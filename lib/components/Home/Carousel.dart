import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.blue,
      alignment: Alignment.center,
      child: Text('轮播图', style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
