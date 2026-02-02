import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/progress_service.dart';
import '../core/database/app_database.dart';
import '../core/repositories/progress_repository.dart';
import '../theme/app_colors.dart';

class DetailedProgressPage extends StatefulWidget {
  final ProgressService progressService;

  const DetailedProgressPage({super.key, required this.progressService});

  @override
  State<DetailedProgressPage> createState() => _DetailedProgressPageState();
}

class _DetailedProgressPageState extends State<DetailedProgressPage> {
  // DATOS MAESTROS
  List<ExerciseData> _allTrackedExercises = []; // Todos los ejercicios con historial
  
  // DATOS FILTRADOS (Para los combobox)
  List<String> _availableGroups = [];
  List<ExerciseData> _filteredExercises = [];

  // SELECCIONES
  String? _selectedGroup;
  int? _selectedExerciseId;

  // GRÁFICO
  List<ProgressPoint> _chartData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() async {
    // 1. Traemos TODOS los ejercicios que tienen datos
    final exercises = await widget.progressService.getTrackedExercises();
    
    // 2. Extraemos los grupos musculares únicos
    final groups = exercises.map((e) => e.muscularGroup).toSet().toList();
    groups.sort(); // Orden alfabético

    setState(() {
      _allTrackedExercises = exercises;
      _availableGroups = groups;
      _isLoading = false;

      // 3. Pre-selección inteligente
      if (groups.isNotEmpty) {
        _selectedGroup = groups.first;
        _updateExerciseList(); // Filtramos ejercicios para ese grupo
      }
    });
  }

  // Lógica de Cascada: Cuando cambia el Grupo -> Cambia la lista de Ejercicios
  void _updateExerciseList() {
    if (_selectedGroup == null) return;

    final filtered = _allTrackedExercises
        .where((e) => e.muscularGroup == _selectedGroup)
        .toList();
    
    // Ordenar ejercicios por nombre
    filtered.sort((a,b) => a.exerciseName.compareTo(b.exerciseName));

    setState(() {
      _filteredExercises = filtered;
      
      // Seleccionar el primer ejercicio automáticamente y cargar gráfico
      if (filtered.isNotEmpty) {
        _selectedExerciseId = filtered.first.id;
        _loadChartData(_selectedExerciseId!);
      } else {
        _selectedExerciseId = null;
        _chartData = [];
      }
    });
  }

  void _loadChartData(int exerciseId) async {
    // Pequeño loading local para el gráfico
    final data = await widget.progressService.getProgressForExercise(exerciseId);
    setState(() {
      _chartData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Análisis Detallado"),
        backgroundColor: const Color(0xFF111827),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFF111827),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  // --- FILTRO 1: GRUPO MUSCULAR ---
                  const Text("Grupo Muscular", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 6),
                  _buildDropdown<String>(
                    value: _selectedGroup,
                    items: _availableGroups,
                    getItemLabel: (item) => item.toUpperCase(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedGroup = val);
                        _updateExerciseList(); // <--- Dispara la cascada
                      }
                    },
                  ),

                  const SizedBox(height: 16),

                  // --- FILTRO 2: EJERCICIO ---
                  const Text("Ejercicio", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 6),
                  _buildDropdown<int>(
                    value: _selectedExerciseId,
                    items: _filteredExercises.map((e) => e.id).toList(),
                    // Truco para obtener el nombre a partir del ID en la lista filtrada
                    getItemLabel: (id) => _filteredExercises.firstWhere((e) => e.id == id).exerciseName,
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedExerciseId = val);
                        _loadChartData(val); // <--- Carga el gráfico
                      }
                    },
                  ),

                  const SizedBox(height: 40),

                  // --- GRÁFICO ---
                  const Text("Evolución de Fuerza", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  
                  SizedBox(
                    height: 300, 
                    child: _chartData.isEmpty
                        ? _buildEmptyState()
                        : _buildChart(),
                  ),
                ],
              ),
            ),
    );
  }

  // Widget auxiliar para no repetir código de los Dropdowns
  Widget _buildDropdown<T>({
    required T? value,
    required List<T> items,
    required String Function(T) getItemLabel,
    required Function(T?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          dropdownColor: const Color(0xFF1F2937),
          isExpanded: true,
          style: const TextStyle(color: Colors.white),
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.orange),
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(getItemLabel(item)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12)
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bar_chart, color: Colors.grey, size: 40),
          SizedBox(height: 10),
          Text("No hay datos para mostrar", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildChart() {
    // 1. CÁLCULO DE LÍMITES Y (PESO)
    double maxY = 0;
    if (_chartData.isNotEmpty) {
      // Buscamos el peso más alto para definir el techo del gráfico
      maxY = _chartData.map((e) => e.weight).reduce((a, b) => a > b ? a : b);
    }
    maxY = maxY * 1.2; // Le damos un 20% de aire arriba para que no toque el borde

    // 2. CÁLCULO DE LÍMITES X (ÍNDICES)
    // Usamos índices (0, 1, 2) para que solo aparezcan tus entrenamientos, sin huecos de días vacíos.
    // minX y maxX controlan el "zoom" horizontal.
    double minX = -0.3; 
    double maxX = (_chartData.length - 1) + 0.3;
    
    // Si solo hay 1 dato, ajustamos para que quede centrado y bonito
    if (_chartData.length == 1) {
      minX = -0.5;
      maxX = 0.5;
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true, 
          drawVerticalLine: false, 
          getDrawingHorizontalLine: (value) => FlLine(color: Colors.white10, strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          
          // --- EJE X: FECHAS ENTRENADAS ---
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1, 
              getTitlesWidget: (value, meta) {
                // 🔥 CORRECCIÓN: Si el valor tiene decimales (ej. -0.5 o 0.5), lo ignoramos.
                // Solo queremos etiquetas en los números enteros (0, 1, 2...).
                if (value % 1 != 0) return const Text('');

                final index = value.toInt();
                if (index >= 0 && index < _chartData.length) {
                  final date = _chartData[index].date;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      DateFormat('d MMM', 'es_ES').format(date), 
                      style: const TextStyle(color: Colors.grey, fontSize: 10)
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          
          // EJE Y: PESO
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              // interval: 5, // Descomenta si quieres forzar saltos de 5kg en 5kg
              getTitlesWidget: (value, meta) {
                 if (value == 0) return const Text("");
                 return Text('${value.toInt()}kg', style: const TextStyle(color: Colors.grey, fontSize: 10));
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        
        // Configuramos los límites calculados arriba
        minY: 0,
        maxY: maxY,
        minX: minX,
        maxX: maxX,
        
        lineBarsData: [
          LineChartBarData(
            // Mapeamos por índice (0, 1, 2...)
            spots: _chartData.asMap().entries.map((e) {
              return FlSpot(e.key.toDouble(), e.value.weight);
            }).toList(),
            
            isCurved: false, // Líneas rectas para ver el progreso exacto entre sesiones
            color: AppColors.orange,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: const Color(0xFF1F2937),
                  strokeWidth: 2,
                  strokeColor: AppColors.orange,
                );
              }
            ),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.orange.withOpacity(0.15),
            ),
          ),
        ],
      ),
    );
  }
}