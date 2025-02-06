import 'package:push_notification/common/widgets/bottom_right_curve_card.dart';
import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/common/widgets/no_data_found_widget.dart';
import 'package:push_notification/features/iSAC/models/reject_reason.dart';
import 'package:push_notification/features/iSAC/models/vendorcode_req_list_response.dart';
import 'package:push_notification/features/iSAC/providers/isac_provider.dart';
import 'package:push_notification/features/iSAC/providers/vendor_code_list_provider.dart';
import 'package:push_notification/features/iSAC/screens/vendorcode_req_list/widget/vendorcode_req_list_widget.dart';
import 'package:push_notification/features/iSAC/screens/vendoronboarding_req_details/vendoronboarding_req_details.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class VendorCodeRequestItemWidget extends StatelessWidget {
  const VendorCodeRequestItemWidget({
    super.key,
    required this.dataItem,
    required this.isButtonVisible,
    required this.callback,
    required this.filteredRequestNo,
  });
  final RequestListDataVC dataItem;
  final bool isButtonVisible;
  final StringCallback callback;
  final List<String>? filteredRequestNo;
  @override
  Widget build(BuildContext context) {
    var requestApproveJson = {
      "ReqObj": {
        "UserId": GlobalVariables.userName,
        "ENC_Cid": "",
        "RequestType": "VendorCodeRequest"
      }
    };
    var requestRejectJson = {
      "ReqObj": {
        "UserId": GlobalVariables.userName,
        "ENC_Cid": "",
        "RejectionReasonId": "0",
        "OtherRejectReason": "Reject",
        "RequestType": "VendorCodeRequest"
      }
    };
    TextEditingController txtRejectRemarkController = TextEditingController();
    return Stack(
      children: [
        const BottomRightCurveCardWidget(
          height: 200,
        ),
        InkWell(
          onTap: () async {
            await Get.to(ChangeNotifierProvider<ISACProvider>(
                create: (_) => ISACProvider(),
                child: VendorOnboardingDetailsScreen(
                  requestType: "VendorCodeRequest",
                  encrequestID: '${dataItem.eNCCid}',
                  isButtonVisible: isButtonVisible,
                  ticketnumber: '${dataItem.ticketNumber}',
                  filteredRequestNo: filteredRequestNo,
                  callback: callback,
                )));
            if (isButtonVisible == true) {
              await context
                  .read<VendorCodeListProvider>()
                  .getvendorcodeRequestListData({
                "ReqObj": {
                  "UserId": GlobalVariables.userName,
                  "RequestStatus": "Pending"
                }
              });
            }
          },
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(100)),
            ),
            child: SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 0,
                          child: Text(
                            '${dataItem.ticketNumber}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: FColors.listHeaderText,
                                fontSize: 14),
                          ),
                        ),
                        Visibility(
                          visible: isButtonVisible,
                          child: Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                color: Colors.white,
                                padding: EdgeInsets.zero,
                                iconSize: 30,
                                icon: const Icon(
                                    FontAwesomeIcons.solidCircleCheck,
                                    color: FColors.submitColor),
                                onPressed: () => {
                                  ///Json Create here

                                  HelperFunctions.confirmAlert("Authorizations",
                                          'Are you sure on Authorization for Ticket No. [${dataItem.ticketNumber}]')
                                      .then((value) {
                                    if (value == "Yes") {
                                      context.loaderOverlay.show();
                                      context
                                          .read<VendorCodeListProvider>()
                                          .vendorAuthRequest({
                                        "ReqObj": {
                                          "UserId": GlobalVariables.userName,
                                          "ENC_Cid": dataItem.eNCCid.toString(),
                                          "RequestType": "VendorCodeRequest"
                                        }
                                      }).then((value) async {
                                        context.loaderOverlay.hide();

                                        if ((value.returnStatus == 2)) {
                                          //To Show dialog Popup
                                          HelperFunctions.showAlert("Success",
                                              '${dataItem.ticketNumber} has been approved successfully.');

                                          context.loaderOverlay.show();
                                          callback("refresh");
                                          // var requestJson = {
                                          //   "ReqObj": {
                                          //     "UserId": GlobalVariables
                                          //         .userName,
                                          //     "RequestStatus": "Pending"
                                          //   }
                                          // };
                                          // await context
                                          //     .read<VendorCodeListProvider>()
                                          //     .getSPRequestListData({
                                          //   "ReqObj": {
                                          //     "UserId": GlobalVariables
                                          //         .userName,
                                          //     "RequestStatus": "Pending"
                                          //   }
                                          // });
                                          // Provider.of<VendorCodeListProvider>(
                                          //         context,
                                          //         listen: false)
                                          //     .getSPRequestListData({
                                          //   "ReqObj": {
                                          //     "UserId": GlobalVariables
                                          //         .userName,
                                          //     "RequestStatus": "Pending"
                                          //   }
                                          // });
                                          context.loaderOverlay.hide();
                                        } else if ((value.returnStatus == 1) ||
                                            (value.returnStatus == 4)) {
                                          HelperFunctions.showAlert(
                                              "AMIGO", value.responseMessage!);
                                        } else {
                                          HelperFunctions.showAlert("Error",
                                              "Oops! Something went wrong");
                                        }
                                      });
                                    }
                                  }),
                                },
                              ),
                              IconButton(
                                color: Colors.white,
                                padding: EdgeInsets.zero,
                                iconSize: 30,
                                icon: const Icon(
                                    FontAwesomeIcons.solidCircleXmark,
                                    color: FColors.rejectColor),
                                onPressed: () => {
                                  ///Json Create here

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        openRejectPopup(
                                      context,
                                      txtRejectRemarkController,
                                    ),
                                  ).then((value) {
                                    if (value['Value'] == 'Submit') {
                                      requestRejectJson = {
                                        "ReqObj": {
                                          "UserId": GlobalVariables.userName,
                                          "ENC_Cid": dataItem.eNCCid.toString(),
                                          "RejectionReasonId":
                                              value['RejectionReasonId'],
                                          "OtherRejectReason": value['Remark'],
                                          "RequestType": "VendorCodeRequest"
                                        }
                                      };

                                      HelperFunctions.confirmAlert("Rejection",
                                              'Are you sure on Rejection for Ticket No. [${dataItem.ticketNumber}]')
                                          .then((value) {
                                        if (value == "Yes") {
                                          context
                                              .read<VendorCodeListProvider>()
                                              .vendorRejectRequest(
                                                  requestRejectJson)
                                              .then((value) async {
                                            if (value.returnStatus == 2) {
                                              await HelperFunctions.showAsyncAlert(
                                                  "Success",
                                                  '${dataItem.ticketNumber} has been rejected successfully.');
                                              callback("refresh");
                                            } else if ((value.returnStatus ==
                                                    1) ||
                                                (value.returnStatus == 4)) {
                                              HelperFunctions.showAlert("AMIGO",
                                                  value.responseMessage!);
                                            } else {
                                              HelperFunctions.showAlert("Error",
                                                  "Something went wrong");
                                            }
                                          });
                                        }
                                      });
                                    } else {}
                                  })
                                },
                              ),
                            ],
                          )),
                        )
                      ],
                    ),
                    SizedBox(
                        height: isButtonVisible ? 0.5 : 10,
                        width: double.infinity),
                    LabelValueWidget(
                        label: 'Requestor Name',
                        value: HelperFunctions.truncateText(
                            dataItem.requestor ?? "", 21)),
                    LabelValueWidget(
                        label: 'Company Name',
                        value: HelperFunctions.truncateText(
                            dataItem.companyName ?? "", 21)),
                    LabelValueWidget(
                        label: 'Request For', value: dataItem.requestFor ?? ""),
                    LabelValueWidget(
                        label: 'Type Of Request',
                        value: HelperFunctions.truncateText(
                            dataItem.requestType ?? "", 21)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

///**********************************
/// Display Response Message Dialog
///**********************************
Widget popupResponseAlert(BuildContext context, String responseMessage) {
  return AlertDialog(
    title: const Text(
      'Amigo',
      style: TextStyle(fontSize: 17),
    ),
    content: Text(responseMessage),
    actions: [
      SizedBox(
        height: 40,
        child: TextButton(
          child: const Text('Ok'),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
    ],
  );
}

///*******************
/// Loader Dialog
///*******************
Widget popupLoaderScreen(BuildContext context) {
  return const Opacity(
    opacity: 0.5,
    child: AlertDialog(
      content: SizedBox(
        height: 100,
        width: 100,
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              'Loading...',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ),
  );
}

Widget openRejectPopup(
  BuildContext context,
  TextEditingController txtRejectRemarkController,
) {
  var requestRejectReasonJson = {"RequestStatusID": "3"};
  var selIndex = 0;
  txtRejectRemarkController.text = "";
  return SizedBox(
    height: 100,
    width: 100,
    child: AlertDialog(
      title: const Text(
        'Reject Remark',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      buttonPadding: const EdgeInsets.all(0),
      icon: const Icon(
        FontAwesomeIcons.solidCircleXmark,
        color: FColors.rejectColor,
        size: 60,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const NoDataFountWidget();
                  } else if (snapshot.hasData) {
                    var data = snapshot.data as RejectReason;
                    if (data.returnStatus == 3) {
                      return const NoDataFountWidget();
                    } else if (data.returnStatus == 2) {
                      return Consumer<ISACRejectListProvider>(
                          builder: (context, listProvider, child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...listProvider.rejectdata
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              var option = entry.value;
                              return CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Text(option.reasonDesc!),
                                value: listProvider.selectedOption == index,
                                onChanged: (bool? val) {
                                  listProvider.selectOption(index);
                                  selIndex = option.cid!;
                                },
                              );
                            }),
                            if (listProvider.selectedOption ==
                                listProvider.rejectdata.length - 1)
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(3))),
                                child: TextField(
                                  controller: txtRejectRemarkController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 4,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(0),
                                      border: InputBorder.none,
                                      hintText: 'Enter Remark'),
                                ),
                              ),
                          ],
                        );
                      });
                    } else if (data.returnStatus == 1) {
                      return const Text("Error");
                    }
                  }
                }
                return const LoadingPage();
              },
              future: context
                  .read<ISACRejectListProvider>()
                  .isacRejectReasonRequest(requestRejectReasonJson),
            ),
            const SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding:
                                const WidgetStatePropertyAll(EdgeInsets.zero),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                FColors.submitColor)),
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: FColors.textWhite),
                        ),
                        onPressed: () => {
                          Navigator.pop(context, {
                            'Value': "Submit",
                            'Remark': txtRejectRemarkController.text,
                            'RejectionReasonId': selIndex.toString()
                          })
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
                            padding:
                                const WidgetStatePropertyAll(EdgeInsets.zero),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                FColors.rejectColor)),
                        child: const Text('Cancel',
                            style: TextStyle(color: FColors.textWhite)),
                        onPressed: () => {
                          Navigator.pop(context, {
                            'Value': "Cancel",
                            'Remark': '',
                            'RejectionReasonId': ''
                          })
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    ),
  );
}
