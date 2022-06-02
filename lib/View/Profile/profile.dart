import 'dart:convert';
import 'dart:io';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/View/FormAlamat/formAlamat.dart';
import 'package:omahdilit/View/Login/login.dart';
import 'package:omahdilit/View/Profile/editprofile.dart';
import 'package:omahdilit/View/Profile/policy.dart';
import 'package:omahdilit/bloc/alamat/alamat_bloc.dart';
import 'package:omahdilit/bloc/profile/profile_bloc.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/loading.dart';
import 'package:omahdilit/model/customer.dart';
import 'package:omahdilit/model/listalamat.dart';
import 'package:omahdilit/viewimage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Customer _customer = Customer();
  File? _sampleImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileSuccess) {
            _customer = state.customer;
            context.read<AlamatBloc>().add(GetAlamatEvent());
            return _buildView(context);
          } else if (state is ProfileError) {
            return _buildError();
          } else {
            return _buildLoading();
          }
        },
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    return Container(
      height: tinggi,
      width: lebar,
      padding: EdgeInsets.symmetric(
        horizontal: marginHorizontal,
        vertical: marginVertical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  if (_customer.photo != null) {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (_) =>
                                ViewImage(image: _customer.photo!)));
                  } else {
                    await pickImage(context).then((value) async {
                      cropImage(value);
                    });
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: marginHorizontal,
                    vertical: marginVertical,
                  ),
                  child: Badge(
                    badgeContent: GestureDetector(
                      onTap: () async {
                        await pickImage(context).then((value) async {
                          cropImage(value);
                        });
                      },
                      child: Icon(
                        CupertinoIcons.pen,
                        color: Colors.white,
                        size: marginVertical,
                      ),
                    ),
                    badgeColor: greyLight,
                    child: _customer.photo != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: "https://omahdilit.site/images/" +
                                  _customer.photo!,
                              width: lebar / 4.75,
                              height: lebar / 4.75,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              width: lebar / 4.75,
                              height: lebar / 4.75,
                              color: greyLight,
                              child: Icon(
                                CupertinoIcons.camera,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _customer.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: tinggi / lebar * 8.5,
                    ),
                  ),
                  Text(
                    _customer.number!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: tinggi / lebar * 7,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: marginVertical,
          ),
          BlocBuilder<AlamatBloc, AlamatState>(
            builder: (context, state) {
              if (state is AlamatLoaded) {
                return _buildAlamat(state.listAlamat.alamat!);
              } else {
                return _buildLoadingAlamat();
              }
            },
          ),
          SizedBox(
            height: marginVertical,
          ),
          Text(
            "Info Lainnya",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: tinggi / lebar * 8,
            ),
          ),
          SizedBox(
            height: marginVertical * .1,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (_) => EditProfile()));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: marginHorizontal / 2,
                  vertical: marginVertical / 1.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.grey,
                        size: marginHorizontal * 1.3,
                      ),
                      SizedBox(
                        width: marginHorizontal / 2,
                      ),
                      Text(
                        "Edit Profil",
                        style: TextStyle(
                          fontSize: tinggi / lebar * 8,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    CupertinoIcons.right_chevron,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: marginVertical * 2.5),
            child: Divider(
              color: Colors.grey.shade400,
              height: 1,
            ),
          ),
          InkWell(
            onTap: () {
              print("Kebijakan Privasi");
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (_) => const Policy(isPolicy: true)));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: marginHorizontal / 2,
                  vertical: marginVertical / 1.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.privacy_tip_outlined,
                        color: Colors.grey,
                        size: marginHorizontal * 1.3,
                      ),
                      SizedBox(
                        width: marginHorizontal / 2,
                      ),
                      Text(
                        "Kebijakan Privasi",
                        style: TextStyle(
                          fontSize: tinggi / lebar * 8,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    CupertinoIcons.right_chevron,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: marginVertical * 2.5),
            child: Divider(
              color: Colors.grey.shade400,
              height: 1,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (_) => const Policy(isPolicy: false)));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: marginHorizontal / 2,
                  vertical: marginVertical / 1.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.privacy_tip_outlined,
                        color: Colors.grey,
                        size: marginHorizontal * 1.3,
                      ),
                      SizedBox(
                        width: marginHorizontal / 2,
                      ),
                      Text(
                        "Syarat dan Ketentuan",
                        style: TextStyle(
                          fontSize: tinggi / lebar * 8,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    CupertinoIcons.right_chevron,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: marginVertical * 2.5),
            child: Divider(
              color: Colors.grey.shade400,
              height: 1,
            ),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: marginHorizontal / 2,
                  vertical: marginVertical / 1.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star_border_outlined,
                        color: Colors.grey,
                        size: marginHorizontal * 1.3,
                      ),
                      SizedBox(
                        width: marginHorizontal / 2,
                      ),
                      Text(
                        "Beri Kami Rating",
                        style: TextStyle(
                          fontSize: tinggi / lebar * 8,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    CupertinoIcons.right_chevron,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: marginVertical * 2.5),
            child: Divider(
              color: Colors.grey.shade400,
              height: 1,
            ),
          ),
          InkWell(
            onTap: () async {
              FirebaseAuth.instance.signOut();
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.clear();
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => Login(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: marginHorizontal / 2,
                  vertical: marginVertical / 1.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.grey,
                        size: marginHorizontal * 1.3,
                      ),
                      SizedBox(
                        width: marginHorizontal / 2,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: tinggi / lebar * 8,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    CupertinoIcons.right_chevron,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return LoadingBuilder();
  }

  Widget _buildError() {
    return Container();
  }

  Widget _buildAlamat(List<Alamat> listAlamat) {
    print(listAlamat.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Alamat Kamu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: tinggi / lebar * 8,
              ),
            ),
            GestureDetector(
              onTap: () {
                _awaitChangeAlamat(context);
              },
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: marginHorizontal,
                  vertical: marginVertical,
                ),
                child: Text(
                  "Atur Alamat",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: tinggi / lebar * 7,
                    color: blue,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: marginVertical / 2),
          child: Text(
            "Daftar alamat kamu untuk pesan cukur rambut",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: tinggi / lebar * 6,
            ),
          ),
        ),
        SizedBox(
          height: marginVertical,
        ),
        Container(
          width: lebar,
          height: tinggi * .175,
          child: listAlamat.isNotEmpty
              ? ListView.builder(
                  itemCount: listAlamat.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    Alamat _alamat = listAlamat[index];
                    return InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: marginHorizontal / 2),
                        child: Container(
                          width: lebar / 1.4,
                          padding: EdgeInsets.symmetric(
                            horizontal: marginHorizontal / 2,
                            vertical: marginVertical / 2,
                          ),
                          decoration: BoxDecoration(
                            color: _alamat.utama == 1
                                ? secondary
                                : greyMain.withOpacity(.2),
                            border: Border.all(
                              color: _alamat.utama == 1 ? primary : greyMain,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: _alamat.utama == 1
                                            ? primary
                                            : greyMain,
                                      ),
                                      Text(
                                        _alamat.tag.toString(),
                                        style: TextStyle(
                                          fontSize: tinggi / lebar * 6,
                                          fontWeight: FontWeight.w600,
                                          color: _alamat.utama == 1
                                              ? Colors.black
                                              : textAccent,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      _alamat.utama == 1
                                          ? Text(
                                              "Utama",
                                              style: TextStyle(
                                                fontSize: tinggi / lebar * 5.5,
                                                fontWeight: FontWeight.w500,
                                                color: _alamat.utama == 1
                                                    ? primary
                                                    : textAccent,
                                              ),
                                            )
                                          : Container(),
                                      InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: marginHorizontal / 5,
                                          ),
                                          child: Icon(
                                            Icons.check_circle_rounded,
                                            color: _alamat.utama == 1
                                                ? primary
                                                : greyMain,
                                          ),
                                        ),
                                      ),
                                      // InkWell(
                                      //   onTap: () {},
                                      //   child: Padding(
                                      //     padding: EdgeInsets.symmetric(
                                      //       horizontal: marginHorizontal / 7.5,
                                      //     ),
                                      //     child: Icon(
                                      //       Icons.edit,
                                      //       color:
                                      //           _alamat.utama == 1 ? primary : greyMain,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: marginVertical / 2,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _alamat.nama.toString(),
                                      style: TextStyle(
                                        fontSize: tinggi / lebar * 6,
                                        fontWeight: FontWeight.w500,
                                        color: _alamat.utama == 1
                                            ? Colors.black
                                            : textAccent,
                                      ),
                                    ),
                                    Text(
                                      _alamat.alamat.toString(),
                                      style: TextStyle(
                                        fontSize: tinggi / lebar * 6,
                                        fontWeight: FontWeight.w400,
                                        color: _alamat.utama == 1
                                            ? Colors.black
                                            : textAccent,
                                      ),
                                    ),
                                    Text(
                                      _alamat.kecamatan.toString() +
                                          ", " +
                                          _alamat.kota.toString() +
                                          ", " +
                                          _alamat.provinsi.toString(),
                                      style: TextStyle(
                                        fontSize: tinggi / lebar * 6,
                                        fontWeight: FontWeight.w400,
                                        color: _alamat.utama == 1
                                            ? Colors.black
                                            : textAccent,
                                      ),
                                    ),
                                    Text(
                                      _alamat.noTelp.toString(),
                                      style: TextStyle(
                                        fontSize: tinggi / lebar * 6.5,
                                        fontWeight: FontWeight.w400,
                                        color: _alamat.utama == 1
                                            ? Colors.black
                                            : textAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    "Kamu belum punya alamat",
                    style: TextStyle(
                      color: greyLight,
                    ),
                  ),
                ),
        )
      ],
    );
  }

  Widget _buildLoadingAlamat() {
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(
    //           "Alamat Kamu",
    //           style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: tinggi / lebar * 8,
    //           ),
    //         ),
    //         Text(
    //           "Atur Alamat",
    //           style: TextStyle(
    //             fontWeight: FontWeight.w500,
    //             fontSize: tinggi / lebar * 7,
    //             color: blue,
    //           ),
    //         ),
    //       ],
    //     ),
    //     Padding(
    //       padding: EdgeInsets.symmetric(vertical: marginVertical / 2),
    //       child: Text(
    //         "Daftar alamat kamu untuk pesan cukur rambut",
    //         style: TextStyle(
    //           color: Colors.grey,
    //           fontWeight: FontWeight.w500,
    //           fontSize: tinggi / lebar * 6,
    //         ),
    //       ),
    //     ),
    //     SizedBox(
    //       height: marginVertical,
    //     ),
    //     Flexible(
    //       child: Shimmer.fromColors(
    //         child: ListView.builder(
    //           itemCount: 10,
    //           itemBuilder: (BuildContext context, int index) {
    //             return Card(
    //               elevation: 2,
    //               margin: EdgeInsets.symmetric(
    //                 horizontal: marginHorizontal,
    //                 vertical: marginVertical / 2,
    //               ),
    //               child: Container(
    //                 width: lebar,
    //                 height: tinggi * .15,
    //                 margin: EdgeInsets.symmetric(
    //                   vertical: marginVertical / 2,
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //         baseColor: Colors.grey,
    //         highlightColor: Colors.grey.shade300,
    //       ),
    //     ),
    //   ],
    // );
    return Center(
      child: Container(
        width: lebar / 3,
        height: lebar / 3,
        child: LottieBuilder.asset("assets/loading.json"),
      ),
    );
  }

  Future<void> _awaitaddAlamat(BuildContext context) async {
    Navigator.pop(context);
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => FormAlamat(uid: _customer.uid!),
      ),
    );
  }

  void _awaitChangeAlamat(BuildContext context) async {
    final result = await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      context: context,
      elevation: 1,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter updateState) {
            var _currentAlamat;
            return Container(
              height: tinggi / 3,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: marginHorizontal,
                      right: marginHorizontal,
                      top: marginVertical,
                      bottom: marginVertical / 2,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: tinggi / 100,
                          width: lebar / 9,
                          decoration: BoxDecoration(
                            color: greyPill,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: marginVertical,
                            bottom: marginVertical / 2,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.black,
                                    size: lebar / 15,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: marginHorizontal / 2,
                                    ),
                                    child: Text(
                                      "Alamat Kamu",
                                      style: TextStyle(
                                        fontSize: tinggi / lebar * 8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  _awaitaddAlamat(context);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Tambah Alamat",
                                      style: TextStyle(
                                        fontSize: tinggi / lebar * 5,
                                        fontWeight: FontWeight.w500,
                                        color: primary,
                                      ),
                                    ),
                                    Icon(
                                      Icons.add_outlined,
                                      color: primary,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: marginVertical),
                          width: lebar,
                          child: Text(
                            "Alamat yang bisa kamu pake buat cukur",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: tinggi / lebar * 6,
                              fontWeight: FontWeight.w500,
                              color: textAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<AlamatBloc, AlamatState>(
                      builder: (context, state) {
                        // print(snapshot.toString());
                        if (state is AlamatLoaded) {
                          ListAlamat listAlamat = state.listAlamat;
                          bool utamaItem;
                          if (listAlamat.alamat!.isNotEmpty) {
                            return Container(
                              child: ListView.builder(
                                itemCount: listAlamat.alamat!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == 0) {
                                    utamaItem = true;
                                    _currentAlamat = listAlamat.alamat![index];
                                  } else {
                                    utamaItem = false;
                                  }
                                  return Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: marginHorizontal / 2),
                                    child: Container(
                                      width: lebar / 1.4,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: marginHorizontal / 2,
                                        vertical: marginVertical / 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: utamaItem
                                            ? secondary
                                            : greyMain.withOpacity(.2),
                                        border: Border.all(
                                          color: utamaItem ? primary : greyMain,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    color: utamaItem
                                                        ? primary
                                                        : greyMain,
                                                  ),
                                                  Text(
                                                    listAlamat
                                                        .alamat![index].tag
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          tinggi / lebar * 6,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: utamaItem
                                                          ? Colors.black
                                                          : textAccent,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  listAlamat.alamat![index]
                                                              .utama ==
                                                          1
                                                      ? Text(
                                                          "Utama",
                                                          style: TextStyle(
                                                            fontSize: tinggi /
                                                                lebar *
                                                                5.5,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: utamaItem
                                                                ? primary
                                                                : textAccent,
                                                          ),
                                                        )
                                                      : Container(),
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            marginHorizontal /
                                                                5,
                                                      ),
                                                      child: Icon(
                                                        Icons
                                                            .check_circle_rounded,
                                                        color: utamaItem
                                                            ? primary
                                                            : greyMain,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      await Navigator.push(
                                                          context,
                                                          CupertinoPageRoute(
                                                              builder: (_) =>
                                                                  FormAlamat(
                                                                    uid: _customer
                                                                        .uid!,
                                                                    isEdit:
                                                                        true,
                                                                    alamat: listAlamat
                                                                            .alamat![
                                                                        index],
                                                                  )));
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            marginHorizontal /
                                                                7.5,
                                                      ),
                                                      child: Icon(
                                                        Icons.edit,
                                                        color: utamaItem
                                                            ? primary
                                                            : greyMain,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              bottom: marginVertical,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  listAlamat.alamat![index].nama
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        tinggi / lebar * 6,
                                                    fontWeight: FontWeight.w500,
                                                    color: utamaItem
                                                        ? Colors.black
                                                        : textAccent,
                                                  ),
                                                ),
                                                Text(
                                                  listAlamat
                                                      .alamat![index].alamat
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        tinggi / lebar * 6,
                                                    fontWeight: FontWeight.w400,
                                                    color: utamaItem
                                                        ? Colors.black
                                                        : textAccent,
                                                  ),
                                                ),
                                                Text(
                                                  listAlamat.alamat![index]
                                                          .kecamatan
                                                          .toString() +
                                                      ", " +
                                                      listAlamat
                                                          .alamat![index].kota
                                                          .toString() +
                                                      ", " +
                                                      listAlamat.alamat![index]
                                                          .provinsi
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        tinggi / lebar * 6,
                                                    fontWeight: FontWeight.w400,
                                                    color: utamaItem
                                                        ? Colors.black
                                                        : textAccent,
                                                  ),
                                                ),
                                                Text(
                                                  listAlamat
                                                      .alamat![index].noTelp
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        tinggi / lebar * 6.5,
                                                    fontWeight: FontWeight.w400,
                                                    color: utamaItem
                                                        ? Colors.black
                                                        : textAccent,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return Center(
                              child: Text(
                                "Kamu belum punya alamat",
                                style: TextStyle(
                                  color: greyLight,
                                ),
                              ),
                            );
                          }
                        } else {
                          return Shimmer.fromColors(
                            child: Container(
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: marginHorizontal / 2),
                                child: Container(
                                  width: lebar / 1.4,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: marginHorizontal / 2,
                                    vertical: marginVertical / 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: greyMain.withOpacity(.2),
                                    border: Border.all(
                                      color: greyMain,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade400,
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: marginVertical,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<File> pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    try {
      final _pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      return File(_pickedFile!.path);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  void cropImage(File file) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );

    croppedFile!.readAsBytes().then(
      (value) {
        context.read<ProfileBloc>().add(
              UpdateAva(
                _customer.uid!,
                base64Encode(value),
              ),
            );
      },
    );
  }
}
