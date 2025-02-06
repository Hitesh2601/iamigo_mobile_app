import 'package:push_notification/features/iApproval/models/fpn_request_details_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class AuditTrailsWidget extends StatelessWidget {
  const AuditTrailsWidget({
    super.key,
    required this.auditTrail,
  });

  final List<AuditTrail> auditTrail;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(2),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: auditTrail.length,
      itemBuilder: (context, index) {
        return AuditTrailView(
          auditTrail: auditTrail[index],
        );
      },
    );
  }
}

class AuditTrailView extends StatelessWidget {
  const AuditTrailView({super.key, required this.auditTrail});

  final AuditTrail auditTrail;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 12, 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('${auditTrail.actorName} (${auditTrail.actorCode})',
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('${auditTrail.status} ',
                      style: TextStyle(
                          color: auditTrail.status != "Approved"
                              ? Colors.red
                              : Colors.green)),
                  const Text('On ', style: TextStyle(color: Colors.grey)),
                  Text(auditTrail.actionDateTime!,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Html(data: '${auditTrail.auditRemark}'),
            ),
          ],
        ),
      ),
    );
  }
}
