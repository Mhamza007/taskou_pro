import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../resources/resources.dart';
import '../../../app.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HelpCubit(context),
      child: BlocBuilder<HelpCubit, HelpState>(
        builder: (context, state) {
          var cubit = context.read<HelpCubit>();

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
              title: Text(Res.string.help),
            ),
            body: ListView(
              children: [
                SettingsListItem(
                  title: Res.string.faq,
                  callback: cubit.faq,
                ),
                const Divider(
                  thickness: 2,
                  height: 0,
                ),
                SettingsListItem(
                  title: Res.string.privacyPolicy,
                ),
                const Divider(
                  thickness: 2,
                  height: 0,
                ),
                SettingsListItem(
                  title: Res.string.termsConditions,
                ),
                const Divider(
                  thickness: 2,
                  height: 0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
