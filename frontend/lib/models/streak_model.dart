class StreakModel {
  String name;
  int streak;
  String userAvatarUrl;

  StreakModel({
    required this.name,
    required this.streak,
    required this.userAvatarUrl,
  });

  static List<StreakModel> getStreaks() {
    List<StreakModel> streaks = [];

    streaks.add(
      StreakModel(
        name: "Nicole",
        streak: 10,
        userAvatarUrl: "https://i.pravatar.cc/300",
      ),
    );

    streaks.add(
      StreakModel(
        name: "Wong",
        streak: 5,
        userAvatarUrl: "https://i.pravatar.cc/300",
      ),
    );

    return streaks;
  }
}
