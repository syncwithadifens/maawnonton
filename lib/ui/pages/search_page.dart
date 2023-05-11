import 'package:flutter/material.dart';
import 'package:maawnonton/providers/search_provider.dart';
import 'package:maawnonton/theme/styles.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 30),
                child: TextField(
                  controller: searchCtrl,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      hintText: 'Cari movie pilihanmu...',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      filled: true,
                      fillColor: const Color(0xffF1F0F5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      suffixIcon: IconButton(
                          onPressed: () {
                            searchProvider.query = searchCtrl.text;
                            searchProvider.searchMovie();
                          },
                          icon: Icon(
                            Icons.search,
                            color: yellowColor,
                          ))),
                ),
              ),
              searchProvider.query != ''
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchProvider.dataSearch!.results.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w185${searchProvider.dataSearch!.results[index].posterPath}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          searchProvider
                                              .dataSearch!.results[index].title,
                                          maxLines: 2,
                                          style: titleStyle.copyWith(
                                              color: blackColor, fontSize: 18),
                                        ),
                                        Text(
                                          searchProvider.dataSearch!
                                              .results[index].overview,
                                          maxLines: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text(
                          'Belum ada pencarian dilakukan..',
                          style: subtitleStyle.copyWith(fontSize: 16),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
