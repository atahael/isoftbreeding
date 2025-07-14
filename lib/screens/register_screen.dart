import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  List<String> villes = [];
  List<String> fonctions = [];

  String? selectedVille;
  String? selectedFonction;
  bool showAutreFonction = false;

  final TextEditingController autreFonctionController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final villesJson = await rootBundle.loadString('assets/data/villes_maroc.json');
    final fonctionsJson = await rootBundle.loadString('assets/data/fonctions.json');

    setState(() {
      villes = List<String>.from(json.decode(villesJson))..sort();
      fonctions = List<String>.from(json.decode(fonctionsJson))..sort();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green.shade100,
        appBar: AppBar(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Créer un compte",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: villes.isEmpty || fonctions.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField("Prénom", controller: prenomController),
                      const SizedBox(height: 12),
                      _buildTextField("Nom", controller: nomController),
                      const SizedBox(height: 12),
                      _buildTextField("Email", keyboardType: TextInputType.emailAddress, controller: emailController),
                      const SizedBox(height: 18),
                      _buildDropdownField("Ville", villes, selectedVille, (val) {
                        setState(() => selectedVille = val);
                      }),
                      const SizedBox(height: 18),
                      _buildDropdownField("Fonction", fonctions, selectedFonction, (val) {
                        setState(() {
                          selectedFonction = val;
                          showAutreFonction = val == "Autre";
                        });
                      }),
                      if (showAutreFonction) ...[
                        const SizedBox(height: 12),
                        _buildTextField("Précisez votre fonction", controller: autreFonctionController),
                      ],
                      const SizedBox(height: 18),
                      _buildTextField("Mot de passe", isPassword: true, controller: passwordController),
                      const SizedBox(height: 12),
                      _buildTextField("Confirmer le mot de passe", isPassword: true, controller: confirmPasswordController),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (passwordController.text != confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Les mots de passe ne correspondent pas")),
                              );
                              return;
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Inscription en cours...")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 2,
                        ),
                        child: const Text("Créer un compte", style: TextStyle(fontSize: 18)),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Vous avez déjà un compte ? Se connecter",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildTextField(
    String label, {
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16, color: Colors.black87),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) return 'Champ requis';
        if (label == "Email" && !value.contains('@')) return 'Email invalide';
        return null;
      },
    );
  }

  Widget _buildDropdownField(
    String label,
    List<String> items,
    String? selectedValue,
    void Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16, color: Colors.black87),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Champ requis' : null,
    );
  }
}
