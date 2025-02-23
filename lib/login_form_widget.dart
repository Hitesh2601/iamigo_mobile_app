import 'package:amigo_mobile_app/common/widgets/loader_screen.dart';
import 'package:amigo_mobile_app/features/iApproval/screens/request_detail/fpn_details_screen.dart';
import 'package:amigo_mobile_app/features/iCart/screens/request_detail/hardware/hardware_detail_screen.dart';
import 'package:amigo_mobile_app/features/iCart/screens/request_detail/software/software_detail_screen.dart';
import 'package:amigo_mobile_app/features/iSAC/screens/request_list_details/isac_request_list_details.dart';
import 'package:amigo_mobile_app/features/user/providers/login_provider.dart';
import 'package:amigo_mobile_app/features/user/screens/home/home_screen.dart';
import 'package:amigo_mobile_app/utility/constants/colors.dart';
import 'package:amigo_mobile_app/utility/constants/global_variables.dart';
import 'package:amigo_mobile_app/utility/constants/sizes.dart';
import 'package:amigo_mobile_app/utility/helpers/helper_functions.dart';
import 'package:amigo_mobile_app/utility/push-notification-api/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
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
                Image.asset('assets/images/login.png'),
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
                            if (value!.isEmpty) {
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
                            if (value!.isEmpty) {
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
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          /// To Show Loader dialog
                          BuildContext dialogContext = context;
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                dialogContext = context;
                                return loaderScreen(context,
                                    "authenticating user. please wait...");
                              });

                          var loginJson = <String, String>{
                            "EmpActiveDirectoryId": userNameController.text,
                            "IMEICode": "a72a7f4c-26d6-43bb-8830-75fb56a6a458",
                            "Password": passwordController.text,
                            "IsOwner": "NA"
                          };
                          GlobalVariables.userName = userNameController.text;
                          GlobalVariables.password = passwordController.text;
                          try {
                            Provider.of<LoginProvider>(context, listen: false)
                                .adidLogin(loginJson)
                                .then((value) {
                              resetInputFields();

                              /// To Check Resposne Status

                              if (value.returnStatus == 2) {
                                var route = MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                );
                                HelperFunctions.showAlert(
                                    "lauchViaNotification",
                                    GlobalVariables.redirectURL);
                                if (!HelperFunctions.isNullorEmpty(
                                    GlobalVariables.redirectURL)) {
                                  final splitted =
                                      GlobalVariables.redirectURL.split('/');
                                  HelperFunctions.showAlert(
                                      "Module", splitted[0]);
                                  if (splitted[0] == "FPN") {
                                    // iSACURl: FPN/pending/fpnNumber
                                    route = MaterialPageRoute(
                                        builder: (context) => FpnDetailsScreen(
                                              fpnNumber: splitted[1],
                                              isButtonVisible: true,
                                              callback: (val) => (() => val),
                                            ));
                                  } else if (splitted[0] == "iSAC") {
                                    // iSACURl: iSAC/pending/encRequestID/encFormID/ticketNumber
                                    route = MaterialPageRoute(
                                        builder: (context) => ISACDetailsScreen(
                                              encrequestID: splitted[1],
                                              isButtonVisible: true,
                                              formID: splitted[2],
                                              ticketnumber: splitted[3],
                                            ));
                                  } else if (splitted[0] == "iCART") {
                                    // iCART: iCART/pending/software/profile/requestNo
                                    if (splitted[1] == "software") {
                                      route = MaterialPageRoute(
                                          builder: (context) =>
                                              SoftwareDetailsScreen(
                                                requestNumber: splitted[3],
                                                profile: splitted[2],
                                                isButtonVisible: true,
                                              ));
                                    }
                                    if (splitted[1] == "hardware") {
                                      route = MaterialPageRoute(
                                          builder: (context) =>
                                              HardwareDetailsScreen(
                                                requestNumber: splitted[3],
                                                profile: splitted[2],
                                                isButtonVisible: true,
                                              ));
                                    }
                                  } else {
                                    route = MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    );
                                  }
                                }

                                NotificationServices notificationServices =
                                    NotificationServices();
                                notificationServices.isRefreshToken();
                                notificationServices
                                    .getDeviceToken()
                                    .then((value) {
                                  HelperFunctions.showCopyAlert("Token", value);
                                  print(value);
                                });
                                // notificationServices.sendFCMMessage();
                                if (value.isImeiExists == 0) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        PopupDeviceOwnerAlert(context),
                                  ).then((value) {
                                    if (value == 'Yes') {
                                    } else {}
                                    HelperFunctions.showAlert(
                                        "lauchViaNotification",
                                        GlobalVariables.redirectURL);
                                    Navigator.pushAndRemoveUntil(
                                        context, route, (route) => false);
                                  });
                                } else {
                                  HelperFunctions.showAlert(
                                      "lauchViaNotification",
                                      GlobalVariables.redirectURL);
                                  Navigator.pushAndRemoveUntil(
                                      context, route, (route) => false);
                                }
                              } else {
                                HelperFunctions.showAlert(
                                    "Error", value.responseMessage!);
                              }
                            });
                          } catch (e) {
                            print(e);
                          } finally {
                            Navigator.of(dialogContext, rootNavigator: true)
                                .pop(false);
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
