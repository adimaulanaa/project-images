import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_gallery/core/media/media_colors.dart';
import 'package:my_gallery/core/media/media_res.dart';
import 'package:my_gallery/core/media/media_text.dart';
import 'package:my_gallery/core/utils/page_route.dart';

class CustomScaffold extends StatelessWidget {
  final bool showAppBar;
  final bool centerTitle;
  final Widget body;
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backgroundColor;
  final List<Widget>? actions;

  const CustomScaffold({
    super.key,
    required this.body,
    this.showAppBar = true,
    this.centerTitle = true,
    this.title,
    this.showBackButton = false,
    this.onBackPressed,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      appBar: showAppBar
          ? AppBar(
              elevation: 0,
              scrolledUnderElevation: 0.0,
              surfaceTintColor:
                  Colors.transparent, // hilangkan background saat scroll
              backgroundColor: backgroundColor ?? AppColors.background,
              centerTitle: centerTitle,
              leading: showBackButton
                  ? IconButton(
                      onPressed: onBackPressed ?? () => context.popPage(),
                      icon: SvgPicture.asset(
                        MediaRes.back, // path svg kamu
                        width: 23,
                        height: 23,
                        colorFilter: const ColorFilter.mode(
                          AppColors.textTitle,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  : null,
              title: title != null
                  ? Text(
                      title!,
                      style: blackTextstyle.copyWith(fontWeight: bold),
                    )
                  : null,
              actions: actions,
            )
          : null,
      body: body,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
    );
  }
}
