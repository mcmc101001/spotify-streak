import 'package:flutter/material.dart';
import 'package:spotify_streak/main.dart';
import 'package:spotify_streak/pages/home.dart';
import 'package:spotify_streak/pages/onboarding/link_spotify.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    supabase.auth.onAuthStateChange.listen(
      (data) async {
        final event = data.event;

        if (event == AuthChangeEvent.signedIn) {
          if (!mounted) return; // Ensure widget is still in the tree

          final user = supabase.auth.currentUser;
          if (user == null) return; // Ensure user is not null
          final response =
              await supabase
                  .from('profiles')
                  .select('''
                    auth_code
                  ''')
                  .eq('id', user.id)
                  .single();

          bool isAuthCodePresent = response['auth_code'] != null;

          Widget nextPage =
              isAuthCodePresent ? const HomePage() : const LinkSpotifyPage();

          if (mounted) {
            // Double-check before navigating
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => nextPage),
            );
          }
        }
      },
      onError: (error) {
        if (error is AuthException &&
            error.statusCode == "provider_email_needs_verification") {
          if (!mounted) return; // Ensure widget is still in the tree

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please verify your email!'),
              backgroundColor: Colors.red,
              duration: Durations.extralong4,
            ),
          );
        }
      },
    );
  }

  Future<void> _spotifySignIn() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.spotify,
      scopes: 'user-read-recently-played',
      redirectTo: 'io.supabase.flutterquickstart://login-callback/',
      authScreenLaunchMode: LaunchMode.externalApplication,
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
