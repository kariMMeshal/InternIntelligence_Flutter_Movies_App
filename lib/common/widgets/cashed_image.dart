import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class KCashedImage {
  KCashedImage._();

  static final _customCacheManager = CacheManager(
    Config(
      "customCache",
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 200,
    ),
  );

  static Widget customCachedImage(String imagePath, {bool isPoster = false}) {
    // Check if the border radius should be applied
    if (isPoster) {
      return CachedNetworkImage(
        fadeInDuration: const Duration(milliseconds: 600),
        width: 500,
        height: 500,
        alignment: Alignment.topCenter,
        cacheManager: _customCacheManager,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        imageUrl: imagePath,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: CachedNetworkImage(
          fadeInDuration: const Duration(milliseconds: 600),
          width: 200,
          cacheManager: _customCacheManager,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          imageUrl: imagePath,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      );
    }
  }
}
