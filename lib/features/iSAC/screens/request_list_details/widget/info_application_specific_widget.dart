import 'package:flutter/material.dart';
import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iSAC/models/isac_request_details_response.dart';

class InfoAppSpecificView extends StatelessWidget {
  const InfoAppSpecificView({super.key, required this.appListData});
  final List<ApplicationSpecificInfo> appListData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: appListData.length,
      itemBuilder: (context, index) {
        return RequestListDetailsItemWidget(
          appListData: appListData[index],
        );
      },
    );
  }
}

class RequestListDetailsItemWidget extends StatelessWidget {
  const RequestListDetailsItemWidget({super.key, required this.appListData});
  final ApplicationSpecificInfo appListData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
            label: appListData.key ?? "",
            value: appListData.value ?? "",
            padding: const EdgeInsets.all(7)),
        //const Divider(),
      ],
    );
  }
}

// class InfoAppSpecificView extends StatelessWidget {
//   const InfoAppSpecificView({
//     super.key,
//     required this.infoDetails,
//   });

//   final ISACRequestDetailsClass infoDetails;

//   @override
//   Widget build(BuildContext context) {
//     String AccessText = "";
//     if (infoDetails.ticketData?.accessType != null) {
//       if (infoDetails.ticketData?.accessType == 1) {
//         AccessText = "Temporary";
//       } else {
//         AccessText = "Permanent";
//       }
//     } else {
//       AccessText = "";
//     }
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Visibility(
//           visible: (infoDetails.ticketData!.branchCode!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'Branch Code/Location',
//             value: infoDetails.ticketData?.branchCode ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         //const Divider(),
//         Visibility(
//           visible: (infoDetails
//               .ticketData!.identityStoreMaster!.costCode!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'Cost Code',
//             value:
//                 infoDetails.ticketData?.identityStoreMaster?.costCode ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         //const Divider(),
//         Visibility(
//           visible:
//               ((infoDetails.ticketData!.identityStoreMaster!.systemUserIDDesc !=
//                       null) &&
//                   (infoDetails.ticketData!.identityStoreMaster!
//                       .systemUserIDDesc!.isNotEmpty)),
//           child: LabelValueWidget(
//             label: 'Generic User Id name',
//             value:
//                 infoDetails.ticketData?.identityStoreMaster?.systemUserIDDesc ??
//                     "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),

//         //const Divider(),
//         Visibility(
//           visible: ((infoDetails.ticketData!.systemUserID!.isNotEmpty) &&
//               (infoDetails.ticketData!.systemUserID != null)),
//           child: LabelValueWidget(
//             label: 'System User ID',
//             value: infoDetails.ticketData?.systemUserID ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         //const Divider(),
//         Visibility(
//           visible: ((infoDetails.ticketData!.newGenericIDOwner != null) &&
//               (infoDetails.ticketData!.newGenericIDOwner!.isNotEmpty)),
//           child: LabelValueWidget(
//             label: "New Owner's Employee Code",
//             value: infoDetails.ticketData?.newGenericIDOwner ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         //const Divider(),
//         Visibility(
//           visible: (infoDetails.ticketData!.emailID!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'Email',
//             value: infoDetails.ticketData?.emailID ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         // const Divider(),
//         LabelValueWidget(
//           label: 'Access Type',
//           value: AccessText,
//           padding: const EdgeInsets.all(7),
//         ),
//         //const Divider(),
//         Visibility(
//           visible: ((infoDetails.ticketData!.currentBranchCode != null) &&
//               (infoDetails.ticketData!.currentBranchCode!.isNotEmpty)),
//           child: LabelValueWidget(
//             label: 'Current Branch Code',
//             value: infoDetails.ticketData?.currentBranchCode ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         // const Divider(),
//         Visibility(
//           visible: ((infoDetails.ticketData!.currentSystemTemplate != null) &&
//               (infoDetails.ticketData!.currentSystemTemplate!.isNotEmpty)),
//           child: LabelValueWidget(
//             label: 'Current Template Code',
//             value: infoDetails.ticketData?.currentSystemTemplate ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         //const Divider(),
//         Visibility(
//           visible: ((infoDetails.ticketData!.duration!.toString().isNotEmpty) &&
//               (infoDetails.ticketData!.duration!.toString() != null)),
//           child: LabelValueWidget(
//             label: 'Duration  (In Days)',
//             value: infoDetails.ticketData?.duration.toString() ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         //const Divider(),
//         Visibility(
//           visible: ((infoDetails.ticketData!.remarks != null) &&
//               (infoDetails.ticketData!.remarks!.isNotEmpty)),
//           child: LabelValueWidget(
//             label: 'Remarks',
//             value: infoDetails.ticketData?.remarks ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         //const Divider(),
//         Visibility(
//           visible: ((infoDetails.ticketData!.agency != null) &&
//               (infoDetails.ticketData!.agency!.isNotEmpty)),
//           child: LabelValueWidget(
//             label: 'Agency',
//             value: infoDetails.ticketData?.agency ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         //const Divider(),
//         // LabelValueWidget(
//         //   label: 'BP Type',
//         //   value: infoDetails.ticketData?.agency ?? "NA",
//         //   padding: const EdgeInsets.all(7),
//         // ),
//         //const Divider(),

//         Visibility(
//           visible: (infoDetails.ticketData!.productName!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'Product to be Mapped',
//             value: "",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         // const Divider(),
//         Visibility(
//           visible: (infoDetails.ticketData!.productName!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'Product Category',
//             value: infoDetails.ticketData?.productCategoryName ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         //const Divider(),
//         Visibility(
//           visible: (infoDetails.ticketData!.productName!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'Product',
//             value: infoDetails.ticketData?.productName ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         //const Divider(),
//         Visibility(
//           visible: (infoDetails.ticketData!.productNameRemove!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'Product to be Removed',
//             value: "",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         //const Divider(),
//         Visibility(
//           visible: (infoDetails.ticketData!.productNameRemove!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'Product Category',
//             value: infoDetails.ticketData?.productCategoryNameRemove ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         // const Divider(),
//         Visibility(
//           visible: (infoDetails.ticketData!.productNameRemove!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'Product',
//             value: infoDetails.ticketData?.productNameRemove ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         // const Divider(),
//         Visibility(
//           visible: (infoDetails.ticketData!.regionName!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'Location to be Mapped',
//             value: "",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         // const Divider(),
//         Visibility(
//           visible: (infoDetails.ticketData!.regionName!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'Region',
//             value: infoDetails.ticketData?.regionName ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         //const Divider(),
//         Visibility(
//           visible: (infoDetails.ticketData!.regionName!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'State',
//             value: infoDetails.ticketData?.stateName ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         //const Divider(),
//         Visibility(
//           visible: (infoDetails.ticketData!.regionName!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'Hub',
//             value: infoDetails.ticketData?.hubName ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),

//         //const Divider(),
//         // LabelValueWidget(
//         //   label: 'Branch',
//         //   value: infoDetails.ticketData?.regionBranchId ?? "NA",
//         //   padding: const EdgeInsets.all(7),
//         // ),
//         //const Divider(),
//         Visibility(
//           visible: (infoDetails.ticketData!.regionName!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'Location',
//             value: infoDetails.ticketData?.regionBranchId ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         // const Divider(),
//         Visibility(
//           visible: (infoDetails.ticketData!.regionNameRemove!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'Location to be Removed',
//             value: "",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         //const Divider(),
//         Visibility(
//           visible: (infoDetails.ticketData!.regionNameRemove!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'Region',
//             value: infoDetails.ticketData?.regionNameRemove ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         //const Divider(),
//         Visibility(
//           visible: (infoDetails.ticketData!.regionNameRemove!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'State',
//             value: infoDetails.ticketData?.stateNameRemove ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//         //const Divider(),
//         Visibility(
//           visible: (infoDetails.ticketData!.regionNameRemove!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'Hub',
//             value: infoDetails.ticketData?.hubNameRemove ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),

//         //const Divider(),
//         // LabelValueWidget(
//         //   label: 'Branch',
//         //   value: infoDetails.ticketData?.regionBranchIdRemove ?? "NA",
//         //   padding: const EdgeInsets.all(7),
//         // ),
//         // const Divider(),
//         Visibility(
//           visible: (infoDetails.ticketData!.regionNameRemove!.isNotEmpty),
//           child: LabelValueWidget(
//             label: 'Location',
//             value: infoDetails.ticketData?.regionBranchIdRemove ?? "NA",
//             padding: const EdgeInsets.all(7),
//           ),
//         ),
//       ],
//     );
//   }
// }
