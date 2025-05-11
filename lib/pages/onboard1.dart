import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'https://images.pexels.com/photos/3038539/pexels-photo-3038539.jpeg?cs=srgb&dl=pexels-chaman-kumar-1566771-3038539.jpg&fm=jpg',
      'title': 'Welcome to FiberSync',
      'desc': 'Start your journey with FiberSync SCM today.'
    },
    {
      'image': 'https://c1.wallpaperflare.com/preview/242/963/793/fabric-colorful-quilting-cotton.jpg',
      'title': 'Field Agent App',
      'desc': 'Focuses on the ability to track orders and inventory, and never be late for any detail. Generate reports.'
    },
    {
      'image': 'https://static.vecteezy.com/system/resources/previews/060/432/959/non_2x/london-check-pattern-plaid-glen-background-texture-textile-site-tartan-seamless-fabric-in-cyan-and-light-colors-vector.jpg',
      'title': 'Trusted and Secure',
      'desc': 'We aspire to build a future where textile supply chains are transparent, agile, and trusted at every step.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _controller,
        itemCount: onboardingData.length,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  child: Image.network(
                    onboardingData[index]['image']!,
                    height: 500,
                    fit: BoxFit.cover, // Ensures the image fills the box nicely
                    width: 300, // Makes the image span the available width
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  onboardingData[index]['title']!,
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF39FF14), // neon green
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  onboardingData[index]['desc']!,
                  style:  GoogleFonts.montserrat(fontSize: 12, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: Colors.white,
        width: double.infinity,
        child: _currentPage == onboardingData.length - 1
            ? ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF39FF14),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Get Started"),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () =>
                        _controller.jumpToPage(onboardingData.length - 1),
                    child: const Text("Skip",
                        style: TextStyle(color: Colors.black)),
                  ),
                  Row(
                    children: List.generate(
                      onboardingData.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 12 : 8,
                        height: _currentPage == index ? 12 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? const Color(0xFF39FF14)
                              : Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _controller.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    ),
                    child: const Text("Next",
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
      ),
    );
  }
}

