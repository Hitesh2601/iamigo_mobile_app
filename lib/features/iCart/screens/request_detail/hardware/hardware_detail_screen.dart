import 'package:push_notification/common/widgets/background_screen.dart';
import 'package:push_notification/common/widgets/no_data_found_widget.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/widget/header_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/fpn_detail_menu_card_widget.dart';
import 'package:push_notification/features/iCart/models/icart_hardware_detail_response.dart';
import 'package:push_notification/features/iCart/providers/hardware_detail_provider.dart';
import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/approver_details.dart';
import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/approver_history_details.dart';
import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/checklist_validation_screen.dart';
import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/delivery_address_details.dart';
import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/employee_details.view.dart';
import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/existing_asset_view.dart';
import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/invoicing_payment_screen.dart';
import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/po_insurance_installation.dart';
import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/query_feedback_view.dart';
import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/request_details_view.dart';
import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/request_reason_view.dart';
import 'package:push_notification/features/iCart/screens/request_detail/hardware/screens/unit_details_view.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class HardwareDetailsScreen extends StatefulWidget {
  final String requestNumber;
  final String profile;
  final String requestType;
  final String newReplace;
  final bool isButtonVisible;
  final List<String>? filteredRequestNo;
  const HardwareDetailsScreen(
      {super.key,
      required this.requestNumber,
      required this.isButtonVisible,
      required this.filteredRequestNo,
      required this.requestType,
      required this.newReplace,
      required this.profile});

  @override
  State<HardwareDetailsScreen> createState() => _HardwareDetailsState();
}

class _HardwareDetailsState extends State<HardwareDetailsScreen> {
  TextEditingController txtRejectRemarkController = TextEditingController();

  TextEditingController txtApproveRemarkController = TextEditingController();

  Future<ICartHardwareDetailModel>? _myFuture;
  @override
  void initState() {
    super.initState();
    _myFuture = getRequestDetailsData();
  }

  Future<ICartHardwareDetailModel> getRequestDetailsData() async {
    var res = await Provider.of<HardwareDetailProvider>(context, listen: false)
        .getRequestDetailsData({
      "RegObj": {
        "UserId": GlobalVariables.userName,
        "RequestNo": widget.requestNumber,
        "RequestType": "Hardware",
        "Profile": widget.profile,
      }
    });
    return res;
  }

  @override
  void dispose() {
    txtRejectRemarkController.dispose();
    txtApproveRemarkController.dispose();
    super.dispose();
  }

