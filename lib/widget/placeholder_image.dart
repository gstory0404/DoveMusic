import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:larkmusic/config/assets_image.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/16 18:19
/// @Email gstory0404@gmail.com
/// @Description: 带圆角的图片

class PlaceholderImage extends StatelessWidget {
  String image;
  double width;
  double height;
  double? radius;
  String? assetName;

  PlaceholderImage(
      {super.key,
      required this.image,
      required this.width,
      required this.height,
      this.radius,
      this.assetName});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 6),
      child: image.isNotEmpty
          ? FadeInImage(
              width: width,
              height: height,
              fit: BoxFit.cover,
              image: Image.memory(const Base64Decoder().convert(image)).image,
              placeholderFit: BoxFit.cover,
              placeholder: const AssetImage(
                AssetsImages.logoPlaceholder,
              ),
              imageErrorBuilder: (context, error, stack) {
                return Image.asset(
                  assetName ?? AssetsImages.logoPlaceholder,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                );
              },
            )
          : Image.asset(
              assetName ?? AssetsImages.logoPlaceholder,
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
    );
  }
}
