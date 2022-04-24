import 'package:flutter/material.dart';
import 'package:rlesports_app/models/news_article.dart';
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/widgets/frosted_pane.dart';
import 'package:rlesports_app/widgets/article.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  Future<List<NewsArticle>> getArticles() {
    // TODO: add way to enable/disable different article sources
    // TODO: add other article getters
    Future<List<NewsArticle>> articles = getShiftArticles();
    return articles;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<NewsArticle>> articles = getArticles();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.rlOrange.withOpacity(.8),
            AppColors.rlBlue.withOpacity(.8),
          ],
        ),
      ),
      child: FutureBuilder(
        future: articles,
        builder: (BuildContext context, AsyncSnapshot<List<NewsArticle>> snap) {
          if (snap.connectionState == ConnectionState.none ||
              snap.data == null) {
            return const CircularProgressIndicator();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(10),
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
