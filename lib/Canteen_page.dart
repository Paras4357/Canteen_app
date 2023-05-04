import 'package:flutter/material.dart';
import 'package:untitled1/Cart.dart';

class CanteenItem {
  String name;
  double price;
  int quantity;

  CanteenItem({required this.name, required this.price, required this.quantity});
}
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


class CanteenPage extends StatefulWidget {
  const CanteenPage({Key? key}) : super(key: key);

  @override
  _CanteenPageState createState() => _CanteenPageState();
}

class _CanteenPageState extends State<CanteenPage> {
  final List<CanteenItem> _canteenItems = [
    CanteenItem(name: 'Burger', price: 35, quantity: 0),
    CanteenItem(name: 'Pizza', price: 70, quantity: 0),
    CanteenItem(name: 'Sandwich', price: 40, quantity: 0),
    CanteenItem(name: 'Fries', price: 40, quantity: 0),
    CanteenItem(name: 'Momos', price: 40, quantity: 0),
    CanteenItem(name: 'Patties', price: 30, quantity: 0),
    CanteenItem(name: 'Cold Coffee', price: 50, quantity: 0),
    CanteenItem(name: 'Maggie', price: 30, quantity: 0),
  ];
  final Map<CanteenItem, int> _cartItems = {};

  void _addItemToCart(CanteenItem item) {
    setState(() {
      if (_cartItems.containsKey(item)) {
        _cartItems[item] = _cartItems[item]! + 1;
      } else {
        _cartItems[item] = 1;
      }
    });
  }

  void _removeItemFromCart(CanteenItem item) {
    setState(() {
      if (_cartItems[item] == 1) {
        _cartItems.remove(item);
      } else {
        _cartItems[item] = _cartItems[item]! - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Canteen'),
      ),
      body: ListView.builder(
        itemCount: _canteenItems.length,
        itemBuilder: (context, index) {
          final item = _canteenItems[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('\₹${item.price}'),
            trailing: SizedBox(
              width: 120.0,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () => _removeItemFromCart(item),
                  ),
                  Text('${_cartItems[item] ?? 0}'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => _addItemToCart(item),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Map<CanteenItem, int> cartItems = {};
            for (CanteenItem item in _canteenItems) {
              if (item.quantity > 0) {
                cartItems[item] = item.quantity;
              }
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(cartItems: cartItems),
              ),
            );
          }
        },
        label: Text('Cart'),
        icon: Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}