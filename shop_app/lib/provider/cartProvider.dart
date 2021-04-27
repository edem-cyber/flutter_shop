import 'package:flutter/foundation.dart';
import 'package:shop_app/models/cart.dart';

class Cart with ChangeNotifier {
  final String _userId;
  Map<String, CartItem> _items = {};
  List<String> _ps = [];
  List<int> _q = [];

  Cart(this._userId);

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String pId, int price, String title) {
    if (_items.containsKey(pId)) {
      _items.update(
        pId,
        (value) => CartItem(
            id: value.id,
            price: value.price,
            quantity: value.quantity + 1,
            title: value.title),
      );
      var index = _ps.indexWhere((element) => element == pId);
      _q[index] += 1;
    } else {
      _items.putIfAbsent(
        pId,
        () => CartItem(
          id: pId,
          price: price,
          quantity: 1,
          title: title,
        ),
      );
      _ps.add(pId);
      _q.add(1);
    }
    notifyListeners();
  }
}
