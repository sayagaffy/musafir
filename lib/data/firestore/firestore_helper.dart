import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:musafir/models/report_model.dart';
import 'package:musafir/models/report_types.dart';

class FirestoreHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Collection names
  static const String REPORTS_COLLECTION = 'reports';
  static const String REPORT_STATS_COLLECTION = 'report_stats';

  /// Initialize the database structure
  Future<void> initializeDatabase() async {
    try {
      // Ensure report_stats collection exists
      await _firestore.collection(REPORT_STATS_COLLECTION).doc('global').set({
        'total_reports': 0,
        'reports_by_type': {
          for (var type in ReportTypes.availableTypes) type: 0
        },
        'reports_by_priority': {
          '1': 0, // Critical
          '2': 0, // High
          '3': 0, // Medium
          '4': 0, // Low
        },
        'last_updated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Error initializing database: $e');
      rethrow;
    }
  }

  /// Validate the database structure
  Future<bool> validateDatabaseStructure() async {
    try {
      // Check report_stats collection
      final statsDoc = await _firestore
          .collection(REPORT_STATS_COLLECTION)
          .doc('global')
          .get();

      if (!statsDoc.exists) {
        await initializeDatabase();
        return false;
      }

      // Validate required fields
      final data = statsDoc.data() ?? {};
      final requiredFields = [
        'total_reports',
        'reports_by_type',
        'reports_by_priority',
        'last_updated'
      ];

      for (var field in requiredFields) {
        if (!data.containsKey(field)) {
          await initializeDatabase();
          return false;
        }
      }

      return true;
    } catch (e) {
      debugPrint('Database structure validation failed: $e');
      return false;
    }
  }

  /// Create a sample report for testing purposes
  /// Only to be used in debug mode
  Future<ReportModel> createSampleReport() async {
    final sampleReport = ReportModel(
      placeId: 'sample_place_123',
      placeName: 'Test Restaurant',
      userId: 'debug_user',
      userEmail: 'debug@example.com',
      userName: 'Debug User',
      reportType: ReportTypes.NOT_HALAL,
      description: 'Sample report for testing database setup',
      createdAt: DateTime.now(),
      status: 'pending',
      priority: 1,
    );

    try {
      // Add report to reports collection
      final reportRef = await _firestore
          .collection(REPORTS_COLLECTION)
          .add(sampleReport.toJson());

      // Update report stats
      await _updateReportStats(sampleReport);

      // Return the report with its new ID
      return ReportModel.fromJson(
          {...sampleReport.toJson(), 'id': reportRef.id}, reportRef.id);
    } catch (e) {
      debugPrint('Error creating sample report: $e');
      rethrow;
    }
  }

  /// Update report statistics when a new report is created
  Future<void> _updateReportStats(ReportModel report) async {
    final statsRef =
        _firestore.collection(REPORT_STATS_COLLECTION).doc('global');

    await _firestore.runTransaction((transaction) async {
      final statsDoc = await transaction.get(statsRef);
      final data = statsDoc.data() ?? {};

      // Increment total reports
      transaction.update(statsRef, {
        'total_reports': FieldValue.increment(1),
        'reports_by_type.${report.reportType}': FieldValue.increment(1),
        'reports_by_priority.${report.priority}': FieldValue.increment(1),
        'last_updated': FieldValue.serverTimestamp(),
      });
    });
  }
}
