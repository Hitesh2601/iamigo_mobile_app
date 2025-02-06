import 'package:push_notification/common/widgets/background_screen.dart';
import 'package:push_notification/features/iApproval/models/tco_details_response.dart';
import 'package:push_notification/features/iApproval/providers/fpn_tco_detail_provider.dart';
import 'package:push_notification/utility/constants/colors.dart';
import 'package:push_notification/utility/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class FPNTCODetailPage extends StatefulWidget {
  final String fpnNumber;
  const FPNTCODetailPage({super.key, required this.fpnNumber});

  @override
  State<FPNTCODetailPage> createState() => _FPNTCODetailPageState();
}

class _FPNTCODetailPageState extends State<FPNTCODetailPage> {
  Future<TcoDetailResponse>? _myFuture;
  @override
  void initState() {
    super.initState();
    _myFuture = getTCODetailtData();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  Future<TcoDetailResponse> getTCODetailtData() async {
    var res = await Provider.of<FpnTcoDetailProvider>(context, listen: false)
        .getTCODetailtData(
            {'UserId': GlobalVariables.userName, 'FpnNo': widget.fpnNumber});
    return res;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var requestTCOJson = <String, String>{
      'UserId': GlobalVariables.userName,
      'FpnNo': widget.fpnNumber
    };
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        WidgetsFlutterBinding.ensureInitialized();
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      },
      child: Scaffold(
        backgroundColor: FColors.light,
        body: Stack(
          children: [
            BackgrounScreenWidget(
              height: 110,
            ),
            Column(
              children: [
                tcoHeaderWidget(context),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(45, 16, 16, 16.0),
                    child: FutureBuilder(
                        builder: (ctx, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Text(
                                snapshot.error.toString(),
                              );
                            } else if (snapshot.hasData) {
                              var data = snapshot.data as TcoDetailResponse;
                              List<VNewDatum> tcoList = [];
                              for (var element in data.vNewData) {
                                if (element.totalAmt == "0.00") {
                                  if (element.displayGridStyle !=
                                      DisplayGridStyle.TEXT) {
                                    tcoList.add(element);
                                  }
                                } else {
                                  tcoList.add(element);
                                }
                              }
                              tcoList.sort(
                                  (a, b) => a.serialNo.compareTo(b.serialNo));
                              var fixedColumnData = context
                                  .read<FpnTcoDetailProvider>()
                                  .generateFixedColumnList(tcoList);
                              var fixedRowData = context
                                  .read<FpnTcoDetailProvider>()
                                  .generateFixedHeaderRowList(data.yearsCount);
                              var nonfixedRowData = context
                                  .read<FpnTcoDetailProvider>()
                                  .generateNonFixedDataList(
                                      tcoList, data.yearsCount);
                              List<int> headerIndexList = [];
                              List<int> headerSubHeaderIndexList = [];
                              for (var element in tcoList) {
                                if (element.displayGridStyle !=
                                    DisplayGridStyle.SUB_MAIN_HEADER) {
                                  if (element.displayGridStyle ==
                                      DisplayGridStyle.SUB_HEADER) {
                                    headerSubHeaderIndexList
                                        .add(tcoList.indexOf(element));
                                  }
                                } else {
                                  headerIndexList.add(tcoList.indexOf(element));
                                  headerSubHeaderIndexList
                                      .add(tcoList.indexOf(element));
                                }
                              }
                              return CustomDataTable(
                                  fixedCornerCell: 'Total Expenditure Cost',
                                  borderColor: Colors.grey.shade300,
                                  rowsCells: nonfixedRowData,
                                  fixedColCells: fixedColumnData,
                                  fixedRowCells: fixedRowData,
                                  mainData: tcoList,
                                  headerIndexList: headerIndexList,
                                  headerSubHeaderIndexList:
                                      headerSubHeaderIndexList);
                            }
                          }
                          // Displaying LoadingSpinner to indicate waiting state
                          return const Center(
                            child: Text('Loading..'),
                          );
                        },
                        future: _myFuture),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding tcoHeaderWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 5, right: 5, bottom: 10),
      child: Row(
        children: [
          InkWell(
            onTap: () async {
              WidgetsFlutterBinding.ensureInitialized();
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
              ]);

              Get.back();
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 0),
              child: Icon(FontAwesomeIcons.arrowLeft,
                  size: 40, color: FColors.textWhite),
            ),
          ),
          const Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("TCO Details",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: FColors.textWhite,
                        fontSize: 23,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDataTable<T> extends StatefulWidget {
  final T fixedCornerCell;
  final List<T> fixedColCells;
  final List<T> fixedRowCells;
  final List<List<T>> rowsCells;
  final double fixedColWidth;
  final double cellWidth;
  final double cellHeight;
  final double cellMargin;
  final double cellSpacing;
  final Color borderColor;
  final List<VNewDatum> mainData;
  final List<int> headerIndexList;
  final List<int> headerSubHeaderIndexList;

  const CustomDataTable(
      {super.key,
      required this.fixedCornerCell,
      required this.fixedColCells,
      required this.fixedRowCells,
      required this.rowsCells,
      this.fixedColWidth = 300.0,
      this.cellHeight = 56.0,
      this.cellWidth = 200.0,
      this.cellMargin = 10.0,
      this.cellSpacing = 10.0,
      required this.borderColor,
      required this.mainData,
      required this.headerIndexList,
      required this.headerSubHeaderIndexList});

  @override
  State<StatefulWidget> createState() => CustomDataTableState();
}

class CustomDataTableState<T> extends State<CustomDataTable<T>> {
  final _columnController = ScrollController();
  final _rowController = ScrollController();
  final _subTableYController = ScrollController();
  final _subTableXController = ScrollController();

  Widget _buildChild(double width, T data,
          {FontWeight fontWeight = FontWeight.w500}) =>
      SizedBox(
        width: width,
        child: Text(
          '$data',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: fontWeight),
        ),
      );

  TableBorder _buildBorder({
    bool top = false,
    bool left = false,
    bool right = false,
    bool bottom = false,
    bool verticalInside = false,
  }) {
    return TableBorder(
      top: top ? BorderSide(color: widget.borderColor) : BorderSide.none,
      left: left ? BorderSide(color: widget.borderColor) : BorderSide.none,
      right: right ? BorderSide(color: widget.borderColor) : BorderSide.none,
      bottom: bottom ? BorderSide(color: widget.borderColor) : BorderSide.none,
      verticalInside: verticalInside
          ? BorderSide(color: widget.borderColor)
          : BorderSide.none,
    );
  }

  Widget _buildFixedCol() => DataTable(
      border: _buildBorder(right: true),
      horizontalMargin: widget.cellMargin,
      columnSpacing: widget.cellSpacing,
      headingRowHeight: widget.cellHeight,
      dataRowHeight: widget.cellHeight,
      columns: [
        DataColumn(
            label: Visibility(
                visible: false,
                child: _buildChild(
                    widget.fixedColWidth, widget.fixedColCells.first)))
      ],
      rows: widget.fixedColCells
          .map((c) => DataRow(
                  color: widget.headerIndexList
                          .contains(widget.fixedColCells.indexOf(c))
                      ? WidgetStateColor.resolveWith(
                          (states) => FColors.tcoLight)
                      : WidgetStateColor.resolveWith((states) => Colors.white),
                  cells: [
                    DataCell(_buildChild(widget.fixedColWidth, c,
                        fontWeight: widget.headerSubHeaderIndexList
                                .contains(widget.fixedColCells.indexOf(c))
                            ? FontWeight.bold
                            : FontWeight.w400))
                  ]))
          .toList());

  Widget _buildFixedRow() => DataTable(
        decoration: const BoxDecoration(color: FColors.tcoDark),
        border: _buildBorder(verticalInside: true, bottom: true),
        horizontalMargin: widget.cellMargin,
        columnSpacing: widget.cellSpacing,
        headingRowHeight: widget.cellHeight,
        dataRowHeight: widget.cellHeight,
        columns: widget.fixedRowCells
            .map(
              (c) => DataColumn(
                label: _buildChild(widget.cellWidth, c,
                    fontWeight: FontWeight.bold),
              ),
            )
            .toList(),
        rows: const [],
      );

  Widget _buildSubTable() => Material(
      child: DataTable(
          border: _buildBorder(verticalInside: true),
          horizontalMargin: widget.cellMargin,
          columnSpacing: widget.cellSpacing,
          headingRowHeight: widget.cellHeight,
          dataRowHeight: widget.cellHeight,
          columns: widget.rowsCells.first
              .map((c) => DataColumn(label: _buildChild(widget.cellWidth, c)))
              .toList(),
          rows: widget.rowsCells
              .map(
                (row) => DataRow(
                    color: widget.headerIndexList
                            .contains(widget.rowsCells.indexOf(row))
                        ? WidgetStateColor.resolveWith(
                            (states) => FColors.tcoLight)
                        : WidgetStateColor.resolveWith(
                            (states) => Colors.white),
                    cells: row
                        .map((c) => DataCell(_buildChild(widget.cellWidth, c,
                            fontWeight: widget.headerSubHeaderIndexList
                                    .contains(widget.rowsCells.indexOf(row))
                                ? FontWeight.bold
                                : FontWeight.w400)))
                        .toList()),
              )
              .toList()));

  Widget _buildCornerCell() => DataTable(
        decoration: const BoxDecoration(color: FColors.tcoDark),
        border: _buildBorder(bottom: true, right: true),
        horizontalMargin: widget.cellMargin,
        columnSpacing: widget.cellSpacing,
        headingRowHeight: widget.cellHeight,
        dataRowHeight: widget.cellHeight,
        columns: [
          DataColumn(
            label: _buildChild(widget.fixedColWidth, widget.fixedCornerCell,
                fontWeight: FontWeight.bold),
          )
        ],
        rows: const [],
      );
  bool isSyncing = false;
  @override
  void initState() {
    super.initState();
    _subTableXController.addListener(() {
      _rowController.jumpTo(_subTableXController.position.pixels);
    });

    _subTableYController.addListener(() {
      if (isSyncing) return;
      isSyncing = true;
      _columnController.jumpTo(_subTableYController.offset);
      isSyncing = false;
    });

    _columnController.addListener(() {
      if (isSyncing) return;
      isSyncing = true;
      _subTableYController.jumpTo(_columnController.offset);
      isSyncing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: widget.borderColor),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              SingleChildScrollView(
                controller: _columnController,
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                child: _buildFixedCol(),
              ),
              Flexible(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  controller: _subTableXController,
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    controller: _subTableYController,
                    scrollDirection: Axis.vertical,
                    child: _buildSubTable(),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildCornerCell(),
              Flexible(
                child: SingleChildScrollView(
                  controller: _rowController,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  child: _buildFixedRow(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
