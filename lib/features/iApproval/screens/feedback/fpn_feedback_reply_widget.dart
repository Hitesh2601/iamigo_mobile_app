import 'package:push_notification/common/widgets/background_screen.dart';
import 'package:push_notification/features/iApproval/providers/fpn_feedback_provider.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/widget/header_widget.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/sizes.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class FPNFeedbackReplyWidget extends StatefulWidget {
  final String fpnNumber;
  final String reciepient;
  final String reciepientName;
  const FPNFeedbackReplyWidget(
      {super.key,
      required this.fpnNumber,
      required this.reciepient,
      required this.reciepientName});

  // final StringCallback callback;

  @override
  State<FPNFeedbackReplyWidget> createState() =>
      _FFPNFeedbackReplyWidgetState();
}

class _FFPNFeedbackReplyWidgetState extends State<FPNFeedbackReplyWidget> {
  TextEditingController messageController = TextEditingController();
  TextEditingController reciepientController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  void resetInputFields() {
    messageController.clear();
    reciepientController.clear();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    reciepientController.dispose();
    super.dispose();
  }

  @override
  Widget build(Object context) {
    return Scaffold(
      backgroundColor: FColors.textWhite,
      body: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (_) {
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: FColors.textHeader,
              secondRingColor: FColors.textHeader,
              thirdRingColor: const Color(0xFFEA3799),
              size: 50,
            ),
          );
        },
        overlayColor: Colors.black.withOpacity(0.1),
        child: Stack(
          children: [
            BackgrounScreenWidget(
              height: 85,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              child: Column(
                children: [
                  const HeaderWidget(
                    title: 'Feedback Reply',
                    icon: "back",
                    iconColor: Colors.white,
                  ),
                  Form(
                      child: Padding(
                    padding: const EdgeInsets.all(FSizes.md),
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: widget.reciepientName,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Recipient',
                            fillColor: Colors.white,
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
                        ),
                        const SizedBox(
                          height: FSizes.spaceBtwInputfields,
                        ),
                        TextFormField(
                          controller: messageController,
                          keyboardType: TextInputType.multiline,
                          textAlign: TextAlign.start,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            labelText: 'Feedback Message',
                            hintText: 'Enter feedback message',
                            fillColor: Colors.white,
                            alignLabelWithHint: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
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
                                  BorderSide(width: 1, color: Colors.red),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Message is Empty";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  )),
                  FeedbackConfirmButton(
                      widget: widget, messageController: messageController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedbackConfirmButton extends StatelessWidget {
  const FeedbackConfirmButton(
      {super.key, required this.widget, required this.messageController});

  final FPNFeedbackReplyWidget widget;
  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                    padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    backgroundColor:
                        WidgetStateProperty.all<Color>(FColors.submitColor)),
                child: const Text(
                  'Confirm Reply',
                  style: TextStyle(color: FColors.textWhite),
                ),
                onPressed: () {
                  if (HelperFunctions.isNullorEmpty(messageController.text)) {
                    HelperFunctions.showAlert(
                        "Warning", "Please enter Remarks");
                    return;
                  }
                  var requestFeedbackJson = <String, String>{
                    'UserId': GlobalVariables.userName.toUpperCase(),
                    'FpnNo': widget.fpnNumber,
                    'ReceiverEmpCode': widget.reciepient,
                    'ReplyText': messageController.text
                  };
                  context.loaderOverlay.show();
                  context
                      .read<FPNFeedbackProvider>()
                      .fpnFeedbackReply(requestFeedbackJson)
                      .then((value) async {
                    context.loaderOverlay.hide();
                    if (value.returnStatus == 2) {
                      await HelperFunctions.showAsyncAlert("Success",
                          'Reply for ${widget.fpnNumber} has been successfully submitted.');
                      Get.back(result: "refresh");
                    } else if ((value.returnStatus == 1) ||
                        (value.returnStatus == 4)) {
                      HelperFunctions.showAlert(
                          "AMIGO", value.responseMessage!);
                    } else {
                      HelperFunctions.showAlert(
                          "Error", "Something went wrong");
                    }
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: SizedBox(
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                    padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    backgroundColor:
                        WidgetStateProperty.all<Color>(FColors.rejectColor)),
                child: const Text('Cancel',
                    style: TextStyle(color: FColors.textWhite)),
                onPressed: () => {Get.back(result: "refresh")},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
