import 'package:flutter/material.dart';
import 'package:rlesports_app/models/news_article.dart';
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/widgets/frosted_pane.dart';
import 'package:rlesports_app/widgets/article.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  List<NewsArticle> getArticles() {
    // TODO: Get this from a server as well
    List<NewsArticle> articles = getDummyNewsArticles();
    return articles;
  }

  @override
  Widget build(BuildContext context) {
    List<NewsArticle> articles = getArticles();
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
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return FrostedPane(
            child: Article(
              newsArticle: articles[index],
            ),
          );
        },
      ),
    );
  }
}
