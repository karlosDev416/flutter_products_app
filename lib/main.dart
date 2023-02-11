import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_products_app/screens/screens.dart';
import 'package:flutter_products_app/services/services.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsService())
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Products App',
      initialRoute: 'home',
      routes: {
        'login': (_) => LoginScreen(),
        'home': (_) => HomeScreen(),
        'product': (_) => ProductScreen()
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              elevation: 0, backgroundColor: Colors.indigo),
          appBarTheme: AppBarTheme(elevation: 0, color: Colors.indigo)),
    );
  }
}
