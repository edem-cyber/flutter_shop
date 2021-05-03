import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/HttpException.dart';
import 'package:shop_app/models/order.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/user.dart' as user;
import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/provider/productProvider.dart';
import 'package:shop_app/provider/userProvider.dart';
import 'package:shop_app/widgets/adminUserDetailProduct.dart';

class UserDetailScreenAdmin extends StatefulWidget {
  static const routeName = "/user-detail-admin";

  @override
  _UserDetailScreenAdminState createState() => _UserDetailScreenAdminState();
}

class _UserDetailScreenAdminState extends State<UserDetailScreenAdmin> {
  late String userId;
  late user.User _user;
  late List<Product> product = [];
  late List<Order> order = [];
  bool init = false;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (!init) {
      userId = ModalRoute.of(context)?.settings.arguments as String;
      _user = Provider.of<User>(context, listen: false).findById(userId);
      product = Provider.of<ProductProvider>(context).findBySeller(userId);
      Provider.of<Cart>(context, listen: false).getOrder().then((value) {
        setState(() {
          init = true;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // print(product.length);
    order = Provider.of<Cart>(context).orders;
    print(order);
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
                return AdminUserDetailProduct(e: e);
              }).toList(),
              Text(
                "Orders",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? null
                          : Colors.black,
                      fontSize: 24,
                    ),
              ),
              ...order.map((e) {
                return Text(e.id);
              }).toList()
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
