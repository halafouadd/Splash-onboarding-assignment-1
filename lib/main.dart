import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primaryColor: const Color(0xFF5A55CA),
        scaffoldBackgroundColor: Colors.white,
        
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1D1B20), 
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color(0xFF4A494B), 
          ),
        ),
        useMaterial3: true,
        
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5A55CA),
          brightness: Brightness.light,
        ),
      ),
      home: const OnboardingScreen(),
    );
  }
}

//onboarding constructor  

class OnboardingItem {
  final String imagePath;
  final String title;
  final String description;

  OnboardingItem({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}


final List<OnboardingItem> onboardingData = [
  OnboardingItem(
    imagePath: 'assets/onboarding_1.png', 
    title: 'Welcome to the Future of News',
    description: 'Get the latest headlines, personalized to your interests and location, all in one place.',
  ),
  OnboardingItem(
    imagePath: 'assets/onboarding_2.png',
    title: 'Real-Time Updates & Alerts',
    description: 'Stay ahead of the curve with instant notifications for breaking news and major events.',
  ),
  OnboardingItem(
    imagePath: 'assets/onboarding_3.png', 
    title: 'Customize Your Feed',
    description: 'Select your preferred topics, sources, and regions to build your perfect daily briefing.',
  ),
  OnboardingItem(
    imagePath: 'assets/onboarding_4.png', 
    title: 'Start Your Reading Journey',
    description: 'Ready to dive into a world of curated content? Tap Get Started to begin.',
  ),
];

//widgets

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _goToNextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _goToLoginScreen();
    }
  }

  void _goToLoginScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLastPage = _currentPage == onboardingData.length - 1;
    final primaryColor = Theme.of(context).colorScheme.primary; 

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _goToLoginScreen,
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // Page View
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  return OnboardingPage(item: onboardingData[index]);
                },
              ),
            ),

            // Indicator Dots and Controls
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Indicators
                  Row(
                    children: List.generate(
                      onboardingData.length,
                          (index) => IndicatorDot(
                        isActive: index == _currentPage,
                        color: primaryColor,
                      ),
                    ),
                  ),

                  // Next/Get Started Button
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _goToNextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        isLastPage ? 'Get Started' : 'Next',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IndicatorDot extends StatelessWidget {
  final bool isActive;
  final Color color;

  const IndicatorDot({
    super.key,
    required this.isActive,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    
    final Color inactiveColor = color.withAlpha(77);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 30.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? color : inactiveColor,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //  Image
          Image.asset(
            item.imagePath,
            height: 250,
            width: 250,
            fit: BoxFit.contain,
            
            errorBuilder: (context, error, stackTrace) {
              final primaryColor = Theme.of(context).colorScheme.primary;
              final Color lightPrimary = primaryColor.withAlpha(26);
              final Color mediumPrimary = primaryColor.withAlpha(128);

              return Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  color: lightPrimary,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: mediumPrimary,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 100,
                  color: primaryColor,
                ),
              );
            },
          ),
          const SizedBox(height: 50),

          // Title
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

//login screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() {
    // Simple validation and message box instead of alert()
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showMessage(context, 'Please enter both email and password.');
    } else {
      // Logic for signing in goes here
      _showMessage(context, 'Attempting login for ${_emailController.text}...');
    }
  }

  void _showMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text('Login Status'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    
    final Color semiTransparentPrimary = primaryColor.withAlpha(178);


    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 40),

            // App Logo
            Text(
              'News Hub',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Welcome Back!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 60),

            // Email Field
            _buildTextField(
              context: context,
              controller: _emailController,
              label: 'Email Address',
              icon: Icons.email_outlined,
            ),
            const SizedBox(height: 20),

            // Password Field
            _buildTextField(
              context: context,
              controller: _passwordController,
              label: 'Password',
              icon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 10),

            // Forgot Password Link
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => _showMessage(context, 'Forgot Password functionality is not implemented yet.'),
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: semiTransparentPrimary),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Sign In Button
            ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Or sign in with
            Row(
              children: <Widget>[
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Or sign in with',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 20),

            // Social Login Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialButton(context, Icons.facebook, 'Facebook'),
                _buildSocialButton(context, Icons.g_mobiledata, 'Google'),
              ],
            ),
            const SizedBox(height: 60),

            // Don't have an account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                TextButton(
                  onPressed: () => _showMessage(context, 'Sign Up screen is not implemented yet.'),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    
    final Color semiTransparentPrimary = primaryColor.withAlpha(178);

    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Color(0xFF1D1B20)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: primaryColor),
        prefixIcon: Icon(icon, color: semiTransparentPrimary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  // Helper function to build social login buttons
  Widget _buildSocialButton(BuildContext context, IconData icon, String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: OutlinedButton.icon(
          onPressed: () => _showMessage(context, 'Logging in with $label...'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
          ),
          icon: const Icon(Icons.abc, color: Colors.black, size: 24), // Placeholder icon
          label: Text(
            label,
            style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}