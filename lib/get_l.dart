
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetL extends StatelessWidget {
  const GetL({Key? key, required this.animalID, required this.foodID, required this.loaiid}) : super(key: key);
  final String animalID;
  final String foodID;
  final String loaiid;
  @override
  Widget build(BuildContext context) {
    String nameloai;
    CollectionReference dd=FirebaseFirestore.instance.collection('animal').doc(animalID).collection('food').doc(foodID).collection('species');
    return FutureBuilder<DocumentSnapshot>(
        future: dd.doc(loaiid).get(),
        builder: ((context,snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            Map<String,dynamic> data=
            snapshot.data!.data() as Map<String,dynamic>;
            nameloai=data['name_species'].toString();
            return
              Text('${data['name_species']}');
          }
          return Text("loading...");
        }));
  }

}
