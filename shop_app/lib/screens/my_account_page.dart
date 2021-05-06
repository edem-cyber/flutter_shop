import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/provider/userProvider.dart';

class MyAccountPage extends StatefulWidget {
  static const routeName = '/my-account';

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  var isLoading = false;
  GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    var provider = Provider.of<User>(context, listen: false);
    if (provider.currUser['email'] == '') {
      setState(() {
        isLoading = true;
      });
      provider.getMyDetail().then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var details = Provider.of<User>(context).currUser;
    return Scaffold(
        appBar: AppBar(
          title: Text('My Account'),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                constraints: BoxConstraints(maxWidth: 960),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Form(
                  child: Column(
                    children: [
                      CircleAvatar(
                        maxRadius: 75,
                        minRadius: 50,
                        child: Icon(
                          Icons.person_rounded,
                          size: 60,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        enabled: false,
                        initialValue: details['email'],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        style: TextStyle(color: Colors.grey),
                        enableInteractiveSelection: false,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        initialValue: details['firstname'],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            prefixIcon: Icon(Icons.person_outline),
                            labelText: 'First Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field cannot be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        initialValue: details['lastname'],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            prefixIcon: Icon(Icons.person_outline),
                            labelText: 'Last Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field cannot be empty";
                          }
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        initialValue: details['address'],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            prefixIcon: Icon(Icons.home_outlined),
                            labelText: 'Primary Address'),
                        maxLines: 3,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        initialValue: details['phone'],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          prefixIcon: Icon(Icons.phone),
                          labelText: 'Mobile no.',
                        ),
                        validator: (value) {
                          if (value!.length < 10) {
                            return "Please enter a valid mobile number!";
                          }
                        },
                      )
                    ],
                  ),
                  key: _key,
                ),
              ),
        bottomNavigationBar: isLoading
            ? null
            : Container(
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.check),
                  label: Text('Submit'),
                ),
              ));
  }
}
