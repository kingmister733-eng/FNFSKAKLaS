# Android port status

Target: make the bundled Dustin/FND mod playable on Android using the Psych Engine source in this repository.

## Working branch

- Branch: `android/mobile-port`
- Original files under `imported-zip-15A4oADt/` are kept unchanged.
- Work must be made in this branch until the Android build is validated.

## Verified source inventory

- Psych Engine source: `imported-zip-15A4oADt/Nk/source/` (159 Haxe files).
- Psych project file: `imported-zip-15A4oADt/Nk/Project.xml`.
- Psych project declares version `0.2.8`, landscape mobile orientation, fullscreen mobile window, and Android among the conditional video targets.
- Psych source includes `backend/Controls.hx`, `backend/ClientPrefs.hx`, `states/PlayState.hx`, `objects/Note.hx`, and `objects/StrumNote.hx`.
- V-Slice mobile reference source: `imported-zip-15A4oADt/Nk/source (1)/funkin/mobile/` (10 mobile Haxe files, including `FunkinButton.hx`, `FunkinHitbox.hx`, and `ControlsHandler.hx`).
- Mod/game distribution: `imported-zip-15A4oADt/fnd_demo_bug_patch_v1point5/`, with 447 files under `assets/` and 22 files under `mods/`.

## Blocking issues found

1. The Psych project root is incomplete. `Project.xml` expects `assets/fonts`, `assets/shared`, `assets/songs`, `assets/week_assets`, `assets/embed`, `art/icons`, `example_mods`, and `list.txt`, but there is no `Nk/assets/` directory in the imported tree.
2. The available `fnd_demo_bug_patch_v1point5/assets/` is a built game distribution layout, not yet verified as the matching Psych Engine source asset tree. It must be mapped and compared before copying or renaming files.
3. Psych Engine's current project defines `MODS_ALLOWED`, `HSCRIPT_ALLOWED`, and `LUA_ALLOWED` only for desktop. This means the desktop mod's Lua/script-based behavior cannot be assumed to work on Android.
4. The Psych Engine source has no existing mobile touch-control implementation. The V-Slice classes are reference code only; they cannot be copied directly because they depend on V-Slice classes and input architecture.
5. The imported V-Slice subtree does not include its own top-level `Project.xml`; it is not a standalone build target in this import.
6. No repository license file was found at the checked tree paths. Confirm upstream license/attribution requirements before redistributing a built APK.

## Implementation sequence

1. Identify the mod's exact engine version, metadata, Lua scripts, custom note types/events, and asset dependencies.
2. Reconstruct a valid Psych Engine project root without changing the imported originals. Add only verified matching assets and mod files.
3. Implement a Psych-native Android touch overlay with four lanes, simultaneous touch IDs, press/hold/release semantics, configurable visibility/alpha/position, and correct pause/menu behavior.
4. Route touch states through Psych Engine's existing `Controls` / note-hit and sustain-note logic; do not simulate keyboard events if native control states can be used.
5. Audit Android-incompatible dependencies and script APIs. Keep unsupported mod features clearly reported rather than silently dropping them.
6. Add a dedicated GitHub Actions Android build workflow only after the project root and dependencies are complete.
7. Build a debug APK, inspect the complete build log, install-test on Android, then build a release APK.

## Acceptance criteria

- APK installs and launches on Android.
- Main menu and freeplay/story navigation are touch-operable.
- The target mod appears and launches with its required assets.
- Four touch lanes work simultaneously (multi-touch).
- Sustain notes remain held until the corresponding finger is released.
- No missing asset, script, or dependency errors during the target song.
- Build workflow produces a downloadable APK artifact.

## Important

A successful compile alone is not proof that the mod works. The target mod must be launched and played on a real Android device, and any unsupported Lua, HScript, custom event, video, or native-library behavior must be tested explicitly.
