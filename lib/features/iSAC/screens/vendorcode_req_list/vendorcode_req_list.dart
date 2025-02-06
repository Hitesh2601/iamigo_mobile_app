import 'package:push_notification/common/widgets/background_screen.dart';
import 'package:push_notification/common/widgets/no_data_found_widget.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/widget/header_widget.dart';
import 'package:push_notification/features/iSAC/models/vendorcode_req_list_response.dart';
import 'package:push_notification/features/iSAC/providers/isac_provider.dart';
import 'package:push_notification/features/iSAC/providers/vendor_code_list_provider.dart';
import 'package:push_notification/features/iSAC/screens/vendorcode_req_list/widget/vendorcode_req_list_widget.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class VendorCodeRequestListScreen extends StatefulWidget {
  final bool isButtonsVisible;
  final String requestType;
  const VendorCodeRequestListScreen(
      {super.key, required this.isButtonsVisible, required this.requestType});

  @override
  State<VendorCodeRequestListScreen> createState() =>
      _VendorCodeRequestListScreen();
}

class _VendorCodeRequestListScreen extends State<VendorCodeRequestListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var requestJson = {
      "ReqObj": {
        "UserId": GlobalVariables.userName,
        "RequestStatus": widget.requestType
      }
    };
    return Scaffold(
      backgroundColor: FColors.light,
      body: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (_) {
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: FColors.textHeader,
              secondRingColor: FColors.textHeader,
              thirdRingColor: const Color(0xFFEA3799),
              size: 50,
            ),
          );
        },
        overlayColor: Colors.black.withOpacity(0.1),
        child: Stack(
          children: [
            BackgrounScreenWidget(
              height: 160,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 10.0, 8.0),
              child: Column(
                children: [
                  HeaderWidget(
                    title: '${widget.requestType} Requests',
                    icon: "back",
                    iconColor: Colors.white,
                  ),
                  const SizedBox(height: 5),
                  Consumer<VendorCodeListProvider>(
                      builder: (context, provider, child) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 241, 240, 240),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: TextField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
                                child: Icon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  color: FColors.primary,
                                ),
                              ),
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                  color: FColors.primary,
                                  fontWeight: FontWeight.w600),
                            ),
                            onChanged: provider.onSearchTextChanged,
                          ),
                        ),
                      ),
                    );
                  }),
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        context.loaderOverlay.show();
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        context.loaderOverlay.hide();
                        if (snapshot.hasError) {
                          return const NoDataFountWidget();
                        } else if (snapshot.hasData) {
                          var data =
                              snapshot.data as iSACVendorCodeRequestListClass;
                          if (data.returnStatus == 3) {
                            return const NoDataFountWidget();
                          } else if (data.returnStatus == 2) {
                            return Expanded(
                              child: Consumer<VendorCodeListProvider>(
                                builder: (context, value, child) {
                                  return value.displayList.isEmpty
                                      ? const NoDataFountWidget()
                                      : Expanded(
                                          child: VendorCodeRequestListWidget(
                                              dataItem: value.displayList,
                                              isButtonVisible:
                                                  widget.isButtonsVisible,
                                              callback: (val) =>
                                                  setState(() => val)),
                                        );
                                },
                              ),
                            );
                          } else if (data.returnStatus == 1) {
                            return const Text("Error");
                          }
                        }
                      }
                      return const SizedBox();
                    },
                    future: context
                        .read<VendorCodeListProvider>()
                        .getvendorcodeRequestListData(requestJson),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
