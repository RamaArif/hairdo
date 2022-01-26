import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:omahdilit/constant.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF6F6F6F)),
        title: Center(
          child: Text(
            "Riwayat Pesanan",
            style: TextStyle(color: textAccent, fontSize: 18.0),
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {},
            child: Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(
                horizontal: marginHorizontal,
                vertical: marginVertical / 2,
              ),
              child: Container(
                width: lebar,
                margin: EdgeInsets.symmetric(
                  horizontal: marginHorizontal,
                  vertical: marginVertical / 2,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        "https://omahdilit.my.id/images/imgcustomer.png",
                        fit: BoxFit.cover,
                        width: lebar / 7.5,
                        height: lebar / 7.5,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Koma Head",
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: tinggi / lebar * 8,
                              ),
                            ),
                            Text(
                              "17 Agustus 1945",
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: tinggi / lebar * 6.5,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
