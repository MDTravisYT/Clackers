; ===========================================================================
; ---------------------------------------------------------------------------
; Patter Load Cues - Sonic
; ---------------------------------------------------------------------------
; Guide as half Documented by Hivebrain
; (See http://info.sonicretro.org/SCHG:Sonic_Crackers for more information)
;
;	Each load cue consists of ten bytes:
;
;			PLC	$S2S1,$97L3,$L2L1,$DDDD,$FFF
;
;	$S2S1 = DMA Size
;	$97L3 and $L2L1 = DMA Location (Source)
;	$DDDD = DMA Destination (Added with hard coded data at offset: 0000CA2C)
;	$FFFF = End of list flag 
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
PLCRay_Stand:		PLC	$0240,ARTUNC_Ray+$0000,$D380,$FFFF
