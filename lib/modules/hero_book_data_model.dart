import 'package:flutter/material.dart';

class HeroBookData {
  final String img;
  final String textHead;
  final String textDesc;
  final Color groundColor;

  HeroBookData({
    required this.textHead,
    required this.textDesc,
    required this.groundColor,
    required this.img,
  });
}

HeroBookData book1 = HeroBookData(
  textHead: "may books",
  textDesc:
      "The fascinating story of how the Chinese language revolutionized the world of computing,an eye-opening investigation into charitable crowdfunding for healthcare in the United States, a collection of essays that explores and celebrates Dungeons & Dragons’ legacy, and more",
  groundColor: Color(0xffC2B66C),
  img: "assets/img/books/LAM.jpeg",
);
HeroBookData book2 = HeroBookData(
  textHead: "may books",
  textDesc:
      "The fascinating story of how the Chinese language revolutionized the world of computing,an eye-opening investigation into charitable crowdfunding for healthcare in the United States, a collection of essays that explores and celebrates Dungeons & Dragons’ legacy, and more",
  groundColor: Color(0xffF8920A),
  img: "assets/img/books/OIP.jpeg",
);
List<HeroBookData> heroBookData = [book1, book2];
