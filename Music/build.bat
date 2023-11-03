@echo off

IF EXIST Music.bin del Music.bin

set USEANSI=n
asl -q -L -A -E -xx Music.asm
p2bin Music.p Music.bin -r 0x-0x

del Music.p