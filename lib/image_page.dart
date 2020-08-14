import 'dart:io';

import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  File image1;
  ImagePage({this.image1});

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Hero(
            tag: "${widget.image1.path}",
            child: Image.file(widget.image1)),
        ),
      );

  }
}
