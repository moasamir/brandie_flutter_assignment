import 'package:flutter/material.dart';

class SocialSplashPage extends StatefulWidget {
  final String appName;
  final String logoUrl;
  final Color color;
  final bool isAsset;

  const SocialSplashPage({
    super.key,
    required this.appName,
    required this.logoUrl,
    required this.color,
    this.isAsset = false,
  });

  @override
  State<SocialSplashPage> createState() => _SocialSplashPageState();
}

class _SocialSplashPageState extends State<SocialSplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // HUGE LOGO SIZE
                SizedBox(
                  height: 100,
                  width: 100,
                  child: widget.isAsset 
                    ? Image.asset(widget.logoUrl, fit: BoxFit.contain)
                    : Image.network(widget.logoUrl, fit: BoxFit.contain, errorBuilder: (c, e, s) => const Icon(Icons.apps, size: 100)),
                ),
                const SizedBox(height: 40),
                Text(
                  widget.appName,
                  style: TextStyle(
                    fontSize: 36, 
                    fontWeight: FontWeight.bold, 
                    color: widget.color,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Text('from', style: TextStyle(color: Colors.grey, fontSize: 18)),
                const SizedBox(height: 8),
                Text(
                  'META',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 10,
                    fontSize: 24,
                    color: widget.color.withAlpha(180),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
