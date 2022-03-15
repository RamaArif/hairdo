import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omahdilit/bloc/bloc/activity_bloc.dart';
import 'package:omahdilit/bloc/transaksi/transaksi_bloc.dart';

class DetailPesanan extends StatefulWidget {
  const DetailPesanan({Key? key}) : super(key: key);

  @override
  State<DetailPesanan> createState() => _DetailPesananState();
}

class _DetailPesananState extends State<DetailPesanan> {
  ActivityBloc _activityBloc = ActivityBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activityBloc.add(GetActivity());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityBloc(),
      child: BlocBuilder<ActivityBloc, ActivityState>(
        builder: (context, state) {
          if (state is TransaksiLoaded ) {
            return _buildView(context);
          } 
          return Container();
        },
      ),
    );
  }
}

Widget _buildView(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: Color(0xFF6F6F6F),
          size: 21,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Color(0xFF6F6F6F)),
      title: Text(
        "Model Rambut",
        style: TextStyle(color: Color(0xFF6F6F6F), fontSize: 18.0),
      ),
    ),
    body: Column(
      children: [],
    ),
  );
}
