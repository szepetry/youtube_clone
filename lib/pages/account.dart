import 'package:flutter/material.dart';
import '../authentication/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../authentication/auth.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  String email, displayName, uid, photoURL;

  void getUserDetails() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('${user.uid}')
        .get()
        .then((value) {
      setState(() {
        email = value.data()['email'];
        displayName = value.data()['displayName'];
        uid = value.data()['uid'];
        photoURL = value.data()['photoURL'];
      });
    });
  }

    BoxDecoration _buildBottomBorder() => BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      );

      Widget _buildPersonal(BuildContext context) {
    List<Map> items = [
      {"name": "Your channel", "icon": Icon(Icons.account_box)},
      {
        "name": "YouTube Studio",
        "icon": Icon(Icons.subscriptions),
      },
      {"name": "Time watched", "icon": Icon(Icons.access_time)},
      {"name": "Paid memberships", "icon": Icon(Icons.monetization_on)},
      {
        "name": "Switch account",
        "icon": Icon(Icons.supervisor_account),
      },
      {
        "name": "Turn on Incognito",
        "icon": Icon(Icons.settings_input_composite),
      },
      {
        "name": "Your data in YouTube",
        "icon": Icon(Icons.portrait),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: _buildBottomBorder(),
      child: Column(
        children: items
            .map((i) => ListTile(
                  leading: i["icon"],
                  title: i["extra"] == null
                      ? Text(i["name"])
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(i["name"]),
                            Container(
                              margin: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                i["extra"],
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                          ],
                        ),
                ))
            .toList(),
      ),
    );
  }

 Widget _buildExtras(BuildContext context) {
    List<Map> items = [
      {"name": "Settings", "icon": Icon(Icons.settings)},
      {
        "name": "Help & feedback",
        "icon": Icon(Icons.help),
      },
      // {"name": "Sign out", "icon": Icon(Icons.exit_to_app)},
    ];

    return Container(
      padding: const EdgeInsets.all(8.0),
      // decoration: _buildBottomBorder(),
      child: Column(
        children: items
            .map((i) => ListTile(
                  leading: i["icon"],
                  title: i["extra"] == null
                      ? Text(i["name"])
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(i["name"]),
                            Container(
                              margin: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                i["extra"],
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                          ],
                        ),
                ))
            .toList(),
      ),
    );
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: email != null?
      ListView(
        children: [
          ListTile(
            leading: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipOval(
                          child: Image.network(
                        photoURL,
                        fit: BoxFit.fill,
                      )),
                    ),
                    title: Row(
                      children: [
                        Text(displayName),
                        // Spacer(flex:4),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    ),
                    subtitle: Text(email),
                    
          ),
          Padding(
            padding: const EdgeInsets.only(left:88.0),
            child: Text("Manage your Google Account", style: TextStyle(color: Colors.blue),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(color: Colors.grey[600],),
          ),
          _buildPersonal(context),
          _buildExtras(context),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: InkWell(
              onTap: (){
                AuthService().signOut();
                Navigator.pushReplacementNamed(context, "/");
              },
                          child: ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text("Sign out")
                    ),
            ),
          ),
        ],
      ):Center(child: CircularProgressIndicator())
    );
  }
}