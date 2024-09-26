import 'package:book_app_flutter/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:book_app_flutter/widgets/favorite_books.dart';
import 'package:book_app_flutter/widgets/nav_bar.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _currentIndex = 2; // Set this index for the Favorites screen

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Implement your menu button action here
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                user.logout();
                Navigator.pushNamed(context, '/');
              },
            ),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 1, 44, 80),
        foregroundColor: Colors.white,
      ),
      body: const SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child:
            FavoriteBooks(), // Directly use FavoriteBooks without scroll view
      )),
      bottomNavigationBar: Navbar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}
