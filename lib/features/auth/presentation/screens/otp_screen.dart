import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/size_config.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../providers/auth_providers.dart';

/// OTP verification screen
class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  Future<void> _verifyOtp() async {
    final authViewModel = ref.read(authViewModelProvider.notifier);
    final isValid = await authViewModel.verifyOtpCode(_otp);

    if (isValid && mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final authState = ref.watch(authViewModelProvider);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تأكيد الكود'),

          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.w(6)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image(
                            image: const AssetImage(
                              'assets/Image (FAP Logo).png',
                            ),
                          ),
                          Text(
                            'رمز التحقق',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: SizeConfig.sp(12),
                              color: const Color(0xFFE81923),
                            ),
                          ),
                          SizedBox(height: SizeConfig.h(1)),
                          Text(
                            'تم إرسال الكود إلى رقمك على واتساب',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: SizeConfig.sp(8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: SizeConfig.h(1)),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: SizeConfig.w(2),
                            runSpacing: SizeConfig.h(1.5),
                            children: List.generate(6, (index) {
                              return Container(
                                width: isLandscape
                                    ? SizeConfig.w(10)
                                    : SizeConfig.w(12),
                                constraints: const BoxConstraints(
                                  maxWidth: 65,
                                  minWidth: 45,
                                ),
                                child: TextField(
                                  controller: _controllers[index],
                                  focusNode: _focusNodes[index],
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: SizeConfig.sp(10),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: SizeConfig.h(1.3),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty && index < 5) {
                                      _focusNodes[index + 1].requestFocus();
                                    } else if (value.isEmpty && index > 0) {
                                      _focusNodes[index - 1].requestFocus();
                                    }

                                    if (index == 5 && value.isNotEmpty) {
                                      _verifyOtp();
                                    }
                                  },
                                ),
                              );
                            }),
                          ),
                          if (authState.error != null) ...[
                            SizedBox(height: SizeConfig.h(2)),
                            Text(
                              authState.error!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: SizeConfig.sp(4.5),
                              ),
                            ),
                          ],
                          SizedBox(
                            height: isLandscape
                                ? SizeConfig.h(2)
                                : SizeConfig.h(4),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.h(0.5),
                              ),
                            ),
                            onPressed: authState.isLoading ? null : _verifyOtp,
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
                                    'تأكيد',
                                    style: TextStyle(
                                      fontSize: SizeConfig.sp(10),
                                    ),
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
