
import 'package:animals_book/resource/assets.dart';
import 'package:animals_book/utils.dart';
import 'package:flutter/material.dart';

class ChangeInfo extends StatefulWidget {
   ChangeInfo.init({Key? key,required this.name,required this.age}) : super(key: key);
   static Route route(String name,String age) {
     return Utils.pageRouteBuilder(
         ChangeInfo.init(age: age, name:name,
         ),
         true);
   }
String name;
String age;
  @override
  State<ChangeInfo> createState() => _ChangeInfoState();
}

class _ChangeInfoState extends State<ChangeInfo> {
  final _name = TextEditingController();
  final _age = TextEditingController();
  late FocusNode myFocusNode;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }
  @override
  void dispose() {
    myFocusNode.dispose();
    _name.dispose();
    _age.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Utils.bkavCheckOrientation(context, SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration:  const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageAsset.loginBackgroundd),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10),
                child: InkWell(
                  onTap: (){},
                  child: Container(
                    height: 200,
                    width: 200,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.green.shade700,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ),
              SizedBox(height: 50,),
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
                      focusNode: myFocusNode,
                      controller: _name,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'FirstName'),
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
                      controller: _age,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'LastName'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
