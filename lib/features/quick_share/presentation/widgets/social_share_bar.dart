import 'package:flutter/material.dart';
import 'share_loading_dialog.dart';
import '../pages/social_splash_page.dart';

class SocialShareBar extends StatelessWidget {
  const SocialShareBar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> socialApps = [
      {'name': 'Instagram', 'asset': 'assets/images/Instagram.png', 'color': Colors.pinkAccent},
      {'name': 'Facebook', 'asset': 'assets/images/Facebook.png', 'color': Colors.blueAccent},
      {'name': 'WhatsApp', 'asset': 'assets/images/Whatsapp.png', 'color': Colors.green},
      {'name': 'Messenger', 'asset': 'assets/images/massenger.png', 'color': Colors.blue},
      {'name': 'TikTok', 'asset': 'assets/images/Tik_Tok.png', 'color': Colors.black},
      {'name': 'Telegram', 'asset': 'assets/images/Telegram.png', 'color': Colors.blue},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const Text(
            'Quick share to:',
            style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: socialApps.map((app) => _buildShareIcon(
                  context, 
                  app['asset'], 
                  app['name'], 
                  app['color']
                )).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareIcon(BuildContext context, String assetPath, String appName, Color splashColor) {
    return GestureDetector(
      onTap: () async {
        // 1. Show the multi-step loading dialog and WAIT for it to finish
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => ShareLoadingDialog(message: 'Connecting to $appName...'),
        );
        
        // 2. ONLY after the dialog is closed (animation complete), push the splash screen
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SocialSplashPage(
                appName: appName,
                logoUrl: assetPath,
                color: splashColor,
                isAsset: true,
              ),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 14),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(assetPath, errorBuilder: (c, e, s) => const Icon(Icons.share, size: 18)),
          ),
        ),
      ),
    );
  }
}
