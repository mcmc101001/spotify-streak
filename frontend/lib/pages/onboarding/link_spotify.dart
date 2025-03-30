import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_streak/helpers/fetcher.dart';
import 'package:spotify_streak/main.dart';

class LinkSpotifyPage extends StatefulWidget {
  const LinkSpotifyPage({super.key});

  @override
  State<LinkSpotifyPage> createState() => _LinkSpotifyPageState();
}

class _LinkSpotifyPageState extends State<LinkSpotifyPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _linkSpotify() async {
    final token = supabase.auth.currentSession?.accessToken;
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not logged in'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String apiUrl = dotenv.env['BACKEND_URL'] ?? "";
    await Fetcher.fetchWithAuth('$apiUrl/link-spotify', token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Link spotify')),
      body: Center(
        child: ElevatedButton(
          onPressed: _linkSpotify,
          child: const Text('Link spotify account'),
        ),
      ),
    );
  }
}
