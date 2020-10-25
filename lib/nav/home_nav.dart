import 'package:baby_milk/pages/feces_page/index.dart';
import 'package:baby_milk/pages/milk_page/index.dart';
import 'package:baby_milk/store/feces_page.dart';
import 'package:baby_milk/store/milk_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeNav extends StatefulWidget {
  HomeNav({Key key}) : super(key: key);

  @override
  _HomeNavState createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MilkPageProvider>(
            create: (_) => MilkPageProvider()),
        ChangeNotifierProvider<FacesPageProvider>(
            create: (_) => FacesPageProvider())
      ],
      child: Consumer2<MilkPageProvider, FacesPageProvider>(
        builder: (ctx, MilkPageProvider mStore, FacesPageProvider fStore, _) {
          return DefaultTabController(
              length: 2,
              child: Builder(builder: (BuildContext context) {
                final TabController tabController =
                    DefaultTabController.of(context);
                return Scaffold(
                  appBar: AppBar(
                    title: TabBar(
                      tabs: <Tab>[
                        Tab(text: '吃奶时光'),
                        Tab(text: '放松时刻'),
                      ],
                      isScrollable: true,
                    ),
                  ),
                  body: TabBarView(
                    children: <Widget>[
                      MilkPage(),
                      FacesPage(),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      DateTime date = DateTime.now();
                      if (tabController.index == 0) {
                        mStore.insert(date.toString());
                      } else {
                        fStore.insert(date.toString());
                      }
                    },
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  ), // This traili
                );
              }));
        },
      ),
    );
  }
}
