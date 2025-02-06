import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iCart/models/icart_software_detail_response.dart';
import 'package:flutter/material.dart';

class ExtensionDetailScreen extends StatelessWidget {
  const ExtensionDetailScreen({super.key, required this.extensionRequest});

  final ExtensionRequest extensionRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
          label: 'Root Request Number',
          value: extensionRequest.rootRequestNo ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Total Number Of Days',
          value: extensionRequest.totalNumberOfDays ?? "NA",
          padding: const EdgeInsets.all(10),
        ),
        ListView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: extensionRequest.extensionDetailsList?.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const Divider(),
                LabelValueWidget(
                  label: 'Extension Order',
                  value: extensionRequest
                          .extensionDetailsList![index].extensionOrder ??
                      "NA",
                  padding: const EdgeInsets.all(10),
                ),
                const Divider(),
                LabelValueWidget(
                  label: 'Request Number',
                  value: extensionRequest
                          .extensionDetailsList![index].requestNumber ??
                      "NA",
                  padding: const EdgeInsets.all(10),
                ),
                const Divider(),
                LabelValueWidget(
                  label: 'Extended For Request Number',
                  value: extensionRequest.extensionDetailsList![index]
                          .extendedForRequestNumber ??
                      "NA",
                  padding: const EdgeInsets.all(10),
                ),
                const Divider(),
                LabelValueWidget(
                  label: 'License Start Date',
                  value: extensionRequest
                          .extensionDetailsList![index].licenseStartDate ??
                      "NA",
                  padding: const EdgeInsets.all(10),
                ),
                const Divider(),
                LabelValueWidget(
                  label: 'License End Date',
                  value: extensionRequest
                          .extensionDetailsList![index].licenseEndDate ??
                      "NA",
                  padding: const EdgeInsets.all(10),
                ),
                const Divider(),
                LabelValueWidget(
                  label: 'Number Of Days',
                  value:
                      extensionRequest.extensionDetailsList![index].noOfDays ??
                          "NA",
                  padding: const EdgeInsets.all(10),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
