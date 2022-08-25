import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class GetDacTinh extends StatelessWidget {
  final String foodID;
  final String animalID;
  const GetDacTinh({Key? key, required this.foodID, required this.animalID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference dd=FirebaseFirestore.instance.collection('animal').doc(animalID).collection('food');
    return FutureBuilder<DocumentSnapshot>(
        future: dd.doc(foodID).get(),
        builder: ((context,snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            Map<String,dynamic> data=
            snapshot.data!.data() as Map<String,dynamic>;
            return
                  Text('${data['name_food']}');
          }
          return Text("loading...");
        }));
  }
}
