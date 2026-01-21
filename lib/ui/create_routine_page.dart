import 'package:flutter/material.dart';
import '../services/routine_service.dart';
import '../theme/app_colors.dart';
import '../core/database/app_database.dart';
// Asegúrate de que RoutineExerciseView sea accesible. 
// Normalmente está en routine_repository.dart, que se exporta o se importa aquí.
import '../core/repositories/routine_repository.dart'; 

// Una clasecita temporal solo para manejar los datos en esta vista
class ExerciseDraft {
  final int exerciseId;
  final String name;
  final int sets;
  final int reps;
  final double weight;

  ExerciseDraft({
    required this.exerciseId,
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
  });
}

class CreateRoutinePage extends StatefulWidget {
  final RoutineService routineService;
  final RoutineData? routineToEdit; // <--- NUEVO: Recibe rutina si es edición

  const CreateRoutinePage({
    super.key, 
    required this.routineService,
    this.routineToEdit, // <--- Opcional
  });
  
  @override
  State<CreateRoutinePage> createState() => _CreateRoutinePageState();
}

class _CreateRoutinePageState extends State<CreateRoutinePage> {
  final _nameController = TextEditingController();
  
  // Estado local
  final List<String> _days = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
  final Set<String> _selectedDays = {}; // Usamos Set para evitar duplicados fácilmente
  final List<ExerciseDraft> _addedExercises = []; // Aquí guardamos los ejercicios en memoria

  List<ExerciseData> _availableExercises = [];
  bool _isLoadingExercises = true;

  // Getter para saber si estamos editando
  bool get _isEditing => widget.routineToEdit != null;

  @override
  void initState() {
    super.initState();
    _loadExercises(); // Cargar catálogo
    
    // Si estamos editando, cargar los datos de la rutina
    if (_isEditing) {
      _loadExistingData();
    }
  }

  void _loadExercises() async {
    try {
      final list = await widget.routineService.getExercises();
      if (mounted) {
        setState(() {
          _availableExercises = list;
          _isLoadingExercises = false;
        });
      }
    } catch (e) {
      print("Error cargando ejercicios: $e");
    }
  }

