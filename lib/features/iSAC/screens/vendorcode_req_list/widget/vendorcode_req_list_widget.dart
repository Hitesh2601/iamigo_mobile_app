import 'package:push_notification/features/iSAC/models/vendorcode_req_list_response.dart';
import 'package:push_notification/features/iSAC/screens/vendorcode_req_list/widget/vendorcode_req_item_widget.dart';
import 'package:flutter/material.dart';

typedef StringCallback = void Function(String val);

class VendorCodeRequestListWidget extends StatelessWidget {
  const VendorCodeRequestListWidget(
      {super.key,
      required this.dataItem,
      required this.isButtonVisible,
      required this.callback});
  final bool isButtonVisible;
  final List<RequestListDataVC> dataItem;
  final StringCallback callback;
  @override
  Widget build(BuildContext context) {
    List<String> filteredRequestNo = dataItem.map((e) => e.eNCCid!).toList();

    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: dataItem.length,
      itemBuilder: (context, index) {
        return AnimatedListItem(
          index: index,
          child: VendorCodeRequestItemWidget(
            dataItem: dataItem[index],
            isButtonVisible: isButtonVisible,
            filteredRequestNo: filteredRequestNo,
            callback: callback,
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
