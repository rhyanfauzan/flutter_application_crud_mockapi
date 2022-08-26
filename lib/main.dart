import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_application_crud_mockapi/data/repository.dart';
import 'package:flutter_application_crud_mockapi/model/person.dart';
import 'package:flutter_application_crud_mockapi/pages/create_data_page.dart';
import 'package:flutter_application_crud_mockapi/pages/update_data_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Person> listPerson = [];
  Repository repository = Repository();

  getData() async {
    listPerson = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(listPerson: listPerson),
      routes: {
        'home': (context) => HomePage(listPerson: listPerson),
        'create': (context) => CreateData(),
        'update': (context) => UpdateData(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
    required this.listPerson,
  }) : super(key: key);

  final List<Person> listPerson;
  Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: ListView.builder(
          itemCount: listPerson.length,
          itemBuilder: (context, index) {
            Person person = listPerson[index];
            return InkWell(
              onLongPress: () {
                Navigator.popAndPushNamed(context, 'update', arguments: [
                  person.id,
                  person.first_name,
                  person.last_name,
                  person.message
                ]);
              },
              child: Dismissible(
                key: Key(person.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Icon(Icons.delete),
                ),
                confirmDismiss: (direction) {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Delete Data'),
                          content: Text('Are you sure to delete data?'),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  bool response =
                                      await repository.deleteData(person.id);
                                  if (response) {
                                    Navigator.pop(context, true);
                                  } else {
                                    Navigator.pop(context, false);
                                  }
                                },
                                child: Text('Yes')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: Text('No'))
                          ],
                        );
                      });
                },
                child: ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/person1.png'),
                            fit: BoxFit.cover)),
                  ),
                  title: Text('${person.first_name} ${person.last_name}'),
                  subtitle: Text(person.message),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, 'create');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
