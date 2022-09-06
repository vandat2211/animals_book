
import 'package:animals_book/view/login/forgot_password_page.dart';
import 'package:animals_book/resource/assets.dart';
import 'package:animals_book/resource/color.dart';
import 'package:animals_book/resource/style.dart';
import 'package:animals_book/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passworddController = TextEditingController();
  Future signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passworddController.text.trim());
    Navigator.of(context).pop();
  }
  Future<UserCredential> signInWithGoogle() async {
    final prefs = await SharedPreferences.getInstance();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final  credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await prefs.setString('TokenGoogle', googleAuth!.accessToken!);
    print("ok2:  ${googleAuth.accessToken}");
    return await FirebaseAuth.instance.signInWithCredential(credential);

  }
  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
  Future addUserDetail(String firstName,String lastName,String email,int age,String user_url)async{
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
      'first name':firstName,
      'last name':lastName,
      'email':email,
      'age':age,
      'user_url':user_url,
    });
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passworddController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Utils.bkavCheckOrientation(context, SingleChildScrollView(
          child: Container(
            //Bkav Nhungltk: diem diem giao dien
            //alignment: const Alignment(0, -0.408),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageAsset.loginBackgroundd),
                    fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Hello Again!",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Welcome back, you\'ve been missed!',
                    style: TextStyle(
                      fontSize: 20,color: Colors.white
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Email'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _passworddController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Password'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return ForgotPasswordPage();
                                  }));
                            },
                            child: const Text(
                              'Forot Password ?',
                              style: TextStyle(
                                  color: Colors.deepPurple, fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: InkWell(
                      onTap: signIn,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member? ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                          onTap: widget.showRegisterPage,
                          child: const Text(
                            'Register now',
                            style: TextStyle(
                                color: Colors.blue, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Container(
                          width: 40,
                          height: 40,
                          child: GestureDetector(
                            onTap:(){signInWithGoogle().then((UserCredential value) {
                              User? user=value.user;
                                final name=value.user!.displayName;
                                final email=value.user!.email;
                                final userurl=value.user!.photoURL;
                                if(user!=null){
                                  if(value.additionalUserInfo!.isNewUser){
                                    addUserDetail(name!,name,email!,20,userurl!);
                                  }
                                }
                            });} ,
                            child: Image(image: AssetImage(ImageAsset.imageGoogle),),
                          ),
                        ),
                      SizedBox(width: 20,),
                      Container(
                        width: 40,
                        height: 40,
                        child: GestureDetector(
                          onTap:(){signInWithFacebook().then((value) {
                            User? user=value.user;
                            final name=value.user!.displayName;
                            final email=value.user!.email;
                            final userurl=value.user!.photoURL;
                            if(user!=null){
                              if(value.additionalUserInfo!.isNewUser){
                                addUserDetail(name!,name,email!,20,userurl!);
                              }
                            }
                          });} ,
                          child: Image(image: AssetImage(ImageAsset.imageFacebook),),
                        ),
                      ),
                    ],
                  )
                ],
              ))),
        )),
      );
  }
  }

