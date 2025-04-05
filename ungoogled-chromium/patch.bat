@echo off
setlocal EnableDelayedExpansion

REM Set the path to the repository
set "REPO_PATH=E:\ungoogled\chromium\src"

REM Apply patches and commit changes for each commit
for /f %%a in (series) do (
    REM Check and apply patch, ignoring whitespace changes
    git -C "!REPO_PATH!" apply --check --verbose --ignore-space-change "%~dp0%%a"
    if errorlevel 1 (
        echo Failed to apply patch for commit: %%a
        goto end
    ) else (
        git -C "!REPO_PATH!" apply --ignore-space-change "%~dp0%%a"
    )
)

echo All patches applied and committed successfully.

:end
REM Clean up temporary file
endlocal
pause
