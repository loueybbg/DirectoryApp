import 'package:flutter/material.dart';
import 'package:loginpage/UI/input_field.dart';
import 'package:loginpage/admin.dart';
import 'package:loginpage/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:loginpage/signup.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //Material App
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  //StateFullWidget

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  Future save() async {
    var res = await http.post(Uri.parse("http://10.0.2.2:8080/signin"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': user.mail,
          'password': user.password
        });
    print(res.body);
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => HomePage()));
  }

  Admin user = Admin('', '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Scaffold
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.lightBlueAccent,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  heightFactor: 0.5,
                  widthFactor: 0.5,
                  child: Material(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(200.0)),
                    color: const Color.fromRGBO(255, 255, 255, 0.4),
                    child: Container(
                      width: 400,
                      height: 400,
                    ),
                  ),
                ),
                Center(
                    child: Container(
                  width: 400,
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Material(
                          elevation: 10.0,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "images/flutter-logo.png",
                              width: 80,
                              height: 80,
                            ),
                          )),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: TextEditingController(text: user.mail),
                          onChanged: (value) {
                            user.mail = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter something';
                            } else if (RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return null;
                            } else {
                              return 'Enter valid email';
                            }
                          },
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.email,
                                color: Colors.blue,
                              ),
                              hintText: 'Enter Email',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.blue)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.blue)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.red))),
                        ),
                      ),
                      Form(
                        child: TextFormField(
                          controller: TextEditingController(text: user.mail),
                          onChanged: (value) {
                            user.mail = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter something';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.vpn_key,
                                color: Colors.blue,
                              ),
                              hintText: 'Enter Password',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.blue)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.blue)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.red))),
                        ),
                      ),
                      Container(
                        width: 150,
                        child: RaisedButton(
                          //Raised Button
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              save();
                            } else {
                              print("not ok");
                            }
                          },
                          color: Colors.indigo,
                          textColor: Colors.white,
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(95, 20, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              "Not have Account ? ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => Signup()));
                              },
                              child: Text(
                                "Signup",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            )));
  }
}
