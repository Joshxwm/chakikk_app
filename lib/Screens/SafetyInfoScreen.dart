import 'package:flutter/material.dart';

class SafetyInfoScreen extends StatelessWidget {
  const SafetyInfoScreen({super.key});

  void _openSection(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Información de Seguridad"),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildSafetyButton(
                    Icons.info,
                    "Resguardo de su Información",
                    Placeholder(),
                  ),
                  _buildSafetyButton(
                    Icons.home,
                    "Proteja su Hogar",
                    Placeholder(),
                  ),
                  _buildSafetyButton(
                    Icons.article,
                    "Comunicados Oficiales",
                    Placeholder(),
                  ),
                  _buildSafetyButton(
                    Icons.group,
                    "Medidas de Seguridad para Apoyo a la Comunidad",
                    Placeholder(),
                  ),
                  _buildSafetyButton(
                    Icons.cloud,
                    "Conoce más sobre los fenómenos meteorológicos",
                    Placeholder(),
                  ),
                  _buildSafetyButton(
                    Icons.health_and_safety,
                    "Medidas de Seguridad",
                    Placeholder(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _buildNotificationsSection(),
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
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _buildSafetyButton(IconData icon, String label, Widget screen) {
    return GestureDetector(
      onTap: () => _openSection(screen as BuildContext, screen),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "¿Requieres ver tus notificaciones? ¡Revisa aquí!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Card(
          child: ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notificaciones"),
            trailing: Icon(Icons.arrow_forward),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        // Aquí puedes definir la navegación de los botones inferiores
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
        BottomNavigationBarItem(icon: Icon(Icons.group), label: "Comunidad"),
        BottomNavigationBarItem(icon: Icon(Icons.wifi_off), label: "Offline"),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Configuración",
        ),
      ],
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.black54,
      showUnselectedLabels: true,
    );
  }
}