  // LOGICA DE CARGA PARA EDICIÓN
  void _loadExistingData() async {
    final routine = widget.routineToEdit!;
    
    // 1. Llenar Nombre
    _nameController.text = routine.routineName;

    // 2. Llenar Días (Vienen como String "L,M,V")
    if (routine.dayWeek.isNotEmpty) {
      final daysList = routine.dayWeek.split(',');
      setState(() {
        _selectedDays.addAll(daysList);
      });
    }

    // 3. Llenar Ejercicios
    // Traemos los detalles de la BD
    final details = await widget.routineService.getRoutineDetails(routine.id);
    
    if (mounted) {
      setState(() {
        for (var d in details) {
          // Convertimos de la vista de BD a nuestro borrador local
          _addedExercises.add(ExerciseDraft(
            exerciseId: d.exerciseId,
            name: d.exerciseName,
            sets: d.targetSets,
            reps: d.targetReps,
            weight: d.targetWeight,
          ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? "Editar Rutina" : "Nueva Rutina"), // Título dinámico
        actions: [
          TextButton(
            onPressed: _saveRoutine, // Función para guardar/actualizar
            child: Text(
              _isEditing ? "ACTUALIZAR" : "GUARDAR", // Texto dinámico
              style: const TextStyle(color: AppColors.orange, fontWeight: FontWeight.bold)
            ),
          )
        ],
      ),
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Nombre de la Rutina
            _sectionTitle("1. Nombre y Días a entrenar"),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Ej: Destructor de Piernas",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
            ),
            const SizedBox(height: 16),

            // 2. Selector de Días (Chips)
            Wrap(
              spacing: 8,
              children: _days.map((day) {
                final isSelected = _selectedDays.contains(day);
                return FilterChip(
                  label: Text(day),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      selected ? _selectedDays.add(day) : _selectedDays.remove(day);
                    });
                  },
                  backgroundColor: Colors.black,
                  selectedColor: AppColors.orange,
                  labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.grey),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: AppColors.border)),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 32),
            
            // 3. Sección de Ejercicios
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _sectionTitle("2. Ejercicios (${_addedExercises.length})"),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: AppColors.orange, size: 30),
                  onPressed: _showAddExerciseDialog,
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 4. Lista Visual de lo que vas agregando
            if (_addedExercises.isEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white10),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white.withOpacity(0.02)
                ),
                child: const Text("Añade ejercicios para armar tu plan", 
                  textAlign: TextAlign.center, 
                  style: TextStyle(color: Colors.grey)
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true, // Importante dentro de SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _addedExercises.length,
                itemBuilder: (context, index) {
                  final ex = _addedExercises[index];
                  return Card(
                    color: Colors.white10,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(ex.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      subtitle: Text("${ex.sets} series x ${ex.reps} reps - ${ex.weight}kg", style: const TextStyle(color: AppColors.orange)),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _addedExercises.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold));
  }

  // --- POPUP PARA AÑADIR EJERCICIO (EXISTENTE O NUEVO) ---
  void _showAddExerciseDialog() {
    if (_isLoadingExercises || _availableExercises.isEmpty) return;

    // Estado inicial del popup
    String selectedGroup = _availableExercises.first.muscularGroup;
    
    // Variables temporales
    int selectedExerciseId = -1; 
    String selectedExerciseName = "";
    int tempSets = 4;
    int tempReps = 12;
    double tempWeight = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            
            // 1. Calcular grupos dinámicamente
            final List<String> muscleGroups = _availableExercises
                .map((e) => e.muscularGroup)
                .toSet()
                .toList();
            muscleGroups.sort();

            if (!muscleGroups.contains(selectedGroup)) {
              selectedGroup = muscleGroups.first;
            }

            // 2. Filtrar ejercicios por grupo
            List<ExerciseData> filteredExercises = _availableExercises
                .where((e) => e.muscularGroup == selectedGroup)
                .toList();
            // Ordenar alfabéticamente
            filteredExercises.sort((a,b) => a.exerciseName.compareTo(b.exerciseName));

            // 3. Seleccionar default si es necesario
            if (selectedExerciseId == -1 || !filteredExercises.any((e) => e.id == selectedExerciseId)) {
               if (filteredExercises.isNotEmpty) {
                 selectedExerciseId = filteredExercises.first.id;
                 selectedExerciseName = filteredExercises.first.exerciseName;
               }
            }

            return AlertDialog(
              backgroundColor: const Color(0xFF1F2937),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Text("Agregar Ejercicio", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    
                    // Dropdown Grupo
                    const Text("Grupo Muscular", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.orange.withOpacity(0.5)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedGroup,
                          dropdownColor: const Color(0xFF1F2937),
                          isExpanded: true,
                          icon: const Icon(Icons.filter_list, color: AppColors.orange),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          items: muscleGroups.map((String group) {
                            return DropdownMenuItem<String>(
                              value: group,
                              child: Text(group.toUpperCase()),
                            );
                          }).toList(),
                          onChanged: (String? newGroup) {
                            if (newGroup != null) {
                              setDialogState(() {
                                selectedGroup = newGroup;
                                selectedExerciseId = -1; // Reset selección
                              });
                            }
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Label Ejercicio + Botón Nuevo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Ejercicio", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        InkWell(
                          onTap: () async {
                            final newGroupCreated = await _showCreateExerciseDialog();
                            if (newGroupCreated != null) {
                              setDialogState(() {
                                selectedGroup = newGroupCreated;
                                selectedExerciseId = -1;
                              });
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text("+ Nuevo", style: TextStyle(color: AppColors.orange, fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 5),
                    
                    // Dropdown Ejercicios
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: selectedExerciseId,
                          dropdownColor: const Color(0xFF1F2937),
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down, color: AppColors.orange),
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                          items: filteredExercises.map((ExerciseData ex) {
                            return DropdownMenuItem<int>(
                              value: ex.id,
                              child: Text(ex.exerciseName),
                            );
                          }).toList(),
                          onChanged: (int? newId) {
                            if (newId != null) {
                              final selected = filteredExercises.firstWhere((e) => e.id == newId);
                              setDialogState(() {
                                selectedExerciseId = newId;
                                selectedExerciseName = selected.exerciseName;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Inputs Numéricos
                    Row(
                      children: [
                        Expanded(child: _popupInput("Series", "4", (val) => tempSets = int.tryParse(val) ?? 0)),
                        const SizedBox(width: 8),
                        Expanded(child: _popupInput("Reps", "12", (val) => tempReps = int.tryParse(val) ?? 0)),
                        const SizedBox(width: 8),
                        Expanded(child: _popupInput("Peso", "0.0", (val) => tempWeight = double.tryParse(val) ?? 0)),
                      ],
                    ),
                  ],
                ),
              ),
              
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar", style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.orange),
                  onPressed: () {
                    if (selectedExerciseId == -1) return;

                    // Actualizamos la lista de la página principal
                    this.setState(() {
                      _addedExercises.add(ExerciseDraft(
                        exerciseId: selectedExerciseId,
                        name: selectedExerciseName,
                        sets: tempSets,
                        reps: tempReps,
                        weight: tempWeight,
                      ));
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Agregar", style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _popupInput(String label, String hint, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        TextField(
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            filled: true,
            fillColor: Colors.black26,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.orange),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  // MODAL PARA CREAR UN EJERCICIO NUEVO EN LA BD (Quick Create)
  Future<String?> _showCreateExerciseDialog() async {
    final nameController = TextEditingController();
    
    final groups = ["Pecho", "Espalda", "Piernas", "Hombros", "Brazos", "Abdominales", "Glúteos", "Cardio", "Calistenia", "Full Body", "Otros"];
    groups.sort();
    
    String selectedGroup = "Pecho"; 
    String? createdGroup; 

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F2937),
          title: const Text("Nuevo Ejercicio", style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Nombre (ej. Curl Zottman)",
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.orange)),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedGroup,
                dropdownColor: const Color(0xFF1F2937),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Grupo Muscular",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                items: groups.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                onChanged: (val) => selectedGroup = val!,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.orange),
              onPressed: () async {
                if (nameController.text.isNotEmpty) {
                  // Guardar en BD
                  final newId = await widget.routineService.createExercise(nameController.text, selectedGroup);
                  
                  // Actualizar lista local de catálogo
                  final newExercise = ExerciseData(
                    id: newId, 
                    exerciseName: nameController.text, 
                    muscularGroup: selectedGroup
                  );

                  setState(() {
                    _availableExercises.add(newExercise);
                    _availableExercises.sort((a, b) => a.exerciseName.compareTo(b.exerciseName)); 
                  });

                  createdGroup = selectedGroup; 

                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Ejercicio '${nameController.text}' añadido correctamente"),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                }
              },
              child: const Text("Guardar"),
            ),
          ],
        );
      },
    );
    
    return createdGroup;
  }

  // --- LÓGICA DE GUARDADO / ACTUALIZADO ---
  void _saveRoutine() async {
    // Validaciones
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("¡Falta el nombre de la rutina!")),
      );
      return;
    }

    if (_selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Selecciona al menos un día para entrenar.",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    if (_addedExercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Agrega al menos un ejercicio.",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_isEditing ? "Actualizando..." : "Guardando...", 
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
    );

    try {
      if (_isEditing) {
        // --- CASO 1: EDICIÓN ---
        await widget.routineService.updateRoutine(
          routineId: widget.routineToEdit!.id,
          routineName: _nameController.text,
          dayWeek: _selectedDays.join(','),
          newExercises: _addedExercises,
        );
        
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(
               content: Text("¡Rutina actualizada correctamente! 👌",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
               ),
               backgroundColor: Colors.green,
             ),
          );
        }

      } else {
        // --- CASO 2: CREACIÓN ---
        await widget.routineService.createRoutineWithExercises(
          userId: 1, 
          routineName: _nameController.text,
          dayWeek: _selectedDays.join(','),
          creationDate: DateTime.now(), 
          exercises: _addedExercises,
        );

        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(
               content: Text("¡Rutina creada con éxito! 💪",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
               ),
               backgroundColor: Colors.green,
             ),
          );
        }
      }
      
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"), 
            backgroundColor: Colors.red
          ),
        );
      }
    }
  } 
}