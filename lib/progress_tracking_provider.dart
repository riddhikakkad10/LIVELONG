import 'dart:io';
import 'package:flutter/material.dart';

class ProgressTrackingProvider extends ChangeNotifier {
  Map<DateTime, String> _uploadedImages = {};
  DateTime? _selectedDay;

  Map<DateTime, String> get uploadedImages => _uploadedImages;
  DateTime? get selectedDay => _selectedDay;

  void setUploadedImage(DateTime date, String filePath) {
    _uploadedImages[date] = filePath;
    notifyListeners();
  }

  void setSelectedDay(DateTime? day) {
    _selectedDay = day;
    notifyListeners();
  }
}