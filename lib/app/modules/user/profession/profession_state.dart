part of 'profession_cubit.dart';

class ProfessionState extends Equatable {
  const ProfessionState({
    this.professions = const [],
    this.page = 0,
    this.loading = false,
    this.title = '',
    this.appBarTitle = '',
    this.message = '',
    this.apiResponseStatus,
    this.categoryName = '',
    this.subCategoryName = '',
    this.sub2CategoryName = '',
    this.sub3CategoryName = '',
    this.categories,
    this.subCategoriesList,
    this.sub2CategoriesList,
    this.sub3CategoriesList,
  });

  final List<Map<String, dynamic>> professions;
  final int page;
  final bool loading;
  final String title;
  final String appBarTitle;
  final String message;
  final ApiResponseStatus? apiResponseStatus;
  final String categoryName;
  final String subCategoryName;
  final String sub2CategoryName;
  final String sub3CategoryName;
  final List<CategoriesResponseData>? categories;
  final List<SubCategoriesData>? subCategoriesList;
  final List<Sub2CategoriesData>? sub2CategoriesList;
  final List<Sub3CategoriesData>? sub3CategoriesList;

  @override
  List<Object?> get props => [
        professions,
        page,
        loading,
        title,
        appBarTitle,
        message,
        apiResponseStatus,
        categoryName,
        subCategoryName,
        sub2CategoryName,
        sub3CategoryName,
        categories,
        subCategoriesList,
        sub2CategoriesList,
        sub3CategoriesList,
      ];

  ProfessionState copyWith({
    List<Map<String, dynamic>>? professions,
    int? page,
    bool? loading,
    String? title,
    String? appBarTitle,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    String? categoryName,
    String? subCategoryName,
    String? sub2CategoryName,
    String? sub3CategoryName,
    List<CategoriesResponseData>? categories,
    List<SubCategoriesData>? subCategoriesList,
    List<Sub2CategoriesData>? sub2CategoriesList,
    List<Sub3CategoriesData>? sub3CategoriesList,
  }) {
    return ProfessionState(
      professions: professions ?? this.professions,
      page: page ?? this.page,
      loading: loading ?? this.loading,
      title: title ?? this.title,
      appBarTitle: appBarTitle ?? this.appBarTitle,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      categoryName: categoryName ?? this.categoryName,
      subCategoryName: subCategoryName ?? this.subCategoryName,
      sub2CategoryName: sub2CategoryName ?? this.sub2CategoryName,
      sub3CategoryName: sub3CategoryName ?? this.sub3CategoryName,
      categories: categories ?? this.categories,
      subCategoriesList: subCategoriesList ?? this.subCategoriesList,
      sub2CategoriesList: sub2CategoriesList ?? this.sub2CategoriesList,
      sub3CategoriesList: sub3CategoriesList ?? this.sub3CategoriesList,
    );
  }
}
