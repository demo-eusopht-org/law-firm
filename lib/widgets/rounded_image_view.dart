import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundImageView extends StatelessWidget {
  final String url;
  final double size;
  const RoundImageView({
    super.key,
    required this.url,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.fitWidth,
        height: size,
        width: size,
        errorWidget: (context, _, __) {
          return Icon(
            Icons.image,
            size: size,
          );
        },
      ),
    );
  }
}
