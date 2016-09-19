import 'package:gdgflutter/model/articles/Article.dart';
import 'package:flutter/http.dart';
import 'dart:async';
import 'dart:convert';

class ArticleRepository {

  static const _ENDPOINT = 'https://api.nytimes.com/svc/mostpopular/v2/mostemailed/all-sections/1.json';

  // Shouldn't be public, but... oh well.
  static const _API_KEY = 'f06ceeaa849e4b14a8bcdbb6ea21ef35';

  Future<List<Article>> fetchArticles() {
    return get('$_ENDPOINT?api-key=$_API_KEY')
      .asStream()
      .map((response) {
        return response.body;
      })
      .transform(JSON.decoder)
      .map((jsonBody) {
        return jsonBody['results'];
      })
      .expand((jsonList) {
        return jsonList;
      })
      .map((item) => new Article(
        title: item['title'],
        imageUrl: _urlFromArticleItem(item)
      ))
      .toList();
  }

  String _urlFromArticleItem(item) {
    return item['media'][0]['media-metadata'][2]['url'];
  }

}
