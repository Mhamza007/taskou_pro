import 'package:flutter/material.dart';

import '../../../../../../../../resources/resources.dart';
import '../../../../../sdk/sdk.dart';

class Sub3CategoryPage extends StatelessWidget {
  const Sub3CategoryPage({
    super.key,
    this.sub3CategoriesList,
    this.onItemTap,
  });

  final List<Sub3CategoriesData>? sub3CategoriesList;
  final Function(Sub3CategoriesData sub3CategoriesData)? onItemTap;

  @override
  Widget build(BuildContext context) {
    final darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return sub3CategoriesList == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            itemCount: sub3CategoriesList!.length,
            separatorBuilder: (c, i) => const Divider(height: 0),
            itemBuilder: (context, index) {
              var item = sub3CategoriesList![index];

              return ListTile(
                title: Text(
                  item.subSubSubCatName ?? '',
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
