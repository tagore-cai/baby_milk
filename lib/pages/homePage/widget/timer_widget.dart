import 'dart:async';

import 'package:baby_milk/utils/date_utils.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final String date;

  TimerWidget({Key key, this.date}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Duration diff = Duration(seconds: 0);
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) {
        return;
      }
      setState(() {
        diff = DateUtils.diff(DateTime.now(), widget.date);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        '距离上次喂奶 ${diff.inHours} 小时 ${diff.inMinutes % 60} 分钟 ${diff.inSeconds % 60} 秒',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}
