import 'package:flutter/material.dart';

import '../../../../../resources/resources.dart';

class ProfessionsListing extends StatelessWidget {
  const ProfessionsListing({
    super.key,
    this.loading = false,
    required this.professions,
    this.deleteCallback,
  });

  final bool loading;
  final List<Map<String, dynamic>> professions;
  final Function(Map<String, dynamic> item)? deleteCallback;

  String _getTitle(item) {
    var catName = item['cat_name'];
    var sub1Name = item['sub1_name'] != null ? '\n${item['sub1_name']}' : '';
    var sub2Name = item['sub2_name'] != null ? '\n${item['sub2_name']}' : '';
    var sub3Name = item['sub3_name'] != null ? '\n${item['sub3_name']}' : '';

    return catName + sub1Name + sub2Name + sub3Name;
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return loading
        ? Center(
            child: CircularProgressIndicator(
              color: Res.colors.materialColor,
            ),
          )
        : professions.isEmpty
            ? Center(
                child: Text(
                  Res.string.emptyProfessionsMessage,
                ),
              )
            : ListView.separated(
                itemCount: professions.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 0,
                    thickness: 1,
                  );
                },
                itemBuilder: (context, index) {
                  var item = professions[index];
                  return ListTile(
                    title: Text(
                      _getTitle(item),
                    ),
                    trailing: IconButton(
                      onPressed: deleteCallback != null
                          ? () {
                              deleteCallback!(item);
                            }
                          : null,
                      icon: Icon(
                        Icons.delete_outline,
                        color: Res.colors.materialColor,
                      ),
                    ),
                  );
                },
              );
  }
}
