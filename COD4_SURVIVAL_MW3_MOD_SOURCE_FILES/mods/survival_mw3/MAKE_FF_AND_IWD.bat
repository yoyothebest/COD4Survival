del images.iwd
del sound.iwd
del animtrees.iwd
del weapons.iwd
del mod.ff

xcopy ui ..\..\raw\ui /SYI
xcopy english ..\..\raw\english /SYI
copy /Y mod.csv ..\..\zone_source
cd ..\..\bin
linker_pc.exe -language english -compress -cleanup mod
cd ..\mods\survival_mw3
copy ..\..\zone\english\mod.ff

7za a -r -tzip images.iwd images
7za a -r -tzip sound.iwd sound
7za a -r -tzip animtrees.iwd animtrees
7za a -r -tzip weapons.iwd weapons

pause