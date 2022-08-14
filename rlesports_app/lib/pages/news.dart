import 'package:flutter/material.dart';
import 'package:rlesports_app/models/news_article.dart';
import 'package:rlesports_app/services/shiftgg.dart' as shiftgg;
import 'package:rlesports_app/widgets/background.dart';
import 'package:rlesports_app/widgets/frosted_pane.dart';
import 'package:rlesports_app/widgets/article.dart';

class NewsPage extends StatelessWidget {
  // TODO: this should probably be stateful
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
      child: FrostedPane(
          bottomPadding: 25,
          child: FutureBuilder(
            future: articles,
            builder:
                (BuildContext context, AsyncSnapshot<List<NewsArticle>> snap) {
              if (snap.data == null) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: snap.data!.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: const Center(child: Text("News")));
                  }
                  return Article(
                    newsArticle: snap.data![index - 1],
                  );
                },
              );
            },
          )),
    );
  }
}
