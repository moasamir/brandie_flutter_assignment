import 'package:flutter/material.dart';

class SearchPageContent extends StatelessWidget {
  const SearchPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20), // Reduced top gap
          TextField(
            decoration: InputDecoration(
              hintText: 'Search products, people...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Trending Searches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildTrendingItem('Giordani Gold Eternal Glow'),
          _buildTrendingItem('Summer Skincare Routine'),
          _buildTrendingItem('WonderLash Mascara tips'),
        ],
      ),
    );
  }

  Widget _buildTrendingItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.trending_up, color: Color(0xFF8FD6B3), size: 20),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 14, color: Colors.black87)),
        ],
      ),
    );
  }
}

class ChatPageContent extends StatelessWidget {
  const ChatPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Messages', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 6,
            separatorBuilder: (c, i) => const Divider(height: 1),
            itemBuilder: (context, index) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 26,
                backgroundColor: const Color(0xFF8FD6B3).withAlpha(50),
                child: Icon(Icons.person, color: const Color(0xFF8FD6B3)),
              ),
              title: Text('Team Brandie ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('New smart post suggestions ready!', maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: const Text('Just now', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfilePageContent extends StatelessWidget {
  const ProfilePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
          const CircleAvatar(
            radius: 55,
            backgroundColor: Color(0xFF8FD6B3),
            child: CircleAvatar(radius: 52, backgroundImage: AssetImage('assets/images/user_profile.png')),
          ),
          const SizedBox(height: 16),
          const Text('Amanda', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Text('@amanda_beauty_uk', style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStat('Posts', '124'),
              _buildStat('Followers', '12.5K'),
              _buildStat('Following', '450'),
            ],
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Edit Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}
