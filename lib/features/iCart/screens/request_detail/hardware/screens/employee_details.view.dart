import 'package:push_notification/common/widgets/label_value_widget.dart';
import 'package:push_notification/features/iCart/models/icart_hardware_detail_response.dart';
import 'package:flutter/material.dart';

class EmployeeDetailsView extends StatelessWidget {
  const EmployeeDetailsView({
    super.key,
    required this.employeeInformation,
  });

  final EmployeeInformation employeeInformation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValueWidget(
          label: 'Employee Code',
          value: employeeInformation.positionCode ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Employee Name',
          value: employeeInformation.empName ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Employee Grade',
          value: employeeInformation.empGrade ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Cost Code',
          value: employeeInformation.costCode ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Cost Code Name',
          value: employeeInformation.costCodeName ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Branch Code',
          value: employeeInformation.branchCode ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Branch Name',
          value: employeeInformation.branchName ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'State',
          value: employeeInformation.state ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
        const Divider(),
        LabelValueWidget(
          label: 'Region',
          value: employeeInformation.region ?? "NA",
          padding: const EdgeInsets.all(5),
        ),
      ],
    );
  }
}
