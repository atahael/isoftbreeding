import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddAnimalScreen extends StatefulWidget {
  const AddAnimalScreen({super.key});

  @override
  State<AddAnimalScreen> createState() => _AddAnimalScreenState();
}

class _AddAnimalScreenState extends State<AddAnimalScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController dateNaissanceController = TextEditingController();

  File? _image;
  String? selectedEspece;
  String? selectedSexe;
  DateTime? selectedDateNaissance;

  int selectedAgeYears = 0;
  int selectedAgeMonths = 0;
  bool knowsExactDate = false;

  List<String> especes = [];

  @override
  void initState() {
    super.initState();
    _loadEspecesFromJson();
  }

  Future<void> _loadEspecesFromJson() async {
    final String data = await rootBundle.loadString('assets/data/animals.json');
    final List<dynamic> jsonResult = json.decode(data);
    setState(() {
      especes = jsonResult.cast<String>();
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 20),
      lastDate: now,
    );
    if (picked != null) {
      selectedDateNaissance = picked;
      dateNaissanceController.text =
          "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  DateTime _calculateBirthdateFromAge(int years, int months) {
    final now = DateTime.now();
    final approx = DateTime(now.year - years, now.month - months, now.day);
    return approx;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un Animal"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: especes.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.green.shade100,
                        backgroundImage: _image != null ? FileImage(_image!) : null,
                        child: _image == null ? const Icon(Icons.camera_alt, size: 32) : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: nomController,
                      decoration: const InputDecoration(labelText: "Nom de l'animal"),
                      validator: (value) =>
                          value!.isEmpty ? "Veuillez entrer un nom" : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedEspece,
                      decoration: const InputDecoration(labelText: "Espèce"),
                      items: especes
                          .map((espece) =>
                              DropdownMenuItem(value: espece, child: Text(espece)))
                          .toList(),
                      onChanged: (value) => setState(() => selectedEspece = value),
                      validator: (value) =>
                          value == null ? "Veuillez choisir une espèce" : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedSexe,
                      decoration: const InputDecoration(labelText: "Sexe"),
                      items: const [
                        DropdownMenuItem(value: "Mâle", child: Text("Mâle")),
                        DropdownMenuItem(value: "Femelle", child: Text("Femelle")),
                      ],
                      onChanged: (value) => setState(() => selectedSexe = value),
                      validator: (value) =>
                          value == null ? "Sélectionnez le sexe" : null,
                    ),
                    const SizedBox(height: 16),

                    /// Choix entre date exacte ou âge estimé
                    SwitchListTile(
                      title: const Text("Connaissez-vous la date exacte ?"),
                      value: knowsExactDate,
                      onChanged: (value) {
                        setState(() {
                          knowsExactDate = value;
                          if (!knowsExactDate) {
                            dateNaissanceController.clear();
                            selectedDateNaissance = null;
                          }
                        });
                      },
                    ),

                    if (knowsExactDate) ...[
                      TextFormField(
                        controller: dateNaissanceController,
                        readOnly: true,
                        decoration: const InputDecoration(labelText: "Date de naissance"),
                        onTap: () => _selectDate(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Sélectionnez une date";
                          }
                          return null;
                        },
                      ),
                    ] else ...[
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: selectedAgeYears,
                              decoration: const InputDecoration(labelText: "Années"),
                              items: List.generate(
                                21,
                                (index) => DropdownMenuItem(
                                    value: index, child: Text("$index")),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selectedAgeYears = value!;
                                  final date = _calculateBirthdateFromAge(
                                      selectedAgeYears, selectedAgeMonths);
                                  dateNaissanceController.text =
                                      "${date.day}/${date.month}/${date.year}";
                                  selectedDateNaissance = date;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: selectedAgeMonths,
                              decoration: const InputDecoration(labelText: "Mois"),
                              items: List.generate(
                                12,
                                (index) => DropdownMenuItem(
                                    value: index, child: Text("$index")),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selectedAgeMonths = value!;
                                  final date = _calculateBirthdateFromAge(
                                      selectedAgeYears, selectedAgeMonths);
                                  dateNaissanceController.text =
                                      "${date.day}/${date.month}/${date.year}";
                                  selectedDateNaissance = date;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: dateNaissanceController,
                        readOnly: true,
                        enabled: false,
                        decoration: const InputDecoration(
                            labelText: "Date estimée de naissance"),
                      ),
                    ],

                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // TODO: Sauvegarder l’animal avec les infos
                          Navigator.pop(context);
                        }
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
      ),
    );
  }
}
