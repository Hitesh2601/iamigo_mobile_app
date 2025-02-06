import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iCart/models/icart_software_detail_response.dart';
import 'package:flutter/material.dart';

class AssetDetailsView extends StatelessWidget {
  const AssetDetailsView(
      {super.key, required this.softwareExistingAssetDetails});

  final SoftwareExistingAssetDetails softwareExistingAssetDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
          label: 'Asset Type',
          value: softwareExistingAssetDetails.assetType ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Asset Code',
          value: softwareExistingAssetDetails.assetCode ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Asset Description',
          value: softwareExistingAssetDetails.assetDesc ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Asset Category',
          value: softwareExistingAssetDetails.assetCategory ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Asset Serial Number',
          value: softwareExistingAssetDetails.assetSerialNo ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Asset Status',
          value: softwareExistingAssetDetails.assetStatus ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Asset Sub Status',
          value: softwareExistingAssetDetails.assetSubStatus ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
      ],
    );
  }
}
