import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_gallery/core/media/media_colors.dart';
import 'package:my_gallery/core/media/media_res.dart';
import 'package:my_gallery/core/media/media_text.dart';
import 'package:my_gallery/core/utils/page_route.dart';
import 'package:my_gallery/core/widgets/custom_inkwell.dart';
import 'package:my_gallery/core/widgets/custom_scafold.dart';
import 'package:my_gallery/features/shopping_page.dart';

class DetailImagesPage extends StatefulWidget {
  final String images;
  const DetailImagesPage({super.key, required this.images});

  @override
  State<DetailImagesPage> createState() => _DetailImagesPageState();
}

class _DetailImagesPageState extends State<DetailImagesPage> {
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
    Size size = MediaQuery.of(context).size;
    return CustomScaffold(
      showAppBar: false,
      body: SafeArea(
        child: Stack(
          children: [
            // 1. Bagian Foto Utama (Hero Image)
            _buildHeroImage(size.height, widget.images),
            // 2. Bagian Tombol Kembali (Overlay)
            Positioned(
              top: 20,
              left: 10,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol back di kiri
                  CustomInkWell(
                    onTap: () => context.popPage(),
                    child: SvgPicture.asset(
                      MediaRes.back,
                      width: 25,
                      height: 25,
                      colorFilter: const ColorFilter.mode(
                        AppColors.background,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),

                  // Tombol tiga titik di kanan
                  CustomInkWell(
                    onTap: () {
                      debugPrint('More tapped');
                    },
                    child: const Icon(
                      Icons.more_vert, // ← ini ikon tiga titik vertikal
                      color: AppColors.background,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),

            // Bottom sheet langsung muncul
            DraggableScrollableSheet(
              initialChildSize: 0.1, // tinggi awal
              minChildSize: 0.1, // batas minimum
              maxChildSize: 0.5, // maksimal (bisa penuh)
              expand: true,
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.only(top: 10, left: 12, right: 12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 8),
                    ],
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.textBody.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildProfileAndActions(widget.images),
                        SizedBox(height: 20),
                        Container(
                          width: size.width,
                          height: 1,
                          decoration: BoxDecoration(
                            color: AppColors.textBody.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 10),
                        InfoRow(label: 'Location', value: 'BGK Senayan'),
                        InfoRow(label: 'Tanggal', value: '25 November 2025'),
                        InfoRow(label: 'Jam', value: '09:30'),
                        InfoRow(label: 'Status', value: 'Approved'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImage(double screenHeight, String images) {
    return Stack(
      children: [
        // Foto utama
        Container(
          height: screenHeight * 0.9,
          width: double.infinity,
          color: AppColors.primary,
          child: Image.network(images, fit: BoxFit.cover),
        ),

        // Gradient di bawah foto biar smooth ke bottom sheet
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 120,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black26, Colors.black45],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileAndActions(String images) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.network(
                  images,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name Fotografer',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '@nickname_fotografer',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              CustomInkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  MediaRes.favorite,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 15),
              CustomInkWell(
                onTap: () {
                  context.pushPage(
                    const ShoppingPage(),
                    type: TransitionType.slide,
                  );
                },
                child: SvgPicture.asset(
                  MediaRes.bag,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ],
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
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: height,
            decoration: BoxDecoration(
              color: AppColors.primary[(index % 9 + 1) * 100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(images, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.left,
            style: greyTextstyle.copyWith(fontSize: 12, fontWeight: reguler),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: greyTextstyle.copyWith(
                  fontSize: 16,
                  fontWeight: reguler,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                style: blackTextstyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
