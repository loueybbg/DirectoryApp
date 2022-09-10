import 'package:flutter/material.dart';
import 'package:loginpage/User.dart';
import 'package:loginpage/home_page.dart';
import 'package:loginpage/user_dialog.dart';
import 'package:http/http.dart' as http;

class AddUserDialog extends StatefulWidget {
  final Function(User) addUser;

  AddUserDialog(this.addUser);

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  @override
  Widget build(BuildContext context) {
    Widget buildTextField(String hint, TextEditingController controller) {
      return Container(
        margin: EdgeInsets.all(4),
        child: TextField(
          decoration: InputDecoration(
              labelText: hint,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black38),
              )),
          controller: controller,
        ),
      );
    }

    var usernamecontroller = TextEditingController();
    var emailcontroller = TextEditingController();
    var phoneNocontroller = TextEditingController();
    var adressecontroller = TextEditingController();
    insertData() async {
      var res =
          await http.post(Uri.parse("http://10.0.2.2:8080/insertdata"), body: {
        "username": usernamecontroller.text,
        "email": emailcontroller.text,
        "phoneNo": phoneNocontroller.text,
        "adresse": adressecontroller.text
      }, headers: {
        'Context-Type': 'application/json;charSet=UTF-8'
      });
    }

    return Container(
        padding: EdgeInsets.all(8),
        height: 350,
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'add User',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.blueGrey),
              ),
              buildTextField('username', usernamecontroller),
              buildTextField('email', emailcontroller),
              buildTextField('phoneNo', phoneNocontroller),
              buildTextField('adresse', adressecontroller),
              ElevatedButton(
                  onPressed: () {
                    insertData();
                    final user = User(
                        usernamecontroller.text,
                        emailcontroller.text,
                        phoneNocontroller.text,
                        adressecontroller.text);
                    widget.addUser(user);
                    Navigator.of(context).pop();
                  },
                  child: Text('Add User'))
            ],
          ),
        ));
  }
}
