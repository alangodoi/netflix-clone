import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Netflix'),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
        FlatButton(
          child: Text(
            "Séries",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
          onPressed: () {},
        ),
        FlatButton(
          child: Text(
            "Filmes",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
          onPressed: () {},
        ),
        FlatButton(
          child: Text(
            "Minha lista",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
