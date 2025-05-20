import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProcurementAgentPage extends StatefulWidget {
  @override
  _ProcurementAgentPageState createState() => _ProcurementAgentPageState();
}

class _ProcurementAgentPageState extends State<ProcurementAgentPage> {
  TextEditingController orderIdController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();

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

  Future<void> sendPostRequest() async {
    final url = Uri.parse('https://fiberportal-backend.vercel.app/api/procurementOrders/fieldAgentUpdateApp');

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final agentName = prefs.getString('name');

    final Map<String, dynamic> requestData = {
      'orderNumber': orderIdController.text.trim(),
      'status': statusController.text.trim(),
      'remarks': remarksController.text.trim(),
      'date': dateController.text.trim(),
      'agentName': agentName,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Success',
          desc: 'Data sent successfully!',
          btnOkOnPress: () {},
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Failed',
          desc: 'Failed to send data. Error: ${responseData['message']}',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'An error occurred: $e',
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF39FF14),
        title: Text(
          'Procurement Agent',
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Field Agent Remarks',
              style: GoogleFonts.poppins(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(195, 0, 0, 0),
              ),
            ),
            SizedBox(height: 20.h),

            _buildInputField(orderIdController, 'Order ID'),
            SizedBox(height: 16.h),
            _buildInputField(statusController, 'Status'),
            SizedBox(height: 16.h),
            _buildInputField(remarksController, 'Remarks', maxLines: 4),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: _buildInputField(dateController, 'Date', suffixIcon: Icons.calendar_today),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                if (orderIdController.text.isEmpty ||
                    statusController.text.isEmpty ||
                    remarksController.text.isEmpty ||
                    dateController.text.isEmpty) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.rightSlide,
                    title: 'Incomplete',
                    desc: 'Please fill all the fields!',
                    btnOkOnPress: () {},
                  ).show();
                } else {
                  sendPostRequest();
                }
              },
              child: Text(
                'Update',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 12.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w900,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                minimumSize: Size(double.infinity, 50.h),
                backgroundColor: const Color(0xFF39FF14),
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

  Widget _buildInputField(TextEditingController controller, String label, {int maxLines = 1, IconData? suffixIcon}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        ),
        keyboardType: maxLines > 1 ? TextInputType.multiline : TextInputType.text,
      ),
    );
  }
}
