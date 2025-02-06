import 'dart:convert';

class MockPendingData {
  mockISACCount() {
    var res = {
      "PendingCount": 179,
      "ResponseMessage": "Success",
      "ReturnStatus": 2,
      "UserDetails": {
        "BranchCode": "04989",
        "BranchName": "KANJUR MARG",
        "EmailId": "arun@hdfcbank.com",
        "EmpName": "ARUN NEGI"
      }
    };
    return json.encode(res);
  }

  mockICartCount() {
    var res = {
      "PendingCount": 152,
      "ResponseMessage": "Success",
      "ReturnStatus": 2
    };
    return json.encode(res);
  }

  mockIApprovalCount() {
    var res = {"ResponseMessage": "", "ReturnStatus": 2, "PendingCount": "124"};
    return json.encode(res);
  }
}
