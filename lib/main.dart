import 'package:flutter/material.dart';
import 'package:maawnonton/providers/movies_provider.dart';
import 'package:maawnonton/providers/search_provider.dart';
import 'package:maawnonton/ui/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Maawnonton',
        home: HomePage(),
      ),
    );
  }
}
