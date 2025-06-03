# Building ungoogled-chromium for windows 7

The following steps assume you are building ungoogled-chromium version `<chromium_version>` (for example, ungoogled-chromium version 132.0.6834.159).

Open a command prompt and

1. Clone repos

   - Follow the steps outlined [here](https://chromium.googlesource.com/chromium/src/+/main/docs/windows_build_instructions.md) to clone the Chromium source code and download all dependencies. Assume that Chromium has been cloned to `E:\ungoogled\chromium\src`.

   - Clone [ungoogled-chromium-windows](https://github.com/ungoogled-software/ungoogled-chromium-windows), assuming it is cloned to `E:\ungoogled-chromium-windows`.

     ```bat
     git clone --recurse-submodules https://github.com/ungoogled-software/ungoogled-chromium-windows.git
     cd ungoogled-chromium-windows
     git checkout --recurse-submodules <chromium_version>
     ```

   - ```bat
     git clone https://github.com/e3kskoy7wqk/Chromium-for-windows-7.git
     ```

2. Set common variables

   ```bat
   SET _ROOT_DIR=E:\ungoogled-chromium-windows
   SET CHROMIUM=E:\ungoogled\chromium\src
   ```

3. Backup files

   ```bat
   mkdir %_ROOT_DIR%\TempDir
   ```

   ```bat
   xcopy /s /f /h %CHROMIUM%\third_party\rust\* %_ROOT_DIR%\TempDir\third_party\rust\
   xcopy /s /f /h %CHROMIUM%\third_party\rust-toolchain\* %_ROOT_DIR%\TempDir\third_party\rust-toolchain\
   xcopy /s /f /h %CHROMIUM%\third_party\llvm-build\* %_ROOT_DIR%\TempDir\third_party\llvm-build\
   mkdir %_ROOT_DIR%\TempDir\third_party\win_build_output\midl\chrome\updater\app\server\win\x64
   mkdir %_ROOT_DIR%\TempDir\third_party\win_build_output\midl\chrome\updater\app\server\win\x86
   copy /Y %CHROMIUM%\third_party\win_build_output\midl\chrome\updater\app\server\win\x64\updater_legacy_idl.tlb %_ROOT_DIR%\TempDir\third_party\win_build_output\midl\chrome\updater\app\server\win\x64\updater_legacy_idl.tlb
   copy /Y %CHROMIUM%\third_party\win_build_output\midl\chrome\updater\app\server\win\x64\updater_idl.tlb %_ROOT_DIR%\TempDir\third_party\win_build_output\midl\chrome\updater\app\server\win\x64\updater_idl.tlb
   copy /Y %CHROMIUM%\third_party\win_build_output\midl\chrome\updater\app\server\win\x86\updater_legacy_idl.tlb %_ROOT_DIR%\TempDir\third_party\win_build_output\midl\chrome\updater\app\server\win\x86\updater_legacy_idl.tlb
   copy /Y %CHROMIUM%\third_party\win_build_output\midl\chrome\updater\app\server\win\x86\updater_idl.tlb %_ROOT_DIR%\TempDir\third_party\win_build_output\midl\chrome\updater\app\server\win\x86\updater_idl.tlb
   mkdir %_ROOT_DIR%\TempDir\v8\test\torque
   copy /Y %CHROMIUM%\v8\test\torque\test-torque.tq %_ROOT_DIR%\TempDir\v8\test\torque\test-torque.tq
   ```

4. Retrieve windows downloads

   ```bat
   %_ROOT_DIR%\ungoogled-chromium\utils\downloads.py retrieve -c %_ROOT_DIR%\build\download_cache -i %_ROOT_DIR%\downloads.ini   
   ```

5. Prune binaries

   ```bat
   %_ROOT_DIR%\ungoogled-chromium\utils\prune_binaries.py %CHROMIUM% %_ROOT_DIR%\pruning.list
   ```

   ```bat
   rd /s /q %CHROMIUM%\third_party\microsoft_dxheaders\src
   mkdir %CHROMIUM%\third_party\microsoft_dxheaders\src
   rd /s /q %CHROMIUM%\third_party\node\win
   mkdir %CHROMIUM%\third_party\node\win
   rd /s /q %CHROMIUM%\third_party\rust-toolchain-x64
   mkdir %CHROMIUM%\third_party\rust-toolchain-x64
   rd /s /q %CHROMIUM%\third_party\rust-toolchain-x86
   mkdir %CHROMIUM%\third_party\rust-toolchain-x86
   rd /s /q %CHROMIUM%\third_party\rust-toolchain-arm
   mkdir %CHROMIUM%\third_party\rust-toolchain-arm
   ```

6. Unpack downloads

   ```bat
   %_ROOT_DIR%\ungoogled-chromium\utils\downloads.py unpack  -c %_ROOT_DIR%\build\download_cache -i %_ROOT_DIR%\downloads.ini -- %CHROMIUM%
   ```

7. Restore files

   ```bat
   rd /s /q %CHROMIUM%\third_party\rust
   xcopy /s /f /h %_ROOT_DIR%\TempDir\third_party\rust\* %CHROMIUM%\third_party\rust\
   rd /s /q %CHROMIUM%\third_party\rust-toolchain
   xcopy /s /f /h %_ROOT_DIR%\TempDir\third_party\rust-toolchain\* %CHROMIUM%\third_party\rust-toolchain\
   rd /s /q %CHROMIUM%\third_party\llvm-build
   xcopy /s /f /h %_ROOT_DIR%\TempDir\third_party\llvm-build\* %CHROMIUM%\third_party\llvm-build\
   copy /Y %_ROOT_DIR%\TempDir\third_party\win_build_output\midl\chrome\updater\app\server\win\x64\updater_legacy_idl.tlb %CHROMIUM%\third_party\win_build_output\midl\chrome\updater\app\server\win\x64\updater_legacy_idl.tlb
   copy /Y %_ROOT_DIR%\TempDir\third_party\win_build_output\midl\chrome\updater\app\server\win\x64\updater_idl.tlb %CHROMIUM%\third_party\win_build_output\midl\chrome\updater\app\server\win\x64\updater_idl.tlb
   copy /Y %_ROOT_DIR%\TempDir\third_party\win_build_output\midl\chrome\updater\app\server\win\x86\updater_legacy_idl.tlb %CHROMIUM%\third_party\win_build_output\midl\chrome\updater\app\server\win\x86\updater_legacy_idl.tlb
   copy /Y %_ROOT_DIR%\TempDir\third_party\win_build_output\midl\chrome\updater\app\server\win\x86\updater_idl.tlb %CHROMIUM%\third_party\win_build_output\midl\chrome\updater\app\server\win\x86\updater_idl.tlb
   mkdir %CHROMIUM%\v8\test\torque
   copy /Y %_ROOT_DIR%\TempDir\v8\test\torque\test-torque.tq %CHROMIUM%\v8\test\torque\test-torque.tq
   ```

8. Modify patches

   - Remove the following items from `%_ROOT_DIR%\patches\series`:

     - `ungoogled-chromium/windows/windows-fix-building-gn.patch`
     - `ungoogled-chromium/windows/windows-fix-generate-resource-allowed-list.patch`
     - `ungoogled-chromium/windows/windows-fix-building-with-rust.patch`

   - Modify `%_ROOT_DIR%\ungoogled-chromium\patches\core\ungoogled-chromium\fix-building-with-prunned-binaries.patch` by removing any content related to `services/passage_embeddings/passage_embeddings_service.cc` and `services/passage_embeddings/passage_embeddings_service.h`.

9. Apply patches

   - Modify `patch.bat` to ensure that the value of the `REPO_PATH` variable matches the value of the `CHROMIUM` variable.

   - Copy `patch.bat` to `%_ROOT_DIR%\ungoogled-chromium\patches` and double-click to run it.

   - Copy `patch.bat` to `%_ROOT_DIR%\patches` and double-click to run it.

   - Modify all `apply_patches.bat` files in the `<chromium_version>` directory by replacing all instances of the string `E:\ungoogled\chromium\src` with the value of the `CHROMIUM` variable. 

   - Run all `apply_patches.bat` files in the `<chromium_version>` directory. If this step is not performed, the resulting build of ungoogled-chromium will not support Windows 7.

10. Substitute domains

    ```bat
    %_ROOT_DIR%\ungoogled-chromium\utils\domain_substitution.py apply -r %_ROOT_DIR%\ungoogled-chromium\domain_regex.list -f %_ROOT_DIR%\ungoogled-chromium\domain_substitution.list -c %_ROOT_DIR%\build\domsubcache.tar.gz %CHROMIUM%
    ```

11. Invoke the build

    - ```bat
      cd /d %CHROMIUM%
      gn args out\mybuild
      ```
    
    - args.gn:

      ```
      chrome_pgo_phase=0
      enable_swiftshader=false
      ffmpeg_branding="Chrome"
      is_clang=true
      is_component_build=false
      is_debug=false
      is_official_build=true
      proprietary_codecs=true
      target_cpu="x64"
      use_sysroot=false
      dcheck_always_on=false
      blink_symbol_level=0
      v8_symbol_level=0
      symbol_level=0
      enable_rust=true
      enable_mse_mpeg2ts_stream_parser=true
      treat_warnings_as_errors = false
      ```
    
    - ```bat
      autoninja -C out\mybuild mini_installer
      ```
