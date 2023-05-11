import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:maawnonton/models/movies_model.dart';
import 'package:maawnonton/theme/styles.dart';

class DetailPage extends StatelessWidget {
  final Result data;
  const DetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: screenHeight * 0.6,
              width: screenWidth,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w780/${data.backdropPath}'),
                      fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              height: screenHeight * 0.5,
              width: screenWidth,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18)),
                color: blackColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: titleStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      height: 40,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: data.genreIds.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: yellowColor)),
                            child: Text(
                              'action',
                              style: subtitleStyle.copyWith(fontSize: 12),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  RatingBar.builder(
                    itemSize: 18,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: yellowColor,
                    ),
                    onRatingUpdate: (rating) {
                      debugPrint(rating.toString());
                    },
                    unratedColor: whiteColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Overview',
                      style: subtitleStyle.copyWith(color: whiteColor),
                    ),
                  ),
                  Text(
                    data.overview,
                    style: subtitleStyle.copyWith(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 199, 197, 197)),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: 50,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: blackColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: yellowColor)),
                  child: Icon(
                    Icons.arrow_back,
                    color: whiteColor,
                    size: 24,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
