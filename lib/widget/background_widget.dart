import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/config/assets_image.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/8 16:23
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class BackGroundWidget extends ConsumerWidget {
  Widget child;

  BackGroundWidget({super.key,required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FadeInImage.assetNetwork(
            fit: BoxFit.fill,
            image: "",
            placeholderFit: BoxFit.cover,
            placeholder: AssetsImages.bg,
            imageErrorBuilder: (context, error, stack) {
              return Image.asset(
                AssetsImages.bg,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        child,
      ],
    );
  }
}
