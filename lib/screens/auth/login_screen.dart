import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:flex_yemen/theme/app_theme.dart';
import 'package:flex_yemen/providers/auth_provider.dart';
import 'package:flex_yemen/core/utils/validators.dart';
import 'package:flex_yemen/core/utils/helpers.dart';
import 'package:flex_yemen/screens/auth/register_screen.dart';
import 'package:flex_yemen/screens/auth/forgot_password_screen.dart';
import 'package:flex_yemen/screens/home/main_navigation.dart';
import 'package:flex_yemen/widgets/common/custom_button.dart';
import 'package:flex_yemen/widgets/common/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    final success = await authProvider.signIn(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => MainNavigation()),
      );
    } else if (mounted) {
      Helpers.showSnackBar(
        context,
        message: authProvider.error ?? 'فشل تسجيل الدخول',
        isError: true,
      );
    }
  }

  void _loginAsGuest() {
    Helpers.showSnackBar(
      context,
      message: 'تم الدخول كضيف - بعض الميزات مقيدة',
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => MainNavigation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark 
                ? [AppColors.darkBg, AppColors.darkSurface]
                : [AppColors.lightBg, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40),
                  
                  // الشعار
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.goldPrimary,
                            AppColors.goldLight,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.goldPrimary.withOpacity(0.3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.shopping_bag,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  )
                  .animate()
                  .scale(duration: 500.ms, curve: Curves.easeOutBack),
                  
                  SizedBox(height: 30),
                  
                  // عنوان الترحيب
                  Text(
                    'مرحباً بعودتك!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 200.ms)
                  .slideY(begin: 0.3, end: 0),
                  
                  SizedBox(height: 10),
                  
                  Text(
                    'سجل الدخول للمتابعة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 16,
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 300.ms),
                  
                  SizedBox(height: 40),
                  
                  // حقل البريد/الهاتف
                  CustomTextField(
                    controller: _emailController,
                    label: 'البريد الإلكتروني أو رقم الهاتف',
                    hint: 'أدخل بريدك الإلكتروني أو رقم هاتفك',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;
                    },
                  )
                  .animate()
                  .fadeIn(delay: 400.ms)
                  .slideX(begin: -0.2, end: 0),
                  
                  SizedBox(height: 20),
                  
                  // حقل كلمة المرور
                  CustomTextField(
                    controller: _passwordController,
                    label: 'كلمة المرور',
                    hint: 'أدخل كلمة المرور',
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: _obscurePassword 
                        ? Icons.visibility_outlined 
                        : Icons.visibility_off_outlined,
                    onSuffixTap: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    obscureText: _obscurePassword,
                    validator: Validators.password,
                  )
                  .animate()
                  .fadeIn(delay: 500.ms)
                  .slideX(begin: -0.2, end: 0),
                  
                  SizedBox(height: 16),
                  
                  // تذكرني ونسيت كلمة المرور
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        activeColor: AppColors.goldPrimary,
                      ),
                      Text(
                        'تذكرني',
                        style: TextStyle(
                          fontFamily: 'Changa',
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'نسيت كلمة المرور؟',
                          style: TextStyle(
                            fontFamily: 'Changa',
                            color: AppColors.goldPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
                  .animate()
                  .fadeIn(delay: 600.ms),
                  
                  SizedBox(height: 24),
                  
                  // زر تسجيل الدخول
                  CustomButton(
                    text: 'تسجيل الدخول',
                    onPressed: _login,
                    isLoading: authProvider.isLoading,
                  )
                  .animate()
                  .fadeIn(delay: 700.ms)
                  .scale(begin: Offset(0.9, 0.9), end: Offset(1, 1)),
                  
                  SizedBox(height: 20),
                  
                  // أو
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'أو',
                          style: TextStyle(
                            fontFamily: 'Changa',
                            color: isDark ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  )
                  .animate()
                  .fadeIn(delay: 800.ms),
                  
                  SizedBox(height: 20),
                  
                  // دخول كضيف
                  OutlinedButton.icon(
                    onPressed: _loginAsGuest,
                    icon: Icon(Icons.person_outline),
                    label: Text(
                      'الدخول كضيف',
                      style: TextStyle(fontFamily: 'Changa'),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: AppColors.goldPrimary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 900.ms),
                  
                  SizedBox(height: 30),
                  
                  // إنشاء حساب
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ليس لديك حساب؟',
                        style: TextStyle(
                          fontFamily: 'Changa',
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'إنشاء حساب',
                          style: TextStyle(
                            fontFamily: 'Changa',
                            color: AppColors.goldPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                  .animate()
                  .fadeIn(delay: 1000.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
