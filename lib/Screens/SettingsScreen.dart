import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.arrow_back, color: Colors.black),
            SizedBox(width: 10),
            Text(
              'Configuración',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            Spacer(),
            Icon(Icons.settings, color: Colors.black),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar",
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView(
                children: [
                  _buildSettingsCategory("Principal"),
                  _buildSettingsItem(
                    context,
                    title: "Usuario",
                    subtitle: "Perfil y configuración de la cuenta",
                    icon: Icons.account_circle,
                    route: "/usuario",
                  ),
                  _buildSettingsCategory("Configuración de la Aplicación"),
                  _buildSettingsItem(
                    context,
                    title: "Notificaciones y Mensajes",
                    icon: Icons.notifications,
                    route: "/notificaciones",
                  ),
                  _buildSettingsItem(
                    context,
                    title: "Ayuda y Soporte",
                    icon: Icons.help_outline,
                    route: "/ayuda",
                  ),
                  _buildSettingsItem(
                    context,
                    title: "Privacidad y seguridad",
                    icon: Icons.lock,
                    route: "/privacidad",
                  ),
                  _buildSettingsCategory("Otros"),
                  _buildSettingsItem(
                    context,
                    title: "Sobre Chak iik´",
                    icon: Icons.info_outline,
                    route: "/sobre",
                  ),
                  _buildSettingsItem(
                    context,
                    title: "Cerrar sesión",
                    icon: Icons.logout,
                    route: "/logout",
                  ),
                ],
              ),
            ),
          ),
        ],
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
        currentIndex: 3, // Configuración seleccionado
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/comunidad');
              break;
            case 2:
              Navigator.pushNamed(context, '/offline');
              break;
            case 3:
              break; // Ya estamos en Configuración
          }
        },
      ),
    );
  }

  Widget _buildSettingsCategory(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required String title,
    String? subtitle,
    required IconData icon,
    required String route,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(title, style: TextStyle(fontSize: 16)),
      subtitle:
          subtitle != null
              ? Text(subtitle, style: TextStyle(color: Colors.grey))
              : null,
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
