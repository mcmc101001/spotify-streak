import 'package:flutter/material.dart';
import 'package:spotify_streak/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Flutter',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.green),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
        ),
      ),
      home: LoginPage(),

      // FutureBuilder<bool>(
      //   future: _checkAuthCodeStatus(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Scaffold(
      //         body: Center(child: CircularProgressIndicator()),
      //       );
      //     }

      //     if (snapshot.hasError) {
      //       return const Scaffold(
      //         body: Center(child: Text('Please verify your email')),
      //       );
      //     }

      //     if (snapshot.data == true) {
      //       return const HomePage();
      //     } else if (supabase.auth.currentSession != null) {
      //       return const LinkSpotifyPage();
      //     } else {
      //       return const LoginPage();
      //     }
      //   },
      // ),
    );
  }

  // Future<bool> _checkAuthCodeStatus() async {
  //   try {
  //     // Fetch the current user
  //     final user = supabase.auth.currentUser;
  //     if (user == null) return false;

  //     // Fetch the user's profile
  //     final response =
  //         await supabase
  //             .from('profiles')
  //             .select('auth_code')
  //             .eq('id', user.id)
  //             .single();

  //     // Return true if auth_code is not null
  //     return response['auth_code'] != null;
  //   } catch (e) {
  //     print('Error checking auth code: $e');
  //     return false;
  //   }
  // }
}
