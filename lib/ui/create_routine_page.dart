import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// Una clasecita temporal solo para manejar los datos en esta vista
class ExerciseDraft {
  final String name;
  final int sets;
  final int reps;
  final double weight;

  ExerciseDraft({
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
  });
}

class CreateRoutinePage extends StatefulWidget {
  const CreateRoutinePage({super.key});

  @override
  State<CreateRoutinePage> createState() => _CreateRoutinePageState();
}

class _CreateRoutinePageState extends State<CreateRoutinePage> {
  final _nameController = TextEditingController();
  
  // Estado local
  final List<String> _days = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
  final List<String> _selectedDays = []; // Aquí guardamos los días seleccionados
  final List<ExerciseDraft> _addedExercises = []; // Aquí guardamos los ejercicios en memoria

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

  // REEMPLAZA TU FUNCIÓN _showAddExerciseModal POR ESTA:
  void _showAddExerciseDialog() {
    // Variables temporales para el popup
    String tempName = "Press de Banca"; // Valor inicial
    int tempSets = 4;
    int tempReps = 12;
    double tempWeight = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // StatefulBuilder permite que el Dropdown cambie visualmente DENTRO del diálogo
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1F2937), // Un gris oscuro (gray-800) para contrastar con el fondo negro
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Text(
                "Agregar Ejercicio",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Se ajusta al contenido
                  children: [
                    // 1. Dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: tempName,
                          dropdownColor: const Color(0xFF1F2937),
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down, color: AppColors.orange),
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                          items: ["Press de Banca", "Sentadilla", "Peso Muerto", "Dominadas"]
                              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (val) {
                            // Usamos setDialogState, NO setState normal
                            setDialogState(() {
                              tempName = val!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 2. Inputs numéricos
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
              actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              actions: [
                // Botón Cancelar
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar", style: TextStyle(color: Colors.grey)),
                ),
                // Botón Agregar
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    // Aquí sí usamos el setState DE LA PÁGINA PRINCIPAL para actualizar la lista
                    this.setState(() {
                      _addedExercises.add(ExerciseDraft(
                        name: tempName,
                        sets: tempSets,
                        reps: tempReps,
                        weight: tempWeight,
                      ));
                    });
                    Navigator.pop(context); // Cierra el popup
                  },
                  child: const Text("Agregar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

  // LA LÓGICA DE GUARDADO
  void _saveRoutine() async {
    if (_nameController.text.isEmpty || _addedExercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ponle nombre y al menos un ejercicio")));
      return;
    }

    // 1. Aquí llamas a tu servicio
    // final routineId = await widget.trainingService.createRoutine(
    //    name: _nameController.text,
    //    days: _selectedDays.join(','),
    // );

    // 2. Aquí recorres la lista y guardas los detalles
    // for (var exercise in _addedExercises) {
    //    await widget.trainingService.addExerciseToRoutine(
    //      routineId: routineId,
    //      exerciseName: exercise.name, // O el ID si lo tienes
    //      sets: exercise.sets,
    //      reps: exercise.reps,
    //      weight: exercise.weight
    //    );
    // }

    Navigator.pop(context); // Volver atrás
  }
}