import 'package:animals_book/resource/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class StyleBkav {
  static TextStyle textStyleFW400(Color? color, double? size, {TextOverflow ? overflow, double ? height}) {
    return GoogleFonts.roboto(
        textStyle:
        TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w400, overflow: overflow ?? TextOverflow.ellipsis, height: height ?? 1));
  }
  static TextStyle textStyleFW500(Color? color, double? size, {TextOverflow ? overflow, double ? height}) {
    return GoogleFonts.roboto(
        textStyle:
        TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w500, overflow: overflow ?? TextOverflow.ellipsis, height: height ?? 1));
  }
  static TextStyle textStyleFW400NotOverflow(Color? color, double? size, {TextOverflow ? overflow, double ? height}) {
    return GoogleFonts.roboto(
      textStyle:
      TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w400, height: height ?? 1),);
  }
  static TextStyle textStyleFW700(Color? color, double? size, {TextOverflow ? overflow, double ? height, FontWeight? fontWeight}) {
    return GoogleFonts.roboto(
        textStyle:
        TextStyle(color: color, fontSize: size, fontWeight: fontWeight ?? FontWeight.w700, overflow: overflow ?? TextOverflow.ellipsis, height: height ?? 1));
  }
  static TextStyle textStyleBlack12() {
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: AppColor.black22, fontSize: 12, fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis));
  }
  static TextStyle textStyleBlack14() {
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: AppColor.black22, fontSize: 14, fontWeight: FontWeight.w400,overflow: TextOverflow.visible,));
  }
  static TextStyle textStyleBlack16({TextOverflow ? overflow}) {
    return GoogleFonts.roboto(
        textStyle:
        TextStyle(color: AppColor.black22, fontSize: 16, fontWeight: FontWeight.w700, overflow: overflow ??TextOverflow.ellipsis));
  }
  static TextStyle textStyleGray20() {
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700,overflow: TextOverflow.ellipsis));
  }
  //Bkav Nhungltk
  static TextStyle textGrey400({Color? colors}){
    return GoogleFonts.roboto(
        textStyle: TextStyle(
            color: colors ?? AppColor.gray400,
            fontSize: 14,
            fontWeight: FontWeight.w400));
  }

  static TextStyle textBlack700Size14(){
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: AppColor.black22, fontSize: 14, fontWeight: FontWeight.w700, height: 1.4));
  }

  static TextStyle textStyleFullBlack14() {
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: AppColor.black22, fontSize: 14, fontWeight: FontWeight.w400));
  }

  static TextStyle textStyleGray300() {
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColor.gray300));
  }

  static TextStyle textStyleBlack14NotOverflow() {
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: AppColor.black22, fontSize: 14, fontWeight: FontWeight.w400, height: 1.4));
  }

  static TextStyle textStyleBlack16NotOverflow() {
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: AppColor.back09, fontSize: 15, fontWeight: FontWeight.w700));
  }

  static TextStyle textStyleGray400weight600() {
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: AppColor.gray400,
            fontSize: 14,
            fontWeight: FontWeight.w600));
  }
  static TextStyle textStyleGreen() {
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: AppColor.green1, fontSize: 16, fontWeight: FontWeight.w700));
  }
  static TextStyle textGrey(){
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: AppColor.gray500, fontSize: 12, fontWeight: FontWeight.w400));
  }
  static TextStyle textBlackContent(){
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: AppColor.black22, fontSize: 14, fontWeight: FontWeight.w400));
  }
  static TextStyle textBlackContactName(){
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: AppColor.black22, fontSize: 14, fontWeight: FontWeight.w700));
  }

  static TextStyle textItalicRed400(){
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: AppColor.redE5, fontSize: 11, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic));
  }
  static TextStyle textSumCart(){
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: AppColor.gray11, fontSize: 14, fontWeight: FontWeight.w500));
  }
  static TextStyle textSumNumber(){
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: AppColor.main, fontSize: 29, fontWeight: FontWeight.w500));
  }
  static TextStyle textSumNumberNotAc(){
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: AppColor.gray12, fontSize: 29, fontWeight: FontWeight.w500));
  }
  static TextStyle textToday(){
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: AppColor.main, fontSize: 12, fontWeight: FontWeight.w400));
  }
  static TextStyle textScore(Color color){
    return GoogleFonts.roboto(
        textStyle:
        TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w400));
  }
  static TextStyle textCustomerManager(){
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500));
  }

  static TextStyle textRangerDay(){
    return GoogleFonts.roboto(
        textStyle:
        const TextStyle(color: AppColor.main, fontSize: 20, fontWeight: FontWeight.w500));
  }
  static TextStyle textAboutNoScore(Color color){
    return GoogleFonts.roboto(
        textStyle:
        TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic, height: 1.406));
  }

}