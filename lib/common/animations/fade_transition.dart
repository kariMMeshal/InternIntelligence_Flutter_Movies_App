import 'package:flutter/material.dart';

// Updated method to accept a PageRouteBuilder
PageRouteBuilder fadeTransition(PageRouteBuilder pageRouteBuilder) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds:1100),
    pageBuilder: pageRouteBuilder.pageBuilder,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Create a scale animation
      final scaleAnimation = Tween<double>(
        begin: 0.9, // scale down to 90% initially
        end: 1.0, // scale to 100% at the end
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut, // You can adjust the curve here
      ));

      // Create a fade animation
      final fadeAnimation =
          Tween<double>(begin: 0.7, end: 1.0).animate(animation);

      // Combine both scale and fade transitions
      return FadeTransition(
        opacity: fadeAnimation,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: child,
        ),
      );
    },
  );
}
