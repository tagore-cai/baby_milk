import 'package:baby_milk/widget/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import 'package:baby_milk/store/milk_page.dart';
import 'package:baby_milk/utils/date_utils.dart';

class MilkPage extends StatefulWidget {
  const MilkPage({Key key}) : super(key: key);

  @override
  State<MilkPage> createState() => _MilkPageState();
}

// ignore: must_be_immutable
class _MilkPageState extends State<MilkPage> {
  final int offset = 20;
  MilkPageProvider store;

  @override
  void initState() {
    super.initState();
    // accelerometerEvents.listen(
    //   (AccelerometerEvent event) {
    //     if (event.x >= offset ||
    //         event.x <= -offset ||
    //         event.y >= offset ||
    //         event.y <= -offset ||
    //         event.z >= offset ||
    //         event.z <= -offset) {
    //       if (store != null) {
    //         DateTime date = DateTime.now();
    //         store.insert(date.toString());
    //       }
    //     }
    //   },
    // );
  }

  String getSubTitle(i) {
    if (i == store.list.length - 1) {
      return '0 小时 0 分钟 0 秒';
    }
    Duration diff = DateUtils.diff(store.list[i], store.list[i + 1]);
    return "${diff.inHours} 小时 ${diff.inMinutes % 60} 分钟 ${diff.inSeconds % 60} 秒";
  }

  bool isDiffDay(i) {
    if (i == 0) {
      return true;
    }
    if (i == store.list.length - 1) {
      return false;
    }
    DateTime date1 = DateUtils.toDateTime(store.list[i]);
    DateTime date2 = DateUtils.toDateTime(store.list[i + 1]);

    if (date1.day != date2.day) {
      return true;
    }
    return false;
  }

  getList() {
    return ListView.builder(
      itemCount: store.list.length,
      itemBuilder: (BuildContext context, int i) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white38,
            child: Icon(
              MaterialCommunityIcons.baby_bottle,
              color: Colors.lightBlue,
            ),
          ),
          title: Text("吃奶时间： ${DateUtils.formatDate(store.list[i])}"),
          subtitle: Text('间隔： ${getSubTitle(i)}'),
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('提示'),
                  content: Text('确认删除吗？'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('取消'),
                      onPressed: () {
                        Navigator.of(context).pop('cancel');
                      },
                    ),
                    FlatButton(
                      child: Text('确认'),
                      onPressed: () {
                        Navigator.of(context).pop('ok');
                        store.remove(store.list[i]);
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    store = Provider.of<MilkPageProvider>(context);
    return store.list.length > 0
        ? Column(
            children: [
              TimerWidget(
                date: store.list[0],
                event: "吃奶",
              ),
              Expanded(
                child: getList(),
              ),
            ],
          )
        : Center(
            child: const Text('无记录'),
          );
  }
}
