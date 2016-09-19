import 'package:flutter/material.dart';
import 'package:gdgflutter/model/articles/Article.dart';
import 'package:gdgflutter/model/articles/ArticleRepository.dart';
import 'package:gdgflutter/ui/articles/ArticleView.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue
      ),
      home: new FlutterDemo()
    )
  );
}

class FlutterDemo extends StatefulWidget {
  FlutterDemo({ Key key }) : super(key: key);

  @override
  _FlutterDemoState createState() => new _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {

  List<Article> _articles = [];
  AnimationController textAnimationController;
  double textSize = 16.0;

  _FlutterDemoState() {
    new ArticleRepository()
      .fetchArticles()
      .then((articles) => _setArticles(articles));

    setUpAnimations();
  }

  void setUpAnimations() {
    textAnimationController = new AnimationController(
      value: 16.0,
      lowerBound: 16.0,
      upperBound: 32.0,
      duration: new Duration(seconds: 4)
    );
    textAnimationController.view.addListener(
      () => _setTextSize(textAnimationController.view.value)
    );
  }

  void _setArticles(List<Article> articles) {
    setState(() {
      _articles = articles;
    });
  }

  void _increaseTextSize() {
    textAnimationController.animateTo(textSize + 3.0);
  }

  void _setTextSize(double newTextSize) {
    setState(() {
      textSize = newTextSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Demo')
      ),
      body: articlesList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _increaseTextSize,
        tooltip: 'Increase text size',
        child: new Icon(Icons.add)
      )
    );
  }

  Widget articlesList() {
    return new ScrollableViewport(
      child: new Column(
        children: _articles
          .map((article) => new ArticleView(
            article: article,
            textSize: textSize
          ))
          .toList()
      )
    );
  }

}
