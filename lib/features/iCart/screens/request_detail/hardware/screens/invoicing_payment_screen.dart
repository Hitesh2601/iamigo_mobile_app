// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:push_notification/features/iCart/models/icart_hardware_detail_response.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:flutter/material.dart';

class InvoicingPaymentScreen extends StatelessWidget {
  const InvoicingPaymentScreen({
    super.key,
    required this.invoicingPaymentFar,
  });

  final InvoicingPaymentFar invoicingPaymentFar;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: FColors.light,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 12, bottom: 12),
                          child: Text(
                            "Invoice Details",
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  questionAnswerWidget(
                      "Invoice Number", '${invoicingPaymentFar.invoiceNumber}'),
                  questionAnswerWidget(
                      "Invoice Date", '${invoicingPaymentFar.invoiceDate}'),
                  questionAnswerWidget("Invoice Amount (Rs.)",
                      '${invoicingPaymentFar.invoiceAmount}'),
                  questionAnswerWidget("Invoice Receipt Date",
                      '${invoicingPaymentFar.invoiceReceiptDate}'),
                  questionAnswerWidget("Invoice Submission Date",
                      '${invoicingPaymentFar.invoiceSubmissionDate}'),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: FColors.light,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 12, bottom: 12),
                          child: Text(
                            "Payment And FAR",
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  questionAnswerWidget("Invoice Acceptance Date",
                      '${invoicingPaymentFar.invoiceAcceptanceDate}'),
                  questionAnswerWidget("Payment Voucher No",
                      '${invoicingPaymentFar.invoiceVoucherNo}'),
                  questionAnswerWidget("Payment Date",
                      '${invoicingPaymentFar.invoicePaymentDate}'),
                  questionAnswerWidget(
                      "FAR No", '${invoicingPaymentFar.fARNo}'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding questionAnswerWidget(
    String quetion,
    String answer,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quetion,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(11, 2, 0, 4),
            child: Text(
              answer,
              style: TextStyle(
                  color: Colors.grey.shade600, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
