import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../../../utils/asset_urls.dart';
import '../../../../utils/theme_data.dart';

class ImageBackground extends StatelessWidget {
  const ImageBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return ClipRRect(
          borderRadius: isKeyboardVisible
              ? BorderRadius.zero
              : const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetUrls.BACKGROUND_LOGIN),
                fit: BoxFit.cover,
              ),
            ),
            width: Get.width,
            height: Get.height * 0.8,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      // primaryColor.withOpacity(0.9),
                      primaryColor.withOpacity(0.7),
                      primaryColor.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
