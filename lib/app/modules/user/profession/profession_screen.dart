import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../resources/resources.dart';
import '../../../app.dart';

class ProfessionScreen extends StatelessWidget {
  const ProfessionScreen({
    super.key,
    this.professionsData,
  });

  final Map? professionsData;

  @override
  Widget build(BuildContext context) {
    bool darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return BlocProvider(
      create: (context) => ProfessionCubit(
        context,
        professionsData: professionsData,
      ),
      child: BlocConsumer<ProfessionCubit, ProfessionState>(
        listenWhen: (previous, current) {
          return previous.apiResponseStatus != current.apiResponseStatus;
        },
        listener: (context, state) {
          switch (state.apiResponseStatus) {
            case ApiResponseStatus.failure:
              Helpers.errorSnackBar(
                context: context,
                title: state.message,
              );
              break;
            default:
          }
        },
        builder: (context, state) {
          var cubit = context.read<ProfessionCubit>();

          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: cubit.back,
                child: SvgPicture.asset(
                  Res.drawable.back,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
              title: Text(state.appBarTitle),
              actions: [
                if (state.page == 0)
                  IconButton(
                    onPressed: cubit.addProfession,
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
              ],
            ),
            body: PageView(
              controller: cubit.pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: cubit.onPageChanged,
              children: [
                ProfessionsListing(
                  loading: state.loading,
                  professions: state.professions,
                  deleteCallback: cubit.deleteProfession,
                ),
                CategoryPage(
                  resultList: state.categories,
                  itemCallback: cubit.getSubCategories,
                ),
                SubCategoryPage(
                  subCategoriesList: state.subCategoriesList,
                  onItemTap: cubit.onSubCategoryClicked,
                ),
                Sub2CategoryPage(
                  sub2CategoriesList: state.sub2CategoriesList,
                  onItemTap: cubit.onSub2CategoryClicked,
                ),
                Sub3CategoryPage(
                  sub3CategoriesList: state.sub3CategoriesList,
                  onItemTap: cubit.onSub3CategoryClicked,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
