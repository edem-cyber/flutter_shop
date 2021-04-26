import 'package:flutter/material.dart';
import 'package:shop_app/screens/adminScreens/userDetailScreen_admin.dart';
import 'package:shop_app/models/user.dart' as user;

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
