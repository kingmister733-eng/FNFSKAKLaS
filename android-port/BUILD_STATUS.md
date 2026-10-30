# Current Android build status

Branch: `android/mobile-port-assets-audit`

The Android workflow has been added at `.github/workflows/android-apk.yml`. Its build directory now uses the GitHub workspace context rather than the runner context, and it runs on branch pushes or manual dispatch.

The two initial workflow runs completed with zero jobs, so they did not reach asset staging or Haxe compilation. The workflow configuration has since been corrected. The next run must confirm that GitHub starts the job, stages the uploaded files, installs the toolchain, and compiles the APK.

No APK is available yet. Do not treat a successful staging step as proof that the target mod, Lua/HScript scripts, touchscreen controls, or sustain notes work on Android.
