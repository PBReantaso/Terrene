import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'profile.dart';

class StoryScreens extends StatelessWidget {
  const StoryScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final darkGreen = const Color(0xFF84A175);
    final lightGreen = const Color(0xFF9DC08B);
    final cardRadius = 18.0;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/BG.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: SizedBox(
              height: size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Profile Row
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                    child: Row(
                      children: [
                        // Profile image
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: AssetImage('lib/assets/profile.jpg'),
                        ),
                        const SizedBox(width: 12),
                        // User name
                        Text(
                          'Christian Antonio',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1B4D3E),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        // Settings icon
                        IconButton(
                          icon: const Icon(Icons.settings, color: const Color(0xFF1B4D3E), size: 32),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  // Story Progress Card
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkGreen,
                        borderRadius: BorderRadius.circular(cardRadius),
                        border: Border.all(color: lightGreen, width: 4),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      alignment: Alignment.center,
                      child: const Text(
                        'Story Progress',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Expanded empty space
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                      children: [
                        _StoryCard(
                          imagePath: 'assets/world1.jpg',
                          title: 'Prologue',
                          subtitle: 'World 1',
                          statusWidget: Center(
                            child: Container(
                              width: 260,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Color(0xFFF57C1F),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'Completed',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _StoryCard(
                          imagePath: 'assets/world2.jpg',
                          title: 'The Unknown',
                          subtitle: 'World 2',
                          statusWidget: Center(
                            child: SizedBox(
                              width: 260,
                              height: 24,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: 0.75,
                                    child: Container(
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF57C1F),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '75%',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _StoryCard(
                          imagePath: 'assets/world3.jpg',
                          title: '',
                          subtitle: '',
                          statusWidget: const Icon(Icons.lock, size: 40, color: Color(0xFF1B4D3E)),
                          isLocked: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Navigation bar at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _DashboardNavBarBig(darkGreen: darkGreen, lightGreen: lightGreen),
          ),
        ],
      ),
    );
  }
}

class _DashboardNavBarBig extends StatelessWidget {
  final Color darkGreen;
  final Color lightGreen;
  const _DashboardNavBarBig({required this.darkGreen, required this.lightGreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: lightGreen,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => const DashboardScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            child: Icon(Icons.home, size: 40, color: const Color(0xFF1B4D3E)),
          ),
          Icon(Icons.bar_chart, size: 40, color: const Color(0xFF1B4D3E)),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => const StoryScreens(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            child: Icon(Icons.receipt_long, size: 40, color: Colors.white),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => const ProfileScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            child: Icon(Icons.person, size: 40, color: const Color(0xFF1B4D3E)),
          ),
        ],
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final Widget statusWidget;
  final bool isLocked;

  const _StoryCard({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.statusWidget,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    const double cardHeight = 130;
    return Container(
      height: cardHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Color(0xFF9DC08B), width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: ColorFiltered(
              colorFilter: isLocked
                  ? const ColorFilter.mode(Colors.black54, BlendMode.darken)
                  : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
              child: SizedBox(
                width: 120,
                height: cardHeight,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
              child: isLocked
                  ? Center(child: statusWidget)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1B4D3E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 16,
                            color: const Color(0xFF1B4D3E),
                          ),
                        ),
                        const SizedBox(height: 12),
                        statusWidget,
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
} 