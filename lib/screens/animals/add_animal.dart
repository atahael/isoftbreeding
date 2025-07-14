import 'package:flutter/material.dart';

class AddAnimalScreen extends StatelessWidget {
  const AddAnimalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nomController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    String? selectedEspece;

    final List<String> especes = ['Vache', 'Mouton', 'Poulet', 'Chèvre', 'Autre'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un Animal"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: nomController,
              decoration: const InputDecoration(labelText: "Nom de l'animal"),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedEspece,
              decoration: const InputDecoration(labelText: "Espèce"),
              items: especes.map((espece) {
                return DropdownMenuItem(
                  value: espece,
                  child: Text(espece),
                );
              }).toList(),
              onChanged: (value) {
                selectedEspece = value;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: ageController,
              decoration: const InputDecoration(labelText: "Âge"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // TODO: Sauvegarder les données
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Ajouter", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
