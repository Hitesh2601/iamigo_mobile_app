import 'package:push_notification/common/widgets/background_screen.dart';
import 'package:push_notification/common/widgets/no_data_found_widget.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/widget/header_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/fpn_detail_menu_card_widget.dart';
import 'package:push_notification/features/iCart/models/icart_software_detail_response.dart';
import 'package:push_notification/features/iCart/providers/software_detail_provider.dart';
import 'package:push_notification/features/iCart/screens/request_detail/software/screens/approval_period.dart';
import 'package:push_notification/features/iCart/screens/request_detail/software/screens/approver_details.dart';
import 'package:push_notification/features/iCart/screens/request_detail/software/screens/approver_history_details.dart';
import 'package:push_notification/features/iCart/screens/request_detail/software/screens/asset_details.dart';
import 'package:push_notification/features/iCart/screens/request_detail/software/screens/employee_details.view.dart';
import 'package:push_notification/features/iCart/screens/request_detail/software/screens/extension_details.dart';
import 'package:push_notification/features/iCart/screens/request_detail/software/screens/query_feedback_view.dart';
import 'package:push_notification/features/iCart/screens/request_detail/software/screens/request_details_view.dart';
import 'package:push_notification/features/iCart/screens/request_detail/software/screens/request_info_screen.dart';
import 'package:push_notification/features/iCart/screens/request_detail/software/screens/temporary_license.dart';
import 'package:push_notification/features/iCart/screens/request_detail/software/screens/unit_details_view.dart';
import 'package:push_notification/features/iCart/screens/request_list/software/software_request_item.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class SoftwareDetailsScreen extends StatefulWidget {
  final String requestNumber;
  final String profile;
  final bool isButtonVisible;
  final List<String>? filteredRequestNo;
  const SoftwareDetailsScreen(
      {super.key,
      required this.requestNumber,
      required this.isButtonVisible,
      required this.filteredRequestNo,
      required this.profile});

  @override
  State<SoftwareDetailsScreen> createState() => _SoftwareDetailsScreenState();
}

class _SoftwareDetailsScreenState extends State<SoftwareDetailsScreen> {
  TextEditingController txtRejectRemarkController = TextEditingController();

  TextEditingController txtApproveRemarkController = TextEditingController();

  Future<ICartSoftwareRequestDetail>? _myFuture;
  @override
  void initState() {
    super.initState();
    _myFuture = getSoftwareDetailsData();
  }

