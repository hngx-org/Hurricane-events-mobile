import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/constants/images.dart';
import 'package:hurricane_events/component/enums/enums.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/domain/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/setting_tile.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = "settings-screen";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  12.height,
                  Text(
                    "Settings",
                    textAlign: TextAlign.center,
                    style: context.headline3.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  40.height,
                  ListTile(
                    leading: ClipOval(
                      child: Builder(
                        builder: (context) {
                          if (userProvider.user?.avatar == null) {
                            return Image.asset(
                              AppImages.imgSamuel,
                              height: 44,
                              width: 44,
                            );
                          }

                          return CachedNetworkImage(
                            imageUrl: userProvider.user?.avatar ?? "",
                            height: 44,
                            width: 44,
                            errorWidget: (context, url, error) {
                              return Image.asset(
                                AppImages.imgSamuel,
                                height: 44,
                                width: 44,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    tileColor: AppColors.p10,
                    title: Text(
                      userProvider.user?.name ?? "Default",
                      style: context.headline3.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      userProvider.user?.email ?? "Default",
                      style: context.body2.copyWith(fontSize: 12, color: AppColors.designBlack5),
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
                    onPressed: () async {
                      await userProvider.logOut();
                    },
                    color: AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Builder(builder: (context) {
                          if (userProvider.state == AppState.loading) {
                            return const Center(
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: AppColors.darkBlue1,
                                ),
                              ),
                            );
                          }

                          return Row(
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
                                style: context.body2.copyWith(
                                  fontSize: 16,
                                  color: AppColors.designRed,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
