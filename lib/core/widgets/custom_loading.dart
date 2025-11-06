import 'package:flutter/material.dart';
import 'package:my_gallery/core/media/media_colors.dart';
import 'package:my_gallery/core/media/media_res.dart';
import 'package:my_gallery/core/media/media_text.dart';
import 'package:my_gallery/core/utils/page_route.dart';

class LoadingScreen {
  static void show(BuildContext context, {String? text, Color? colorText}) {
    showDialog(
      context: context,
      barrierDismissible: false, // supaya tidak bisa tap luar untuk close
      barrierColor: Colors.black54, // warna background semi transparan
      builder: (_) => PopScope(
        canPop: false, // disable tombol back
        child: LoadingIndicator(text: text, colorText: colorText),
      ),
    );
  }

  static void hide(BuildContext context) {
    if (context.canPopPage()) {
      context.popPage(); // ini sudah otomatis animasi reverse route yang tadi
    }
  }
}

class LoadingPage extends StatelessWidget {
  final String? text;
  final Color? colorText;
  const LoadingPage({super.key, this.text, this.colorText});

  @override
  Widget build(BuildContext context) {
    // Kalau text null → gunakan default
    final displayText = text ?? 'Tunggu Sebentar';
    // Kalau colorText null → default putih
    final displayColor = colorText ?? Colors.transparent;
    return Scaffold(
      backgroundColor: displayColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(MediaRes.logo, width: 100, height: 100),
            // Text Dynamic
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                displayText,
                textAlign: TextAlign.center,
                style: whiteTextstyle.copyWith(
                  fontSize: 18,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  final String? text;
  final Color? colorText;
  const LoadingIndicator({super.key, this.text, this.colorText});

  @override
  Widget build(BuildContext context) {
    final displayText = text ?? 'Tunggu Sebentar...';
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // Kotak putih berisi indikator & teks
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    displayText,
                    textAlign: TextAlign.center,
                    style: blackTextstyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
