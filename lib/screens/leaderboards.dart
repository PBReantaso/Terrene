import 'package:flutter/material.dart';

/* 
Authored by: Francis Dave A. Asico
Company: CSPCA
Project: Terrene
Feature: [TCM-06] Leaderboard
Description: Leaderboard screen to see whos on the top.
*/

class Leaderboards extends StatelessWidget {
  const Leaderboards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
                "Leaderboards",
                style: TextStyle(
                    color: Colors.white,
                ),
            ),
            backgroundColor: Color(0xFF23442F),
        ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF23442F),
          //borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 140,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    left: 30,
                    bottom: 0,
                    child: buildTopUser("Christian Bald...", 2, 39, "lib/assets/profile2.png"),
                  ),
                  Positioned(
                    top: 0,
                    child: buildTopUser("Christian Antonio", 1, 40, "lib/assets/profile1.png"),
                  ),
                  Positioned(
                    right: 30,
                    bottom: 0,
                    child: buildTopUser("Salvador N. R...", 3, 38, "lib/assets/profile3.png"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFF282A2C),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: ListView(
                  children: [
                    LeaderboardTile(rank: 4, name: "Francis Dave A. Asico", points: 37),
                    LeaderboardTile(rank: 5, name: "Philippe Bernard G. Reantaso", points: 37),
                    LeaderboardTile(rank: 6, name: "You", points: 37, isCurrentUser: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTopUser(String name, int rank, int points, String imagePath) {
    return Column(
      children: [
        CircleAvatar(
          radius: rank == 1 ? 40 : 30,
          backgroundImage: AssetImage(imagePath),
        ),
        const SizedBox(height: 6),
        Text(name, style: const TextStyle(color: Colors.white)),
        Text(
          "$points pts",
          style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class LeaderboardTile extends StatelessWidget {
  final int rank;
  final String name;
  final int points;
  final bool isCurrentUser;

  const LeaderboardTile({
    super.key,
    required this.rank,
    required this.name,
    required this.points,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrentUser ? const Color(0xFF4E6249) : Color(0xFF363739),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$rank", style: const TextStyle(color: Colors.white)),
          Expanded(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            "$points pts",
            style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}