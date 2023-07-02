import 'package:flutter/material.dart';

import '../../../../../../../../resources/resources.dart';
import '../../../../../sdk/sdk.dart';

class SubCategoryPage extends StatelessWidget {
  const SubCategoryPage({
    super.key,
    this.subCategoriesList,
    this.onItemTap,
  });

  final List<SubCategoriesData>? subCategoriesList;
  final Function(SubCategoriesData subCategoriesData)? onItemTap;

  @override
  Widget build(BuildContext context) {
    final darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return subCategoriesList == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            itemCount: subCategoriesList!.length,
            separatorBuilder: (c, i) => const Divider(height: 0),
            itemBuilder: (context, index) {
              var item = subCategoriesList![index];

              return ListTile(
                title: Text(
                  item.subCategory ?? '',
                  style: TextStyle(
                    color: darkMode
                        ? Res.colors.textColorDark
                        : Res.colors.textColor,
                  ),
                ),
                onTap: onItemTap != null
                    ? () {
                        onItemTap!(item);
                      }
                    : null,
              );
            },
          );
  }
}
