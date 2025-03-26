import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchResultsScreen extends StatefulWidget {
  final String query;

  const SearchResultsScreen({Key? key, required this.query}) : super(key: key);

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late Future<List<Map<String, dynamic>>> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = _fetchResults(widget.query);
  }

  Future<List<Map<String, dynamic>>> _fetchResults(String query) async {
    List<Map<String, dynamic>> results = [];

    // Buscar en la colección de Mapas
    QuerySnapshot mapsSnapshot =
        await FirebaseFirestore.instance
            .collection('maps')
            .where('name', isGreaterThanOrEqualTo: query)
            .where('name', isLessThanOrEqualTo: '$query\uf8ff')
            .get();

    results.addAll(
      mapsSnapshot.docs.map((doc) {
        return {
          'type': 'Mapa',
          'title': doc['name'],
          'description':
              doc['type'], // Tipo de mapa (Satelital, Temperatura, etc.)
          'id': doc.id,
        };
      }),
    );

    // Buscar en la colección de Chats
    QuerySnapshot chatsSnapshot =
        await FirebaseFirestore.instance
            .collection('chats')
            .where('name', isGreaterThanOrEqualTo: query)
            .where('name', isLessThanOrEqualTo: '$query\uf8ff')
            .get();

    results.addAll(
      chatsSnapshot.docs.map((doc) {
        return {
          'type': 'Chat',
          'title': doc['name'],
          'description': 'Grupo de chat comunitario',
          'id': doc.id,
        };
      }),
    );

    // Buscar en la colección de Información de Seguridad
    QuerySnapshot infoSnapshot =
        await FirebaseFirestore.instance
            .collection('safety_info')
            .where('title', isGreaterThanOrEqualTo: query)
            .where('title', isLessThanOrEqualTo: '$query\uf8ff')
            .get();

    results.addAll(
      infoSnapshot.docs.map((doc) {
        return {
          'type': 'Información',
          'title': doc['title'],
          'description': doc['details'],
          'id': doc.id,
        };
      }),
    );

    // Buscar en la colección de Rescatistas Voluntarios
    QuerySnapshot rescuersSnapshot =
        await FirebaseFirestore.instance
            .collection('rescuers')
            .where('name', isGreaterThanOrEqualTo: query)
            .where('name', isLessThanOrEqualTo: '$query\uf8ff')
            .get();

    results.addAll(
      rescuersSnapshot.docs.map((doc) {
        return {
          'type': 'Rescatista',
          'title': doc['name'],
          'description': 'Rescatista en ${doc['municipio']}',
          'id': doc.id,
        };
      }),
    );

    return results;
  }

  /* void _openScreen(String type, String id) {
    switch (type) {
      case 'Mapa':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapScreen(mapId: id)),
        );
        break;
      case 'Chat':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen(chatId: id)),
        );
        break;
      case 'Información':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SafetyInfoScreen(infoId: id)),
        );
        break;
      case 'Rescatista':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RescuerDetailScreen(rescuerId: id)),
        );
        break;
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Resultados para "${widget.query}"')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al buscar'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No se encontraron resultados'));
          }

          List<Map<String, dynamic>> results = snapshot.data!;

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              var item = results[index];
              return ListTile(
                leading: Icon(
                  item['type'] == 'Mapa'
                      ? Icons.map
                      : item['type'] == 'Chat'
                      ? Icons.chat
                      : item['type'] == 'Información'
                      ? Icons.info
                      : Icons.person, // Rescatista
                  color: Colors.teal,
                ),
                title: Text(item['title']),
                subtitle: Text(item['description']),
                //onTap: ()
                /*  {
                  _openScreen(item['type'], item['id']);
                } */
              );
            },
          );
        },
      ),
    );
  }
}
