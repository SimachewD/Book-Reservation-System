import 'package:book_app_flutter/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Navbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const Navbar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'My Reservations',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
      ],
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        onTap(user.token!=null ? index : 0); // Update the index when an item is tapped
        // Handle navigation
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/');
            break;
          case 1:
            user.token!=null
            ? Navigator.pushNamed(context, '/reservations',)
            : Navigator.pushNamed(context, '/signin', arguments: '/reservations');
            break;
          case 2:
            user.token!=null
            ? Navigator.pushNamed(context, '/favorites')
            : Navigator.pushNamed(context, '/signin', arguments: '/favorites');
            break;
        }
      },
      backgroundColor: Colors.white,
    );
  }
}
