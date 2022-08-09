import 'package:flutter/material.dart';
import 'package:rlesports_app/models/news_article.dart';
import 'package:rlesports_app/widgets/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Article extends StatelessWidget {
  final NewsArticle newsArticle;

  const Article({
    Key? key,
    required this.newsArticle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewLoad(
              articleUrl: newsArticle.articleUrl,
            ),
          ),
        )
      },
      // TODO: Include source
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            children: [
              Image.network(
                newsArticle.imageUrl,
                height: 234,
                width: 480,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                  newsArticle.title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WebViewLoad extends StatefulWidget {
  final String articleUrl;
  const WebViewLoad({Key? key, required this.articleUrl}) : super(key: key);

  @override
  WebViewLoadUI createState() => WebViewLoadUI();
}

class WebViewLoadUI extends State<WebViewLoad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const RLAppBar(
          useBackButton: true,
          useSearchBar: false,
        ),
        body: WebView(
          initialUrl: widget.articleUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
