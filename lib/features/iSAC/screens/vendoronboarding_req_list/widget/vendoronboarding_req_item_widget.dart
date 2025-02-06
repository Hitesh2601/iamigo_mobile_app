import 'package:push_notification/common/widgets/bottom_right_curve_card.dart';
import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iSAC/models/vendoronboarding_req_list_response.dart';
import 'package:push_notification/features/iSAC/providers/isac_provider.dart';
import 'package:push_notification/features/iSAC/providers/vendor_onboarding_list_provider.dart';
import 'package:push_notification/features/iSAC/screens/vendorcode_req_list/widget/vendorcode_req_item_widget.dart';
import 'package:push_notification/features/iSAC/screens/vendoronboarding_req_details/vendoronboarding_req_details.dart';
import 'package:push_notification/features/iSAC/screens/vendoronboarding_req_list/widget/vendoronboarding_req_list_widget.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class VendorOnboardRequestItemWidget extends StatelessWidget {
  const VendorOnboardRequestItemWidget({
    super.key,
    required this.dataItem,
    required this.isButtonVisible,
    required this.filteredRequestNo,
    required this.callback,
    //required this.VendorTicketNumber,

    //required this.ctx,
  });
  final RequestListDataVO dataItem;
  final bool isButtonVisible;
  final List<String>? filteredRequestNo;
  final StringCallback callback;
  //final List<String> VendorTicketNumber;

  // final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    var requestApproveJson = {
      "ReqObj": {
        "UserId": GlobalVariables.userName,
        "ENC_Cid": "",
        "RequestType": "VendorOnboardingRequest",
      }
    };

    var requestRejectJson = {
      "ReqObj": {
        "UserId": GlobalVariables.userName,
        "ENC_Cid": "",
        "RejectionReasonId": "0",
        "OtherRejectReason": "Reject",
        "RequestType": "VendorOnboardingRequest"
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
            await Get.to(ChangeNotifierProvider<VendorOnBoardingListProvider>(
                create: (_) => VendorOnBoardingListProvider(),
                child: VendorOnboardingDetailsScreen(
                  requestType: "VendorOnboardingRequest",
                  encrequestID: '${dataItem.eNCCid}',
                  isButtonVisible: isButtonVisible,
                  ticketnumber: '${dataItem.ticketNumber}',
                  filteredRequestNo: filteredRequestNo,
                  callback: callback,
                )));
            if (isButtonVisible == true) {
              await context
                  .read<VendorOnBoardingListProvider>()
                  .getvendoronboardRequestListData({
                "ReqObj": {
                  "UserId": GlobalVariables.userName,
                  "RequestStatus": "Pending"
                }
              });
            }

            //     ?.then((value) async {
            //   if (value == "refresh") {
            //     ctx.loaderOverlay.show();
            //     await ctx.read<VendorOnBoardingListProvider>().getSPRequestListData({
            //       "ReqObj": {
            //         "UserId": GlobalVariables.userName,
            //         "RequestStatus": "Pending"
            //       }
            //     });

            //     ctx.loaderOverlay.hide();
            //   } else {
            //     HelperFunctions.showAlert("Error", value);
            //   }
            // });
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
                                        // requestApproveJson = {
                                        //   "ReqObj": {
                                        //     "UserId": GlobalVariables.userName,
                                        //     "ENC_Cid":
                                        //         dataItem.eNCCid.toString(),
                                        //     "RequestType":
                                        //         "VendorOnboardingRequest",
                                        //   }
                                        // },
                                        HelperFunctions.confirmAlert(
                                                "Authorizations",
                                                'Are you sure on Authorization for Ticket No. [${dataItem.ticketNumber}]')
                                            .then((value) {
                                          if (value == "Yes") {
                                            context.loaderOverlay.show();
                                            context
                                                .read<
                                                    VendorOnBoardingListProvider>()
                                                .vendorAuthRequest({
                                              "ReqObj": {
                                                "UserId":
                                                    GlobalVariables.userName,
                                                "ENC_Cid":
                                                    dataItem.eNCCid.toString(),
                                                "RequestType":
                                                    "VendorOnboardingRequest",
                                              }
                                            }).then((value) async {
                                              context.loaderOverlay.hide();

                                              if ((value.returnStatus == 2)) {
                                                //To Show dialog Popup
                                                await HelperFunctions
                                                    .showAsyncAlert("Success",
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
                                                //     .read<VendorOnBoardingListProvider>()
                                                //     .getSPRequestListData({
                                                //   "ReqObj": {
                                                //     "UserId": GlobalVariables
                                                //         .userName,
                                                //     "RequestStatus": "Pending"
                                                //   }
                                                // });
                                                // Provider.of<VendorOnBoardingListProvider>(
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
                                          }
                                        }),
                                      }),
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
                                          "RequestType":
                                              "VendorOnboardingRequest"
                                        }
                                      };

                                      HelperFunctions.confirmAlert("Rejection",
                                              'Are you sure on Rejection for Ticket No. [${dataItem.ticketNumber}]')
                                          .then((value) {
                                        if (value == "Yes") {
                                          // HelperFunctions.showAlert("Success",
                                          //     '${dataItem.ticketNumber} id $id remark $remark  has been rejected successfully.');
                                          context
                                              .read<
                                                  VendorOnBoardingListProvider>()
                                              .vendorRejectRequest(
                                                  requestRejectJson)
                                              .then((value) {
                                            /// To Close Loader
                                            if (value.returnStatus == 2) {
                                              HelperFunctions.showAlert(
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
                                                  "Oops! Something went wrong");
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
                            dataItem.requestorName ?? "", 18)),
                    LabelValueWidget(
                        label: 'Company Name',
                        value: HelperFunctions.truncateText(
                            dataItem.companyName ?? "", 18)),
                    LabelValueWidget(
                        label: 'Staff Name',
                        value: HelperFunctions.truncateText(
                            dataItem.staffName ?? "", 18)),
                    LabelValueWidget(
                        label: 'Staff Line Manager',
                        value: HelperFunctions.truncateText(
                            dataItem.lineMgrCode ?? "", 18)),
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