  String _requestNumber = "";
  bool _isNumChanged = false;
  @override
  Widget build(BuildContext context) {
    if (!_isNumChanged) {
      _requestNumber = widget.requestNumber;
    }
    var requestJson = {
      "RegObj": {
        "UserId": GlobalVariables.userName,
        "RequestNo": widget.requestNumber,
        "RequestType": "Hardware",
        "Profile": widget.profile,
      }
    };
    bool isApproved = widget.requestType == "Approved";
    //final double bPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
        backgroundColor: FColors.light,
        body: Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: LoaderOverlay(
            useDefaultLoading: false,
            overlayColor: Colors.black.withOpacity(0.1),
            overlayWidgetBuilder: (_) {
              //ignored progress for the moment
              return Center(
                child: LoadingAnimationWidget.discreteCircle(
                  color: FColors.textHeader,
                  secondRingColor: FColors.textHeader,
                  thirdRingColor: const Color(0xFFEA3799),
                  size: 50,
                ),
              );
            },
            child: Stack(children: [
              BackgrounScreenWidget(
                height: 310,
              ),
              Column(
                children: [
                  Consumer<HardwareDetailProvider>(
                      builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: HeaderWidget(
                        title: value.selectedNumber,
                        icon: "back",
                        iconColor: Colors.white,
                      ),
                    );
                  }),
                  Expanded(
                      child: Column(
                    children: [
                      FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            context.loaderOverlay.show();
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            context.loaderOverlay.hide();
                            if (snapshot.hasError) {
                              return const NoDataFountWidget();
                            } else if (snapshot.hasData) {
                              var data =
                                  snapshot.data as ICartHardwareDetailModel;
                              if (data.returnStatus == 3) {
                                return const NoDataFountWidget();
                              } else if (data.returnStatus == 2) {
                                return Consumer<HardwareDetailProvider>(
                                  builder: (context, value, child) {
                                    return Column(
                                      children: [
                                        getHardwareMenus(context, isApproved),
                                        getSelectedScreen(
                                            context,
                                            value.detailResponse,
                                            value.selectedValue),
                                      ],
                                    );
                                  },
                                );
                              } else if ((data.returnStatus == 1) ||
                                  (data.returnStatus == 4)) {
                                HelperFunctions.showAlert(
                                    "AMIGO", data.responseMessage!);
                              } else {
                                HelperFunctions.showAlert(
                                    "Error", "Oops! Something went wrong");
                              }
                            }
                          }
                          return SizedBox();
                        },
                        future: _myFuture,
                      ),
                    ],
                  )),
                  Visibility(
                    visible: widget.isButtonVisible,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Card(
                        elevation: 0,
                        shadowColor: Colors.black,
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0)),
                        ),
                        margin: EdgeInsets.zero,
                        child: SizedBox(
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 0, 10),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          padding: const WidgetStatePropertyAll(
                                              EdgeInsets.zero),
                                          shape: WidgetStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  FColors.submitColor)),
                                      child: const Text(
                                        'Authorize',
                                        style:
                                            TextStyle(color: FColors.textWhite),
                                      ),
                                      onPressed: () => {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  iCartHWApproveAlert(
                                                      context,
                                                      txtApproveRemarkController,
                                                      context
                                                          .read<
                                                              HardwareDetailProvider>()
                                                          .additionaInfo),
                                            ).then((value) {
                                              if (value == 'Submit') {
                                                context.loaderOverlay.show();
                                                context
                                                    .read<
                                                        HardwareDetailProvider>()
                                                    .iCartApproveRequest({
                                                  "RegObj": {
                                                    "UserId": GlobalVariables
                                                        .userName,
                                                    "Profile": widget.profile,
                                                    "RequestType": "Hardware",
                                                    "Request": [
                                                      {
                                                        "RequestNo":
                                                            _requestNumber,
                                                        "Remark":
                                                            txtApproveRemarkController
                                                                .text
                                                                .toString(),
                                                        "ChangeApprover": false,
                                                        "NextApproverId": "",
                                                        "Reason": "",
                                                        "IsHardDiskFormatting":
                                                            ""
                                                      }
                                                    ]
                                                  }
                                                }).then((value) async {
                                                  context.loaderOverlay.hide();
                                                  if (value.returnStatus == 2) {
                                                    txtApproveRemarkController
                                                        .text = "";
                                                    await HelperFunctions
                                                        .showAsyncAlert(
                                                            "Success",
                                                            '$_requestNumber has been approved successfully.');
                                                    context.loaderOverlay
                                                        .show();
                                                    _requestNumber =
                                                        getNextRequest(
                                                            _requestNumber);
                                                    if (!HelperFunctions
                                                        .isNullorEmpty(
                                                            _requestNumber)) {
                                                      await Provider.of<
                                                                  HardwareDetailProvider>(
                                                              context,
                                                              listen: false)
                                                          .getRequestDetailsData({
                                                        "RegObj": {
                                                          "UserId":
                                                              GlobalVariables
                                                                  .userName,
                                                          "RequestNo":
                                                              _requestNumber,
                                                          "RequestType":
                                                              "Hardware",
                                                          "Profile":
                                                              widget.profile,
                                                        }
                                                      });
                                                      context.loaderOverlay
                                                          .hide();
                                                    } else {
                                                      Get.back(
                                                          result: "refresh");
                                                    }
                                                  } else if ((value
                                                              .returnStatus ==
                                                          1) ||
                                                      (value.returnStatus ==
                                                          4)) {
                                                    HelperFunctions.showAlert(
                                                        "AMIGO",
                                                        value.responseMessage!);
                                                  } else {
                                                    HelperFunctions.showAlert(
                                                        "Error",
                                                        "Oops! Something went wrong");
                                                  }
                                                });
                                              } else {}
                                            })
                                          }),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        padding: const WidgetStatePropertyAll(
                                            EdgeInsets.zero),
                                        shape: WidgetStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                FColors.rejectColor)),
                                    child: const Text(
                                      'Reject',
                                      style:
                                          TextStyle(color: FColors.textWhite),
                                    ),
                                    onPressed: () => {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            iCartHWRejectAlert(
                                                context,
                                                txtRejectRemarkController,
                                                context
                                                    .read<
                                                        HardwareDetailProvider>()
                                                    .additionaInfo),
                                      ).then((value) async {
                                        if (value == 'Submit') {
                                          context.loaderOverlay.show();
                                          context
                                              .read<HardwareDetailProvider>()
                                              .iCartRejectRequest({
                                            "RegObj": {
                                              "UserId":
                                                  GlobalVariables.userName,
                                              "Profile": widget.profile,
                                              "RequestType": "Hardware",
                                              "Request": [
                                                {
                                                  "RequestNo": _requestNumber,
                                                  "Remark":
                                                      txtRejectRemarkController
                                                          .text
                                                          .toString()
                                                }
                                              ]
                                            }
                                          }).then((value) async {
                                            context.loaderOverlay.hide();
                                            if (value.returnStatus == 2) {
                                              await HelperFunctions.showAsyncAlert(
                                                  "Success",
                                                  '$_requestNumber has been rejected successfully.');
                                              _requestNumber = getNextRequest(
                                                  _requestNumber);

                                              txtRejectRemarkController.text =
                                                  "";
                                              if (!HelperFunctions
                                                  .isNullorEmpty(
                                                      _requestNumber)) {
                                                context.loaderOverlay.show();
                                                await Provider.of<
                                                            HardwareDetailProvider>(
                                                        context,
                                                        listen: false)
                                                    .getRequestDetailsData({
                                                  "RegObj": {
                                                    "UserId": GlobalVariables
                                                        .userName,
                                                    "RequestNo": _requestNumber,
                                                    "RequestType": "Hardware",
                                                    "Profile": widget.profile,
                                                  }
                                                });
                                                context.loaderOverlay.hide();
                                              } else {
                                                Get.back(result: "refresh");
                                              }
                                            } else if ((value.returnStatus ==
                                                    1) ||
                                                (value.returnStatus == 4)) {
                                              HelperFunctions.showAlert("AMIGO",
                                                  value.responseMessage!);
                                            } else {
                                              HelperFunctions.showAlert("Error",
                                                  "Oops! Something went wrong");
                                            }
                                          });
                                        } else {}
                                      })
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ]),
          ),
        ));
  }

  String getNextRequest(String requestNo) {
    String requestNumber = "";

    int currentIndex = widget.filteredRequestNo!.indexOf(requestNo);
    widget.filteredRequestNo!.removeAt(currentIndex);

    if (widget.filteredRequestNo!.isNotEmpty) {
      if (currentIndex <
          HelperFunctions.getNumber(widget.filteredRequestNo?.length) - 1) {
        requestNumber = widget.filteredRequestNo![currentIndex];
      } else {
        currentIndex = 0;
        requestNumber = widget.filteredRequestNo![currentIndex];
      }
    } else {
      requestNumber = "";
    }

    return requestNumber;
  }

  Padding getHardwareMenus(BuildContext context, bool isApproved) {
    ScrollController scrollController = ScrollController();
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Card(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 215,
            child: Consumer<HardwareDetailProvider>(
              builder: (context, iCartProvider, _) =>
                  NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollController.offset >=
                          scrollController.position.maxScrollExtent &&
                      !scrollController.position.outOfRange) {
                    iCartProvider.setPositionEnd(true);
                  }
                  if (scrollController.offset <=
                          scrollController.position.minScrollExtent &&
                      !scrollController.position.outOfRange) {
                    iCartProvider.setPositionEnd(false);
                  }
                  return true;
                },
                child: GridView.builder(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    controller: scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: iCartProvider
                        .getMenuList(widget.requestType, widget.newReplace)
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return getBorderedLabelIconWidget(
                          index, iCartProvider, scrollController);
                    }),
              ),
            ),
          ),
        ));
  }

  InkWell getBorderedLabelIconWidget(int index, HardwareDetailProvider provider,
      ScrollController scrollController) {
    return InkWell(
      onTap: () {
        if (provider.hwMenuList[index].name == "More") {
          !provider.isPositionEnd
              ? scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn)
              : scrollController.animateTo(0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn);
        } else {
          provider.setSelectedValue(provider.hwMenuList[index].name);
        }
      },
      child: getBorderedLabelIcon(
          (provider.hwMenuList[index].name == "More")
              ? (provider.isPositionEnd)
                  ? FontAwesomeIcons.circleChevronUp
                  : FontAwesomeIcons.circleChevronDown
              : provider.hwMenuList[index].icon,
          (provider.hwMenuList[index].name == "More")
              ? ""
              : provider.hwMenuList[index].name,
          isSelected:
              provider.hwMenuList[index].name == provider.selectedValue),
    );
  }

  Padding getSelectedScreen(
      BuildContext context, ICartHardwareDetailModel data, String screenType) {
    SizedBox nullWidget = SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/dnf.jpg'),
          const SizedBox(
            height: 15,
          ),
          const Center(
            child: Text(
              'No Data Found',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
    SizedBox widget = nullWidget;
    if (data.requestDetails == null) {
      return Padding(
          padding: const EdgeInsets.only(top: 8.0), child: nullWidget);
    }
    switch (screenType) {
      case "Request Information":
        widget = data.requestDetails?.requestInfo != null
            ? SizedBox(
                child: Card(
                    child: RequestDetailsView(
                  requestInfo: data.requestDetails!.requestInfo!,
                )),
              )
            : nullWidget;
        break;
      case "Employee Information":
        widget = data.requestDetails?.employeeInformation != null
            ? SizedBox(
                child: Card(
                    child: EmployeeDetailsView(
                  employeeInformation:
                      data.requestDetails!.employeeInformation!,
                )),
              )
            : nullWidget;
        break;
      case "Unit Details":
        widget = data.requestDetails?.unitDetails != null
            ? SizedBox(
                child: Card(
                    child: UnitDetailsView(
                  unitDetails: data.requestDetails!.unitDetails!,
                )),
              )
            : nullWidget;
        break;
      case "Existing Asset Details":
        widget = data.requestDetails?.existingAssetDetails != null
            ? SizedBox(
                child: Card(
                    child: ExisitingAsseView(
                  existingAssetDetails:
                      data.requestDetails!.existingAssetDetails!,
                )),
              )
            : nullWidget;
        break;
      case "Checklist & Validation":
        widget = data.requestDetails?.checklistValidations != null
            ? SizedBox(
                child: Card(
                    child: ChecklistValidationScreen(
                  checklistValidations:
                      data.requestDetails!.checklistValidations!,
                )),
              )
            : nullWidget;
        break;
      case "Delivery Details":
        widget = data.requestDetails?.deliveryDetails != null
            ? SizedBox(
                child: Card(
                    child: DeliveryDetailsView(
                  deliveryDetails: data.requestDetails!.deliveryDetails!,
                )),
              )
            : nullWidget;
        break;
      case "PO, Insurance & Installation":
        widget = data.requestDetails?.poInsuranceInstallation != null
            ? SizedBox(
                child: Card(
                    child: POInsuranceInstallationView(
                  poInsuranceInstallation:
                      data.requestDetails!.poInsuranceInstallation!,
                )),
              )
            : nullWidget;
        break;
      case "Invoicing Payment & FAR":
        widget = data.requestDetails?.invoicingPaymentFar != null
            ? SizedBox(
                child: Card(
                    child: InvoicingPaymentScreen(
                  invoicingPaymentFar:
                      data.requestDetails!.invoicingPaymentFar!,
                )),
              )
            : nullWidget;
        break;
      case "Request Reason":
        widget = data.requestDetails?.requestReason != null
            ? SizedBox(
                child: Card(
                    child: RequestReasonView(
                  requestReason: data.requestDetails!.requestReason!,
                )),
              )
            : nullWidget;
        break;
      case "Approver Details":
        widget = data.requestDetails?.approverDetail != null
            ? SizedBox(
                child: Card(
                    child: ApproverDetailsView(
                  approverDetail: data.requestDetails!.approverDetail!,
                )),
              )
            : nullWidget;
        break;
      case "Approver History":
        widget = data.requestDetails?.approverHistory != null
            ? SizedBox(
                child: Card(
                    child: ApproverHistoryView(
                  approverHistory: data.requestDetails!.approverHistory!,
                )),
              )
            : nullWidget;
        break;
      case "Query Feedback":
        widget = data.requestDetails?.queryFeedback != null
            ? SizedBox(
                child: Card(
                    child: QueryFeedbackView(
                  queryFeedback: data.requestDetails!.queryFeedback!,
                )),
              )
            : nullWidget;
        break;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 395,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(screenType,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: FColors.textPrimary,
                        fontSize: 16)),
              ),
            ),
            widget
          ]),
        ),
      ),
    );
  }
}

