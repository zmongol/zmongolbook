import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Model/article.dart';

class BookWidget extends StatelessWidget {
  static const _height = 300.0;

  // Temporarily use Article model
  final NewArticle book;
  // final double width;

  const BookWidget({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDetailPage(context, book.id),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(4)),
        child: Container(
          height: _height,
          margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  book.imageUrl ?? "https://picsum.photos/250?image=9",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  alignment: Alignment.topLeft,
                  child: MongolText(
                    book.title,
                    style: Theme.of(context).textTheme.displayMedium,
                    //maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openDetailPage(BuildContext context, int id) {
    Navigator.of(context).pushNamed('/detail', arguments: {'index': id});
  }
}
