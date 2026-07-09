class PostModel {
  final String imageUrl;
  final String userName;
  final String userProfileUrl;
  final String caption;
  final String hashtags;
  final String referralCode;
  final String referralLink;
  final String musicName;
  final String? productName;
  final String? productPrice;

  PostModel({
    required this.imageUrl,
    required this.userName,
    required this.userProfileUrl,
    required this.caption,
    required this.hashtags,
    required this.referralCode,
    required this.referralLink,
    required this.musicName,
    this.productName,
    this.productPrice,
  });
}