  Future<ICartSoftwareRequestDetail> getSoftwareDetailsData() async {
    var res = await Provider.of<SoftwareDetailProvider>(context, listen: false)
        .getSoftwareDetailsData({
      "RegObj": {
        "UserId": GlobalVariables.userName,
        "RequestNo": widget.requestNumber,
        "RequestType": "Software",
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
        "RequestNo": _requestNumber,
        "RequestType": "Software",
        "Profile": widget.profile,
      }
    };
    //final double bPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
        backgroundColor: FColors.light,
        body: LoaderOverlay(
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
                Consumer<SoftwareDetailProvider>(
                    builder: (context, provider, child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: HeaderWidget(
                      title: provider.selectedNumber,
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
                                  snapshot.data as ICartSoftwareRequestDetail;
                              if (data.returnStatus == 3) {
                                return const NoDataFountWidget();
                              } else if (data.returnStatus == 2) {
                                return Consumer<SoftwareDetailProvider>(
                                  builder: (context, value, child) {
                                    return Column(
                                      children: [
                                        getSoftwareMenus(context),
                                        getSelectedScreen(
                                            context,
                                            value.softwareDetailResponse,
                                            value.selectedValue,
                                            value.isServerDataVisible),
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
                          return const SizedBox();
                        },
                        future: _myFuture),
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
                                                    BorderRadius.circular(8))),
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                FColors.submitColor)),
                                    child: const Text(
                                      'Authorize',
                                      style:
                                          TextStyle(color: FColors.textWhite),
                                    ),
                                    onPressed: () => {
                                          ///Json Create here
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                iCartSWApproveAlert(context,
                                                    txtApproveRemarkController),
                                          ).then((value) {
                                            if (value == 'Submit') {
                                              context.loaderOverlay.show();
                                              context
                                                  .read<
                                                      SoftwareDetailProvider>()
                                                  .iCartApproveRequest({
                                                "RegObj": {
                                                  "UserId":
                                                      GlobalVariables.userName,
                                                  "Profile": widget.profile,
                                                  "RequestType": "Software",
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
                                                      "IsHardDiskFormatting": ""
                                                    }
                                                  ]
                                                }
                                              }).then((value) async {
                                                context.loaderOverlay.hide();
                                                if (value.returnStatus == 2) {
                                                  txtApproveRemarkController
                                                      .text = "";
                                                  await HelperFunctions
                                                      .showAsyncAlert("Success",
                                                          '$_requestNumber has been approved successfully.');
                                                  context.loaderOverlay.show();
                                                  _requestNumber =
                                                      getNextRequest(
                                                          _requestNumber);
                                                  if (!HelperFunctions
                                                      .isNullorEmpty(
                                                          _requestNumber)) {
                                                    await Provider.of<
                                                                SoftwareDetailProvider>(
                                                            context,
                                                            listen: false)
                                                        .getSoftwareDetailsData({
                                                      "RegObj": {
                                                        "UserId":
                                                            GlobalVariables
                                                                .userName,
                                                        "RequestNo":
                                                            _requestNumber,
                                                        "RequestType":
                                                            "Software",
                                                        "Profile":
                                                            widget.profile,
                                                      }
                                                    });
                                                    context.loaderOverlay
                                                        .hide();
                                                  } else {
                                                    Get.back(result: "refresh");
                                                  }
                                                } else if ((value
                                                            .returnStatus ==
                                                        1) ||
                                                    (value.returnStatus == 4)) {
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
                                    style: TextStyle(color: FColors.textWhite),
                                  ),
                                  onPressed: () => {
                                    ///Json Create here
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          iCartSWRejectAlert(context,
                                              txtRejectRemarkController),
                                    ).then((value) async {
                                      if (value == 'Submit') {
                                        context.loaderOverlay.show();

                                        context
                                            .read<SoftwareDetailProvider>()
                                            .iCartRejectRequest({
                                          "RegObj": {
                                            "UserId": GlobalVariables.userName,
                                            "Profile": widget.profile,
                                            "RequestType": "Software",
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
                                            txtRejectRemarkController.text = "";
                                            await HelperFunctions.showAsyncAlert(
                                                "Success",
                                                '$_requestNumber has been rejected successfully.');
                                            _requestNumber =
                                                getNextRequest(_requestNumber);

                                            if (!HelperFunctions.isNullorEmpty(
                                                _requestNumber)) {
                                              context.loaderOverlay.show();
                                              context
                                                  .read<
                                                      SoftwareDetailProvider>()
                                                  .getSoftwareDetailsData({
                                                "RegObj": {
                                                  "UserId":
                                                      GlobalVariables.userName,
                                                  "RequestNo": _requestNumber,
                                                  "RequestType": "Software",
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
                                      }
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

  Padding getSoftwareMenus(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Card(
            child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 215,
          child: Consumer<SoftwareDetailProvider>(
            builder: (context, detailProvider, _) =>
                NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollController.offset >=
                        scrollController.position.maxScrollExtent &&
                    !scrollController.position.outOfRange) {
                  detailProvider.setPositionEnd(true);
                }
                if (scrollController.offset <=
                        scrollController.position.minScrollExtent &&
                    !scrollController.position.outOfRange) {
                  detailProvider.setPositionEnd(false);
                }

                return true;
              },
              child: GridView.builder(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  controller: scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: detailProvider.getMenuList().length,
                  itemBuilder: (BuildContext context, int index) {
                    return getBorderedLabelIconWidget(
                        index, detailProvider, scrollController);
                  }),
            ),
          ),
        )));
  }
}

InkWell getBorderedLabelIconWidget(int index, SoftwareDetailProvider provider,
    ScrollController scrollController) {
  return InkWell(
    onTap: () {
      if (provider.swMenuList[index].name == "More") {
        !provider.isPositionEnd
            ? scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn)
            : scrollController.animateTo(0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn);
      } else {
        provider.setSelectedValue(provider.swMenuList[index].name);
      }
    },
    child: getBorderedLabelIcon(
        (provider.swMenuList[index].name == "More")
            ? (provider.isPositionEnd)
                ? FontAwesomeIcons.circleChevronUp
                : FontAwesomeIcons.circleChevronDown
            : provider.swMenuList[index].icon,
        (provider.swMenuList[index].name == "More")
            ? ""
            : provider.swMenuList[index].name,
        isSelected: provider.swMenuList[index].name == provider.selectedValue),
  );
}

Padding getSelectedScreen(BuildContext context, ICartSoftwareRequestDetail data,
    String screenType, bool isServerDataVisible) {
  SizedBox nullWidget = const SizedBox(child: NoDataFountWidget());
  SizedBox widget = nullWidget;
  if (data.softwareRequestDetails == null) {
    return Padding(padding: const EdgeInsets.only(top: 8.0), child: nullWidget);
  }
  switch (screenType) {
    case "Request Information":
      widget = data.softwareRequestDetails?.softwareRequestInformation != null
          ? SizedBox(
              child: Card(
                  child: RequestInfoScreen(
                requestInfo:
                    data.softwareRequestDetails!.softwareRequestInformation!,
              )),
            )
          : nullWidget;
      break;
    case "Employee Information":
      widget = data.softwareRequestDetails?.softwareEmployeeInformation != null
          ? SizedBox(
              child: Card(
                  child: EmployeeDetailsView(
                employeeInformation:
                    data.softwareRequestDetails!.softwareEmployeeInformation!,
              )),
            )
          : nullWidget;
      break;
    case "Software Details":
      widget = data.softwareRequestDetails?.softwareUnitDetails != null
          ? SizedBox(
              child: Card(
                  child: UnitDetailsView(
                      unitDetails:
                          data.softwareRequestDetails!.softwareUnitDetails!,
                      isServerDataVisible: isServerDataVisible)),
            )
          : nullWidget;
      break;
    case "Asset Details":
      widget = data.softwareRequestDetails?.softwareExistingAssetDetails != null
          ? SizedBox(
              child: Card(
                  child: AssetDetailsView(
                softwareExistingAssetDetails:
                    data.softwareRequestDetails!.softwareExistingAssetDetails!,
              )),
            )
          : nullWidget;
      break;
    case "Request Details":
      widget = data.softwareRequestDetails?.softRequestDetails != null
          ? SizedBox(
              child: Card(
                  child: SoftwareRequestDetailsView(
                requestInfo: data.softwareRequestDetails!.softRequestDetails!,
              )),
            )
          : nullWidget;
      break;
    case "Extension Request":
      widget = data.softwareRequestDetails?.extensionRequest != null
          ? SizedBox(
              child: Card(
                  child: ExtensionDetailScreen(
                extensionRequest:
                    data.softwareRequestDetails!.extensionRequest!,
              )),
            )
          : nullWidget;
      break;
    case "Approval Period":
      widget = data.softwareRequestDetails?.softwareApproverPeriod != null
          ? SizedBox(
              child: Card(
                  child: ApprovalPeriodScreen(
                softwareApproverPeriod:
                    data.softwareRequestDetails!.softwareApproverPeriod!,
              )),
            )
          : nullWidget;
      break;

    case "Temporary License":
      widget = data.softwareRequestDetails?.temporaryLicense != null
          ? SizedBox(
              child: Card(
                  child: TemporaryLicenseScreen(
                temporaryLicense:
                    data.softwareRequestDetails!.temporaryLicense!,
              )),
            )
          : nullWidget;
      break;
    case "Approver Details":
      widget = data.softwareRequestDetails?.softwareApproverDetail != null
          ? SizedBox(
              child: Card(
                  child: ApproverDetailsView(
                approverDetail:
                    data.softwareRequestDetails!.softwareApproverDetail!,
              )),
            )
          : nullWidget;
      break;
    case "Approver History":
      widget = data.softwareRequestDetails?.approverHistory != null
          ? SizedBox(
              child: Card(
                  child: ApproverHistoryView(
                approverHistory: data.softwareRequestDetails!.approverHistory!,
              )),
            )
          : nullWidget;
      break;
    case "Query Feedback":
      widget = data.softwareRequestDetails?.softwareQueryFeedback != null
          ? SizedBox(
              child: Card(
                  child: QueryFeedbackView(
                queryFeedback:
                    data.softwareRequestDetails!.softwareQueryFeedback!,
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
              child: Text('$screenType',
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
