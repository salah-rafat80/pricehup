import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'core/constants/app_theme.dart';
import 'core/utils/security_service.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Enable screen security to prevent screenshots and screen recording - MANDATORY
  if (Platform.isAndroid) {
    await SecurityService.enableScreenSecurity();
  }

  await di.init();
  runApp(const ProviderScope(child: PriceHupApp()));
}

class PriceHupApp extends StatelessWidget {
  const PriceHupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PriceHup',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        final mq = MediaQuery.of(context);
        // احسب معامل التكبير الحالي ثم قم بتقييده ضمن نطاق معقول
        final current = mq.textScaler.scale(1.0);
        final clamped = current.clamp(0.9, 1.3);
        return MediaQuery(
          data: mq.copyWith(textScaler: TextScaler.linear(clamped.toDouble())),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const SecureWrapper(child: LoginScreen()),
    );
  }
}

/// Wrapper widget to ensure screen security on every screen
class SecureWrapper extends StatefulWidget {
  final Widget child;
  const SecureWrapper({super.key, required this.child});

  @override
  State<SecureWrapper> createState() => _SecureWrapperState();
}

class _SecureWrapperState extends State<SecureWrapper> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Re-enable security when app comes to foreground
    _ensureSecurity();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Re-enable security when app comes back to foreground
      _ensureSecurity();
    }
  }

  Future<void> _ensureSecurity() async {
    if (Platform.isAndroid) {
      await SecurityService.enableScreenSecurity();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
