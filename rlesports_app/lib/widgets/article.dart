import 'package:flutter/material.dart';
import 'package:rlesports_app/models/news_article.dart';

class Article extends StatelessWidget {
  final NewsArticle newsArticle;

  const Article({
    Key? key,
    required this.newsArticle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .85 * MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            newsArticle.imageUrl,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              newsArticle.title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            newsArticle.subTitle.substring(
                    0,
                    100 < newsArticle.subTitle.length
                        ? 100
                        : newsArticle.subTitle.length) +
                "...",
          ),
        ],
      ),
    );
  }
}
