import 'package:push_notification/features/iApproval/models/fpn_request_details_response.dart';
import 'package:push_notification/features/iApproval/screens/request_detail/widget/table_widget.dart';
import 'package:flutter/material.dart';

class BenefitDetailsWidget extends StatelessWidget {
  const BenefitDetailsWidget({
    super.key,
    required this.benefitDetails,
  });

  final List<BenefitDetail> benefitDetails;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: benefitDetails.length,
      itemBuilder: (context, index) {
        return BenefitDetailsView(
          benefitDetail: benefitDetails[index],
        );
      },
    );
  }
}

class BenefitDetailsView extends StatelessWidget {
  const BenefitDetailsView({super.key, required this.benefitDetail});
  final BenefitDetail benefitDetail;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          TableViewWidget(
            header: 'Benefit Type',
            headerValue: benefitDetail.type!,
          ),
          TableViewWidget(
            header: 'Value in Lacs',
            headerValue: benefitDetail.value!,
          ),
          TableViewWidget(
            header: 'Target Date',
            headerValue: benefitDetail.targetDate!,
          ),
          TableViewWidget(
            header: 'Basis',
            headerValue: benefitDetail.basis!,
          )
        ],
      ),
    );
  }
}
