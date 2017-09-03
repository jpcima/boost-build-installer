;--------------------------------
;Include Modern UI
!include "MUI2.nsh"

;--------------------------------
;Include libraries
!include "EnvVarUpdate.nsh"

;--------------------------------
;General
!ifndef ARCH
  !error "You must define ARCH to either i386 or amd64"
!endif

!define /file VERSION "boost-build-${ARCH}/version.txt"
Name "Boost.Build ${VERSION}"
OutFile "setup-${ARCH}.exe"
InstallDir "$PROGRAMFILES64\boost-build"

;--------------------------------
;Interface Settings
!define MUI_ABORTWARNING

;--------------------------------
;Pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "License_1_0.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

;--------------------------------
;Languages
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

;--------------------------------
;Installer Sections
Section "Boost.Build" SecInstall
SectionIn RO
SetOutPath $INSTDIR
File /r boost-build-${ARCH}\*
WriteUninstaller $INSTDIR\uninstall.exe
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\boost-build-${ARCH}" \
                 "DisplayName" "Boost.Build ${VERSION} ${ARCH}"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\boost-build-${ARCH}" \
                 "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
SectionEnd

Section "Add to system PATH" SecUpdatePath
${EnvVarUpdate} $0 "PATH" "A" "HKLM" "$INSTDIR\bin"
SectionEnd

;--------------------------------
;Descriptions
LangString DESC_SecInstall ${LANG_ENGLISH} "Boost.Build"
LangString DESC_SecUpdatePath ${LANG_ENGLISH} "Add to system PATH"
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SecInstall} $(DESC_SecInstall)
!insertmacro MUI_DESCRIPTION_TEXT ${SecUpdatePath} $(DESC_SecUpdatePath)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section
Section "Uninstall"
Delete $INSTDIR\uninstall.exe
RMDir $INSTDIR
${un.EnvVarUpdate} $0 "PATH" "R" "HKLM" "$INSTDIR\bin"
DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\boost-build-${ARCH}"
SectionEnd
