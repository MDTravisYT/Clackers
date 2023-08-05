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
PLCSon_Stand:		PLC	$0220,ARTUNC_Sonic+$0000,$D380,$FFFF
PLCSon_LookUp:		PLC	$01E0,ARTUNC_Sonic+$0220,$D380,$FFFF
PLCSon_LookDown:	PLC	$01C0,ARTUNC_Sonic+$0400,$D380,$FFFF
PLCSon_Hurt:		PLC	$0240,ARTUNC_Sonic+$05C0,$D380,$FFFF
PLCSon_Wait1:		PLC	$01E0,ARTUNC_Sonic+$0800,$D380,$FFFF
PLCSon_Wait2:		PLC	$01E0,ARTUNC_Sonic+$09E0,$D380,$FFFF
PLCSON_BlncIn1:		PLC	$0220,ARTUNC_Sonic+$0BC0,$D380,$FFFF
PLCSON_BlncIn2:		PLC	$0240,ARTUNC_Sonic+$0DE0,$D380,$FFFF
PLCSON_BlncIn3:		PLC	$0240,ARTUNC_Sonic+$1020,$D380,$FFFF
PLCSON_BlncOut1:	PLC	$0240,ARTUNC_Sonic+$1260,$D380,$FFFF
PLCSON_BlncOut2:	PLC	$0220,ARTUNC_Sonic+$14A0,$D380,$FFFF
PLCSON_BlncOut3:	PLC	$01E0,ARTUNC_Sonic+$16C0,$D380,$FFFF
; ---------------------------------------------------------------------------
; Walking (Angle: 000* 180* degrees)
PLCSON_Walk5_000:	PLC	$02C0,ARTUNC_Sonic+$18A0,$D380,$FFFF
PLCSON_Walk6_000:	PLC	$0260,ARTUNC_Sonic+$1B60,$D380,$FFFF
PLCSON_Walk1_000:	PLC	$01C0,ARTUNC_Sonic+$1DC0,$D380,$FFFF
PLCSON_Walk2_000:	PLC	$0220,ARTUNC_Sonic+$1F80,$D380,$FFFF
PLCSON_Walk3_000:	PLC	$01E0,ARTUNC_Sonic+$21A0,$D380,$FFFF
PLCSON_Walk4_000:	PLC	$0220,ARTUNC_Sonic+$2380,$D380,$FFFF
; ---------------------------------------------------------------------------
; Walking (Angle: 045* 225* degrees)
PLCSON_Walk5_045:	PLC	$0280,ARTUNC_Sonic+$25A0,$D380,$FFFF
PLCSON_Walk6_045:	PLC	$02C0,ARTUNC_Sonic+$2820,$D380,$FFFF
PLCSON_Walk1_045:	PLC	$0200,ARTUNC_Sonic+$2AE0,$D380,$FFFF
PLCSON_Walk2_045:	PLC	$0280,ARTUNC_Sonic+$2CE0,$D380,$FFFF
PLCSON_Walk3_045:	PLC	$0260,ARTUNC_Sonic+$2F60,$D380,$FFFF
PLCSON_Walk4_045:	PLC	$0260,ARTUNC_Sonic+$31C0,$D380,$FFFF
; ---------------------------------------------------------------------------
; Walking (Angle: 090* 270* degrees)
PLCSON_Walk5_090:	PLC	$02C0,ARTUNC_Sonic+$3420,$D380,$FFFF
PLCSON_Walk6_090:	PLC	$0280,ARTUNC_Sonic+$36E0,$D380,$FFFF
PLCSON_Walk1_090:	PLC	$01C0,ARTUNC_Sonic+$3960,$D380,$FFFF
PLCSON_Walk2_090:	PLC	$0220,ARTUNC_Sonic+$3B20,$D380,$FFFF
PLCSON_Walk3_090:	PLC	$01E0,ARTUNC_Sonic+$3D40,$D380,$FFFF
PLCSON_Walk4_090:	PLC	$0220,ARTUNC_Sonic+$3F20,$D380,$FFFF
; ---------------------------------------------------------------------------
; Walking (Angle: 135* 315* degrees)
PLCSON_Walk5_135:	PLC	$0280,ARTUNC_Sonic+$4140,$D380,$FFFF
PLCSON_Walk6_135:	PLC	$02C0,ARTUNC_Sonic+$43C0,$D380,$FFFF
PLCSON_Walk1_135:	PLC	$0220,ARTUNC_Sonic+$4680,$D380,$FFFF
PLCSON_Walk2_135:	PLC	$0260,ARTUNC_Sonic+$48A0,$D380,$FFFF
PLCSON_Walk3_135:	PLC	$0260,ARTUNC_Sonic+$4B00,$D380,$FFFF
PLCSON_Walk4_135:	PLC	$0260,ARTUNC_Sonic+$4D60,$D380,$FFFF
; ---------------------------------------------------------------------------
PLCSon_Run1_000:	PLC	$0240,ARTUNC_Sonic+$4FC0,$D380,$FFFF
PLCSon_Run1_045:	PLC	$0240,ARTUNC_Sonic+$5200,$D380,$FFFF
PLCSon_Run1_090:	PLC	$0240,ARTUNC_Sonic+$5440,$D380,$FFFF
PLCSon_Run1_135:	PLC	$0240,ARTUNC_Sonic+$5680,$D380,$FFFF
PLCSon_Run2_000:	PLC	$0280,ARTUNC_Sonic+$58C0,$D380,$FFFF
PLCSon_Run2_045:	PLC	$0280,ARTUNC_Sonic+$5B40,$D380,$FFFF
PLCSon_Run2_090:	PLC	$0280,ARTUNC_Sonic+$5DC0,$D380,$FFFF
PLCSon_Run2_135:	PLC	$0280,ARTUNC_Sonic+$6040,$D380,$FFFF
PLCSon_Run3_000:	PLC	$0240,ARTUNC_Sonic+$62C0,$D380,$FFFF
PLCSon_Run3_045:	PLC	$0240,ARTUNC_Sonic+$6500,$D380,$FFFF
PLCSon_Run3_090:	PLC	$0240,ARTUNC_Sonic+$6740,$D380,$FFFF
PLCSon_Run3_135:	PLC	$0240,ARTUNC_Sonic+$6980,$D380,$FFFF
PLCSon_Run4_000:	PLC	$0280,ARTUNC_Sonic+$6BC0,$D380,$FFFF
PLCSon_Run4_045:	PLC	$0280,ARTUNC_Sonic+$6E40,$D380,$FFFF
PLCSon_Run4_090:	PLC	$0280,ARTUNC_Sonic+$70C0,$D380,$FFFF
PLCSon_Run4_135:	PLC	$0280,ARTUNC_Sonic+$7340,$D380,$FFFF
; ---------------------------------------------------------------------------
PLCSon_Skid1:		PLC	$0220,ARTUNC_Sonic+$75C0,$D380,$FFFF
PLCSon_Skid2:		PLC	$0220,ARTUNC_Sonic+$77E0,$D380,$FFFF
PLCSon_Skid3:		PLC	$0280,ARTUNC_Sonic+$7A00,$D380,$FFFF
PLCSon_Pull1:		PLC	$0200,ARTUNC_Sonic+$7C80,$D380,$FFFF
PLCSon_Pull2:		PLC	$0280,ARTUNC_Sonic+$7E80,$D380,$FFFF
PLCSon_Roll1:		PLC	$0200,ARTUNC_Sonic+$8100,$D380,$FFFF
PLCSon_Roll2:		PLC	$0200,ARTUNC_Sonic+$8300,$D380,$FFFF
PLCSon_Roll3:		PLC	$0200,ARTUNC_Sonic+$8500,$D380,$FFFF
PLCSon_Roll4:		PLC	$0200,ARTUNC_Sonic+$8700,$D380,$FFFF
PLCSon_Roll5:		PLC	$0200,ARTUNC_Sonic+$8900,$D380,$FFFF
PLCSon_Dizzy1:		PLC	$0200,ARTUNC_Sonic+$8B00,$D380,$FFFF
PLCSon_Dizzy2:		PLC	$01A0,ARTUNC_Sonic+$8D00,$D380,$FFFF
PLCSon_Dizzy3:		PLC	$0200,ARTUNC_Sonic+$8EA0,$D380,$FFFF
PLCSon_Dizzy4:		PLC	$01E0,ARTUNC_Sonic+$90A0,$D380,$FFFF
PLCSon_Dizzy5:		PLC	$0220,ARTUNC_Sonic+$9280,$D380,$FFFF
PLCSon_Dizzy6:		PLC	$0200,ARTUNC_Sonic+$94A0,$D380,$FFFF
; ---------------------------------------------------------------------------
; Unused
PLCSon_Climb1:		PLC	$0240,ARTUNC_Sonic+$96A0,$D380,$FFFF
PLCSon_Climb2:		PLC	$0200,ARTUNC_Sonic+$98E0,$D380,$FFFF
PLCSon_Climb3:		PLC	$01E0,ARTUNC_Sonic+$9AE0,$D380,$FFFF
PLCSon_Climb4:		PLC	$01C0,ARTUNC_Sonic+$9CC0,$D380,$FFFF
PLCSon_Climb5:		PLC	$0240,ARTUNC_Sonic+$9E80,$D380,$FFFF
PLCSon_Throw1:		PLC	$02A0,ARTUNC_Sonic+$A0C0,$D380,$FFFF
PLCSon_Throw2:		PLC	$0220,ARTUNC_Sonic+$A360,$D380,$FFFF
PLCSon_Throw3:		PLC	$0260,ARTUNC_Sonic+$A580,$D380,$FFFF
PLCSon_Throw4:		PLC	$01C0,ARTUNC_Sonic+$A7E0,$D380,$FFFF
PLCSon_WallJump1:	PLC	$02C0,ARTUNC_Sonic+$A9A0,$D380,$FFFF
PLCSon_WallJump2:	PLC	$0200,ARTUNC_Sonic+$AC60,$D380,$FFFF
PLCSon_WallJump3:	PLC	$0240,ARTUNC_Sonic+$AE60,$D380,$FFFF
PLCSon_WallJump4:	PLC	$01C0,ARTUNC_Sonic+$B0A0,$D380,$FFFF
PLCSon_WallJump5:	PLC	$0240,ARTUNC_Sonic+$B260,$D380,$FFFF
; ---------------------------------------------------------------------------
PLCSon_Spindash1:	PLC	$0200,ARTUNC_Sonic+$B4A0,$D380,$FFFF
PLCSon_Spindash2:	PLC	$0200,ARTUNC_Sonic+$B6A0,$D380,$FFFF
PLCSon_Spindash3:	PLC	$0200,ARTUNC_Sonic+$B8A0,$D380,$FFFF
PLCSon_Spindash4:	PLC	$0200,ARTUNC_Sonic+$BAA0,$D380,$FFFF
PLCSon_Spindash5:	PLC	$0200,ARTUNC_Sonic+$BCA0,$D380,$FFFF
PLCSon_Spindash6:	PLC	$0200,ARTUNC_Sonic+$BEA0,$D380,$FFFF
			even
; ---------------------------------------------------------------------------
; ===========================================================================