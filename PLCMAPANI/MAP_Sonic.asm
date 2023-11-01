; ===========================================================================
; ---------------------------------------------------------------------------
; Mappings - Sonic
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
MAPSon_Stand:		dc.b	$0D,$EA,$06,$9C,$F0,$00
			dc.b	$09,$FA,$06,$A4,$F2,$00
			dc.b	$08,$0A,$06,$AA,$F8,$FF
MAPSon_LookUp:		dc.b	$0B,$E9,$06,$9C,$F0,$00
			dc.b	$08,$09,$06,$A8,$F8,$FF
MAPSon_LookDown:	dc.b	$04,$F1,$06,$9C,$00,$00
			dc.b	$0E,$F9,$06,$9E,$F5,$FF
MAPSon_Hurt:		dc.b	$0B,$F1,$06,$9C,$EC,$00
			dc.b	$06,$F6,$06,$A8,$04,$FF
MAPSon_Wait1:		dc.b	$0B,$E9,$06,$9C,$F0,$00
			dc.b	$08,$09,$06,$A8,$F8,$FF
MAPSon_Wait2:		dc.b	$0B,$E9,$06,$9C,$F0,$00
			dc.b	$08,$09,$06,$A8,$F8,$FF
MAPSon_BlncIn1:		dc.b	$0F,$EC,$06,$9C,$EE,$00			; Balance in 1
			dc.b	$00,$0C,$06,$AC,$F8,$FF
MAPSon_BlncIn2:		dc.b	$0F,$EA,$06,$9C,$EC,$00			; Balance in 2
			dc.b	$04,$0A,$06,$AC,$F0,$FF
MAPSon_BlncIn3:		dc.b	$0E,$EB,$06,$9C,$EC,$00			; Balance in 3
			dc.b	$09,$03,$06,$A8,$ED,$FF
MAPSon_BlncOut1:	dc.b	$0B,$EC,$06,$9C,$FC,$00			; Balance out 1
			dc.b	$05,$F6,$06,$A8,$EC,$00
			dc.b	$04,$0C,$06,$AC,$04,$FF
MAPSon_BlncOut2:	dc.b	$0E,$EC,$06,$9C,$F4,$00			; Balance out 2
			dc.b	$00,$F8,$06,$A8,$EC,$00
			dc.b	$05,$04,$06,$A9,$FD,$FF
MAPSon_BlncOut3:	dc.b	$0D,$EC,$06,$9C,$F0,$00			; Balance out 3
			dc.b	$09,$FC,$06,$A4,$F4,$00
			dc.b	$00,$0C,$06,$AA,$03,$FF
; ---------------------------------------------------------------------------
; Walking (Angle: 000* 180* degrees)
MAPSon_Walk5_000:	dc.b	$0F,$E9,$06,$9C,$EC,$00
			dc.b	$01,$F9,$06,$AC,$0C,$00
			dc.b	$0C,$09,$06,$AE,$EF,$FF
MAPSon_Walk6_000:	dc.b	$08,$E9,$06,$9C,$F3,$00
			dc.b	$0D,$F1,$06,$9F,$F3,$00
			dc.b	$0D,$01,$06,$A7,$F4,$FF
MAPSon_Walk1_000:	dc.b	$0B,$EB,$06,$9C,$F4,$00
			dc.b	$04,$0B,$06,$A8,$F7,$FF
MAPSon_Walk2_000:	dc.b	$0A,$EA,$06,$9C,$F4,$00
			dc.b	$0D,$02,$06,$A5,$F2,$FF
MAPSon_Walk3_000:	dc.b	$0A,$EB,$06,$9C,$F4,$00
			dc.b	$0C,$03,$06,$A5,$EC,$00
			dc.b	$04,$0B,$06,$A9,$FF,$FF
MAPSon_Walk4_000:	dc.b	$0D,$EB,$06,$9C,$F3,$00
			dc.b	$0A,$FB,$06,$A4,$F4,$FF
; ---------------------------------------------------------------------------
; Walking (Angle: 045* 225* degrees)
MAPSon_Walk5_045:	dc.b	$0E,$ED,$06,$9C,$EC,$00
			dc.b	$01,$F5,$06,$A8,$0C,$00
			dc.b	$06,$05,$06,$AA,$F8,$FF
