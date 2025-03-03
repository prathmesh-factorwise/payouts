import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


const secondaryColor = Color.fromARGB(255, 239, 242, 255);// Assuming this is the blue background color

// Model for payment history record
class RecentFile {
  final String partyName;
  final String transactionType; // "Debit" or "Credit"
  final String date;
  final double amount;
  final String icon;

  RecentFile({
    required this.partyName,
    required this.transactionType,
    required this.date,
    required this.amount,
    required this.icon,
  });
}

// Sample data for demonstration
List<RecentFile> demoPaymentHistory = [
  RecentFile(
    partyName: "Ankit Chaudhary",
    transactionType: "Debit",
    date: "2024-12-20",
    amount: 1.00,
    icon: "assets/icons/debit_icon.svg",
  ),
  RecentFile(
    partyName: "Ankit Chaudhary",
    transactionType: "Debit",
    date: "2024-12-25",
    amount: 1.00,
    icon: "assets/icons/credit_icon.svg",
  ),
  // Add more sample records as needed
];

class RecentFiles extends StatelessWidget {
  const RecentFiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: secondaryColor,  // Retaining the background color as it was
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment History",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: 16,
              columns: [
                DataColumn(label: Text("Party Name")),
                DataColumn(label: Text("Type")),
                DataColumn(label: Text("Date")),
                DataColumn(label: Text("Amount")),
              ],
              rows: List.generate(
                demoPaymentHistory.length,
                (index) => recentFileDataRow(demoPaymentHistory[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Function to create a DataRow for each RecentFile (payment record)
DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(fileInfo.partyName),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.transactionType)),
      DataCell(Text(fileInfo.date)),
      DataCell(Text("\Rs${fileInfo.amount.toStringAsFixed(2)}")),
    ],
  );
}
