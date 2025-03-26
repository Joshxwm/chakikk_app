import 'package:chakikk_app/Screens/RescueContactScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RescueListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rescatistas Voluntarios')),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance
                .collection('rescuers')
                .where('approved', isEqualTo: true)
                .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          var rescuers = snapshot.data!.docs;
          return ListView.builder(
            itemCount: rescuers.length,
            itemBuilder: (context, index) {
              var rescuer = rescuers[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(rescuer['imageUrl']),
                ),
                title: Text(rescuer['name']),
                subtitle: Text('Municipio: ${rescuer['municipality']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => RescueContactScreen(rescuer: rescuer),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
