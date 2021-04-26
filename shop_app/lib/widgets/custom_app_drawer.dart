import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/authProvider.dart';

class CustomDrawer extends StatelessWidget {
  final int role;
  CustomDrawer(this.role);

  @override
  Widget build(BuildContext context) {
    Widget drawerHeader = Container(
      height: 230,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/app_drawer.jpg'),
            fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 40,
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Hello There!',
            style: GoogleFonts.poppins(fontSize: 24, color: Colors.white),
          ),
        ],
      ),
    );

    return Drawer(
      elevation: 60,
      child: Column(
        children: [
          drawerHeader,
          option(context, 'My Orders', Icons.shopping_bag, () {}),
          option(context, 'My Account', Icons.person, () {}),
          option(context, 'My Cart', Icons.shopping_cart, () {}),
          option(context, 'My Favorite', Icons.favorite, () {}),
          option(context, 'My Products', Icons.list, () {}),
          option(context, 'My Settings', Icons.settings, () {}),
          option(context, 'About Us', Icons.help_outline, () {}),
          option(context, 'Rate Us', Icons.star, () {}),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 24,
            ),
            title: Text(
              'Log out',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }

  ListTile option(
      BuildContext context, String name, IconData icon, Function function) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24,
      ),
      title: Text(
        name,
        style: GoogleFonts.poppins(fontSize: 14),
      ),
      onTap: function(),
    );
  }
}
