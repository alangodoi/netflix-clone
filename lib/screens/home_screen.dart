import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:netflix/models/movie.dart';
import 'package:netflix/models/popular.dart';
import 'package:netflix/widgets/custom_sliver_app_bar.dart';
import 'package:netflix/widgets/horizontal_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  bool _showAppBar = true;
  Future<Popular> _dataRequiredForBuild;
  Popular _dramas;
  Popular _animations;

  @override
  void initState() {
    super.initState();
    print('initState');
    scroll();

    _dataRequiredForBuild = fetchData();

    print(_dataRequiredForBuild);
    // fetchPost();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(() {});
    super.dispose();
  }

  void showAppBar() {
    setState(() {
      _showAppBar = true;
    });
  }

  void hideAppBar() {
    setState(() {
      _showAppBar = false;
    });
  }

  void scroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        // _showAppBar = false;
        hideAppBar();
        print('Down:' + _showAppBar.toString());
      }

      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        // _showAppBar = true;
        showAppBar();
        print('Top: ' + _showAppBar.toString());
      }
    });
  }

  Future<Popular> fetchData() async {
    Response popular = await fetchPopular();
    Response dramas = await fetchDrama();
    Response animations = await fetchAnimations();

    _dramas = Popular.fromJson(jsonDecode(dramas.body));
    _animations = Popular.fromJson(jsonDecode(animations.body));
    return Popular.fromJson(jsonDecode(popular.body));
  }

  Future<Response> fetchPopular() async {
    String url =
        'https://api.themoviedb.org/3/discover/movie?api_key=870d1832f5dc55377a5ae84353410f2d&sort_by=popularity.desc';

    Response response = await get(url);

    if (response.statusCode == 200) {
      // return Popular.fromJson(jsonDecode(response.body));
      return response;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Response> fetchDrama() async {
    String url =
        'https://api.themoviedb.org/3/discover/movie?api_key=870d1832f5dc55377a5ae84353410f2d&with_genres=18&sort_by=vote_average.desc&vote_count.gte=10';

    Response response = await get(url);

    if (response.statusCode == 200) {
      // return Popular.fromJson(jsonDecode(response.body));
      return response;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Response> fetchAnimations() async {
    String url =
        'https://api.themoviedb.org/3/discover/movie?api_key=870d1832f5dc55377a5ae84353410f2d&with_genres=16&sort_by=vote_average.desc&vote_count.gte=10';

    Response response = await get(url);

    if (response.statusCode == 200) {
      // return Popular.fromJson(jsonDecode(response.body));
      return response;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Movie> fetchMovie() async {
    String url =
        'https://api.themoviedb.org/3/movie/495764?api_key=870d1832f5dc55377a5ae84353410f2d';

    Response response = await get(url);

    if (response.statusCode == 200) {
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  int rand() {
    Random random = new Random();
    int randomNumber = random.nextInt(100) + 10; // from 0 upto 99 included
    return randomNumber;
  }

  List<String> myList(List<Results> results, int startPosition, int quantity) {
    List<String> list = List();

    if (results != null)
      for (var i = startPosition; i < results.length; i++) {
        if (results[i].posterPath != null)
          list.add(results[i].posterPath.toString());
      }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<Popular>(
      future: _dataRequiredForBuild,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Scaffold(
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      CustomSliverAppBar(
                        // posterUrl: "https://image.tmdb.org/t/p/original/" +
                        //     snapshot.data.results[12].posterPath.toString(),
                        // 1917
                        // posterUrl: "https://image.tmdb.org/t/p/original/AuGiPiGMYMkSosOJ3BQjDEAiwtO.jpg",
                        // La Casa de Papel
                        posterUrl: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/zd8mxIfGY8SlupYd9XvK3qJL91B.jpg",
                      ),
                    ];
                  },
                  body: Container(
                    color: Color(0xff0f0f0f),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        // TopMenu(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                  ),
                                  Text(
                                    'Continuar assistindo como Alan',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              
                              height: 200.0,
                              child: HorizontalList(
                                posterUrls:
                                    myList(snapshot.data.results, 0, 20),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                  ),
                                  Text(
                                    'Em alta',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 200.0,
                              child: snapshot.hasData
                                  ? HorizontalList(
                                      posterUrls:
                                          myList(snapshot.data.results, 5, 20),
                                    )
                                  : CircularProgressIndicator(),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                  ),
                                  Text(
                                    'Animação',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 200.0,
                              child: HorizontalList(
                                posterUrls: myList(_animations.results, 0, 20),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                  ),
                                  Text(
                                    'Séries dramáticas',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 200.0,
                              child: HorizontalList(                              
                                posterUrls: myList(_dramas.results, 0, 20),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              );
      },
    );
  }
}
