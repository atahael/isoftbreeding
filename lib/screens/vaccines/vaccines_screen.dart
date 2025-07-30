import 'package:flutter/material.dart';

class VaccinsScreen extends StatelessWidget {
  const VaccinsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> vaccins = [
      {"nom": "Fièvre aphteuse", "date": "2025-08-01", "animal": "Vache 1"},
      {"nom": "Rage", "date": "2025-09-15", "animal": "Chien 3"},
      {"nom": "Peste bovine", "date": "2025-10-10", "animal": "Vache 2"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Suivi des Vaccins',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: vaccins.isEmpty
            ? const Center(
                child: Text(
                  'Aucun vaccin enregistré.',
                  style: TextStyle(fontSize: 18),
                ),
              )
            : ListView.separated(
                itemCount: vaccins.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final vaccin = vaccins[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.vaccines, size: 32),
                      title: Text(
                        vaccin['nom']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text('Animal : ${vaccin['animal']}'),
                          Text('Date prévue : ${vaccin['date']}'),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // TODO: afficher les détails ou éditer
                      },
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Naviguer vers un formulaire d'ajout de vaccin
        },
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
