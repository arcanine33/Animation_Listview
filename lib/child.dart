import 'package:flutter/material.dart';

class Child extends StatelessWidget {
  String parent;
  bool tap;
  double width;
  Child(this.parent, this.tap, this.width);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          floating: false,
          pinned: true,
          title: Text('THIS IS SLIVER APP BAR'),
          backgroundColor: Colors.teal,
          expandedHeight: MediaQuery.of(context).size.height / 3 ,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      InkWell(
                        onTap: (){
                          print('tap');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Text('$parent child')),
                                Flexible(
                                    child: Icon(Icons.arrow_forward_ios,)
                                )
                              ]
                            ),
                        ),
                      ),
              childCount: 20,
          ),
        ),
      ],
    );
  }
}
