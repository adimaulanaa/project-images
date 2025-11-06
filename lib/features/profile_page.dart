import 'package:flutter/material.dart';
import 'package:my_gallery/core/media/media_colors.dart';
import 'package:my_gallery/core/media/media_text.dart';
import 'package:my_gallery/core/widgets/custom_scafold.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Profile Page',
          style: blackTextstyle.copyWith(fontSize: 30, fontWeight: bold),
        ),
      ),
    );
  }
}
