import 'package:push_notification/features/iApproval/models/fpn_request_details_response.dart';
import 'package:push_notification/features/iApproval/providers/fpn_feedback_provider.dart';
import 'package:push_notification/features/iApproval/screens/feedback/fpn_feedback_reply_widget.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class FeedbacksWidget extends StatelessWidget {
  const FeedbacksWidget({
    super.key,
    required this.feedback,
    required this.fpnNumber,
  });

  final List<FeedbackResponse> feedback;
  final String fpnNumber;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(2),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: feedback.length,
      itemBuilder: (context, index) {
        return FeedbackView(
          feedbackResponse: feedback[index],
          fpnNumber: fpnNumber,
        );
      },
    );
  }
}

class FeedbackView extends StatelessWidget {
  const FeedbackView(
      {super.key, required this.feedbackResponse, required this.fpnNumber});

  final FeedbackResponse feedbackResponse;
  final String fpnNumber;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 8, 12, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('From: ',
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold)),
                Text('${feedbackResponse.queryFromName}',
                    style: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold)),
              ],
            ),
            Text('${feedbackResponse.queryDetail}',
                style: TextStyle(
                    color: Colors.grey.shade800, fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('To: ',
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold)),
                Text('${feedbackResponse.replyFromName}',
                    style: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold)),
              ],
            ),
            Text('${feedbackResponse.replyDetail}',
                style: TextStyle(
                    color: Colors.grey.shade800, fontWeight: FontWeight.w500)),
            Visibility(
              visible: feedbackResponse.replyRequired!,
              child: ElevatedButton(
                style: ButtonStyle(
                    padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    backgroundColor:
                        WidgetStateProperty.all<Color>(FColors.feedbackDark)),
                child: const Text(
                  'Reply',
                  style: TextStyle(color: FColors.textWhite),
                ),
                onPressed: () async {
                  await Get.to(ChangeNotifierProvider<FPNFeedbackProvider>(
                      create: (_) => FPNFeedbackProvider(),
                      child: FPNFeedbackReplyWidget(
                        fpnNumber: fpnNumber,
                        reciepient: feedbackResponse.replyToEmpCode!,
                        reciepientName: feedbackResponse.replyToName!,
                      )));
                  Get.back(result: "refresh");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class FeedbackView extends StatelessWidget {
//   const FeedbackView({Key? key, required this.feedbackResponse})
//       : super(key: key);

//   final FeedbackResponse feedbackResponse;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(12.0, 8, 12, 8),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text('From: ',
//                     style: TextStyle(
//                         color: Colors.grey.shade800,
//                         fontWeight: FontWeight.bold)),
//                 Text('${feedbackResponse.queryFromName}',
//                     style: const TextStyle(
//                         color: Colors.blue, fontWeight: FontWeight.bold)),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text('To: ', style: TextStyle(color: Colors.grey.shade800)),
//                 Text('${feedbackResponse.queryToName}',
//                     style: const TextStyle(
//                         color: Colors.blue, fontWeight: FontWeight.bold)),
//               ],
//             ),
//             Text('${feedbackResponse.queryDetail}',
//                 style: TextStyle(
//                     color: Colors.grey.shade800, fontWeight: FontWeight.bold)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text('From: ',
//                     style: TextStyle(
//                         color: Colors.grey.shade800,
//                         fontWeight: FontWeight.bold)),
//                 Text('${feedbackResponse.replyFromName}',
//                     style: const TextStyle(
//                         color: Colors.blue, fontWeight: FontWeight.bold)),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text('To: ', style: TextStyle(color: Colors.grey.shade800)),
//                 Text('${feedbackResponse.replyToName}',
//                     style: const TextStyle(
//                         color: Colors.blue, fontWeight: FontWeight.bold)),
//               ],
//             ),
//             Text('${feedbackResponse.replyDetail}',
//                 style: TextStyle(
//                     color: Colors.grey.shade800, fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//     );
//   }
// }
