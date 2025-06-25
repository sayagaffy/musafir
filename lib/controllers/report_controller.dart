import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/data/firestore/firestore_helper.dart';
import 'package:musafir/models/report_model.dart';
import 'package:musafir/models/report_types.dart';

class ReportController extends GetxController {
  final FirestoreHelper firestoreHelper;

  ReportController({FirestoreHelper? firestoreHelper})
      : firestoreHelper = firestoreHelper ?? FirestoreHelper();

  // Reactive variables for report creation
  final _selectedReportType = ''.obs;
  final _description = ''.obs;
  final _photoUrls = <String>[].obs;
  final _isSubmitting = false.obs;
  final _isLoading = false.obs;
  final _userReports = <ReportModel>[].obs;

  // Getters
  String get selectedReportType => _selectedReportType.value;
  String get description => _description.value;
  List<String> get photoUrls => _photoUrls;
  bool get isSubmitting => _isSubmitting.value;
  bool get isLoading => _isLoading.value;
  List<ReportModel> get userReports => _userReports;
  List<String> get selectedImages => _photoUrls;

  // Setters
  void setReportType(String type) {
    _selectedReportType.value = type;
  }

  void setDescription(String desc) {
    _description.value = desc;
  }

  // Image picking and upload
  Future<void> pickImages() async {
    if (_photoUrls.length >= 3) {
      showCustomSnackBar('Maximum 3 images allowed', isError: true);
      return;
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        _isSubmitting.value = true;
        final file = File(pickedFile.path);

        // In a real app, you'd use Firebase Storage
        // For now, just add the local file path
        _photoUrls.add(file.path);
      } catch (e) {
        showCustomSnackBar('Image upload failed', isError: true);
        debugPrint('Image upload error: $e');
      } finally {
        _isSubmitting.value = false;
      }
    }
  }

  // Remove an image from the list
  void removeImage(String imageUrl) {
    _photoUrls.remove(imageUrl);
  }

  // Submit report
  Future<bool> submitReport({
    required String placeId,
    required String placeName,
    required String reportType,
    required String description,
  }) async {
    // Validate inputs
    if (reportType.isEmpty) {
      showCustomSnackBar('Please select a report type', isError: true);
      return false;
    }

    if (description.trim().isEmpty) {
      showCustomSnackBar('Please provide a description', isError: true);
      return false;
    }

    try {
      _isSubmitting.value = true;

      // TODO: Replace with actual user retrieval
      final currentUser = {
        'id': 'sample_user_id',
        'email': 'user@example.com',
        'name': 'Sample User'
      };

      final report = ReportModel(
        placeId: placeId,
        placeName: placeName,
        userId: currentUser['id']!,
        userEmail: currentUser['email']!,
        userName: currentUser['name']!,
        reportType: reportType,
        description: description.trim(),
        photoUrls: _photoUrls,
        createdAt: DateTime.now(),
        status: 'pending',
        priority: ReportTypes.priorities[reportType] ?? 4,
      );

      // Add report to Firestore
      final reportRef = await FirebaseFirestore.instance
          .collection(FirestoreHelper.REPORTS_COLLECTION)
          .add(report.toJson());

      // Reset form
      _selectedReportType.value = '';
      _description.value = '';
      _photoUrls.clear();

      showCustomSnackBar('Report submitted successfully', isError: false);
      return true;
    } catch (e) {
      showCustomSnackBar('Failed to submit report', isError: true);
      debugPrint('Report submission error: $e');
      return false;
    } finally {
      _isSubmitting.value = false;
    }
  }

  // Fetch user's reports
  Future<void> getUserReports() async {
    try {
      _isLoading.value = true;

      // TODO: Replace with actual user retrieval
      final currentUser = {
        'id': 'sample_user_id',
      };

      final querySnapshot = await FirebaseFirestore.instance
          .collection(FirestoreHelper.REPORTS_COLLECTION)
          .where('user_id', isEqualTo: currentUser['id'])
          .orderBy('created_at', descending: true)
          .get();

      _userReports.value = querySnapshot.docs
          .map((doc) => ReportModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      debugPrint('Error fetching user reports: $e');
      showCustomSnackBar('Failed to load reports', isError: true);
    } finally {
      _isLoading.value = false;
    }
  }

  // Get status color
  Color getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return const Color(0xFFE0E0E0); // Light gray
      case 'reviewed':
        return const Color(0xFF2196F3); // Blue
      case 'resolved':
        return const Color(0xFF4CAF50); // Green
      case 'rejected':
        return const Color(0xFFF44336); // Red
      default:
        return const Color(0xFF9E9E9E); // Gray
    }
  }

  // Get status text
  String getStatusText(String status) {
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
}
