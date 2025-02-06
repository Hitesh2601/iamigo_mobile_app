import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iCart/models/icart_hardware_detail_response.dart';
import 'package:flutter/material.dart';

class POInsuranceInstallationView extends StatelessWidget {
  const POInsuranceInstallationView({
    super.key,
    required this.poInsuranceInstallation,
  });

  final PoInsuranceInstallation poInsuranceInstallation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
          label: 'PO number',
          value: poInsuranceInstallation.pONumber ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        LabelValueWidget(
          label: 'PO Date',
          value: poInsuranceInstallation.pODate ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        LabelValueWidget(
          label: 'Insurance Policy No',
          value: poInsuranceInstallation.insurancePolicyNo ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        LabelValueWidget(
          label: 'Insurance Amount',
          value: poInsuranceInstallation.insuranceAmount ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        LabelValueWidget(
          label: 'Insurance Start Date',
          value: poInsuranceInstallation.insuranceStartDate ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        LabelValueWidget(
          label: 'Insurance End Date',
          value: poInsuranceInstallation.insuranceEndDate ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        LabelValueWidget(
          label: 'New FM Call Log No',
          value: poInsuranceInstallation.newFMCallLogNo ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        LabelValueWidget(
          label: 'New Asset Code',
          value: poInsuranceInstallation.newAssetCode ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        LabelValueWidget(
          label: 'New Serial Number',
          value: poInsuranceInstallation.newSerialNumber ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        LabelValueWidget(
          label: 'Installation Date',
          value: poInsuranceInstallation.installationDate ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
      ],
    );
  }
}
