import 'package:baby_milk/store/feces_page.dart';
import 'package:baby_milk/widget/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import 'package:baby_milk/utils/date_utils.dart';

class FacesPage extends StatelessWidget {
  const FacesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FacesPageProvider store = Provider.of<FacesPageProvider>(context);
    return store.list.length > 0
        ? Column(
            children: [
              TimerWidget(
                date: store.list[0],
                event: "拉臭臭",
              ),
              Expanded(
                child: _getList(store),
              ),
            ],
          )
        : Center(
            child: const Text('无记录'),
          );
  }
}

String _getSubTitle(store, i) {
  if (i == store.list.length - 1) {
    return '0 小时 0 分钟 0 秒';
  }
  Duration diff = DateUtils.diff(store.list[i], store.list[i + 1]);
  return "${diff.inHours} 小时 ${diff.inMinutes % 60} 分钟 ${diff.inSeconds % 60} 秒";
}

_getList(store) {
  return ListView.builder(
    itemCount: store.list.length,
    itemBuilder: (BuildContext context, int i) {
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white38,
          child: Icon(
            MaterialCommunityIcons.pumpkin,
            color: Colors.yellow,
          ),
        ),
        title: Text("拉臭时间： ${DateUtils.formatDate(store.list[i])}"),
        subtitle: Text('间隔： ${_getSubTitle(store, i)}'),
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
