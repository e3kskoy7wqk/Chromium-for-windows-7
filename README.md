# ![](imgs/product_logo_64.png)Chromium for windows 7![](imgs/windows.png)

Chromium is an open-source browser project that aims to build a safer, faster, and more stable way for all users to experience the web.

Chrome 109 is the last version to support Windows 7. This repository includes patches that enable Chromium to run on Windows 7 beyond the official end-of-support date, allowing users to continue using the latest features and improvements from the Chromium project.

I have successfully created  patches to make Chromium work again on Windows 7 since October 2023  (though I didn’t release them immediately). Now, two years later, I have continued to apply these patches to newer versions of Chromium by  making minor adjustments on these patches. However, several growing challenges have  forced me to reevaluate the viability of these outdated patches. These  challenges include: (1) the presence of minor but difficult-to-fix bugs  in the patches, and (2) the increasing difficulty of adapting the  patches to newer Chromium versions due to major ongoing changes in Chromium UI code.

Given these  challenges, I have decided to spend the next few months reworking the  patches in an attempt to create new ones that address the challenges  mentioned above. If the rework successfully resolves these challenges,  Chromium for windows 7 will be built using the new patches. Otherwise,  Chromium for Windows 7 will no longer update. During this  rework period, Chromium for windows 7 will continue update but at a slower pace.

## Platform Support

Windows 7 SP1 with KB3080149 (for EventSetInformation) and KB4019990 (for d3dcompiler_47.dll) installed, Windows 8, Windows 10, Windows 11.

![](imgs/snapshot.png)

## Building

1. Follow the steps in [the instructions on how to get the code](https://chromium.googlesource.com/chromium/src/+/main/docs/windows_build_instructions.md) until the command `autoninja -C out\Default chrome`. 

   **Note**: These patches have only been tested on Chromium versions 122.0.6261.34, 122.0.6261.116, 123.0.6312.16, 123.0.6312.32, 124.0.6338.2, 124.0.6341.0, 124.0.6345.0, 124.0.6349.1, 124.0.6352.2, 124.0.6365.1, 124.0.6367.14, 125.0.6384.1, 125.0.6386.0, 125.0.6392.1, 125.0.6394.1, 125.0.6400.1, ..., and may not work on other versions. Therefore, you may need to use `git checkout` to switch to the corresponding Chromium version.

   **Note**: Setting `target_cpu = "x86"` to build the 32-bit version, setting `target_cpu = "x64"` to build the 64-bit version, and other values for `target_cpu` are not supported.

   The suggested content in args.gn is:

   ```
   is_official_build = true
   is_component_build = false
   is_debug = false
   target_cpu = "x86"
   target_os = "win"
   ffmpeg_branding="Chrome"
   proprietary_codecs=true
   treat_warnings_as_errors = false
   ```

2. git clone https://github.com/e3kskoy7wqk/Chromium-for-windows-7.git.

3. Replace the string "E:\win7dep\chromium\src" with the location of the Chromium source code in **ALL** files named 'apply_patches.bat' in this repository.

4. Enter the appropriate directory based on the Chromium version you want to patch (e.g. 123.0.6312.16), then run **ALL** of the 'apply_patches.bat' files in the directory.

5. `autoninja -C out\Default chrome`
