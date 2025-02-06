import 'dart:convert';

class MockLoginData {
  mockADIDLoginResponse() {
    var data = {
      "LoginData": null,
      "ResponseMessage": null,
      "ReturnStatus": 2,
      "isIMEIExists": 1
    };
    return json.encode(data);
  }

  mockfpnLoginData() {
    var data = {
      "ResponseMessage": "",
      "ReturnStatus": 2,
      "FPNLoginData": {
        "CurrentLoginDate": "18 Jan 2024 22:15:45:870",
        "EmpCode": "A9086",
        "EmpName": "Amogh Samant",
        "LastLoginDate": "27 Nov 2023 11:39:04:807",
        "Profile": "IT Finance Team"
      },
      "isIMEIExists": 1
    };
    return json.encode(data);
  }

  mockIcartLoginData() {
    var data = {
      "ResponseMessage": "",
      "ReturnStatus": 2,
      "data": {
        "ChangeApproverReason": [
          "Approver is on Leave",
          "Supervisor in Meeting/Training",
          "Other"
        ],
        "EmpName": "Vishal Muttoo",
        "ProfileDetail": [
          {
            "Hardware": {
              "BulkApproval": false,
              "Filter": false,
              "QueryFeedback": false,
              "SendEmailNotification": false
            },
            "Profile": "User",
            "Software": {
              "BulkApproval": false,
              "Filter": false,
              "QueryFeedback": false,
              "SendEmailNotification": false
            }
          },
          {
            "Hardware": {
              "BulkApproval": true,
              "Filter": true,
              "QueryFeedback": true,
              "SendEmailNotification": true
            },
            "Profile": "BPRG3",
            "Software": null
          }
        ],
        "UserProfile": ["User", "BPRG3"],
        "iCartToken": "a86a754e-d838-4654-beff-b92a7764485b"
      }
    };
    return json.encode(data);
  }

  mockISACLogin() {
    var data = {
      "LoginData": {
        "ApproverID": 0,
        "BranchCode": "04989",
        "BranchId": 3811,
        "BranchName": "KANJUR MARG",
        "CompanyId": 4,
        "CompanyName": "HDFC Bank",
        "CompanyTypeId": 1,
        "CompanyTypeName": "Primary",
        "CostCode": "00069",
        "CostCodeId": 54,
        "CostCodeIdList": "54,240,240",
        "CostCodeList": "00000,00069",
        "CostCodeNameList": "WB Business Solution Group,NANA",
        "CostName": "WB Business Solution Group",
        "ENC_ApproverID": null,
        "EmailFrom": null,
        "EmailId": "abhishekv.parab@hdfcbank.com",
        "EmailTo": null,
        "Email_Body": null,
        "Email_Subject": null,
        "EmpActiveDirectoryId": "a9086",
        "EmpCode": "A9086",
        "EmpName": "Amogh Samant",
        "FormID": 0,
        "IPAddress": null,
        "IdentityStoreID": 18129,
        "IsModifyRequest": true,
        "IsNewRequestCreation": true,
        "IsRequestWorkFlow": true,
        "OwnerEmail": null,
        "RequestID": 0,
        "SessionTimeOut": 15,
        "SupervisorEmpCode": "A21308",
        "Token": "E5A2D7CC-757C-4721-A00B-5B23CE90948C",
        "UserId": null,
        "iSacPword": null
      },
      "ResponseMessage": null,
      "ReturnStatus": 2,
      "isIMEIExists": 1
    };
    return json.encode(data);
  }
}
