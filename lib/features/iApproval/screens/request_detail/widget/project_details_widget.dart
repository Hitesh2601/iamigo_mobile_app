import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iApproval/models/fpn_request_details_response.dart';
import 'package:push_notification/features/iApproval/providers/fpn_request_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectDetailsView extends StatelessWidget {
  const ProjectDetailsView({
    super.key,
    required this.projectDetails,
  });

  final ProjectDetails projectDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
          label: 'Project Name',
          value: projectDetails.projectName!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Project Description',
          value: projectDetails.projectDescription!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Project Id',
          value: projectDetails.projectId!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Concept Initiator Name',
          value: projectDetails.conceptInitiatorName!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Concept Initiator Date',
          value: projectDetails.conceptInitiatorDate!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Business/Sponsor Group Head',
          value: projectDetails.groupHeadName!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Function Name',
          value: projectDetails.functionName!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Function Head Name',
          value: projectDetails.functionHeadName!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Spend Category',
          value: projectDetails.projBudgetCategory!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Estimated Days to Go Live for Final Phase',
          value: projectDetails.days!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'FPN Amount',
          value: projectDetails.fpnAmount!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Non Cash Flow Amount',
          value: projectDetails.nonCashFlow!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Cash Flow Amount',
          value: projectDetails.cashFlow!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'FPN Amount (In Words)',
          value: projectDetails.fpnAmountWords!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Cash Flow Amount (In Words)',
          value: projectDetails.cashFlowWords!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Non Cash Flow Amount (In Words)',
          value: projectDetails.nonCashFlowWords!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'FPN Category',
          value: projectDetails.fpnCategory!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'FPN Sub Category',
          value: projectDetails.fpnSubCategory!,
          padding: const EdgeInsets.all(10),
        ),
        Consumer<FPNDetailProvider>(
          builder: (context, value, child) => Visibility(
            visible: value.isAMCVisible,
            child: Column(
              children: [
                const Divider(),
                LabelValueWidget(
                  label:
                      'Confirm if the proposed BOM for Hardware AMC Validated with FAR and is complete or incase of software AMC the Enhancement details are updated in software AMC tool',
                  value: projectDetails.isHardwareAmcvAlidated!,
                  padding: const EdgeInsets.all(10),
                ),
              ],
            ),
          ),
        ),
        Consumer<FPNDetailProvider>(
          builder: (context, value, child) => Visibility(
            visible: value.isAMCRemarkVisible,
            child: Column(
              children: [
                const Divider(),
                LabelValueWidget(
                  label: 'AMC Remark',
                  value: projectDetails.amcRemark!,
                  padding: const EdgeInsets.all(10),
                ),
              ],
            ),
          ),
        ),
        Consumer<FPNDetailProvider>(
          builder: (context, value, child) => Column(
            children: [
              const Divider(),
              LabelValueWidget(
                label: 'NSI Project',
                value: projectDetails.nsiProject!,
                padding: const EdgeInsets.all(10),
              ),
            ],
          ),
        ),
        Consumer<FPNDetailProvider>(
          builder: (context, value, child) => Visibility(
            visible: value.isPPMProjectIDVisible,
            child: Column(
              children: [
                const Divider(),
                LabelValueWidget(
                  label: 'PPM Project ID',
                  value: projectDetails.ppmProjectId!,
                  padding: const EdgeInsets.all(10),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Project Relevance',
          value: projectDetails.projectRelevance!,
          padding: const EdgeInsets.all(10),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'No Of Phases',
          value: projectDetails.noOfPhase == null
              ? "0"
              : projectDetails.noOfPhase!.length.toString(),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        ),
        (projectDetails.noOfPhase != null)
            ? ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: projectDetails.noOfPhase?.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const Divider(),
                      LabelValueWidget(
                        label: projectDetails.noOfPhase![index].phase!
                            .split("-")[0],
                        value: projectDetails.noOfPhase![index].phase!
                            .split("-")[1],
                        padding: const EdgeInsets.all(10),
                      )
                    ],
                  );
                },
              )
            : const SizedBox()
      ],
    );
  }
}
