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

class FPNSmallCard extends StatelessWidget {
  const FPNSmallCard(
      {super.key,
      required this.countData,
      required this.cardTitle,
      required this.cardType});

  final int countData;
  final String cardTitle;
  final String cardType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Get.to(ChangeNotifierProvider<FPNRequestListProvider>(
            create: (_) => FPNRequestListProvider(),
            child: FPNRequestListScreen(
              requestType: cardType,
              isButtonsVisible: false,
            )));
        await Provider.of<FPNDashboardProvider>(context, listen: false)
            .getDashboardData({"UserId": GlobalVariables.userName});
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: FSizes.md, right: FSizes.md, top: 15),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 70,
              child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50)),
                  ),
                  color: cardType == "Approved"
                      ? FColors.approvedMedium
                      : cardType == "Locked"
                          ? FColors.lockedMedium
                          : FColors.rejectedMedium,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                            (cardType == "Approved"
                                ? FontAwesomeIcons.userCheck
                                : (cardType == "Rejected"
                                    ? FontAwesomeIcons.circleXmark
                                    : FontAwesomeIcons.lock)),
                            size: 30,
                            color: cardType == "Approved"
                                ? FColors.approvedDark
                                : cardType == "Locked"
                                    ? FColors.lockedDark
                                    : FColors.rejectedDark),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            cardTitle,
                            style: const TextStyle(
                              color: FColors.textWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          Positioned(
            top: 40,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    color: cardType == "Approved"
                        ? FColors.approvedLight
                        : cardType == "Locked"
                            ? FColors.lockedLight
                            : FColors.rejectedLight,
                    child: SizedBox(
                      width: 75,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '$countData',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: cardType == "Approved"
                                ? FColors.approvedDark
                                : cardType == "Locked"
                                    ? FColors.lockedDark
                                    : FColors.rejectedDark,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
