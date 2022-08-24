import 'package:animals_book/resource/assets.dart';
import 'package:animals_book/resource/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';


class CustomAppBar extends AppBar {
  final BuildContext context;

  static Widget defaultBackButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 6),
      child: IconButton(
        icon: SvgPicture.asset(
          IconAsset.icArrowLeft,
          height: 15,
          // color: Colors.,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        color: Colors.white,
        padding: EdgeInsets.zero,
      ),
    );
  }

  CustomAppBar(
      this.context, {
        required bool showDefaultBackButton,
        bool hasBottom=false,
        bool centerTitle = true,
        double toolbarHeight = 44,
        double elevation = 0,
        Key? key,
        Widget? leading,
        bool automaticallyImplyLeading = true,
        Widget? title,
        List<Widget>? actions,
        Widget? flexibleSpace,
        PreferredSizeWidget? bottom,
        Color? shadowColor,
        ShapeBorder? shape,
        Color? backgroundColor = AppColor.whiteF5,
        Color? foregroundColor,
        Brightness? brightness,
        IconThemeData? iconTheme,
        IconThemeData? actionsIconTheme,
        TextTheme? textTheme,
        bool primary = true,
        bool excludeHeaderSemantics = false,
        double? titleSpacing,
        double toolbarOpacity = 1.0,
        // double bottomOpacity = 0.5,
        double? leadingWidth = 34,
        bool? backwardsCompatibility,
        TextStyle? toolbarTextStyle,
        TextStyle? titleTextStyle,
        SystemUiOverlayStyle? systemOverlayStyle = SystemUiOverlayStyle.dark,
      }) : super(
      key: key,
      leading:
      showDefaultBackButton ? defaultBackButton(context) : leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title,
      actions: actions,
      flexibleSpace: flexibleSpace,
      // bottom:hasBottom? bottom: PreferredSize(
      //     preferredSize: const Size.fromHeight(3),
      //     child: Container(
      //       color: AppColor.gray9B,
      //       height: 1,
      //     )),
      elevation: elevation,
      shadowColor: shadowColor,
      shape: shape,
      backgroundColor: backgroundColor,
      // foregroundColor: foregroundColor,
      //brightness: brightness,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      primary: primary,
      centerTitle: centerTitle,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: titleSpacing,
      toolbarOpacity: toolbarOpacity,
      //bottomOpacity: bottomOpacity,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      toolbarTextStyle: toolbarTextStyle,
      titleTextStyle: titleTextStyle,
      systemOverlayStyle: systemOverlayStyle
    // const SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     statusBarIconBrightness: Brightness.light,
    //   )
  );
}
