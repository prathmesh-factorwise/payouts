import 'package:flutter/material.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/dashboard/components/storage_details.dart';
import '../../constants.dart';

class BillPayments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(activePageTitle: 'Bill Payments'),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: buildSummaryCard(
                              title: "Bills Pending",
                              count: 0,
                              color: const Color.fromARGB(255, 251, 57, 57),
                              icon: Icons.pending_actions,
                            ),
                          ),
                          SizedBox(width: defaultPadding),
                          Expanded(
                            child: buildSummaryCard(
                              title: "Bills Paid",
                              count: 0,
                              color: const Color.fromARGB(255, 26, 199, 32),
                              icon: Icons.done_all,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                      buildPendingBillsTable(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StorageDetails(),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSummaryCard({
    required String title,
    required int count,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 40, color: color),
              Spacer(),
              Text(
                "$count",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding / 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }


  Widget buildPendingBillsTable() {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pending Bills",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: defaultPadding),
          DataTable(
            columns: [
              DataColumn(label: Text("Category")),
              DataColumn(label: Text("Due Date")),
              DataColumn(label: Text("Pending Amount")),
            ],
            rows: [], 
          ),
          SizedBox(height: defaultPadding),
          Center(
            child: Text(
              "No Pending Bills",
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
