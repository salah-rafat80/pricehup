# Codemagic UI Quick Setup Guide

## 📱 Android Debug Build (UI Configuration)

### Build Settings

**Environment:**
- Flutter version: `stable`
- Xcode version: `latest` (or `default`)
- CocoaPods version: `default`
- Build machine type: `mac_mini_m1` (or `linux_standard`)

**Build Triggers:**
- ✅ Trigger on push
- ✅ Watched branch patterns: `main` or `master`
- ⬜ Trigger on pull request (optional)
- ⬜ Trigger on tag (optional)

---

### Build Steps (Scripts)

Copy and paste each command into separate script steps in order:

#### Script 1: Install Dependencies
```bash
#!/usr/bin/env bash
set -e
set -x

flutter pub get
```

#### Script 2: Analyze Code (Optional but Recommended)
```bash
#!/usr/bin/env bash
set -e
set -x

flutter analyze
```

#### Script 3: Run Tests (Optional)
```bash
#!/usr/bin/env bash
set -e

# Run tests, but don't fail the build if tests fail
flutter test || true
```

#### Script 4: Build Android APK
```bash
#!/usr/bin/env bash
set -e
set -x

flutter build apk --debug
```

**OR for Release Build:**
```bash
#!/usr/bin/env bash
set -e
set -x

flutter build appbundle --release
```

---

### Artifacts

Add these patterns to collect build outputs:

```
build/**/outputs/**/*.apk
build/**/outputs/**/*.aab
build/**/outputs/**/mapping.txt
flutter_drive.log
```

---

### Publishing (Notifications)

**Email notifications:**
- Email: `your-email@example.com`
- ✅ Notify on build failure
- ⬜ Notify on build success (optional)

---

## 📱 Android Release Build (UI Configuration)

Same as debug, but with these changes:

### Environment Variables (Add these in Codemagic UI)

```
PACKAGE_NAME=com.example.pricehup
```

### Code Signing

1. Go to **Code signing identities** → **Android**
2. Upload your keystore file (`.jks` or `.keystore`)
3. Add the following:
   - Keystore password
   - Key alias
   - Key password

### Build Script (Replace Script 4)

```bash
#!/usr/bin/env bash
set -e
set -x

flutter build appbundle --release
```

---

## 🍎 iOS Build (UI Configuration)

### Prerequisites
- Apple Developer Account
- App Store Connect API key configured in Codemagic
- iOS distribution certificate and provisioning profile

### Environment

**Environment:**
- Flutter version: `stable`
- Xcode version: `latest`
- CocoaPods version: `default`
- Build machine type: `mac_mini_m1` (required for iOS)

### Build Steps

#### Script 1: Install Dependencies
```bash
#!/usr/bin/env bash
set -e
set -x

flutter pub get
```

#### Script 2: Install CocoaPods
```bash
#!/usr/bin/env bash
set -e
set -x

find . -name "Podfile" -execdir pod install \;
```

#### Script 3: Set up Code Signing
```bash
#!/usr/bin/env bash
set -e
set -x

xcode-project use-profiles
```

#### Script 4: Build iOS IPA
```bash
#!/usr/bin/env bash
set -e
set -x

flutter build ipa --release \
  --export-options-plist=/Users/builder/export_options.plist
```

### Artifacts

```
build/ios/ipa/*.ipa
/tmp/xcodebuild_logs/*.log
flutter_drive.log
```

---

## 🔧 Troubleshooting

### Build Fails with "Method not defined" Errors

**Solution:** This shouldn't happen in Codemagic (clean build environment), but if it does:

Add this script BEFORE "flutter pub get":
```bash
#!/usr/bin/env bash
set -e
set -x

flutter clean
```

### Build Succeeds but Warnings About Kotlin

**Status:** ✅ This is normal and can be ignored

The Kotlin daemon cache warnings don't prevent successful builds.

### Build Takes Too Long

**Solutions:**
- Use `mac_mini_m1` for faster builds
- Remove unnecessary test steps
- Cache dependencies (Codemagic does this automatically)

---

## 📊 Expected Build Times

| Build Type | Machine Type | Approximate Time |
|-----------|-------------|------------------|
| Android Debug APK | mac_mini_m1 | 3-5 minutes |
| Android Release AAB | mac_mini_m1 | 4-6 minutes |
| iOS Release IPA | mac_mini_m1 | 8-12 minutes |
| Android Debug APK | linux_standard | 5-8 minutes |

---

## ✅ Verification

After setting up, your first build should show:

```
✓ flutter pub get completed
✓ flutter analyze completed (0 issues found)
✓ flutter test completed (or skipped)
✓ flutter build apk completed
✓ Built build/app/outputs/flutter-apk/app-debug.apk
```

---

## 📞 Quick Commands Reference

**Clean build locally to verify:**
```bash
flutter clean
flutter pub get
flutter analyze
flutter build apk --debug
```

**Check Flutter version:**
```bash
flutter --version
```

**Update Flutter (if needed):**
```bash
flutter upgrade
```

---

## 🎯 Next Steps

1. ✅ Verify builds work in Codemagic
2. Set up Android code signing for release builds
3. Configure iOS code signing (if building for iOS)
4. Set up automatic deployment to stores (optional)
5. Add Slack/Discord notifications (optional)

---

## 📝 Notes

- All scripts should use `#!/usr/bin/env bash` shebang
- Always use `set -e` to fail fast on errors
- Use `set -x` to see command output for debugging
- Codemagic automatically sets `$CM_BUILD_DIR` to your project root

