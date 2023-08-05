; ===========================================================================
; ---------------------------------------------------------------------------
; Patter Load Cues - Tails' Arm
; ---------------------------------------------------------------------------
; Guide as half Documented by Hivebrain
; (See http://info.sonicretro.org/SCHG:Sonic_Crackers for more information)
;
;	Each load cue consists of ten bytes:
;
;			dc.w	$S2S1,$97L3,$L2L1,$DDDD,$FFF
;
;	$S2S1 = DMA Size
;	$97L3 and $L2L1 = DMA Location (Source)
;	$DDDD = DMA Destination (Added with hard coded data at offset: 0000CA2C)
;	$FFFF = End of list flag 
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
PLCTArm_Pul_Lft_000:	dc.w	$3000,$9703,$2000,$D6A0,$FFFF	; Walk Pull (Arm Left)
PLCTArm_Pul_LftDwn_020:	dc.w	$6000,$9703,$2030,$D6A0,$FFFF	; Walk Pull (Arm Left/Down 020*)
PLCTArm_Pul_LftDwn_045:	dc.w	$6000,$9703,$2090,$D6A0,$FFFF	; Walk Pull (Arm Left/Down 045*)
PLCTArm_Pul_LftDwn_060:	dc.w	$6000,$9703,$20F0,$D6A0,$FFFF	; Walk Pull (Arm Left/Down 060*)
PLCTArm_Pul_Dwn_000:	dc.w	$6000,$9703,$2150,$D6A0,$FFFF	; Walk Pull (Arm Down)
PLCTArm_Pul_DwnRht_020:	dc.w	$6000,$9703,$21B0,$D6A0,$FFFF	; Walk Pull (Arm Down/Right 020*)
PLCTArm_Pul_DwnRht_045:	dc.w	$6000,$9703,$2210,$D6A0,$FFFF	; Walk Pull (Arm Down/Right 045*)
PLCTArm_Pul_DwnRht_060:	dc.w	$6000,$9703,$2270,$D6A0,$FFFF	; Walk Pull (Arm Down/Right 060*)
PLCTArm_Pul_Rht_000:	dc.w	$6000,$9703,$22D0,$D6A0,$FFFF	; Walk Pull (Arm Right)
PLCTArm_Pul_RhtUp_020:	dc.w	$6000,$9703,$2330,$D6A0,$FFFF	; Walk Pull (Arm Right/Up 020*)
PLCTArm_Pul_RhtUp_045:	dc.w	$5000,$9703,$2390,$D6A0,$FFFF	; Walk Pull (Arm Right/Up 045*)
PLCTArm_Pul_RhtUp_060:	dc.w	$6000,$9703,$23E0,$D6A0,$FFFF	; Walk Pull (Arm Right/Up 060*)
PLCTArm_Pul_Up_000:	dc.w	$3000,$9703,$2440,$D6A0,$FFFF	; Walk Pull (Arm Up)
PLCTArm_Pul_UpDwn_020:	dc.w	$6000,$9703,$2470,$D6A0,$FFFF	; Walk Pull (Arm Up/Left 020*)
PLCTArm_Pul_UpDwn_045:	dc.w	$6000,$9703,$24D0,$D6A0,$FFFF	; Walk Pull (Arm Up/Left 045*)
PLCTArm_Pul_UpDwn_060:	dc.w	$6000,$9703,$2530,$D6A0,$FFFF	; Walk Pull (Arm Up/Left 060*)
; ---------------------------------------------------------------------------
PLCTArm_BlncOut1:	dc.w	$4000,$9703,$2590,$D6A0,$FFFF	; Balance Face Out 1
PLCTArm_BlncOut2:	dc.w	$4000,$9703,$25D0,$D6A0,$FFFF	; Balance Face Out 2
PLCTArm_BlncOut3:	dc.w	$4000,$9703,$2610,$D6A0,$FFFF	; Balance Face Out 3
PLCTArm_BlncIn1:	dc.w	$4000,$9703,$2650,$D6A0,$FFFF	; Balance Face In 1
PLCTArm_BlncIn2:	dc.w	$2000,$9703,$2690,$D6A0,$FFFF	; Balance Face In 2
PLCTArm_BlncIn3:	dc.w	$4000,$9703,$26B0,$D6A0,$FFFF	; Balance Face In 3
; ---------------------------------------------------------------------------
; Walking (Angle: 000* 180* degrees)
PLCTArm_Walk4_000:	dc.w	$4000,$9703,$26F0,$D6A0,$FFFF	; Walk 4
PLCTArm_Walk1_000:	dc.w	$4000,$9703,$2730,$D6A0,$FFFF	; Walk 1 (Also Stand)
PLCTArm_Walk2_000:	dc.w	$6000,$9703,$2770,$D6A0,$FFFF	; Walk 2
PLCTArm_Walk3_000:	dc.w	$6000,$9703,$27D0,$D6A0,$FFFF	; Walk 3 (Also Look Down)
; ---------------------------------------------------------------------------
; Walking (Angle: 045* 225* degrees)
PLCTArm_Walk4_045:	dc.w	$6000,$9703,$2830,$D6A0,$FFFF	; Walk 4
PLCTArm_Walk1_045:	dc.w	$6000,$9703,$2890,$D6A0,$FFFF	; Walk 1
PLCTArm_Walk2_045:	dc.w	$6000,$9703,$28F0,$D6A0,$FFFF	; Walk 2
PLCTArm_Walk3_045:	dc.w	$6000,$9703,$2950,$D6A0,$FFFF	; Walk 3
; ---------------------------------------------------------------------------
; Walking (Angle: 090* 270* degrees)
PLCTArm_Walk4_090:	dc.w	$4000,$9703,$29B0,$D6A0,$FFFF	; Walk 4
PLCTArm_Walk1_090:	dc.w	$4000,$9703,$29F0,$D6A0,$FFFF	; Walk 1
PLCTArm_Walk2_090:	dc.w	$6000,$9703,$2A30,$D6A0,$FFFF	; Walk 2
PLCTArm_Walk3_090:	dc.w	$6000,$9703,$2A90,$D6A0,$FFFF	; Walk 3
; ---------------------------------------------------------------------------
; Walking (Angle: 135* 315* degrees)
PLCTArm_Walk4_135:	dc.w	$6000,$9703,$2AF0,$D6A0,$FFFF	; Walk 4
PLCTArm_Walk1_135:	dc.w	$6000,$9703,$2B50,$D6A0,$FFFF	; Walk 1
PLCTArm_Walk2_135:	dc.w	$4000,$9703,$2BB0,$D6A0,$FFFF	; Walk 2
PLCTArm_Walk3_135:	dc.w	$6000,$9703,$2BF0,$D6A0,$FFFF	; Walk 3
; ---------------------------------------------------------------------------
; Unused
PLCTArm_Unused_00:	dc.w	$2000,$9703,$2C50,$D6A0,$FFFF	; Unused
PLCTArm_Unused_01:	dc.w	$4000,$9703,$2C70,$D6A0,$FFFF	; Unused
PLCTArm_Unused_02:	dc.w	$4000,$9703,$2CB0,$D6A0,$FFFF	; Unused
; ---------------------------------------------------------------------------
PLCTArm_Run_000:	dc.w	$6000,$9703,$2CF0,$D6A0,$FFFF	; Running 1-4 (Angle: 000* 180* degrees)
PLCTArm_Run_045:	dc.w	$6000,$9703,$2D50,$D6A0,$FFFF	; Running 1-4 (Angle: 045* 225* degrees)
PLCTArm_Run_090:	dc.w	$6000,$9703,$2DB0,$D6A0,$FFFF	; Running 1-4 (Angle: 090* 270* degrees)
PLCTArm_Run_135:	dc.w	$6000,$9703,$2E10,$D6A0,$FFFF	; Running 1-4 (Angle: 135* 315* degrees)
; ---------------------------------------------------------------------------
PLCTArm_Hold1_000:	dc.w	$4000,$9703,$2E70,$D6A0,$FFFF	; Holding Sonic 1 (000*) (Used on 000*)
PLCTArm_Hold2_000:	dc.w	$2000,$9703,$2EB0,$D6A0,$FFFF	; Holding Sonic 2 (000*) (Used on 045*)
PLCTArm_Hold3_000:	dc.w	$2000,$9703,$2ED0,$D6A0,$FFFF	; Holding Sonic 3 (000*) (Used on 090*)
PLCTArm_Hold1_045:	dc.w	$2000,$9703,$2EF0,$D6A0,$FFFF	; Holding Sonic 1 (045*) (Used on 135*)
PLCTArm_Hold2_045:	dc.w	$4000,$9703,$2F10,$D6A0,$FFFF	; Holding Sonic 2 (045*) (Unused)
PLCTArm_Hold3_045:	dc.w	$4000,$9703,$2F50,$D6A0,$FFFF	; Holding Sonic 3 (045*) (Unused)
PLCTArm_Hold1_090:	dc.w	$4000,$9703,$2F90,$D6A0,$FFFF	; Holding Sonic 1 (090*) (Unused)
PLCTArm_Hold2_090:	dc.w	$2000,$9703,$2FD0,$D6A0,$FFFF	; Holding Sonic 2 (090*) (Unused)
PLCTArm_Hold3_090:	dc.w	$2000,$9703,$2FF0,$D6A0,$FFFF	; Holding Sonic 3 (090*) (Unused)
PLCTArm_Hold1_135:	dc.w	$2000,$9703,$3010,$D6A0,$FFFF	; Holding Sonic 1 (135*) (Unused)
PLCTArm_Hold2_135:	dc.w	$4000,$9703,$3030,$D6A0,$FFFF	; Holding Sonic 2 (135*) (Unused)
PLCTArm_Hold3_135:	dc.w	$4000,$9703,$3070,$D6A0,$FFFF	; Holding Sonic 3 (135*) (Unused)
; ---------------------------------------------------------------------------
; Unused
PLCTArm_Unused_03:	dc.w	$4000,$9703,$30B0,$D6A0,$FFFF	; Unused
PLCTArm_Unused_04:	dc.w	$4000,$9703,$30F0,$D6A0,$FFFF	; Unused
PLCTArm_Unused_05:	dc.w	$1000,$9703,$3130,$D6A0,$FFFF	; Unused
PLCTArm_Unused_06:	dc.w	$4000,$9703,$3140,$D6A0,$FFFF	; Unused
PLCTArm_Unused_07:	dc.w	$4000,$9703,$3180,$D6A0,$FFFF	; Unused
PLCTArm_Unused_08:	dc.w	$4000,$9703,$31C0,$D6A0,$FFFF	; Unused
PLCTArm_Unused_09:	dc.w	$4000,$9703,$3200,$D6A0,$FFFF	; Unused
PLCTArm_Unused_0A:	dc.w	$4000,$9703,$3240,$D6A0,$FFFF	; Unused
PLCTArm_Unused_0B:	dc.w	$4000,$9703,$3280,$D6A0,$FFFF	; Unused
PLCTArm_Unused_0C:	dc.w	$4000,$9703,$32C0,$D6A0,$FFFF	; Unused
PLCTArm_Unused_0D:	dc.w	$4000,$9703,$3300,$D6A0,$FFFF	; Unused
			even
; ---------------------------------------------------------------------------
; ===========================================================================