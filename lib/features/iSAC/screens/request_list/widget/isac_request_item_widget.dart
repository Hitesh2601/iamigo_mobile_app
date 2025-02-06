// ignore_for_file: prefer_const_constructors, empty_statements, use_key_in_widget_constructors

import 'package:push_notification/common/widgets/bottom_right_curve_card.dart';
import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/common/widgets/no_data_found_widget.dart';
import 'package:push_notification/features/iSAC/models/isac_request_list_response.dart';
import 'package:push_notification/features/iSAC/models/reject_reason.dart';
import 'package:push_notification/features/iSAC/providers/isac_provider.dart';
import 'package:push_notification/features/iSAC/providers/isac_request_list_provider.dart';
import 'package:push_notification/features/iSAC/screens/request_list_details/isac_request_list_details.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class ISACRequestItemWidget extends StatelessWidget {
  const ISACRequestItemWidget({
    super.key,
    required this.dataItem,
    required this.isButtonVisible,
    //required this.callback,
    required this.filteredRequestNo,
    required this.filteredFormNo,
    required this.ctx,
  });
  final ISACData dataItem;
  final bool isButtonVisible;
  //final StringCallback callback;
  final List<String>? filteredRequestNo;
  final List<String>? filteredFormNo;
  final BuildContext ctx;
  @override
  Widget build(BuildContext context) {
    var requestApproveJson = {
      'ENC_RequestID': "",
      'command': 'AUTHORISE',
      'RejectionResentRemark': '',
      'RejectionReasonID': 0
    };
    var requestRejectJson = {
      'ENC_RequestID': "",
      'command': 'REJECT',
      'RejectionResentRemark': '',
      'RejectionReasonID': 0
    };
    //TextEditingController txtApproveRemarkController = TextEditingController();
    TextEditingController txtRejectRemarkController = TextEditingController();
    // final List<RejectReasonData> reasonList = [];
    // print('start stack');
    return Stack(
      children: [
        const BottomRightCurveCardWidget(
          height: 250,
        ),
        InkWell(
          onTap: () async {
            Get.to(ISACDetailsScreen(
              encrequestID: '${dataItem.encRequestID}',
              isButtonVisible: isButtonVisible,
              formID: '${dataItem.encFormID}',
              ticketnumber: '${dataItem.ticketNumber}',
              // callback: callback,
              filteredRequestNo: filteredRequestNo,
              filteredFormNo: filteredFormNo,
            ))?.then((value) async {
              if (value == "refresh") {
                ctx.loaderOverlay.show();
                await ctx
                    .read<ISACRequestListProvider>()
                    .getSPRequestListData({"LastAccessedDateTime": ""});

                ctx.loaderOverlay.hide();
              } else {
                HelperFunctions.showAlert("Error", value);
              }
            });
            ;
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
              height: 250,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  //   'ENC_RequestID':
                                  //       dataItem.encRequestID.toString(),
                                  //   'command': 'AUTHORISE',
                                  //   'RejectionResentRemark': '',
                                  //   'RejectionReasonID': 0
                                  // },
                                  HelperFunctions.confirmAlert("Authorizations",
                                          'Are you sure on Authorization for Ticket No. [${dataItem.ticketNumber}]')
                                      .then((value) {
                                    if (value == "Yes") {
                                      context.loaderOverlay.show();
                                      context
                                          .read<ISACRequestListProvider>()
                                          .isacApproveRejectRequest({
                                        'ENC_RequestID':
                                            dataItem.encRequestID.toString(),
                                        'command': 'AUTHORISE',
                                        'RejectionResentRemark': '',
                                        'RejectionReasonID': 0
                                      }).then((value) async {
                                        context.loaderOverlay.hide();

                                        if ((value.returnStatus == 2)) {
                                          //To Show dialog Popup
                                          await HelperFunctions.showAsyncAlert(
                                              "Success",
                                              '${dataItem.ticketNumber} has been approved successfully.');

                                          context.loaderOverlay.show();
                                          var requestJson = <String, String>{
                                            "LastAccessedDateTime": ""
                                          };
                                          await context
                                              .read<ISACRequestListProvider>()
                                              .getSPRequestListData(
                                                  requestJson);
                                          // var requestJson = {
                                          //   "ReqObj": {
                                          //     "UserId": GlobalVariables
                                          //         .userName,
                                          //     "RequestStatus": "Pending"
                                          //   }
                                          // };
                                          // await context
                                          //     .read<ISACProvider>()
                                          //     .getSPRequestListData({
                                          //   "ReqObj": {
                                          //     "UserId": GlobalVariables
                                          //         .userName,
                                          //     "RequestStatus": "Pending"
                                          //   }
                                          // });
                                          // Provider.of<ISACProvider>(
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
                                  //showDialog(
                                  // context: context,
                                  // builder: (BuildContext context) {
                                  //   return AlertDialog(
                                  //     title: Text('Authorization'),
                                  //     content: Text(
                                  //         'Are you sure on Authorization for Ticket No. [${dataItem.ticketNumber}]'),
                                  //     actions: <Widget>[
                                  //       TextButton(
                                  //           child: Text('Yes'),
                                  //           onPressed: () {
                                  //             context.loaderOverlay.show();

                                  //             context
                                  //                 .read<ISACProvider>()
                                  //                 .isacApproveRejectRequest(
                                  //                     requestApproveJson)
                                  //                 .then((value) async {
                                  //               context.loaderOverlay
                                  //                   .hide();
                                  //               if ((value.returnStatus ==
                                  //                   2)) {
                                  //                 //To Show dialog Popup
                                  //                 HelperFunctions.showAlert(
                                  //                     "Success",
                                  //                     '${dataItem.ticketNumber} has been approved successfully.');
                                  //                 context.loaderOverlay
                                  //                     .show();
                                  //                 var requestJson =
                                  //                     <String, String>{
                                  //                   "LastAccessedDateTime":
                                  //                       ""
                                  //                 };
                                  //                 await context
                                  //                     .read<ISACProvider>()
                                  //                     .getSPRequestListData(
                                  //                         requestJson);
                                  //                 context.loaderOverlay
                                  //                     .hide();
                                  //               } else if ((value
                                  //                           .returnStatus ==
                                  //                       1) ||
                                  //                   (value.returnStatus ==
                                  //                       4)) {
                                  //                 HelperFunctions.showAlert(
                                  //                     "AMIGO",
                                  //                     value
                                  //                         .responseMessage!);
                                  //               } else {
                                  //                 HelperFunctions.showAlert(
                                  //                     "Error",
                                  //                     "Oops! Something went wrong");
                                  //               }
                                  //             });
                                  //           }),
                                  //       TextButton(
                                  //         child: Text('No'),
                                  //         onPressed: () {
                                  //           Get.back();
                                  //         },
                                  //       ),
                                  //     ],
                                  //   );
                                  // }),
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
                                        openRejectPopup(context,
                                            txtRejectRemarkController, true),
                                  ).then((value) {
                                    if (value['Value'] == 'Submit') {
                                      requestRejectJson = {
                                        'ENC_RequestID':
                                            dataItem.encRequestID.toString(),
                                        'command': 'REJECT',
                                        'RejectionResentRemark':
                                            value['Remark'],
                                        'RejectionReasonID':
                                            value['RejectionReasonID']
                                      };
                                      // var id = value['RejectionReasonID'];
                                      // var remark = value['Remark'];
                                      HelperFunctions.confirmAlert("Rejection",
                                              'Are you sure on Rejection for Ticket No. [${dataItem.ticketNumber}]')
                                          .then((value) {
                                        if (value == "Yes") {
                                          // HelperFunctions.showAlert("Success",
                                          //     '${dataItem.ticketNumber} id $id remark $remark  has been rejected successfully.');
                                          context
                                              .read<ISACRequestListProvider>()
                                              .isacApproveRejectRequest(
                                                  requestRejectJson)
                                              .then((value) async {
                                            /// To Close Loader
                                            if (value.returnStatus == 2) {
                                              await HelperFunctions.showAsyncAlert(
                                                  "Success",
                                                  '${dataItem.ticketNumber} has been rejected successfully.');
                                              context.loaderOverlay.show();
                                              var requestJson =
                                                  <String, String>{
                                                "LastAccessedDateTime": ""
                                              };
                                              await context
                                                  .read<
                                                      ISACRequestListProvider>()
                                                  .getSPRequestListData(
                                                      requestJson);
                                              context.loaderOverlay.hide();
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
                        label: 'Application',
                        value: HelperFunctions.truncateText(
                            dataItem.applicationName ?? "", 21)),
                    // LabelValueWidget(
                    //     label: 'Segment',
                    //     value: dataItem.commandParam.toString()),
                    LabelValueWidget(
                        label: 'Employee Name',
                        value: HelperFunctions.truncateText(
                            dataItem.empName ?? "", 21)),
                    LabelValueWidget(
                        label: 'Employee Code', value: dataItem.empCode ?? ""),
                    LabelValueWidget(
                        label: 'Template',
                        value: HelperFunctions.truncateText(
                            dataItem.templateName ?? "", 21)),
                    LabelValueWidget(
                        label: 'Br. Code', value: dataItem.branchCode ?? ""),
                    LabelValueWidget(
                        label: 'UAM Activity',
                        value: HelperFunctions.truncateText(
                            dataItem.typeOfRequest ?? "", 21)),
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

Widget popupApproveAlert(
    BuildContext context, TextEditingController txtApproveRemarkController) {
  String value;

  return AlertDialog(
    title: const Text(
      'Approve Remark',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    ),
    titlePadding: const EdgeInsets.all(0),
    contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
    buttonPadding: const EdgeInsets.all(0),
    icon: const Icon(
      FontAwesomeIcons.solidCircleCheck,
      color: FColors.approvedDark,
      size: 60,
    ),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))),
    content: Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: const BorderRadius.all(Radius.circular(3))),
      child: TextField(
        controller: txtApproveRemarkController,
        keyboardType: TextInputType.multiline,
        maxLines: 4,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            border: InputBorder.none,
            hintText: 'Enter Remark'),
      ),
    ),
    actions: [
      Row(
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
                  'Submit',
                  style: TextStyle(color: FColors.textWhite),
                ),
                onPressed: () =>
                    {value = 'Submit', Navigator.pop(context, value)},
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
    ],
  );
}

// class RejectReasonAPI extends StatelessWidget {
//   const RejectReasonAPI();

//   @override
//   Widget build(BuildContext context) {
//     var requestRejectReasonJson = {"RequestStatusID": "3"};
//     //List<RejectReasonData> rejectReasonList = [];
//     print('API calling');
//     return FutureBuilder(
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasError) {
//             HelperFunctions.showAlert("Reject Reason", 'Something went wrong.');
//           } else if (snapshot.hasData) {
//             var data = snapshot.data as RejectReason;
//             if (data.returnStatus == 3) {
//               HelperFunctions.showAlert(
//                   "Reject Reason", 'Something went wrong.');
//             } else if (data.returnStatus == 2) {
//               Expanded(
//                 child: Consumer<ISACProvider>(
//                   builder: (context, value, child) {
//                     // if (rejectReasonList.isEmpty) {
//                     //   GlobalVariables.dataReasonItem = [];
//                     // } else {
//                     //   GlobalVariables.dataReasonItem = rejectReasonList;
//                     // }
//                     return Container();
//                     // return popupRejectAlert(
//                     //     context, txtRejectRemarkController, dataReasonItem);
//                   },
//                 ),
//               );
//               const LoadingPage();
//             } else if ((data.returnStatus == 1) || (data.returnStatus == 4)) {
//               showDialog(
//                   context: context,
//                   builder: (BuildContext context) => popupResponseAlert(
//                       context, data.responseMessage.toString()));
//             } else {
//               showDialog(
//                   context: context,
//                   builder: (BuildContext context) =>
//                       popupResponseAlert(context, "Something went wrong"));
//             }
//           }
//         }
//         return const LoadingPage();
//       },
//       future: context
//           .read<ISACProvider>()
//           .isacRejectReasonRequest(requestRejectReasonJson),
//     );
//   }
// }

// class popupRejectAlert extends StatelessWidget {
//  popupRejectAlert({Key? key, required this.dataItem,required this.txtRejectRemarkController }):super(key: key);
// final ReturnReasonData dataItem;
// TextEditingController txtRejectRemarkController;
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

Widget openRejectPopup(BuildContext context,
    TextEditingController txtRejectRemarkController, bool isLoad) {
  var requestRejectReasonJson = {"RequestStatusID": "3"};
  var selIndex = 0;
  txtRejectRemarkController.text = "";
  return AlertDialog(
    title: const Text(
      'Reject Remark',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    ),
    titlePadding: const EdgeInsets.all(0),
    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    buttonPadding: const EdgeInsets.all(0),
    icon: const Icon(
      FontAwesomeIcons.solidCircleXmark,
      color: FColors.rejectedDark,
      size: 60,
    ),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))),
    content: SizedBox(
      height: 400,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        // if (isLoad) {
                        //   listProvider.clearSelection();
                        //   isLoad = false;
                        // }
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
            // Align(
            // alignment: Alignment.bottomCenter,child:
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
                            'RejectionReasonID': selIndex.toString()
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
                            'RejectionReasonID': ''
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
            //),
          ],
        ),
      ),
    ),
  );
}

// Widget popupRejectAlert(
//   BuildContext context,
//   TextEditingController txtRejectRemarkController,
// ) {
//   String value;
//   bool isPageLoad = true;

//   return Consumer<CheckListProvider>(
//       builder: (context, checkListProvider, child) {
//     var requestRejectReasonJson = {"RequestStatusID": "3"};
//     List<ReturnReasonData> resonData = [];

//     Provider.of<ISACProvider>(context, listen: false)
//         .isacRejectReasonRequest(requestRejectReasonJson)
//         .then((value) {
//       resonData = value.returnReasonData!;
//       if (isPageLoad && resonData != []) {
//         checkListProvider.setReasonList(resonData);
//         isPageLoad = false;
//       }
//     });
//     return SizedBox(
//       height: 200,
//       width: 200,
//       child: AlertDialog(
//         title: const Text(
//           'Reject Remark',
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//         ),
//         titlePadding: const EdgeInsets.all(0),
//         contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
//         buttonPadding: const EdgeInsets.all(0),
//         icon: const Icon(
//           FontAwesomeIcons.solidCircleXmark,
//           color: FColors.rejectedDark,
//           size: 60,
//         ),
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(5))),
//         content: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             //Text(checkListProvider.reasonList[0].reasonDesc!)
//             // ListView.builder(
//             //   padding: EdgeInsets.zero,
//             //   scrollDirection: Axis.vertical,
//             //   //shrinkWrap: true,
//             //   itemCount: GlobalVariables.dataReasonItem.length,
//             //   itemBuilder: (context, index) {
//             //     return RejectListItem(
//             //         dataItem: GlobalVariables.dataReasonItem[index]);
//             //   },
//             // ),
//             ...checkListProvider.reasonList.asMap().entries.map((entry) {
//               int index = entry.key;
//               var option = entry.value;
//               return CheckboxListTile(
//                 title: Text(option.reasonDesc!),
//                 value: checkListProvider.selectedOption == index,
//                 onChanged: (bool? value) {
//                   checkListProvider.selectOption(index);
//                 },
//               );
//             }).toList(),
//             if (checkListProvider.selectedOption ==
//                 checkListProvider.reasonList.length - 1)
//               TextField(
//                 decoration: InputDecoration(
//                     contentPadding: EdgeInsets.all(0),
//                     border: InputBorder.none,
//                     hintText: 'Enter Remark'),
//               )
//           ],
//         ),
//         // content: Container(
//         //   height: 90,
//         //   width: MediaQuery.of(context).size.width,
//         //   padding: const EdgeInsets.all(10),
//         //   decoration: BoxDecoration(
//         //       border: Border.all(color: Colors.blue),
//         //       borderRadius: const BorderRadius.all(Radius.circular(3))),
//         //   child: TextField(
//         //     controller: txtRejectRemarkController,
//         //     keyboardType: TextInputType.multiline,
//         //     maxLines: 4,
//         //     decoration: const InputDecoration(
//         //         contentPadding: EdgeInsets.all(0),
//         //         border: InputBorder.none,
//         //         hintText: 'Enter Remark'),
//         //   ),
//         // ),
//         actions: [
//           Row(
//             children: [
//               Expanded(
//                 child: SizedBox(
//                   height: 40,
//                   child: ElevatedButton(
//                     style: ButtonStyle(
//                         padding:
//                             const WidgetStatePropertyAll(EdgeInsets.zero),
//                         shape:
//                             WidgetStateProperty.all<RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8))),
//                         backgroundColor: WidgetStateProperty.all<Color>(
//                             FColors.submitColor)),
//                     child: const Text(
//                       'Submit',
//                       style: TextStyle(color: FColors.textWhite),
//                     ),
//                     onPressed: () =>
//                         {value = 'Submit', Navigator.pop(context, value)},
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 width: 5,
//               ),
//               Expanded(
//                 child: SizedBox(
//                   height: 40,
//                   child: ElevatedButton(
//                     style: ButtonStyle(
//                         padding:
//                             const WidgetStatePropertyAll(EdgeInsets.zero),
//                         shape:
//                             WidgetStateProperty.all<RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8))),
//                         backgroundColor: WidgetStateProperty.all<Color>(
//                             FColors.rejectColor)),
//                     child: const Text('Cancel',
//                         style: TextStyle(color: FColors.textWhite)),
//                     onPressed: () =>
//                         {value = 'Cancel', Navigator.pop(context, value)},
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   });
// }

// class RejectListItem extends StatelessWidget {
//   RejectListItem({
//     Key? key,
//     required this.dataItem,
//   }) : super(key: key);
//   final ReturnReasonData dataItem;
//   bool _isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     print('Reject List Item is called: ${dataItem.reasonDesc}');
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               CheckboxListTile(
//                 title: Text(dataItem.reasonDesc.toString()),
//                 value: _isChecked,
//                 onChanged: (bool? newvalue) {},
//                 activeColor: FColors.textWhite,
//                 checkColor: FColors.tcoDark,
//                 controlAffinity: ListTileControlAffinity.leading,
//               ),
//             ])
//       ],
//     );
//   }
// }

///**********************************
/// Display Response Message Dialog
///**********************************
Widget popupResponseAlert(BuildContext context, String responseMessage) {
  return AlertDialog(
    title: const Text(
      'AMIGO - Request List',
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
            // SpinKitRing(
            //   color: myColor().fpnNavigationBarColor,
            //   size: 50.0,
            // ),
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
