# ![](imgs/product_logo_64.png)Chromium for windows 7![](imgs/windows.svg)

Chromium for windows 7 is an open-source browser project that aims to build a safer, faster,
and more stable way for all users to experience the web on windows 7.

## Platform Support

Windows 7, 8, 10, 11.

## Building

1. Follow the steps in [the instructions on how to get the code](https://chromium.googlesource.com/chromium/src/+/refs/tags/122.0.6261.34/docs/windows_build_instructions.md) until the command `autoninja -C out\Default chrome`. 

   Note: Ensure that "clang_use_chrome_plugins = false" is included in args.gn. The suggested content in args.gn is:

   ```makefile
   is_official_build = true
   is_component_build = false
   is_debug = false
   target_cpu = "x86"
   target_os = "win"
   clang_use_chrome_plugins = false
   ```

2. git clone this repository.

3. Find **ALL** apply_patches.bat files and replace the string "E:\workspace\chromium\src" with the location where the chromium source code is stored.

4. Execute **ALL** apply_patches.bat files to patch the Chromium source code to support Windows 7.

   Note: These patches have only been tested on Chromium version 122.0.6261.34. The patches should also be applicable to versions with the major version 122, but it's hard to say whether they will work on versions such as 121.x.yyyy.zzz or 123.a.bbbb.ccc.

5. `autoninja -C out\Default chrome`

6. enjoy!

