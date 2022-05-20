import 'dart:convert';

import 'package:complex_json_implementation/Model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User_Screen extends StatefulWidget {
  const User_Screen({Key? key}) : super(key: key);

  @override
  State<User_Screen> createState() => _User_ScreenState();
}

List<Usermodel> userlist = [];

Future<List<Usermodel>> getapi() async {
  final responce =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
  var data = jsonDecode(responce.body.toString());
  if (responce.statusCode == 200) {
    for (Map i in data) {
      userlist.add(Usermodel.fromJson(i));
    }
    return userlist;
  } else {
    return userlist;
  }
}

class _User_ScreenState extends State<User_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('user Screen'),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getapi(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Usermodel>> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else
                    return ListView.builder(
                        itemCount: userlist.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              children: [
                                ReusableRow(
                                    title: 'Name',
                                    value:
                                        snapshot.data![index].name.toString()),
                                ReusableRow(
                                    title: 'Email',
                                    value: snapshot.data![index].email
                                        .toString()),
                                ReusableRow(
                                    title: 'City Address',
                                    value: snapshot.data![index].address!.city
                                        .toString())
                              ],
                            ),
                          );
                        });
                },
              ),
            )
          ],
        ));
  }
}
////Component
class ReusableRow extends StatelessWidget {
  String title, value;

  ReusableRow({required this.title, required this.value}) : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(value)],
      ),
    );
  }
}
