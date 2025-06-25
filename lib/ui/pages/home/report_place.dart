import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/report_controller.dart';
import 'package:musafir/help/depedencies.dart' as dependencies;
import 'package:musafir/models/report_types.dart';
import 'package:musafir/shared/theme.dart';

class ReportPlacePage extends StatefulWidget {
  final String placeId;
  final String placeName;

  const ReportPlacePage(
      {super.key, required this.placeId, required this.placeName});

  @override
  _ReportPlacePageState createState() => _ReportPlacePageState();
}

class _ReportPlacePageState extends State<ReportPlacePage> {
  late ReportController reportController;
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Use global FirestoreHelper from dependencies
    reportController = Get.put(
        ReportController(firestoreHelper: dependencies.firestoreHelper));
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  // Success animation method
  Future<void> _showSuccessAnimation(BuildContext context) async {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height / 2 - 50,
        left: MediaQuery.of(context).size.width / 2 - 50,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: kBlueColor,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.check,
                color: kWhiteColor,
                size: 60,
              ),
            ),
          ),
        ),
      ),
    );

    // Insert the overlay
    overlay.insert(overlayEntry);

    // Animate the overlay
    await Future.delayed(const Duration(milliseconds: 300));

    // Remove the overlay
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Place',
            style: blackTextStyle.copyWith(
              fontWeight: bold,
            )),
      ),
      body: Obx(() => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Report Type Selection
                Text('Select Report Type',
                    style: blackTextStyle.copyWith(
                      fontWeight: semiBold,
                    )),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: ReportTypes.availableTypes.map((type) {
                    final isSelected =
                        reportController.selectedReportType == type;
                    return GestureDetector(
                      onTap: () => reportController.setReportType(type),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? kBlueColor : kNeutral30,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          ReportTypes.labels[type] ?? type,
                          style: blackTextStyle.copyWith(
                            color: isSelected ? kWhiteColor : kBlackColor,
                            fontWeight: isSelected ? semiBold : regular,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // Description Input
                const SizedBox(height: 20),
                Text('Description',
                    style: blackTextStyle.copyWith(
                      fontWeight: semiBold,
                    )),
                const SizedBox(height: 10),
                TextField(
                  controller: _descriptionController,
                  onChanged: reportController.setDescription,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Provide details about your report',
                    hintStyle: greyTextStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                // Image Upload
                const SizedBox(height: 20),
                Text('Add Photos (Optional)',
                    style: blackTextStyle.copyWith(
                      fontWeight: semiBold,
                    )),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: reportController.pickImages,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: kNeutral30.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: kNeutral40, style: BorderStyle.solid),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.camera_alt,
                            size: 32, color: kNeutral80),
                        const SizedBox(height: 10),
                        Text('Upload Photos',
                            style: greyTextStyle.copyWith(
                              fontSize: 14,
                            )),
                      ],
                    ),
                  ),
                ),

                // Selected Images Preview
                if (reportController.selectedImages.isNotEmpty)
                  const SizedBox(height: 10),
                if (reportController.selectedImages.isNotEmpty)
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: reportController.selectedImages.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: FileImage(File(
                                      reportController.selectedImages[index])),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 15,
                              child: GestureDetector(
                                onTap: () => reportController.removeImage(
                                    reportController.selectedImages[index]),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kRedMain.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.close,
                                      color: kWhiteColor, size: 20),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                // Submit Button
                const SizedBox(height: 30),
                AnimatedBuilder(
                  animation: Listenable.merge([
                    ValueNotifier(reportController.isSubmitting),
                    ValueNotifier(reportController.selectedReportType),
                    ValueNotifier(_descriptionController.text),
                  ]),
                  builder: (context, child) {
                    final isFormValid =
                        reportController.selectedReportType.isNotEmpty &&
                            _descriptionController.text.trim().isNotEmpty;

                    // Explicitly log form validation state for debugging
                    debugPrint(
                        'Report Type: ${reportController.selectedReportType}');
                    debugPrint(
                        'Description: ${_descriptionController.text.trim()}');
                    debugPrint('Form Valid: $isFormValid');

                    return Obx(() => ElevatedButton(
                          onPressed:
                              (reportController.selectedReportType.isNotEmpty &&
                                      _descriptionController.text
                                          .trim()
                                          .isNotEmpty &&
                                      !reportController.isSubmitting)
                                  ? () async {
                                      // Unfocus any active text fields to dismiss keyboard
                                      FocusScope.of(context).unfocus();

                                      final success =
                                          await reportController.submitReport(
                                        placeId: widget.placeId,
                                        placeName: widget.placeName,
                                        reportType:
                                            reportController.selectedReportType,
                                        description:
                                            _descriptionController.text.trim(),
                                      );

                                      if (success) {
                                        // Show success animation
                                        await _showSuccessAnimation(context);

                                        // Clear form fields
                                        reportController.setReportType('');
                                        _descriptionController.clear();
                                        reportController.selectedImages.clear();

                                        // Navigate back after a brief delay
                                        await Future.delayed(
                                            const Duration(milliseconds: 500));
                                        Get.back();
                                      }
                                    }
                                  : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isFormValid && !reportController.isSubmitting
                                    ? kBlueColor
                                    : kBlueColor.withOpacity(0.5),
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: reportController.isSubmitting
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: kWhiteColor,
                                    strokeWidth: 3,
                                  ),
                                )
                              : Text(
                                  isFormValid
                                      ? 'Submit Report'
                                      : 'Select Report Type & Description',
                                  style: whiteTextStyle.copyWith(
                                    fontWeight: semiBold,
                                    color: isFormValid &&
                                            !reportController.isSubmitting
                                        ? kWhiteColor
                                        : kWhiteColor.withOpacity(0.7),
                                  ),
                                ),
                        ));
                  },
                ),
              ],
            ),
          )),
    );
  }
}
