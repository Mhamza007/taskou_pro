import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../resources/resources.dart';
import '../../../../sdk/sdk.dart';
import 'my_reviews.dart';

class MyReviewsScreen extends StatelessWidget {
  const MyReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyReviewsCubit(
        context,
      ),
      child: BlocBuilder<MyReviewsCubit, MyReviewsState>(
        builder: (context, state) {
          var cubit = context.read<MyReviewsCubit>();

          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: Get.back,
                child: SvgPicture.asset(
                  Res.drawable.back,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
              title: Text(
                Res.string.myReview,
              ),
            ),
            body: state.handymanReviews == null || state.loading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: state.handymanReviews!
                        .map(
                          (handymanReview) => HandymanReviewWidget(
                            cubit: cubit,
                            handymanReview: handymanReview,
                          ),
                        )
                        .toList(),
                  ),
          );
        },
      ),
    );
  }
}

class HandymanReviewWidget extends StatelessWidget {
  const HandymanReviewWidget({
    super.key,
    required this.cubit,
    required this.handymanReview,
  });

  final MyReviewsCubit cubit;
  final HandymanReviewData handymanReview;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xfff2f1f7),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Res.colors.materialColor,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (handymanReview.comentedBy != null)
            Text(
              handymanReview.comentedBy!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          if (handymanReview.rating != null &&
              handymanReview.rating!.isNotEmpty)
            RatingBar.builder(
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Res.colors.materialColor,
              ),
              allowHalfRating: true,
              onRatingUpdate: (value) {},
              ignoreGestures: true,
              itemSize: 24,
              initialRating: cubit.getRating(handymanReview.rating),
            ).marginSymmetric(
              vertical: 8.0,
            ),
          Text(
            handymanReview.message ?? '',
          ),
        ],
      ).paddingAll(12.0),
    );
  }
}
