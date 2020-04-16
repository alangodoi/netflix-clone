import 'package:flutter/material.dart';
import 'package:netflix/widgets/horizontal_list_item.dart';

class HorizontalList extends StatelessWidget {
  final List<String> posterUrls;
  HorizontalList({this.posterUrls});

  final List<Widget> _horizontalListItem = List<Widget>();

  List<Widget> buildTile() {
    // for (var i = 0; i < posterUrls.length; i++) {
    for (var i = 0; i < 9; i++) {
      _horizontalListItem.add(SizedBox(
        width: 10,
      ));
      _horizontalListItem.add(HorizontalListItem(
        link: "https://image.tmdb.org/t/p/original/" + posterUrls[i],
        // "https://image.tmdb.org/t/p/original/qa6HCwP4Z15l3hpsASz3auugEW6.jpg",
      ));
    }

    return _horizontalListItem;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // This next line does the trick.
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        itemBuilder: (context, position) {
          return Row(children: buildTile());
        });
  }
}
