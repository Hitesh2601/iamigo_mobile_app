import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/constants/sizes.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(FSizes.borderRadiousLg),
      ),
      color: FColors.textHeader,
      child: Container(
        height: 120,
        padding: const EdgeInsets.fromLTRB(25, 15, 20, 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              FontAwesomeIcons.solidCircleUser,
              size: 60,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(left: FSizes.md),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    HelperFunctions.truncateText(
                        '${GlobalVariables.empName} (${GlobalVariables.userName.toUpperCase()})',
                        22),
                    style: const TextStyle(
                        color: FColors.textWhite,
                        fontSize: FSizes.fontSizeLg - 1,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 236,
                    child: Text(GlobalVariables.emailId,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            color: FColors.textWhite,
                            fontSize: FSizes.fontSizeMd - 1.5,
                            fontWeight: FontWeight.w500)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: FSizes.xs),
                    child: Row(
                      children: [
                        const Icon(FontAwesomeIcons.locationDot,
                            size: 20, color: FColors.textWhite),
                        Padding(
                          padding: const EdgeInsets.only(left: FSizes.sm),
                          child: Text(GlobalVariables.branchName,
                              style: const TextStyle(
                                  color: FColors.textWhite,
                                  fontSize: FSizes.fontSizeMd - 1.5,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
