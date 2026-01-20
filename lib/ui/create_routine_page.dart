import 'package:flutter/material.dart';
import '../services/routine_service.dart';
import '../theme/app_colors.dart';
import '../core/database/app_database.dart';
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
  const CreateRoutinePage({super.key, required this.routineService});
  
  @override
  State<CreateRoutinePage> createState() => _CreateRoutinePageState();
}

class _CreateRoutinePageState extends State<CreateRoutinePage> {
  final _nameController = TextEditingController();
  
  // Estado local
  final List<String> _days = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
  final List<String> _selectedDays = []; // Aquí guardamos los días seleccionados
  final List<ExerciseDraft> _addedExercises = []; // Aquí guardamos los ejercicios en memoria

  List<ExerciseData> _availableExercises = [];
  bool _isLoadingExercises = true;

  @override
  void initState() {
    super.initState();
    _loadExercises(); // <--- Cargamos al iniciar
  }

  void _loadExercises() async {
    try {
      final list = await widget.routineService.getExercises();
      setState(() {
        _availableExercises = list;
        _isLoadingExercises = false;
      });
    } catch (e) {
      print("Error cargando ejercicios: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva Rutina"),
        actions: [
          TextButton(
            onPressed: _saveRoutine, // Función para guardar todo junto
            child: const Text("GUARDAR", style: TextStyle(color: AppColors.orange, fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: SingleChildScrollView( // Importante por si la lista crece
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

  // MODAL PARA AGREGAR DETALLES


  Widget _numberInput(String label, Function(String) onChanged) {
    return TextField(
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.orange)),
      ),
      onChanged: onChanged,
    );
  }
  // POPUP
void _showAddExerciseDialog() {
    if (_isLoadingExercises || _availableExercises.isEmpty) return;

    // Estado inicial (Variables que persisten mientras el popup está abierto)
    // Inicializamos con el grupo del primer ejercicio disponible
    String selectedGroup = _availableExercises.first.muscularGroup;
    
    // Variables de los inputs
    int selectedExerciseId = -1; // -1 indica que aún no se ha calculado
    String selectedExerciseName = "";
    int tempSets = 4;
    int tempReps = 12;
    double tempWeight = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // StatefulBuilder permite reconstruir el contenido del diálogo
        return StatefulBuilder(
          builder: (context, setDialogState) {
            
            // 1. CALCULAR GRUPOS DENTRO DEL BUILDER (Para que se actualice al agregar uno nuevo)
            final List<String> muscleGroups = _availableExercises
                .map((e) => e.muscularGroup)
                .toSet()
                .toList();
            muscleGroups.sort(); // Orden alfabético

            // Validación de seguridad: si selectedGroup ya no existe (raro), usar el primero
            if (!muscleGroups.contains(selectedGroup)) {
              selectedGroup = muscleGroups.first;
            }

            // 2. FILTRAR EJERCICIOS SEGÚN EL GRUPO ACTUAL
            List<ExerciseData> filteredExercises = _availableExercises
                .where((e) => e.muscularGroup == selectedGroup)
                .toList();

            // 3. SELECCIONAR EJERCICIO POR DEFECTO
            // Si el ID seleccionado no pertenece a la lista filtrada actual (o es -1),
            // seleccionamos el primero de la nueva lista filtrada.
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
                    
                    // --- GRUPO MUSCULAR ---
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
                                // Al cambiar grupo, reseteamos el ID para que la lógica de arriba seleccione el primero
                                selectedExerciseId = -1; 
                              });
                            }
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // --- EJERCICIO + BOTÓN NUEVO ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Ejercicio", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        InkWell(
                          onTap: () async {
                            // Abrimos el creador y esperamos a que nos devuelva el grupo creado
                            final newGroupCreated = await _showCreateExerciseDialog();
                            
                            // Si se creó algo (newGroupCreated no es null)
                            if (newGroupCreated != null) {
                              setDialogState(() {
                                // 1. Cambiamos el filtro al grupo del nuevo ejercicio
                                selectedGroup = newGroupCreated;
                                // 2. Reseteamos el ID para que seleccione automáticamente el nuevo (que estará al principio o en la lista)
                                // Nota: Como ordenamos alfabéticamente, lo ideal sería buscar el último agregado, 
                                // pero seleccionar el grupo ya es una gran ayuda.
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
                    
                    // DROPDOWN EJERCICIOS
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
                    
                    // --- INPUTS NUMÉRICOS ---
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
                    // Si por alguna razón no hay ejercicio seleccionado, salimos
                    if (selectedExerciseId == -1) return;

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
  // Pequeño helper para los inputs dentro del popup (más compactos)
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

// MODAL PARA CREAR UN EJERCICIO NUEVO EN LA BD
  Future<String?> _showCreateExerciseDialog() async {
    final nameController = TextEditingController();
    
    // Lista completa de grupos
    final groups = ["Pecho", "Espalda", "Piernas", "Hombros", "Brazos", "Abdominales", "Glúteos", "Cardio", "Calistenia", "Full Body", "Otros"];
    groups.sort();
    
    String selectedGroup = "Pecho"; 

    // Retornaremos el grupo del nuevo ejercicio para auto-seleccionarlo luego
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
                  // 1. Guardar en BD
                  final newId = await widget.routineService.createExercise(nameController.text, selectedGroup);
                  
                  // 2. Actualizar lista local
                  final newExercise = ExerciseData(
                    id: newId, 
                    exerciseName: nameController.text, 
                    muscularGroup: selectedGroup
                  );

                  setState(() {
                    _availableExercises.add(newExercise);
                    _availableExercises.sort((a, b) => a.exerciseName.compareTo(b.exerciseName)); 
                  });

                  createdGroup = selectedGroup; // Guardamos el grupo para devolverlo

                  if (mounted) {
                    Navigator.pop(context); // Cerrar popup
                    
                    // MENSAJE DE ÉXITO ✅
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
    
    return createdGroup; // Devolvemos el grupo creado (o null si canceló)
  }
  // LA LÓGICA DE GUARDADO
void _saveRoutine() async {
    // A) Validar Nombre de rutina
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("¡Falta el nombre de la rutina!")),
      );
      return;
    }

    // B) Validar Días
    if (_selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Selecciona al menos un día para entrenar.",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    // Validar Ejercicios
    if (_addedExercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Agrega al menos un ejercicio.",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Guardando rutina...", 
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),)),
    );

    try {
      // 2. LLAMADA CORREGIDA A TU SERVICIO
      await widget.routineService.createRoutineWithExercises(
        userId: 1, 
        routineName: _nameController.text, // Tu servicio pide 'routineName'
        // CONVERSIÓN 1: Tu servicio pide String, la UI tiene List. Usamos join.
        dayWeek: _selectedDays.join(','),  // Convertimos ["Lun", "Mar"] -> "Lun,Mar"
        // CONVERSIÓN 2: Tu servicio pide fecha, la generamos aquí
        creationDate: DateTime.now(), 
        exercises: _addedExercises,
      );

      // 3. Éxito
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(
             content: Text("¡Rutina creada con éxito! 💪",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.green,
           ),
        );
      }
      
    } catch (e) {
      // 4. Error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error al guardar: $e"), 
            backgroundColor: Colors.red
          ),
        );
      }
    }
  } 
}