import 'package:flutter/material.dart';
import 'package:loginpage/SettingsPage.dart';
import 'package:loginpage/main.dart';
import 'package:loginpage/User.dart';
import 'package:loginpage/user_dialog.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum _MenuValues {
  page2,
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> userList = [];
  getdata() async {
    var res = await http.get(Uri.parse("http://10.0.2.2:8080/getdata"));
    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      return jsonObj['clientData'];
    }
  }

  final GlobalKey<AnimatedListState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    void adduserData(User user) {
      setState(() {
        userList.add(user);
      });
    }

    void showUserDialog() {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: AddUserDialog(adduserData),
          );
        },
      );
    }

    deletedData(id) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("delete"),
              content: Text("are u sure"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              actions: [
                FlatButton(
                    child: Text("yes"),
                    onPressed: () async {
                      final res =
                          Uri.parse("http://10.0.2.2:8080/deletedata/$id");
                      final response = await http.delete(res);
                      print(response.statusCode);
                      print(response.body);
                      return json.decode(response.body);
                    }),
                FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }

    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('reserach'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SearchPage())),
              icon: Icon(Icons.search)),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        child: FutureBuilder(
          future: getdata(),
          builder: (BuildContext context, AsyncSnapshot userList) {
            if (userList.data != null) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(4),
                    elevation: 8,
                    child: ListTile(
                      title: Text(
                        userList.data[index]["username"],
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        userList.data[index]["email"],
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      trailing: PopupMenuButton<_MenuValues>(
                          itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            child: Text('page2'),
                            value: _MenuValues.page2,
                          ),
                          PopupMenuItem(
                              child: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () =>
                                      deletedData(userList.data[index]["id"]))),
                        ];
                      }),
                    ),
                  );
                },
                itemCount: userList.data.length,
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: showUserDialog, child: Icon(Icons.add)),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
      )),
    );
  }
}
