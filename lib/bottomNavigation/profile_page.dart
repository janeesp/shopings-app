import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Proffile extends StatefulWidget {
  const Proffile({super.key});

  @override
  State<Proffile> createState() => _ProffileState();
}

class _ProffileState extends State<Proffile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: scrWidth * 0.037, vertical: scrWidth * 0.025),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: scrWidth * 0.17,
                  child: CircleAvatar(
                    radius: scrWidth*0.16,
                    backgroundImage: NetworkImage("https://tse3.mm.bing.net/th?id=OIP.ongTAECCiqSHLmPTxqtxJwHaHg&pid=Api&P=0&h=220",),
                  ),

                ),
              ),
              Text(
                "Janees012",
                style: ArabicTextStyle(
                    arabicFont: ArabicFont.amiri,
                    fontSize: scrWidth * 0.05,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
              ),
              Container(
                height: scrWidth * 0.35,
                width: scrWidth * 1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.white)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Please verify your email or number",
                            style: ArabicTextStyle(
                                arabicFont: ArabicFont.amiri,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: scrWidth * 0.06,
                          ),
                          Container(
                            height: scrWidth * 0.11,
                            width: scrWidth * 0.11,
                            color: Colors.white,
                          )
                        ],
                      ),
                      Text(
                        "Get newest offers",
                        style: ArabicTextStyle(
                            arabicFont: ArabicFont.amiri,
                            color: Colors.white60,
                            fontWeight: FontWeight.w600,
                            fontSize: scrWidth * 0.04),
                      ),
                      SizedBox(
                        height: scrWidth * 0.02,
                      ),
                      Container(
                        height: scrWidth * 0.1,
                        width: scrWidth * 0.86,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white54,
                            ),
                            borderRadius:
                                BorderRadius.circular(scrWidth * 0.055)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.001,
                              vertical: scrWidth * 0.001),
                          child: Row(
                            children: [
                              SizedBox(
                                width: scrWidth*0.02,
                              ),
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: scrWidth * 0.05,
                              ),
                               Text("91",style:TextStyle(color: Colors.white),),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      // horizontal: scrWidth * 0.02,
                                      vertical: scrWidth * 0.05),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    // controller: Name_controller,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange),
                                  onPressed: () {},
                                  child: Text(
                                    "Verify now",
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.amiri,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              buildOptionItem("Address Manager"),
              buildOptionItem("My Order"),
              buildOptionItem("My Offers"),
              buildOptionItem("Wishlist"),
              buildOptionItem("Quick Pay Cards"),
              buildOptionItem("Help Center"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildOptionItem(String title) {
  return Container(

     margin: EdgeInsets.symmetric(horizontal: scrWidth*0.001, vertical: 5),
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(scrWidth*0.02),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            // style: TextStyle(color: Colors.white, fontSize: 16)
          style: ArabicTextStyle(arabicFont: ArabicFont.amiri,
          color: Colors.white,fontSize: scrWidth*0.043),
        ),
        Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
      ],
    ),
  );
}
