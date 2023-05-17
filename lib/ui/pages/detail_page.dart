import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:maawnonton/models/movies_model.dart';
import 'package:maawnonton/providers/movies_provider.dart';
import 'package:maawnonton/theme/styles.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final Result data;
  const DetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Provider.of<MoviesProvider>(context, listen: false)
        .getMoviesDetail(data.id);
    final detailData = Provider.of<MoviesProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: detailData.isLoading == false || detailData.detailMovies == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : detailData.isSuccess == false
              ? const Center(
                  child: Text('Oops, terjadi kesalahan pada server'),
                )
              : Stack(
                  children: [
                    Container(
                      height: screenHeight * 0.6,
                      width: screenWidth,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w1280/${data.backdropPath}'),
                              fit: BoxFit.cover)),
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
                    DraggableScrollableSheet(
                      initialChildSize: 0.5,
                      minChildSize: 0.5,
                      builder: (context, scrollController) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          height: screenHeight * 0.5,
                          width: screenWidth,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18)),
                              color: blackColor,
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0, -5),
                                    color: Colors.black87,
                                    blurRadius: 18,
                                    spreadRadius: 5)
                              ]),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 150, right: 150, bottom: 15),
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: greyColor,
                                      borderRadius: BorderRadius.circular(18)),
                                ),
                                Text(
                                  '${data.title}',
                                  style: titleStyle,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: SizedBox(
                                      height: 40,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: detailData
                                            .detailMovies!.genres!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                border: Border.all(
                                                    color: yellowColor)),
                                            child: Text(
                                              '${detailData.detailMovies!.genres![index].name}',
                                              style: subtitleStyle.copyWith(
                                                  fontSize: 12),
                                            ),
                                          );
                                        },
                                      )),
                                ),
                                RatingBar.builder(
                                  itemSize: 18,
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemPadding:
                                      const EdgeInsets.symmetric(horizontal: 1),
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
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 10),
                                  child: Text(
                                    'Overview',
                                    style: subtitleStyle.copyWith(
                                        color: whiteColor),
                                  ),
                                ),
                                Text(
                                  '${data.overview}',
                                  textAlign: TextAlign.justify,
                                  style: subtitleStyle.copyWith(
                                      fontSize: 14,
                                      color: const Color.fromARGB(
                                          255, 199, 197, 197)),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
    );
  }
}
