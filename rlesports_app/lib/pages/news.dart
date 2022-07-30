import 'package:flutter/material.dart';
import 'package:rlesports_app/models/news_article.dart';
import 'package:rlesports_app/services/shiftgg.dart' as shiftgg;
import 'package:rlesports_app/widgets/background.dart';
import 'package:rlesports_app/widgets/frosted_pane.dart';
import 'package:rlesports_app/widgets/article.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  Future<List<NewsArticle>> getAllArticles() {
    // TODO: add way to enable/disable different article sources
    // TODO: add other article getters
    Future<List<NewsArticle>> articles = shiftgg.getArticles();
    return articles;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<NewsArticle>> articles = getAllArticles();
    return Background(
      child: FutureBuilder(
        future: articles,
        builder: (BuildContext context, AsyncSnapshot<List<NewsArticle>> snap) {
          if (snap.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snap.data?.length,
            itemBuilder: (context, index) {
              return FrostedPane(
                child: Article(
                  newsArticle: snap.data![index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
