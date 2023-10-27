import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../resources/resources.dart';
import '../../../app.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(context),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          var cubit = context.read<SettingsCubit>();

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
              title: Text(Res.string.settings),
            ),
            body: ListView(
              children: [
                SettingsListItem(
                  title: Res.string.changePassword,
                  callback: cubit.navigateToChangePassword,
                ),
                SettingsListItem(
                  title: Res.string.changeLanguage,
                  callback: cubit.changeLanguage,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
