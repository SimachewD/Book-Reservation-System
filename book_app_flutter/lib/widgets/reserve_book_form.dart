import 'package:book_app_flutter/models/book.dart';
import 'package:book_app_flutter/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// import 'package:provider/provider.dart';

Future<void> showReserveBookModal(
    BuildContext context, String userId, String token, Book book) async {
  // final user = Provider.of<AuthProvider>(context);

  final formKey = GlobalKey<FormState>();
  DateTime? dueDate; // Use DateTime for the due date
  bool showDateError = false; // To show error if date is not selected on submit
  bool isLoading = false;

  Future<void> submitForm(StateSetter setState) async {
    // Validate form and check if due date is selected
    if (formKey.currentState!.validate()) {
      if (dueDate == null) {
        setState(() {
          showDateError = true; // Show red error message
        });
      } else {
        formKey.currentState!.save();
        try {
          setState(() {
            isLoading = true;
          });
          await BookService.reserveBook(book.id, userId, token, dueDate!);
          // Success
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Reservation made successfully')));
          Navigator.pop(context); // Close the modal after success
        } catch (error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error: $error')));
        } finally{
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  Future<void> selectDueDate(BuildContext context, StateSetter setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Disable past dates
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dueDate) {
      setState(() {
        dueDate = picked; // Update selected date
        showDateError = false; // Hide error when a date is selected
      });
    }
  }

  showModalBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                ListTile(
                  title: Text(
                    dueDate == null
                        ? 'Select Due Date'
                        : 'Due Date: ${DateFormat('yyyy-MM-dd').format(dueDate!)}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () => selectDueDate(context, setState),
                ),
                // Show error message if date is not selected when form is submitted
                if (showDateError)
                  const Text(
                    'Please select a due date',
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 1, 62, 112),
                    foregroundColor: Colors.white
                    ),
                  onPressed: isLoading ==true ? null : () => submitForm(setState),
                  child: isLoading == true ? const CircularProgressIndicator() : const Text('Send Request'),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
