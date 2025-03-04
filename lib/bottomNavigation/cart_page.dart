import 'dart:async';
import 'dart:ffi';

import 'package:arabic_font/arabic_font.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoping/main.dart';
import 'package:shoping/model/cart_model.dart';
import 'package:shoping/model/modelPage.dart';

class CartPages extends StatefulWidget {
   CartPages({super.key,});

  @override
  State<CartPages> createState() => _CartPagesState();
}
var cart;

class _CartPagesState extends State<CartPages> {

  Stream<List<CartModel>>getCart() {
    return FirebaseFirestore.instance.collection("cart").snapshots().
  map((event) => event.docs.map((e) =>CartModel.fromMap(e.data()),).toList(),);
    
  }

  // getCartDetails() async {
  //   QuerySnapshot items = await FirebaseFirestore.instance.collection("cart").get();
  //   totalPrice =0;
  //   totalAmount=0;
  //   quantity=0;
  //   for(var data in items.docs){
  //     totalAmount+=data.get("total");
  //     quantity+=data.get("quantity");
  //     totalPrice+=totalAmount*quantity;
  //
  //   }
  //   setState(() {
  //
  //   });
  // }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> getCartDetails() {
    return FirebaseFirestore.instance.collection("cart").snapshots().listen((snapshot) {
      // Reset totals
      totalPrice = 0;
      totalAmount = 0;
      quantity = 0;

      for (var data in snapshot.docs) {
        totalAmount = data.get('total') * data.get('quantity');
        totalPrice += totalAmount;
      }

      // Update UI in real-time
      setState(() {});
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCart();
    getCartDetails();
  }
double totalAmount = 0;
  double quantity = 0;
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Expanded(
            child: StreamBuilder<List<CartModel>>(
              stream: getCart(),
              builder: (context, snapshot) {
                var data=snapshot.data;
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
                  itemCount: data.length,
                    itemBuilder: (context, index) {
                       cart=data[index];
                      return Quantity(selectedItems: snapshot.data![index],);
                    },);
              }
            ),
          ),
          Container(
            padding: EdgeInsets.all(0.8),
            height: scrWidth*0.4,
            width: scrWidth*1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(scrWidth*0.01),
              border: Border.all(
                color: Colors.grey.shade300
              ),
              boxShadow: [
                 BoxShadow(
                   color: Colors.black.withOpacity(0.03),
                   spreadRadius: 2,
                   blurRadius: 2,
                   offset: Offset(0, 0.2)
                 )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Payment Details",
                  style: ArabicTextStyle(arabicFont: ArabicFont.amiri,
                  fontSize: scrWidth*0.05,
                  fontWeight: FontWeight.bold),),
                ),
                Divider(
                  thickness: scrWidth*0.002,
                  height: scrWidth*0.01,
                  color: Colors.grey.shade300,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Offer  -",
                      style: ArabicTextStyle(arabicFont: ArabicFont.amiri,
                      color: Colors.black45,
                      fontSize: scrWidth*0.05,
                      fontWeight: FontWeight.w100),),
                      Text("offer not available",
                        style: ArabicTextStyle(arabicFont: ArabicFont.amiri,
                            color: Colors.black,
                            fontSize: scrWidth*0.05,
                            fontWeight: FontWeight.w100),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Shipping Charge -",
                      style: ArabicTextStyle(arabicFont: ArabicFont.amiri,
                      color: Colors.black45,
                      fontSize: scrWidth*0.05,
                      fontWeight: FontWeight.w100),),
                      Text("Free",
                        style: ArabicTextStyle(arabicFont: ArabicFont.amiri,
                            color: Colors.green,
                            fontSize: scrWidth*0.05,
                            fontWeight: FontWeight.w100),),
                    ],
                  ),
                ),
              ],
            ),
          ),Row(
            children: [
              Container(
                height: scrWidth*0.15,
                 width: scrWidth*0.5,
               decoration:  BoxDecoration(
                 boxShadow: [
                   BoxShadow(
                     color:Colors.black.withOpacity(0.02),
                     blurRadius: 2,
                     spreadRadius: 4,
                     offset: Offset(0, 0.02)
                   )
                 ]
               ),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                         Icon(Icons.currency_rupee,
                         size: scrWidth*0.04,),
                       Text(totalPrice.toString(),style: ArabicTextStyle(arabicFont: ArabicFont.amiri,
                       fontSize: scrWidth*0.04,
                       fontWeight: FontWeight.w900),)
                     ],
                   ),
                   Text("See Price Details",
                   style: ArabicTextStyle(arabicFont: ArabicFont.amiri,
                       color: Colors.black45,
                       fontSize: scrWidth*0.04,
                       fontWeight: FontWeight.w400,))
                 ],
               ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(),
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(
                    horizontal:scrWidth*0.17,
                    vertical: scrWidth*0.046
                  )
                ),
                  onPressed: () {

              }, child: Text("Continue",
              style: ArabicTextStyle(arabicFont: ArabicFont.amiri,
              color: Colors.white,
              fontSize: scrWidth*0.042),))
            ],
          )
        ],
      ),

    );
  }
}

