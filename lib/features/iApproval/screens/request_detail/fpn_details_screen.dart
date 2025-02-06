import 'package:push_notification/common/widgets/background_screen.dart';
import 'package:push_notification/common/widgets/no_data_found_widget.dart';
import 'package:push_notification/common/widgets/somthing_went_wrong.dart';
import 'package:push_notification/features/iApproval/models/fpn_request_details_response.dart';
import 'package:push_notification/features/iApproval/providers/fpn_feedback_provider.dart';
import 'package:push_notification/features/iApproval/providers/fpn_request_detail_provider.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/widget/header_widget.dart';
import 'package:push_notification/features/iApproval/screens/feedback/fpn_feedback_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/application_list_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/audit_trails_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/benefit_details_new_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/benefit_details_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/budget_details_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/case_approval_matrix_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/case_details_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/cost_center_list_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/feedbacks_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/fincon_sentback_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/fpn_detail_menu_card_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/fpn_intimation_view.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/process_attachment_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/project_details_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/tco_detail_screen.dart';
import 'package:push_notification/features/iApproval/screens/request_list/widget/fpn_request_item_widget.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/fpn_menu_list.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class FpnDetailsScreen extends StatefulWidget {
  final String fpnNumber;
  final bool isButtonVisible;

  final List<String>? filteredRequestNo;
  const FpnDetailsScreen({
    super.key,
    required this.fpnNumber,
    required this.isButtonVisible,
    required this.filteredRequestNo,
  });

  @override
  State<FpnDetailsScreen> createState() => _FpnDetailsScreenState();
}

class _FpnDetailsScreenState extends State<FpnDetailsScreen> {
  TextEditingController txtRejectRemarkController = TextEditingController();

  TextEditingController txtApproveRemarkController = TextEditingController();

  Future<FPNDetailResponse>? _myFuture;
  @override
  void initState() {
    super.initState();
    _myFuture = getRequestDetailsData();
  }

  Future<FPNDetailResponse> getRequestDetailsData() async {
    var res = await Provider.of<FPNDetailProvider>(context, listen: false)
        .getRequestDetailsData(
            {'UserId': GlobalVariables.userName, 'FpnNo': widget.fpnNumber});
    return res;
  }

  @override
  void dispose() {
    txtRejectRemarkController.dispose();
    txtApproveRemarkController.dispose();
    super.dispose();
  }

