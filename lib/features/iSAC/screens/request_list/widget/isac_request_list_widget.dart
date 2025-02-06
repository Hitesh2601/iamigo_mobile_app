// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:push_notification/features/iSAC/models/isac_request_list_response.dart';
import 'package:push_notification/features/iSAC/screens/request_list/widget/isac_request_item_widget.dart';
import 'package:push_notification/features/iSAC/screens/request_list_details/isac_request_list_details.dart';
import 'package:flutter/material.dart';

class ISACRequestListWidget extends StatelessWidget {
  const ISACRequestListWidget({
    super.key,
    required this.dataItem,
    required this.isButtonVisible,
    required this.maincontext,
  });
  //required this.callback
  final bool isButtonVisible;
  final List<ISACData> dataItem;
  final BuildContext maincontext;
  // final StringCallback callback;

  @override
  Widget build(BuildContext context) {
    List<String> filteredFormNo = [];
    List<String> filteredRequestNo = [];

    if (isButtonVisible == true) {
      filteredRequestNo = dataItem.map((e) => e.encRequestID!).toList();
      filteredFormNo = dataItem.map((e) => e.encFormID!).toList();
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: dataItem.length,
      itemBuilder: (context, index) {
        return AnimatedListItem(
          //delay: Duration(milliseconds: index * 100),
          index: index,
          child: ISACRequestItemWidget(
              dataItem: dataItem[index],
              isButtonVisible: isButtonVisible,
              filteredRequestNo: filteredRequestNo,
              filteredFormNo: filteredFormNo,
              ctx: maincontext
              //callback: callback,
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
  const AnimatedListItem({required this.child, required this.index});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: Duration(milliseconds: 500),
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
  // Widget build(BuildContext context) {
  //   Future.delayed(Duration(milliseconds: index * 200), () {
  //     _startAnimation(context);
  //   });
  //   return child;
  // }

  // void _startAnimation(BuildContext context) {
  //   Scaffold.of(context).showBottomSheet<void>(
  //     (BuildContext context) {
  //       return Container(
  //         alignment: Alignment.center,
  //         height: 50,
  //         child: Text('Item $index appeared'),
  //       );
  //     },
  //   );
  // final AnimationController controller = AnimationController(
  //   duration: const Duration(milliseconds: 500),
  //   vsync: Scaffold.of(context),
  // );

  // final Animation<Offset> offsetAnimation = Tween<Offset>(
  //   begin: const Offset(-1, 0),
  //   end: const Offset(0, 0),
  // ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

  //controller.forward();
}

//// Animation on request list item i.e each item is coming one by one
// class AnimatedListItem extends StatefulWidget {
//   final Widget child;
//   final int index;

//   AnimatedListItem({required this.child, required this.index});

//   @override
//   State<AnimatedListItem> createState() => _AnimatedListItemState();
// }

// class _AnimatedListItemState extends State<AnimatedListItem>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _animation;
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 300),
//     );
//     _animation = Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

//     Future.delayed(Duration(milliseconds: widget.index * 600), () {
//       _controller.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SlideTransition(
//       position: _animation,
//       child: FadeTransition(opacity: _controller, child: widget.child),
//     );
//   }
// }
