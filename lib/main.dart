import 'package:flutter/material.dart';
import 'models/order_model.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/customer/create_order_screen.dart';
import 'screens/customer/customer_home_screen.dart';
import 'screens/customer/order_details_screen.dart';
import 'screens/customer/track_delivery_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const DeliveryTrackingApp());
}

class DeliveryTrackingApp extends StatelessWidget {
  const DeliveryTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery Tracking System',
      theme: AppTheme.lightTheme,
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => const SplashScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/customer_home': (_) => const CustomerHomeScreen(),
        '/create_order': (_) => const CreateOrderScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/order_details' &&
            settings.arguments is OrderModel) {
          return MaterialPageRoute(
            builder: (_) => OrderDetailsScreen(
              order: settings.arguments! as OrderModel,
            ),
            settings: settings,
          );
        }
        if (settings.name == '/track_delivery' &&
            settings.arguments is OrderModel) {
          return MaterialPageRoute(
            builder: (_) => TrackDeliveryScreen(
              order: settings.arguments! as OrderModel,
            ),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}