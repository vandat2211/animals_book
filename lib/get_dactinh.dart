import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class GetDacTinh extends StatelessWidget {
  final String ddId;
  final String animalID;
  const GetDacTinh({Key? key, required this.ddId, required this.animalID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference dd=FirebaseFirestore.instance.collection('animal').doc(animalID).collection('dactinh');
    return FutureBuilder<DocumentSnapshot>(
        future: dd.doc(ddId).get(),
        builder: ((context,snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            Map<String,dynamic> data=
            snapshot.data!.data() as Map<String,dynamic>;
            return
                  Text('${data['name_dactinh']}');
          }
          return Text("loading...");
        }));
  }
}
