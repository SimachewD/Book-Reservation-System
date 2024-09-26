import 'package:book_app_flutter/providers/auth_provider.dart';
import 'package:book_app_flutter/widgets/book_store_map.dart';
import 'package:flutter/material.dart';
import 'package:book_app_flutter/views/favorite_screen.dart';
import 'package:book_app_flutter/views/home_screen.dart';
import 'package:book_app_flutter/views/reservation_screen.dart';
import 'package:book_app_flutter/views/sign_in_screen.dart';
import 'package:book_app_flutter/views/sign_up_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context)=>AuthProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Books',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context)=>const HomeScreen(),
        '/signin': (context)=> const SignInPage(),
        '/signup': (context)=>const SignUpPage(),
        '/reservations': (context)=>const ReservationScreen(),
        '/favorites': (context)=>const FavoriteScreen(),
        '/maps': (context)=>const BookStoreMap(),

      },
    );
  }
}
