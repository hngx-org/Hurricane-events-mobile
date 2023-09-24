import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hurricane_events/app/presentation/add_group/providers/add_group_provider.dart';
import 'package:hurricane_events/app/presentation/add_group/widgets/add_people_button.dart';
import 'package:hurricane_events/app/presentation/add_group/widgets/add_people_chip.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/constants/images.dart';
import 'package:hurricane_events/component/enums/enums.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/component/widgets/click_button.dart';
import 'package:hurricane_events/component/widgets/custom_button.dart';
import 'package:hurricane_events/component/widgets/custom_textfield.dart';
import 'package:hurricane_events/component/widgets/svg_picture.dart';
import 'package:hurricane_events/domain/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddGroupScreen extends StatefulWidget {
  static const routeName = "add_group";
  const AddGroupScreen({super.key});

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  final TextEditingController _nameOfGroupController = TextEditingController();
  ValueNotifier addPeoplePressed = ValueNotifier(false);

  XFile? image;
  late ImagePicker _picker;

  bool isUploading = false;

  String? nameError;
  String? emailError;

  final nameFocus = FocusNode();
  final emailFocus = FocusNode();

  List<String> friendsEmailAddress = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();

    nameFocus.addListener(() {
      setState(() {});
    });
    emailFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    nameFocus.dispose();
    _email.dispose();
    emailFocus.dispose();
    _nameOfGroupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.backgroundColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: ClickWidget(
          onTap: () {
            BaseNavigator.pop();
          },
          child: const SizedBox(
            height: 30,
            width: 30,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
            ),
          ),
        ),
      ),
      title: Text(
        "Add Group",
        style: context.headline3.copyWith(
          fontSize: 16,
        ),
      ),
    );
    return Consumer<AddGroupProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: appBar,
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  32.height,
                  Text(
                    'Name of Group',
                    style: context.body2.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  8.height,
                  CustomTextField(
                    focus: nameFocus,
                    filled: true,
                    controller: _nameOfGroupController,
                    errorText: nameError,
                    hintText: "Enter name of group",
                    validator: (p0) {
                      if (p0 == null || p0.trim().isEmpty) {
                        nameError = "Please enter your event name";
                        setState(() {});
                        return nameError;
                      }

                      nameError = null;
                      setState(() {});
                      return nameError;
                    },
                  ),
                  const Gap(24),

                  //Choose an icon
                  Text(
                    'Choose an icon',
                    style: context.body2.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  8.height,

                  Row(children: [
                    Builder(builder: (context) {
                      if (image != null) {
                        return Container(
                          height: 76.0,
                          width: 76.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: AppColors.darkGrey2,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24.0),
                            child: Image.file(
                              File(image?.path ?? ""),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                      return Container(
                        height: 76.0,
                        width: 76.0,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: AppColors.darkGrey2,
                        ),
                        child: const Svg(
                          image: AppImages.techiesIcon,
                        ),
                      );
                    }),
                    12.width,
                    ClickWidget(
                      onTap: () async {
                        await _picker.pickImage(source: ImageSource.gallery).then(
                          (value) async {
                            if (value != null) {
                              image = value;
                              setState(() {});
                            }
                          },
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add,
                            color: AppColors.designOrange,
                          ),
                          7.width,
                          Text(
                            "Add from\nGallery",
                            style: context.body1.copyWith(
                              fontSize: 12,
                              color: AppColors.designOrange,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                  const Gap(24),
                  Text(
                    'Add people',
                    style: context.body2.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  8.height,
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF2F2F2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ...friendsEmailAddress
                            .map(
                              (e) => AddPeopleChip(
                                onTap: () {
                                  friendsEmailAddress.remove(e);
                                  setState(() {});
                                },
                                text: e,
                              ),
                            )
                            .toList(),
                        AddPeopleButton(
                          function: () async {
                            addPeoplePressed.value = !addPeoplePressed.value;
                          },
                        ),
                      ],
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: addPeoplePressed,
                    builder: (context, value, child) {
                      if (value) {
                        return FadeInDown(
                          duration: const Duration(milliseconds: 100),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.height,
                              CustomTextField(
                                focus: emailFocus,
                                filled: true,
                                controller: _email,
                                errorText: emailError,
                                hintText: "Enter email of user",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if (_email.text.trim().isEmpty) {
                                      return;
                                    }

                                    if (_formKey.currentState!.validate()) {
                                      friendsEmailAddress.add(_email.text);
                                      setState(() {});
                                      _email.clear();
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: AppColors.darkBlue1,
                                  ),
                                ),
                                validator: (p0) {
                                  if (p0 == null || p0.trim().isEmpty) {
                                    emailError = "Please enter a valid email";
                                    setState(() {});
                                    return emailError;
                                  }

                                  if (!EmailValidator.validate(p0)) {
                                    emailError = "This email is not valid";
                                    setState(() {});
                                    return emailError;
                                  }

                                  emailError = null;
                                  setState(() {});
                                  return emailError;
                                },
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const Spacer(),
                  Builder(builder: (context) {
                    if (provider.state == AppState.loading) {
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
                    return CustomButton(
                      radius: 32,
                      backgroundColor: AppColors.darkBlue1,
                      onPressed: () async {
                        if (isUploading) {
                          return;
                        }
                        if (_formKey.currentState!.validate()) {
                          if (image != null) {
                            isUploading = true;
                            setState(() {});

                            TaskSnapshot taskSnapshot = await FirebaseStorage.instance
                                .ref()
                                .child('thumbnails')
                                .child("hng/${image?.name}/${DateTime.now().toIso8601String()}")
                                .child(context.read<UserProvider>().user?.id ?? "")
                                .putFile(File(image?.path ?? ""));
                            String url = await taskSnapshot.ref.getDownloadURL();
                            isUploading = false;
                            setState(() {});

                            if (url.isNotEmpty) {
                              await provider.createGroup(
                                groupTitle: _nameOfGroupController.text,
                                listOfFriends: friendsEmailAddress,
                                avatar: url,
                              );
                            } else {
                              await provider.createGroup(
                                groupTitle: _nameOfGroupController.text,
                                listOfFriends: friendsEmailAddress,
                                avatar: "",
                              );
                            }
                          } else {
                            await provider.createGroup(
                              groupTitle: _nameOfGroupController.text,
                              listOfFriends: friendsEmailAddress,
                              avatar: "",
                            );
                          }
                        }
                      },
                      buttonWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          7.width,
                          Text(
                            "Add Group",
                            style: context.button2.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  48.height,
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
