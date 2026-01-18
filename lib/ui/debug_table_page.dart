import 'package:flutter/material.dart';
import '../core/database/app_database.dart';

class DebugTablePage extends StatelessWidget {
  final AppDatabase db;

  const DebugTablePage({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug DB')),
      body: ListView(
        children: [
          _tableTile(
            context,
            'Usuarios',
            () => db.select(db.user).get(),
          ),
          _tableTile(
            context,
            'Ejercicios',
            () => db.select(db.exercise).get(),
          ),
          _tableTile(
            context,
            'Rutinas',
            () => db.select(db.routine).get(),
          ),
          _tableTile(
            context,
            'Detalle Rutinas',
            () => db.select(db.routineDetail).get(),
          ),
          _tableTile(
            context,
            'Entrenamientos',
            () => db.select(db.training).get(),
          ),
          _tableTile(
            context,
            'Detalle Entrenamientos',
            () => db.select(db.trainingDetail).get(),
          ),
        ],
      ),
    );
  }

  Widget _tableTile(
    BuildContext context,
    String title,
    Future<List<dynamic>> Function() loader,
  ) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        final data = await loader();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DebugListPage(title: title, data: data),
          ),
        );
      },
    );
  }
}

class DebugListPage extends StatelessWidget {
  final String title;
  final List<dynamic> data;

  const DebugListPage({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, i) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(data[i].toString()),
            ),
          );
        },
      ),
    );
  }
}
