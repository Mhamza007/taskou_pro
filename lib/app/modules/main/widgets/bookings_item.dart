import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../configs/configs.dart';
import '../../../../resources/resources.dart';
import '../../../app.dart';

class BookingsItem extends StatelessWidget {
  const BookingsItem({
    super.key,
    required this.bookingType,
    required this.profileImage,
    required this.title,
    this.dateTime,
    required this.location,
    required this.scheduleFor,
    this.scheduled,
    this.bookingStatus,
    this.acceptCallback,
    this.rejectCallback,
    this.tapCallback,
  });

  final BookingType bookingType;
  final String profileImage;
  final String title;
  final String? dateTime;
  final String location;
  final String scheduleFor;
  final String? scheduled;
  final String? bookingStatus;
  final Function()? acceptCallback;
  final Function()? rejectCallback;
  final Function()? tapCallback;

  String _getBookingStatus() {
    switch (bookingType) {
      case BookingType.newRequest:
        return Res.string.newRequest;
      case BookingType.past:
        return Res.string.completed;
      case BookingType.running:
        return bookingStatus == '2'
            ? Res.string.accepted
            : bookingStatus == '3'
                ? Res.string.arrived
                : bookingStatus == '4'
                    ? Res.string.workStarted
                    : '';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Res.colors.materialColor,
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileImage.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: CachedNetworkImage(
                            imageUrl: '${HTTPConfig.imageBaseURL}$profileImage',
                            width: 44.0,
                            height: 44.0,
                            fit: BoxFit.scaleDown,
                            errorWidget: (context, url, error) {
                              return SvgPicture.asset(
                                Res.drawable.userAvatar,
                                width: 44.0,
                                height: 44.0,
                                fit: BoxFit.scaleDown,
                              );
                            },
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: SvgPicture.asset(
                            Res.drawable.userAvatar,
                            width: 44.0,
                            height: 44.0,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        if (dateTime != null)
                          Text(
                            dateTime!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        if (dateTime != null) const SizedBox(height: 2.0),
                        Text(
                          location,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        if (bookingType == BookingType.newRequest)
                          Text(
                            '${Res.string.scheduleFor}: $scheduleFor',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        if (bookingType == BookingType.newRequest)
                          const SizedBox(height: 8.0),
                        if (bookingType == BookingType.newRequest)
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: acceptCallback,
                                  child: Text(
                                    Res.string.accept,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: rejectCallback,
                                  child: Text(
                                    Res.string.reject,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ).paddingAll(12.0),
            ],
          ),
          Positioned(
            right: 8.0,
            top: 8.0,
            child: Text(
              _getBookingStatus(),
              style: TextStyle(
                color: Res.colors.chestnutRedColor,
              ),
            ),
          ),
        ],
      ),
    ).onTap(
      tapCallback,
    );
  }
}
