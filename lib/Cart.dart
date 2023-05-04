import 'package:flutter/material.dart';
import 'Canteen_page.dart';

class CartPage extends StatelessWidget {
  final Map<CanteenItem, int> cartItems;

  CartPage({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    for (CanteenItem item in cartItems.keys) {
      totalPrice += item.price * cartItems[item]!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems.keys.toList()[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('\₹${item.price}'),
                  trailing: Text('x${cartItems[item]}'),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total:'),
                Text('\₹$totalPrice'),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Clear the cart and go back to the Canteen page
              Navigator.pop(context);
            },
            child: Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
