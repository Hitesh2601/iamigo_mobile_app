import 'dart:async';
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

const Duration fakeAPIDuration = Duration(seconds: 1);
const Duration debounceDuration = Duration(milliseconds: 500);

class FPNFeedbackWidget extends StatefulWidget {
  final String fpnNumber;
  const FPNFeedbackWidget({super.key, required this.fpnNumber});

  // final StringCallback callback;

  @override
  State<FPNFeedbackWidget> createState() => _FPNFeedbackWidgetState();
}

class _FPNFeedbackWidgetState extends State<FPNFeedbackWidget> {
  TextEditingController recipientController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  // The query currently being searched for. If null, there is no pending
  // request.
  String? _currentQuery;
  String recipent = "";

  // The most recent options received from the API.
  late Iterable<String> _lastOptions = <String>[];

  late final _Debounceable<Iterable<String>?, String> _debouncedSearch;

  final formKey = GlobalKey<FormState>();
  void resetInputFields() {
    recipientController.clear();
    messageController.clear();
  }

  Future<Iterable<String>?> _search(String query) async {
    _currentQuery = query;
    if (_currentQuery!.length < 4) {
      return <String>[];
    }
    if (_currentQuery!.contains('-')) {
      recipent = _currentQuery!.split('-').first;
      return <String>[];
    }

    var requestEmployeeJson = <String, String>{
      'UserId': GlobalVariables.userName,
      'EmpCode': _currentQuery!
    };
    late final Iterable<String> options;
    try {
      options = await Provider.of<FPNFeedbackProvider>(context, listen: false)
          .getEmployeeListData(requestEmployeeJson);
    } catch (error) {
      if (error is _NetworkException) {
        return <String>[];
      }
      rethrow;
    }

    // If another search happened after this one, throw away these options.
    if (_currentQuery != query) {
      return null;
    }
    _currentQuery = null;

    return options;
  }

  @override
  void initState() {
    super.initState();
    _debouncedSearch = _debounce<Iterable<String>?, String>(_search);
  }

  @override
  void dispose() {
    recipientController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(Object context) {
    var requestFeedbackJson = <String, String>{
      'UserId': GlobalVariables.userName,
      'FpnNo': '',
      'ReceiverEmpCode': '',
      'FeedbackText': ''
    };
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
                    title: 'Feedback',
                    icon: "back",
                    iconColor: Colors.white,
                  ),
                  Form(
                      child: Padding(
                    padding: const EdgeInsets.all(FSizes.md),
                    child: Column(
                      children: [
                        Autocomplete<String>(
                          fieldViewBuilder: (BuildContext context,
                              TextEditingController controller,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted) {
                            return TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: const InputDecoration(
                                labelText: 'Recipient',
                                hintText: 'Enter recipient Employee Code',
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.grey), //<-- SEE HERE
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
                              onFieldSubmitted: (String value) {
                                onFieldSubmitted();
                              },
                            );
                          },
                          optionsBuilder:
                              (TextEditingValue textEditingValue) async {
                            recipientController.text = textEditingValue.text;
                            final Iterable<String>? options =
                                await _debouncedSearch(textEditingValue.text);
                            if (options == null) {
                              return _lastOptions;
                            }
                            _lastOptions = options;
                            return options;
                          },
                          onSelected: (String selection) {
                            recipientController.text = selection;
                            debugPrint('You just selected $selection');
                          },
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
                      requestFeedbackJson: requestFeedbackJson,
                      widget: widget,
                      recipientController: recipientController,
                      messageController: messageController),
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
      {super.key,
      required this.requestFeedbackJson,
      required this.widget,
      required this.recipientController,
      required this.messageController});

  final Map<String, String> requestFeedbackJson;
  final FPNFeedbackWidget widget;
  final TextEditingController recipientController;
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
                  'Confirm Feedback',
                  style: TextStyle(color: FColors.textWhite),
                ),
                onPressed: () async {
                  var recipent = recipientController.text;
                  if (HelperFunctions.isNullorEmpty(recipent)) {
                    await HelperFunctions.showAsyncAlert(
                        "Validation", "Recipient Employee Code is Empty");
                    recipientController.text = "";
                    return;
                  }

                  if (recipent.contains('-')) {
                    recipent = recipent.split('-').first;
                  }
                  var isValid = await context
                      .read<FPNFeedbackProvider>()
                      .validateEmployeeData(recipent);
                  if (!isValid) {
                    await HelperFunctions.showAsyncAlert(
                        "Validation", "Invalid Recipient Employee Code");
                    recipientController.text = "";
                    return;
                  }
                  if (HelperFunctions.isNullorEmpty(messageController.text)) {
                    HelperFunctions.showAlert(
                        "Warning", "Please enter Remarks");
                    return;
                  }

                  requestFeedbackJson['UserId'] =
                      GlobalVariables.userName.toUpperCase();
                  requestFeedbackJson['FpnNo'] = widget.fpnNumber;
                  requestFeedbackJson['ReceiverEmpCode'] = recipent;
                  requestFeedbackJson['FeedbackText'] = messageController.text;
                  context.loaderOverlay.show();
                  context
                      .read<FPNFeedbackProvider>()
                      .fpnFeedbackSendRequest(requestFeedbackJson)
                      .then((value) async {
                    context.loaderOverlay.hide();
                    if (value.returnStatus == 2) {
                      await HelperFunctions.showAsyncAlert("Success",
                          'Feedback for ${widget.fpnNumber} has been successfully submitted.');

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

typedef _Debounceable<S, T> = Future<S?> Function(T parameter);

/// Returns a new function that is a debounced version of the given function.
///
/// This means that the original function will be called only after no calls
/// have been made for the given Duration.
_Debounceable<S, T> _debounce<S, T>(_Debounceable<S?, T> function) {
  _DebounceTimer? debounceTimer;

  return (T parameter) async {
    if (debounceTimer != null && !debounceTimer!.isCompleted) {
      debounceTimer!.cancel();
    }
    debounceTimer = _DebounceTimer();
    try {
      await debounceTimer!.future;
    } catch (error) {
      if (error is _CancelException) {
        return null;
      }
      rethrow;
    }
    return function(parameter);
  };
}

// A wrapper around Timer used for debouncing.
class _DebounceTimer {
  _DebounceTimer() {
    _timer = Timer(debounceDuration, _onComplete);
  }

  late final Timer _timer;
  final Completer<void> _completer = Completer<void>();

  void _onComplete() {
    _completer.complete();
  }

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void cancel() {
    _timer.cancel();
    _completer.completeError(const _CancelException());
  }
}

// An exception indicating that the timer was canceled.
class _CancelException implements Exception {
  const _CancelException();
}

// An exception indicating that a network request has failed.
// ignore: unused_element
class _NetworkException implements Exception {
  const _NetworkException();
}
