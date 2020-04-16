// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HorizontalListItem extends StatelessWidget {
  final String link;
  final double defaultWidth = 110;

  HorizontalListItem({@required final this.link});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: link,
          width: defaultWidth,
        ),
      ],
    );
  }
}
