import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../controllers/admin_report_controller.dart';
import '../../../shared/theme.dart';
import '../../../models/report_model.dart';

class AdminReportsDashboard extends StatelessWidget {
  final AdminReportController _controller = Get.put(AdminReportController());

  AdminReportsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Reports Dashboard',
            style: blackTextStyle.copyWith(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _controller.refreshDashboard,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildStatisticsGrid(),
            const SizedBox(height: 20),
            _buildReportTypeChart(),
            const SizedBox(height: 20),
            _buildRecentReportsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsGrid() {
    return Obx(() => GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          children: [
            _buildStatCard(
                'Total Reports', _controller.totalReports.value, kBlueColor),
            _buildStatCard('Pending Reports', _controller.pendingReports.value,
                kWarningMain),
            _buildStatCard('Resolved Reports',
                _controller.resolvedReports.value, kSuccessMain),
            _buildStatCard('Critical Reports',
                _controller.criticalReports.value, kRedColor),
          ],
        ));
  }

  Widget _buildStatCard(String title, int value, Color color) {
    return Card(
      elevation: 4,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: greyTextStyle.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              value.toString(),
              style: blackTextStyle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportTypeChart() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Reports Distribution',
              style: blackTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Obx(() => AspectRatio(
                  aspectRatio: 1.5,
                  child: PieChart(
                    PieChartData(
                      sections: _controller.reportTypeChartData,
                      centerSpaceRadius: 40,
                      sectionsSpace: 4,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentReportsList() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Reports',
              style: blackTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Obx(() => _controller.recentReports.isEmpty
                ? Center(
                    child: Text(
                      'No recent reports',
                      style: greyTextStyle,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _controller.recentReports.length,
                    itemBuilder: (context, index) {
                      final report = _controller.recentReports[index];
                      return _buildReportListTile(report);
                    },
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildReportListTile(ReportModel report) {
    Color statusColor = _getStatusColor(report.status);

    return ListTile(
      title: Text(
        report.placeName,
        style: blackTextStyle.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            report.reportType,
            style: greyTextStyle.copyWith(fontSize: 12),
          ),
          Text(
            report.status,
            style: TextStyle(color: statusColor, fontSize: 12),
          ),
        ],
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (String newStatus) {
          _showUpdateStatusDialog(report, newStatus);
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'pending',
            child: Text('Mark as Pending'),
          ),
          const PopupMenuItem<String>(
            value: 'reviewed',
            child: Text('Mark as Reviewed'),
          ),
          const PopupMenuItem<String>(
            value: 'resolved',
            child: Text('Mark as Resolved'),
          ),
        ],
        icon: const Icon(Icons.more_vert),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return kWarningMain;
      case 'reviewed':
        return kBlueColor;
      case 'resolved':
        return kSuccessMain;
      default:
        return kGreyColor;
    }
  }

  void _showUpdateStatusDialog(ReportModel report, String newStatus) {
    final TextEditingController noteController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: Text('Update Report Status', style: blackTextStyle),
        content: TextField(
          controller: noteController,
          decoration: InputDecoration(
            hintText: 'Optional admin notes',
            hintStyle: greyTextStyle,
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: greyTextStyle),
          ),
          ElevatedButton(
            onPressed: () {
              _controller.updateReportStatus(
                report.id!,
                newStatus,
                noteController.text.trim().isNotEmpty
                    ? noteController.text
                    : null,
              );
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: kBlueColor),
            child: Text('Update', style: whiteTextStyle),
          ),
        ],
      ),
    );
  }
}
