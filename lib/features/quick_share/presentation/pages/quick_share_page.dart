import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/post_model.dart';
import '../widgets/post_overlay_widget.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/video_post_widget.dart';
import '../widgets/nav_pages.dart';

class QuickSharePage extends StatefulWidget {
  const QuickSharePage({super.key});

  @override
  State<QuickSharePage> createState() => _QuickSharePageState();
}

class _QuickSharePageState extends State<QuickSharePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _verticalController = PageController();
  final PageController _horizontalController = PageController();
  bool _isLoading = true;
  int _currentIndex = 0;
  int _selectedNavIndex = 2; // Home

  // Amanda's Carousel Data
  final List<PostModel> _amandaPosts = [
    PostModel(
      imageUrl: 'assets/images/product_1.png',
      userName: 'Amanda',
      userProfileUrl: 'assets/images/user_profile.png',
      caption: 'Elevate your beauty with the Giordani Gold - Eternal Glow Lipstick SPF 25! This luxurious creamy lipstick doesn\'t just promise rich pigments but brings you the benefits of hyaluronic acid and collagen-boosting peptides too.',
      hashtags: '#Oriflame #GiordaniGold #LipCareGoals',
      referralCode: 'UK-AMANDA3012',
      referralLink: 'www.oriflame.com/giordani/amanda3012',
      musicName: 'Bad Habits by Ed Sheeran',
      productName: 'Giordani Gold Lipstick',
      productPrice: '\$14.99',
    ),
    PostModel(
      imageUrl: 'assets/images/product_2.png',
      userName: 'Amanda',
      userProfileUrl: 'assets/images/user_profile.png',
      caption: 'Experience the elegance of Eclat Amour—a fragrance that captures the essence of romance and sophistication.',
      hashtags: '#EclatAmour #TimelessElegance',
      referralCode: 'UK-AMANDA3012',
      referralLink: 'www.oriflame.com/giordani/amanda3012',
      musicName: 'Unstoppable by Sia',
      productName: 'Eclat Amour Perfume',
      productPrice: '\$29.99',
    ),
  ];

  // Sofia's Single Post Data
  final PostModel _sofiaPost = PostModel(
    imageUrl: 'assets/images/product_3.png',
    userName: 'Sofia',
    userProfileUrl: 'assets/images/user_profile.png',
    caption: 'Unlock the power of bold, beautiful lashes! With WonderLash Mascara, get ultimate length and volume.',
    hashtags: '#WonderLash #LashesForDays',
    referralCode: 'UK-SOFIA9988',
    referralLink: 'www.oriflame.com/giordani/sofia9988',
    musicName: 'Vogue by Madonna',
    productName: 'WonderLash Mascara',
    productPrice: '\$12.50',
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: _isLoading ? null : _buildAppBar(),
      body: Stack(
        children: [
          if (!_isLoading)
            IndexedStack(
              index: _selectedNavIndex,
              children: [
                VideoPostWidget(videoPath: 'assets/video/ad.mp4', post: _amandaPosts[0]),
                const SearchPageContent(),
                _buildMainSmartPostTab(),
                const ChatPageContent(),
                const ProfilePageContent(),
              ],
            ),
          if (_isLoading)
            LoadingOverlay(
              onFinished: () {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
        ],
      ),
      bottomNavigationBar: _isLoading ? null : _buildBottomNav(),
    );
  }

  Widget _buildMainSmartPostTab() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildSmartPostContent(),
        const Center(child: Text('Library Page')),
        const Center(child: Text('Communities Page')),
        const Center(child: Text('Share&Win Page')),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 70,
      leadingWidth: 100,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                  child: Image.asset('assets/images/ai_logo.png', height: 22, color: Colors.white),
                ),
                Positioned(
                  top: -4,
                  right: -8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8FD6B3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'AI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text('Your Assistant', style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      title: Image.asset('assets/images/oriflame_logo.png', height: 28),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                child: const Icon(Icons.camera_alt_outlined, size: 22, color: Colors.white),
              ),
              const SizedBox(height: 4),
              const Text('Camera', style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: const [
            Tab(text: 'Smart Post'),
            Tab(text: 'Library'),
            Tab(text: 'Communities'),
            Tab(text: 'Share&Win'),
          ],
        ),
      ),
    );
  }

  Widget _buildSmartPostContent() {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: _verticalController,
      itemCount: 2, // 1st: Amanda's Carousel, 2nd: Sofia's Post
      itemBuilder: (context, verticalIndex) {
        if (verticalIndex == 0) {
          // Amanda's Horizontal Carousel
          return PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _horizontalController,
            itemCount: _amandaPosts.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, horizontalIndex) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(_amandaPosts[horizontalIndex].imageUrl, fit: BoxFit.cover),
                  PostOverlayWidget(
                    post: _amandaPosts[horizontalIndex],
                    currentIndex: _currentIndex,
                    totalPosts: _amandaPosts.length,
                    onDotTap: (dotIndex) {
                      _horizontalController.animateToPage(dotIndex, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                    },
                  ),
                ],
              );
            },
          );
        } else {
          // Sofia's Single Vertical Post
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(_sofiaPost.imageUrl, fit: BoxFit.cover),
              PostOverlayWidget(
                post: _sofiaPost,
                currentIndex: 0,
                totalPosts: 1,
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildBottomNav() {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent, 
        elevation: 0,
        currentIndex: _selectedNavIndex,
        onTap: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          _buildNavItem('assets/images/rocket_nav.png', 0, true),
          _buildNavItem('assets/images/search_nav.png', 1, false),
          _buildNavItem('assets/images/home_nav.png', 2, false),
          _buildNavItem('assets/images/chat_nav.png', 3, false),
          _buildNavItem('assets/images/profile_nav.png', 4, false),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String asset, int index, bool isRocket) {
    bool isSelected = _selectedNavIndex == index;
    double size = isRocket ? (isSelected ? 55 : 45) : (isSelected ? 38 : 32);
    
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: size,
        width: size,
        child: Image.asset(
          asset, 
          color: isSelected ? const Color(0xFF8FD6B3) : Colors.black.withAlpha(220),
          fit: BoxFit.contain,
        ),
      ),
      label: '',
    );
  }
}
