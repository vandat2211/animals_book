
import 'package:animals_book/app_bar.dart';
import 'package:animals_book/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key,}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    init();
    super.initState();
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
    );
  }
}
