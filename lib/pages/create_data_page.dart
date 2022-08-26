import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_crud_mockapi/data/repository.dart';
import 'package:flutter_application_crud_mockapi/main.dart';

class CreateData extends StatefulWidget {
  const CreateData({Key? key}) : super(key: key);

  @override
  State<CreateData> createState() => _CreateDataState();
}

class _CreateDataState extends State<CreateData> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final messageController = TextEditingController();
  Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tambah data'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'First Name'),
                  controller: firstNameController,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Last Name'),
                  controller: lastNameController,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Message'),
                  controller: messageController,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, 'home');
                        },
                        child: Text('Cancel')),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          bool response = await repository.createData(
                              firstNameController.text,
                              lastNameController.text,
                              messageController.text);

                          if (response) {
                            Navigator.popAndPushNamed(context, 'home');
                          } else {
                            throw Exception('Gagal menambah data');
                          }
                        },
                        child: Text('Submit'))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
