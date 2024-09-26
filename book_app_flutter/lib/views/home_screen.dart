import 'package:book_app_flutter/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:book_app_flutter/widgets/featured_books.dart';
import 'package:book_app_flutter/widgets/action_buttons.dart';
import 'package:book_app_flutter/widgets/nav_bar.dart';
import 'package:book_app_flutter/widgets/new_released_books.dart';
import 'package:book_app_flutter/widgets/popular_authors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; //index for the Favorites screen
  int _notificationCount = 5;


  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    }); //Setting state to navigate b/n navbar links
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ashewa Library',
          style: TextStyle(fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            //menu button action here
          },
        ),
        actions: [
          user.token != null
              ? Row(
                children: [
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications),
                        onPressed: () {
                          setState(() {
                            _notificationCount = 0; // Clear notification count on tap
                          });
                        },
                      ),
                      if (_notificationCount > 0) // Only show badge if count > 0
                        Positioned(
                          right: 9,
                          top: 11,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '$_notificationCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(2, 8, 8, 8),
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
                        },
                      ),
                    ),  
                ],
              )
              : TextButton.icon(
                  icon: const Icon(
                    Icons.login,
                    color: Colors.white,
                    size: 16,
                  ),
                  label: const Text('Log In',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                ),
        ],
        backgroundColor: const Color.fromARGB(255, 1, 44, 80),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Action buttons (Sign Up, Log In and Search)
            const ActionButtons(),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, '/maps');
            }, child: const Text('Find Bookstores')),
            const SizedBox(height: 32.0),
            // Featured Books Section
            const FeaturedBooks(),
            const SizedBox(height: 32.0),
            // New Released Books Section
            const NewReleasedBooks(),
            const SizedBox(height: 32.0),
            //Popular Authors Section
            const PopularAuthors(),
            const SizedBox(height: 12.0),
          ],
        ),
      )),
      bottomNavigationBar: Navbar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}
