import 'package:baby_milk/pages/homePage/widget/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import 'package:baby_milk/store/home_page.dart';
import 'package:baby_milk/utils/date_utils.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// ignore: must_be_immutable
class _HomePageState extends State<HomePage> {
  final int offset = 20;
  HomePageProvider store;

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

  getSubTitle(i) {
    if (i == store.list.length - 1) {
      return '间隔： 0 小时 0 分钟 0 秒';
    }
    Duration diff = DateUtils.diff(store.list[i], store.list[i + 1]);
    return "${diff.inHours} 小时 ${diff.inMinutes % 60} 分钟 ${diff.inSeconds % 60} 秒";
  }

  getList() {
    return ListView.builder(
      itemCount: store.list.length,
      itemBuilder: (BuildContext context, int i) {
        return Dismissible(
          key: Key(store.list[i]),
          onDismissed: (_) {
            //参数暂时没有用到，则用下划线表示
            store.remove(store.list[i]);
          },
          movementDuration: Duration(milliseconds: 100),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white38,
              child: Icon(
                MaterialCommunityIcons.baby_bottle,
                color: Colors.lightBlue,
              ),
            ),
            title: Text("吃奶时间： ${DateUtils.formatDate(store.list[i])}"),
            subtitle: Text('间隔： ${getSubTitle(i)}'),
          ),
          background: Container(
            color: Color(0xffff0000),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    store = Provider.of<HomePageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: store.list.length > 0
          ? Column(
              children: [
                TimerWidget(date: store.list[0]),
                Expanded(
                  child: getList(),
                ),
              ],
            )
          : Center(
              child: const Text('无记录'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DateTime date = DateTime.now();
          store.insert(date.toString());
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
