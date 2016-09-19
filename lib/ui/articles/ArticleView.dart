import 'package:flutter/material.dart';
import 'package:gdgflutter/model/articles/Article.dart';

class ArticleView extends StatelessWidget {

  Article article;
  double textSize = 16.0;

  ArticleView({this.article, this.textSize});

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: FractionalOffset.bottomLeft,
      children: [
        new Image.fromNetwork(
          src: article.imageUrl,
          width: 400.0,
          height: 250.0
        ),
        titleBlock()
      ]
    );
  }

  Widget titleBlock() {
    return new Block(
      children: [
        new DecoratedBox(
          decoration: titleDecoration(),
          child: textWithPadding()
        )
      ]
    );
  }

  Widget textWithPadding() {
    return new Padding(
      padding: new EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0
      ),
      child: new Text(
        article.title,
        textAlign: TextAlign.left,
        style: new TextStyle(
          color: new Color.fromARGB(255, 255, 255, 255),
          fontSize: textSize
        )
      )
    );
  }

  Decoration titleDecoration() {
    return new BoxDecoration(
      gradient: titleGradient()
    );
  }

  Gradient titleGradient() {
    return new LinearGradient(
      begin: FractionalOffset.bottomCenter,
      end: new FractionalOffset(0.5, -1.0),
      colors: [
        new Color.fromARGB(200, 0, 0, 0),
        new Color.fromARGB(0, 0, 0, 0)
      ]
    );
  }

}
