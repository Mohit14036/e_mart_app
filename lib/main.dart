import 'package:e_mart_app/providers/cart_items_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/auth_provider.dart';
import './providers/cart_provider.dart';
import './screens/auth/login_screen.dart';
import './screens/auth/signup_screen.dart';
import './screens/bottom_nav_screen.dart';
import './screens/home_screen.dart';
import './screens/product_list_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/profile_screen.dart';
import './screens/favorite_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import './models/product.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => CartItemsProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-Mart',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: StreamBuilder(
            stream: auth.userAuthStream, // Assuming you have a stream for user authentication
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show loading indicator while checking authentication state
              }
              if (snapshot.hasData) {
                return BottomNavScreen(); // If user is authenticated, show home screen
              }
              return LoginScreen(); // If user is not authenticated, show login screen
            },
          ),
          routes: {
            '/login': (ctx) => LoginScreen(),
            '/signup': (ctx) => SignUpScreen(),
            '/home': (ctx) => BottomNavScreen(),
            '/product-list': (ctx) => ProductListScreen('Category Title'),

            '/cart': (ctx) => CartScreen(),
            '/profile': (ctx) => ProfileScreen(),
            '/favorite': (ctx) => FavoriteScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/product-detail') {
              final product = settings.arguments as Product;
              return MaterialPageRoute(
                builder: (ctx) => ProductDetailScreen(product: product),
              );
            }
            return null; // Let other routes be handled as per the normal flow
          },
        ),
      ),

    );

  }
}
