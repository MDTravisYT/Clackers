@Echo Off
cd Z80
EXE\asl -q -cpu Z80 -gnuerrors -c -A -xx Z80.asm
EXE\p2bin Z80.p Z80.bin -r 0x-0x
IF NOT EXIST Z80.p goto ERROR
GOTO	AssembleROM
CLS

:ERROR
DEL Z80.p
DEL Z80.h

:AssembleROM
cd ..
Asm68k.exe /p /o ow+ SonCra.asm, SCBuilt.bin
Pause