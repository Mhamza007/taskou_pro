import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../resources/resources.dart';
import '../../../app.dart';

class UpdatePriceScreen extends StatelessWidget {
  const UpdatePriceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePriceCubit(context),
      child: BlocBuilder<UpdatePriceCubit, UpdatePriceState>(
        builder: (context, state) {
          var cubit = context.read<UpdatePriceCubit>();

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
                Res.string.updateYourPrice,
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text(
                  Res.string.ratePerHour,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: cubit.rateController,
                  decoration: InputDecoration(
                    hintText: Res.string.ratePerHour,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Res.colors.ghostGreyColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Res.colors.ghostGreyColor,
                      ),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9.]'),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: state.loading ? null : cubit.update,
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      const Size(double.maxFinite, 48.0),
                    ),
                  ),
                  child: state.loading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Res.colors.materialColor,
                          ),
                        )
                      : Text(
                          Res.string.update,
                        ).paddingAll(16.0),
                ),
              ],
            ).onTap(Helpers.unFocus),
          );
        },
      ),
    );
  }
}
