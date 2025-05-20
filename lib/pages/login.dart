import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:iconsax/iconsax.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final url = Uri.parse('https://fiberportal-backend.vercel.app/api/faUser/auth'); // Replace with your URL
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'employeeId': _employeeIdController.text.trim(),
        'name': _nameController.text.trim(),
        'role': _roleController.text.trim(),
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['auth'] == true) {
      final agent = data['agent'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('agent_id', agent['employeeId'].toString());
      await prefs.setString('agent_name', agent['name'].toString());
      await prefs.setString('agent_role', agent['id'].toString());

      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        title: 'Success',
        desc: 'Welcome ${agent['name']}!',
        btnOkOnPress: () => Navigator.pushReplacementNamed(context, '/home'),
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Login Failed',
        desc: data['message'] ?? 'Authentication failed',
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true, splitScreenMode: true);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://c1.wallpaperflare.com/preview/974/76/44/fabric-textile-color-image-copy-space.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.darken),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 100.h),
                  Text(
                    'FiberSync',
                    style: GoogleFonts.poppins(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF39FF14),
                    ),
                  ),
                  Text(
                    'Field Agent App',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _employeeIdController,
                          icon: Icons.badge,
                          hint: 'Employee ID',
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          controller: _nameController,
                          icon: Iconsax.user,
                          hint: 'Name',
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          controller: _roleController,
                          icon: Icons.work,
                          hint: 'Role',
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.done,
                        ),
                        SizedBox(height: 50.h),
                        CustomRoundedButton(
                          buttonText: 'Login',
                          onPressed: () => _login(context),
                        ),
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

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;

  const CustomTextField({
    required this.controller,
    required this.icon,
    required this.hint,
    required this.inputType,
    required this.inputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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

class CustomRoundedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomRoundedButton({required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF39FF14),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.h),
        minimumSize: Size(double.infinity, 50.h),
      ),
      child: Text(
        buttonText,
        style: GoogleFonts.spaceGrotesk(
          fontSize: 16.sp,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),
    );
  }
}
