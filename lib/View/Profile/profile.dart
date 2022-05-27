import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:omahdilit/View/Login/login.dart';
import 'package:omahdilit/View/Profile/policy.dart';
import 'package:omahdilit/bloc/alamat/alamat_bloc.dart';
import 'package:omahdilit/bloc/profile/profile_bloc.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/loading.dart';
import 'package:omahdilit/model/customer.dart';
import 'package:omahdilit/model/listalamat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Customer _customer = Customer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: marginHorizontal,
                  vertical: marginVertical,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://omahdilit.site/images/" + _customer.photo!,
                    width: lebar / 4.75,
                    height: lebar / 4.75,
                    fit: BoxFit.cover,
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
              sharedPreferences.remove("loggedIn");
              sharedPreferences.remove("user");
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: marginVertical * 2.5),
            child: Divider(
              color: Colors.grey.shade400,
              height: 1,
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
            Text(
              "Atur Alamat",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: tinggi / lebar * 7,
                color: blue,
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
          child: listAlamat.length != 0
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
                    "Belum ada alamat",
                    style: TextStyle(
                      color: greyBackground,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildLoadingAlamat() {
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
            Text(
              "Atur Alamat",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: tinggi / lebar * 7,
                color: blue,
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
        Flexible(
          child: Shimmer.fromColors(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(
                    horizontal: marginHorizontal,
                    vertical: marginVertical / 2,
                  ),
                  child: Container(
                    width: lebar,
                    height: tinggi * .15,
                    margin: EdgeInsets.symmetric(
                      vertical: marginVertical / 2,
                    ),
                  ),
                );
              },
            ),
            baseColor: Colors.grey,
            highlightColor: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}
