import 'dart:convert';

class MockICartData {
  mockDashboard() {
    var res = {
      "ResponseMessage": "",
      "ReturnStatus": 2,
      "DashboardData": [
        {
          "Approved": 367,
          "DelegatedPending": 0,
          "Pending": 31,
          "Profile": "User",
          "Rejected": 58
        },
        {
          "Approved": 3240,
          "DelegatedPending": 0,
          "Pending": 0,
          "Profile": "BPRG3",
          "Rejected": 0
        }
      ]
    };
    return json.encode(res);
  }

  mockRequestList() {
    var res = {
      "ResponseMessage": "",
      "ReturnStatus": 2,
      "Hardware": {
        "EndCount": 30,
        "FilteredRequestNo": [
          "OP050820214989038425",
          "OP040920214989038637",
          "OP080420224989041921",
          "OP180420229755003411",
          "OP290420229868000001",
          "OP290420229868000002",
          "OP040520220712000052",
          "OP230520220560000567",
          "OP230520220959000035",
          "OP210620229918000001",
          "OP210620229919000001",
          "OP220820224989042626",
          "OP220820229836000129",
          "OP040420224989039295",
          "OP040420224989039298",
          "OP040420224989039300",
          "OP040420224989039301",
          "OP040420224989039304",
          "OP040420224989039308",
          "OP040420224989039312"
        ],
        "NextApproverName": [
          {"Approver": "No-Profile"}
        ],
        "PageNo": 1,
        "RequestListHardware": [
          {
            "AddtionalInfo":
                "Selected product specification type Dot Matrix printer - DD printing already exists at Branch Code :4989",
            "Amount": "8725.00",
            "NextApproverId": "",
            "PreviousApprover": "S3031-Santosh Kotian",
            "Product": "Printer",
            "ProductSpecification": "Dot Matrix printer - DD printing",
            "RequestBy": "V9836-Vithoba Kavathankar",
            "RequestFor": "Self",
            "RequestNo": "OP050820214989038425",
            "RequestType": "New",
            "SearchListData": null,
            "iCartCid": 107426
          },
          {
            "AddtionalInfo": "",
            "Amount": "53387.00",
            "NextApproverId": "B0040",
            "PreviousApprover": "S3031-Santosh Kotian",
            "Product": "PC",
            "ProductSpecification": "High End Desktop for BTG Developer",
            "RequestBy": "P10803-Pushkar Singh",
            "RequestFor": "Self",
            "RequestNo": "OP040920214989038637",
            "RequestType": "New",
            "SearchListData": null,
            "iCartCid": 107490
          },
          {
            "AddtionalInfo":
                "Selected product specification type Bar Code Scanner already exists at Branch Code :9818",
            "Amount": "2990.00",
            "NextApproverId": "",
            "PreviousApprover": "NA",
            "Product": "Scanner",
            "ProductSpecification": "Bar Code Scanner",
            "RequestBy": "S3031-Santosh Kotian",
            "RequestFor": "Self",
            "RequestNo": "OP080420224989041921",
            "RequestType": "New",
            "SearchListData": null,
            "iCartCid": 120874
          },
          {
            "AddtionalInfo":
                "Selected product specification type Dot Matrix printer - DD printing already exists at Branch Code :9755",
            "Amount": "8725.00",
            "NextApproverId": "",
            "PreviousApprover": "NA",
            "Product": "Printer",
            "ProductSpecification": "Dot Matrix printer - DD printing",
            "RequestBy": "V2512-Venkatesh V",
            "RequestFor": "Self",
            "RequestNo": "OP180420229755003411",
            "RequestType": "New",
            "SearchListData": null,
            "iCartCid": 120901
          },
          {
            "AddtionalInfo":
                "Selected product specification type Disbursement - Volumes upto 500 pages per day already exists at Branch Code :9868",
            "Amount": "63650.00",
            "NextApproverId": "",
            "PreviousApprover": "NA",
            "Product": "Printer",
            "ProductSpecification":
                "Disbursement - Volumes upto 500 pages per day",
            "RequestBy": "V2512-Venkatesh V",
            "RequestFor": "Self",
            "RequestNo": "OP290420229868000001",
            "RequestType": "New",
            "SearchListData": null,
            "iCartCid": 121434
          },
          {
            "AddtionalInfo":
                "Selected product specification type Disbursement - Volumes upto 500 pages per day already exists at Branch Code :9868",
            "Amount": "63650.00",
            "NextApproverId": "",
            "PreviousApprover": "NA",
            "Product": "Printer",
            "ProductSpecification":
                "Disbursement - Volumes upto 500 pages per day",
            "RequestBy": "V2512-Venkatesh V",
            "RequestFor": "Self",
            "RequestNo": "OP290420229868000002",
            "RequestType": "New",
            "SearchListData": null,
            "iCartCid": 121435
          },
          {
            "AddtionalInfo": "",
            "Amount": "0.00",
            "NextApproverId": "",
            "PreviousApprover": "NA",
            "Product": "Switch",
            "ProductSpecification": "NA",
            "RequestBy": "V2512-Venkatesh V",
            "RequestFor": "Self",
            "RequestNo": "OP040520220712000052",
            "RequestType": "Asset Movement",
            "SearchListData": null,
            "iCartCid": 121440
          },
          {
            "AddtionalInfo": "",
            "Amount": "0.00",
            "NextApproverId": "",
            "PreviousApprover": "NA",
            "Product": "Scanner",
            "ProductSpecification": "NA",
            "RequestBy": "V2512-Venkatesh V",
            "RequestFor": "Self",
            "RequestNo": "OP230520220560000567",
            "RequestType": "Asset Movement",
            "SearchListData": null,
            "iCartCid": 121484
          },
          {
            "AddtionalInfo": "",
            "Amount": "0.00",
            "NextApproverId": "",
            "PreviousApprover": "NA",
            "Product": "Printer",
            "ProductSpecification": "NA",
            "RequestBy": "V2512-Venkatesh V",
            "RequestFor": "Self",
            "RequestNo": "OP230520220959000035",
            "RequestType": "Asset Movement",
            "SearchListData": null,
            "iCartCid": 121485
          },
          {
            "AddtionalInfo": "",
            "Amount": "63650.00",
            "NextApproverId": "",
            "PreviousApprover": "NA",
            "Product": "Printer",
            "ProductSpecification":
                "Disbursement - Volumes upto 500 pages per day",
            "RequestBy": "V2512-Venkatesh V",
            "RequestFor": "Self",
            "RequestNo": "OP210620229918000001",
            "RequestType": "New",
            "SearchListData": null,
            "iCartCid": 131496
          },
          {
            "AddtionalInfo": "",
            "Amount": "5750.00",
            "NextApproverId": "",
            "PreviousApprover": "NA",
            "Product": "Scanner",
            "ProductSpecification":
                "Bio Matric Scanner for Smart Phone - Other",
            "RequestBy": "V2512-Venkatesh V",
            "RequestFor": "Self",
            "RequestNo": "OP210620229919000001",
            "RequestType": "New",
            "SearchListData": null,
            "iCartCid": 131497
          },
          {
            "AddtionalInfo": "",
            "Amount": "51000.00",
            "NextApproverId": "",
            "PreviousApprover": "S3031-Santosh Kotian",
            "Product": "Test VKK",
            "ProductSpecification": "TEST CASE HARDWARE",
            "RequestBy": "V9836-Vithoba Kavathankar",
            "RequestFor": "Self",
            "RequestNo": "OP220820224989042626",
            "RequestType": "New",
            "SearchListData": null,
            "iCartCid": 131548
          },
          {
            "AddtionalInfo": "",
            "Amount": "8725.00",
            "NextApproverId": "",
            "PreviousApprover": "S3031-Santosh Kotian",
            "Product": "Printer",
            "ProductSpecification": "Dot Matrix printer - DD printing",
            "RequestBy": "V9836-Vithoba Kavathankar",
            "RequestFor": "Self",
            "RequestNo": "OP220820229836000129",
            "RequestType": "New",
            "SearchListData": null,
            "iCartCid": 131549
          },
          {
            "AddtionalInfo":
                "Selected product specification type CTS Scanner - O/w Vol. 300 to 700 cheques per day already exists at Branch Code :0499",
            "Amount": "65945.00",
            "NextApproverId": "",
            "PreviousApprover": "V0037-Vishal Muttoo",
            "Product": "Scanner",
            "ProductSpecification":
                "CTS Scanner - O/w Vol. 300 to 700 cheques per day",
            "RequestBy": "r15202-Rajsaheb Gawankar",
            "RequestFor": "S3031-Santosh Kotian",
            "RequestNo": "OP040420224989039295",
            "RequestType": "New",
            "SearchListData": null,
            "iCartCid": 118235
          },
          {
            "AddtionalInfo":
                "Selected product specification type CTS Scanner - O/w Vol. 300 to 700 cheques per day already exists at Branch Code :0499",
            "Amount": "65945.00",
            "NextApproverId": "",
            "PreviousApprover": "V0037-Vishal Muttoo",
            "Product": "Scanner",
            "ProductSpecification":
                "CTS Scanner - O/w Vol. 300 to 700 cheques per day",
            "RequestBy": "v2512-Venkatesh V",
            "RequestFor": "S3031-Santosh Kotian",
            "RequestNo": "OP040420224989039298",
            "RequestType": "New",
            "SearchListData": null,
            "iCartCid": 118238
          },
          {
            "AddtionalInfo":
                "Selected product specification type CTS Scanner - O/w Vol. 300 to 700 cheques per day already exists at Branch Code :0499",
            "Amount": "65945.00",
            "NextApproverId": "",
            "PreviousApprover": "V0037-Vishal Muttoo",
            "Product": "Scanner",
            "ProductSpecification":
                "CTS Scanner - O/w Vol. 300 to 700 cheques per day",
            "RequestBy": "r15202-Rajsaheb Gawankar",
            "RequestFor": "S3031-Santosh Kotian",
            "RequestNo": "OP040420224989039300",
            "RequestType": "New",
            "SearchListData": null,
            "iCartCid": 118240
          },
          {
            "AddtionalInfo":
                "Selected product specification type CTS Scanner - O/w Vol. 300 to 700 cheques per day already exists at Branch Code :0499",
            "Amount": "65945.00",
            "NextApproverId": "",
            "PreviousApprover": "V0037-Vishal Muttoo",
            "Product": "Scanner",
            "ProductSpecification":
                "CTS Scanner - O/w Vol. 300 to 700 cheques per day",
            "RequestBy": "r15202-Rajsaheb Gawankar",
            "RequestFor": "S3031-Santosh Kotian",
            "RequestNo": "OP040420224989039301",
            "RequestType": "New",
            "SearchListData": null,
            "iCartCid": 118241
          },
          {
            "AddtionalInfo":
                "Selected product specification type CTS Scanner - O/w Vol. 300 to 700 cheques per day already exists at Branch Code :0499",
            "Amount": "65945.00",
            "NextApproverId": "",
            "PreviousApprover": "V0037-Vishal Muttoo",
            "Product": "Scanner",
            "ProductSpecification":
                "CTS Scanner - O/w Vol. 300 to 700 cheques per day",
            "RequestBy": "v0420-Vasant Shenoy",
            "RequestFor": "S3031-Santosh Kotian",
            "RequestNo": "OP040420224989039304",
            "RequestType": "New",
            "SearchListData": null,
            "iCartCid": 118244
          },
          {
            "AddtionalInfo":
                "Selected product specification type CTS Scanner - O/w Vol. 300 to 700 cheques per day already exists at Branch Code :0499",
            "Amount": "65945.00",
            "NextApproverId": "",
            "PreviousApprover": "V0037-Vishal Muttoo",
            "Product": "Scanner",
            "ProductSpecification":
                "CTS Scanner - O/w Vol. 300 to 700 cheques per day",
            "RequestBy": "r15202-Rajsaheb Gawankar",
            "RequestFor": "S3031-Santosh Kotian",
            "RequestNo": "OP040420224989039308",
            "RequestType": "New",
            "SearchListData": null,
            "iCartCid": 118248
          },
          {
            "AddtionalInfo":
                "Selected product specification type CTS Scanner - O/w Vol. 300 to 700 cheques per day already exists at Branch Code :0499",
            "Amount": "65945.00",
            "NextApproverId": "",
            "PreviousApprover": "V0037-Vishal Muttoo",
            "Product": "Scanner",
            "ProductSpecification":
                "CTS Scanner - O/w Vol. 300 to 700 cheques per day",
            "RequestBy": "v2512-Venkatesh V",
            "RequestFor": "S3031-Santosh Kotian",
            "RequestNo": "OP040420224989039312",
            "RequestType": "New",
            "SearchListData": null,
            "iCartCid": 118252
          }
        ],
        "StartCount": 1,
        "TotalCount": 290,
        "filter": {
          "HardwareRequestType": [
            {"Type": "New"},
            {"Type": "Asset Movement"}
          ],
          "Product": [
            {"ProductName": "Printer"},
            {"ProductName": "PC"},
            {"ProductName": "Scanner"},
            {"ProductName": "Switch"},
            {"ProductName": "Test VKK"}
          ],
          "ProductSpecification": [
            {"Specification": "Dot Matrix printer - DD printing"},
            {"Specification": "High End Desktop for BTG Developer"},
            {"Specification": "Bar Code Scanner"},
            {"Specification": "Disbursement - Volumes upto 500 pages per day"},
            {"Specification": "NA"},
            {"Specification": "Bio Matric Scanner for Smart Phone - Other"},
            {"Specification": "TEST CASE HARDWARE"},
            {
              "Specification":
                  "CTS Scanner - O/w Vol. 300 to 700 cheques per day"
            }
          ]
        }
      },
      "Software": {
        "EndCount": 7,
        "FilteredRequestNo": [
          "SL050220224989039165",
          "SL310320224989039253",
          "SL050420224989039354",
          "SL050420224989039391",
          "SL070420224989040317",
          "SL120520224989042488",
          "SL230620224989042529"
        ],
        "PageNo": 1,
        "RequestListSoftware": [
          {
            "AcquisitionType": "Permanent",
            "Amount": "22269.00",
            "NextApproverId": "",
            "PreviousApprover": "NA",
            "RequestBy": "P10803-Pushkar Singh",
            "RequestFor": "Self",
            "RequestNo": "SL050220224989039165",
            "RequestType": "Transfer",
            "SoftwareName": "Microsoft Office Standard",
            "SoftwareType": "Perpetual License",
            "SoftwareVersion": "2016",
            "iCartCid": 94188
          },
          {
            "AcquisitionType": "Temporary",
            "Amount": "0.00",
            "NextApproverId": "",
            "PreviousApprover": "NA",
            "RequestBy": "V9836-Vithoba Kavathankar",
            "RequestFor": "Self",
            "RequestNo": "SL310320224989039253",
            "RequestType": "Extension",
            "SoftwareName":
                "IBM BigFix Inventory (including z systems) Resource Value Unit",
            "SoftwareType": "Perpetual License",
            "SoftwareVersion": "Latest",
            "iCartCid": 94212
          },
          {
            "AcquisitionType": "Permanent",
            "Amount": "7629.85",
            "NextApproverId": "",
            "PreviousApprover": "NA",
            "RequestBy": "V2512-Venkatesh V",
            "RequestFor": "Self",
            "RequestNo": "SL050420224989039354",
            "RequestType": "New",
            "SoftwareName": "Microsoft Excel",
            "SoftwareType": "Perpetual License",
            "SoftwareVersion": "2019",
            "iCartCid": 94215
          },
          {
            "AcquisitionType": "Permanent",
            "Amount": "0.00",
            "NextApproverId": "",
            "PreviousApprover": "NA",
            "RequestBy": "A0232-Ashwini Desai",
            "RequestFor": "S0067-Susmita Subu",
            "RequestNo": "SL050420224989039391",
            "RequestType": "New",
            "SoftwareName": "ABB WinECP",
            "SoftwareType": "Freeware",
            "SoftwareVersion": "7",
            "iCartCid": 94216
          },
          {
            "AcquisitionType": "Permanent",
            "Amount": "9041.00",
            "NextApproverId": "",
            "PreviousApprover": "NA",
            "RequestBy": "M16087-Makarand Patkar",
            "RequestFor": "Self",
            "RequestNo": "SL070420224989040317",
            "RequestType": "New",
            "SoftwareName": "Microsoft Excel",
            "SoftwareType": "Perpetual License",
            "SoftwareVersion": "2016",
            "iCartCid": 94217
          },
          {
            "AcquisitionType": "Permanent",
            "Amount": "9041.00",
            "NextApproverId": "",
            "PreviousApprover": "NA",
            "RequestBy": "V9836-Vithoba Kavathankar",
            "RequestFor": "S21456-Sudheera Kumara Shetty",
            "RequestNo": "SL120520224989042488",
            "RequestType": "New",
            "SoftwareName": "Microsoft Excel",
            "SoftwareType": "Perpetual License",
            "SoftwareVersion": "2016",
            "iCartCid": 94231
          },
          {
            "AcquisitionType": "Permanent",
            "Amount": "9041.00",
            "NextApproverId": "",
            "PreviousApprover": "NA",
            "RequestBy": "V9836-Vithoba Kavathankar",
            "RequestFor": "Self",
            "RequestNo": "SL230620224989042529",
            "RequestType": "New",
            "SoftwareName": "Microsoft Excel",
            "SoftwareType": "Perpetual License",
            "SoftwareVersion": "2016",
            "iCartCid": 94242
          }
        ],
        "StartCount": 1,
        "TotalCount": 7,
        "filter": {
          "Software": [
            {"SoftName": "Microsoft Office Standard"},
            {
              "SoftName":
                  "IBM BigFix Inventory (including z systems) Resource Value Unit"
            },
            {"SoftName": "Microsoft Excel"},
            {"SoftName": "ABB WinECP"}
          ],
          "SoftwareRequestType": [
            {"SoftRequestType": "Transfer"},
            {"SoftRequestType": "Extension"},
            {"SoftRequestType": "New"}
          ]
        }
      }
    };
    return json.encode(res);
  }
}
