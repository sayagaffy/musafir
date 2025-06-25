import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a user-submitted report for a place in the Musafir app
class ReportModel {
  /// Unique identifier for the report
  final String? id;

  /// Identifier of the place being reported
  final String placeId;

  /// Name of the place being reported
  final String placeName;

  /// Identifier of the user submitting the report
  final String userId;

  /// Email of the user submitting the report
  final String userEmail;

  /// Name of the user submitting the report
  final String userName;

  /// Type of report (e.g., NOT_HALAL, PERMANENTLY_CLOSED)
  final String reportType;

  /// Detailed description of the report
  final String description;

  /// Optional URLs of photos supporting the report
  final List<String>? photoUrls;

  /// Timestamp when the report was created
  final DateTime createdAt;

  /// Current status of the report (pending, reviewed, resolved, rejected)
  final String status;

  /// Optional note from admin handling the report
  final String? adminNote;

  /// Timestamp when the report was resolved
  final DateTime? resolvedAt;

  /// Identifier of the admin who resolved the report
  final String? resolvedBy;

  /// Priority of the report (1: Critical, 2: High, 3: Medium, 4: Low)
  final int priority;

  /// Constructor for creating a new ReportModel
  ReportModel({
    this.id,
    required this.placeId,
    required this.placeName,
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.reportType,
    required this.description,
    this.photoUrls,
    required this.createdAt,
    required this.status,
    this.adminNote,
    this.resolvedAt,
    this.resolvedBy,
    required this.priority,
  });

  /// Converts the ReportModel to a JSON map for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'place_id': placeId,
      'place_name': placeName,
      'user_id': userId,
      'user_email': userEmail,
      'user_name': userName,
      'report_type': reportType,
      'description': description,
      'photo_urls': photoUrls ?? [],
      'created_at': Timestamp.fromDate(createdAt),
      'status': status,
      'admin_note': adminNote,
      'resolved_at':
          resolvedAt != null ? Timestamp.fromDate(resolvedAt!) : null,
      'resolved_by': resolvedBy,
      'priority': priority,
    };
  }

  /// Creates a ReportModel from a Firestore JSON map
  factory ReportModel.fromJson(Map<String, dynamic> json,
      [String? documentId]) {
    return ReportModel(
      id: documentId ?? json['id'],
      placeId: json['place_id'] ?? '',
      placeName: json['place_name'] ?? '',
      userId: json['user_id'] ?? '',
      userEmail: json['user_email'] ?? '',
      userName: json['user_name'] ?? '',
      reportType: json['report_type'] ?? '',
      description: json['description'] ?? '',
      photoUrls: json['photo_urls'] != null
          ? List<String>.from(json['photo_urls'])
          : null,
      createdAt: (json['created_at'] is Timestamp)
          ? (json['created_at'] as Timestamp).toDate()
          : DateTime.now(),
      status: json['status'] ?? 'pending',
      adminNote: json['admin_note'],
      resolvedAt: json['resolved_at'] is Timestamp
          ? (json['resolved_at'] as Timestamp).toDate()
          : null,
      resolvedBy: json['resolved_by'],
      priority: json['priority'] ?? 3,
    );
  }
}
