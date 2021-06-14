import 'package:ecom/screens/home/components/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ExploreAllProduct extends StatefulWidget {
  @override
  _ExploreAllProductState createState() => _ExploreAllProductState();
}

class _ExploreAllProductState extends State<ExploreAllProduct> {

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
          
         
          DefaultTabController(
            length: 8, // length of tabs
            initialIndex: 0,
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
              Container(
                child: TabBar(
                  isScrollable: true,
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: 'Dresses'),
                    Tab(text: 'Sports'),
                    Tab(text: 'T-shirts'),
                    Tab(text: 'All'),
                    Tab(text: 'Dresses'),
                    Tab(text: 'Sports'),
                    Tab(text: 'T-shirts'),
                  ],
                ),
              ),
              Container(
                height:500, //height of TabBarView
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                ),
                child: TabBarView(children: <Widget>[
                  Container(
                    child:GridView.count(
                      crossAxisSpacing: 1.0, 
                      crossAxisCount:  2,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.75,
                      children: [
                        Product(),
                         Product(),
                          Product()
                      ],
                      
                      
                    )
                  ),
                  Container(
                    child: Center(
                      child: Text('Display Tab 2', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('Display Tab 3', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('Display Tab 4', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('Display Tab 1', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('Display Tab 2', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('Display Tab 3', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('Display Tab 4', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ])
              )
            ])
          ),
        ]),
      );
  }
}