import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shop_app/screens/add_product_screen.dart';

import 'package:shop_app/screens/mainPage.dart';
import 'package:shop_app/widgets/custom_app_drawer.dart';
import 'package:shop_app/widgets/product_grid.dart';
import 'package:shop_app/provider/productProvider.dart';

class HomePage extends StatefulWidget {
  final ScreenSize size;
  final Size screenSize;
  HomePage(this.size, this.screenSize);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isLoading = false;
  var role = 0;
  List<String> _categories = [
    "All",
    "Grocery",
    "Mobiles",
    "Fashion",
    "Electronics",
    "Home",
    "Appliances",
    "Beauty, Toy & More",
  ];
  var selected = "";
  var sort = -1;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<ProductProvider>(context, listen: false)
        .getProducts()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isLoading
          ? null
          : AppBar(
              title: Text(
                'FlutterStore',
                style: Theme.of(context).textTheme.headline6,
              ),
              bottomOpacity: 1,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.shopping_bag_outlined),
                  onPressed: () {},
                ),
                if (role == 0)
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AddProductScreen.routeName);
                    },
                  )
              ],
            ),
      drawer: CustomDrawer(role),
      body: HawkFabMenu(
        fabColor: Theme.of(context).accentColor,
        body: Container(
          padding: const EdgeInsets.only(top: 8),
          child: Center(
            child: _isLoading
                ? CircularProgressIndicator()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 50,
                        width: widget.screenSize.width,
                        child: ListView.builder(
                          itemBuilder: (context, index) => Card(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (index == 0) {
                                    selected = "";
                                  } else {
                                    selected = _categories[index];
                                  }
                                });
                              },
                              child: Container(
                                constraints: widget.size == ScreenSize.small
                                    ? null
                                    : BoxConstraints(minWidth: 200),
                                child: Center(
                                  child: Text(
                                    _categories[index],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.raleway(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                              ),
                            ),
                          ),
                          itemCount: _categories.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Expanded(
                        child: ProductGrid(
                            widget.size, widget.screenSize, selected, sort),
                      ),
                    ],
                  ),
          ),
        ),
        items: [
          HawkFabMenuItem(
            label: 'Price: High to Low',
            ontap: () {
              setState(() {
                sort = 0;
              });
            },
            icon: Icon(Icons.arrow_upward),
            labelColor: Colors.white,
            labelBackgroundColor: Colors.blue,
          ),
          HawkFabMenuItem(
            label: 'Price: Low to High',
            ontap: () {
              setState(() {
                sort = 1;
              });
            },
            icon: Icon(Icons.arrow_downward),
            color: Theme.of(context).accentColor,
            labelColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
