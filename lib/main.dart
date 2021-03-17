import 'package:flutter/material.dart';
import 'package:listviewanimation/child.dart';

void main() {
  runApp(Main());
}

class Change with ChangeNotifier {
  String get parent => _parent;
  String _parent;

  void change(String pp) {
    _parent = pp;
    notifyListeners();
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView Animation',
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  bool tap = false;
  List<String> parentTitle = [
    'Americano',
    'Latte',
    'MakkiAtto',
    'Chocolate Latte',
    'Apple Juice',
    'PrapuchinoPrapuchinoPrapuchinoPrapuchinoPrapuchinoPrapuchinoPrapuchinoPrapuchinoPrapuchinoPrapuchinoPrapuchinoPrapuchinoPrapuchinoPrapuchinoPrapuchinoPrapuchino'
  ];
  List<bool> eachTap = [];
  String idSort;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey(); // backing data
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < parentTitle.length; i++) eachTap.add(false);
  }

  void _addItem() {
    final int _index = parentTitle.length;
    parentTitle.insert(_index, _index.toString());
    _listKey.currentState.insertItem(_index);
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  void _removeItem() {
    final int _index = parentTitle.length - 1;
    _listKey.currentState
        .removeItem(_index, (context, animation) => Container());
    parentTitle.removeAt(_index);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          body: Row(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: tap ? width / 2 : width,
            height: height,
            child: Scaffold(
              appBar: AppBar(title: Text('Menu')),
              body: AnimatedList(
                controller: _scrollController,
                key: _listKey,
                initialItemCount: parentTitle.length,
                itemBuilder: (context, index, animation) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: tap ? width / 2 : width,
                    child: SlideTransition(
                      position: animation.drive(Tween<Offset>(
                          begin: Offset(-1.0, 0.0), end: Offset.zero)),
                      child: Ink(
                        color:
                            eachTap[index] == true ? Colors.teal : Colors.white,
                        child: ListTile(
                          title: Text('${parentTitle[index]}'),
                          trailing: Icon(Icons.fast_forward),
                          onTap: () {
                            idSort = parentTitle[index];
                            setState(() {
                              if (eachTap.every((element) => element == false))
                                tap = !tap;

                              for (int i = 0; i < parentTitle.length; i++) {
                                if (i == index) {
                                  if (eachTap[index] == true) tap = !tap;
                                  eachTap[i] = !eachTap[i];
                                } else
                                  eachTap[i] = false;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    _addItem();
                    eachTap.add(false);
                  });
                },
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: height,
            width: !tap ? 0 : width / 2,
            child: Scaffold(
              appBar: AppBar(title: Text('Item')),
              body: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(color: Colors.teal, width: 3.0))),
                  child: Child(idSort, tap, width)),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
              ),
            ),
          ),
        ],
      )),
    );
  }
}
