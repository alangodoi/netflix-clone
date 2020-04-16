import 'package:flutter/material.dart';

class TopMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.network("https://capas-m.imagemfilmes.com.br/164856_000_m.jpg",
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover);
    // Flex(
    //   direction: Axis.vertical,
    //   children: <Widget>[
    //     Image.network("https://capas-m.imagemfilmes.com.br/164777_000_m.jpg", fit: BoxFit.cover)
    //   ],
    // );
  }
}
