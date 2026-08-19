@echo off
setlocal

rem Install the Windows PowerShell profile package with GNU Stow.
set "CYGWIN_BASH=C:\cygwin64\bin\bash.exe"
if not exist "%CYGWIN_BASH%" (
    echo Cygwin bash was not found at "%CYGWIN_BASH%".
    exit /b 1
)

"%CYGWIN_BASH%" --noprofile --norc -lc "cd '/home/SR-Wave Admin/Projects/dotfiles' && exec stow --target='/cygdrive/c/Users/SR-Wave Admin' windows-powershell"
set "EXIT_CODE=%ERRORLEVEL%"
if not "%EXIT_CODE%"=="0" (
    echo Stow failed with exit code %EXIT_CODE%.
)
exit /b %EXIT_CODE%
