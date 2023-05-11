import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maawnonton/providers/movies_provider.dart';
import 'package:maawnonton/theme/styles.dart';
import 'package:maawnonton/ui/pages/detail_page.dart';
import 'package:maawnonton/ui/pages/search_page.dart';
import 'package:maawnonton/ui/widgets/custom_bottom_navbar.dart';
import 'package:maawnonton/ui/widgets/custom_fab.dart';
import 'package:maawnonton/ui/widgets/masked_image.dart';
import 'package:provider/provider.dart';
import 'package:scaled_list/scaled_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<MoviesProvider>(context, listen: false)
      ..getMoviesByNowPlaying()
      ..getMoviesByPopular();
  }

  @override
  Widget build(BuildContext context) {
    final moviesData = Provider.of<MoviesProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: blackColor,
      floatingActionButton: const CustomFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavbar(screenWidth: screenWidth),
      body: Stack(
        children: [
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: greenColor.withOpacity(0.5)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.4,
            right: -88,
            child: Container(
              height: 166,
              width: 166,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: pinkColor.withOpacity(0.5),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 200,
                  sigmaY: 200,
                ),
                child: Container(
                  height: 166,
                  width: 166,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cyanColor.withOpacity(0.5),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 200,
                  sigmaY: 200,
                ),
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Maaw nonton apa nih?',
                    style: titleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchPage(),
                      )),
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Cari movie yang kamu suka'),
                        Icon(Icons.search)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Text(
                    'Paling banyak ditonton',
                    style: titleStyle.copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                moviesData.isLoading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : moviesData.isSuccess &&
                            moviesData.dataMoviesByPopular != null
                        ? ScaledList(
                            itemCount: 5,
                            itemColor: (index) {
                              return randomColor[index % randomColor.length];
                            },
                            itemBuilder: (index, selectedIndex) {
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                          data: moviesData.dataMoviesByPopular!
                                              .results[index]),
                                    )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 40),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://image.tmdb.org/t/p/w185/${moviesData.dataMoviesByPopular!.results[index].posterPath}'),
                                              fit: BoxFit.cover)),
                                      height: selectedIndex == index ? 200 : 80,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        moviesData.dataMoviesByPopular!
                                            .results[index].title,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: titleStyle.copyWith(
                                            color: blackColor,
                                            fontSize: selectedIndex == index
                                                ? 25
                                                : 20),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 50, bottom: 20),
                              child: Text(
                                'Oops, terjadi kesalahan pada server',
                                style: subtitleStyle.copyWith(
                                    color: pinkColor, fontSize: 14),
                              ),
                            ),
                          ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 20, right: 20, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Now Playing',
                        style: subtitleStyle,
                      ),
                      Text(
                        'Lihat semua',
                        style: subtitleStyle.copyWith(
                            fontSize: 16, color: greyColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 160,
                  child: moviesData.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : moviesData.isSuccess &&
                              moviesData.dataMoviesByNowPlaying != null
                          ? ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: moviesData
                                  .dataMoviesByNowPlaying!.results.length,
                              itemBuilder: (context, index) {
                                String mask;
                                if (index == 0) {
                                  mask = 'assets/mask/mask_firstIndex.png';
                                } else if (index ==
                                    moviesData.dataMoviesByNowPlaying!.results
                                            .length -
                                        1) {
                                  mask = 'assets/mask/mask_lastIndex.png';
                                } else {
                                  mask = 'assets/mask/mask.png';
                                }
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                            data: moviesData
                                                .dataMoviesByNowPlaying!
                                                .results[index]),
                                      )),
                                  child: Container(
                                    height: 160,
                                    width: 142,
                                    margin: EdgeInsets.only(
                                        left: index == 0 ? 20 : 0),
                                    child: MaskedImage(
                                        asset: moviesData
                                            .dataMoviesByNowPlaying!
                                            .results[index]
                                            .posterPath,
                                        mask: mask),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                'Oops, terjadi kesalahan pada server',
                                style: subtitleStyle.copyWith(
                                    color: pinkColor, fontSize: 14),
                              ),
                            ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 20, right: 20, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular',
                        style: subtitleStyle,
                      ),
                      Text(
                        'Lihat semua',
                        style: subtitleStyle.copyWith(
                            fontSize: 16, color: greyColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 160,
                    child: moviesData.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : moviesData.isSuccess &&
                                moviesData.dataMoviesByPopular != null
                            ? ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: moviesData
                                    .dataMoviesByPopular!.results.length,
                                itemBuilder: (context, index) {
                                  String mask;
                                  if (index == 0) {
                                    mask = 'assets/mask/mask_firstIndex.png';
                                  } else if (index ==
                                      moviesData.dataMoviesByPopular!.results
                                              .length -
                                          1) {
                                    mask = 'assets/mask/mask_lastIndex.png';
                                  } else {
                                    mask = 'assets/mask/mask.png';
                                  }
                                  return GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                              data: moviesData
                                                  .dataMoviesByPopular!
                                                  .results[index]),
                                        )),
                                    child: Container(
                                      height: 160,
                                      width: 142,
                                      margin: EdgeInsets.only(
                                          left: index == 0 ? 20 : 0),
                                      child: MaskedImage(
                                          asset: moviesData.dataMoviesByPopular!
                                              .results[index].posterPath,
                                          mask: mask),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  'Oops, terjadi kesalahan pada server',
                                  style: subtitleStyle.copyWith(
                                      color: pinkColor, fontSize: 14),
                                ),
                              ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
