/* 爆款 */
import 'package:flutter/material.dart';

class BestSelling extends StatefulWidget {
  BestSelling({Key? key}) : super(key: key);

  @override
  _BestSellingState createState() => _BestSellingState();
}

class _BestSellingState extends State<BestSelling> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.blue,
      alignment: Alignment.center,
      child: Text('爆款推荐', style: TextStyle(color: Colors.white)),
    );
  }
}
