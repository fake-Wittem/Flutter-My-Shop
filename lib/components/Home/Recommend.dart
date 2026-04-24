/* 推荐 */
import 'package:flutter/material.dart';

class Recommend extends StatefulWidget {
  Recommend({Key? key}) : super(key: key);

  @override
  _RecommendState createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 300,
        alignment: Alignment.center,
        color: Colors.blue,
        child: Text('推荐', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
