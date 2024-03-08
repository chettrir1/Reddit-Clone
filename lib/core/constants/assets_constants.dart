import 'package:reddit_clone/feature/feed/screen/feed_screen.dart';
import 'package:reddit_clone/feature/post/screen/add_post_screen.dart';

class AssetsConstants {
  static const String _basePath = 'assets/images';
  static const String logo = '$_basePath/logo.png';
  static const String loginEmote = '$_basePath/loginEmote.png';
  static const String google = '$_basePath/google.png';

  static const bannerDefault =
      'https://thumbs.dreamstime.com/b/abstract-stained-pattern-rectangle-background-blue-sky-over-fiery-red-orange-color-modern-painting-art-watercolor-effe-texture-123047399.jpg';
  static const avatarDefault =
      'https://external-preview.redd.it/5kh5OreeLd85QsqYO1Xz_4XSLYwZntfjqou-8fyBFoE.png?auto=webp&s=dbdabd04c399ce9c761ff899f5d38656d1de87c2';

  static const tabWidgets = [
    FeedScreen(),
    AddPostScreen(),
  ];
}