class Quantity extends StatefulWidget {
  final CartModel selectedItems;
  const Quantity({super.key,required this.selectedItems});

  @override
  State<Quantity> createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  // int? qty;
  // List<int>num=[1,2,3,4,5,6];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: scrWidth*0.35,
      width: scrWidth*1,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(14)
          )
      ),
      margin: EdgeInsets.only(
          top: scrWidth*0.02
      ),
      child: Row(
        children: [
          Container(
            height: scrWidth*0.35,
            width: scrWidth*0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(image: NetworkImage(cart.image.toString()))
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 8
                ),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start ,
                  children: [
                    Text(cart.name.toString(),
                      style: ArabicTextStyle(arabicFont: ArabicFont.amiri,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),),
                    SizedBox(
                      height: scrWidth*0.02,
                    ),
                    SizedBox(
                      width: scrWidth*0.35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 11,
                            child: Icon(Icons.check,
                              size: 15,
                              color: Colors.white,),
                          ),
                          Text("M",style: ArabicTextStyle(
                              arabicFont: ArabicFont.amiri,
                              fontWeight: FontWeight.bold),),
                          Container(
                            height: scrWidth*0.08,
                            width: scrWidth*0.2,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black12
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.02),
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      offset: Offset(0, 0.2)
                                  ),
                                ]
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Qty :",style: ArabicTextStyle(arabicFont: ArabicFont.amiri),),
                                Text(cart.quantity.toString())
                                // DropdownButton(
                                //   underline: Container(
                                //     height: 2,
                                //   ),
                                //   value: qty,
                                //   items:num.map((int value) {
                                //     return DropdownMenuItem<int>(
                                //       value: value,
                                //       child: Text(value.toString()),
                                //     );
                                //   }).toList(),
                                //   onChanged: (int?newvalue) {
                                //
                                //     setState(() {
                                //       qty=newvalue;
                                //     });
                                //
                                //   },)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: scrWidth*0.01,
                    ),
                    Row(
                      children: [
                        Icon(Icons.currency_rupee,size: 13,),
                        Text(cart.total.toString(),style: ArabicTextStyle(
                            arabicFont: ArabicFont.amiri,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),),
                        Icon(Icons.currency_rupee,size: 11,color: Colors.grey,),
                        Text(cart.rate.toString(),style: ArabicTextStyle(
                            arabicFont: ArabicFont.amiri,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: scrWidth*0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: scrWidth*0.068,
                    width: scrWidth*0.35,
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Colors.grey.shade200
                          ),
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.bookmark_outline_sharp,size: scrWidth*0.05,),
                        Text("Next time buy",
                          style: ArabicTextStyle(arabicFont: ArabicFont.amiri,
                              fontSize: scrWidth*0.04,
                              color: Colors.black45),)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      FirebaseFirestore.instance.collection("cart").doc(widget.selectedItems.id).delete();

                    },
                    child: Container(
                      height: scrWidth*0.068,
                      width: scrWidth*0.35,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade200
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_outlined,size: scrWidth*0.05,),
                          SizedBox(width: scrWidth*0.026,),
                          Text("Remove",
                            style: ArabicTextStyle(arabicFont: ArabicFont.amiri,
                                fontSize: scrWidth*0.04,
                                color: Colors.black45),)
                        ],
                      ),
                    ),
                  ),
                ],
              )

            ],
          )
        ],
      ),
    );
  }
}
