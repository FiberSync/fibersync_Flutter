import 'package:flutter/material.dart';

class DyeingAgentPage extends StatefulWidget {
  @override
  _DyeingAgentPageState createState() => _DyeingAgentPageState();
}

class _DyeingAgentPageState extends State<DyeingAgentPage> {
  TextEditingController orderIdController = TextEditingController();
  TextEditingController batchIdController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  
  // Quality Metrics Controllers
  TextEditingController colorFastnessController = TextEditingController();
  TextEditingController phLevelController = TextEditingController();
  TextEditingController shrinkageController = TextEditingController();
  TextEditingController defectsController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF39FF14),
        title: Text(
          'Dyeing Agent',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dyeing Agent Remarks',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Existing Fields
              TextField(
                controller: orderIdController,
                decoration: InputDecoration(
                  labelText: 'Order ID',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: batchIdController,
                decoration: InputDecoration(
                  labelText: 'Batch ID',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: statusController,
                decoration: InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: messageController,
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 16),
              TextField(
                controller: roleController,
                decoration: InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
              ),
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
              SizedBox(height: 16),
              // Quality Metrics Section
              Text(
                'Quality Metrics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF39FF14),
                ),
              ),
              SizedBox(height: 12),
              // Quality Metric Fields
              _buildQualityMetricField(controller: colorFastnessController, label: 'Color Fastness'),
              SizedBox(height: 16),
              _buildQualityMetricField(controller: phLevelController, label: 'pH Level'),
              SizedBox(height: 16),
              _buildQualityMetricField(controller: shrinkageController, label: 'Shrinkage'),
              SizedBox(height: 16),
              _buildQualityMetricField(controller: defectsController, label: 'Defects'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle update button press
                  String orderId = orderIdController.text;
                  String batchId = batchIdController.text;
                  String status = statusController.text;
                  String message = messageController.text;
                  String role = roleController.text;
                  String date = dateController.text;
                  String colorFastness = colorFastnessController.text;
                  String phLevel = phLevelController.text;
                  String shrinkage = shrinkageController.text;
                  String defects = defectsController.text;

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Data Updated: $orderId, $batchId, $status, $message, $role, $date, $colorFastness, $phLevel, $shrinkage, $defects'),
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
      ),
    );
  }

  // Single method for creating stylish field for Quality Metrics
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
        keyboardType: TextInputType.number,
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
