import 'package:flutter/material.dart';

class ShareLoadingDialog extends StatefulWidget {
  final String message; // Initial message (can be fallback)
  const ShareLoadingDialog({super.key, required this.message});

  @override
  State<ShareLoadingDialog> createState() => _ShareLoadingDialogState();
}

class _ShareLoadingDialogState extends State<ShareLoadingDialog> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  double _progress = 0;
  String _currentMessage = "";

  final List<String> _loadingSteps = [
    'Generating your sales link..',
    'Copying the caption to clipboard',
    'Saving the content to your profile',
    'Preparing the content for social media',
  ];

  @override
  void initState() {
    super.initState();
    _currentMessage = _loadingSteps[0];
    
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _animateProcess();
  }

  void _animateProcess() async {
    int totalSteps = _loadingSteps.length;
    
    for (int i = 0; i < totalSteps; i++) {
      // Update text for each step
      if (mounted) {
        setState(() {
          _currentMessage = _loadingSteps[i];
        });
      }

      // Smoothly animate progress for this step
      double startProgress = i / totalSteps;
      double endProgress = (i + 1) / totalSteps;
      
      for (int p = 0; p <= 20; p++) {
        await Future.delayed(const Duration(milliseconds: 60)); // Total ~1.2s per step
        if (mounted) {
          setState(() {
            _progress = startProgress + (p / 20) * (endProgress - startProgress);
          });
        }
      }
    }
    
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- ROTATING AI LOGO ---
            RotationTransition(
              turns: _rotationController,
              child: Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xFF8FD6B3),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/ai_logo.png',
                  color: Colors.white,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // --- DYNAMIC TEXT ---
            SizedBox(
              height: 40, // Fixed height to prevent dialog jumping
              child: Text(
                _currentMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // --- PROGRESS BAR ---
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: _progress,
                minHeight: 6,
                backgroundColor: Colors.grey[100],
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8FD6B3)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
