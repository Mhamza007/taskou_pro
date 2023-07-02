import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../resources/resources.dart';
import '../../../../app.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({
    super.key,
    this.bookingData,
  });

  final Map? bookingData;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrackingCubit(
        context,
        bookingData: bookingData,
      ),
      child: BlocBuilder<TrackingCubit, TrackingState>(
        builder: (context, state) {
          var cubit = context.read<TrackingCubit>();

          return WillPopScope(
            onWillPop: cubit.back,
            child: Scaffold(
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
                  Res.string.tracking,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: state.initialCameraPosition,
                            onMapCreated: cubit.onMapCreated,
                            myLocationEnabled: true,
                            myLocationButtonEnabled: false,
                            markers: state.markers,
                            polylines: state.polylines,
                            zoomControlsEnabled: false,
                          ),
                          // if (state.arrived && !state.tracking)
                          //   Positioned(
                          //     right: 8.0,
                          //     child: ElevatedButton(
                          //       onPressed: cubit.startTracking,
                          //       child: Text(
                          //         Res.string.startTracking,
                          //       ),
                          //     ),
                          //   ),
                          if (!state.arrived)
                            Positioned(
                              right: 8.0,
                              bottom: 0.0,
                              child: ElevatedButton(
                                onPressed: cubit.directionCallback,
                                child: Text(
                                  Res.string.direction,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: ListTile(
                        leading: SvgPicture.asset(
                          Res.drawable.userAvatar,
                        ),
                        title: state.userName != null
                            ? Text(
                                state.userName!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                ),
                              )
                            : const SizedBox.shrink(),
                        subtitle: state.address != null
                            ? Text(
                                state.address!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            : const SizedBox.shrink(),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: cubit.call,
                              icon: SvgPicture.asset(
                                Res.drawable.phone,
                                width: 20.0,
                                height: 20.0,
                              ),
                            ),
                            IconButton(
                              onPressed: cubit.chat,
                              icon: SvgPicture.asset(
                                Res.drawable.message,
                                width: 20.0,
                                height: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: state.loading
                          ? null
                          : () {
                              if (state.arrived && state.tracking) {
                                cubit.completeTask();
                              } else if (state.arrived && !state.tracking) {
                                cubit.startTracking();
                              } else {
                                cubit.arrived();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(double.maxFinite, 60.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        backgroundColor: Res.colors.tabIndicatorColor,
                      ),
                      child: state.loading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Res.colors.materialColor,
                              ),
                            )
                          : Text(
                              state.arrived && state.tracking
                                  ? Res.string.completeTask
                                  : state.arrived && !state.tracking
                                      ? Res.string.startTask
                                      : Res.string.arrived,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
