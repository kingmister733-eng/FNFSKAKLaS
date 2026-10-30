# Android port audit — updated assets inventory

Branch: `android/mobile-port-assets-audit`

## Confirmed repository layout on `main`

The uploaded material is split across directories; it is not one self-contained project root.

- Psych Engine project file: `imported-zip-15A4oADt/Nk/Project.xml`
- Psych Engine source tree: `imported-zip-15A4oADt/Nk/source/`
- V-Slice source tree: `imported-zip-15A4oADt/Nk/source (1)/`
- Additional game asset tree: `imported-zip-15A4oADt/Nkk/assets/`
- Separate Windows game distribution: `imported-zip-15A4oADt/fnd_demo_bug_patch_v1point5/`

The Psych `Project.xml` points to a sibling `assets/` directory and includes a `BASE_GAME_FILES` section which maps `assets/base_game` into the built game's assets. The new `Nkk/assets` directory contains `base_game`, `fonts`, `shared`, `songs`, `embed`, `secrets`, and other asset folders. This is a promising match for the Psych project, but it must be staged as `Nk/assets` for the project file to see it.

## Android blockers still to resolve

- `MODS_ALLOWED`, `HSCRIPT_ALLOWED`, and `LUA_ALLOWED` are currently defined only for `desktop` in `Project.xml`. Android builds will not automatically enable the desktop mod/script runtime.
- The supplied Windows distribution contains Windows binaries and libraries; those files cannot be reused in an Android APK.
- The Psych source has no verified mobile touch overlay yet. Touch must be wired into the actual Psych input/control path, including press, release, simultaneous lanes, and sustain holds.
- The V-Slice mobile source is a separate codebase and is reference material only; it must not be copied wholesale into Psych Engine.
- The supplied `Nkk/assets` tree does not currently show all optional paths named by `Project.xml` (for example `videos`, `week_assets`, and `translations`). Confirm which are required by the chosen defines and add empty placeholders only where the build system requires them.
- Dependency versions and Android toolchain requirements still need to be pinned from the source/workflow configuration before enabling a CI build.

## Next implementation sequence

1. Assemble a clean Psych project root in CI by copying `Nk/` to a staging directory and placing `Nkk/assets/` at the staging root as `assets/`.
2. Validate the asset tree against every active `<assets path=...>` entry in `Project.xml`.
3. Audit Psych Lua/HScript and mod-loading code for Android-compatible dependencies; do not enable unsupported runtimes blindly.
4. Implement a Psych-native Android touch layer and connect it to `backend/Controls.hx` / gameplay input.
5. Add a debug Android build workflow only after steps 1–4 pass.
6. Install-test the APK on a real Android device; verify menu navigation, song launch, four-lane multitouch, releases, and sustain notes.

## Acceptance criteria

- APK installs and opens without crashing.
- Menus and song selection respond to touch.
- The target mod and its charts/assets load without missing-resource errors.
- Four-lane multitouch works; held notes remain held until touch release.
- Android build logs contain no unresolved native library or script-runtime errors.
- CI uploads a reproducible debug APK artifact.

**Status:** asset/source inventory is now clearer; no Android APK has been built or validated yet.
