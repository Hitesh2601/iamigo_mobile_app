import 'package:push_notification/common/widgets/no_data_found_widget.dart';
import 'package:push_notification/features/iCart/models/icart_request_response.dart';
import 'package:push_notification/features/iCart/providers/icart_request_list_provider.dart';
import 'package:push_notification/features/iCart/screens/request_list/software/software_filter_screen.dart';
import 'package:push_notification/features/iCart/screens/request_list/software/software_request_list_screen.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class SoftwareRequestScreen extends StatefulWidget {
  final bool isPending;
  final String requestType;
  final SoftwareFilter softwareFilter;
  final String profile;
  const SoftwareRequestScreen(
      {required this.isPending,
      required this.softwareFilter,
      required this.profile,
      required this.requestType,
      super.key});

  @override
  State<SoftwareRequestScreen> createState() => UserSoftwareRequestListState();
}

class UserSoftwareRequestListState extends State<SoftwareRequestScreen> {
  int pageNumber = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic result;
    int swFilterCount = 0;
    return Consumer<ICartRequestListProvider>(
        builder: (context, provider, child) {
      return Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search'),
                      onChanged: provider.onSWSearchTextChanged,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async => {
                    result = await Get.bottomSheet(
                        SoftwareFilterScreen(dataItem: widget.softwareFilter),
                        isScrollControlled: true),
                    if (result != null)
                      {
                        swFilterCount = 0,
                        if (!HelperFunctions.isNullorEmpty(
                            result['selectedSWType']))
                          {swFilterCount = swFilterCount + 1},
                        if (!HelperFunctions.isNullorEmpty(
                            result['selectedSWUnit']))
                          {swFilterCount = swFilterCount + 1},
                        provider.setSwFilterCount(swFilterCount),
                        context.loaderOverlay.show(),
                        await provider.getRequestListData({
                          "RegObj": {
                            "UserId": GlobalVariables.userName,
                            "RequestStatus": widget.requestType,
                            "Profile": widget.profile,
                            "HardwareReqParams": {
                              "HardwarePageNo": pageNumber,
                              "filter": {
                                "Unit": result['selectedUnit'],
                                "HardwareRequestType":
                                    result['selectedRequestType'],
                                "UnitSpecification": result['selectedUnitSpec']
                              }
                            },
                            "SoftwareReqParams": {
                              "SoftwarePageNo": "0",
                              "filter": {
                                "SoftwareRequestType": result['selectedSWType'],
                                "Software": result['selectedSWUnit']
                              }
                            }
                          }
                        }),
                        context.loaderOverlay.hide(),
                      }
                  },
                  child: Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: FaIcon(
                          Iconsax.document_filter,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      Visibility(
                        visible: provider.swFilterCount > 0,
                        child: Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              alignment: Alignment.center,
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                              child: Text(
                                provider.swFilterCount.toString(),
                                style: const TextStyle(
                                    color: FColors.textWhite,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          provider.displaySWList.isEmpty
              ? const NoDataFountWidget()
              : Expanded(
                  child: SoftwareRequestListScreen(
                      dataItem: provider.displaySWList,
                      isPending: widget.isPending,
                      profile: widget.profile,
                      filteredRequestNo: provider.software.filteredRequestNo,
                      requestType: widget.requestType),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                color: Colors.black.withOpacity(0.7),
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: provider.isSoftPrevVisible,
                      child: IconButton(
                        color: FColors.textHeader,
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        icon: const Icon(FontAwesomeIcons.circleChevronLeft,
                            color: FColors.textWhite),
                        onPressed: () async {
                          context.loaderOverlay.show();
                          pageNumber = pageNumber - 1;
                          await provider.getRequestListData({
                            "RegObj": {
                              "UserId": GlobalVariables.userName,
                              "RequestStatus": widget.requestType,
                              "Profile": widget.profile,
                              "HardwareReqParams": {
                                "HardwarePageNo": "0",
                                "filter": {
                                  "Unit": null,
                                  "HardwareRequestType": null,
                                  "UnitSpecification": null
                                }
                              },
                              "SoftwareReqParams": {
                                "SoftwarePageNo": pageNumber,
                                "filter": {
                                  "SoftwareRequestType": null,
                                  "Software": null
                                }
                              }
                            }
                          });
                          context.loaderOverlay.hide();
                        },
                      ),
                    ),
                    Text(
                      provider.softwarePageCounttext,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Visibility(
                      visible: provider.isSoftNextVisible,
                      child: IconButton(
                        color: FColors.textHeader,
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        icon: const Icon(FontAwesomeIcons.circleChevronRight,
                            color: FColors.textWhite),
                        onPressed: () async {
                          context.loaderOverlay.show();
                          pageNumber = pageNumber + 1;
                          await provider.getRequestListData({
                            "RegObj": {
                              "UserId": GlobalVariables.userName,
                              "RequestStatus": widget.requestType,
                              "Profile": widget.profile,
                              "HardwareReqParams": {
                                "HardwarePageNo": "0",
                                "filter": {
                                  "Unit": null,
                                  "HardwareRequestType": null,
                                  "UnitSpecification": null
                                }
                              },
                              "SoftwareReqParams": {
                                "SoftwarePageNo": pageNumber,
                                "filter": {
                                  "SoftwareRequestType": null,
                                  "Software": null
                                }
                              }
                            }
                          });

                          context.loaderOverlay.hide();
                        },
                      ),
                    ),
                  ],
                )),
          ),
        ],
      );
    });
  }
}
