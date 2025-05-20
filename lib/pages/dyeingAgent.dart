import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class DyeingAgentPage extends StatefulWidget {
  @override
  _DyeingAgentPageState createState() => _DyeingAgentPageState();
}

class _DyeingAgentPageState extends State<DyeingAgentPage> {
  TextEditingController orderIdController = TextEditingController();
  TextEditingController batchIdController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  TextEditingController colorFastnessController = TextEditingController();
  TextEditingController phLevelController = TextEditingController();
  TextEditingController shrinkageController = TextEditingController();
  TextEditingController defectsController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String selectedStatus = 'Pending';

  final List<String> statusOptions = [
    'Pending',
    'Preparation',
    'Dyeing',
    'Washing',
    'Drying',
    'Completed',
    'On Hold'
  ];

  Future<void> _updateDyeingRecord() async {
    final url = Uri.parse('https://fiberportal-backend.vercel.app/api/dyeing/updateFAapp');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "orderId": orderIdController.text.trim(),
          "batchNumber": batchIdController.text.trim(),
          "status": selectedStatus,
          "remarkMessage": messageController.text.trim(),
          "role": roleController.text.trim(),
          "qualityMetrics": {
            "colorFastness": colorFastnessController.text.trim(),
            "pHLevel": phLevelController.text.trim(),
            "shrinkage": shrinkageController.text.trim(),
            "defects": defectsController.text.trim(),
          }
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          title: 'Success',
          desc: data['message'] ?? 'Record updated successfully',
          btnOkOnPress: () {},
        ).show();
      } else {
        throw Exception(data['message'] ?? 'Unknown error');
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        title: 'Error',
        desc: e.toString(),
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
          'Dyeing Agent',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dyeing Agent Remarks',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: const Color.fromARGB(195, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(orderIdController, 'Order ID'),
            const SizedBox(height: 16),
            _buildTextField(batchIdController, 'Batch ID'),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: selectedStatus,
              items: statusOptions
                  .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                  .toList(),
              onChanged: (value) {
                setState(() => selectedStatus = value!);
              },
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),
            _buildTextField(messageController, 'Message', maxLines: 3),
            const SizedBox(height: 16),
            _buildTextField(roleController, 'Role'),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Quality Metrics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF39FF14)),
            ),
            const SizedBox(height: 12),
            _buildQualityMetricField(colorFastnessController, 'Color Fastness'),
            const SizedBox(height: 16),
            _buildQualityMetricField(phLevelController, 'pH Level'),
            const SizedBox(height: 16),
            _buildQualityMetricField(shrinkageController, 'Shrinkage'),
            const SizedBox(height: 16),
            _buildQualityMetricField(defectsController, 'Defects'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _updateDyeingRecord,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF39FF14),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                'Update',
                style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildQualityMetricField(TextEditingController controller, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }
}
