import 'package:flutter/material.dart';
import './constants.dart';

class ResultScreen extends StatelessWidget {
  String result;
  ResultScreen({this.result});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
            child: Container(
      height: size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
              "https://images.unsplash.com/photo-1586771107445-d3ca888129ff?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YWdyaWN1bHR1cmV8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
            ),
            fit: BoxFit.cover),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 26.0),
        margin: EdgeInsets.symmetric(
            vertical: size.height * 0.4, horizontal: size.width * 0.1),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 5.0),
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(29.0))),
        child: Text(
          'you should grow $result  in your feild',
          style: kStyle.copyWith(fontSize: 25.0),
        ),
      ),
    )));
  }
}
