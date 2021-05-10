import 'package:flutter/material.dart';
import 'package:mongol_ebook/Model/news_category.dart';
import 'package:mongol_ebook/widgets/screens/home_screen/news_screen/category_pills.dart';

class CategoryList extends StatelessWidget {
  final SetCategoryCallback setCategoryCallback;
  final List<NewsCategory> categories;

  const CategoryList(
      {Key? key, required this.setCategoryCallback, required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return categories.isNotEmpty
        ? Container(
            height: 120.0,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var category = categories[index];
                return InkWell(
                    onTap: () => setCategoryCallback(category),
                    child: Container(
                        margin: index != categories.length - 1
                            ? const EdgeInsets.only(left: 16.0)
                            : const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CategoryPill(text: category.categoryName)));
              },
              separatorBuilder: (context, index) => SizedBox(
                width: 0.0,
              ),
              itemCount: categories.length,
            ),
          )
        : Container();
  }
}

typedef SetCategoryCallback = void Function(NewsCategory category);
