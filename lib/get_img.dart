import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
class GetImg extends StatelessWidget {
  final String animalId;
  const GetImg({Key? key, required this.animalId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference animal=FirebaseFirestore.instance.collection('animal');
    return FutureBuilder<DocumentSnapshot>(
        future: animal.doc(animalId).get(),
        builder: ((context,snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            Map<String,dynamic> data=
            snapshot.data!.data() as Map<String,dynamic>;
            return Image(image: NetworkImage('${data['url_dacdiem']}'),fit: BoxFit.cover,);
          }
          return Container();
        }));
  }
}
