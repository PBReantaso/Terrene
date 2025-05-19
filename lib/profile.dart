import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';
import 'storyscreens.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = 'Guest';
  String _userEmail = '';
  String _profileImage = 'assets/profile.jpg';
  int _totalRuns = 0;
  int _totalTime = 0;
  int _totalCalories = 0;
  int _achievements = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadStats();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userEmail = prefs.getString('user_email') ?? '';
      _userName = _userEmail.split('@').first;
    });
  }

  Future<void> _loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    final runs = prefs.getStringList('runs') ?? [];
    int totalTime = 0;
    int totalCalories = 0;

    for (final run in runs) {
      try {
        final runData = Map<String, dynamic>.from(
          Map.fromEntries(
            run.substring(1, run.length - 1).split(', ').map((e) {
              final parts = e.split(': ');
              return MapEntry(
                parts[0].trim(),
                parts[1].trim().replaceAll("'", ""),
              );
            }),
          ),
        );

        totalTime += int.parse(runData['duration'] ?? '0');
        totalCalories += int.parse(runData['calories'] ?? '0');
      } catch (e) {
        print('Error parsing run data: $e');
      }
    }

    setState(() {
      _totalRuns = runs.length;
      _totalTime = totalTime;
      _totalCalories = totalCalories;
      _achievements = (_totalRuns / 10).floor(); // Simple achievement calculation
    });
  }

  Future<void> _handleLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  String _formatTime(int seconds) {
    final hours = (seconds / 3600).floor();
    return '${hours}h';
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = const Color(0xFFAED9A3);
    final darkGreen = const Color(0xFF204B3A);
    final orange = const Color(0xFFF57C1F);
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Profile Header Card
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: Color(0xFF84A175),
                          borderRadius: BorderRadius.circular(cardRadius),
                          border: Border.all(color: Color(0xFF9DC08B), width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(_profileImage),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _userName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _userEmail,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Stats Section Title
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: [
                          const Text(
                            'Your Stats',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: Text('View All', style: TextStyle(color: orange, fontWeight: FontWeight.bold, fontSize: 13)),
                          ),
                        ],
                      ),
                    ),

                    // Stats Cards
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(cardRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  _StatCard(
                                    icon: Icons.directions_run,
                                    value: _totalRuns.toString(),
                                    label: 'Total Runs',
                                    color: cardColor,
                                  ),
                                  const SizedBox(width: 16),
                                  _StatCard(
                                    icon: Icons.timer,
                                    value: _formatTime(_totalTime),
                                    label: 'Time Spent',
                                    color: cardColor,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  _StatCard(
                                    icon: Icons.emoji_events,
                                    value: _achievements.toString(),
                                    label: 'Achievements',
                                    color: cardColor,
                                  ),
                                  const SizedBox(width: 16),
                                  _StatCard(
                                    icon: Icons.local_fire_department,
                                    value: _totalCalories.toString(),
                                    label: 'Calories',
                                    color: cardColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Settings Section Title
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: Row(
                        children: [
                          const Text(
                            'Settings',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    // Settings Cards
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(cardRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _SettingsCard(
                                icon: Icons.person_outline,
                                title: 'Edit Profile',
                                onTap: () {
                                  // TODO: Implement edit profile
                                },
                                color: cardColor,
                              ),
                              _SettingsCard(
                                icon: Icons.notifications_outlined,
                                title: 'Notifications',
                                onTap: () {
                                  // TODO: Implement notifications settings
                                },
                                color: cardColor,
                              ),
                              _SettingsCard(
                                icon: Icons.privacy_tip_outlined,
                                title: 'Privacy',
                                onTap: () {
                                  // TODO: Implement privacy settings
                                },
                                color: cardColor,
                              ),
                              _SettingsCard(
                                icon: Icons.help_outline,
                                title: 'Help & Support',
                                onTap: () {
                                  // TODO: Implement help & support
                                },
                                color: cardColor,
                              ),
                              _SettingsCard(
                                icon: Icons.logout,
                                title: 'Logout',
                                onTap: _handleLogout,
                                color: cardColor,
                                isLogout: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _DashboardNavBarBig(darkGreen: darkGreen, lightGreen: cardColor),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: Colors.black87),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color color;
  final bool isLogout;

  const _SettingsCard({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.color,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: isLogout ? Colors.red : Colors.black87,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isLogout ? Colors.red : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right,
                color: isLogout ? Colors.red : Colors.black87,
              ),
            ],
          ),
        ),
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
        color: Color(0xFF9DC08B),
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
            child: Icon(Icons.receipt_long, size: 40, color: const Color(0xFF1B4D3E)),
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
            child: Icon(Icons.person, size: 40, color: Colors.white),
          ),
        ],
      ),
    );
  }
} 