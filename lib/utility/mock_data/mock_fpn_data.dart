import 'dart:convert';

class MockFPNData {
  mockDashboard() {
    var res = {
      "ResponseMessage": "",
      "ReturnStatus": 2,
      "DashboardData": {
        "AwaitingFeedbackRequestCount": 3,
        "FPNAuthorizedCount": 37,
        "FPNFeedbackCount": 1,
        "FPNLockedCount": 5,
        "FPNPendingCount": 28,
        "FPNRejectedCount": 9
      },
      "Role": "User"
    };
    return json.encode(res);
  }

  mockRequestList() {
    var data = {
      "ResponseMessage": "",
      "ReturnStatus": 2,
      "data": [
        {
          "CashFlowAmount": "5,260.79",
          "FPNAmount": "5,260.79",
          "FPNCategory": "Run the bank",
          "FPNNumber": "FPN30NOV2023001568",
          "FPNSubCategory": "HW AMC Tool FPN",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription": "Hardware AMC",
          "ProjectName": "Hardware AMC",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "5,260.79",
          "FPNAmount": "5,260.79",
          "FPNCategory": "Run the bank",
          "FPNNumber": "FPN30NOV2023001567",
          "FPNSubCategory": "HW AMC Tool FPN",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription": "Hardware AMC",
          "ProjectName": "Hardware AMC",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "5,260.79",
          "FPNAmount": "5,260.79",
          "FPNCategory": "Run the bank",
          "FPNNumber": "FPN30NOV2023001566",
          "FPNSubCategory": "HW AMC Tool FPN",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription": "Hardware AMC",
          "ProjectName": "Hardware AMC",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "5,260.79",
          "FPNAmount": "5,260.79",
          "FPNCategory": "Run the bank",
          "FPNNumber": "FPN29NOV2023001563",
          "FPNSubCategory": "HW AMC Tool FPN",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription": "Hardware AMC",
          "ProjectName": "Hardware AMC",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "5,260.79",
          "FPNAmount": "5,260.79",
          "FPNCategory": "Run the bank",
          "FPNNumber": "FPN29NOV2023001561",
          "FPNSubCategory": "HW AMC Tool FPN",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription": "Hardware AMC",
          "ProjectName": "Hardware AMC",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "5,260.79",
          "FPNAmount": "5,260.79",
          "FPNCategory": "Run the bank",
          "FPNNumber": "FPN29NOV2023001560",
          "FPNSubCategory": "HW AMC Tool FPN",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription": "Hardware AMC",
          "ProjectName": "Hardware AMC",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "5,260.79",
          "FPNAmount": "5,260.79",
          "FPNCategory": "Run the bank",
          "FPNNumber": "FPN29NOV2023001559",
          "FPNSubCategory": "HW AMC Tool FPN",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription": "Hardware AMC",
          "ProjectName": "Hardware AMC",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "5,260.79",
          "FPNAmount": "5,260.79",
          "FPNCategory": "Run the bank",
          "FPNNumber": "FPN29NOV2023001558",
          "FPNSubCategory": "HW AMC Tool FPN",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription": "Hardware AMC",
          "ProjectName": "Hardware AMC",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "10,000.00",
          "FPNAmount": "10,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN28NOV2023001557",
          "FPNSubCategory": "Cloud hosting charges",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription":
              "Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content.",
          "ProjectName": "tetst",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "100.00",
          "FPNAmount": "100.00",
          "FPNCategory": "IT for IT",
          "FPNNumber": "FPN25JUL2023001542",
          "FPNSubCategory": "Capacity Upgrade",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription": "twt",
          "ProjectName": "TEST28JUN",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "500.00",
          "FPNAmount": "500.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN28APR2023001414",
          "FPNSubCategory": "Cloud hosting charges",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription": "Testing Category - Cloud Hosting Charges",
          "ProjectName": "Test1",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "10,000.00",
          "FPNAmount": "10,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN27JAN2023001391",
          "FPNSubCategory": "Cloud hosting charges",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription":
              "Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content.",
          "ProjectName": "tetst",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "10,000.00",
          "FPNAmount": "10,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN11JAN2023001375",
          "FPNSubCategory": "Cloud hosting charges",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription":
              "Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content.",
          "ProjectName": "tetst",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "10,000.00",
          "FPNAmount": "10,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN11JAN2023001373",
          "FPNSubCategory": "Cloud hosting charges",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription":
              "Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content.",
          "ProjectName": "tetst",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "10,000.00",
          "FPNAmount": "10,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN11JAN2023001372",
          "FPNSubCategory": "Cloud hosting charges",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription":
              "Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content.",
          "ProjectName": "tetst",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "10,000.00",
          "FPNAmount": "10,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN11JAN2023001371",
          "FPNSubCategory": "Cloud hosting charges",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription":
              "Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content.",
          "ProjectName": "tetst",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "10,000.00",
          "FPNAmount": "10,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN06JAN2023001363",
          "FPNSubCategory": "Cloud hosting charges",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription":
              "Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content.",
          "ProjectName": "tetst",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "10,000.00",
          "FPNAmount": "10,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN06JAN2023001361",
          "FPNSubCategory": "Cloud hosting charges",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription":
              "Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content.",
          "ProjectName": "tetst",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "10,000.00",
          "FPNAmount": "10,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN06JAN2023001360",
          "FPNSubCategory": "Cloud hosting charges",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription":
              "Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content.",
          "ProjectName": "tetst",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "10,000.00",
          "FPNAmount": "10,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN06JAN2023001359",
          "FPNSubCategory": "Cloud hosting charges",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription":
              "Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content.",
          "ProjectName": "tetst",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "10,000.00",
          "FPNAmount": "10,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN06JAN2023001358",
          "FPNSubCategory": "Cloud hosting charges",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription":
              "Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content.",
          "ProjectName": "tetst",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "10,000.00",
          "FPNAmount": "10,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN05JAN2023001355",
          "FPNSubCategory": "Capacity upgrade/NBR",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription": "pppp",
          "ProjectName": "pppp",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "10,000.00",
          "FPNAmount": "10,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN05JAN2023001354",
          "FPNSubCategory": "Capacity upgrade/NBR",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription": "pppp",
          "ProjectName": "pppp",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "5,000.00",
          "FPNAmount": "5,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN13OCT2022001205",
          "FPNSubCategory": "Capacity upgrade/NBR",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription":
              "Vendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/P",
          "ProjectName":
              "Vendor Onsite Support Cost/Professional (Resources or services taken exclus",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "5,000.00",
          "FPNAmount": "5,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN13OCT2022001204",
          "FPNSubCategory": "Capacity upgrade/NBR",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription":
              "Vendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/P",
          "ProjectName":
              "Vendor Onsite Support Cost/Professional (Resources or services taken exclus",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "5,000.00",
          "FPNAmount": "5,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN13OCT2022001203",
          "FPNSubCategory": "Capacity upgrade/NBR",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription":
              "Vendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/P",
          "ProjectName":
              "Vendor Onsite Support Cost/Professional (Resources or services taken exclus",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "5,000.00",
          "FPNAmount": "5,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN13OCT2022001202",
          "FPNSubCategory": "Capacity upgrade/NBR",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription":
              "Vendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/P",
          "ProjectName":
              "Vendor Onsite Support Cost/Professional (Resources or services taken exclus",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        },
        {
          "CashFlowAmount": "5,000.00",
          "FPNAmount": "5,000.00",
          "FPNCategory": "Grow the bank",
          "FPNNumber": "FPN13OCT2022001200",
          "FPNSubCategory": "Capacity upgrade/NBR",
          "FeedbackText": "",
          "FinConAnalystRemark": "",
          "NonCashFlowAmount": "0.00",
          "ProjectDescription":
              "Vendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/Professional (Resources or services taken exclusively until the project go-live)\nVendor Onsite Support Cost/P",
          "ProjectName":
              "Vendor Onsite Support Cost/Professional (Resources or services taken exclus",
          "ReceiverEmpCode": "P24073",
          "UserLevel": "Recommended By"
        }
      ]
    };
    return json.encode(data);
  }

