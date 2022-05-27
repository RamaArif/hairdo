import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

Color primary = Color(0xFFFA163F);
Color secondary = Color(0x40FA163F);
Color textColor = Colors.black;
Color black = Colors.black;
Color textField = Color(0xFFF2F2F2);
Color textAccent = Color(0xFF717171);
Color greyMain = Color(0xFFA09F9F);
Color greyDark = Color(0xFF6F6F6F);
Color greyBackground = Color(0xFFF8F8F8);
Color greyPill = Color(0xFFDFDFDF);
Color greyLight = Colors.grey.shade400;
Color blue = Color(0xFF2A8DD8);
Color blueshade = Color(0x402A8DD8);
Color yellow = Color(0xFFF9B917);
Color like = Color(0xFF10AC84);
Color dislike = Color(0xFFEE5253);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight blackBold = FontWeight.w900;

var tinggi;
var lebar;
var marginHorizontal;
var marginVertical;
var numberFormat = new NumberFormat.currency(locale: 'id', symbol: "Rp");

TextStyle textStyle = GoogleFonts.poppins();
Style htmlGrey = Style(
    fontFamily: GoogleFonts.poppins().fontFamily,
    color: Colors.grey.shade500,
    fontSize: FontSize(tinggi/lebar*7),
    fontWeight: medium);
    
Style htmlBlack = Style(
    fontFamily: GoogleFonts.poppins().fontFamily,
    color: black,
    fontSize: FontSize(tinggi/lebar*7),
    fontWeight: medium);