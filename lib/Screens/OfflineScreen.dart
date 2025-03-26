import 'package:flutter/material.dart';

class OfflineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildOfflineButton(
              context,
              icon: Icons.map,
              text: 'Mapas\nDescargados',
              color: Colors.teal,
              route: '/mapasDescargados',
            ),
            SizedBox(height: 16),
            _buildOfflineButton(
              context,
              icon: Icons.info,
              text: 'Información\nDescargas',
              color: Colors.teal.shade700,
              route: '/informacionDescargada',
            ),
            SizedBox(height: 16),
            _buildOfflineButton(
              context,
              icon: Icons.house,
              text: 'Guía de Refugios\nDescargados',
              color: Colors.teal,
              route: '/refugiosDescargados',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Comunidad'),
          BottomNavigationBarItem(
            icon: Icon(Icons.signal_wifi_off),
            label: 'Offline',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        currentIndex: 2, // Offline seleccionado
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/comunidad');
              break;
            case 2:
              break; // Ya estamos en Offline
            case 3:
              Navigator.pushNamed(context, '/settings');
              break;
          }
        },
      ),
    );
  }

  Widget _buildOfflineButton(
    BuildContext context, {
    required IconData icon,
    required String text,
    required Color color,
    required String route,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(width: 16),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
