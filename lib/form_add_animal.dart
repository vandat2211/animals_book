import 'package:flutter/material.dart';

class FormAddAnimal extends StatefulWidget {
  const FormAddAnimal({Key? key}) : super(key: key);

  @override
  State<FormAddAnimal> createState() => _FormAddAnimalState();
}

class _FormAddAnimalState extends State<FormAddAnimal> {
  String? value;

  List<String> items = ['One', 'Two', 'Three', 'Four', 'Five'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Text("dac diem"),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 300,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black, width: 4)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: value,
                      iconSize: 36,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      isExpanded: true,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() => this.value = value),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("dac diem"),

                SizedBox(width: 10,),
                Container(
                  width: 300,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black, width: 4)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: value,
                      iconSize: 36,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      isExpanded: true,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() => this.value = value),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("dac diem"),
                SizedBox(width: 10,),
                Container(
                  width: 300,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black, width: 4)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: value,
                      iconSize: 36,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      isExpanded: true,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() => this.value = value),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));
}
