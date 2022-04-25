import 'package:flutter/material.dart';
import 'package:rlesports_app/models/news_article.dart';
import 'package:rlesports_app/services/shiftgg.dart' as shiftgg;
import 'package:rlesports_app/theme/colors.dart';
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
          if (snap.data == null) {
            return const Center(child: CircularProgressIndicator());
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
