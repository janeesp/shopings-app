import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shoping/bottomNavigation/home_page.dart';
import 'package:shoping/bottomNavigation/cart_page.dart';
import 'package:shoping/bottomNavigation/favourite.dart';
import 'package:shoping/bottomNavigation/profile_page.dart';
import 'package:shoping/main.dart';


class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  Widget _currentScreen =Home();
  final PageStorageBucket _bucket=PageStorageBucket();
  int index=0;
  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      // drawer: Drawer(
      //   width: scrWidth*0.6,
      //   child:
      //   // ListTile(
      //   //   title: Text("data"),
      //   // );
      //   ListView(
      //     children: [
      //       DrawerHeader(
      //           child: Column(
      //             children: [
      //               Text("Settings")
      //             ],
      //           )),
      //       ListTile(
      //         title:InkWell(
      //           onTap: () {
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => AdminPage(),
      //                 ));
      //           },
      //             child: Text("Newest Arrivals")) ,
      //       ),
      //
      //     ],
      //   )
      // ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {

            },
            child: Icon(
              Icons.menu,
              color: Colors.black,
            )),
        title: Text("Home",
            style: ArabicTextStyle(
                arabicFont: ArabicFont.amiri,
                fontWeight: FontWeight.w800,
                fontSize: scrWidth * 0.07)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.search),
          )
        ],
      ),
      body:  DefaultTabController(
        length: 4,
        child: Scaffold(
          body: PageStorage(
              bucket:_bucket ,
              child:_currentScreen ),
          bottomNavigationBar: Container(
            height: scrWidth*0.15,
            width: scrWidth*1,
            child:
            Row(
              children: [
                index==0?
                MaterialButton(

                  onPressed: () {
                    setState(() {
                      index=0;
                      _currentScreen=Home();
                    });
                  },
                  child: Container(
                      width: scrWidth*0.1,
                      height: scrWidth*0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepOrange.shade100
                      ),
                      child: Icon(CupertinoIcons.home,color: Colors.orange.shade800,)),):
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      index=0;
                      _currentScreen=Home();
                    });
                  },
                  child: Icon(CupertinoIcons.home),),
                index==1?MaterialButton(
                  onPressed: () {
                    setState(() {
                      index=1;
                      _currentScreen=FavouriteScreen();
                    });
                  },
                  child: Container(
                      width: scrWidth*0.1,
                      height: scrWidth*0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepOrange.shade100
                      ),
                      child: Icon(Icons.favorite_border,color: Colors.orange.shade800,)),):MaterialButton(
                  onPressed: () {
                    setState(() {
                      index=1;
                      _currentScreen=FavouriteScreen();
                    });
                  },
                  child: Icon(Icons.favorite_border),),
                index==2?MaterialButton(
                  onPressed: () {
                    setState(() {
                      index=2;
                      _currentScreen=CartPages();
                    });
                  },
                  child: Container( width: scrWidth*0.1,
                      height: scrWidth*0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepOrange.shade100
                      ),
                      child: Icon(Icons.shopping_cart,color: Colors.orange.shade800,)),):MaterialButton(
                  onPressed: () {
                    setState(() {
                      index=2;
                      _currentScreen=CartPages();
                    });
                  },
                  child: Icon(Icons.shopping_cart),),
                index==3?  MaterialButton(
                  onPressed: () {
                    setState(() {
                      index=3;
                      _currentScreen=Proffile();
                    });
                  },
                  child: Container(
                      width: scrWidth*0.1,
                      height: scrWidth*0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepOrange.shade100
                      ),
                      child: Icon(Icons.person,color: Colors.orange.shade800,)),):MaterialButton(
                  onPressed: () {
                    setState(() {
                      index=3;
                      _currentScreen=Proffile();
                    });
                  },
                  child: Icon(Icons.person),)
              ],
            ),
          ),
        ),
      ),

    );

  }
}
