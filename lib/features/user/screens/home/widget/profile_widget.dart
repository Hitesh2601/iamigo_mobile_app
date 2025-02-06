import 'package:push_notification/features/iSAC/models/isac_pending_count_model.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';

class ProfileWidget extends StatefulWidget {
  final UserDetails userDetails;
  const ProfileWidget({super.key, required this.userDetails});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Iconsax.profile_circle,
          size: 85,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(left: FSizes.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.userDetails.empName,
                style: const TextStyle(
                    color: FColors.textWhite,
                    fontSize: FSizes.fontSizeLg + 2,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: 236,
                child: Text(widget.userDetails.emailId,
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
                      child: Text(widget.userDetails.branchName,
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
    );
  }
}
