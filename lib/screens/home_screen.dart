import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:netflix/models/movie.dart';
import 'package:netflix/models/popular.dart';
import 'package:netflix/widgets/custom_bottom_navbar.dart';
import 'package:netflix/widgets/custom_sliver_app_bar.dart';
import 'package:netflix/widgets/horizontal_list.dart';
import 'package:netflix/widgets/video_player.dart';
import 'package:netflix/widgets/youtube_player.dart';

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
  Popular _upcoming;
  // Movie
  List<String> _genres;

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
    Response upcoming = await fetchUpcoming();

    _dramas = Popular.fromJson(jsonDecode(dramas.body));
    _animations = Popular.fromJson(jsonDecode(animations.body));
    _upcoming = Popular.fromJson(jsonDecode(upcoming.body));
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

  Future<Movie> fetchMovie(int id) async {
    String url = 'https://api.themoviedb.org/3/movie/' +
        id.toString() +
        '?api_key=870d1832f5dc55377a5ae84353410f2d';

    Response response = await get(url);

    if (response.statusCode == 200) {
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Response> fetchUpcoming() async {
    String url =
        'https://api.themoviedb.org/3/movie/upcoming?api_key=870d1832f5dc55377a5ae84353410f2d';

    Response response = await get(url);

    if (response.statusCode == 200) {
      // return Movie.fromJson(jsonDecode(response.body));
      return response;
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
                        // 1917 - ID=530915
                        posterUrl:
                            "https://image.tmdb.org/t/p/original/AuGiPiGMYMkSosOJ3BQjDEAiwtO.jpg",
                        // genres: snapshot.data.results[0],
                        // La Casa de Papel
                        // posterUrl:
                        //     "https://image.tmdb.org/t/p/w600_and_h900_bestv2/zd8mxIfGY8SlupYd9XvK3qJL91B.jpg",
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
                                    'Já disponível',
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
                              // child: CustomVideoPlayer(),
                              child: YoutubeVideoPlayer(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: RaisedButton(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(3.0),
                                        side: BorderSide(color: Colors.white)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.play_arrow,
                                          color: Colors.black87,
                                          size: 28,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Assistir",
                                          style: TextStyle(
                                            fontFamily: 'Confortaa',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: RaisedButton(
                                    color: Color(0xff212121),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(3.0),
                                        side:
                                            BorderSide(color: Color(0xff212121))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Minha lista",
                                          style: TextStyle(
                                            fontFamily: 'Confortaa',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
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
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                  ),
                                  Text(
                                    'Minha lista',
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
                                posterUrls: myList(_upcoming.results, 0, 20),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: CustomBottomNavBar(),
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
