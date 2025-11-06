import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_gallery/core/media/media_colors.dart';
import 'package:my_gallery/core/media/media_res.dart';
import 'package:my_gallery/core/media/media_text.dart';
import 'package:my_gallery/core/utils/page_route.dart';
import 'package:my_gallery/core/widgets/botton.dart';
import 'package:my_gallery/core/widgets/custom_inkwell.dart';
import 'package:my_gallery/core/widgets/custom_scafold.dart';
import 'package:my_gallery/features/shopping_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomScaffold(
      showBackButton: false,
      backgroundColor: AppColors.background,
      centerTitle: false,
      title: 'MyApps',
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CustomInkWell(
            onTap: () {
              context.pushPage(const ShoppingPage(), type: TransitionType.slide);
            },
            child: SvgPicture.asset(
              MediaRes.bag,
              width: 24,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SvgPicture.asset(
            MediaRes.notif,
            width: 24,
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
        ),
      ],
      body: SafeArea(
        child: Padding(
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
                  children: [
                    SvgPicture.asset(
                      MediaRes.gallery,
                      width: 70,
                      height: 70,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Yuk, gunakan Face Scan untuk temukan semua fotomu',
                        textAlign: TextAlign.left,
                        style: blackTextstyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoxFeatures(
                    size: size,
                    images: MediaRes.location,
                    label: 'Location',
                    onTap: () {},
                  ),
                  SizedBox(width: 10),
                  BoxFeatures(
                    size: size,
                    images: MediaRes.video,
                    label: 'Video',
                    onTap: () {},
                  ),
                  SizedBox(width: 10),
                  BoxFeatures(
                    size: size,
                    images: MediaRes.favorite,
                    label: 'Favorite',
                    onTap: () {},
                  ),
                  SizedBox(width: 10),
                  BoxFeatures(
                    size: size,
                    images: MediaRes.history,
                    label: 'History',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BoxFeatures extends StatelessWidget {
  final Size size;
  final String label;
  final String images;
  final VoidCallback onTap;
  const BoxFeatures({
    super.key,
    required this.size,
    required this.label,
    required this.images,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () => onTap(),
      child: Container(
        width: size.width * 0.2,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              images,
              width: 35,
              height: 35,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: blackTextstyle.copyWith(fontSize: 12, fontWeight: medium),
            ),
          ],
        ),
      ),
    );
  }
}
