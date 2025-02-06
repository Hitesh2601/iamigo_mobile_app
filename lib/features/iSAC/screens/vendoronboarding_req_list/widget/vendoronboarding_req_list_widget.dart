import 'package:push_notification/features/iSAC/models/vendoronboarding_req_list_response.dart';
import 'package:push_notification/features/iSAC/screens/vendoronboarding_req_list/widget/vendoronboarding_req_item_widget.dart';
import 'package:flutter/material.dart';

typedef StringCallback = void Function(String val);

class VendorOnboardRequestListWidget extends StatelessWidget {
  const VendorOnboardRequestListWidget(
      {super.key,
      required this.dataItem,
      required this.isButtonVisible,
      //required this.maincontext,
      required this.callback});
  final bool isButtonVisible;
  final List<RequestListDataVO> dataItem;
  //final BuildContext maincontext;
  final StringCallback callback;

  @override
  Widget build(BuildContext context) {
    List<String> filteredRequestNo = dataItem.map((e) => e.eNCCid!).toList();
    // List<String> VendorTicketNumber =
    //     dataItem.map((e) => e.ticketNumber!).toList();

    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: dataItem.length,
      itemBuilder: (context, index) {
        return AnimatedListItem(
          index: index,
          child: VendorOnboardRequestItemWidget(
            dataItem: dataItem[index],
            isButtonVisible: isButtonVisible,
            filteredRequestNo: filteredRequestNo,
            callback: callback,
            //VendorTicketNumber:VendorTicketNumber
            //ctx: maincontext
          ),
        );
      },
    );
  }
}

class AnimatedListItem extends StatelessWidget {
  final Widget child;
  //final Duration delay;
  final int index;
  const AnimatedListItem({super.key, required this.child, required this.index});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 500),
        //curve: Interval(0, 1, curve: Curves.easeInOut),
        curve: Curves.easeInOut,
        //delay: delay,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(100 * (1 - value), 0),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          );
        },
        child: child);
  }
}
