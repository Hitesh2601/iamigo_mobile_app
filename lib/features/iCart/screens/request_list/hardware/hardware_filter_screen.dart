import 'package:push_notification/features/iCart/models/icart_request_response.dart';
import 'package:push_notification/features/iCart/providers/icart_filter_provider.dart';
import 'package:push_notification/features/iCart/providers/icart_request_list_provider.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:flex_list/flex_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class HardwareFilterScreen extends StatefulWidget {
  final HardwareFilter hardwareFilter;

  const HardwareFilterScreen({
    required this.hardwareFilter,
    super.key,
  });

  @override
  State<HardwareFilterScreen> createState() => _HardwareFilterMState();
}

class _HardwareFilterMState extends State<HardwareFilterScreen> {
  bool pageload = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      padding: const EdgeInsets.all(20.0),
      color: const Color(0xfff7f1fb),
      child:
          Consumer<ICartFilterProvider>(builder: (context, filterNotifier, _) {
        if (pageload) {
          filterNotifier.setBackUpHW();
          pageload = false;
        }
        // filterNotifier.getRequestListData({
        //   "RegObj": {
        //     "UserId": GlobalVariables.userName,
        //     "RequestStatus": widget.requestType,
        //     "Profile": widget.profile,
        //     "HardwareReqParams": {
        //       "HardwarePageNo": "0",
        //       "filter": {
        //         "Unit": filterNotifier.selectedUnit,
        //         "HardwareRequestType": filterNotifier.selectedType,
        //         "UnitSpecification": filterNotifier.selectedDesc.isEmpty
        //             ? null
        //             : [filterNotifier.selectedDesc]
        //       }
        //     },
        //     "SoftwareReqParams": {
        //       "SoftwarePageNo": "0",
        //       "filter": {
        //         "SoftwareRequestType": filterNotifier.selectedSWType,
        //         "Software": filterNotifier.selectedSWUnit
        //       }
        //     }
        //   }
        // });
        return Stack(
          children: [
            ListView(
              padding: const EdgeInsets.only(top: 50, bottom: 50),
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: const Text(
                    "Unit",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 18),
                  ),
                ),
                FlexList(
                  horizontalSpacing: 5,
                  verticalSpacing: 10,
                  children: [
                    for (var i = 0;
                        i < widget.hardwareFilter.product!.length;
                        i++)
                      InkWell(
                        onTap: () {
                          filterNotifier.setSelectedUnit(
                              '${widget.hardwareFilter.product?.elementAt(i).productName}',
                              flag: true);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  '${widget.hardwareFilter.product?.elementAt(i).productName}' ==
                                          filterNotifier.selectedUnit
                                      ? FColors.accent
                                      : Colors.grey[400]!,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            '${widget.hardwareFilter.product?.elementAt(i).productName}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:
                                    '${widget.hardwareFilter.product?.elementAt(i).productName}' ==
                                            filterNotifier.selectedUnit
                                        ? FColors.accent
                                        : Colors.grey[700]),
                          ),
                        ),
                      )
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 25, bottom: 10),
                  child: const Text(
                    "Request Type",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 18),
                  ),
                ),
                FlexList(
                  horizontalSpacing: 5,
                  verticalSpacing: 10,
                  children: [
                    for (var i = 0;
                        i < widget.hardwareFilter.hardwareRequestType!.length;
                        i++)
                      InkWell(
                        onTap: () {
                          filterNotifier.setSelectedType(
                              '${widget.hardwareFilter.hardwareRequestType?.elementAt(i).type}',
                              flag: true);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  '${widget.hardwareFilter.hardwareRequestType?.elementAt(i).type}' ==
                                          filterNotifier.selectedType
                                      ? FColors.accent
                                      : Colors.grey[400]!,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            '${widget.hardwareFilter.hardwareRequestType?.elementAt(i).type}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:
                                    '${widget.hardwareFilter.hardwareRequestType?.elementAt(i).type}' ==
                                            filterNotifier.selectedType
                                        ? FColors.accent
                                        : Colors.grey[700]),
                          ),
                        ),
                      )
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 25, bottom: 10),
                  child: const Text(
                    "Unit Specification",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 18),
                  ),
                ),
                FlexList(
                  horizontalSpacing: 5,
                  verticalSpacing: 10,
                  children: [
                    for (var i = 0;
                        i < widget.hardwareFilter.productSpecification!.length;
                        i++)
                      InkWell(
                        onTap: () {
                          filterNotifier.setSelectedDesc(
                              '${widget.hardwareFilter.productSpecification?.elementAt(i).specification}',
                              flag: true);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  '${widget.hardwareFilter.productSpecification?.elementAt(i).specification}' ==
                                          filterNotifier.selectedDesc
                                      ? FColors.accent
                                      : Colors.grey[400]!,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            '${widget.hardwareFilter.productSpecification?.elementAt(i).specification}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:
                                    '${widget.hardwareFilter.productSpecification?.elementAt(i).specification}' ==
                                            filterNotifier.selectedDesc
                                        ? FColors.accent
                                        : Colors.grey[700]),
                          ),
                        ),
                      )
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 50,
                color: const Color(0xfff7f1fb),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Iconsax.filter,
                          color: FColors.textHeader,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Filters',
                            style: TextStyle(
                                color: FColors.textHeader,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      color: Colors.white,
                      padding: EdgeInsets.zero,
                      iconSize: 30,
                      icon: const Icon(FontAwesomeIcons.solidCircleXmark,
                          color: FColors.rejectedDark),
                      onPressed: () => {
                        filterNotifier.resetToPreviousHW(),
                        Get.back(result: null)
                      },
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding:
                                const WidgetStatePropertyAll(EdgeInsets.zero),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                FColors.submitColor)),
                        child: const Text(
                          'Apply Filters',
                          style: TextStyle(color: FColors.textWhite),
                        ),
                        onPressed: () => {
                          Get.back(result: {
                            "selectedRequestType": filterNotifier.selectedType,
                            "selectedUnit": filterNotifier.selectedUnit,
                            "selectedUnitSpec": filterNotifier.selectedDesc,
                            "selectedSWType": filterNotifier.selectedSWType,
                            "selectedSWUnit": filterNotifier.selectedSWUnit,
                          })
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding:
                                  const WidgetStatePropertyAll(EdgeInsets.zero),
                              shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  FColors.rejectedDark)),
                          child: const Text(
                            'Clear Filter',
                            style: TextStyle(color: FColors.textWhite),
                          ),
                          onPressed: () => {
                            filterNotifier.clearWithNotifySelection(),
                            Get.back(result: {
                              "selectedRequestType":
                                  filterNotifier.selectedType,
                              "selectedUnit": filterNotifier.selectedUnit,
                              "selectedUnitSpec": filterNotifier.selectedDesc,
                              "selectedSWType": filterNotifier.selectedSWType,
                              "selectedSWUnit": filterNotifier.selectedSWUnit,
                            })
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
