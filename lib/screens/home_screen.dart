import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import '../models/nivel_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _supabaseService = SupabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Niveles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _supabaseService.signOut();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Nivel>>(
        future: _supabaseService.getNiveles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay niveles disponibles.'));
          }

          final niveles = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: niveles.length,
            itemBuilder: (context, index) {
              final nivel = niveles[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: Text(
                      '${nivel.id}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    nivel.nombre,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(nivel.description),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Implement navigation to lessons
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Nivel ${nivel.id} seleccionado')),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
