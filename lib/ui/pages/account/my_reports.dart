import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/report_controller.dart';
import 'package:musafir/help/depedencies.dart' as dependencies;
import 'package:musafir/models/report_model.dart';
import 'package:musafir/shared/theme.dart';

class MyReportsPage extends StatefulWidget {
  const MyReportsPage({super.key});

  @override
  _MyReportsPageState createState() => _MyReportsPageState();
}

class _MyReportsPageState extends State<MyReportsPage> {
  late ReportController reportController;

  @override
  void initState() {
    super.initState();
    // Use global FirestoreHelper from dependencies
    reportController = Get.put(
        ReportController(firestoreHelper: dependencies.firestoreHelper));
    reportController.getUserReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kBlackColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'My Reports',
          style: blackTextStyle.copyWith(
            fontWeight: bold,
          ),
        ),
      ),
      body: Obx(() {
        if (reportController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (reportController.userReports.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.report_off, size: 80, color: kNeutral60),
                const SizedBox(height: 16),
                Text(
                  'No reports yet',
                  style: greyTextStyle.copyWith(fontSize: 14),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => reportController.getUserReports(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: reportController.userReports.length,
            itemBuilder: (context, index) {
              final report = reportController.userReports[index];
              final statusColor = _getStatusColor(report.status);
              final statusText = _getStatusText(report.status);

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: kNeutral30.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Report Header
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              report.placeName,
                              style: blackTextStyle.copyWith(
                                fontWeight: semiBold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              statusText,
                              style: blackTextStyle.copyWith(
                                color: statusColor,
                                fontWeight: medium,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),

                    // Report Details
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Report Type
                          Row(
                            children: [
                              const Icon(Icons.report_problem,
                                  size: 16, color: kNeutral60),
                              const SizedBox(width: 8),
                              Text(
                                report.reportType,
                                style: blackTextStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Description
                          Text(
                            report.description,
                            style: greyTextStyle.copyWith(fontSize: 13),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),

                          // Date
                          Text(
                            _formatDate(report.createdAt),
                            style: greyTextStyle.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return kNeutral30;
      case 'reviewed':
        return kBlueColor;
      case 'resolved':
        return kSuccessMain;
      case 'rejected':
        return kErrorMain;
      default:
        return kNeutral60;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'Pending';
      case 'reviewed':
        return 'Reviewed';
      case 'resolved':
        return 'Resolved';
      case 'rejected':
        return 'Rejected';
      default:
        return 'Unknown';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
