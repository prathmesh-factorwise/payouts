import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Mahindra Logistics Pvt ltd",
    numOfFiles: 1328,
    svgSrc: "icons/account.svg",
    totalStorage: "1.9GB",
    color: Color.fromRGBO(37,64,155,1.000),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Indigo Staffing",
    numOfFiles: 1328,
    svgSrc: "icons/account.svg",
    totalStorage: "2.9GB",
    color: Color.fromRGBO(37,64,155,1.000),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Arthur Systems",
    numOfFiles: 1328,
    svgSrc: "icons/account.svg",
    totalStorage: "1GB",
    color: Color.fromRGBO(37,64,155,1.000),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "Atul Foods",
    numOfFiles: 5328,
    svgSrc: "icons/account.svg",
    totalStorage: "7.3GB",
    color: Color.fromRGBO(37,64,155,1.000),
    percentage: 78,
  ),
];
