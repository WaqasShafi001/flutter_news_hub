import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_hub/common/app_colors.dart';
import 'package:flutter_news_hub/common/app_strings.dart';
import 'package:flutter_news_hub/common/app_urls.dart';
import 'package:flutter_news_hub/features/news_home/presentation/widgets/article_view.dart';
import 'package:get/get.dart';

class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content, posturl;
  final bool isFavorite;
  final VoidCallback? callback;

  const NewsTile(
      {super.key,
      required this.imgUrl,
      required this.desc,
      required this.title,
      required this.content,
      required this.posturl,
      required this.isFavorite,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleView(
                postUrl: posturl,
              ),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(bottom: height * 0.025),
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.036),
            child: Card(
              elevation: 3,
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imgUrl,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Image.network(
                        AppUrls.defaultImageUrl,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      progressIndicatorBuilder: (context, url, progress) =>
                          const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: Text(
                      title,
                      maxLines: 2,
                      style: const TextStyle(
                        color: AppColors.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: Text(
                      desc,
                      maxLines: 2,
                      style: const TextStyle(
                        color: AppColors.textColorDim,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  IconButton(
                    onPressed: callback,
                    icon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.favorite_rounded,
                          color: isFavorite
                              ? AppColors.deepPurple
                              : AppColors.textColorDim,
                        ),
                        SizedBox(
                          width: width * 0.015,
                        ),
                        Text(
                          isFavorite ? AppStrings.dislike : AppStrings.like,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
