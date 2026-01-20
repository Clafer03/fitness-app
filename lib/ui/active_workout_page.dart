import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift; // Necesario para 'Value' si fuera el caso, o para evitar conflictos
import '../services/routine_service.dart';
import '../services/training_service.dart'; // <--- IMPORTANTE
import '../core/database/app_database.dart';
import '../core/repositories/routine_repository.dart'; // Para RoutineExerciseView
import '../theme/app_colors.dart';

class ActiveWorkoutPage extends StatefulWidget {
  final RoutineData routine;
  final RoutineService routineService;
  final TrainingService trainingService; // <--- Nuevo servicio requerido

  const ActiveWorkoutPage({
    super.key, 
    required this.routine, 
    required this.routineService,
    required this.trainingService,
  });

  @override
  State<ActiveWorkoutPage> createState() => _ActiveWorkoutPageState();
}

class _ActiveWorkoutPageState extends State<ActiveWorkoutPage> {
  List<RoutineExerciseView> _exercises = [];
  bool _isLoading = true;
  final DateTime _startTime = DateTime.now(); // Para calcular cuánto duró el entreno

  // MAPA DE CONTROLADORES:
  // Guardamos los inputs de texto para cada ejercicio (ID -> Lista de inputs)
  final Map<int, List<_SetInputController>> _controllers = {};

  @override
  void initState() {
    super.initState();
    _loadWorkoutPlan();
  }

  void _loadWorkoutPlan() async {
    // 1. Pedimos los ejercicios de la rutina
    final data = await widget.routineService.getRoutineDetails(widget.routine.id);
    
    // 2. Preparamos los inputs (Controladores) para cada serie
    for (var ex in data) {
      _controllers[ex.exerciseId] = List.generate(ex.targetSets, (index) {
        // Creamos un controlador pre-llenado con las metas (Target)
        return _SetInputController(
          targetReps: ex.targetReps,
          targetWeight: ex.targetWeight,
        );
      });
    }

    setState(() {
      _exercises = data;
      _isLoading = false;
    });
  }

  // --- LÓGICA DE GUARDADO ---
  void _finishWorkout() async {
    // 1. Recopilar datos de los inputs
    final List<TrainingDetailCompanion> logsToSave = [];

    // Recorremos todos los ejercicios
    _controllers.forEach((exerciseId, setControllers) {
      for (var setCtrl in setControllers) {
        // Solo guardamos si el usuario marcó el checkbox
        if (setCtrl.isCompleted) {
          logsToSave.add(TrainingDetailCompanion.insert(
            trainingId: 0, // Se asignará automáticamente en el servicio
            exerciseId: exerciseId,
            series: 0, // Podrías poner el índice + 1 si quieres guardar el nro de serie
            repetitions: int.tryParse(setCtrl.repsCtrl.text) ?? 0,
            usedWeight: double.tryParse(setCtrl.weightCtrl.text) ?? 0.0,
            completed: true,
          ));
        }
      }
    });

    // Validación simple
    if (logsToSave.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completa al menos una serie para guardar."))
      );
      return;
    }

    // 2. Calcular duración en segundos
    final durationSeconds = DateTime.now().difference(_startTime).inSeconds;

    try {
      // 3. LLAMADA AL NUEVO TRAINING SERVICE
      await widget.trainingService.saveFinishedWorkout(
        userId: 1, // Usuario fijo (esto luego lo harás dinámico)
        routineId: widget.routine.id,
        durationSeconds: durationSeconds,
        details: logsToSave,
      );

      // 4. Éxito y Salida
      if (mounted) {
        Navigator.pop(context); // Vuelve a la pantalla anterior
        ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(
             content: Text("¡Entrenamiento guardado! 💪🔥"), 
             backgroundColor: Colors.green
           ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Entrenando", style: TextStyle(fontSize: 14, color: Colors.grey)),
            Text(widget.routine.routineName, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
      
      // BOTÓN FLOTANTE "TERMINAR"
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: _finishWorkout, // <--- Aquí llamamos a la función
        icon: const Icon(Icons.check, color: Colors.white),
        label: const Text("TERMINAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 100, left: 16, right: 16, top: 16),
              itemCount: _exercises.length,
              itemBuilder: (context, index) {
                final ex = _exercises[index];
                // Recuperamos los controladores creados para este ejercicio
                final setsControllers = _controllers[ex.exerciseId] ?? [];

                return Card(
                  color: const Color(0xFF1F2937),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título Ejercicio
                        Text(
                          ex.exerciseName, 
                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
                        ),
                        Text(ex.muscularGroup.toUpperCase(), style: const TextStyle(color: AppColors.orange, fontSize: 12)),
                        
                        const SizedBox(height: 16),
                        
                        // Encabezados de tabla
                        const Row(
                          children: [
                            SizedBox(width: 30, child: Text("#", style: TextStyle(color: Colors.grey, fontSize: 12))),
                            Expanded(child: Text("Kgs", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 12))),
                            Expanded(child: Text("Reps", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 12))),
                            SizedBox(width: 40, child: Icon(Icons.check, size: 16, color: Colors.grey)),
                          ],
                        ),
                        const Divider(color: Colors.white10),

                        // Generamos las filas según las series (sets)
                        ...List.generate(setsControllers.length, (i) {
                          final ctrl = setsControllers[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                // Número
                                SizedBox(
                                  width: 30, 
                                  child: Text("${i + 1}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                                ),
                                
                                // Input Peso
                                Expanded(
                                  child: _InputCell(controller: ctrl.weightCtrl, hint: "${ex.targetWeight}"),
                                ),
                                const SizedBox(width: 10),
                                
                                // Input Reps
                                Expanded(
                                  child: _InputCell(controller: ctrl.repsCtrl, hint: "${ex.targetReps}"),
                                ),

                                // Checkbox
                                SizedBox(
                                  width: 40,
                                  child: Checkbox(
                                    activeColor: Colors.green,
                                    checkColor: Colors.white,
                                    value: ctrl.isCompleted,
                                    onChanged: (val) {
                                      setState(() {
                                        ctrl.isCompleted = val ?? false;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// --- CLASES AUXILIARES (Para que el código principal quede limpio) ---

class _InputCell extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _InputCell({required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(bottom: 8),
        ),
      ),
    );
  }
}

class _SetInputController {
  final TextEditingController repsCtrl;
  final TextEditingController weightCtrl;
  bool isCompleted;

  _SetInputController({required int targetReps, required double targetWeight})
      : repsCtrl = TextEditingController(text: targetReps.toString()),
        weightCtrl = TextEditingController(text: targetWeight > 0 ? targetWeight.toString() : ""),
        isCompleted = false;
}