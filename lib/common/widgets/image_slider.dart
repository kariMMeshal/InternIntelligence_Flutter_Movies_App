import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/models/movie_model.dart';

class KImageSlider {
  KImageSlider._();
  static CarouselSlider slider({required List<Movie> movies}) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 450.0,
          autoPlay: true,
          autoPlayCurve: Curves.linearToEaseOut,
          enlargeCenterPage: true,
          autoPlayInterval: const Duration(seconds: 15)),
      items: List.generate(movies.length, (i) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.network(
                    "https://image.tmdb.org/t/p/original${movies[i].posterPath}",
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
              ],
            );
          },
        );
      }).toList(),
    );
  }
}
