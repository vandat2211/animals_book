import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
class GetDacDiem extends StatelessWidget {
  final String animalId;
  const GetDacDiem({Key? key, required this.animalId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference animal=FirebaseFirestore.instance.collection('animal');
    return FutureBuilder<DocumentSnapshot>(
      future: animal.doc(animalId).get(),
        builder: ((context,snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            Map<String,dynamic> data=
                snapshot.data!.data() as Map<String,dynamic>;
            final Widget image = Material(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                clipBehavior: Clip.antiAlias,
                child: Image.network( '${data['url_dacdiem']}',fit: BoxFit.cover,)
            );
            return GridTile(
              footer: Material(
                color: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                ),
                clipBehavior: Clip.antiAlias,
                child: GridTileBar(
                  backgroundColor: Colors.black45,
                  title: Text('${data['name_dacdiem_el']}'),
                  subtitle: Text('${data['name_dacdiem']}'),
                ),
              ),
              child: image,
            );
          }
          return Container();
        }));
  }
}
