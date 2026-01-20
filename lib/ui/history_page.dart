import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/training_service.dart';
import '../services/routine_service.dart'; // Para llenar el filtro de rutinas
import '../core/database/app_database.dart'; // Para tipos de datos
import '../core/repositories/training_repository.dart'; // Para WorkoutHistoryItem
import '../theme/app_colors.dart';

class HistoryPage extends StatefulWidget {
  final TrainingService trainingService;
  final RoutineService routineService; // Necesario para el dropdown de filtros

  const HistoryPage({
    super.key, 
    required this.trainingService,
    required this.routineService,
  });

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // ESTADO DE DATOS
  List<WorkoutHistoryItem> _history = [];
  List<RoutineData> _allRoutines = []; // Para el dropdown
  bool _isLoading = true;

  // ESTADO DE FILTROS
  DateTimeRange? _selectedDateRange;
  int? _selectedRoutineId;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() async {
    // Cargamos historial y lista de rutinas para el filtro en paralelo
    final routines = await widget.routineService.watchRutinas().first; // Tomamos la lista actual
    _loadHistory(); // Cargamos historial
    
    if (mounted) {
      setState(() {
        _allRoutines = routines;
      });
    }
  }

  void _loadHistory() async {
    setState(() => _isLoading = true);
    
    final data = await widget.trainingService.getWorkoutHistory(
      start: _selectedDateRange?.start,
      end: _selectedDateRange?.end,
      filterRoutineId: _selectedRoutineId,
    );

    if (mounted) {
      setState(() {
        _history = data;
        _isLoading = false;
      });
    }
  }

  // UI: Selector de Fecha
  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      // --- PERSONALIZACIÓN DE TEXTOS (ESPAÑOL) ---
      locale: const Locale('es', 'ES'), // Fuerza el formato de calendario a español
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.orange,
              onPrimary: Colors.white,
              surface: Color(0xFF1F2937),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _selectedDateRange = picked);
      _loadHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827), // Fondo oscuro base
      appBar: AppBar(
        title: const Text("Historial"),
        backgroundColor: const Color(0xFF111827),
        elevation: 0,
      ),
      body: Column(
        children: [
          // 1. SECCIÓN DE FILTROS
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFF1F2937), // Un poco más claro que el fondo
            child: Row(
              children: [
                // Filtro Fecha
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.calendar_today, size: 16, color: AppColors.orange),
                    label: Text(
                      _selectedDateRange == null 
                          ? "Todas las fechas" 
                          : "${DateFormat('dd/MM').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM').format(_selectedDateRange!.end)}",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white24)),
                    onPressed: _pickDateRange,
                  ),
                ),
                const SizedBox(width: 8),
                
                // Filtro Rutina (Dropdown)
                Expanded(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white24),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: _selectedRoutineId,
                        dropdownColor: const Color(0xFF1F2937),
                        hint: const Text("Todas las rutinas", style: TextStyle(color: Colors.white, fontSize: 12)),
                        icon: const Icon(Icons.filter_list, size: 16, color: AppColors.orange),
                        isExpanded: true,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                        items: [
                          const DropdownMenuItem<int>(value: null, child: Text("Todas")),
                          ..._allRoutines.map((r) => DropdownMenuItem(value: r.id, child: Text(r.routineName))),
                        ],
                        onChanged: (val) {
                          setState(() => _selectedRoutineId = val);
                          _loadHistory();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. LISTA DE TARJETAS
          Expanded(
            child: _isLoading 
              ? const Center(child: CircularProgressIndicator())
              : _history.isEmpty 
                  ? _EmptyHistoryState()
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _history.length,
                      itemBuilder: (context, index) {
                        return _HistoryCard(item: _history[index]);
                      },
                    ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET TARJETA DE HISTORIAL (Estilo Figma) ---
class _HistoryCard extends StatelessWidget {
  final WorkoutHistoryItem item;

  const _HistoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    // Formateo de fecha: "miércoles, 14 de enero"
    final dateStr = DateFormat("EEEE, d 'de' MMMM", 'es_ES').format(item.date); //tener en cuenta, posible error (!)

    return Card(
      color: const Color(0xFF1F2937),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Theme(
        // Quitamos las líneas divisorias feas del ExpansionTile por defecto
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          // --- CABECERA (Siempre visible) ---
          title: Text(
            dateStr, // Fecha grande
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              children: [
                Text("${item.exercises.length} ejercicios", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(width: 8),
                const Text("•", style: TextStyle(color: Colors.grey)),
                const SizedBox(width: 8),
                Text("Vol: ${item.totalVolume.toStringAsFixed(0)} kg", style: const TextStyle(color: Colors.grey, fontSize: 12)), // arreglar
              ],
            ),
          ),
          // Icono del costado (el del Figma naranja)
          trailing: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.orange.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.fitness_center, color: AppColors.orange, size: 20),
          ),
          
          // --- CUERPO (Lo que se despliega) ---
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            const Divider(color: Colors.white10),
            // Lista de ejercicios dentro de la tarjeta
            ...item.exercises.map((ex) => Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Nombre y Series
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ex.exerciseName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 4),
                      Text("${ex.totalSets} series × ~${(ex.totalReps/ex.totalSets).round()} reps", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  // Peso y Volumen
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("${ex.bestWeight} kg", style: const TextStyle(color: AppColors.orange, fontWeight: FontWeight.bold, fontSize: 14)),
                      Text("Vol: ${ex.volume.toStringAsFixed(0)}", style: const TextStyle(color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class _EmptyHistoryState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 60, color: Colors.grey[800]),
          const SizedBox(height: 16),
          const Text("No hay registros", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}