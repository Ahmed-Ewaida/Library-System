import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CustomLoveButton extends StatelessWidget {
  final bool isLiked;
  final VoidCallback? onTap;

  const CustomLoveButton({
    super.key,
    this.isLiked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // تم استخدام `Future.value(!isLiked)` لضمان التوافق مع `like_button`
    // الذي يتوقع دالة من نوع `Future<bool?>`
    return LikeButton(
      isLiked: isLiked,
      onTap: onTap != null ? (bool isLiked) async {
        onTap!(); // استدعاء الدالة التي يتم تمريرها من الخارج
        return !isLiked;
      } : null,
      circleColor: const CircleColor(
        start: Color(0xff00ddff),
        end: Color(0xff0099cc),
      ),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Colors.pink,
        dotSecondaryColor: Colors.white,
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          Icons.favorite,
          color: isLiked ? Colors.red : Colors.grey.withOpacity(0.5),
          size: 30,
        );
      },
    );
  }
}
class CustomLikeButton extends StatelessWidget {
  final bool isLiked;
  final bool Like;
  final VoidCallback? onTap;

  const CustomLikeButton({
    super.key,
    this.isLiked = false,
    required this.Like,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      isLiked: isLiked,
      onTap: onTap != null ? (isLiked) async {
        onTap!();
        return !isLiked;
      } : null,
      circleColor: const CircleColor(
        start: Color(0xff00ddff),
        end: Color(0xff0099cc),
      ),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Colors.pink,
        dotSecondaryColor: Colors.white,
      ),
      likeBuilder: (isLiked) {
        return Icon(
          Like ? Icons.thumb_up_outlined : Icons.thumb_down_outlined,
          color: isLiked
              ? (Like ? Colors.blue : Colors.red)
              : Colors.grey.withOpacity(0.5),
          size: 30,
        );
      },
    );
  }
}