import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  final List<String> _cartItems = [];

  void _addItemToCart(String item) {
    setState(() {
      _cartItems.add(item);
    });
  }

  Widget _buildCartContents() {
    if (_cartItems.isEmpty) {
      return const Text('Your cart is empty.');
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your cart contains:'),
          for (var item in _cartItems)
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(item),
            ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCartContents(),
        ElevatedButton(
          onPressed: () => _addItemToCart('Example item'),
          child: const Text('Add item to cart'),
        ),
      ],
    );
  }
}