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

  Widget getWebView(String url) {
    return WebView(
      initialUrl: url,
    );
  }

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
      child: Container(
        width: .85 * MediaQuery.of(context).size.width,
        // padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              newsArticle.imageUrl,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Text(
                newsArticle.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
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
