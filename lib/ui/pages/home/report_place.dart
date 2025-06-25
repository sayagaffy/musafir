import 'dart:io';
import 'package:flutter/material.dart';
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
                ElevatedButton(
                  onPressed: reportController.selectedReportType.isNotEmpty
                      ? () async {
                          final success = await reportController.submitReport(
                            placeId: widget.placeId,
                            placeName: widget.placeName,
                            reportType: reportController.selectedReportType,
                            description: _descriptionController.text.trim(),
                          );
                          if (success) {
                            Get.back(); // Close the report page
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBlueColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Submit Report',
                    style: whiteTextStyle.copyWith(
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
