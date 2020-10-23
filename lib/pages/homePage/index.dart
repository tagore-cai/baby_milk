import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:baby_milk/store/home_page.dart';
import 'package:baby_milk/utils/index.dart';
import 'package:sensors/sensors.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final String title;
  HomePageProvider homePageProvider;

  HomePage({Key key, this.title}) : super(key: key);

  // ignore: unused_element
  HomePage._internal(this.title) {
    accelerometerEvents.listen(
      (AccelerometerEvent event) {
        int value = 20;
        if (event.x >= value ||
            event.x <= -value ||
            event.y >= value ||
            event.y <= -value ||
            event.z >= value ||
            event.z <= -value) {
          if (homePageProvider != null) {
            DateTime date = DateTime.now();
            homePageProvider.insert(date.toString());
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    homePageProvider = Provider.of<HomePageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: homePageProvider.list.length > 0
          ? ListView.builder(
              itemCount: homePageProvider.list.length,
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  title: Text(
                    formatDate(
                      homePageProvider.list[i],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: const Text('No items'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DateTime date = DateTime.now();
          homePageProvider.insert(date.toString());
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
