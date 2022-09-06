
import 'package:animals_book/app_bar.dart';
import 'package:animals_book/utils.dart';
import 'package:animals_book/view/page/change_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key,}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name='';
  String? email='';
  String? user_url='';
  String? age='';
  Future _getData()async{
    await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((snapshot)async{
      if(snapshot.exists){
        name= snapshot.data()!["first name"];
        email= snapshot.data()!["email"];
        user_url= snapshot.data()!["user_url"];
        age= snapshot.data()!["age"].toString();
      }
    });
  }
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    init();
    super.initState();
    _getData();
  }
  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString("TokenGoogle");
    print("tokengoogle : ${prefs.getString("TokenGoogle")}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      appBar: CustomAppBar(
        context,
        title: Text(user.email!),
        showDefaultBackButton: false,
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: Icon(Icons.logout),
          )
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/backgroundd.jpg'),
                  fit: BoxFit.cover)),

        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
            borderRadius:
            BorderRadius
                .circular(
            12.0),
            child: Image.network(
              user.photoURL!,
              fit: BoxFit.cover,
              width: 150,height: 150,
            ),
    ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.displayName!,),
                const SizedBox(height: 5,),
                Text(user.email!)
              ],
            )
          ],
        ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 50),
              child: InkWell(
                onTap: (){Navigator.of(context)
                    .push<void>(
                  ChangeInfo.route(
                    name!,
                    age!
                  ),
                );},
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                      child: Text(
                        'Change Infomation',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ),
          ],

        ),
      )


    );
  }
}
