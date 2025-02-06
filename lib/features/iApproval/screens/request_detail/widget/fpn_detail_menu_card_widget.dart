import 'package:push_notification/utility/constants/colors.dart';
import 'package:flutter/material.dart';

// typedef StringCallback = void Function(String val);

// class FPNDetailMenuCardWidget extends StatelessWidget {
//   final String fpnNo;
//   final StringCallback callback;
//   final String selectedValue;
//   const FPNDetailMenuCardWidget(
//       {super.key,
//       required this.fpnNo,
//       required this.callback,
//       required this.selectedValue});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(
//               height: 15,
//             ),
//             Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//               InkWell(
//                 onTap: () {
//                   callback(FPNDetailMenus.fpnMenuList[0].name);
//                 },
//                 child: BorderedLabelIconWidget(
//                     icon: FPNDetailMenus.fpnMenuList[0].icon,
//                     name: FPNDetailMenus.fpnMenuList[0].name,
//                     height: 50,
//                     isSelected:
//                         FPNDetailMenus.fpnMenuList[0].name == selectedValue),
//               ),
//               InkWell(
//                 onTap: () {
//                   callback(FPNDetailMenus.fpnMenuList[1].name);
//                 },
//                 child: BorderedLabelIconWidget(
//                     icon: FPNDetailMenus.fpnMenuList[1].icon,
//                     name: FPNDetailMenus.fpnMenuList[1].name,
//                     height: 50,
//                     isSelected:
//                         FPNDetailMenus.fpnMenuList[1].name == selectedValue),
//               ),
//               InkWell(
//                 onTap: () {
//                   callback(FPNDetailMenus.fpnMenuList[2].name);
//                 },
//                 child: BorderedLabelIconWidget(
//                     icon: FPNDetailMenus.fpnMenuList[2].icon,
//                     name: FPNDetailMenus.fpnMenuList[2].name,
//                     height: 50,
//                     isSelected:
//                         FPNDetailMenus.fpnMenuList[2].name == selectedValue),
//               ),
//               InkWell(
//                 onTap: () {
//                   callback(FPNDetailMenus.fpnMenuList[3].name);
//                 },
//                 child: BorderedLabelIconWidget(
//                     icon: FPNDetailMenus.fpnMenuList[3].icon,
//                     name: FPNDetailMenus.fpnMenuList[3].name,
//                     height: 50,
//                     isSelected:
//                         FPNDetailMenus.fpnMenuList[3].name == selectedValue),
//               ),
//             ]),
//             Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//               InkWell(
//                 onTap: () {
//                   Get.to(FPNTCODetailPage(fpnNumber: fpnNo));
//                 },
//                 child: BorderedLabelIconWidget(
//                     icon: FPNDetailMenus.fpnMenuList[4].icon,
//                     name: FPNDetailMenus.fpnMenuList[4].name,
//                     height: 50),
//               ),
//               InkWell(
//                 onTap: () {
//                   callback(FPNDetailMenus.fpnMenuList[5].name);
//                 },
//                 child: BorderedLabelIconWidget(
//                     icon: FPNDetailMenus.fpnMenuList[5].icon,
//                     name: FPNDetailMenus.fpnMenuList[5].name,
//                     height: 50,
//                     isSelected:
//                         FPNDetailMenus.fpnMenuList[5].name == selectedValue),
//               ),
//               InkWell(
//                 onTap: () {
//                   callback(FPNDetailMenus.fpnMenuList[10].name);
//                 },
//                 child: BorderedLabelIconWidget(
//                     icon: FPNDetailMenus.fpnMenuList[10].icon,
//                     name: FPNDetailMenus.fpnMenuList[10].name,
//                     height: 50,
//                     isSelected:
//                         FPNDetailMenus.fpnMenuList[10].name == selectedValue),
//               ),
//               InkWell(
//                 onTap: () => {
//                   showModalBottomSheet(
//                       context: context,
//                       isScrollControlled: true,
//                       builder: (BuildContext context) {
//                         return FractionallySizedBox(
//                           heightFactor: 0.34,
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       InkWell(
//                                         onTap: () async {
//                                           callback(FPNDetailMenus
//                                               .fpnMenuList[6].name);

//                                           Get.back();
//                                         },
//                                         child: BorderedIconWidget(
//                                           icon: FPNDetailMenus
//                                               .fpnMenuList[6].icon,
//                                           name: FPNDetailMenus
//                                               .fpnMenuList[6].name,
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () async {
//                                           callback(FPNDetailMenus
//                                               .fpnMenuList[7].name);
//                                           Get.back();
//                                         },
//                                         child: BorderedIconWidget(
//                                           icon: FPNDetailMenus
//                                               .fpnMenuList[7].icon,
//                                           name: FPNDetailMenus
//                                               .fpnMenuList[7].name,
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () async {
//                                           callback(FPNDetailMenus
//                                               .fpnMenuList[8].name);
//                                           Get.back();
//                                         },
//                                         child: BorderedIconWidget(
//                                           icon: FPNDetailMenus
//                                               .fpnMenuList[8].icon,
//                                           name: FPNDetailMenus
//                                               .fpnMenuList[8].name,
//                                         ),
//                                       ),
//                                     ]),
//                                 Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       InkWell(
//                                         onTap: () async {
//                                           callback(FPNDetailMenus
//                                               .fpnMenuList[9].name);
//                                           Get.back();
//                                         },
//                                         child: BorderedIconWidget(
//                                           icon: FPNDetailMenus
//                                               .fpnMenuList[9].icon,
//                                           name: FPNDetailMenus
//                                               .fpnMenuList[9].name,
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () async {
//                                           callback(FPNDetailMenus
//                                               .fpnMenuList[10].name);
//                                           Get.back();
//                                         },
//                                         child: BorderedIconWidget(
//                                           icon: FPNDetailMenus
//                                               .fpnMenuList[10].icon,
//                                           name: FPNDetailMenus
//                                               .fpnMenuList[10].name,
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () => {Get.back()},
//                                         child: const BorderedIconWidget(
//                                           icon:
//                                               FontAwesomeIcons.circleChevronUp,
//                                           name: "Less",
//                                         ),
//                                       ),
//                                     ]),
//                               ]),
//                         );
//                       })
//                 },
//                 child: const BorderedLabelIconWidget(
//                   icon: FontAwesomeIcons.circleChevronDown,
//                   name: "More",
//                   height: 50,
//                 ),
//               )
//             ]),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BorderedLabelIconWidget extends StatelessWidget {
//   final IconData icon;
//   final String name;
//   final double height;
//   final double width;
//   final bool isSelected;

//   const BorderedLabelIconWidget(
//       {super.key,
//       required this.icon,
//       required this.name,
//       this.height = 120,
//       this.width = 80,
//       this.isSelected = false});

//   @override
//   Widget build(BuildContext context) {
//     return getBorderedLabelIcon();
//   }

Column getBorderedLabelIcon(IconData icon, String name,
    {bool isSelected = false}) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 46,
          width: 46,
          decoration: BoxDecoration(
              border: Border.all(color: FColors.light),
              borderRadius: BorderRadius.circular(70),
              color: isSelected ? FColors.textHeader : FColors.light,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400]!,
                    blurRadius: 3.0,
                    blurStyle: BlurStyle.normal),
              ]),
          child: Icon(
            icon,
            size: name == "" || name == "More" || name == "Less" ? 50 : 20,
            color: isSelected ? FColors.light : FColors.textHeader,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
      ]);
}

// class BorderedIconWidget extends StatelessWidget {
//   final IconData icon;
//   final String name;

//   const BorderedIconWidget({super.key, required this.icon, required this.name});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 95,
//       height: 120,
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               height: 70,
//               width: 70,
//               decoration: BoxDecoration(
//                   border: Border.all(color: FColors.light),
//                   borderRadius: BorderRadius.circular(70),
//                   color: FColors.light,
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.grey[400]!,
//                         blurRadius: 3.0,
//                         blurStyle: BlurStyle.normal),
//                   ]),
//               child: Icon(
//                 icon,
//                 size: name == "More" || name == "Less" ? 70 : 30,
//                 color: FColors.textHeader,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 8.0, bottom: 16),
//               child: Text(
//                 name,
//                 textAlign: TextAlign.center,
//                 style:
//                     const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//               ),
//             ),
//           ]),
//     );
//   }
// }
