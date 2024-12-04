import 'package:flutter/material.dart';

class KImageCard {
  KImageCard._();

  static Container imageCard({required String imagePath}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      margin: const EdgeInsets.all(3),
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(
                Icons.broken_image,
                size: 50,
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }
}