MAPSon_Walk6_045:	dc.b	$0F,$ED,$06,$9C,$EC,$00
			dc.b	$05,$FC,$06,$AC,$0C,$00
			dc.b	$04,$0D,$06,$B0,$FB,$FF
MAPSon_Walk1_045:	dc.b	$09,$ED,$06,$9C,$F0,$00
			dc.b	$0D,$FD,$06,$A2,$F4,$00
			dc.b	$04,$0D,$06,$AA,$03,$FF
MAPSon_Walk2_045:	dc.b	$0F,$ED,$06,$9C,$F0,$00
			dc.b	$01,$F6,$06,$AC,$10,$00
			dc.b	$01,$0D,$06,$AE,$FE,$FF
MAPSon_Walk3_045:	dc.b	$0B,$ED,$06,$9C,$F0,$00
			dc.b	$05,$FD,$06,$A8,$08,$00
			dc.b	$08,$0D,$06,$AC,$FD,$FF
MAPSon_Walk4_045:	dc.b	$0F,$ED,$06,$9C,$EC,$00
			dc.b	$00,$01,$06,$AC,$0C,$00
			dc.b	$04,$0D,$06,$AD,$FE,$FF
; ---------------------------------------------------------------------------
; Walking (Angle: 090* 270* degrees)
MAPSon_Walk5_090:	dc.b	$0F,$F4,$06,$9C,$E9,$00
			dc.b	$04,$EC,$06,$AC,$F9,$00
			dc.b	$03,$F1,$06,$AE,$09,$FF
MAPSon_Walk6_090:	dc.b	$0B,$F2,$06,$9C,$EB,$00
			dc.b	$07,$ED,$06,$A8,$03,$FF
MAPSon_Walk1_090:	dc.b	$0E,$F4,$06,$9C,$EB,$00
			dc.b	$01,$FC,$06,$A8,$0B,$FF
MAPSon_Walk2_090:	dc.b	$0A,$F4,$06,$9C,$EA,$00
			dc.b	$07,$EE,$06,$A5,$02,$FF
MAPSon_Walk3_090:	dc.b	$0E,$F4,$06,$9C,$EB,$00
			dc.b	$01,$F5,$06,$A8,$0B,$00
			dc.b	$00,$0C,$06,$AA,$05,$FF
MAPSon_Walk4_090:	dc.b	$07,$F2,$06,$9C,$EB,$00
			dc.b	$0A,$F4,$06,$A4,$FB,$FF
; ---------------------------------------------------------------------------
; Walking (Angle: 135* 315* degrees)
MAPSon_Walk5_135:	dc.b	$0B,$F4,$06,$9C,$EC,$00
			dc.b	$04,$EC,$06,$A8,$F4,$00
			dc.b	$09,$F9,$06,$AA,$04,$FF
MAPSon_Walk6_135:	dc.b	$0F,$F4,$06,$9C,$EC,$00
			dc.b	$05,$E4,$06,$AC,$FB,$00
			dc.b	$01,$F5,$06,$B0,$0C,$FF
MAPSon_Walk1_135:	dc.b	$0A,$F8,$06,$9C,$EC,$00
			dc.b	$05,$E8,$06,$A5,$01,$00
			dc.b	$05,$F8,$06,$A9,$04,$FF
MAPSon_Walk2_135:	dc.b	$0A,$F8,$06,$9C,$EC,$00
			dc.b	$05,$E8,$06,$A5,$F5,$00
			dc.b	$09,$F9,$06,$A9,$04,$FF
MAPSon_Walk3_135:	dc.b	$0E,$F8,$06,$9C,$EC,$00
			dc.b	$09,$E8,$06,$A8,$FC,$00
			dc.b	$00,$FC,$06,$AE,$0C,$FF
MAPSon_Walk4_135:	dc.b	$0F,$F2,$06,$9C,$EC,$00
			dc.b	$00,$EA,$06,$AC,$01,$00
			dc.b	$01,$F2,$06,$AD,$0C,$FF
; ---------------------------------------------------------------------------
MAPSon_Run1_000:	dc.b	$09,$ED,$06,$9C,$F6,$00
			dc.b	$0E,$FD,$06,$A2,$EF,$FF
