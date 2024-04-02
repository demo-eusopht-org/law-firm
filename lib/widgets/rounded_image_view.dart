import 'package:flutter/material.dart';

class RoundNetworkImageView extends StatelessWidget {
  final String? url;
  final double size;
  final bool showBadge;
  const RoundNetworkImageView({
    super.key,
    this.url,
    required this.size,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAlias,
      children: [
        Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAlias,
          child: url != null
              ? Image.network(
                  url!,
                  fit: BoxFit.fitWidth,
                  height: size,
                  width: size,
                  errorBuilder: (context, _, __) {
                    return Icon(
                      Icons.image,
                      size: size,
                    );
                  },
                )
              : Icon(
                  Icons.image,
                  size: size,
                ),
        ),
        if (showBadge) _buildBadge(),
      ],
    );
  }

  Positioned _buildBadge() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.edit,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
