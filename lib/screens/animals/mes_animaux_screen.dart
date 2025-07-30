import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_animal.dart';

class MesAnimauxScreen extends StatelessWidget {
  const MesAnimauxScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('animaux').orderBy('espece').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Aucun animal enregistré."),
            );
          }

          // Grouper les animaux par espèce
          final Map<String, List<Map<String, dynamic>>> animauxParEspece = {};

          for (var doc in snapshot.data!.docs) {
            final data = doc.data() as Map<String, dynamic>;
            final espece = data['espece'] ?? 'Autre';

            if (!animauxParEspece.containsKey(espece)) {
              animauxParEspece[espece] = [];
            }
            animauxParEspece[espece]!.add(data);
          }

          return ListView(
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
                    // Calcul âge à partir de la date de naissance
                    String age = 'Inconnu';
                    if (animal['date_naissance'] != null) {
                      final birth = DateTime.parse(animal['date_naissance']);
                      final now = DateTime.now();
                      final years = now.year - birth.year;
                      final months = now.month - birth.month;
                      age = months >= 0 ? "$years ans et $months mois" : "$years ans";
                    }

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green.shade100,
                          backgroundImage: (animal['photo'] ?? '').isNotEmpty
                              ? NetworkImage(animal['photo'])
                              : null,
                          child: (animal['photo'] ?? '').isEmpty
                              ? const Icon(Icons.pets, color: Colors.green)
                              : null,
                        ),
                        title: Text(animal['nom'] ?? ''),
                        subtitle: Text(age),
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
          );
        },
      ),
    );
  }
}
