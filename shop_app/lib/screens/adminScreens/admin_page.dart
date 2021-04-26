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
          itemBuilder: (context, index) => UserTile(user: _user[index]),
          itemCount: _user.length,
        );
      },
    );
  }
}

class UserTile extends StatelessWidget {
  const UserTile({
    Key? key,
    required user.User user,
  })   : _user = user,
        super(key: key);

  final user.User _user;

  @override
  Widget build(BuildContext context) {
    var userDetail = ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(UserDetailScreenAdmin.routeName, arguments: _user.id);
      },
      tileColor: _user.role == 0 ? Colors.yellow : Colors.lightGreen,
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        '${_user.firstname} ${_user.lastname}',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(
        _user.role == 0 ? 'Seller' : 'Buyer',
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
    return Dismissible(
      key: Key(_user.id),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: userDetail,
          ),
        ),
      ),
    );
  }
}
