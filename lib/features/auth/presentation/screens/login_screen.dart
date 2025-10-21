import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/size_config.dart';
import '../providers/auth_providers.dart';
import 'otp_screen.dart';

/// Login screen where user enters mobile number
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _mobileController = TextEditingController();

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final authState = ref.watch(authViewModelProvider);
    final authViewModel = ref.read(authViewModelProvider.notifier);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    // Listen to OTP sent state
    ref.listen(authViewModelProvider, (previous, next) {
      if (next.isOtpSent && previous?.isOtpSent != true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const OtpScreen()),
        );
      }

      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تسجيل الدخول'),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.w(6)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Icon(
                            Icons.phone_android,
                            size: isLandscape ? SizeConfig.w(15) : SizeConfig.w(20),
                            color: const Color(0xFFD4AF37),
                          ),
                          SizedBox(height: isLandscape ? SizeConfig.h(2) : SizeConfig.h(3)),
                          Text(
                            'مرحباً بك',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: SizeConfig.sp(10),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: SizeConfig.h(1)),
                          Text(
                            'الرجاء إدخال رقم جوالك للمتابعة',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: SizeConfig.sp(8),
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: isLandscape ? SizeConfig.h(3) : SizeConfig.h(5)),
                          TextField(
                            controller: _mobileController,
                            keyboardType: TextInputType.phone,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(fontSize: SizeConfig.sp(8)),
                            decoration: InputDecoration(
                              labelText: 'رقم الجوال',
                              labelStyle: TextStyle(fontSize: SizeConfig.sp(8)),
                              hintText: '05xxxxxxxx',
                              hintStyle: TextStyle(fontSize: SizeConfig.sp(8)),
                              prefixIcon: Icon(Icons.phone, size: SizeConfig.w(6)),
                            ),
                            onChanged: authViewModel.setMobileNumber,
                          ),
                          SizedBox(height: SizeConfig.h(3)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: SizeConfig.h(2)),
                            ),
                            onPressed: authState.isLoading
                                ? null
                                : () => authViewModel.sendOtp(),
                            child: authState.isLoading
                                ? SizedBox(
                                    height: SizeConfig.h(3),
                                    width: SizeConfig.h(3),
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'متابعة',
                                    style: TextStyle(fontSize: SizeConfig.sp(10)),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
