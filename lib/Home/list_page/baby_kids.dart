import 'package:arabic_font/arabic_font.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoping/main.dart';

import '../../model/babyandkidsModel.dart';

class BabyKids extends StatefulWidget {
  const BabyKids({super.key});

  @override
  State<BabyKids> createState() => _BabyKidsState();
}

class _BabyKidsState extends State<BabyKids> {

  Stream<List<BabyModel>> getglass() {

    return FirebaseFirestore.instance.collection("baby&kids").doc("baby&kids").collection("kidesArrivals").
      snapshots().map(
            (event) => event.docs
                .map(
                  (e) => BabyModel.fromMap(e.data()),
                )
                .toList(),
          );
  }

  Stream<List<BabyModel>> getWatch() =>
      FirebaseFirestore.instance.collection("baby&kids").doc("baby&kids").collection("kidsFeatured").snapshots().map(
            (event) => event.docs
                .map(
                  (e) => BabyModel.fromMap(e.data()),
                )
                .toList(),
          );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Baby & Kids",
          style: ArabicTextStyle(
              arabicFont: ArabicFont.amiri, color: Colors.white),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Center(
            child: Container(
              height: scrWidth * 0.5,
              width: scrWidth * 0.94,
              decoration: BoxDecoration(
                  color: Colors.white, border: Border.all(color: Colors.white)),
              child: Image(
                image: NetworkImage(
                    "https://tse4.mm.bing.net/th?id=OIP.WgLYltepcY7CgPDlCwwBlAAAAA&pid=Api&P=0&h=220"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Newest Arrivals",
                  style: ArabicTextStyle(
                      arabicFont: ArabicFont.amiri,
                      color: Colors.white,
                      fontSize: scrWidth*0.05,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "view all",
                  style: ArabicTextStyle(
                      fontSize: scrWidth*0.05,
                      arabicFont: ArabicFont.amiri,
                      color: Colors.white60,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: scrWidth * 0.04),
              child: StreamBuilder<List<BabyModel>>(
                  stream: getglass(),
                  builder: (context, snapshot) {
                    var data = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("error: ${snapshot.error}"),
                      );
                    }
                    if (data!.isEmpty) {
                      return Center(
                        child: Text("No items Available"),
                      );
                    }
                    return GridView.builder(
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: scrWidth * 0.04,
                          mainAxisSpacing: scrWidth * 0.05),
                      itemBuilder: (context, index) {
                        final babykids = data[index];
                        return Column(
                          children: [
                            SizedBox(
                              height: scrWidth * 0.43,
                              width: scrWidth * 0.45,
                              child: Image(
                                image: NetworkImage(babykids.image.toString()),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      babykids.name.toString(),
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.amiri,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      babykids.catogery.toString(),
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.amiri,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.currency_rupee,
                                        color: Colors.white,
                                        size: scrWidth * 0.03,
                                      ),
                                      Text(
                                        babykids.rate.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: scrWidth * 0.03),
                                      ),
                                      Icon(
                                        Icons.currency_rupee,
                                        color: Colors.orange,
                                        size: scrWidth * 0.04,
                                      ),
                                      Text(
                                        babykids.total.toString(),
                                        style: TextStyle(color: Colors.orange),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      },
                    );
                  }),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Featured Products",
                  style: ArabicTextStyle(
                      fontSize: scrWidth*0.05,
                      arabicFont: ArabicFont.amiri,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "view all",
                  style: ArabicTextStyle(
                      arabicFont: ArabicFont.amiri,
                      color: Colors.white60,
                      fontSize: scrWidth*0.05,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: scrWidth * 0.04),
              child: StreamBuilder<List<BabyModel>>(
                  stream: getWatch(),
                  builder: (context, snapshot) {
                    var data = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("error: ${snapshot.error}"),
                      );
                    }
                    if (data!.isEmpty) {
                      return Center(
                        child: Text("No items Available"),
                      );
                    }
                    return GridView.builder(
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: scrWidth * 0.04,
                          mainAxisSpacing: scrWidth * 0.05),
                      itemBuilder: (context, index) {
                        final items = data[index];
                        return Column(
                          children: [
                            SizedBox(
                              height: scrWidth * 0.42,
                              width: scrWidth * 0.45,

                              child: Image(
                                image: NetworkImage(items.image.toString()),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      items.name.toString(),
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.amiri,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      items.catogery.toString(),
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.amiri,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.currency_rupee,
                                        color: Colors.white,
                                        size: scrWidth * 0.03,
                                      ),
                                      Text(
                                        items.rate.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: scrWidth * 0.03),
                                      ),
                                      Icon(
                                        Icons.currency_rupee,
                                        color: Colors.orange,
                                        size: scrWidth * 0.04,
                                      ),
                                      Text(
                                        items.total.toString(),
                                        style: TextStyle(color: Colors.orange),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      },
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
