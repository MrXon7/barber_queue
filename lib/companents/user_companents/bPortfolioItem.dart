import 'package:flutter/material.dart';

class BportfolioItem extends StatelessWidget {
  final url;
  const BportfolioItem({
    super.key,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              // color: Colors.amber, 
              borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(url['url'], fit: BoxFit.fill)),
        );
      },
    );
  }
}
