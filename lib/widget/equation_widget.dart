import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/screens/dashboard_screen.dart';
import 'package:sleepwell/screens/feedback/feedback_page.dart';
import 'package:sleepwell/models/difficult_equation_model.dart';
import 'package:sleepwell/models/easy_equation_model.dart';
import 'package:sleepwell/models/equation_abstrat_model.dart';
// import 'package:sleepwell/screens/home_screen.dart';

class EquationWidget extends StatefulWidget {
  final bool showEasyEquation;
  final int alarmId;
  const EquationWidget({
    Key? key,
    required this.alarmId,
    this.showEasyEquation = false,
  }) : super(key: key);

  @override
  State<EquationWidget> createState() => _EquationWidgetState();
}

class _EquationWidgetState extends State<EquationWidget> {
  bool _showFeedbackDialog = true;
  Timer? _reminderTimer;

  @override
  void dispose() {
    _reminderTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EquationModel equationModel = widget.showEasyEquation
        ? EasyEquationModel()
        : DifficultEquationModel();

    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "To stop the alarm\nSolve the following mathematical equation:",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            alignment: AlignmentDirectional.center,
            height: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 223, 224, 248),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey),
            ),
            child: Text(
              equationModel.equation,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            alignment: AlignmentDirectional.center,
            height: 50,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final widthScreen = width - 30;
                final optionsCount = equationModel.options.length;
                const margin = 10 * 2;
                final allOptionsMargin = optionsCount * margin;

                return Container(
                  width: (widthScreen - allOptionsMargin) / optionsCount,
                  margin: const EdgeInsets.symmetric(horizontal: margin / 2),
                  child: FloatingActionButton(
                    heroTag: equationModel.options[index],
                    onPressed: () async {
                      if (equationModel.options[index] ==
                          equationModel.result) {
                        print(":::::::::::::::::: Success chosen");
                        await Alarm.stop(widget.alarmId);
                        final shouldShowFeedbackDialog = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Daily Feedback'),
                              content: const Text(
                                  'Do you want to give your feedback now?'),
                              actions: [
                                TextButton(
                                  child: const Text('Remind me later'),
                                  onPressed: () {
                                    // Navigator.pop(context, false);
                                    Get.back(result: false);
                                    _showFeedbackDialog = false;
                                    _startReminderTimer();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Yes'),
                                  onPressed: () {
                                    // Navigator.pop(context, true);
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => FeedbackPage()),
                                    // );
                                    Get.back(result: true);
                                    Get.to(const FeedbackPage());
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        if (!(shouldShowFeedbackDialog ?? false)) {
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => MyHomePage()),
                          //   (route) => false,
                          // );
                          Get.offAll(DashboardScreen());
                        }
                      } else {
                        print(":::::::::::::::::: Wrong chosen");
                        setState(() {});
                      }
                    },
                    child: Text(equationModel.options[index].toString()),
                  ),
                );
              },
              itemCount: equationModel.options.length,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  void _startReminderTimer() {
    _reminderTimer = Timer(Duration(minutes: 1), () {
      if (_showFeedbackDialog) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Daily Feedback Reminder'),
              content: Text('Do you want to give your feedback now?'),
              actions: [
                TextButton(
                  child: Text('Remind me later'),
                  onPressed: () {
                    // Navigator.pop(context);
                    Get.back();
                    _startReminderTimer();
                  },
                ),
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    // Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => FeedbackPage()),
                    // );
                    Get.back();
                    Get.to(const FeedbackPage());
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }
}
