import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';
import 'package:mongol_ebook/Model/article.dart';
import 'package:mongol_ebook/Model/top_article.dart';
import 'package:mongol_ebook/widgets/common/rounded_image.dart';

class CategorizedNews extends StatelessWidget {
  static const placeholder1 =
      "https://pbs.twimg.com/profile_images/883859744498176000/pjEHfbdn_400x400.jpg";
  static const placeholder2 =
      "https://discovery.sndimg.com/content/dam/images/discovery/fullset/2020/1/8/honeybees_articleimage.jpg.rend.hgtvcom.616.347.suffix/1578499708500.jpeg";
  static const placeholder3 =
      "https://shopee.co.id/inspirasi-shopee/wp-content/uploads/2019/01/coveteur_marie_kondo_238_preview_maxwidth_2000_maxheight_2000_ppi_300_embedmetadata_true.jpg";
  static const placeholder4 =
      "https://st2.depositphotos.com/2256213/12010/i/950/depositphotos_120104944-stock-photo-colloseum-rome-italy.jpg";

  static const _imageSize = 80.0;

  final NewArticle article;
  final VoidCallback onTap;

  const CategorizedNews({Key? key, required this.article, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imgUrl = "";

    switch (article.id % 4) {
      case 1:
        imgUrl = placeholder1;
        break;
      case 2:
        imgUrl = placeholder2;
        break;
      case 3:
        imgUrl = placeholder3;
        break;
      default:
        imgUrl = placeholder4;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _imageSize,
        height: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedImage(
              size: _imageSize,
              imageUrl: imgUrl,
            ),
            SizedBox(
              height: 16.0,
            ),
            Flexible(
              child: MongolText(
                article.title,
                maxLines: 3,
                style: Theme.of(context).textTheme.headline2!,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
