import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comunidad'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_outlined),
            onPressed: () {
              // Lógica para editar
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Buscar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavButton(context, 'Mensajes', '/mensajes', false),
              _buildNavButton(context, 'Comunidad', '/comunidad', true),
              ElevatedButton(
                onPressed: () {}, // Micrófono (lógica a definir)
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Icon(Icons.mic),
              ),
              _buildNavButton(context, 'Llamadas', '/llamadas', false),
            ],
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.group_add)),
            title: Text('Crear nueva comunidad'),
            onTap: () {
              Navigator.pushNamed(context, '/crearGrupo');
            },
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('groups').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No hay grupos disponibles."));
                }
                return ListView(
                  children:
                      snapshot.data!.docs.map((doc) {
                        Map<String, dynamic> groupData =
                            doc.data() as Map<String, dynamic>;
                        return _buildGroupTile(groupData);
                      }).toList(),
                );
              },
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
        currentIndex: 1, // Comunidad seleccionado
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              break; // Ya estamos en comunidad
            case 2:
              Navigator.pushNamed(context, '/offline');
              break;
            case 3:
              Navigator.pushNamed(context, '/settings');
              break;
          }
        },
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context,
    String text,
    String route,
    bool isActive,
  ) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: isActive ? Colors.white : Colors.black,
        backgroundColor: isActive ? Colors.teal : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(text),
    );
  }

  Widget _buildGroupTile(Map<String, dynamic> groupData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage:
                groupData['image'] != null
                    ? NetworkImage(groupData['image'])
                    : null,
            child: groupData['image'] == null ? Icon(Icons.group) : null,
          ),
          title: Text(groupData['name'] ?? 'Grupo sin nombre'),
          subtitle: Text("Miembros: ${groupData['members']?.length ?? 0}"),
          onTap: () {
            // Aquí iría la navegación al chat del grupo
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextButton(onPressed: () {}, child: Text('Ver todos')),
          ),
        ),
      ],
    );
  }
}
