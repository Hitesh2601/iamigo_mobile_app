import 'package:push_notification/features/iApproval/models/fpn_request_details_response.dart';
import 'package:flutter/material.dart';

class BenefitDetailsNewWidget extends StatelessWidget {
  const BenefitDetailsNewWidget({super.key, required this.benefitDetailsNew});

  final BenefitDetailsNew benefitDetailsNew;

  @override
  Widget build(BuildContext context) {
    var incrementalVolEffortList = benefitDetailsNew.incrementalVolEffortList;
    var reducedEffortList = benefitDetailsNew.reducedEffortList;
    return Column(
      children: [
        (incrementalVolEffortList != null)
            ? IncrementalVolEffortListWidget(
                incrementalVolEffortList: incrementalVolEffortList)
            : const SizedBox(),
        (reducedEffortList != null)
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ReducedEffortListWidget(
                    reducedEffortList: reducedEffortList),
              )
            : const SizedBox(),
      ],
    );
  }
}

class IncrementalVolEffortListWidget extends StatelessWidget {
  const IncrementalVolEffortListWidget({
    super.key,
    required this.incrementalVolEffortList,
  });

  final List<IncrementalVolEffortList> incrementalVolEffortList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: incrementalVolEffortList.length,
      itemBuilder: (context, index) {
        return IncrementalVolEffortTableView(
          incrementalVolEffort: incrementalVolEffortList[index],
          index: index,
        );
      },
    );
  }
}

class IncrementalVolEffortTableView extends StatelessWidget {
  const IncrementalVolEffortTableView(
      {super.key, required this.incrementalVolEffort, required this.index});
  final IncrementalVolEffortList incrementalVolEffort;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          children: [
            Visibility(
              visible: index == 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                color: Colors.blue.shade800,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Incremental Volumes Effort",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Product",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                incrementalVolEffort.productName!,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "# of units per month (In Lakhs)",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 2, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Existing",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 2,
                          color: Colors.white,
                        ),
                        const Text(
                          "Expected",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 2, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          incrementalVolEffort.unitPerMonthExisting!,
                        ),
                        Container(
                          width: 2,
                          color: Colors.white,
                        ),
                        Text(
                          incrementalVolEffort.unitPerMonthExpected!,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Avg Tickets Size (In Lakhs)",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 2, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Existing",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 2,
                          color: Colors.white,
                        ),
                        const Text(
                          "Expected",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 2, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          incrementalVolEffort.avgTicketSizeExisting!,
                        ),
                        Container(
                          width: 2,
                          color: Colors.white,
                        ),
                        Text(
                          incrementalVolEffort.avgTicketSizeExpected!,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Incremental Annual Avg. Balance \n(In Lakhs)",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 2, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Expected",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                incrementalVolEffort
                                    .incAnualAvgBalanceExpected!,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 2, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Incremental Revenue p.a.(In Lakhs)",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 2, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Expected",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                incrementalVolEffort.incRevenuePAExpected!,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 2, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "To be Tracked From",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                incrementalVolEffort.toBeTrackFrom!,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ReducedEffortListWidget extends StatelessWidget {
  const ReducedEffortListWidget({
    super.key,
    required this.reducedEffortList,
  });

  final List<ReducedEffortList> reducedEffortList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reducedEffortList.length,
      itemBuilder: (context, index) {
        return ReducedEffortTableView(
          reducedEffort: reducedEffortList[index],
          index: index,
        );
      },
    );
  }
}

class ReducedEffortTableView extends StatelessWidget {
  const ReducedEffortTableView(
      {super.key, required this.reducedEffort, required this.index});
  final ReducedEffortList reducedEffort;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          children: [
            Visibility(
              visible: index == 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                color: Colors.blue.shade800,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Reduced Efforts",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Functions",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                reducedEffort.functionName!,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 2, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Unit Name",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                reducedEffort.unitName!,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Processing Time (In Minutes)",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 2, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Existing",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 2,
                          color: Colors.white,
                        ),
                        const Text(
                          "Expected",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 2, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          reducedEffort.processingTimeExisting!,
                        ),
                        Container(
                          width: 2,
                          color: Colors.white,
                        ),
                        Text(
                          reducedEffort.processingTimeExpected!,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Productivity Per Resource \n(Per Transactions)",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 2, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Existing",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 2,
                          color: Colors.white,
                        ),
                        const Text(
                          "Expected",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 2, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          reducedEffort.productivityPerResourceExisting!,
                        ),
                        Container(
                          width: 2,
                          color: Colors.white,
                        ),
                        Text(
                          reducedEffort.productivityPerResourceExpected!,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Effective release of resources (count)",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 2, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Expected",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                reducedEffort.effectiveRelease!,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 2, 15, 0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue.shade100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "To be Tracked From",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                reducedEffort.toBeTrackFrom!,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
