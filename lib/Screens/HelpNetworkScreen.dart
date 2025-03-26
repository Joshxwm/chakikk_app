import 'package:flutter/material.dart';

class HelpNetworkScreen extends StatelessWidget {
  const HelpNetworkScreen({super.key});

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Red De Ayuda",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 10),
            const Text(
              "Formularios",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildFormButtons(context),
            const SizedBox(height: 20),
            const Text(
              "Teléfonos de Emergencia",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildEmergencyButtons(context),
            const SizedBox(height: 10),
            _buildViewAllButton(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Buscar",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        fillColor: Colors.grey[200],
        filled: true,
      ),
    );
  }

  Widget _buildFormButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _formCard(
          context,
          "Ubicación de Refugios",
          Icons.home,
          Colors.teal,
          Placeholder(),
        ),
        _formCard(
          context,
          "Solicitud de Recursos",
          Icons.medical_services,
          Colors.teal,
          Placeholder(),
        ),
      ],
    );
  }

  Widget _formCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget screen,
  ) {
    return GestureDetector(
      onTap: () => _navigateTo(context, screen),
      child: Container(
        width: 150,
        height: 120,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyButtons(BuildContext context) {
    return Column(
      children: [
        _emergencyButton(
          context,
          "Ambulancias",
          Icons.local_hospital,
          Placeholder(),
        ),
        _emergencyButton(context, "Hospitales", Icons.apartment, Placeholder()),
        _emergencyButton(
          context,
          "Bomberos",
          Icons.local_fire_department,
          Placeholder(),
        ),
        _emergencyButton(context, "Policía", Icons.local_police, Placeholder()),
      ],
    );
  }

  Widget _emergencyButton(
    BuildContext context,
    String title,
    IconData icon,
    Widget screen,
  ) {
    return GestureDetector(
      onTap: () => _navigateTo(context, screen),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildViewAllButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {},
        child: const Text(
          "> Ver todos",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index) {},
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
        BottomNavigationBarItem(icon: Icon(Icons.group), label: "Comunidad"),
        BottomNavigationBarItem(icon: Icon(Icons.wifi_off), label: "Offline"),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Configuración",
        ),
      ],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
    );
  }
}
