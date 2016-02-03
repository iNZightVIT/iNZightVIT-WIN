!define APPNAME "iNZightVIT"
!define COMPANY "The University of Auckland"
!define VERSIONMAJOR 3
!define VERSIONMINOR 0
!define VERSIONBUILD 0

RequestExecutionLevel admin

## Define installation directory
InstallDir $PROGRAMFILES\${APPNAME}
Name "${APPNAME} - ${VERSIONMAJOR}.${VERSIONMINOR}.${VERSIONBUILD}"
Icon "icon.ico"
outFile "${APPNAME}-installer.exe"

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
	
	# Create main shortcuts to run inzight/vit/updater
	createShortcut "$INSTDIR\iNZight.lnk" "$INSTDIR\prog_files\bin\i386\Rgui.exe" "--quiet --no-save --no-restore" "$INSTDIR\icon.ico" "" SW_SHOWMINIMIZED
	createShortcut "$DESKTOP\iNZight.lnk" "$INSTDIR\prog_files\bin\i386\Rgui.exe" "--quiet --no-save --no-restore" "$INSTDIR\icon.ico" "" SW_SHOWMINIMIZED
	  
	setOutPath $INSTDIR\prog_files
	createShortcut "$INSTDIR\Update.lnk" "$INSTDIR\prog_files\bin\i386\R.exe" "--quiet --no-save --no-restore" "$INSTDIR\icon.ico" "" SW_SHOWNORMAL
	
	setOutPath $INSTDIR\prog_files\vit
	createShortcut "$INSTDIR\VIT.lnk" "$INSTDIR\prog_files\bin\i386\Rgui.exe" "--quiet --no-save --no-restore" "$INSTDIR\icon.ico" "" SW_SHOWMINIMIZED
	createShortcut "$DESKTOP\VIT.lnk" "$INSTDIR\prog_files\bin\i386\Rgui.exe" "--quiet --no-save --no-restore" "$INSTDIR\icon.ico" "" SW_SHOWMINIMIZED
	  
	
SectionEnd

Section "uninstall"

	# Remove desktop shortcuts
	delete $DESKTOP\iNZight.lnk
	delete $DESKTOP\VIT.lnk
	
	# Remove files
	RMDir /r $INSTDIR\prog_files
	RMDir /r $INSTDIR\data
	delete $INSTDIR\.Rprofile
	delete $INSTDIR\icon.ico
	delete $INSTDIR\iNZight.lnk
	delete $INSTDIR\Update.lnk
	delete $INSTDIR\VIT.lnk
	
	delete $INSTDIR\uninstall.exe
	RMDir $INSTDIR
	
SectionEnd