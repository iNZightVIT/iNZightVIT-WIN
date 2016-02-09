!define APPNAME "iNZightVIT"
!define COMPANY "The University of Auckland"
!define VERSIONMAJOR 3
!define VERSIONMINOR 0
!define VERSIONBUILD 0

RequestExecutionLevel user

## Define installation directory
InstallDir $DOCUMENTS\${APPNAME}
Name "${APPNAME} - ${VERSIONMAJOR}.${VERSIONMINOR}.${VERSIONBUILD}"
Icon "icon.ico"
outFile "${APPNAME}-installer.exe"

LoadLanguageFile "${NSISDIR}\Contrib\Language files\English.nlf"
VIProductVersion "${VERSIONMAJOR}.${VERSIONMINOR}.${VERSIONBUILD}.0"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "${APPNAME}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductVersion" "${VERSIONMAJOR}.${VERSIONMINOR}.${VERSIONBUILD}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "${COMPANY}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "GPL-2"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "An easy to use data visualisation tool."
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${VERSIONMAJOR}.${VERSIONMINOR}.${VERSIONBUILD}"



page directory
page instfiles


Section "install"

	setOutPath $INSTDIR
	File /r "prog_files"
	File /r "data"
	file ".Rprofile"
	file "icon.ico"

	# Create an uninstaller
	writeUninstaller "$INSTDIR\uninstall.exe"

	# Create a read-only shortcut to the data folder:
	createShortcut "$INSTDIR\Example Datasets.lnk" "$INSTDIR\data"
	
	# Start Menu Folder
	createDirectory "$SMPROGRAMS\${APPNAME}"
	createShortcut "$SMPROGRAMS\${APPNAME}\uninstall.lnk" "$INSTDIR\uninstall.exe"

	# Create main shortcuts to run inzight/vit/updater
	createShortcut "$INSTDIR\iNZight.lnk" "$INSTDIR\prog_files\bin\i386\Rgui.exe" "--quiet --no-save --no-restore" "$INSTDIR\icon.ico" "" SW_SHOWMINIMIZED
	createShortcut "$DESKTOP\iNZight.lnk" "$INSTDIR\prog_files\bin\i386\Rgui.exe" "--quiet --no-save --no-restore" "$INSTDIR\icon.ico" "" SW_SHOWMINIMIZED
	createShortcut "$SMPROGRAMS\${APPNAME}\iNZight.lnk" "$INSTDIR\prog_files\bin\i386\Rgui.exe" "--quiet --no-save --no-restore" "$INSTDIR\icon.ico" "" SW_SHOWMINIMIZED

	setOutPath $INSTDIR\prog_files
	createShortcut "$INSTDIR\Update.lnk" "$INSTDIR\prog_files\bin\i386\R.exe" "--quiet --no-save --no-restore" "$INSTDIR\icon.ico" "" SW_SHOWNORMAL
	createShortcut "$SMPROGRAMS\${APPNAME}\Update.lnk" "$INSTDIR\prog_files\bin\i386\R.exe" "--quiet --no-save --no-restore" "$INSTDIR\icon.ico" "" SW_SHOWNORMAL
	
	setOutPath $INSTDIR\prog_files\vit
	createShortcut "$INSTDIR\VIT.lnk" "$INSTDIR\prog_files\bin\i386\Rgui.exe" "--quiet --no-save --no-restore" "$INSTDIR\icon.ico" "" SW_SHOWMINIMIZED
	createShortcut "$DESKTOP\VIT.lnk" "$INSTDIR\prog_files\bin\i386\Rgui.exe" "--quiet --no-save --no-restore" "$INSTDIR\icon.ico" "" SW_SHOWMINIMIZED
	createShortcut "$SMPROGRAMS\${APPNAME}\VIT.lnk" "$INSTDIR\prog_files\bin\i386\Rgui.exe" "--quiet --no-save --no-restore" "$INSTDIR\icon.ico" "" SW_SHOWMINIMIZED

SectionEnd



## UNINSTALLER

function un.onInit

	MessageBox MB_OKCANCEL "Permanently remove ${APPNAME}?" IDOK next
		Abort
	next:
functionEnd

Section "uninstall"

	# Remove desktop shortcuts
	delete $DESKTOP\iNZight.lnk
	delete $DESKTOP\VIT.lnk
	
	# Remove start menu shortcuts
	delete $SMPROGRAMS\${APPNAME}\iNZight.lnk
	delete $SMPROGRAMS\${APPNAME}\VIT.lnk
	delete $SMPROGRAMS\${APPNAME}\Update.lnk
	delete $SMPROGRAMS\${APPNAME}\uninstall.lnk
	RMDir $SMPROGRAMS\${APPNAME}

	# Remove files
	RMDir /r $INSTDIR\prog_files
	RMDir /r $INSTDIR\data
	delete $INSTDIR\.Rprofile
	delete $INSTDIR\icon.ico
	delete $INSTDIR\iNZight.lnk
	delete $INSTDIR\Update.lnk
	delete $INSTDIR\VIT.lnk
	delete $INSTDIR\Data.lnk
	delete $INSTDIR\.inzight
	
	delete $INSTDIR\uninstall.exe
	RMDir $INSTDIR
	
	MessageBox MB_OK "iNZightVIT has been uninstalled. You may need to manually remove the iNZightVIT folder from your Documents folder."

SectionEnd
