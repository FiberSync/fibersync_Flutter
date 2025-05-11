import 'package:flutter/material.dart';

class ManufacturingAgentPage extends StatefulWidget {
  @override
  _ManufacturingAgentPageState createState() => _ManufacturingAgentPageState();
}

class _ManufacturingAgentPageState extends State<ManufacturingAgentPage> {
  TextEditingController orderIdController = TextEditingController();
  TextEditingController batchIdController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  // Quality Metrics Controllers
  TextEditingController stitchQualityController = TextEditingController();
  TextEditingController seamStrengthController = TextEditingController();
  TextEditingController dimensionalAccuracyController = TextEditingController();
  TextEditingController defectsCountController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF39FF14),
        title: Text(
          'Manufacturing Agent',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Manufacturing Agent Remarks',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),

            _buildField(controller: orderIdController, label: 'Order ID'),
            SizedBox(height: 16),
            _buildField(controller: batchIdController, label: 'Batch ID'),
            SizedBox(height: 16),
            _buildField(controller: statusController, label: 'Status'),
            SizedBox(height: 16),
            _buildField(controller: messageController, label: 'Message', maxLines: 4),
            SizedBox(height: 16),
            _buildField(controller: roleController, label: 'Role'),
            SizedBox(height: 16),

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

            SizedBox(height: 20),
            Text('Quality Metrics',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF39FF14))),
            SizedBox(height: 12),

            _buildQualityMetricField(controller: stitchQualityController, label: 'Stitch Quality'),
            SizedBox(height: 16),
            _buildQualityMetricField(controller: seamStrengthController, label: 'Seam Strength'),
            SizedBox(height: 16),
            _buildQualityMetricField(controller: dimensionalAccuracyController, label: 'Dimensional Accuracy'),
            SizedBox(height: 16),
            _buildQualityMetricField(controller: defectsCountController, label: 'Defects Count'),

            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                String orderId = orderIdController.text;
                String batchId = batchIdController.text;
                String status = statusController.text;
                String message = messageController.text;
                String role = roleController.text;
                String date = dateController.text;
                String stitchQuality = stitchQualityController.text;
                String seamStrength = seamStrengthController.text;
                String dimensionalAccuracy = dimensionalAccuracyController.text;
                String defectsCount = defectsCountController.text;

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Updated: $orderId, $batchId, $status, $message, $role, $date, $stitchQuality, $seamStrength, $dimensionalAccuracy, $defectsCount',
                  ),
                ));
              },
              child: Text('Update'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                minimumSize: Size(double.infinity, 50),
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

  Widget _buildField({required TextEditingController controller, required String label, int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildQualityMetricField({required TextEditingController controller, required String label}) {
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
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }

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
        dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }
}
