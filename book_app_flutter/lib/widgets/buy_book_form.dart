import 'package:book_app_flutter/models/book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> showBuyBookModal(BuildContext context, Book book) async {
  final _formKey = GlobalKey<FormState>();
  String status = 'purchased';
  String dueDate = '';
  String paymentMethod = 'Credit Card'; // Default payment method

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final response = await http.post(
          Uri.parse('https://your-server-url.com/api/userbooks'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'status': status,
            'dueDate': dueDate,
            'paymentMethod': paymentMethod, // Add payment method to the request
          }),
        );

        if (response.statusCode == 201) {
          // Success
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User book added successfully')));
        } else {
          // Error
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to add user book')));
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $error')));
      }
    }
  }

  showModalBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Total Price: \$10.00', // You can update this to a dynamic value
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Select Payment Method',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => paymentMethod = 'Credit Card'),
                      child: Column(
                        children: [
                          Icon(
                            Icons.credit_card,
                            size: 40,
                            color: paymentMethod == 'Credit Card' ? Colors.blue : Colors.grey,
                          ),
                          const Text('Credit Card'),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => paymentMethod = 'PayPal'),
                      child: Column(
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            size: 40,
                            color: paymentMethod == 'PayPal' ? Colors.blue : Colors.grey,
                          ),
                          const Text('PayPal'),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => paymentMethod = 'Bank Transfer'),
                      child: Column(
                        children: [
                          Icon(
                            Icons.account_balance,
                            size: 40,
                            color: paymentMethod == 'Bank Transfer' ? Colors.blue : Colors.grey,
                          ),
                          const Text('Bank Transfer'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 1, 62, 112),
                    foregroundColor: Colors.white
                    ),
                  onPressed: _submitForm,
                  child: const Text('Purchase'),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
