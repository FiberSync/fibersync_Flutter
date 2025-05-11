import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true, splitScreenMode: true);

    return Stack(
      children: [
        // Background image with black overlay
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://c1.wallpaperflare.com/preview/974/76/44/fabric-textile-color-image-copy-space.jpg'), // Replace with your network image URL
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 150.h),
                  // Title section
                  Container(
                    height: 80.h,
                    child: Center(
                      child: Text(
                        'FiberSync',
                        style: GoogleFonts.poppins(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF39FF14),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50.h,
                    child: Center(
                      child: Text(
                        'Field Agent App',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF39FF14),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Column(
                      children: [
                        // Employee ID, Name, and Role input fields
                        CustomTextField(
                          icon: Icons.image_search,
                          hint: 'Employee ID',
                          inputType: TextInputType.number,
                          inputAction: TextInputAction.next,
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          icon: Iconsax.user,
                          hint: 'Name',
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          icon: Icons.work,
                          hint: 'Role',
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.done,
                        ),
                        SizedBox(height: 50.h),
                        // Login button
                        CustomRoundedButton(buttonText: 'Login'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Custom Text Input Widget
class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;

  const CustomTextField({
    required this.icon,
    required this.hint,
    required this.inputType,
    required this.inputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      keyboardType: inputType,
      textInputAction: inputAction,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.black.withOpacity(0.6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// Custom Rounded Button Widget
class CustomRoundedButton extends StatelessWidget {
  final String buttonText;

  const CustomRoundedButton({required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // Add your button press logic here (e.g., login functionality)
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('employee_id', '123456');
        await prefs.setString('name', 'John Doe');
        await prefs.setString('role', 'Field Agent');
        // await storage.write(key: 'employee_id', value: '123456');
        // await storage.write(key: 'name', value: 'John Doe');
        // await storage.write(key: 'role', value: 'Field Agent');
        Navigator.pushNamed(context, '/home');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF39FF14), // Button color (primary)
        foregroundColor: Colors.black, // Text color (onPrimary)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.h),
        minimumSize: Size(double.infinity, 50.h),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
