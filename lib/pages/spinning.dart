import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // For formatting the date
import 'package:google_fonts/google_fonts.dart';

class SpinningAgentPage extends StatefulWidget {
  @override
  _SpinningAgentPageState createState() => _SpinningAgentPageState();
}

class _SpinningAgentPageState extends State<SpinningAgentPage> {
  TextEditingController orderIdController = TextEditingController();
  TextEditingController batchIdController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  // This variable will hold the selected date
  DateTime selectedDate = DateTime.now();

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ) ?? selectedDate;

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF39FF14),
        title: Text(
          'Spinning Agent',
          style: GoogleFonts.poppins(fontSize: 15.sp, fontWeight: FontWeight.w800, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spinning Agent Remarks',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: orderIdController,
              decoration: InputDecoration(
                labelText: 'Order ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: batchIdController,
              decoration: InputDecoration(
                labelText: 'Batch ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: statusController,
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: messageController,
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: roleController,
              decoration: InputDecoration(
                labelText: 'Role',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                // Handle update button press
                String orderId = orderIdController.text;
                String batchId = batchIdController.text;
                String status = statusController.text;
                String message = messageController.text;
                String role = roleController.text;
                String date = dateController.text;

                // Add the logic for submitting the data (e.g., sending it to a database or API)
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Data Updated: $orderId, $batchId, $status, $message, $role, $date'),
                ));
              },
              child: Text('Update'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                minimumSize: Size(double.infinity, 50.h),
                backgroundColor: Color(0xFF39FF14),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
