import 'package:flutter/material.dart';

class ProductInfoWidget extends StatefulWidget {
  final String name;
  final String price;
  final String discount;
  final String imageUrl;
  final VoidCallback onTap;

  const ProductInfoWidget({
    super.key,
    required this.name,
    required this.price,
    required this.discount,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  State<ProductInfoWidget> createState() => _ProductInfoWidgetState();
}

class _ProductInfoWidgetState extends State<ProductInfoWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    
    // Appear after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              // Reduced black tint for better image visibility as requested
              color: Colors.black.withAlpha(110), 
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withAlpha(80), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(60),
                  blurRadius: 8,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(widget.imageUrl, height: 46, width: 46, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.name, 
                      style: const TextStyle(
                        color: Colors.white, 
                        fontSize: 15, 
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          widget.price, 
                          style: const TextStyle(
                            color: Colors.white, 
                            fontSize: 13, 
                            fontWeight: FontWeight.w500
                          )
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2ECC71), 
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text(
                            widget.discount, 
                            style: const TextStyle(
                              color: Colors.white, 
                              fontSize: 9, 
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