Widget iCartHWApproveAlert(BuildContext context,
    TextEditingController txtApproveRemarkController, String? additionalInfo) {
  String value;
  bool isAdditionalInfo = false;
  if (!HelperFunctions.isNullorEmpty(additionalInfo)) {
    isAdditionalInfo = true;
  }

  return AlertDialog(
    icon: const Icon(
      FontAwesomeIcons.solidCircleCheck,
      color: FColors.approvedDark,
      size: 60,
    ),
    title: const Text(
      'Approve Remark',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    ),
    titlePadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
    contentPadding: const EdgeInsets.all(12),
    content: Container(
      height: isAdditionalInfo ? 220 : 120,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Visibility(
            visible: isAdditionalInfo,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ALERT: ',
                    style: TextStyle(
                        fontSize: 13,
                        color: FColors.accent,
                        fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: Text(
                      additionalInfo ?? "NA",
                      style:
                          const TextStyle(fontSize: 13, color: FColors.accent),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 90,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: const BorderRadius.all(Radius.circular(3))),
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: TextField(
                controller: txtApproveRemarkController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter approve remarks'),
              ),
            ),
          ),
        ],
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                padding: const EdgeInsets.only(left: 16),
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(FColors.submitColor)),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: FColors.textWhite),
                  ),
                  onPressed: () {
                    // if (HelperFunctions.isNullorEmpty(
                    //     txtApproveRemarkController.text)) {
                    //   HelperFunctions.showAlert(
                    //       "Warning", "Please enter Remarks");
                    //   return;
                    // } else if (txtApproveRemarkController.text.length > 500) {
                    //   HelperFunctions.showAlert("Warning",
                    //       "Max Limit for remark exceeded.Must not be greater than 500");
                    //   return;
                    // }
                    Navigator.pop(context, "Submit");
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Container(
                height: 40,
                padding: const EdgeInsets.only(left: 8, right: 16),
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(FColors.rejectColor)),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: FColors.textWhite),
                  ),
                  onPressed: () =>
                      {value = 'Cancel', Navigator.pop(context, value)},
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget iCartHWRejectAlert(BuildContext context,
    TextEditingController txtRejectRemarkController, String? additionalInfo) {
  String value;
  bool isAdditionalInfo = false;
  if (!HelperFunctions.isNullorEmpty(additionalInfo)) {
    isAdditionalInfo = true;
  }
  return AlertDialog(
    icon: const Icon(
      FontAwesomeIcons.solidCircleCheck,
      color: FColors.rejectedDark,
      size: 60,
    ),
    title: const Text(
      'Reject Remark',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    ),
    titlePadding: const EdgeInsets.all(0),
    contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
    buttonPadding: const EdgeInsets.all(0),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))),
    content: Container(
      height: isAdditionalInfo ? 240 : 120,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Visibility(
            visible: isAdditionalInfo,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ALERT: ',
                    style: TextStyle(
                        fontSize: 13,
                        color: FColors.accent,
                        fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: Text(
                      additionalInfo ?? "NA",
                      style:
                          const TextStyle(fontSize: 13, color: FColors.accent),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 90,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: const BorderRadius.all(Radius.circular(3))),
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: TextField(
                controller: txtRejectRemarkController,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Enter reject remarks'),
              ),
            ),
          ),
        ],
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                padding: const EdgeInsets.only(left: 16),
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(FColors.submitColor)),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: FColors.textWhite),
                  ),
                  onPressed: () {
                    if (HelperFunctions.isNullorEmpty(
                        txtRejectRemarkController.text)) {
                      HelperFunctions.showAlert(
                          "Warning", "Please enter Remarks");
                      return;
                    } else if (txtRejectRemarkController.text.length > 500) {
                      HelperFunctions.showAlert("Warning",
                          "Max Limit for remark exceeded.Must not be greater than 500");
                      return;
                    }
                    Navigator.pop(context, "Submit");
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Container(
                height: 40,
                padding: const EdgeInsets.only(left: 8, right: 16),
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
                  onPressed: () =>
                      {value = 'Cancel', Navigator.pop(context, value)},
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
