import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController nameController = TextEditingController();

  String? name;

  //Set Name
  Future<void> setName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", nameController.text);
    print("${nameController.text}"); //cross check value save or not
  }

  //get value
  Future<void> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name") ?? " No data found !";
    });
  }

  @override
  void initState() {
    getName();
  }

  @override
  void dispose() {
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Named Save With Shared Preference"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${name}"),
            SizedBox(
              height: 20,
            ),
            Container(
                width: 400,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Name',
                  ),
                )),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white),
                      onPressed: () async {
                        await setName();
                      },
                      child: Text("Save Data")),
                  ElevatedButton(
                      onPressed: () async {
                        await getName();
                      },
                      child: Text("Get Data"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
