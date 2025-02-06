import 'package:push_notification/common/widgets/loader_screen.dart';
import 'package:push_notification/features/user/providers/home_provider.dart';
import 'package:push_notification/features/user/providers/login_provider.dart';
import 'package:push_notification/features/user/screens/home/home_screen.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/sizes.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 70, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/iamigo.png',
                  height: 100,
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
        const LoginForm(),
      ],
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscureText = true;
  final formKey = GlobalKey<FormState>();
  void resetInputFields() {
    userNameController.clear();
    passwordController.clear();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: -20,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(120),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[400]!,
                              blurRadius: 3.0,
                              blurStyle: BlurStyle.normal),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(FSizes.md),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400]!,
                    blurRadius: 3.0,
                    blurStyle: BlurStyle.normal),
              ],
            ),
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.all(FSizes.sm),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      color: FColors.textHeader,
                      fontSize: FSizes.fontSizeXL,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  'Please use your windows Login ID and Password to login system',
                  style: TextStyle(color: FColors.textPrimary, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(FSizes.md),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: userNameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.user),
                            labelText: 'AD Login ID',
                            contentPadding: EdgeInsets.all(5),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.grey), //<-- SEE HERE
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                          ),
                          validator: (value) {
                            if (HelperFunctions.isNullorEmpty(value)) {
                              return "Username is Empty";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: FSizes.spaceBtwInputfields,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: isObscureText,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Iconsax.password_check),
                            labelText: 'Password',
                            contentPadding: const EdgeInsets.all(5),
                            suffixIcon: InkWell(
                              onTap: () => setState(() {
                                isObscureText = !isObscureText;
                              }),
                              child: (isObscureText == true)
                                  ? const Icon(Iconsax.eye_slash)
                                  : const Icon(Iconsax.eye),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.red),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.red),
                            ),
                          ),
                          validator: (value) {
                            if (HelperFunctions.isNullorEmpty(value)) {
                              return "Password is Empty";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: FSizes.spaceBtwSections + 12,
                        ),
                      ],
                    ),
                  ))
            ]),
          ),
        ),
        Positioned(
          bottom: -20,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(120),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      color: Colors.white,
                      padding: EdgeInsets.zero,
                      iconSize: 65,
                      icon: const Icon(FontAwesomeIcons.circleArrowRight,
                          color: FColors.textHeader),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          // / To Show Loader dialog
                          // BuildContext dialogContext = context;
                          // showDialog(
                          //     context: context,
                          //     barrierDismissible: false,
                          //     builder: (BuildContext context) {
                          //       dialogContext = context;
                          //       return loaderScreen(context,
                          //           "authenticating user. please wait...");
                          //     });

                          var iMEICODE =
                              await HelperFunctions.getUniqueIdentifier();
                          var uName =
                              userNameController.text.replaceAll(' ', '');
                          var pwd = passwordController.text.replaceAll(' ', '');
                          var loginJson = <String, String>{
                            "EmpActiveDirectoryId": uName,
                            "IMEICode": iMEICODE,
                            "Password": pwd,
                            "IsOwner": "NA"
                          };
                          GlobalVariables.userName = uName;
                          GlobalVariables.password = pwd;
                          GlobalVariables.iMEICODE = iMEICODE;
                          try {
                            context.loaderOverlay.show();
                            await Provider.of<LoginProvider>(context,
                                    listen: false)
                                .adidLogin(loginJson)
                                .then((value) {
                              resetInputFields();

                              /// To Check Resposne Status

                              context.loaderOverlay.hide();
                              if (value.returnStatus == 2) {
                                if (value.isImeiExists == 0) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        PopupDeviceOwnerAlert(context),
                                  ).then((value) {
                                    if (value == 'Yes') {
                                    } else {}
                                    Get.offAll(
                                        ChangeNotifierProvider<HomeProvider>(
                                      create: (_) => HomeProvider(),
                                      child: const HomeScreen(),
                                    ));
                                  });
                                } else {
                                  Get.offAll(
                                      ChangeNotifierProvider<HomeProvider>(
                                    create: (_) => HomeProvider(),
                                    child: const HomeScreen(),
                                  ));
                                }
                              } else {
                                HelperFunctions.showAlert(
                                    "Error ", value.responseMessage!);
                              }
                            });
                          } catch (e) {
                            //HelperFunctions.showAlert("Error", e.toString());
                          } finally {
                            if (context.loaderOverlay.visible) {
                              context.loaderOverlay.hide();
                            }
                            // Navigator.of(dialogContext, rootNavigator: true)
                            //     .pop(false);
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: FSizes.spaceBtwSections,
        )
      ],
    );
  }
}

// ignore: non_constant_identifier_names
Widget PopupDeviceOwnerAlert(BuildContext context) {
  String value;
  return AlertDialog(
    title: const Text(
      'Login',
      style: TextStyle(fontSize: 16),
    ),
    content: const SizedBox(
      height: 30,
      child: Text('Are you the owner of the Device'),
    ),
    actions: [
      SizedBox(
        height: 40,
        child: TextButton(
          child: const Text('No'),
          onPressed: () => {value = 'No', Navigator.pop(context, value)},
        ),
      ),
      SizedBox(
        height: 40,
        child: TextButton(
          child: const Text('Yes'),
          onPressed: () => {value = 'Yes', Navigator.pop(context, value)},
        ),
      ),
    ],
  );
}
