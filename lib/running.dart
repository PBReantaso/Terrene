import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RunningScreen extends StatefulWidget {
  const RunningScreen({super.key});

  @override
  State<RunningScreen> createState() => _RunningScreenState();
}

class _RunningScreenState extends State<RunningScreen> {
  Duration runningTime = Duration.zero;
  double distance = 0.0;
  int calories = 0;
  double speed = 0.0;
  double avgSpeed = 0.0;
  Timer? _timer;

  LatLng? _userLocation;
  bool _locationError = false;
  final MapController _mapController = MapController();
  bool isRunning = false;
  StreamSubscription<Position>? _positionStream;
  List<LatLng> _route = [];
  double userWeightKg = 70.0;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _loadUserWeight();
  }

  Future<void> _loadUserWeight() async {
    final prefs = await SharedPreferences.getInstance();
    final savedWeight = prefs.getDouble('user_weight');
    if (savedWeight != null) {
      setState(() {
        userWeightKg = savedWeight;
      });
    }
  }

  void _toggleRun() {
    setState(() {
      isRunning = !isRunning;
    });
    if (isRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          runningTime += const Duration(seconds: 1);
          if (runningTime.inSeconds > 0) {
            avgSpeed = distance / (runningTime.inSeconds / 3600);
          }
        });
      });
      _positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: 2,
        ),
      ).listen((Position pos) {
        LatLng newPoint = LatLng(pos.latitude, pos.longitude);
        setState(() {
          if (_route.isNotEmpty) {
            final last = _route.last;
            final d = Geolocator.distanceBetween(
              last.latitude, last.longitude,
              newPoint.latitude, newPoint.longitude,
            );
            distance += d / 1000.0; // meters to km
            calories = (userWeightKg * distance * 1.036).round();
            speed = d / 1000.0 / (2 / 3600); // km per 2 seconds (distanceFilter)
          }
          _route.add(newPoint);
          _mapController.move(newPoint, _mapController.zoom);
        });
      });
    } else {
      _timer?.cancel();
      _positionStream?.cancel();
      _saveRunData();
    }
  }

  Future<void> _saveRunData() async {
    if (distance > 0) {
      final prefs = await SharedPreferences.getInstance();
      final runs = prefs.getStringList('runs') ?? [];
      final runData = {
        'date': DateTime.now().toIso8601String(),
        'distance': distance.toString(),
        'duration': runningTime.inSeconds.toString(),
        'calories': calories.toString(),
        'route': _route.map((p) => '${p.latitude},${p.longitude}').join('|'),
      };
      runs.add(runData.toString());
      await prefs.setStringList('runs', runs);
    }
  }

  Future<void> _getUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        setState(() => _locationError = true);
        return;
      }
      Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _userLocation = LatLng(pos.latitude, pos.longitude);
        _route = [_userLocation!];
      });
    } catch (e) {
      setState(() => _locationError = true);
    }
  }

  void _recenterMap() async {
    if (_userLocation == null) {
      await _getUserLocation();
    }
    if (_userLocation != null) {
      _mapController.move(_userLocation!, _mapController.zoom);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _positionStream?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final h = twoDigits(d.inHours);
    final m = twoDigits(d.inMinutes.remainder(60));
    final s = twoDigits(d.inSeconds.remainder(60));
    return "$h:$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = const Color(0xFFAED9A3);
    final cardRadius = 22.0;
    return WillPopScope(
      onWillPop: () async {
        if (isRunning) {
          final shouldStop = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Stop Running?'),
              content: const Text('Are you sure you want to stop your current run?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Continue Running'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Stop Run'),
                ),
              ],
            ),
          );
          if (shouldStop == true) {
            _toggleRun();
          }
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              child: _userLocation == null && !_locationError
                  ? const Center(child: CircularProgressIndicator())
                  : FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        center: _userLocation ?? (_route.isNotEmpty ? _route.first : LatLng(0, 0)),
                        zoom: 16.0,
                        interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: _route,
                              color: Colors.orange,
                              strokeWidth: 6,
                            ),
                          ],
                        ),
                        if (_userLocation != null)
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: _userLocation!,
                                width: 40,
                                height: 40,
                                child: const Icon(Icons.my_location, color: Colors.blue, size: 36),
                              ),
                            ],
                          ),
                        if (_locationError)
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: _route.isNotEmpty ? _route.first : LatLng(0, 0),
                                width: 200,
                                height: 40,
                                child: const Center(
                                  child: Text(
                                    'Location unavailable',
                                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
            ),
            // Back button
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: cardColor.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.arrow_back, color: Colors.black87, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Finish Run',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Bottom stats card with play/pause and re-center buttons
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                minimum: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(cardRadius),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Running time',
                                      style: TextStyle(fontSize: 15, color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                              // Play/Pause button
                              GestureDetector(
                                onTap: _toggleRun,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(
                                    isRunning ? Icons.pause : Icons.play_arrow,
                                    color: Colors.green,
                                    size: 22,
                                  ),
                                ),
                              ),
                              // Re-center button
                              GestureDetector(
                                onTap: _recenterMap,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: const Icon(Icons.my_location, color: Colors.blue, size: 22),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _formatDuration(runningTime),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _BottomStat(
                                label: 'KM/s',
                                value: '${distance.toStringAsFixed(2)} km',
                                bold: true,
                              ),
                              _BottomStat(
                                label: 'Cal',
                                value: '$calories cal',
                                bold: true,
                              ),
                              _BottomStat(
                                label: 'Ave Spd',
                                value: '${avgSpeed.isNaN ? 0.0 : avgSpeed.toStringAsFixed(2)} km/hr',
                                bold: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomStat extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  const _BottomStat({required this.label, required this.value, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
} 