import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Model/article.dart';

class TopStory extends StatelessWidget {
  static const height = 200.0;
  static const width = 160.0;
  static const placeholder1 =
      "https://a3.espncdn.com/combiner/i?img=%2Fphoto%2F2021%2F0509%2Fr851774_1296x729_16%2D9.jpg&w=1140&cquality=40&format=jpg";
  static const placeholder2 =
      "https://media.cntraveler.com/photos/57fea9ec8584f8cd20e65f15/16:9/w_1600,c_limit/Aerial-One&OnlyReethiRah-Maldives-CRHotel.jpg";
  final NewArticle article;
  final VoidCallback onTap;

  const TopStory({Key? key, required this.article, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('yyyy-MM-dd');
    String date = article.dateCreated != null
        ? formatter.format(article.dateCreated!)
        : '';

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
            height: height,
            width: width,
            child: Stack(
              children: [
                Image.network(
                  //TODO: Replace placeholder with iamge from backend
                  article.imageUrl ?? _getPlaceholder(),
                  fit: BoxFit.cover,
                  height: height,
                  width: double.infinity,
                ),
                Container(
                  height: height,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MongolText(
                              article.title,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(color: Colors.white),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MongolText(
                                  date,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 24.0,
                                ),
                                MongolText(
                                  article.author,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                            // Flexible(
                            //   child: MongolText(
                            //     article.content,
                            //     maxLines: 4,
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .headline2!
                            //         .copyWith(color: Colors.white),
                            //     softWrap: true,
                            //     overflow: TextOverflow.ellipsis,
                            //   ),
                            // )
                          ],
                        )))
              ],
            )),
      ),
    );
  }

  _getPlaceholder() {
    return (article.id % 2 == 1) ? placeholder1 : placeholder2;
  }
}
