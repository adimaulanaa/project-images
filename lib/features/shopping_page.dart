import 'package:flutter/material.dart';
import 'package:my_gallery/core/media/media_colors.dart';
import 'package:my_gallery/core/media/media_text.dart';
import 'package:my_gallery/core/utils/page_route.dart';
import 'package:my_gallery/core/widgets/botton.dart';
import 'package:my_gallery/core/widgets/custom_loading.dart';
import 'package:my_gallery/core/widgets/custom_popup.dart';
import 'package:my_gallery/core/widgets/custom_scafold.dart';
import 'package:my_gallery/navigator_page.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  // Dummy data
  final List<Map<String, String>> items = List.generate(
    4,
    (index) => {
      "image": "https://picsum.photos/1080/1920?random=$index",
      "title": "Images $index",
    },
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CustomScaffold(
      backgroundColor: AppColors.background,
      title: 'Shopping Cart',
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final item = items[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.5),
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // 👈 penting biar teks di atas kiri
                children: [
                  // Gambar produk
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item["image"]!,
                      width: size.width * 0.22,
                      height: size.width * 0.22,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: size.width * 0.22,
                        height: size.width * 0.22,
                        color: AppColors.primary.withValues(alpha: 0.2),
                        child: const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Informasi produk
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'IMG_202939484_734432.jpg',
                          style: blackTextstyle.copyWith(
                            fontSize: 14,
                            fontWeight: medium,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Nama Fotografer',
                          style: greyTextstyle.copyWith(
                            fontSize: 13,
                            fontWeight: reguler,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'GBK Senayan City',
                          style: greyTextstyle.copyWith(
                            fontSize: 13,
                            fontWeight: reguler,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: UIButton(
          type: UIButtonType.filled,
          size: UIButtonSize.medium,
          label: 'Buat Pesanan',
          onPressed: () async {
            LoadingScreen.show(context);
            await Future.delayed(const Duration(seconds: 3));
            // ignore: use_build_context_synchronously
            LoadingScreen.hide(context);
            if (!context.mounted) {
              return; // Cegah error use_build_context_synchronously
            }

            Popup.showSuccess(
              context,
              title: 'Berhasil',
              message: 'Foto Anda Pesan',
              onButtonPressed: () {
                context.pushAndRemoveUntilPage(
                  NavigatorPage(),
                  type: TransitionType.fade,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
