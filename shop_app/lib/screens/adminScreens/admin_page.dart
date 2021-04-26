import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/user.dart' as user;

import 'package:shop_app/provider/userProvider.dart';
import 'package:shop_app/screens/adminScreens/userDetailScreen_admin.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<User>(context).getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        List<user.User> _user = snapshot.data as List<user.User>;
        return ListView.builder(
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Dismissible(
              key: Key(_user[index].email),
              child: Card(
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        UserDetailScreenAdmin.routeName,
                        arguments: _user[index].id);
                  },
                  tileColor: _user[index].role == 0
                      ? Colors.yellow
                      : Colors.lightGreen,
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(
                    '${_user[index].firstname} ${_user[index].lastname}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: Text(
                    _user[index].role == 0 ? 'Seller' : 'Buyer',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ),
            ),
          ),
          itemCount: _user.length,
        );
      },
    );
  }
}
