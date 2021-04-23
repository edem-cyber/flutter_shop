import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 230,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://image.freepik.com/free-photo/dark-blue-background-with-spread-liquefy-flow_23-2148097614.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                  width: 20,
                ),
                Text(
                  'Hello There!',
                  style: GoogleFonts.poppins(fontSize: 24, color: Colors.white),
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}
