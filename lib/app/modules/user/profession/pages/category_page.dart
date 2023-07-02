import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../resources/resources.dart';
import '../../../../../configs/configs.dart';
import '../../../../../sdk/sdk.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    super.key,
    this.resultList,
    this.itemCallback,
  });

  final List<CategoriesResponseData>? resultList;
  final Function(String categoryId, String categoryName)? itemCallback;

  @override
  Widget build(BuildContext context) {
    final darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return resultList == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            itemCount: resultList!.length,
            separatorBuilder: (c, i) => const Divider(height: 0),
            itemBuilder: (context, index) {
              var item = resultList![index];

              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: '${HTTPConfig.imageBaseURL}${item.categoryImage}',
                  progressIndicatorBuilder: (
                    context,
                    url,
                    downloadProgress,
                  ) {
                    return CircularProgressIndicator(
                      value: downloadProgress.progress,
                    );
                  },
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                  height: 24,
                  width: 24,
                  memCacheHeight: 96,
                  memCacheWidth: 96,
                ),
                title: Text(
                  item.categoryName ?? '',
                  style: TextStyle(
                    color: darkMode
                        ? Res.colors.textColorDark
                        : Res.colors.textColor,
                  ),
                ),
                onTap: (itemCallback != null &&
                        item.catId != null &&
                        item.categoryName != null)
                    ? () {
                        itemCallback!(
                          item.catId!,
                          item.categoryName!,
                        );
                      }
                    : null,
              );
            },
          );
  }
}
