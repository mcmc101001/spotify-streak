import 'package:flutter/material.dart';
import 'package:spotify_streak/main.dart';
import 'package:spotify_streak/pages/login_page.dart';
import 'package:spotify_streak/models/streak_model.dart';

// Future<void> _signOut() async {
//   await supabase.auth.signOut();
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<StreakModel> streaks = [];

  void _getStreaks() {
    streaks = StreakModel.getStreaks();
  }

  @override
  void initState() {
    super.initState();
    _getStreaks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Spotify Streaks',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            bottom: TabBar(
              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              tabs: [Tab(child: Text("Friends")), Tab(child: Text("Artistes"))],
            ),
          ),
          body: TabBarView(
            children: [FriendStreaks(streaks: streaks), Placeholder()],
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () async {
          //     await _signOut();
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(builder: (context) => const LoginPage()),
          //     );
          //   },
          //   child: Icon(Icons.logout),
          // ),
        ),
      ),
    );
  }
}

class FriendStreaks extends StatelessWidget {
  const FriendStreaks({super.key, required this.streaks});

  final List<StreakModel> streaks;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      itemCount: streaks.length,
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemBuilder: (context, index) {
        return Container(
          height: 70,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(streaks[index].userAvatarUrl),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        streaks[index].name,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Last Listened to Taylor Swift",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.local_fire_department,
                    size: 30,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    streaks[index].streak.toString(),
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
