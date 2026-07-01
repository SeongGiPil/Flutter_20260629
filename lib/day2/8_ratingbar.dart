import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding:
                const EdgeInsets.symmetric(horizontal: 4.0),

                itemBuilder: (context, _) => const Icon(
                  Icons.home,
                  color: Colors.amber,
                ),

                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}