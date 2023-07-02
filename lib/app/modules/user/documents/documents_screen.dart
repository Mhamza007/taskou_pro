import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../resources/resources.dart';
import '../../../app.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({
    super.key,
    this.documentsData,
  });

  final Map? documentsData;

  @override
  Widget build(BuildContext context) {
    bool darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return BlocProvider(
      create: (context) => DocumentsCubit(
        context,
        documentsData: documentsData,
      ),
      child: BlocConsumer<DocumentsCubit, DocumentsState>(
        listenWhen: (prev, curr) =>
            prev.apiResponseStatus != curr.apiResponseStatus,
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
          var cubit = context.read<DocumentsCubit>();

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
              title: Text(
                Res.string.addDocuments,
              ),
            ),
            body: Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.all(16.0),
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Text(
                      Res.string.identityProof_,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        _addWidget(
                          darkMode,
                          title: Res.string.front,
                          callback: cubit.idFrontCallback,
                          filePath: state.idProofFront,
                        ),
                        const SizedBox(width: 8.0),
                        _addWidget(
                          darkMode,
                          title: Res.string.back,
                          callback: cubit.idBackCallback,
                          filePath: state.idProofBack,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      Res.string.certificateIfAny,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        _addWidget(
                          darkMode,
                          title: Res.string.front,
                          callback: cubit.certificateFrontCallback,
                          filePath: state.certificateFront,
                        ),
                        const SizedBox(width: 8.0),
                        _addWidget(
                          darkMode,
                          title: Res.string.back,
                          callback: cubit.certificateBackCallback,
                          filePath: state.certificateBack,
                        ),
                      ],
                    ),
                  ],
                ),
                if (state.loading)
                  CupertinoAlertDialog(
                    title: const CupertinoActivityIndicator(),
                    content: Text(Res.string.loading),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _addWidget(
    bool darkMode, {
    required String title,
    Function()? callback,
    String? filePath,
  }) {
    return Expanded(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Card(
              child: filePath != null && filePath.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: filePath.startsWith('http')
                          ? Image.network(
                              filePath,
                              fit: BoxFit.fill,
                            )
                          : Image.file(
                              File(filePath),
                              fit: BoxFit.fill,
                            ),
                    )
                  : AddMediaCircleWidget(
                      child: Icon(
                        Icons.add_rounded,
                        size: 60.0,
                        color: darkMode
                            ? Res.colors.backgroundColorLight
                            : Res.colors.backgroundColorDark,
                      ),
                    ).paddingAll(16.0),
            ).onTap(callback),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
