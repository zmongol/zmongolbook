import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Model/article.dart';

class PriorityNews extends StatelessWidget {
  static const double _height = 200;
  final NewArticle article;
  final VoidCallback onTap;

  const PriorityNews({Key? key, required this.article, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: _height,
          child: Stack(
            children: [
              //TODO: Replace placeholder with iamge from backend
              Image.network(
                article.imageUrl ??
                    "https://images.barrons.com/im-335962?width=1260&size=1.5",
                fit: BoxFit.cover,
                height: _height,
                width: double.infinity,
              ),
              Container(
                height: _height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                        begin: FractionalOffset.centerLeft,
                        end: FractionalOffset.centerRight,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7)
                        ],
                        stops: [
                          0.0,
                          1.0
                        ])),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      width: 100.0,
                      margin: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          MongolText(
                            article.title,
                            maxLines: 3,
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: Colors.white),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Flexible(
                            child: MongolText(
                              article.content,
                              maxLines: 4,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(color: Colors.white),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      )))
            ],
          )),
    );
  }
}
