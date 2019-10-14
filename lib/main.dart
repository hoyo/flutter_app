import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const MaterialColor customSwatch = MaterialColor(
  0xffff7d32,
  const <int, Color>{
    50: Color(0xffffefe6),
    100: Color(0xffffd8c2),
    200: Color(0xffffbe99),
    300: Color(0xffffa470),
    400: Color(0xffff9151),
    500: Color(0xffff7d32),
    600: Color(0xffff752d),
    700: Color(0xffff6a26),
    800: Color(0xffff601f),
    900: Color(0xffff4d13),
  },
);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'Flutter Demo';

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: customSwatch,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
      ),
      home: MyHomePage(title: title));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<BottomNavigationBarItem> _tabItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home),
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.bookmark : Icons.bookmark),
      title: Text('Favorite'),
    ),
  ];

  final List<Widget> _tabWidgets = <Widget>[
    WebView(
      initialUrl: 'https://event.voicy.jp/fanfesta2019',
      javascriptMode: JavascriptMode.unrestricted,
    ),
    Center(
      child: Text('Index 1: Favorite'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Widget scaffold;
    if (Platform.isIOS) {
      scaffold = CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: _tabItems),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(builder: (BuildContext context) {
            return CupertinoPageScaffold(
              navigationBar: new CupertinoNavigationBar(
                middle: Text(widget.title),
              ),
              child: _tabWidgets.elementAt(index),
            );
          });
        },
      );
    } else {
      scaffold = Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(widget.title),
        ),
        body: _tabWidgets.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: _tabItems,
          currentIndex: _selectedIndex,
          selectedItemColor: customSwatch[500],
          onTap: (int index) => setState(() => _selectedIndex = index),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(color: customSwatch[500]),
              ),
              ListTile(
                title: Text('ライセンス'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => new AlertDialog(
                      title: Text('未実装です'),
                      content: Text('この機能は実装されていません'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('OK'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('バージョン'),
                trailing: Text('1.0.0'),
              ),
            ],
          ),
        ),
      );
    }
    return scaffold;
  }
}
