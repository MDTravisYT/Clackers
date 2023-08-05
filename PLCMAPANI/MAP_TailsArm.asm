; ===========================================================================
; ---------------------------------------------------------------------------
; Mappings - Tails' Arm
; ---------------------------------------------------------------------------
; Guide as Documented by Hivebrain
;
;	Each mappings block consists of six bytes:
;
;		dc.b	$SS,$YY,$TT,$TT,$XX,$ZZ
;
;	$SS   = Shape and size of sprite piece
;	$YY   = Y position of sprite piece
;	$TTTT = Tile to read in VRam
;	$XX   = X position of sprite piece
;	$ZZ   = whether it's the last map to use in the sprite or not (00 Include next map in sprite/FF End of sprite)
;
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
MAPTArm_Pul_Lft_000:	dc.b	$08,$10,$26,$B5,$00,$FF		; Walk Pull (Arm Left)
MAPTArm_Pul_LftDwn_020:	dc.b	$09,$10,$26,$B5,$00,$FF		; Walk Pull (Arm Left/Down 020*)
MAPTArm_Pul_LftDwn_045:	dc.b	$09,$11,$26,$B5,$00,$FF		; Walk Pull (Arm Left/Down 045*)
MAPTArm_Pul_LftDwn_060:	dc.b	$06,$10,$26,$B5,$08,$FF		; Walk Pull (Arm Left/Down 060*)
MAPTArm_Pul_Dwn_000:	dc.b	$06,$11,$26,$B5,$0D,$FF		; Walk Pull (Arm Down)
MAPTArm_Pul_DwnRht_020:	dc.b	$06,$10,$26,$B5,$10,$FF		; Walk Pull (Arm Down/Right 020*)
MAPTArm_Pul_DwnRht_045:	dc.b	$09,$13,$26,$B5,$12,$FF		; Walk Pull (Arm Down/Right 045*)
MAPTArm_Pul_DwnRht_060:	dc.b	$09,$10,$26,$B5,$10,$FF		; Walk Pull (Arm Down/Right 060*)
MAPTArm_Pul_Rht_000:	dc.b	$09,$0C,$26,$B5,$11,$FF		; Walk Pull (Arm Right)
MAPTArm_Pul_RhtUp_020:	dc.b	$09,$07,$26,$B5,$11,$FF		; Walk Pull (Arm Right/Up 020*)
MAPTArm_Pul_RhtUp_045:	dc.b	$05,$01,$26,$B5,$16,$00		; Walk Pull (Arm Right/Up 045*)
			dc.b	$00,$11,$26,$B9,$11,$FF		; ''
