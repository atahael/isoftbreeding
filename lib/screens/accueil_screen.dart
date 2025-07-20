import 'package:flutter/material.dart';

class AccueilScreen extends StatelessWidget {
  const AccueilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text("Tableau de bord"),
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Déconnexion',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Déconnexion...")),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            _buildDrawerItem(context, Icons.pets, "Mes Animaux", '/animaux'),
            _buildDrawerItem(context, Icons.vaccines, "Vaccins", '/vaccins'),
            _buildDrawerItem(context, Icons.medication, "Traitements", '/traitements'),
            _buildDrawerItem(context, Icons.monitor_heart, "Suivi Santé", '/sante'),
            _buildDrawerItem(context, Icons.monitor_weight, "Suivi Poids", '/poids'),
            _buildDrawerItem(context, Icons.child_friendly, "Naissances", '/naissances'),
            _buildDrawerItem(context, Icons.calendar_month, "Calendrier des soins", '/calendrier'),
            _buildDrawerItem(context, Icons.bar_chart, "Statistiques", '/statistiques'),
            _buildDrawerItem(context, Icons.person, "Mon Profil", '/profil'),
          ],
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 2;

            if (constraints.maxWidth > 1200) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth > 800) {
              crossAxisCount = 3;
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildCard(context, Icons.pets, "Mes Animaux", '/animaux'),
                  _buildCard(context, Icons.vaccines, "Vaccins", '/vaccins'),
                  _buildCard(context, Icons.medication, "Traitements", '/traitements'),
                  _buildCard(context, Icons.monitor_heart, "Santé", '/sante'),
                  _buildCard(context, Icons.monitor_weight, "Poids", '/poids'),
                  _buildCard(context, Icons.child_friendly, "Naissances", '/naissances'),
                  _buildCard(context, Icons.calendar_month, "Calendrier", '/calendrier'),
                  _buildCard(context, Icons.bar_chart, "Statistiques", '/statistiques'),
                  _buildCard(context, Icons.person, "Profil", '/profil'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String label, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String label, String route) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 40, color: Colors.green),
                const SizedBox(height: 10),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