  String _fpnNumber = "";
  final bool _isNumChanged = false;
  @override
  Widget build(BuildContext context) {
    if (!_isNumChanged) {
      _fpnNumber = widget.fpnNumber;
    }
    var requestJson = <String, String>{
      'UserId': GlobalVariables.userName,
      'FpnNo': _fpnNumber
    };
    var requestApproveJson = <String, String>{
      'UserId': GlobalVariables.userName,
      'FpnNo': _fpnNumber,
      'Remark': '',
      'FinConAnalystRemark': ''
    };
    var requestRejectJson = <String, String>{
      'UserId': GlobalVariables.userName,
      'FpnNo': _fpnNumber,
      'Remark': '',
      'FinConAnalystRemark': ''
    };

    //final double bPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: FColors.light,
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
          overlayColor: Colors.black.withOpacity(0.2),
          child: Stack(children: [
            BackgrounScreenWidget(
              height: 310,
            ),
            Column(
              children: [
                Consumer<FPNDetailProvider>(builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: HeaderWidget(
                      title: value.selectedNumber,
                      icon: "back",
                      iconColor: Colors.white,
                    ),
                  );
                }),
                Column(
                  children: [
                    FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          context.loaderOverlay.show();
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          context.loaderOverlay.hide();
                          if (snapshot.hasError) {
                            return const NoDataFountWidget();
                          } else if (snapshot.hasData) {
                            var data = snapshot.data as FPNDetailResponse;
                            if (data.returnStatus == 3) {
                              return const NoDataFountWidget();
                            } else if (data.returnStatus == 2) {
                              return OrientationBuilder(
                                builder: (context, orientation) {
                                  return (orientation == Orientation.portrait)
                                      ? Consumer<FPNDetailProvider>(
                                          builder: (context, value, child) {
                                            return Column(
                                              children: [
                                                getFPNMenus(context),
                                                getSelectedScreen(
                                                    context,
                                                    value.fpnDetailResponse,
                                                    value.selectedValue,
                                                    widget.isButtonVisible),
                                              ],
                                            );
                                          },
                                        )
                                      : const SizedBox();
                                },
                              );
                            } else if (data.returnStatus == 1) {
                              return const SomthingWentWrongWidget();
                            }
                          }
                        }
                        return const SizedBox();
                      },
                      future: _myFuture,
                    ),
                  ],
                ),
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
                                    const EdgeInsets.fromLTRB(10, 10, 0, 10),
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
                                      'Approve',
                                      style:
                                          TextStyle(color: FColors.textWhite),
                                    ),
                                    onPressed: () {
                                      ///Json Create here
                                      try {
                                        requestApproveJson['FpnNo'] =
                                            _fpnNumber.toString();
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              popupApproveAlert(context,
                                                  txtApproveRemarkController),
                                        ).then((value) {
                                          if (value == 'Submit') {
                                            requestApproveJson['Remark'] =
                                                txtApproveRemarkController.text;

                                            context.loaderOverlay.show();
                                            context
                                                .read<FPNDetailProvider>()
                                                .fpnApproveRequest(
                                                    requestApproveJson)
                                                .then((value) async {
                                              context.loaderOverlay.hide();
                                              if (value.returnStatus == 2) {
                                                await HelperFunctions
                                                    .showAsyncAlert("Success",
                                                        '$_fpnNumber has been approved successfully.');
                                                // widget.callback("refresh");
                                                context.loaderOverlay.show();
                                                txtApproveRemarkController
                                                    .text = "";
                                                _fpnNumber =
                                                    getNextRequest(_fpnNumber);
                                                if (!HelperFunctions
                                                    .isNullorEmpty(
                                                        _fpnNumber)) {
                                                  context
                                                      .read<FPNDetailProvider>()
                                                      .getRequestDetailsData({
                                                    'UserId': GlobalVariables
                                                        .userName,
                                                    'FpnNo': _fpnNumber
                                                  });
                                                  context.loaderOverlay.hide();
                                                } else {
                                                  Get.back(result: "refresh");
                                                }
                                              } else if ((value.returnStatus ==
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
                                        });
                                      } catch (e) {
                                      } finally {
                                        if (context.loaderOverlay.visible) {
                                          context.loaderOverlay.hide();
                                        }
                                      }
                                    }),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 10),
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
                                              FColors.rejectedDark)),
                                  child: const Text(
                                    'Reject',
                                    style: TextStyle(color: FColors.textWhite),
                                  ),
                                  onPressed: () {
                                    ///Json Create here
                                    try {
                                      requestRejectJson['FpnNo'] =
                                          _fpnNumber.toString();
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            popupRejectAlert(context,
                                                txtRejectRemarkController),
                                      ).then((value) {
                                        if (value == 'Submit') {
                                          context.loaderOverlay.show();
                                          requestRejectJson['Remark'] =
                                              txtRejectRemarkController.text;
                                          context
                                              .read<FPNDetailProvider>()
                                              .fpnRejectRequest(
                                                  requestRejectJson)
                                              .then((value) async {
                                            context.loaderOverlay.hide();
                                            if (value.returnStatus == 2) {
                                              await HelperFunctions.showAsyncAlert(
                                                  "Success",
                                                  '$_fpnNumber has been rejected successfully.');
                                              //widget.callback("refresh");
                                              context.loaderOverlay.show();
                                              txtRejectRemarkController.text =
                                                  "";
                                              _fpnNumber =
                                                  getNextRequest(_fpnNumber);
                                              if (!HelperFunctions
                                                  .isNullorEmpty(_fpnNumber)) {
                                                context
                                                    .read<FPNDetailProvider>()
                                                    .getRequestDetailsData({
                                                  'UserId':
                                                      GlobalVariables.userName,
                                                  'FpnNo': _fpnNumber
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
                                      });
                                    } catch (e) {
                                    } finally {
                                      if (context.loaderOverlay.visible) {
                                        context.loaderOverlay.hide();
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                                              FColors.feedbackDark)),
                                  child: const Text(
                                    'Feedback',
                                    style: TextStyle(color: FColors.textWhite),
                                  ),
                                  onPressed: () async {
                                    await Get.to(ChangeNotifierProvider<
                                            FPNFeedbackProvider>(
                                        create: (_) => FPNFeedbackProvider(),
                                        child: FPNFeedbackWidget(
                                          fpnNumber: _fpnNumber,
                                        )));
                                    Get.back(result: "refresh");
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
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

  Padding getFPNMenus(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Card(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 212,
            child: Consumer<FPNDetailProvider>(
              builder: (context, fpnProvider, _) =>
                  NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollController.offset >=
                          scrollController.position.maxScrollExtent &&
                      !scrollController.position.outOfRange) {
                    fpnProvider.setPositionEnd(true);
                  }
                  if (scrollController.offset <=
                          scrollController.position.minScrollExtent &&
                      !scrollController.position.outOfRange) {
                    fpnProvider.setPositionEnd(false);
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
                    itemCount: fpnProvider.getMenuList().length,
                    itemBuilder: (BuildContext context, int index) {
                      return getBorderedLabelIconWidget(
                          index, fpnProvider, scrollController);
                    }),
              ),
            ),
          ),
        ));
  }

  InkWell getBorderedLabelIconWidget(int index, FPNDetailProvider provider,
      ScrollController scrollController) {
    return InkWell(
      onTap: () {
        if (provider.fpnMenuList[index].name == "More") {
          !provider.isPositionEnd
              ? scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn)
              : scrollController.animateTo(0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn);
        } else if (provider.fpnMenuList[index].name == "TCO") {
          {
            Get.to(FPNTCODetailPage(fpnNumber: _fpnNumber));
            provider.setSelectedValue("Project");
          }
        } else {
          provider.setSelectedValue(provider.fpnMenuList[index].name);
        }
      },
      child: getBorderedLabelIcon(
          (provider.fpnMenuList[index].name == "More")
              ? (provider.isPositionEnd)
                  ? FontAwesomeIcons.circleChevronUp
                  : FontAwesomeIcons.circleChevronDown
              : provider.fpnMenuList[index].icon,
          (provider.fpnMenuList[index].name == "More")
              ? ""
              : provider.fpnMenuList[index].name,
          isSelected:
              provider.fpnMenuList[index].name == provider.selectedValue),
    );
  }

  Padding getSelectedScreen(BuildContext context, FPNDetailResponse data,
      String screenType, bool isButtonVisible) {
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
      case "Project":
        widget = data.requestDetails?.projectDetails != null
            ? SizedBox(
                child: Card(
                    child: ProjectDetailsView(
                  projectDetails: data.requestDetails!.projectDetails,
                )),
              )
            : nullWidget;
        break;
      case "Application":
        widget = SizedBox(
          child: Card(
              child: ApplicationListWidget(
            detailList: data.requestDetails!.applicationDetails.detailList,
            totalAmount: data.requestDetails!.applicationDetails.totalAmount,
          )),
        );
        break;

      case "Benefit":
        widget = data.requestDetails!.benefitDetailsNew != null &&
                (data.requestDetails!.benefitDetailsNew!
                            .incrementalVolEffortList !=
                        null ||
                    data.requestDetails!.benefitDetailsNew!.reducedEffortList !=
                        null)
            ? SizedBox(
                child: Card(
                    child: BenefitDetailsNewWidget(
                  benefitDetailsNew: data.requestDetails!.benefitDetailsNew!,
                )),
              )
            : data.requestDetails!.benefitDetails != null
                ? SizedBox(
                    child: Card(
                        child: BenefitDetailsWidget(
                      benefitDetails: data.requestDetails!.benefitDetails!,
                    )),
                  )
                : nullWidget;
        break;
      // case "Benefit":
      //   widget = data.requestDetails!.benefitDetails != null
      //       ? SizedBox(
      //           child: Card(
      //               child: BenefitDetailsWidget(
      //             benefitDetails: data.requestDetails!.benefitDetails!,
      //           )),
      //         )
      //       : nullWidget;
      //   break;
      case "Budget":
        widget = SizedBox(
          child: Card(
              child: BudgetDetailsWidget(
            budgetDetails: data.requestDetails!.budgetDetailsData.budgetDetails,
            totalBudgetAmount:
                data.requestDetails!.budgetDetailsData.totalBudgetAmount,
          )),
        );
        break;
      case "Case Approval":
        widget = data.requestDetails!.caseApprovalMatrix != null
            ? SizedBox(
                child: Card(
                    child: CaseApprovalMatrixWidget(
                  caseApprovalMatrix: data.requestDetails!.caseApprovalMatrix!,
                  fpnNumber: data.fpnNo!,
                  totalBudgetAmount:
                      data.requestDetails!.budgetDetailsData.totalBudgetAmount,
                )),
              )
            : nullWidget;
        break;
      case "Cost Center":
        widget = SizedBox(
          child: Card(
              child: CostCenterListWidget(
            costCenterDetails: data.requestDetails!.costCenterDetails,
          )),
        );
        break;
      case "Additional":
        widget = data.requestDetails!.caseDetails != null
            ? SizedBox(
                child: Card(
                    child: CaseDetailsWidget(
                  caseDetails: data.requestDetails!.caseDetails!,
                )),
              )
            : nullWidget;
        break;
      case "Process Attachment":
        widget = SizedBox(
          child: Card(
              child: ProcessAttachmentWidget(
            processAttachmentDetails:
                data.requestDetails!.processAttachmentDetails,
          )),
        );
        break;
      case "Feedback":
        widget = data.requestDetails!.feedback != null
            ? SizedBox(
                child: FeedbacksWidget(
                feedback: data.requestDetails!.feedback!,
                fpnNumber: _fpnNumber,
              ))
            : nullWidget;
        break;
      case "Audit Trail":
        widget = SizedBox(
            child: AuditTrailsWidget(
          auditTrail: data.requestDetails!.auditTrail,
        ));
        break;
      case "FPN Intimation":
        widget = data.requestDetails?.fYIFPNDetails != null
            ? SizedBox(
                child: Card(
                    child: FPNIntimationWidget(
                  fYIFPNDetails: data.requestDetails!.fYIFPNDetails!,
                )),
              )
            : nullWidget;
        break;
      case "Fincon Sendback":
        widget = data.requestDetails?.sendbackDetails != null
            ? SizedBox(
                child: Card(
                    child: FinconSentbackWidget(
                  sendbackDetails: data.requestDetails!.sendbackDetails!,
                  fpnNumber: data.fpnNo!,
                  isFincon: data.requestDetails!.isFincon,
                  totalBudgetAmount:
                      data.requestDetails!.budgetDetailsData.totalBudgetAmount,
                )),
              )
            : nullWidget;
        break;
    }
    var minusHeight = isButtonVisible ? 395 : 365;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - minusHeight,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text('$screenType Details',
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

class Divider extends StatelessWidget {
  const Divider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1.5, width: double.infinity, color: FColors.dividerColor);
  }
}
