import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/order.dart';
import 'package:shop_app/provider/cartProvider.dart';

class MyOrderPage extends StatefulWidget {
  static const routeName = "/my-order-page";

  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  bool Loading = false;

  @override
  void initState() {
    setState(() {
      Loading = true;
    });
    Provider.of<Cart>(context, listen: false).getOrder().then((value) {
      setState(() {
        Loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Order> order = Provider.of<Cart>(context).orders;

    print(order);
    return Scaffold(
      appBar: AppBar(),
      body: Loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) =>
                  Text(order[index].dateTime.toString()),
              itemCount: order.length,
            ),
    );
  }
}