MAPTArm_Pul_RhtUp_060:	dc.b	$06,$00,$26,$B5,$10,$FF		; Walk Pull (Arm Right/Up 060*)
MAPTArm_Pul_Up_000:	dc.b	$02,$00,$26,$B5,$0E,$FF		; Walk Pull (Arm Up)
MAPTArm_Pul_UpDwn_020:	dc.b	$06,$02,$26,$B5,$08,$FF		; Walk Pull (Arm Up/Left 020*)
MAPTArm_Pul_UpDwn_045:	dc.b	$09,$05,$26,$B5,$03,$FF		; Walk Pull (Arm Up/Left 045*)
MAPTArm_Pul_UpDwn_060:	dc.b	$09,$0B,$26,$B5,$01,$FF		; Walk Pull (Arm Up/Left 060*)
; ---------------------------------------------------------------------------
MAPTArm_BlncOut1:	dc.b	$05,$14,$26,$B5,$00,$FF		; Balance Face Out 1
MAPTArm_BlncOut2:	dc.b	$05,$14,$26,$B5,$07,$FF		; Balance Face Out 2
MAPTArm_BlncOut3:	dc.b	$05,$12,$26,$B5,$0B,$FF		; Balance Face Out 3
MAPTArm_BlncIn1:	dc.b	$05,$05,$26,$B5,$01,$FF		; Balance Face In 1
MAPTArm_BlncIn2:	dc.b	$04,$10,$26,$B5,$05,$FF		; Balance Face In 2
MAPTArm_BlncIn3:	dc.b	$05,$13,$26,$B5,$0C,$FF		; Balance Face In 3
; ---------------------------------------------------------------------------
; Walking (Angle: 000* 180* degrees)
MAPTArm_Walk4_000:	dc.b	$05,$12,$26,$B5,$07,$FF		; Walk 4
MAPTArm_Walk1_000:	dc.b	$05,$12,$26,$B5,$07,$FF		; Walk 1 (Also Stand)
MAPTArm_Walk2_000:	dc.b	$09,$0E,$26,$B5,$0B,$FF		; Walk 2
MAPTArm_Walk3_000:	dc.b	$09,$0D,$26,$B5,$06,$FF		; Walk 3 (Also Look Down)
; ---------------------------------------------------------------------------
; Walking (Angle: 045* 225* degrees)
MAPTArm_Walk4_045:	dc.b	$09,$0E,$26,$B5,$0D,$FF		; Walk 4
MAPTArm_Walk1_045:	dc.b	$09,$0D,$26,$B5,$0E,$FF		; Walk 1
MAPTArm_Walk2_045:	dc.b	$09,$0F,$26,$B5,$0D,$FF		; Walk 2
MAPTArm_Walk3_045:	dc.b	$09,$0E,$26,$B5,$0D,$FF		; Walk 3
; ---------------------------------------------------------------------------
; Walking (Angle: 090* 270* degrees)
MAPTArm_Walk4_090:	dc.b	$05,$0A,$26,$B5,$12,$FF		; Walk 4
MAPTArm_Walk1_090:	dc.b	$05,$09,$26,$B5,$12,$FF		; Walk 1
MAPTArm_Walk2_090:	dc.b	$06,$02,$26,$B5,$0E,$FF		; Walk 2
MAPTArm_Walk3_090:	dc.b	$06,$07,$26,$B5,$0D,$FF		; Walk 3
; ---------------------------------------------------------------------------
; Walking (Angle: 135* 315* degrees)
MAPTArm_Walk4_135:	dc.b	$06,$02,$26,$B5,$0E,$FF		; Walk 4
MAPTArm_Walk1_135:	dc.b	$06,$09,$26,$B5,$0D,$FF		; Walk 1
MAPTArm_Walk2_135:	dc.b	$05,$02,$26,$B5,$0F,$FF		; Walk 2
MAPTArm_Walk3_135:	dc.b	$06,$06,$26,$B5,$0B,$FF		; Walk 3
; ---------------------------------------------------------------------------
; Unused
MAPTArm_Unused_00:	dc.b	$01,$0D,$26,$B5,$06,$FF		; Unused
MAPTArm_Unused_01:	dc.b	$05,$10,$26,$B5,$04,$FF		; Unused
MAPTArm_Unused_02:	dc.b	$05,$08,$26,$B5,$04,$FF		; Unused
; ---------------------------------------------------------------------------
MAPTArm_Run_000:	dc.b	$09,$0D,$26,$B5,$13,$FF		; Running 1-4 (Angle: 000* 180* degrees)
MAPTArm_Run_045:	dc.b	$09,$0A,$26,$B5,$08,$FF		; Running 1-4 (Angle: 045* 225* degrees)
MAPTArm_Run_090:	dc.b	$09,$0B,$26,$B5,$09,$FF		; Running 1-4 (Angle: 090* 270* degrees)
MAPTArm_Run_135:	dc.b	$06,$05,$26,$B5,$0A,$FF		; Running 1-4 (Angle: 135* 315* degrees)
; ---------------------------------------------------------------------------
MAPTArm_Hold1_000:	dc.b	$05,$06,$26,$B5,$0B,$FF		; Holding Sonic 1 (000*) (Used on 000*)
MAPTArm_Hold2_000:	dc.b	$04,$00,$26,$B5,$00,$FF		; Holding Sonic 2 (000*) (Used on 045*)
MAPTArm_Hold3_000:	dc.b	$04,$00,$26,$B5,$00,$FF		; Holding Sonic 3 (000*) (Used on 090*)
MAPTArm_Hold1_045:	dc.b	$04,$01,$26,$B5,$00,$FF		; Holding Sonic 1 (045*) (Used on 135*)
MAPTArm_Hold2_045:	dc.b	$05,$00,$26,$B5,$00,$FF		; Holding Sonic 2 (045*) (Unused)
MAPTArm_Hold3_045:	dc.b	$05,$00,$26,$B5,$00,$FF		; Holding Sonic 3 (045*) (Unused)
MAPTArm_Hold1_090:	dc.b	$05,$00,$26,$B5,$00,$FF		; Holding Sonic 1 (090*) (Unused)
MAPTArm_Hold2_090:	dc.b	$01,$00,$26,$B5,$00,$FF		; Holding Sonic 2 (090*) (Unused)
MAPTArm_Hold3_090:	dc.b	$01,$00,$26,$B5,$00,$FF		; Holding Sonic 3 (090*) (Unused)
MAPTArm_Hold1_135:	dc.b	$01,$00,$26,$B5,$02,$FF		; Holding Sonic 1 (135*) (Unused)
MAPTArm_Hold2_135:	dc.b	$05,$00,$26,$B5,$00,$FF		; Holding Sonic 2 (135*) (Unused)
MAPTArm_Hold3_135:	dc.b	$05,$00,$26,$B5,$00,$FF		; Holding Sonic 3 (135*) (Unused)
; ---------------------------------------------------------------------------
; Unused
MAPTArm_Unused_03:	dc.b	$05,$00,$26,$B5,$00,$FF		; Unused
MAPTArm_Unused_04:	dc.b	$05,$00,$26,$B5,$00,$FF		; Unused
MAPTArm_Unused_05:	dc.b	$00,$00,$26,$B5,$00,$FF		; Unused
MAPTArm_Unused_06:	dc.b	$05,$13,$26,$B5,$00,$FF		; Unused
MAPTArm_Unused_07:	dc.b	$05,$14,$26,$B5,$05,$FF		; Unused
MAPTArm_Unused_08:	dc.b	$05,$14,$26,$B5,$03,$FF		; Unused
MAPTArm_Unused_09:	dc.b	$05,$12,$26,$B5,$05,$FF		; Unused
MAPTArm_Unused_0A:	dc.b	$05,$14,$26,$B5,$04,$FF		; Unused
MAPTArm_Unused_0B:	dc.b	$05,$11,$26,$B5,$07,$FF		; Unused
MAPTArm_Unused_0C:	dc.b	$05,$13,$26,$B5,$05,$FF		; Unused
MAPTArm_Unused_0D:	dc.b	$05,$12,$26,$B5,$06,$FF		; Unused
			even
; ---------------------------------------------------------------------------
; ===========================================================================