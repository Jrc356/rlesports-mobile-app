import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:rlesports_app/models/news_article.dart';

const String shiftUrl = "https://www.shiftrle.gg";

Future<List<NewsArticle>> getArticles() async {
  // TODO this just gets the first page of articles, want to get all
  List<NewsArticle> articles = [];

  http.Response res = await http.get(Uri.parse(shiftUrl));
  if (res.statusCode == 200) {
    Document document = html.parse(res.body);
    List<Element> entries = document.getElementsByClassName("entry");

    for (Element entry in entries) {
      Element imgLink = entry.children[0].children[0];
      String? imageUrl = imgLink.children[0].attributes["data-src"];
      String? articleStub = imgLink.attributes["href"];

      String title = entry.children[2].children[1].children[0].innerHtml;
      String articleUrl = "$shiftUrl$articleStub";

      articles.add(NewsArticle(
        imageUrl: imageUrl as String,
        title: title,
        articleUrl: articleUrl,
      ));
    }
  }

  return articles;
}
