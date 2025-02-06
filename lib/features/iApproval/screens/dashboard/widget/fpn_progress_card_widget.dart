import 'package:push_notification/features/iApproval/providers/fpn_dashboard_provider.dart';
import 'package:push_notification/features/iApproval/providers/fpn_request_list_provider.dart';
import 'package:push_notification/features/iApproval/screens/request_list/fpn_requests_screen.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class FPNProgressCardWidget extends StatelessWidget {
  const FPNProgressCardWidget({
    super.key,
    required this.countData,
    required this.count,
    required this.cardTitle,
    required this.cardType,
  });

  final int countData;
  final double count;
  final String cardTitle;
  final String cardType;

  @override
  Widget build(BuildContext context) {
    double toppending = cardType == "Pending" ? 10 : 15;
    return Padding(
      padding:
          EdgeInsets.only(left: FSizes.md, right: FSizes.md, top: toppending),
      child: InkWell(
        onTap: () async {
          await Get.to(ChangeNotifierProvider<FPNRequestListProvider>(
              create: (_) => FPNRequestListProvider(),
              child: FPNRequestListScreen(
                requestType: cardType,
                isButtonsVisible: cardType == "Pending",
              )));
          await Provider.of<FPNDashboardProvider>(context, listen: false)
              .getDashboardData({"UserId": GlobalVariables.userName});
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(FSizes.borderRadiousLg),
          ),
          color: cardType == "Pending"
              ? FColors.pendingLight
              : FColors.feedbackLight,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                    cardType == "Pending"
                        ? FontAwesomeIcons.userClock
                        : FontAwesomeIcons.envelopeOpenText,
                    size: 30,
                    color: cardType == "Pending"
                        ? FColors.pendingDark
                        : FColors.feedbackDark),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 130,
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: FSizes.md, bottom: FSizes.md),
                            child: Text(
                              '$countData',
                              style: const TextStyle(
                                color: FColors.textWhite,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          LinearProgressIndicator(
                            value: count,
                            color: cardType == "Pending"
                                ? FColors.pendingDark
                                : FColors.feedbackDark,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            FontAwesomeIcons.chartBar,
                            size: 25,
                            color: Colors.white,
                          ),
                          Text(
                            '${(count * 100).round()}%',
                            style: const TextStyle(
                              color: FColors.textWhite,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  cardTitle,
                  style: const TextStyle(
                    color: FColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
