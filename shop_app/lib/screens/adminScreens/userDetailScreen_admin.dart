import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/user.dart' as user;
import 'package:shop_app/provider/productProvider.dart';
import 'package:shop_app/provider/userProvider.dart';

class UserDetailScreenAdmin extends StatelessWidget {
  static const routeName = "/user-detail-admin";
  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)?.settings.arguments as String;
    user.User _user = Provider.of<User>(context).findById(userId);
    List<Product> product =
        Provider.of<ProductProvider>(context).findBySeller(userId);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "User information",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? null
                        : Colors.black,
                    fontSize: 28),
              ),
              UserInformation(
                heading: 'Email',
                value: _user.email,
              ),
              UserInformation(
                  heading: 'Name',
                  value: '${_user.firstname} ${_user.lastname}'),
              UserInformation(heading: 'Phone no.', value: _user.phoneNo ?? ''),
              UserInformation(heading: 'Address', value: _user.address ?? ''),
              Text(
                "Products",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? null
                        : Colors.black,
                    fontSize: 24),
              ),
              ...product.map((e) {
                return Card(
                  child: Dismissible(
                    key: Key(e.id),
                    direction: DismissDirection.startToEnd,
                    background: Container(
                      padding: const EdgeInsets.only(left: 30),
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.delete),
                      color: Colors.red,
                    ),
                    confirmDismiss: (direction) {
                      return showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Are you sure?'),
                          content: Text('Do you want to remove this item?'),
                          elevation: 20,
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                'No',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .deleteItem(e.id);
                                Navigator.of(context).pop(true);
                              },
                              child: Text('Yes',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor)),
                            )
                          ],
                        ),
                      );
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(4),
                      leading: CachedNetworkImage(
                        imageUrl: e.image,
                        height: 60,
                        width: 60,
                      ),
                      title: Text(
                        e.name,
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  ),
                );
              }).toList(),
              Text(
                "Orders",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? null
                        : Colors.black,
                    fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInformation extends StatelessWidget {
  const UserInformation({
    Key? key,
    required this.heading,
    required this.value,
  });

  final String heading;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$heading : ',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