  mockRequestDetail() {
    var data = {
      "ResponseMessage": "",
      "ReturnStatus": 2,
      "FpnNo": "FPN16SEP2024011564",
      "RequestDetails": {
        "ApplicationDetails": {
          "DetailList": [
            {
              "Amount": "1,00,000.00",
              "AppName": "APPID-560073-Tata Outstanding Reports",
              "AppOwnerEmpCode": "S1233",
              "AppOwnerName": "S1233-Shriram Iyer",
              "BusinessFHEmpCode": "S1233",
              "BusinessFHName": "S1233-Shriram Iyer",
              "Count": "5",
              "ExecutionOwnerEmpCode": "S1233",
              "ExecutionOwnerName": "S1233-Shriram Iyer",
              "ProjectManager": "S1233-Shriram Iyer",
              "VendorName": "TATA COMMUNICATIONS LIMITED"
            }
          ],
          "TotalAmount": "1,00,000.00"
        },
        "AuditTrail": [
          {
            "ActionDateTime": "16-Sep-2024 18:22:13",
            "ActorCode": "P14416",
            "ActorName": "Pratik Mehta",
            "AuditRemark": "Approved",
            "Status": "Approved",
            "StatusColor": {
              "knownColor": 0,
              "name": null,
              "state": 0,
              "value": 0
            }
          },
          {
            "ActionDateTime": "16-Sep-2024 18:21:38",
            "ActorCode": "A0019",
            "ActorName": "Ashish Parthasarthy",
            "AuditRemark": "Approved",
            "Status": "Approved",
            "StatusColor": {
              "knownColor": 0,
              "name": null,
              "state": 0,
              "value": 0
            }
          },
          {
            "ActionDateTime": "16-Sep-2024 18:20:54",
            "ActorCode": "S11339",
            "ActorName": "Shoumen Mallick",
            "AuditRemark": "Approved",
            "Status": "Approved",
            "StatusColor": {
              "knownColor": 0,
              "name": null,
              "state": 0,
              "value": 0
            }
          },
          {
            "ActionDateTime": "16-Sep-2024 18:20:04",
            "ActorCode": "A9086",
            "ActorName": "Amogh Samant",
            "AuditRemark": "Approved",
            "Status": "Approved",
            "StatusColor": {
              "knownColor": 0,
              "name": null,
              "state": 0,
              "value": 0
            }
          },
          {
            "ActionDateTime": "16-Sep-2024 18:19:24",
            "ActorCode": "M2148",
            "ActorName": "Mehul Mahajan",
            "AuditRemark": "Approved",
            "Status": "Approved",
            "StatusColor": {
              "knownColor": 0,
              "name": null,
              "state": 0,
              "value": 0
            }
          },
          {
            "ActionDateTime": "16-Sep-2024 12:39:16",
            "ActorCode": "P24073",
            "ActorName": "Prashant Monde",
            "AuditRemark": "",
            "Status": "Initiated",
            "StatusColor": {
              "knownColor": 0,
              "name": null,
              "state": 0,
              "value": 0
            }
          }
        ],
        "BenefitDetails": null,
        "BenefitDetails_New": {
          "IncrementalVolEffortList": [
            {
              "AvgTicketSize_Existing": "10.00",
              "AvgTicketSize_Expected": "10.00",
              "IncAnualAvgBalance_Expected": "10.00",
              "IncRevenuePA_Expected": "10.00",
              "ProductName": "Assets - WS",
              "ToBeTrackFrom": "Phase 2+ 90 days",
              "UnitPerMonth_Existing": "10.00",
              "UnitPerMonth_Expected": "20.00"
            }
          ],
          "ReducedEffortList": null
        },
        "BudgetDetailsData": {
          "BudgetDetails": [
            {
              "AvailableAmt": "68,86,65,299.00",
              "Desciption": "For tracking of Non Budgeted Spend of FY 2023-24",
              "RequestedAmt": "1,00,000.00",
              "SerialNo": "NON-BUDGETED",
              "Type": "Non-Budgeted",
              "UtilizedAmt": "3,17,55,08,804.00",
              "Value": "3,86,41,74,103.00"
            }
          ],
          "TotalBudgetAmount": "1,00,000.00"
        },
        "CaseApprovalMatrix": {
          "AnalystRemark": null,
          "Approved": {
            "Level1": [
              {
                "Code": "A0019",
                "MatrixColor": "green",
                "Name": "Ashish  Parthasarthy",
                "Status": "APPROVED"
              }
            ],
            "Level2": null,
            "Level3": null,
            "Level4": null,
            "Level5": null
          },
          "Concurred": {
            "Level1": [
              {
                "Code": "S11339",
                "MatrixColor": "green",
                "Name": "Shoumen Bimal Mallick",
                "Status": "APPROVED"
              }
            ],
            "Level2": null,
            "Level3": null,
            "Level4": null,
            "Level5": null
          },
          "FinconAmt": null,
          "FinconAnalyst": null,
          "FinconApprover": {
            "Level1": [
              {
                "Code": "P14416",
                "MatrixColor": "green",
                "Name": "Pratik Mehta",
                "Status": "APPROVED"
              }
            ],
            "Level2": null
          },
          "FinconApprover2": {
            "Level1": [
              {
                "Code": "V8779",
                "MatrixColor": "blue",
                "Name": "Victor Nadar",
                "Status": "PENDING"
              }
            ]
          },
          "FinconApprover3": null,
          "FinconOldAmt": null,
          "MDApprover": null,
          "Recommended": {
            "Level1": [
              {
                "Code": "M2148",
                "MatrixColor": "green",
                "Name": "Mehul Ramesh Mahajan",
                "Status": "APPROVED"
              }
            ],
            "Level2": null,
            "Level3": null,
            "Level4": null,
            "Level5": null
          },
          "Reviewed": {
            "Level1": [
              {
                "Code": "A9086",
                "MatrixColor": "green",
                "Name": "Amogh Sushil Samant",
                "Status": "APPROVED"
              }
            ],
            "Level2": null,
            "Level3": null,
            "Level4": null,
            "Level5": null
          }
        },
        "CaseApprovalMatrixNew": null,
        "CaseDetails": {
          "Ariba": "Not Applicable",
          "AutionRefNo": "",
          "CabChangesApproved": "-Select-",
          "FpnDescription": "",
          "Justification": "OEM dependency",
          "PNSIChange": "No",
          "ParentFpnAmount": "0.00",
          "ParentFpnAmtUtilized": "0.00",
          "ParentFpnNo": "",
          "ParentFpnProjectName": "",
          "RefNo": "",
          "SpecifyChangeInScope": "",
          "SupplementaryFpn": "No",
          "TentativeDate": "04-Jun-2024",
          "ValidJustification": ""
        },
        "CostCenterDetails": [
          {
            "CostCenterCode": "0010",
            "CostCenterName": "Retail Banking-Marketing",
            "CostCenterPercentage": "100.00"
          }
        ],
        "FYIFPNDetails": null,
        "Feedback": null,
        "FinconDropdownData": {
          "BenefitTypes": [
            {
              "Label": "Growth in Business",
              "Value": {"TextValue": "Growth in Business", "TextValue_Id": "1"}
            },
            {
              "Label": "Savings in Existing Cost",
              "Value": {
                "TextValue": "Savings in Existing Cost",
                "TextValue_Id": "2"
              }
            },
            {
              "Label": "Release in Existing Manpower",
              "Value": {
                "TextValue": "Release in Existing Manpower",
                "TextValue_Id": "3"
              }
            },
            {
              "Label": "Customer Delight",
              "Value": {"TextValue": "Customer Delight", "TextValue_Id": "4"}
            }
          ],
          "FPNCategoies": [
            {
              "Label": "Run the bank",
              "SubCategories": [
                {
                  "Label": "AMC",
                  "Value": {"TextValue": "AMC", "TextValue_Id": "44"}
                },
                {
                  "Label": "AMC Tool FPN",
                  "Value": {"TextValue": "AMC Tool FPN", "TextValue_Id": "46"}
                },
                {
                  "Label": "HW AMC Tool FPN",
                  "Value": {
                    "TextValue": "HW AMC Tool FPN",
                    "TextValue_Id": "50"
                  }
                },
                {
                  "Label": "Managed Services",
                  "Value": {
                    "TextValue": "Managed Services",
                    "TextValue_Id": "52"
                  }
                },
                {
                  "Label": "Technology Obsolescence (Revex)",
                  "Value": {
                    "TextValue": "Technology Obsolescence (Revex)",
                    "TextValue_Id": "71"
                  }
                },
                {
                  "Label": "Technology Obsolescence (Capex)",
                  "Value": {
                    "TextValue": "Technology Obsolescence (Capex)",
                    "TextValue_Id": "72"
                  }
                },
                {
                  "Label": "Capacity Upgrade (Revex)",
                  "Value": {
                    "TextValue": "Capacity Upgrade (Revex)",
                    "TextValue_Id": "73"
                  }
                },
                {
                  "Label": "Capacity Upgrade (Capex)",
                  "Value": {
                    "TextValue": "Capacity Upgrade (Capex)",
                    "TextValue_Id": "74"
                  }
                },
                {
                  "Label": "R & M",
                  "Value": {"TextValue": "R & M", "TextValue_Id": "75"}
                },
                {
                  "Label": "Colo Charges",
                  "Value": {"TextValue": "Colo Charges", "TextValue_Id": "76"}
                },
                {
                  "Label": "Telecom",
                  "Value": {"TextValue": "Telecom", "TextValue_Id": "77"}
                },
                {
                  "Label": "Licenses and subscription",
                  "Value": {
                    "TextValue": "Licenses and subscription",
                    "TextValue_Id": "78"
                  }
                },
                {
                  "Label": "Cloud hosting charges",
                  "Value": {
                    "TextValue": "Cloud hosting charges",
                    "TextValue_Id": "79"
                  }
                },
                {
                  "Label": "Prof. Services",
                  "Value": {
                    "TextValue": "Prof. Services",
                    "TextValue_Id": "104"
                  }
                },
                {
                  "Label":
                      "Managed Services\/Staff Augmentation\/IT Outsourcing",
                  "Value": {
                    "TextValue":
                        "Managed Services\/Staff Augmentation\/IT Outsourcing",
                    "TextValue_Id": "112"
                  }
                },
                {
                  "Label": "SaaS",
                  "Value": {"TextValue": "SaaS", "TextValue_Id": "113"}
                }
              ],
              "Value": {"TextValue": "Run the bank", "TextValue_Id": "12"}
            },
            {
              "Label": "Grow the bank",
              "SubCategories": [
                {
                  "Label": "Business improvement",
                  "Value": {
                    "TextValue": "Business improvement",
                    "TextValue_Id": "54"
                  }
                },
                {
                  "Label": "Capacity upgrade\/NBR",
                  "Value": {
                    "TextValue": "Capacity upgrade\/NBR",
                    "TextValue_Id": "86"
                  }
                },
                {
                  "Label": "Enhancements",
                  "Value": {"TextValue": "Enhancements", "TextValue_Id": "87"}
                },
                {
                  "Label": "NSI",
                  "Value": {"TextValue": "NSI", "TextValue_Id": "88"}
                },
                {
                  "Label": "Process Improvement\/Automation",
                  "Value": {
                    "TextValue": "Process Improvement\/Automation",
                    "TextValue_Id": "89"
                  }
                },
                {
                  "Label": "Licenses and subscription",
                  "Value": {
                    "TextValue": "Licenses and subscription",
                    "TextValue_Id": "90"
                  }
                },
                {
                  "Label": "Cloud hosting charges",
                  "Value": {
                    "TextValue": "Cloud hosting charges",
                    "TextValue_Id": "91"
                  }
                }
              ],
              "Value": {"TextValue": "Grow the bank", "TextValue_Id": "13"}
            },
            {
              "Label": "Innovation & Strategic",
              "SubCategories": [
                {
                  "Label": "NSI\/POC",
                  "Value": {"TextValue": "NSI\/POC", "TextValue_Id": "92"}
                },
                {
                  "Label": "Enhancements\/Change requests",
                  "Value": {
                    "TextValue": "Enhancements\/Change requests",
                    "TextValue_Id": "93"
                  }
                },
                {
                  "Label": "Consultancy",
                  "Value": {"TextValue": "Consultancy", "TextValue_Id": "94"}
                },
                {
                  "Label": "Prof. Services",
                  "Value": {"TextValue": "Prof. Services", "TextValue_Id": "95"}
                },
                {
                  "Label": "Licenses and subscription",
                  "Value": {
                    "TextValue": "Licenses and subscription",
                    "TextValue_Id": "96"
                  }
                },
                {
                  "Label": "Cloud hosting charges",
                  "Value": {
                    "TextValue": "Cloud hosting charges",
                    "TextValue_Id": "97"
                  }
                },
                {
                  "Label":
                      "Managed Services\/Staff Augmentation\/IT Outsourcing",
                  "Value": {
                    "TextValue":
                        "Managed Services\/Staff Augmentation\/IT Outsourcing",
                    "TextValue_Id": "114"
                  }
                },
                {
                  "Label": "SaaS",
                  "Value": {"TextValue": "SaaS", "TextValue_Id": "115"}
                }
              ],
              "Value": {
                "TextValue": "Innovation & Strategic",
                "TextValue_Id": "14"
              }
            },
            {
              "Label": "Security",
              "SubCategories": [
                {
                  "Label": "NSI",
                  "Value": {"TextValue": "NSI", "TextValue_Id": "80"}
                },
                {
                  "Label": "Enhancements\/Change requests",
                  "Value": {
                    "TextValue": "Enhancements\/Change requests",
                    "TextValue_Id": "81"
                  }
                },
                {
                  "Label": "Licenses and subscription",
                  "Value": {
                    "TextValue": "Licenses and subscription",
                    "TextValue_Id": "82"
                  }
                },
                {
                  "Label": "Technology Obsolescence",
                  "Value": {
                    "TextValue": "Technology Obsolescence",
                    "TextValue_Id": "83"
                  }
                },
                {
                  "Label": "Managed Services",
                  "Value": {
                    "TextValue": "Managed Services",
                    "TextValue_Id": "84"
                  }
                },
                {
                  "Label": "Cloud hosting charges",
                  "Value": {
                    "TextValue": "Cloud hosting charges",
                    "TextValue_Id": "85"
                  }
                },
                {
                  "Label": "Prof. Services",
                  "Value": {
                    "TextValue": "Prof. Services",
                    "TextValue_Id": "105"
                  }
                },
                {
                  "Label": "AMC",
                  "Value": {"TextValue": "AMC", "TextValue_Id": "106"}
                },
                {
                  "Label":
                      "Managed Services\/Staff Augmentation\/IT Outsourcing",
                  "Value": {
                    "TextValue":
                        "Managed Services\/Staff Augmentation\/IT Outsourcing",
                    "TextValue_Id": "116"
                  }
                },
                {
                  "Label": "SaaS",
                  "Value": {"TextValue": "SaaS", "TextValue_Id": "117"}
                }
              ],
              "Value": {"TextValue": "Security", "TextValue_Id": "15"}
            },
            {
              "Label": "Regulatory",
              "SubCategories": [
                {
                  "Label": "Consultancy",
                  "Value": {"TextValue": "Consultancy", "TextValue_Id": "66"}
                },
                {
                  "Label": "NSI",
                  "Value": {"TextValue": "NSI", "TextValue_Id": "68"}
                },
                {
                  "Label": "Enhancements\/Change requests",
                  "Value": {
                    "TextValue": "Enhancements\/Change requests",
                    "TextValue_Id": "69"
                  }
                },
                {
                  "Label": "Prof. Services",
                  "Value": {"TextValue": "Prof. Services", "TextValue_Id": "70"}
                },
                {
                  "Label":
                      "Managed Services\/Staff Augmentation\/IT Outsourcing",
                  "Value": {
                    "TextValue":
                        "Managed Services\/Staff Augmentation\/IT Outsourcing",
                    "TextValue_Id": "118"
                  }
                },
                {
                  "Label": "SaaS",
                  "Value": {"TextValue": "SaaS", "TextValue_Id": "119"}
                }
              ],
              "Value": {"TextValue": "Regulatory", "TextValue_Id": "16"}
            },
            {
              "Label": "IT for IT",
              "SubCategories": [
                {
                  "Label": "NSI\/POC",
                  "Value": {"TextValue": "NSI\/POC", "TextValue_Id": "67"}
                },
                {
                  "Label": "Enhancements\/Change requests",
                  "Value": {
                    "TextValue": "Enhancements\/Change requests",
                    "TextValue_Id": "98"
                  }
                },
                {
                  "Label": "Licenses and subscription",
                  "Value": {
                    "TextValue": "Licenses and subscription",
                    "TextValue_Id": "99"
                  }
                },
                {
                  "Label": "Cloud hosting charges",
                  "Value": {
                    "TextValue": "Cloud hosting charges",
                    "TextValue_Id": "100"
                  }
                },
                {
                  "Label": "Capacity Upgrade",
                  "Value": {
                    "TextValue": "Capacity Upgrade",
                    "TextValue_Id": "101"
                  }
                },
                {
                  "Label": "Consultancy",
                  "Value": {"TextValue": "Consultancy", "TextValue_Id": "102"}
                },
                {
                  "Label": "Prof. Services",
                  "Value": {
                    "TextValue": "Prof. Services",
                    "TextValue_Id": "103"
                  }
                },
                {
                  "Label":
                      "Managed Services\/Staff Augmentation\/IT Outsourcing",
                  "Value": {
                    "TextValue":
                        "Managed Services\/Staff Augmentation\/IT Outsourcing",
                    "TextValue_Id": "120"
                  }
                },
                {
                  "Label": "SaaS",
                  "Value": {"TextValue": "SaaS", "TextValue_Id": "121"}
                }
              ],
              "Value": {"TextValue": "IT for IT", "TextValue_Id": "17"}
            },
            {
              "Label": "Business related spend",
              "SubCategories": [
                {
                  "Label": "Licenses and subscription",
                  "Value": {
                    "TextValue": "Licenses and subscription",
                    "TextValue_Id": "107"
                  }
                },
                {
                  "Label": "SaaS",
                  "Value": {"TextValue": "SaaS", "TextValue_Id": "108"}
                },
                {
                  "Label": "NSI",
                  "Value": {"TextValue": "NSI", "TextValue_Id": "109"}
                },
                {
                  "Label":
                      "Managed Services\/Staff Augmentation\/IT Outsourcing",
                  "Value": {
                    "TextValue":
                        "Managed Services\/Staff Augmentation\/IT Outsourcing",
                    "TextValue_Id": "110"
                  }
                },
                {
                  "Label": "Prof. Services",
                  "Value": {
                    "TextValue": "Prof. Services",
                    "TextValue_Id": "111"
                  }
                }
              ],
              "Value": {
                "TextValue": "Business related spend",
                "TextValue_Id": "18"
              }
            }
          ],
          "ProjectRelevanceList": [
            {
              "Label": "Existing",
              "SubCategories": [
                {
                  "Label": "Supplementary",
                  "Value": {"TextValue": "Supplementary", "TextValue_Id": "1"}
                },
                {
                  "Label": "Additional",
                  "Value": {"TextValue": "Additional", "TextValue_Id": "3"}
                },
                {
                  "Label": "Existing",
                  "Value": {"TextValue": "Existing", "TextValue_Id": "4"}
                },
                {
                  "Label": "Rejected",
                  "Value": {"TextValue": "Rejected", "TextValue_Id": "5"}
                }
              ],
              "Value": {"TextValue": "Existing", "TextValue_Id": "1"}
            },
            {
              "Label": "New",
              "SubCategories": [
                {
                  "Label": "Supplementary",
                  "Value": {"TextValue": "Supplementary", "TextValue_Id": "1"}
                },
                {
                  "Label": "Additional",
                  "Value": {"TextValue": "Additional", "TextValue_Id": "3"}
                },
                {
                  "Label": "No",
                  "Value": {"TextValue": "No", "TextValue_Id": "2"}
                }
              ],
              "Value": {"TextValue": "New", "TextValue_Id": "2"}
            }
          ]
        },
        "IsFincon": true,
        "ProcessAttachmentDetails": {
          "Competition": "test",
          "Current": "test",
          "DownloadLink": "Uploads\\04062024154801\\Scripts.zip",
          "New": "test"
        },
        "ProjectDetails": {
          "AMCRemark": "",
          "CashFlow": "1,00,000.00",
          "CashFlowWords": "One Lakhs  Only",
          "ConceptInitiatorDate": "04-Jun-2024",
          "ConceptInitiatorEmpCode": "A12337",
          "ConceptInitiatorName": "A12337-Adesh Kumar",
          "Days": "1",
          "FpnAmount": "1,00,000.00",
          "FpnAmountWords": "One Lakhs ",
          "FpnCategory": "Grow the bank",
          "FpnSubCategory": "Cloud hosting charges",
          "FunctionHeadEmpCode": "S46256",
          "FunctionHeadName": "S46256-Sujatha Mohan",
          "FunctionName":
              "IT - Business Support Group - Credit Cards (BSG Credit Cards)",
          "GroupHeadEmpCode": "J0001",
          "GroupHeadName": "J0001-Jimmy Tata",
          "IsHardwareAMCVAlidated": "NA",
          "NSIProject": "No",
          "NoOfPhase": [
            {
              "Days": "3",
              "Phase": "Estimated Days to Go Live for Phase 1* - 3"
            },
            {"Days": "1", "Phase": "Estimated Days to Go Live for Phase 2* - 1"}
          ],
          "NonCashFlow": "0.00",
          "NonCashFlowWords": "",
          "PPMProjectID": "",
          "ProjBudgetCategory":
              "Professional \/ Outsourcing \/ Managed Services",
          "ProjectDescription": "projt Fincon 3",
          "ProjectId": "123",
          "ProjectName": "projt Fincon 3",
          "ProjectRelevance": "New"
        },
        "SendbackDetails": {
          "Allowsendback": true,
          "FinconSendbackAmt": "0.00",
          "OriginalFPNAmt": "1,00,000.00",
          "UserSendbackAmt": "0.00"
        }
      },
      "UserId": "v8779"
    };
    return json.encode(data);
  }
}