MAPSon_Run2_000:	dc.b	$09,$ED,$06,$9C,$F6,$00
			dc.b	$0E,$FD,$06,$A2,$EE,$FF
MAPSon_Run3_000:	dc.b	$09,$ED,$06,$9C,$F6,$00
			dc.b	$0E,$FD,$06,$A2,$EE,$FF
MAPSon_Run4_000:	dc.b	$09,$ED,$06,$9C,$F6,$00
			dc.b	$0E,$FD,$06,$A2,$EE,$FF
MAPSon_Run1_045:	dc.b	$0D,$EB,$06,$9C,$EE,$00
			dc.b	$0E,$FB,$06,$A4,$F5,$FF
MAPSon_Run2_045:	dc.b	$0D,$EB,$06,$9C,$EE,$00
			dc.b	$0E,$FB,$06,$A4,$F5,$FF
MAPSon_Run3_045:	dc.b	$0D,$EB,$06,$9C,$EE,$00
			dc.b	$0E,$FB,$06,$A4,$F5,$FF
MAPSon_Run4_045:	dc.b	$0D,$EB,$06,$9C,$EE,$00
			dc.b	$0E,$FB,$06,$A4,$F5,$FF
MAPSon_Run1_090:	dc.b	$06,$F2,$06,$9C,$ED,$00
			dc.b	$0B,$F2,$06,$A2,$FD,$FF
MAPSon_Run2_090:	dc.b	$06,$F2,$06,$9C,$ED,$00
			dc.b	$0B,$F2,$06,$A2,$FD,$FF
MAPSon_Run3_090:	dc.b	$06,$F2,$06,$9C,$ED,$00
			dc.b	$0B,$F2,$06,$A2,$FD,$FF
MAPSon_Run4_090:	dc.b	$06,$F2,$06,$9C,$ED,$00
			dc.b	$0B,$F2,$06,$A2,$FD,$FF
MAPSon_Run1_135:	dc.b	$0B,$EB,$06,$9C,$FB,$00
			dc.b	$07,$F2,$06,$A8,$EB,$FF
MAPSon_Run2_135:	dc.b	$0B,$EA,$06,$9C,$FB,$00
			dc.b	$07,$F2,$06,$A8,$EB,$FF
MAPSon_Run3_135:	dc.b	$0B,$EB,$06,$9C,$FB,$00
			dc.b	$07,$F2,$06,$A8,$EB,$FF
MAPSon_Run4_135:	dc.b	$0B,$EA,$06,$9C,$FB,$00
			dc.b	$07,$F2,$06,$A8,$EB,$FF
; ---------------------------------------------------------------------------
MAPSon_Skid1:		dc.b	$0A,$ED,$06,$9C,$F8,$00
			dc.b	$0D,$05,$06,$A5,$F0,$FF
MAPSon_Skid2:		dc.b	$0A,$E9,$06,$9C,$F8,$00
			dc.b	$09,$01,$06,$A5,$EE,$00
			dc.b	$04,$01,$06,$AB,$06,$FF
MAPSon_Skid3:		dc.b	$0F,$ED,$06,$9C,$F0,$00
			dc.b	$01,$F9,$06,$AC,$10,$00
			dc.b	$04,$0D,$06,$AE,$F0,$FF
MAPSon_Pull1:		dc.b	$0F,$F1,$06,$9C,$EC,$FF
MAPSon_Pull2:		dc.b	$0E,$E9,$06,$9C,$EC,$00
			dc.b	$0D,$01,$06,$A8,$F4,$FF
MAPSon_Roll1:		dc.b	$0F,$F0,$06,$9C,$F0,$FF
MAPSon_Roll2:		dc.b	$0F,$F0,$06,$9C,$F0,$FF
MAPSon_Roll3:		dc.b	$0F,$F0,$06,$9C,$F0,$FF
MAPSon_Roll4:		dc.b	$0F,$F0,$06,$9C,$F0,$FF
MAPSon_Roll5:		dc.b	$0F,$F0,$06,$9C,$F0,$FF
MAPSon_Dizzy1:		dc.b	$04,$E9,$06,$9C,$F8,$00
			dc.b	$0D,$F1,$06,$9E,$F3,$00
			dc.b	$09,$01,$06,$A6,$F8,$FF
