import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<String> cartItems = [];

  void addToCart(String item) {
    setState(() {
      cartItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 138, 170),
        title: const Text('Product List'),
      ),
      body: ListView(
        children: <Widget>[
          ProductItem(
            itemName: 'Apple',
            onAddToCart: addToCart,
          ),
          ProductItem(
            itemName: 'Banana',
            onAddToCart: addToCart,
          ),
          ProductItem(
            itemName: 'Grapes',
            onAddToCart: addToCart,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 233, 138, 170),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShoppingCartScreen(cartItems: cartItems),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String itemName;
  final Function(String) onAddToCart;

  const ProductItem({
    Key? key,
    required this.itemName,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(itemName),
      trailing: ElevatedButton(
        onPressed: () {
          onAddToCart(itemName);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color.fromARGB(255, 233, 138, 170),
          ),
        ),
        child: const Text('Add to Cart'),
      ),
    );
  }
}

class ShoppingCartScreen extends StatefulWidget {
  final List<String> cartItems;

  const ShoppingCartScreen({Key? key, required this.cartItems})
      : super(key: key);

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  void _removeItem(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.cartItems[index]} removed from cart.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 138, 170),
        title: const Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.cartItems[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _removeItem(index);
              },
            ),
          );
        },
      ),
    );
  }
}
