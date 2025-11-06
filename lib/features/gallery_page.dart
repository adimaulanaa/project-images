import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_gallery/core/media/media_colors.dart';
import 'package:my_gallery/core/media/media_res.dart';
import 'package:my_gallery/core/media/media_text.dart';
import 'package:my_gallery/core/utils/page_route.dart';
import 'package:my_gallery/core/widgets/botton.dart';
import 'package:my_gallery/core/widgets/custom_inkwell.dart';
import 'package:my_gallery/core/widgets/custom_scafold.dart';
import 'package:my_gallery/features/detail_images_page.dart';
import 'package:my_gallery/features/shopping_page.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  // Dummy data
  final List<Map<String, String>> items = List.generate(
    20,
    (index) => {
      "image": "https://picsum.photos/1080/1920?random=$index",
      "title": "Images $index",
    },
  );
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.background,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: CustomInkWell(
            onTap: () {
              context.pushPage(
                const ShoppingPage(),
                type: TransitionType.slide,
              );
            },
            child: SvgPicture.asset(
              MediaRes.bag,
              width: 24,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
          ),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            UIButton(
              type: UIButtonType.outlined,
              size: UIButtonSize.medium,
              onPressed: () {
                // handleGoogleSignIn(context);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomInkWell(
                    onTap: () {
                      context.pushPage(
                        const ShoppingPage(),
                        type: TransitionType.slide,
                      );
                    },
                    child: SvgPicture.asset(
                      MediaRes.search,
                      width: 23,
                      height: 23,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Search',
                    style: primaryTextstyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemCount: 20,
                itemBuilder: (context, index) {
                  final height = (index % 2 == 0) ? 200.0 : 150.0;
                  return Tile(
                    index: index,
                    height: height,
                    title: items[index]["title"]!,
                    images: items[index]["image"]!,
                    onTap: () {
                      context.pushPage(
                        DetailImagesPage(images: items[index]["image"]!),
                        type: TransitionType.slide,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final int index;
  final double height;
  final String title;
  final String images;
  final VoidCallback onTap;

  const Tile({
    super.key,
    required this.index,
    required this.height,
    required this.title,
    required this.images,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Kotak gambar
        CustomInkWell(
          onTap: () => onTap(),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: AppColors.primary[(index % 9 + 1) * 100],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(images, fit: BoxFit.cover),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.left,
          style: greyTextstyle.copyWith(fontSize: 12, fontWeight: reguler),
        ),
      ],
    );
  }
}
