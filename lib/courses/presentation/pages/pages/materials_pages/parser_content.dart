import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

class ParsedContent {
  final List<String> textWithNames;
  final List<String> urlTexts;

  ParsedContent({required this.textWithNames, required this.urlTexts});
}

ParsedContent parseContent(String htmlContent) {
  final document = html_parser.parse(htmlContent);

  final textWithNames = <String>[];
  final urlTexts = <String>[];

  final paragraphs = document.querySelectorAll('p');

  for (var p in paragraphs) {
    final links = p.querySelectorAll('a');
    if (links.isNotEmpty) {
      final String textWithoutLinks =
          p.nodes
              .where((node) => node.nodeType == dom.Node.TEXT_NODE)
              .map((node) => node.text)
              .join()
              .trim();

      textWithNames.add(textWithoutLinks);

      urlTexts.add(links.first.attributes['href'] ?? '');
    }
  }

  return ParsedContent(textWithNames: textWithNames, urlTexts: urlTexts);
}
