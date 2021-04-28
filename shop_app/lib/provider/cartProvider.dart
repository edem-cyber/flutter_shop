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

  int get total {
    int total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String pId, int price, String title, String image) {
    if (_items.containsKey(pId)) {
      _items.update(
        pId,
        (value) => CartItem(
            id: value.id,
            price: value.price,
            image: value.image,
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
          image: image,
          quantity: 1,
          title: title,
        ),
      );
      _ps.add(pId);
      _q.add(1);
    }
    notifyListeners();
  }

  void remove(String id) {
    _items.remove(id);
    var index = _ps.indexWhere((element) => element == id);
    _ps.removeAt(index);
    _q.removeAt(index);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) return;
    if (_items[id]!.quantity > 1) {
      _items.update(
        id,
        (value) => CartItem(
          id: value.id,
          price: value.price,
          image: value.image,
          quantity: value.quantity - 1,
          title: value.title,
        ),
      );
      var index = _ps.indexWhere((element) => element == id);
      _q[index] -= 1;
    } else {
      remove(id);
    }
    notifyListeners();
  }
}
