import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class ManufacturingAgentPage extends StatefulWidget {
  @override
  _ManufacturingAgentPageState createState() => _ManufacturingAgentPageState();
}

class _ManufacturingAgentPageState extends State<ManufacturingAgentPage> {
  final TextEditingController orderIdController = TextEditingController();
  final TextEditingController batchIdController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  final TextEditingController stitchQualityController = TextEditingController();
  final TextEditingController seamStrengthController = TextEditingController();
  final TextEditingController dimensionalAccuracyController = TextEditingController();
  final TextEditingController defectsCountController = TextEditingController();

  String selectedStatus = 'Pending';
  final List<String> statusOptions = [
    'Pending',
    'Cutting',
    'Stitching',
    'Assembly',
    'Completed',
    'On Hold'
  ];

  Future<void> _updateManufacturingRecord() async {
    final url = Uri.parse('https://fiberportal-backend.vercel.app/api/manufacturing/manufacturingFaUpdate');

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
            "stitchQuality": stitchQualityController.text.trim(),
            "seamStrength": seamStrengthController.text.trim(),
            "dimensionalAccuracy": dimensionalAccuracyController.text.trim(),
            "defectsCount": defectsCountController.text.trim(),
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
          'Manufacturing Agent',
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
              'Manufacturing Agent Remarks',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
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
              items: statusOptions.map((status) {
                return DropdownMenuItem(value: status, child: Text(status));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedStatus = value!;
                });
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
            const SizedBox(height: 24),

            const Text(
              'Quality Metrics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF39FF14)),
            ),
            const SizedBox(height: 16),

            _buildQualityMetricField(stitchQualityController, 'Stitch Quality'),
            const SizedBox(height: 16),
            _buildQualityMetricField(seamStrengthController, 'Seam Strength'),
            const SizedBox(height: 16),
            _buildQualityMetricField(dimensionalAccuracyController, 'Dimensional Accuracy'),
            const SizedBox(height: 16),
            _buildQualityMetricField(defectsCountController, 'Defects Count'),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _updateManufacturingRecord,
              child: Text(
                'Update',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 12,
                  color: Colors.black87,
                  fontWeight: FontWeight.w900,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 50),
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
}
