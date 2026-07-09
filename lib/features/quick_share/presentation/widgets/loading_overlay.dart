import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class LoadingOverlay extends StatefulWidget {
  final VoidCallback onFinished;
  const LoadingOverlay({super.key, required this.onFinished});

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  final List<String> _steps = [
    'Preparing popular content for you',
    'Crafting a caption to boost engagement',
    'Adding your personal referral link and code',
    'Finding trending songs on other social media',
  ];

  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() async {
    for (int i = 0; i < _steps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 1500));
      if (mounted) {
        setState(() {
          _currentStep = i + 1;
        });
      }
    }
    await Future.delayed(const Duration(milliseconds: 1000));
    widget.onFinished();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Building personalised\nSmart Posts for you!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 40),
          ...List.generate(_steps.length, (index) => _buildStep(index)),
          const SizedBox(height: 40),
          if (_currentStep == _steps.length)
            const Center(
              child: Text(
                'All set! Get ready to share...',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStep(int index) {
    bool isCompleted = index < _currentStep;
    bool isCurrent = index == _currentStep;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isCompleted ? AppColors.primary : Colors.grey[300]!,
                width: 2,
              ),
              color: isCompleted ? AppColors.primary : Colors.transparent,
            ),
            child: isCompleted
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : isCurrent
                    ? const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                      )
                    : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              _steps[index],
              style: TextStyle(
                fontSize: 14,
                color: isCompleted || isCurrent ? Colors.black : Colors.grey,
                fontWeight: isCompleted || isCurrent ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
