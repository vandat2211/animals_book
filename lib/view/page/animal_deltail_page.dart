import 'package:animals_book/app_bar.dart';
import 'package:flutter/material.dart';
class AnimalDeltailPage extends StatefulWidget {
  const AnimalDeltailPage({Key? key}) : super(key: key);

  @override
  State<AnimalDeltailPage> createState() => _AnimalDeltailPageState();
}

class _AnimalDeltailPageState extends State<AnimalDeltailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        title: Text("Ho"),
        showDefaultBackButton: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/backgroundd.jpg'),
                  fit: BoxFit.cover)),
        ),
      ),
      body: Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: const BoxDecoration(
    image: DecorationImage(
    image: ExactAssetImage('assets/images/backgroundd.jpg'),
    fit: BoxFit.cover),
    ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Text("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"),
            )
          ],
        ),
      ),
    );
  }
}
