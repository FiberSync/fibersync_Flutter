import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF39FF14), // Custom header color
        title: Text(
          'FiberSync Field Agent App',
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Text(
                'Welcome to FiberSync',
                style: GoogleFonts.poppins(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF39FF14),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Efficient solutions for managing agents and operations in the textile industry.',
                style: GoogleFonts.poppins(
                  fontSize: 10.sp,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 30.h),

              // Buttons Section
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 20.h,
                childAspectRatio: 1.0,
                children: [
                  _buildSquareButton(context, 'Procurement Agent', Icons.shopping_cart, '/procurementAgent'),
                  _buildSquareButton(context, 'Spinning Agent', Icons.loop, '/spinningAgent'),
                  _buildSquareButton(context, 'Dyeing Agent', Icons.color_lens, '/dyeingAgent'),
                  _buildSquareButton(context, 'Manufacturing Agent', Icons.factory, '/manufacturingAgent'),
                   _buildSquareButton(context, 'Weaving Agent', Icons.adobe_sharp, '/weavingAgent'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom method to create square buttons
  Widget _buildSquareButton(BuildContext context, String title, IconData icon, String route) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to the respective agent page
        Navigator.pushNamed(context, route);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF39FF14), // Button color
        foregroundColor: Colors.black, // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(15.w),
        minimumSize: Size(double.infinity, 150.h),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40.sp,
            color: Colors.white,
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
