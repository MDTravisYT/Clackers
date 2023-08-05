@Echo Off
EXE\asl -q -cpu Z80 -gnuerrors -c -A -xx Z80.asm
EXE\p2bin Z80.p Z80.bin -r 0x-0x
IF NOT EXIST Z80.p goto ERROR
CLS

:ERROR
DEL Z80.p
DEL Z80.h
Pause