MAPSon_Dizzy2:		dc.b	$0A,$EC,$06,$9C,$F2,$00
			dc.b	$05,$04,$06,$A5,$F7,$FF
MAPSon_Dizzy3:		dc.b	$0E,$E9,$06,$9C,$F0,$00
			dc.b	$05,$01,$06,$A8,$FA,$FF
MAPSon_Dizzy4:		dc.b	$09,$E9,$06,$9C,$F7,$00
			dc.b	$0A,$F9,$06,$A2,$F3,$FF
MAPSon_Dizzy5:		dc.b	$04,$E9,$06,$9C,$F8,$00
			dc.b	$0E,$F1,$06,$9E,$F0,$00
			dc.b	$08,$09,$06,$AA,$F6,$FF
MAPSon_Dizzy6:		dc.b	$09,$E9,$06,$9C,$F8,$00
			dc.b	$0D,$F9,$06,$A2,$F8,$00
			dc.b	$04,$09,$06,$AA,$FD,$FF
; ---------------------------------------------------------------------------
; Unused
MAPSon_Climb1:		dc.b	$0B,$00,$06,$9C,$01,$00
			dc.b	$09,$20,$06,$A8,$07,$FF
MAPSon_Climb2:		dc.b	$0B,$00,$06,$9C,$00,$00
			dc.b	$05,$20,$06,$A8,$07,$FF
MAPSon_Climb3:		dc.b	$0A,$00,$06,$9C,$00,$00
			dc.b	$09,$18,$06,$A5,$0A,$FF
MAPSon_Climb4:		dc.b	$09,$00,$06,$9C,$00,$00
			dc.b	$0D,$10,$06,$A2,$00,$FF
MAPSon_Climb5:		dc.b	$0F,$00,$06,$9C,$00,$00
			dc.b	$04,$20,$06,$AC,$10,$FF
MAPSon_Throw1:		dc.b	$0F,$E9,$06,$9C,$EC,$00
			dc.b	$0C,$09,$06,$AC,$EC,$00
			dc.b	$00,$06,$06,$B0,$0C,$FF
MAPSon_Throw2:		dc.b	$0A,$E9,$06,$9C,$F3,$00
			dc.b	$0D,$01,$06,$A5,$EF,$FF
MAPSon_Throw3:		dc.b	$0F,$E9,$06,$9C,$F4,$00
			dc.b	$08,$09,$06,$AC,$F9,$FF
MAPSon_Throw4:		dc.b	$0B,$E9,$06,$9C,$F4,$00
			dc.b	$04,$09,$06,$A8,$F7,$FF
MAPSon_WallJump1:	dc.b	$0F,$00,$06,$9C,$10,$00
			dc.b	$01,$02,$06,$AC,$08,$00
			dc.b	$05,$12,$06,$AE,$00,$FF
MAPSon_WallJump2:	dc.b	$0F,$00,$06,$9C,$00,$FF
MAPSon_WallJump3:	dc.b	$0E,$00,$06,$9C,$00,$00
			dc.b	$09,$18,$06,$A8,$00,$FF
MAPSon_WallJump4:	dc.b	$0E,$00,$06,$9C,$08,$00
			dc.b	$01,$08,$06,$A8,$00,$FF
MAPSon_WallJump5:	dc.b	$0B,$00,$06,$9C,$10,$00
			dc.b	$06,$00,$06,$A8,$00,$FF
; ---------------------------------------------------------------------------
MAPSon_Spindash1:	dc.b	$0F,$F5,$06,$9C,$F0,$FF
MAPSon_Spindash2:	dc.b	$0F,$F5,$06,$9C,$F0,$FF
MAPSon_Spindash3:	dc.b	$0F,$F5,$06,$9C,$F0,$FF
MAPSon_Spindash4:	dc.b	$0F,$F5,$06,$9C,$F0,$FF
MAPSon_Spindash5:	dc.b	$0F,$F5,$06,$9C,$F0,$FF
MAPSon_Spindash6:	dc.b	$0F,$F5,$06,$9C,$F0,$FF

MAPSon_Spring:		
			dc.b	$0B,$F8,$06,$9C,$F0,$00
			dc.b	$05,$18,$06,$A8,$F8,$FF
			even
; ---------------------------------------------------------------------------
; ===========================================================================