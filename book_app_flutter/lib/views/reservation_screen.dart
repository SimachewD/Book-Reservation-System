import 'package:book_app_flutter/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:book_app_flutter/widgets/nav_bar.dart';
import 'package:book_app_flutter/widgets/reserved_books.dart'; // Replace with actual imports
import 'package:book_app_flutter/widgets/pending_books.dart'; // Add actual imports
import 'package:book_app_flutter/widgets/purchased_books.dart';
import 'package:provider/provider.dart'; // Add actual imports

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  String _selectedState = 'Reserved';

  void _selectState(String state) {
    setState(() {
      _selectedState = state;
    });
  }

int _currentIndex = 1;

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
        title: const Text('My Reservations', style: TextStyle(fontSize: 18),),
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
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 1, 44, 80),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStateButton(context, "Reserved"),
                  _buildStateButton(context, "Pending"),
                  _buildStateButton(context, "Purchased"),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: _getBooksWidget(),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Navbar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
      ),
    );
  }

  // Helper method to create state buttons
  Widget _buildStateButton(BuildContext context, String label) {
    final isSelected = _selectedState == label;
    return TextButton(
      onPressed: () => _selectState(label),
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.transparent,
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper method to get the appropriate books widget
  Widget _getBooksWidget() {
    switch (_selectedState) {
      case 'Pending':
        return const PendingBooks(); 
      case 'Purchased':
        return const PurchasedBooks(); 
      case 'Reserved':
      default:
        return const ReservedBooks();
    }
  }
}
