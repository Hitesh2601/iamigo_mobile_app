import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iCart/models/icart_hardware_detail_response.dart';
import 'package:flutter/material.dart';

class ExisitingAsseView extends StatelessWidget {
  const ExisitingAsseView({
    super.key,
    required this.existingAssetDetails,
  });

  final ExistingAssetDetails existingAssetDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
          label: 'FM Call Log No.',
          value: existingAssetDetails.callLogNo ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'WDV',
          value: existingAssetDetails.wDV ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Asset Code',
          value: existingAssetDetails.assetCode ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Asset Type',
          value: existingAssetDetails.assetType ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Asset Serial Number',
          value: existingAssetDetails.assetSerialNo ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Asset Status',
          value: existingAssetDetails.assetStatus ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Asset Sub Status',
          value: existingAssetDetails.assetSubStatus ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Asset at Branch Code',
          value: existingAssetDetails.assetCurrBranchCode ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Warranty Start Date',
          value: existingAssetDetails.assetWarrentyStartDate ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Warranty End Date',
          value: existingAssetDetails.assetWarrentyEndDate ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
      ],
    );
  }
}
