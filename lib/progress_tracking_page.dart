import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ProgressTrackingPage extends StatefulWidget {
  const ProgressTrackingPage({Key? key}) : super(key: key);

  @override
  _ProgressTrackingPageState createState() => _ProgressTrackingPageState();
}

class _ProgressTrackingPageState extends State<ProgressTrackingPage> {
  final ImagePicker _picker = ImagePicker();
  PickedFile? _pickedFile;
  Map<DateTime, String> _uploadedImages = {};
  bool _isUploading = false;
  bool _uploadError = false;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        _pickedFile = pickedFile;
      });
    } catch (e) {
      print('Error picking image: $e');
      // Handle error
    }
  }

  Future<void> _uploadImage() async {
    if (_pickedFile != null) {
      setState(() {
        _isUploading = true;
        _uploadError = false;
      });
      try {
        // Get the directory for storing files on the device
        Directory directory = await getApplicationDocumentsDirectory();
        String path = directory.path;

        // Create a unique file name for the image
        String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
        String filePath = '$path/$fileName';

        // Copy the picked image to the local file path
        await File(_pickedFile!.path).copy(filePath);

        setState(() {
          _uploadedImages[_selectedDay ?? DateTime.now()] = filePath;
          _isUploading = false;
        });
      } catch (e) {
        print('Error storing image locally: $e');
        setState(() {
          _isUploading = false;
          _uploadError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Tracking'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.photo),
              label: Text('Select Image'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImage,
              child: _isUploading
                  ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
                  : Text('Upload Image'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
            SizedBox(height: 20),
            _isUploading
                ? SizedBox()
                : _uploadError
                ? Text(
              'Error uploading image. Please try again.',
              style: TextStyle(color: Colors.red),
            )
                : _uploadedImages[_selectedDay] != null
                ? Container(
              height: 600,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: FileImage(File(_uploadedImages[_selectedDay]!)),
                  fit: BoxFit.cover,
                ),
              ),
            )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}