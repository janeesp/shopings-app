import 'package:arabic_font/arabic_font.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoping/Home/list_page/baby_kids.dart';
import 'package:shoping/bottomNavigation/cart_page.dart';
import 'package:shoping/main.dart';

import '../model/banner_model.dart';
import '../model/modelPage.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream<List<DressModel>> getStreem() => FirebaseFirestore.instance
      .collection("products")
      .snapshots()
      .map((event) =>
          event.docs.map((e) => DressModel.fromMap(e.data())).toList());
  Stream<List<DressModel>> getfeatured() => FirebaseFirestore.instance
      .collection("featured")
      .snapshots()
      .map((event) =>
          event.docs.map((e) => DressModel.fromMap(e.data())).toList());
  Stream<List<BannerModel>> getBanner() =>
      FirebaseFirestore.instance.collection("banners").snapshots().map(
            (event) => event.docs
                .map(
                  (e) => BannerModel.fromMap(e.data()),
                )
                .toList(),
          );

  final List<Map<String, String>> categories = [
    {"icon": "👕", "label": "Men"},
    {"icon": "👗", "label": "Women"},
    {"icon": "🍼", "label": "Baby & Kids"},
    {"icon": "👜", "label": "Bags"},
    {"icon": "🏡", "label": "Decor"},
  ];

  Future<void> addToCart(DressModel dress) async {
    CollectionReference cartRef = FirebaseFirestore.instance.collection("cart");

    QuerySnapshot query =
        await cartRef.where("productId", isEqualTo: dress.id).get();

    if (query.docs.isNotEmpty) {
      var doc = query.docs.first;
      int currentQuantity = doc["quantity"] ?? 1;

      await cartRef.doc(doc.id).update({
        "quantity": currentQuantity + 1,
      });
    } else {
      await cartRef.add({
        "productId": dress.id,
        "name": dress.name,
        "total": dress.total,
        "rate": dress.rate,
        "image": dress.image,
        "quantity": 1, // Initial quantity
      }).then(
        (value) {
          value.update({"id": value.id});
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<BannerModel>>(
              stream: getBanner(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No banners available"));
                }

                var bannerItems = snapshot.data!;

                return CarouselSlider(
                  items: bannerItems.map((banner) {
                    return Image.network(
                      banner.image.toString(),
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          Center(child: Icon(Icons.broken_image, size: 50)),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlayAnimationDuration: Duration(seconds: 2),
                    enlargeCenterPage: true,
                    height: MediaQuery.of(context).size.width * 0.5,
                    autoPlayCurve: Curves.easeInOutCirc,
                    autoPlay: true,
                  ),
                );
              },
            ),
            // StreamBuilder<List<BannerModel>>(
            //   stream: getBanner(),
            //   builder: (context, snapshot) {
            //     var banerItems=snapshot.data;
            //     return
            //       CarouselSlider(
            //       items: [
            //         // Image(
            //         //   image: NetworkImage(),
            //         //   fit: BoxFit.cover,
            //         // ),
            //         // Image(
            //         //   image: NetworkImage(
            //         //       "https://tse4.mm.bing.net/th?id=OIP.MEmh-kcpNtmR94u3P389sQHaEQ&pid=Api&P=0&h=220"),
            //         //   fit: BoxFit.cover,
            //         // ),
            //       ],
            //       options: CarouselOptions(
            //           autoPlayAnimationDuration: Duration(seconds: 2),
            //           enlargeCenterPage: true,
            //           // aspectRatio: 22/1,
            //           height: scrWidth * 0.5,
            //           autoPlayCurve: Curves.easeInOutCirc,
            //           autoPlay: true),
            //     );
            //   }
            // ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: scrWidth * 0.03),
              child: SingleChildScrollView(
                // scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: scrWidth * 0.001, right: scrWidth * 0.02),
                      child: SizedBox(
                        height: scrWidth * 0.2,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                categories[index]["label"] == "Baby & Kids"
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BabyKids(),
                                        ))
                                    : SizedBox();
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: scrWidth * 0.02,
                                        right: scrWidth * 0.02),
                                    child: CircleAvatar(
                                      radius: scrWidth * 0.07,
                                      backgroundColor: Colors.grey[200],
                                      child: Text(
                                        categories[index]["icon"]!,
                                        style: TextStyle(
                                            fontSize: scrWidth * 0.05),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    categories[index]["label"]!,
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.amiri,
                                        color: Colors.orange),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: scrWidth * 0.04, vertical: scrWidth * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Newest Arrivals",
                    style: ArabicTextStyle(
                        arabicFont: ArabicFont.amiri,
                        fontWeight: FontWeight.bold,
                        fontSize: scrWidth * 0.035),
                  ),
                  Text(
                    "view all",
                    style: ArabicTextStyle(
                        arabicFont: ArabicFont.amiri,
                        fontSize: scrWidth * 0.036,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  )
                ],
              ),
            ),
            SizedBox(
              height: scrWidth * 0.526,
              child: StreamBuilder<List<DressModel>>(
                  stream: getStreem(),
                  builder: (context, snapshot) {
                    print(("-------------"));
                    print(DressModel);
                    var items = snapshot.data;
                    print(items);
                    // items!.isEmpty?CircularProgressIndicator():
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
                    if (items!.isEmpty) {
                      return Center(
                        child: Text("No items Available"),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (
                        context,
                        index,
                      ) {
                        final data = items[index];
                        return Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: SizedBox(
                            width: scrWidth * 0.4,
                            height: scrWidth * 0.3,
                            // color: Colors.red,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16)),
                                      ),
                                      builder: (context) {
                                        return Padding(
                                          padding: EdgeInsets.all(16),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Added to Cart",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ElevatedButton.icon(
                                                    onPressed: () async {
                                                      await addToCart(data);

                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              CartPages(),
                                                        ),
                                                      );
                                                    },
                                                    icon: Icon(
                                                        Icons.shopping_cart),
                                                    label: Text("Go to Cart"),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.orange,
                                                    ),
                                                  ),
                                                  ElevatedButton.icon(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(
                                                        Icons.shopping_bag),
                                                    label: Text("Buy Now"),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: scrWidth * 0.4,
                                    width: scrWidth * 0.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            scrWidth * 0.007),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                data.image.toString()),
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          data.name.toString(),
                                          style: ArabicTextStyle(
                                              arabicFont: ArabicFont.amiri,
                                              fontSize: scrWidth * 0.03,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.currency_rupee,
                                              size: 9,
                                            ),
                                            Text(
                                              data.rate.toString(),
                                              style: ArabicTextStyle(
                                                  arabicFont: ArabicFont.amiri,
                                                  fontSize: scrWidth * 0.03,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Icon(
                                              Icons.currency_rupee,
                                              size: 9,
                                              color: Colors.deepOrange,
                                            ),
                                            Text(
                                              data.total.toString(),
                                              style: ArabicTextStyle(
                                                  arabicFont: ArabicFont.amiri,
                                                  color: Colors
                                                      .deepOrange.shade200,
                                                  fontSize: scrWidth * 0.03,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: scrWidth * 0.04, vertical: scrWidth * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Featured Products",
                    style: ArabicTextStyle(
                        arabicFont: ArabicFont.amiri,
                        fontWeight: FontWeight.bold,
                        fontSize: scrWidth * 0.04),
                  ),
                  Text(
                    "view all",
                    style: ArabicTextStyle(
                        arabicFont: ArabicFont.amiri,
                        fontSize: scrWidth * 0.036,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  )
                ],
              ),
            ),
            SizedBox(
              height: scrWidth * 0.526,
              child: StreamBuilder<List<DressModel>>(
                stream: getfeatured(),
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
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final items = data[index];
                      return Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: SizedBox(
                          width: scrWidth * 0.4,
                          height: scrWidth * 0.3,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                    ),
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Added to Cart",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton.icon(
                                                  onPressed: () async {
                                                    await addToCart(items);
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            CartPages(),
                                                      ),
                                                    );
                                                  },
                                                  icon:
                                                      Icon(Icons.shopping_cart),
                                                  label: Text("Go to Cart"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.orange,
                                                  ),
                                                ),
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon:
                                                      Icon(Icons.shopping_bag),
                                                  label: Text("Buy Now"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: scrWidth * 0.4,
                                  width: scrWidth * 0.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.007),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              items.image.toString()),
                                          fit: BoxFit.fill)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        items.name.toString(),
                                        style: ArabicTextStyle(
                                            arabicFont: ArabicFont.amiri,
                                            fontSize: scrWidth * 0.03,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.currency_rupee,
                                            size: 9,
                                          ),
                                          Text(
                                            items.rate.toString(),
                                            style: ArabicTextStyle(
                                                arabicFont: ArabicFont.amiri,
                                                fontSize: scrWidth * 0.03,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            Icons.currency_rupee,
                                            size: 9,
                                            color: Colors.deepOrange,
                                          ),
                                          Text(
                                            "44",
                                            style: ArabicTextStyle(
                                                arabicFont: ArabicFont.amiri,
                                                color:
                                                    Colors.deepOrange.shade200,
                                                fontSize: scrWidth * 0.03,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
