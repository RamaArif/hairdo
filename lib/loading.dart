import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:omahdilit/constant.dart';

class LoadingBuilder extends StatelessWidget {
  const LoadingBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: lebar / 3,
            height: lebar / 3,
            child: LottieBuilder.asset("assets/loading.json"),
          ),
          Text(
            "Tunggu Bentar Yaa ...",
            style: textStyle.copyWith(
              color: black,
              fontWeight: semiBold,
              fontSize: tinggi / lebar * 8,
            ),
          ),
        ],
      ),
    );
  }
}
