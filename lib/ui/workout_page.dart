import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'create_routine_page.dart';
import '../core/database/app_database.dart';
import '../services/routine_service.dart';
import '../services/training_service.dart';
import 'active_workout_page.dart';

class WorkoutPage extends StatefulWidget {
  final RoutineService routineService;
  final TrainingService trainingService;

  const WorkoutPage({super.key, required this.routineService, required this.trainingService});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  // ESTADO DE LA PANTALLA
  bool _isSelectionMode = false; // ¿Estamos borrando?
  final Set<int> _selectedIds = {}; // IDs seleccionados

  // Activar/Desactivar modo selección
  void _toggleSelectionMode() {
    setState(() {
      _isSelectionMode = !_isSelectionMode;
      _selectedIds.clear(); // Limpiamos selección al cambiar modo
    });
  }

  // Marcar/Desmarcar una rutina
  void _toggleItem(int id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
        // Si desmarcas la última, ¿quieres salir del modo selección? 
        // Opcional: if (_selectedIds.isEmpty) _isSelectionMode = false;
      } else {
        _selectedIds.add(id);
      }
    });
  }

  // Borrar todo lo seleccionado
  Future<void> _deleteSelected() async {
    if (_selectedIds.isEmpty) return;

    // Diálogo de confirmación
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F2937),
        title: const Text("¿Eliminar rutinas?", style: TextStyle(color: Colors.white)),
        content: Text(
          "Se eliminarán ${_selectedIds.length} rutinas seleccionadas.",
          style: const TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Eliminar", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      // Borrado múltiple
      for (var id in _selectedIds) {
        await widget.routineService.deleteRoutine(id);
      }
      
      // Feedback y salir del modo
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Rutinas eliminadas",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),)),
        );
        _toggleSelectionMode();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- APPBAR DINÁMICO ---
      appBar: AppBar(
        // Si estamos seleccionando, el botón de la izquierda es una "X" para cancelar
        leading: _isSelectionMode 
            ? IconButton(
                icon: const Icon(Icons.close), 
                onPressed: _toggleSelectionMode
              ) 
            : null,
        
        // Título cambia según el modo
        title: _isSelectionMode 
            ? Text("${_selectedIds.length} seleccionadas", style: const TextStyle(fontSize: 18))
            : const Text("Mis Rutinas"),
        
        actions: [
          // Si estamos seleccionando, mostramos el BASURERO para ejecutar borrado
          if (_isSelectionMode)
             IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: _selectedIds.isEmpty ? null : _deleteSelected, // Deshabilitado si 0 seleccionados
            )
          // Si estamos normal, mostramos el icono para ENTRAR al modo selección
          else
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.orange),
              tooltip: "Borrar rutinas",
              onPressed: _toggleSelectionMode,
            ),
        ],
      ),
      
      // --- FAB (Solo visible si NO estamos borrando) ---
      floatingActionButton: _isSelectionMode 
          ? null // Ocultamos el botón + cuando borramos
          : FloatingActionButton.extended(
              backgroundColor: AppColors.orange,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text("Nueva Rutina", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateRoutinePage(routineService: widget.routineService),
                  ),
                );
              },
            ),

      // --- LISTA ---
      body: StreamBuilder<List<RoutineData>>(
        stream: widget.routineService.watchRutinas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final rutinas = snapshot.data ?? [];
          
          if (rutinas.isEmpty) {
            return _EmptyState();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: rutinas.length,
            itemBuilder: (context, index) {
              final rutina = rutinas[index];
              final isSelected = _selectedIds.contains(rutina.id);

              return Card(
                color: isSelected 
                    ? AppColors.orange.withOpacity(0.1) // Color suave si está seleccionado
                    : const Color(0xFF1F2937),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: isSelected 
                      ? const BorderSide(color: AppColors.orange, width: 2) 
                      : BorderSide.none,
                ),
                margin: const EdgeInsets.only(bottom: 12),
                
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  // LÓGICA DE TAP:
                  // Si estamos en modo selección -> Marca/Desmarca
                  // Si estamos normal -> Debería ir al detalle (futuro)
                  onTap: () {
                    if (_isSelectionMode) {
                      _toggleItem(rutina.id);
                    } else {
                      // NAVEGACIÓN A PANTALLA DE ENTRENAMIENTO 🚀
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActiveWorkoutPage(
                            routine: rutina, // Pasamos el objeto rutina
                            routineService: widget.routineService, // Pasamos el servicio7
                            trainingService: widget.trainingService
                          ),
                        ),
                      );
                    }
                  },
                  // Long press también activa la selección desde el modo normal
                  onLongPress: () {
                    if (!_isSelectionMode) {
                      _toggleSelectionMode();
                      _toggleItem(rutina.id); // Y selecciona este item
                    }
                  },

                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // CHECKBOX ANIMADO
                        // Solo aparece si estamos en modo selección
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: _isSelectionMode ? 32 : 0, // Se expande o colapsa
                          child: _isSelectionMode 
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                                    color: isSelected ? AppColors.orange : Colors.grey,
                                  ),
                                )
                              : null,
                        ),

                        // INFORMACIÓN DE LA TARJETA
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                rutina.routineName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  decoration: isSelected ? TextDecoration.lineThrough : null, // Tachado visual
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                rutina.dayWeek,
                                style: const TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        
                        // Icono derecho (solo visible en modo normal)
                        if (!_isSelectionMode)
                          const Icon(Icons.chevron_right, color: AppColors.orange),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
// Un widget visual para cuando no hay nada creado aún
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fitness_center, size: 80, color: Colors.grey[800]),
          const SizedBox(height: 16),
          const Text(
            "No tienes rutinas aún",
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
          const SizedBox(height: 8),
          const Text(
            "Dale al botón + para crear\ntu primer entrenamiento",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

