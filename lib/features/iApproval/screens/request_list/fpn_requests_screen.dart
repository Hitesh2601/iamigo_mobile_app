import 'package:push_notification/common/widgets/background_screen.dart';
import 'package:push_notification/common/widgets/no_data_found_widget.dart';
import 'package:push_notification/features/iApproval/models/fpn_request_list_response.dart';
import 'package:push_notification/features/iApproval/providers/fpn_request_list_provider.dart';
import 'package:push_notification/features/iApproval/screens/dashboard/widget/header_widget.dart';
import 'package:push_notification/features/iApproval/screens/request_list/widget/fpn_request_list_widget.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class FPNRequestListScreen extends StatefulWidget {
  final bool isButtonsVisible;
  final String requestType;

  const FPNRequestListScreen(
      {super.key, required this.isButtonsVisible, required this.requestType});

  @override
  State<FPNRequestListScreen> createState() => _FPNRequestListScreenState();
}

class _FPNRequestListScreenState extends State<FPNRequestListScreen> {
  Future<FpnRequestListResponse>? _myFuture;
  @override
  void initState() {
    super.initState();
    _myFuture = getRequestListData();
  }

  Future<FpnRequestListResponse> getRequestListData() async {
    var res = await Provider.of<FPNRequestListProvider>(context, listen: false)
        .getRequestListData({
      "UserId": GlobalVariables.userName,
      "RequestType": widget.requestType.toString()
    });
    return res;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final double bPadding = MediaQuery.of(context).padding.bottom;
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
              height: 145,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              child: Column(
                children: [
                  HeaderWidget(
                    title: '${widget.requestType} Requests',
                    icon: "back",
                    iconColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Consumer<FPNRequestListProvider>(
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
                            textAlignVertical: TextAlignVertical.center,
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
                          var data = snapshot.data as FpnRequestListResponse;
                          if (data.returnStatus == 3) {
                            return const NoDataFountWidget();
                          } else if (data.returnStatus == 2) {
                            return Consumer<FPNRequestListProvider>(
                              builder: (context, provider, child) {
                                return provider.displayList.isEmpty
                                    ? const NoDataFountWidget()
                                    : Expanded(
                                        child: RequestListWidget(
                                            dataItem: provider.displayList,
                                            isButtonVisible:
                                                widget.isButtonsVisible,
                                            requestType: widget.requestType,
                                            maincontext: context),
                                      );
                              },
                            );
                          } else {
                            HelperFunctions.showAlert(
                                "AMIGO", data.responseMessage!);
                          }
                        }
                      }
                      return const SizedBox();
                    },
                    future: _myFuture,
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
