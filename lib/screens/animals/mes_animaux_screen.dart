import 'package:flutter/material.dart';
import 'add_animal.dart';

class MesAnimauxScreen extends StatelessWidget {
  const MesAnimauxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Exemple de données classées par espèce
    final Map<String, List<Map<String, String>>> animauxParEspece = {
      'Vache': [
        {
          'nom': 'Bella',
          'age': '3 ans',
          'photo': '',
        },
        {
          'nom': 'Noiraude',
          'age': '5 ans',
          'photo': '',
        },
      ],
      'Poulet': [
        {
          'nom': 'Coco',
          'age': '6 mois',
          'photo': '',
        },
      ],
      'Mouton': [
        {
          'nom': 'Dolly',
          'age': '2 ans',
          'photo': '',
        },
      ],
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Animaux"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Ajouter un animal',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddAnimalScreen()),
              );
            },
          ),
        ],
      ),
      body: animauxParEspece.isEmpty
          ? const Center(
              child: Text(
                "Aucun animal enregistré.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: animauxParEspece.entries.map((entry) {
                final espece = entry.key;
                final animaux = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      espece,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...animaux.map((animal) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green.shade100,
                            backgroundImage: animal['photo']!.isNotEmpty
                                ? NetworkImage(animal['photo']!)
                                : null,
                            child: animal['photo']!.isEmpty
                                ? const Icon(Icons.pets, color: Colors.green)
                                : null,
                          ),
                          title: Text(animal['nom'] ?? ''),
                          subtitle: Text("${animal['age']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  // TODO: Modifier l’animal
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  // TODO: Supprimer l’animal
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),
            ),
    );
  }
}
