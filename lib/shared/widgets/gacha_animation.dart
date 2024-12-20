import 'package:flutter/material.dart';

class GachaAnimation extends StatelessWidget {
  const GachaAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // ガチャ機の画像（ダミーとして円を使用）
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        // 回転するアニメーション
        Positioned(
          child: TweenAnimationBuilder<double>(
            duration: const Duration(seconds: 10),
            tween: Tween(begin: 0, end: 3600),
            builder: (context, angle, child) {
              return Transform.rotate(
                angle: angle * (3.14159 / 180), // 度をラジアンに変換
                child: Icon(Icons.star, size: 50, color: Colors.yellow),
              );
            },
          ),
        ),
      ],
    );
  }
}
