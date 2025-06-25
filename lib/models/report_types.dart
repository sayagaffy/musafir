/// Constants and utilities for report types in the Musafir app
class ReportTypes {
  /// Predefined report types
  static const String NOT_HALAL = 'NOT_HALAL';
  static const String PERMANENTLY_CLOSED = 'PERMANENTLY_CLOSED';
  static const String WRONG_INFORMATION = 'WRONG_INFORMATION';
  static const String SUGGEST_UPDATE = 'SUGGEST_UPDATE';
  static const String OTHER = 'OTHER';

  /// List of all available report types
  static const List<String> availableTypes = [
    NOT_HALAL,
    PERMANENTLY_CLOSED,
    WRONG_INFORMATION,
    SUGGEST_UPDATE,
    OTHER,
  ];

  /// Labels for report types with emojis for UI display
  static const Map<String, String> labels = {
    NOT_HALAL: '🚫 Not Halal',
    PERMANENTLY_CLOSED: '🔒 Permanently Closed',
    WRONG_INFORMATION: '❌ Wrong Information',
    SUGGEST_UPDATE: '🔄 Suggest Update',
    OTHER: '❓ Other',
  };

  /// Priority levels for different report types
  /// Lower number indicates higher priority
  static const Map<String, int> priorities = {
    NOT_HALAL: 1, // Highest priority
    PERMANENTLY_CLOSED: 2,
    WRONG_INFORMATION: 3,
    SUGGEST_UPDATE: 4,
    OTHER: 5, // Lowest priority
  };
}
