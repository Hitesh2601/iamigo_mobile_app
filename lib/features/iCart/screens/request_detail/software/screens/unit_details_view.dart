import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iCart/models/icart_software_detail_response.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class UnitDetailsView extends StatelessWidget {
  const UnitDetailsView({
    super.key,
    required this.unitDetails,
    required this.isServerDataVisible,
  });

  final SoftwareUnitDetails unitDetails;
  final bool isServerDataVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
          label: 'Request Type',
          value: unitDetails.newReplace ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Software',
          value: unitDetails.software ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Version',
          value: unitDetails.version ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Amount (Exclusive of Taxes)',
          value: unitDetails.unitAmount ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Acquisition Type',
          value: unitDetails.acquisitionType ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Software Category',
          value: unitDetails.softwareCategory ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Software Type',
          value: unitDetails.softwareType ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Publisher',
          value: unitDetails.publisher ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        Visibility(
            visible: !HelperFunctions.isNullorEmpty(
                unitDetails.transferFromAssetCode),
            child: const Divider()),
        Visibility(
          visible:
              !HelperFunctions.isNullorEmpty(unitDetails.transferFromAssetCode),
          child: LabelValueWidget(
            label: 'Transfer from Asset Code',
            value: unitDetails.transferFromAssetCode ?? "NA",
            padding: const EdgeInsets.all(10),
          ),
        ),
        Visibility(
            visible: !HelperFunctions.isNullorEmpty(
                unitDetails.transferFromAssetCode),
            child: const Divider()),
        Visibility(
          visible:
              !HelperFunctions.isNullorEmpty(unitDetails.transferFromAssetCode),
          child: LabelValueWidget(
            label: 'Transfer from Employee Code',
            value: unitDetails.transferFromEmpCode ?? "NA",
            padding: const EdgeInsets.all(10),
          ),
        ),
        Visibility(
            visible: !HelperFunctions.isNullorEmpty(
                unitDetails.previousInstalledSoftWare),
            child: const Divider()),
        Visibility(
          visible: !HelperFunctions.isNullorEmpty(
              unitDetails.previousInstalledSoftWare),
          child: LabelValueWidget(
            label: 'Previous Installed Software',
            value: unitDetails.previousInstalledSoftWare ?? "NA",
            padding: const EdgeInsets.all(10),
          ),
        ),
        Visibility(
            visible: !HelperFunctions.isNullorEmpty(
                unitDetails.previousInstalledSoftWareVersion),
            child: const Divider()),
        Visibility(
          visible: !HelperFunctions.isNullorEmpty(
              unitDetails.previousInstalledSoftWareVersion),
          child: LabelValueWidget(
            label: 'Previous Installed Software Version',
            value: unitDetails.previousInstalledSoftWareVersion ?? "NA",
            padding: const EdgeInsets.all(10),
          ),
        ),
        Visibility(
          visible: isServerDataVisible,
          child: Column(
            children: [
              const Divider(),
              LabelValueWidget(
                label: 'Number of days',
                value: unitDetails.noOfdays ?? "NA",
                padding: const EdgeInsets.all(10),
              ),
              const Divider(),
              LabelValueWidget(
                label: 'Environment',
                value: unitDetails.environment ?? "NA",
                padding: const EdgeInsets.all(10),
              ),
              const Divider(),
              LabelValueWidget(
                label: 'Asset Type',
                value: unitDetails.assetType ?? "NA",
                padding: const EdgeInsets.all(10),
              ),
              const Divider(),
              LabelValueWidget(
                label: 'OS Version',
                value: unitDetails.oSVersion ?? "NA",
                padding: const EdgeInsets.all(10),
              ),
              const Divider(),
              LabelValueWidget(
                label: 'Asset Code',
                value: unitDetails.assetCode ?? "NA",
                padding: const EdgeInsets.all(10),
              ),
              const Divider(),
              LabelValueWidget(
                label: 'Owner Name',
                value: unitDetails.ownerName ?? "NA",
                padding: const EdgeInsets.all(10),
              ),
              const Divider(),
              LabelValueWidget(
                label: 'Owner EmpCode',
                value: unitDetails.ownerEmpCode ?? "NA",
                padding: const EdgeInsets.all(10),
              ),
              const Divider(),
              LabelValueWidget(
                label: 'Project Name',
                value: unitDetails.projectName ?? "NA",
                padding: const EdgeInsets.all(10),
              ),
              const Divider(),
              LabelValueWidget(
                label: 'Server Host Name',
                value: unitDetails.serverHostName ?? "NA",
                padding: const EdgeInsets.all(10),
              ),
              const Divider(),
              LabelValueWidget(
                label: 'Server IP Address',
                value: unitDetails.serverIPAddress ?? "NA",
                padding: const EdgeInsets.all(10),
              ),
              const Divider(),
              LabelValueWidget(
                label: 'Server Type',
                value: unitDetails.serverType ?? "NA",
                padding: const EdgeInsets.all(10),
              ),
              const Divider(),
              LabelValueWidget(
                label: 'No of Processors',
                value: unitDetails.noOfProcessors ?? "NA",
                padding: const EdgeInsets.all(10),
              ),
              const Divider(),
              LabelValueWidget(
                label: 'Total Core',
                value: unitDetails.totalCore ?? "NA",
                padding: const EdgeInsets.all(10),
              ),
              const Divider(),
              LabelValueWidget(
                label: 'Server Location',
                value: unitDetails.serverLocation ?? "NA",
                padding: const EdgeInsets.all(10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
