import 'package:flutter/material.dart';
import 'package:my_gallery/core/media/media_colors.dart';

// FontStyle
// SEMUA FONT FAMILY DIUBAH KE 'Poppins'

TextStyle transTextstyle = const TextStyle(
  fontFamily: 'Poppins',
  color: Colors.transparent,
);
TextStyle whiteTextstyle = const TextStyle(
  fontFamily: 'Poppins',
  color: AppColors.primaryForeground,
);
TextStyle blackTextstyle = const TextStyle(
  fontFamily: 'Poppins',
  color: AppColors.textTitle,
);
TextStyle greyTextstyle = const TextStyle(
  fontFamily: 'Poppins',
  color: AppColors.textBody,
);
TextStyle greenTextstyle = const TextStyle(
  fontFamily: 'Poppins',
  color: AppColors.success,
);
TextStyle yellowTextstyle = const TextStyle(
  fontFamily: 'Poppins',
  color: AppColors.warning,
);
TextStyle redTextstyle = const TextStyle(
  fontFamily: 'Poppins',
  color: AppColors.error,
);

TextStyle primaryTextstyle = const TextStyle(
  fontFamily: 'Poppins',
  color: AppColors.primary,
);
TextStyle secondaryTextstyle = const TextStyle(
  fontFamily: 'Poppins',
  color: AppColors.secondary,
);

// FontWeight
// Poppins supports these weights, pastikan berkas TTFnya sudah didefinisikan di pubspec.yaml

FontWeight thin =
    FontWeight.w100; // Poppins-Thin.ttf (Jika ada di download Anda)
FontWeight light = FontWeight.w300; // Poppins-Light.ttf
FontWeight reguler = FontWeight.w400; // Poppins-Regular.ttf
FontWeight medium = FontWeight.w500; // Poppins-Medium.ttf
FontWeight semiBold = FontWeight.w600; // Poppins-SemiBold.ttf
FontWeight bold = FontWeight.w700; // Poppins-Bold.ttf
FontWeight extraBold = FontWeight.w800; // Poppins-ExtraBold.ttf
