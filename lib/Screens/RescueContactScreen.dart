import 'package:flutter/material.dart';

class RescueContactScreen extends StatelessWidget {
  final dynamic rescuer;

  RescueContactScreen({required this.rescuer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(title: Text('Perfil')),
      body: Column(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(rescuer['imageUrl']),
          ),
          SizedBox(height: 10),
          Text(
            rescuer['name'],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'Rescatista voluntario',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoCard(title: 'Municipio', value: rescuer['municipality']),
              InfoCard(title: 'Teléfono', value: rescuer['phone']),
              InfoCard(title: 'Edad', value: '${rescuer['age']} años'),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(value),
          ],
        ),
      ),
    );
  }
}
