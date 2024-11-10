import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peakbit_blog/models/article_list/article_item/article_item_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../article/article_screen.dart';

class ArticleItemWidget extends StatelessWidget {
  final ArticleItemModel article;
  final BuildContext articleContext;

  const ArticleItemWidget(
      {required this.article, required this.articleContext, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(articleContext).push(MaterialPageRoute(builder: (context) => ArticleScreen(id: article.id))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  article.imageUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  errorBuilder: (context, _, __) => Center(
                      child: SvgPicture.asset(
                    "assets/icons/magnifier.svg",
                    height: 140,
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9291B),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/timer.svg",
                        width: 8.51,
                      ),
                      const SizedBox(
                        width: 4.24,
                      ),
                      Text(
                        "${article.readingTime} ${AppLocalizations.of(context)?.minute ?? "perc"}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            article.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 23,
          ),
        ],
      ),
    );
  }
}
