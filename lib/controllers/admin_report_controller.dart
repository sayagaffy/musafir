import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:developer' show debugPrint;

import '../models/report_model.dart';
import '../shared/theme.dart';
import '../data/firestore/firestore_helper.dart'; // Assuming this exists for collection constants

class AdminReportController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Loading state observable
  final RxBool isLoading = false.obs;

  // Observable report statistics
  final RxInt totalReports = 0.obs;
  final RxInt pendingReports = 0.obs;
  final RxInt resolvedReports = 0.obs;
  final RxInt criticalReports = 0.obs;

  // Observable list of recent reports
  final RxList<ReportModel> recentReports = <ReportModel>[].obs;

  // Chart data for report types
  final RxList<PieChartSectionData> reportTypeChartData =
      <PieChartSectionData>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    try {
      isLoading.value = true;

      // Load statistics from report_stats/global document
      final statsDoc = await _firestore
          .collection(FirestoreHelper.REPORT_STATS_COLLECTION)
          .doc('global')
          .get();

      if (statsDoc.exists) {
        final data = statsDoc.data() ?? {};
        totalReports.value = data['total_reports'] ?? 0;
        pendingReports.value = data['pending_reports'] ?? 0;
        resolvedReports.value = data['resolved_reports'] ?? 0;
        criticalReports.value = data['critical_reports'] ?? 0;
      }

      // Load recent reports
      await _loadRecentReports();

      // Generate chart data
      _generateReportTypeChartData();
    } catch (e) {
      debugPrint('Error loading dashboard data: $e');
      Get.snackbar(
        'Error',
        'Failed to load dashboard data',
        backgroundColor: kRedColor,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadRecentReports() async {
    try {
      final snapshot = await _firestore
          .collection(FirestoreHelper.REPORTS_COLLECTION)
          .orderBy('created_at', descending: true)
          .limit(10)
          .get();

      recentReports.value = snapshot.docs
          .map((doc) => ReportModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      debugPrint('Error fetching recent reports: $e');
    }
  }

  void _generateReportTypeChartData() {
    reportTypeChartData.value = [
      PieChartSectionData(
        color: kBlueColor,
        value: pendingReports.value.toDouble(),
        title: 'Pending',
        radius: 50,
      ),
      PieChartSectionData(
        color: kSuccessMain,
        value: resolvedReports.value.toDouble(),
        title: 'Resolved',
        radius: 50,
      ),
      PieChartSectionData(
        color: kRedColor,
        value: criticalReports.value.toDouble(),
        title: 'Critical',
        radius: 50,
      ),
    ];
  }

  Future<void> updateReportStatus(
      String reportId, String newStatus, String? adminNote) async {
    try {
      isLoading.value = true;

      await _firestore
          .collection(FirestoreHelper.REPORTS_COLLECTION)
          .doc(reportId)
          .update({
        'status': newStatus,
        'admin_note': adminNote,
        'resolved_at': newStatus == 'resolved' ? Timestamp.now() : null,
      });

      // Refresh dashboard data after update
      await loadDashboardData();
    } catch (e) {
      debugPrint('Error updating report status: $e');
      Get.snackbar(
        'Error',
        'Failed to update report status',
        backgroundColor: kRedColor,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Method to get chart data for fl_chart PieChart
  List<PieChartSectionData> getChartData() {
    return reportTypeChartData;
  }

  // Pull to refresh method
  Future<void> refreshDashboard() async {
    await loadDashboardData();
  }
}
