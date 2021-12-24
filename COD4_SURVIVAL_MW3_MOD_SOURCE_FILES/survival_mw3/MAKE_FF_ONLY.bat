del mod.ff

xcopy ui ..\..\raw\ui /SYI
xcopy english ..\..\raw\english /SYI
copy /Y mod.csv ..\..\zone_source
cd ..\..\bin
linker_pc.exe -language english -compress -cleanup mod
cd ..\mods\survival_mw3
copy ..\..\zone\english\mod.ff

pause