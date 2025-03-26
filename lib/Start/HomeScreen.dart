import 'package:chakikk_app/Screens/CommunityScreen.dart';
import 'package:chakikk_app/Screens/HelpNetworkScreen.dart';
import 'package:chakikk_app/Screens/OfflineScreen.dart';
import 'package:chakikk_app/Screens/RescueContactScreen.dart';
import 'package:chakikk_app/Screens/RescueListScreen.dart';
import 'package:chakikk_app/Screens/SafetyInfoScreen.dart';
import 'package:chakikk_app/Screens/SearchResultsScreen.dart';
import 'package:chakikk_app/Screens/SettingsScreen.dart';
import 'package:chakikk_app/UI/Maps/MapScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const MethodChannel _channel = MethodChannel('chakiik/maps');
  final TextEditingController _searchController = TextEditingController();

  void _openScreen(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  void _search() {
    if (_searchController.text.isNotEmpty) {
      _openScreen(SearchResultsScreen(query: _searchController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        title: const Text(
          "Bienvenido Usuario!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 20),
            _buildQuickActions(),
            const SizedBox(height: 20),
            _buildMapCards(),
            const SizedBox(height: 20),
            _buildMoreMapsButton(),
            const SizedBox(height: 20),
            _buildRescueListButton(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Escribe para buscar",
          prefixIcon: Icon(Icons.menu),
          suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: _search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _quickActionButton(Icons.group, "Red de Ayuda", HelpNetworkScreen()),
        _quickActionButton(
          Icons.security,
          "Información de Seguridad",
          SafetyInfoScreen(),
        ),
        _quickActionButton(
          Icons.volunteer_activism,
          "Contacta Rescatistas",
          RescueContactScreen(rescuer: null),
        ),
      ],
    );
  }

  Widget _quickActionButton(IconData icon, String label, Widget screen) {
    return GestureDetector(
      onTap: () => _openScreen(screen),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildMapCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _mapCard("Mapa Satelital", 'satelital'),
        _mapCard("Mapa de Temperatura", 'temperatura'),
        _mapCard("Mapa de Viento", 'viento'),
        _mapCard("Mapa de Precipitación", 'precipitacion'),
      ],
    );
  }

  Widget _mapCard(String title, String mapType) {
    return GestureDetector(
      onTap: () => _openScreen(MapScreen(mapType: mapType, mapId: '')),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Icon(Icons.map, size: 40, color: Colors.teal),
              const SizedBox(height: 10),
              Text(title, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoreMapsButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () => _openScreen(MapScreen(mapType: 'todos', mapId: '')),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        ),
        child: const Text(
          "VER MÁS MAPAS",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildRescueListButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () => _openScreen(RescueListScreen()),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        ),
        child: const Text(
          "LISTA DE RESCATISTAS",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      onTap: (index) {
        switch (index) {
          case 0:
            _openScreen(HomeScreen());
            break;
          case 1:
            _openScreen(CommunityScreen());
            break;
          case 2:
            _openScreen(OfflineScreen());
            break;
          case 3:
            _openScreen(SettingsScreen());
            break;
        }
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
