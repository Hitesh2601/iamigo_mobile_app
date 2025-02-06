import 'dart:convert';
import 'package:push_notification/features/iApproval/models/tco_details_response.dart';
import 'package:push_notification/utility/constants/session.dart';
import 'package:push_notification/utility/constants/url_configuration.dart';
import 'package:push_notification/utility/helpers/helper_functions.dart';
import 'package:push_notification/utility/network/http_client.dart';
import 'package:flutter/cupertino.dart';

class FpnTcoDetailProvider with ChangeNotifier {
  List<VNewDatum> tcoList = [];
  List<String> fixedColumnList = [];
  List<String> fixedHeaderRowList = [];
  List<List<String>> nonFixedColumnRowList = [];
  Future<TcoDetailResponse> getTCODetailtData(Object body) async {
    NetworkClientManager networkClientManager = NetworkClientManager();
    var response = await networkClientManager.post(
        '${URLConfiguration().fpnBaseUrl}TCODetail', body);
    TcoDetailResponse res =
        TcoDetailResponse.fromJson(json.decode(response.body));
    if (res.returnStatus == 2) {
      tcoList = res.vNewData
          .where((x) => x.displayGridStyle != DisplayGridStyle.TEXT)
          .toList();
      fixedColumnList = generateFixedColumnList(tcoList);
      fixedHeaderRowList = generateFixedHeaderRowList(res.yearsCount);
      nonFixedColumnRowList = generateNonFixedDataList(tcoList, res.yearsCount);
      notifyListeners();
      return res;
    } else if (res.returnStatus == 4) {
      SessionManagement.expireUserSession();
    } else {
      HelperFunctions.showAlert("AMIGO", res.responseMessage!);
    }
    return res;
  }

  List<String> generateFixedColumnList(List<VNewDatum> list) {
    List<String> fixedColumnList = [];
    try {
      fixedColumnList.clear();
      list.sort(((a, b) => a.serialNo.compareTo(b.serialNo)));
      for (var dt in list) {
        fixedColumnList.add('${dt.sortOrder!} ${dt.totalExpenditureCost!}');
      }
    } catch (e) {
      // HelperFunctions.showAlert("System Error", e.toString());
    }
    return fixedColumnList;
  }

  List<String> generateFixedHeaderRowList(int yearCount) {
    List<String> fixedHeaderRowList = [];
    fixedHeaderRowList.clear();
    fixedHeaderRowList.add('Total Amount');
    for (var i = 1; i <= yearCount; i++) {
      fixedHeaderRowList.add('Year $i');
    }
    return fixedHeaderRowList;
  }

  List<List<String>> generateNonFixedDataList(
      List<VNewDatum> list, int yearsCount) {
    List<String> subList = [];
    List<List<String>> nonFixedDataList = [];
    try {
      subList.clear();
      fixedColumnList.clear();
      list.sort(((a, b) => a.serialNo.compareTo(b.serialNo)));
      if (yearsCount == 1) {
        for (var dt in list) {
          List<String> subList = [];
          subList.add(HelperFunctions.separateNumberByComma(dt.totalAmt!));
          subList.add(HelperFunctions.separateNumberByComma(dt.year1!));
          nonFixedDataList.add(subList);
        }
      } else if (yearsCount == 2) {
        for (var dt in list) {
          List<String> subList = [];
          subList.add(HelperFunctions.separateNumberByComma(dt.totalAmt!));
          subList.add(HelperFunctions.separateNumberByComma(dt.year1!));
          subList.add(HelperFunctions.separateNumberByComma(dt.year2!));

          nonFixedDataList.add(subList);
        }
      } else if (yearsCount == 3) {
        for (var dt in list) {
          List<String> subList = [];
          subList.add(HelperFunctions.separateNumberByComma(dt.totalAmt!));
          subList.add(HelperFunctions.separateNumberByComma(dt.year1!));
          subList.add(HelperFunctions.separateNumberByComma(dt.year2!));
          subList.add(HelperFunctions.separateNumberByComma(dt.year3!));

          nonFixedDataList.add(subList);
        }
      } else if (yearsCount == 4) {
        for (var dt in list) {
          List<String> subList = [];
          subList.add(HelperFunctions.separateNumberByComma(dt.totalAmt!));
          subList.add(HelperFunctions.separateNumberByComma(dt.year1!));
          subList.add(HelperFunctions.separateNumberByComma(dt.year2!));
          subList.add(HelperFunctions.separateNumberByComma(dt.year3!));
          subList.add(HelperFunctions.separateNumberByComma(dt.year4!));
          nonFixedDataList.add(subList);
        }
      } else if (yearsCount == 5) {
        for (var dt in list) {
          List<String> subList = [];
          subList.add(HelperFunctions.separateNumberByComma(dt.totalAmt!));
          subList.add(HelperFunctions.separateNumberByComma(dt.year1!));
          subList.add(HelperFunctions.separateNumberByComma(dt.year2!));
          subList.add(HelperFunctions.separateNumberByComma(dt.year3!));
          subList.add(HelperFunctions.separateNumberByComma(dt.year4!));
          subList.add(HelperFunctions.separateNumberByComma(dt.year5!));
          nonFixedDataList.add(subList);
        }
      }
    } catch (e) {
      //HelperFunctions.showAlert("System Error", e.toString());
    }

    return nonFixedDataList;
  }
}
