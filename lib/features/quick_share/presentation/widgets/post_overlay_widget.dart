import 'package:flutter/material.dart';
import '../../domain/models/post_model.dart';
import '../pages/edit_caption_page.dart';
import 'social_share_bar.dart';
import 'product_info_widget.dart';

class PostOverlayWidget extends StatelessWidget {
  final PostModel post;
  final int currentIndex;
  final int totalPosts;
  final Function(int)? onDotTap;

  const PostOverlayWidget({
    super.key,
    required this.post,
    required this.currentIndex,
    required this.totalPosts,
    this.onDotTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Side Indicators
        Positioned(
          right: 12,
          top: 0,
          bottom: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(totalPosts, (index) => _buildDot(index == currentIndex, index)),
          ),
        ),
        // Content
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10), 
                _buildUserProfile(),
                const Spacer(), 
                // Bottom content pushed lower to sit right above navigator
                ProductInfoWidget(
                  name: post.productName ?? '',
                  price: post.productPrice ?? '',
                  discount: '30% off',
                  imageUrl: post.imageUrl,
                  onTap: () {
                    _showPremiumStoreLink(context);
                  },
                ),
                const SizedBox(height: 10),
                _buildMusicInfo(),
                const SizedBox(height: 10),
                _buildCaptionSection(context),
                const SizedBox(height: 10), // Minimal padding above bottom nav
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showPremiumStoreLink(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 24),
            const Icon(Icons.shopping_bag_outlined, size: 50, color: Color(0xFF8FD6B3)),
            const SizedBox(height: 16),
            Text('Exclusive Store Link', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 8),
            Text('Redirecting you to the personal beauty store for ${post.productName}...', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8FD6B3),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text('Go to Store', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(bool isActive, int index) {
    return GestureDetector(
      onTap: () => onDotTap?.call(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: isActive ? 12 : 8, 
        width: isActive ? 12 : 8,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF2ECC71) : Colors.white.withAlpha(120),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: const AssetImage('assets/images/user_profile.png'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFFFF85A1), borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      children: [
                        Icon(Icons.auto_awesome, size: 10, color: Colors.white),
                        SizedBox(width: 4),
                        Text('Ready to share', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('${currentIndex + 1} of $totalPosts', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 4),
              const Text('High-converting in Oriflame Community', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const Icon(Icons.more_vert, color: Colors.white, size: 24),
      ],
    );
  }

  Widget _buildMusicInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Colors.black.withAlpha(90), borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.music_note, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.white, fontSize: 11),
              children: [
                const TextSpan(text: 'RECOMMENDED: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: post.musicName, style: const TextStyle(fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaptionSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12), // Reduced padding to make it smaller
      decoration: BoxDecoration(color: Colors.black.withAlpha(140), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.description_outlined, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  const Text('CAPTION SUGGESTION', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
              GestureDetector(
                onTap: () => _openEditCaption(context),
                child: const Row(
                  children: [
                    Icon(Icons.edit_outlined, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text('Edit Caption', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => _openEditCaption(context),
            child: RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4),
                children: [
                  TextSpan(text: post.caption),
                  const TextSpan(text: ' see more', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Use my referral code: ${post.referralCode}\nUse my referral link: ${post.referralLink}',
            style: TextStyle(color: Colors.white.withAlpha(200), fontSize: 10, height: 1.5, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 12),
          const SocialShareBar(),
        ],
      ),
    );
  }

  void _openEditCaption(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditCaptionPage(initialCaption: post.caption)));
  }
}
