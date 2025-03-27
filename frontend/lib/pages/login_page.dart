import 'package:flutter/material.dart';
import 'package:spotify_streak/main.dart';
import 'package:spotify_streak/pages/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    _setupAuthListener();
    super.initState();
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    });
  }

  Future<void> _spotifySignIn() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.spotify,
      scopes: 'user-read-recently-played',
      redirectTo:
          kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
      authScreenLaunchMode:
          kIsWeb
              ? LaunchMode.platformDefault
              : LaunchMode
                  .externalApplication, // Launch the auth screen in a new webview on mobile.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: _spotifySignIn,
          child: const Text('Login with Spotify'),
        ),
      ),
    );
  }
}
