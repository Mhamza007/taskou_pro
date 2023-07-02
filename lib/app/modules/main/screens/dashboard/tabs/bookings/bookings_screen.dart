import 'package:flutter/material.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../app.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({
    super.key,
    required this.cubit,
    required this.state,
    this.themeMode,
  });

  final BookingsCubit cubit;
  final BookingsState state;
  final ThemeMode? themeMode;

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      widget.cubit.getBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: Res.colors.materialColor,
            child: TabBar(
              controller: _tabController,
              indicatorWeight: 4,
              indicatorColor: Res.colors.tabIndicatorColor,
              tabs: [
                Tab(text: Res.string.newRequest),
                Tab(text: Res.string.running),
                Tab(text: Res.string.past),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                /// New Request
                widget.state.newBookingsResponseList == null ||
                        widget.state.currentLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : widget.state.newBookingsResponseList!.isEmpty
                        ? Center(
                            child: Text(
                              Res.string.noDataFound,
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              widget.cubit.getBookings();
                            },
                            child: ListView.separated(
                              padding: const EdgeInsets.all(16.0),
                              itemCount:
                                  widget.state.newBookingsResponseList!.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 16.0);
                              },
                              itemBuilder: (context, index) {
                                var item = widget
                                    .state.newBookingsResponseList![index];
                                return BookingsItem(
                                  bookingType: BookingType.newRequest,
                                  profileImage: item.profileImg ?? '',
                                  title:
                                      '${item.firstName ?? ''}, ${item.lastName ?? ''}',
                                  dateTime: Helpers.getScheduleDateTime(
                                    scheduleDate: item.scheduleDate,
                                    scheduleTime: item.scheduleTime,
                                  ),
                                  location: item.address ?? '',
                                  scheduleFor: '',
                                  rejectCallback: () {
                                    widget.cubit.rejectBooking(
                                      bookingId: item.bookingId,
                                    );
                                  },
                                  acceptCallback: () {
                                    widget.cubit.acceptBooking(
                                      booking: item,
                                    );
                                  },
                                  // ratePerHour: item.price?.isNotEmpty == true
                                  //     ? '${item.price}/hour'
                                  //     : 'NA',
                                  // status: item.bookingStatus == '1'
                                  //     ? 'Pending'
                                  //     : 'Ongoing',
                                  // onTap: () {
                                  //   cubit.goToBookingStatus(
                                  //     bookingData: {
                                  //       'booking_id': item.bookingId,
                                  //       'booking_type':
                                  //           BookingType.currentBooking,
                                  //     },
                                  //   );
                                  // },
                                );
                              },
                            ),
                          ),

                /// Running
                widget.state.runningBookingsResponseList == null ||
                        widget.state.currentLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : widget.state.runningBookingsResponseList!.isEmpty
                        ? Center(
                            child: Text(
                              Res.string.noDataFound,
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              widget.cubit.getBookings();
                            },
                            child: ListView.separated(
                              padding: const EdgeInsets.all(16.0),
                              itemCount: widget
                                  .state.runningBookingsResponseList!.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 16.0);
                              },
                              itemBuilder: (context, index) {
                                var item = widget
                                    .state.runningBookingsResponseList![index];
                                return BookingsItem(
                                  bookingType: BookingType.running,
                                  bookingStatus: item.bookingStatus,
                                  profileImage: item.profileImg ?? '',
                                  title:
                                      '${item.firstName ?? ''}, ${item.lastName ?? ''}',
                                  dateTime: Helpers.getScheduleDateTime(
                                    scheduleDate: item.scheduleDate,
                                    scheduleTime: item.scheduleTime,
                                  ),
                                  location: item.address ?? '',
                                  // scheduleFor: '',
                                  scheduleFor:
                                      '${item.scheduleDate} ${item.scheduleTime}',
                                  tapCallback: () {
                                    widget.cubit.openRunningBooking(
                                      booking: item,
                                    );
                                  },

                                  // onTap: () {
                                  //   cubit.goToBookingStatus(
                                  //     bookingData: {
                                  //       'booking_id': item.bookingId,
                                  //       'booking_type': BookingType.pastBooking,
                                  //     },
                                  //   );
                                  // },
                                );
                              },
                            ),
                          ),

                /// Past
                widget.state.pastBookingsResponseList == null ||
                        widget.state.currentLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : widget.state.pastBookingsResponseList!.isEmpty
                        ? Center(
                            child: Text(
                              Res.string.noDataFound,
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              widget.cubit.getBookings();
                            },
                            child: ListView.separated(
                              padding: const EdgeInsets.all(16.0),
                              itemCount:
                                  widget.state.pastBookingsResponseList!.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 16.0);
                              },
                              itemBuilder: (context, index) {
                                var item = widget
                                    .state.pastBookingsResponseList![index];
                                return BookingsItem(
                                  bookingType: BookingType.past,
                                  profileImage: '',
                                  title:
                                      '${item.firstName ?? ''}, ${item.lastName ?? ''}',
                                  dateTime: Helpers.getScheduleDateTime(
                                    scheduleDate: item.scheduleDate,
                                    scheduleTime: item.scheduleTime,
                                  ),
                                  location: item.address ?? '',
                                  scheduleFor: '',
                                  // scheduleFor: item.price?.isNotEmpty == true
                                  //     ? '${item.price}/hour'
                                  //     : 'NA',
                                  // status: item.bookingStatus == '1'
                                  //     ? 'Pending'
                                  //     : 'Ongoing',
                                  scheduled:
                                      'Schedule at ${item.scheduleDate} ${item.scheduleTime}',
                                  // onTap: () {
                                  //   cubit.goToBookingStatus(
                                  //     bookingData: {
                                  //       'booking_id': item.bookingId,
                                  //       'booking_type':
                                  //           BookingType.upcomingBooking,
                                  //     },
                                  //   );
                                  // },
                                );
                              },
                            ),
                          ),
              ],
            ),
          ),
        ],
      ),
    );

    // return DefaultTabController(
    //   length: 3,
    //   child: Column(
    //     children: [
    //       Container(
    //         color: Res.colors.materialColor,
    //         child: TabBar(
    //           indicatorWeight: 4,
    //           indicatorColor: Res.colors.tabIndicatorColor,
    //           tabs: [
    //             Tab(text: Res.string.newRequest),
    //             Tab(text: Res.string.running),
    //             Tab(text: Res.string.past),
    //           ],
    //         ),
    //       ),
    //       Expanded(
    //         child: TabBarView(
    //           controller: widget.cubit.tabController,
    //           // controller: cubit.tabController,
    //           children: [
    //             /// New Request
    //             widget.state.newBookingsResponseList == null ||
    //                     widget.state.currentLoading
    //                 ? const Center(
    //                     child: CircularProgressIndicator(),
    //                   )
    //                 : widget.state.newBookingsResponseList!.isEmpty
    //                     ? Center(
    //                         child: Text(
    //                           Res.string.noDataFound,
    //                           style: const TextStyle(
    //                             fontSize: 18.0,
    //                           ),
    //                         ),
    //                       )
    //                     : RefreshIndicator(
    //                         onRefresh: () async {
    //                           widget.cubit.getBookings();
    //                         },
    //                         child: ListView.separated(
    //                           padding: const EdgeInsets.all(16.0),
    //                           itemCount:
    //                               widget.state.newBookingsResponseList!.length,
    //                           separatorBuilder: (context, index) {
    //                             return const SizedBox(height: 16.0);
    //                           },
    //                           itemBuilder: (context, index) {
    //                             var item = widget
    //                                 .state.newBookingsResponseList![index];
    //                             return BookingsItem(
    //                               bookingType: BookingType.newRequest,
    //                               profileImage: item.profileImg ?? '',
    //                               title:
    //                                   '${item.firstName ?? ''}, ${item.lastName ?? ''}',
    //                               dateTime:
    //                                   Helpers.bookingsDateTime(item.createdOn),
    //                               location: item.address ?? '',
    //                               scheduleFor: '',
    //                               rejectCallback: () {
    //                                 widget.cubit.rejectBooking(
    //                                   bookingId: item.bookingId,
    //                                 );
    //                               },
    //                               acceptCallback: () {
    //                                 widget.cubit.acceptBooking(
    //                                   booking: item,
    //                                 );
    //                               },
    //                               // ratePerHour: item.price?.isNotEmpty == true
    //                               //     ? '${item.price}/hour'
    //                               //     : 'NA',
    //                               // status: item.bookingStatus == '1'
    //                               //     ? 'Pending'
    //                               //     : 'Ongoing',
    //                               // onTap: () {
    //                               //   cubit.goToBookingStatus(
    //                               //     bookingData: {
    //                               //       'booking_id': item.bookingId,
    //                               //       'booking_type':
    //                               //           BookingType.currentBooking,
    //                               //     },
    //                               //   );
    //                               // },
    //                             );
    //                           },
    //                         ),
    //                       ),

    //             /// Running
    //             widget.state.runningBookingsResponseList == null ||
    //                     widget.state.currentLoading
    //                 ? const Center(
    //                     child: CircularProgressIndicator(),
    //                   )
    //                 : widget.state.runningBookingsResponseList!.isEmpty
    //                     ? Center(
    //                         child: Text(
    //                           Res.string.noDataFound,
    //                           style: const TextStyle(
    //                             fontSize: 18.0,
    //                           ),
    //                         ),
    //                       )
    //                     : RefreshIndicator(
    //                         onRefresh: () async {
    //                           widget.cubit.getBookings();
    //                         },
    //                         child: ListView.separated(
    //                           padding: const EdgeInsets.all(16.0),
    //                           itemCount: widget
    //                               .state.runningBookingsResponseList!.length,
    //                           separatorBuilder: (context, index) {
    //                             return const SizedBox(height: 16.0);
    //                           },
    //                           itemBuilder: (context, index) {
    //                             var item = widget
    //                                 .state.runningBookingsResponseList![index];
    //                             return BookingsItem(
    //                               bookingType: BookingType.running,
    //                               bookingStatus: item.bookingStatus,
    //                               profileImage: item.profileImg ?? '',
    //                               title:
    //                                   '${item.firstName ?? ''}, ${item.lastName ?? ''}',
    //                               dateTime:
    //                                   Helpers.bookingsDateTime(item.createdOn),
    //                               location: item.address ?? '',
    //                               // scheduleFor: '',
    //                               scheduleFor:
    //                                   '${item.scheduleDate} ${item.scheduleTime}',
    //                               tapCallback: () {
    //                                 widget.cubit.openRunningBooking(
    //                                   booking: item,
    //                                 );
    //                               },

    //                               // onTap: () {
    //                               //   cubit.goToBookingStatus(
    //                               //     bookingData: {
    //                               //       'booking_id': item.bookingId,
    //                               //       'booking_type': BookingType.pastBooking,
    //                               //     },
    //                               //   );
    //                               // },
    //                             );
    //                           },
    //                         ),
    //                       ),

    //             /// Past
    //             widget.state.pastBookingsResponseList == null ||
    //                     widget.state.currentLoading
    //                 ? const Center(
    //                     child: CircularProgressIndicator(),
    //                   )
    //                 : widget.state.pastBookingsResponseList!.isEmpty
    //                     ? Center(
    //                         child: Text(
    //                           Res.string.noDataFound,
    //                           style: const TextStyle(
    //                             fontSize: 18.0,
    //                           ),
    //                         ),
    //                       )
    //                     : RefreshIndicator(
    //                         onRefresh: () async {
    //                           widget.cubit.getBookings();
    //                         },
    //                         child: ListView.separated(
    //                           padding: const EdgeInsets.all(16.0),
    //                           itemCount:
    //                               widget.state.pastBookingsResponseList!.length,
    //                           separatorBuilder: (context, index) {
    //                             return const SizedBox(height: 16.0);
    //                           },
    //                           itemBuilder: (context, index) {
    //                             var item = widget
    //                                 .state.pastBookingsResponseList![index];
    //                             return BookingsItem(
    //                               bookingType: BookingType.past,
    //                               profileImage: '',
    //                               title:
    //                                   '${item.firstName ?? ''}, ${item.lastName ?? ''}',
    //                               dateTime:
    //                                   Helpers.bookingsDateTime(item.createdOn),
    //                               location: item.address ?? '',
    //                               scheduleFor: '',
    //                               // scheduleFor: item.price?.isNotEmpty == true
    //                               //     ? '${item.price}/hour'
    //                               //     : 'NA',
    //                               // status: item.bookingStatus == '1'
    //                               //     ? 'Pending'
    //                               //     : 'Ongoing',
    //                               scheduled:
    //                                   'Schedule at ${item.scheduleDate} ${item.scheduleTime}',
    //                               // onTap: () {
    //                               //   cubit.goToBookingStatus(
    //                               //     bookingData: {
    //                               //       'booking_id': item.bookingId,
    //                               //       'booking_type':
    //                               //           BookingType.upcomingBooking,
    //                               //     },
    //                               //   );
    //                               // },
    //                             );
    //                           },
    //                         ),
    //                       ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
