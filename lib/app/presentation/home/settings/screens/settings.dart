import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/constants/images.dart';
import 'package:hurricane_events/component/utils/extensions.dart';

import '../widgets/setting_tile.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = "settings-screen";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Gap(45),
              Text(
                "Settings",
                textAlign: TextAlign.center,
                style: context.headline3.copyWith(
                  fontSize: 16,
                ),
              ),
              const Gap(40),
              ListTile(
                leading: ClipOval(child: Image.asset(AppImages.imgSamuel)),
                tileColor: AppColors.p10,
                title: Text(
                  "Samuel Igboji",
                  style: context.headline3.copyWith(
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  "uche.samuel21@gmail.com",
                  style: context.body2.copyWith(
                    fontSize: 12,
                    color: AppColors.designBlack5,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                ),
              ),
              const Gap(40),
              SettingTile(
                title: "Notifications",
                imgPath: AppImages.notifications,
                onTap: () {},
              ),
              SettingTile(
                title: "Privacy",
                imgPath: AppImages.privacy,
                onTap: () {},
              ),
              SettingTile(
                title: "Appearance",
                imgPath: AppImages.appearance,
                onTap: () {},
              ),
              SettingTile(
                title: "Language and Region",
                imgPath: AppImages.language,
                onTap: () {},
              ),
              SettingTile(
                title: "Help and Support",
                imgPath: AppImages.help,
                onTap: () {},
              ),
              SettingTile(
                title: "About",
                imgPath: AppImages.about,
                onTap: () {},
              ),
              const Gap(64),
              MaterialButton(
                onPressed: () {},
                color: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 15,
                          height: 15,
                          child: Image.asset(AppImages.logout),
                        ),
                        const Gap(10),
                        Text(
                          "Logout",
                          style: context.body2.copyWith(fontSize: 16, color: AppColors.designRed),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
