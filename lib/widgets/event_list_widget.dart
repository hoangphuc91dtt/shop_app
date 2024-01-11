import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/event_provider.dart';
import 'package:untitled/providers/student_provider.dart';
import 'package:untitled/screens/edit_event_screen.dart';
import 'package:untitled/screens/edit_student_screen.dart';
import '../models/event_model.dart';
import '../themes/colors.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  void initState() {
    super.initState();
    print("dffsdf");
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    eventProvider.fetchAllEventsFromApiByLimit(10);
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    Future<void> _handleRefresh() async {
      await eventProvider.fetchAllEventsFromApiByLimit(10);
    }

    return LiquidPullToRefresh(
      onRefresh: _handleRefresh,
      height: 100,
      backgroundColor: Colors.white,
      color: AppColor.primaryColor,
      child: ListView.builder(
        itemCount: eventProvider.events.length,
        itemBuilder: (context, index) {
          final event = eventProvider.events[index];
          return EventRow(
            event: event,
          );
        },
      ),
    );
  }
}

class EventRow extends StatelessWidget {
  final Event event; // Declare student as a final field

  // Use named constructor to initialize student
  const EventRow({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    color: Color(0xffF3F4F6),
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 30,
                        top: 10,
                        bottom: 10,
                        right: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${event.fullName}",
                                  style: TextStyle(
                                    color: AppColor.titleColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("${event.className} - ${event.attendanceStatus}"),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EventEditingScreen(event: event),
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.edit_note),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          actionsPadding:
                                              EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                          actionsAlignment: MainAxisAlignment.spaceBetween,
                                          title: Text(
                                            'Are you sure to delete this student?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColor.primaryColor,
                                            ),
                                          ),
                                          actions: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  // color: AppColor.primaryColor,
                                                  // borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                              child: TextButton(
                                                onPressed: () async {
                                                  final eventProvider = Provider.of<EventProvider>(
                                                      context,
                                                      listen: false);
                                                  await eventProvider.deleteEvent(event.id);
                                                  Navigator.pop(context);
                                                },
                                                style: TextButton.styleFrom(
                                                  backgroundColor: AppColor.primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: 1,
                                                      color: AppColor.primaryColor,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: TextButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: 1,
                                                      color: AppColor.primaryColor,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    color: AppColor.primaryColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(Icons.delete),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 110,
                  width: 20,
                ),
              ],
            ),
            Positioned(
              right: 100,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${event.attendedEvents.length} events",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
