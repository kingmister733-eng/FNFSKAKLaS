# Android APK build workflow

The workflow is `.github/workflows/android-apk.yml`.

## What it does

1. Checks out this repository.
2. Clones the official Psych Engine repository at the pinned upstream commit `5c67ced49e5a98535298a6daa3f8f4ec79ac8399` to supply project scaffolding that was not included in the uploaded `Nk` folder (setup scripts, icons, templates, and build support).
3. Replaces the upstream `source/` and `Project.xml` with the uploaded files from `imported-zip-15A4oADt/Nk/`.
4. Replaces the upstream `assets/` directory with the uploaded assets from `imported-zip-15A4oADt/Nkk/assets/`.
5. Disables Discord RPC and VLC video integration for this Android build. The imported project enables both in its desktop-oriented configuration; they are not assumed to be Android-safe.
6. Installs the Haxe libraries and Android toolchain, then runs `lime build android -D officialBuild`.
7. Uploads any generated APK and the build log as a GitHub Actions artifact.

The V-Slice source directory `Nk/source (1)/` is intentionally not copied into the Psych Engine project. It is a separate engine codebase.

## Run it

- Open the repository on GitHub.
- Select branch `android/mobile-port-assets-audit`.
- Open **Actions** → **Android APK (Psych Engine + uploaded assets)**.
- Choose **Run workflow** and run it on `android/mobile-port-assets-audit`.
- Open the new run. If it succeeds, download the artifact named `psych-engine-android-build`.

## Important scope and known limitations

This is the first reproducible Android build attempt, not a claim that the target mod is already playable. The imported Psych Engine configuration only enables its Lua, HScript, and mod-loader defines for desktop. This workflow preserves that restriction rather than turning on unverified Android script runtimes. The first build therefore tests whether the uploaded Psych source and game assets can compile into an Android APK; it does not yet certify the target mod's scripts, mod-specific content, touch gameplay, or sustain-note handling.

The uploaded source tree also lacked the normal Psych project scaffolding. The workflow borrows that scaffolding from the pinned upstream Psych Engine commit while replacing the actual game source and assets with the user's uploaded files. Review upstream and mod licenses before distributing a resulting APK.
