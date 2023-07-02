import 'package:flutter/material.dart';

import '../../../../../../../../resources/resources.dart';
import '../../../../../sdk/sdk.dart';

class Sub2CategoryPage extends StatelessWidget {
  const Sub2CategoryPage({
    super.key,
    this.sub2CategoriesList,
    this.onItemTap,
  });

  final List<Sub2CategoriesData>? sub2CategoriesList;
  final Function(Sub2CategoriesData sub2CategoriesData)? onItemTap;

  @override
  Widget build(BuildContext context) {
    final darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return sub2CategoriesList == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            itemCount: sub2CategoriesList!.length,
            separatorBuilder: (c, i) => const Divider(height: 0),
            itemBuilder: (context, index) {
              var item = sub2CategoriesList![index];

              return ListTile(
                title: Text(
                  item.subSubCatName ?? '',
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
