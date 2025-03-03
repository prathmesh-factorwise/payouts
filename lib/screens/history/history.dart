import 'package:flutter/material.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import '../../constants.dart';

class TransactionHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(activePageTitle: 'Payouts History'),
            SizedBox(height: defaultPadding),
            buildFilterSection(context),
            SizedBox(height: defaultPadding),
            buildTransactionTable(context),
          ],
        ),
      ),
    );
  }

  Widget buildFilterSection(BuildContext context) {
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
            "Filters",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Filter by NEFT logic
                },
                child: Text("NEFT"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Filter by IMPS logic
                },
                child: Text("IMPS"),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Party Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "From Date",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    // Date picker logic
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "To Date",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    // Date picker logic
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTransactionTable(BuildContext context) {
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
            "Transaction Records",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: defaultPadding),
          DataTable(
            columns: const [
              DataColumn(label: Text("Party Name")),
              DataColumn(label: Text("Amount")),
              DataColumn(label: Text("Date")),
              DataColumn(label: Text("Time")),
              DataColumn(label: Text("Type")),
            ],
            rows: [], // Add rows dynamically based on transactions
          ),
          SizedBox(height: defaultPadding),
          Center(
            child: Text(
              "No transactions to display.",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
