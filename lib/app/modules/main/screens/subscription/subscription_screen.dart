import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../resources/resources.dart';
import '../../../../app.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return BlocProvider(
      create: (context) => SubscriptionCubit(context),
      child: BlocBuilder<SubscriptionCubit, SubscriptionState>(
        builder: (context, state) {
          var cubit = context.read<SubscriptionCubit>();

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
              title: Text(Res.string.subscription),
            ),
            body: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text(
                  Res.string.currentPack,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16.0),
                SubscriptionListItem(
                  title: Res.string.freeForNow,
                  subtitle: '2 Months left',
                  points: '150',
                  callback: cubit.itemCallback,
                ),
                const SizedBox(height: 16.0),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: Res.string.allPacks,
                      ),
                      const TextSpan(
                        text: ' (',
                      ),
                      TextSpan(
                        text: Res.string.dzd,
                      ),
                      const TextSpan(
                        text: ') ',
                      ),
                    ],
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: darkMode
                          ? Res.colors.whiteColor
                          : Res.colors.blackColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                SubscriptionListItem(
                  title: Res.string.monthly,
                  points: '150',
                  callback: cubit.itemCallback,
                ),
                const SizedBox(height: 16.0),
                SubscriptionListItem(
                  title: Res.string.sixMonths,
                  points: '250',
                  callback: cubit.itemCallback,
                ),
                const SizedBox(height: 16.0),
                SubscriptionListItem(
                  title: Res.string.yearly,
                  points: '250',
                  callback: cubit.itemCallback,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// e9f71d border
// ffc118 inner
