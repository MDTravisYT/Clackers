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
MAPSon2_Stand:		dc.b	$0D,$EA,$26,$9C,$F0,$00
					dc.b	$09,$FA,$26,$A4,$F2,$00
					dc.b	$08,$0A,$26,$AA,$F8,$FF
MAPSon2_LookUp:		dc.b	$0B,$E9,$26,$9C,$F0,$00
					dc.b	$08,$09,$26,$A8,$F8,$FF
MAPSon2_LookDown:	dc.b	$04,$F1,$26,$9C,$00,$00
					dc.b	$0E,$F9,$26,$9E,$F5,$FF
MAPSon2_Hurt:		dc.b	$0B,$F1,$26,$9C,$EC,$00
					dc.b	$06,$F6,$26,$A8,$04,$FF
MAPSon2_Wait1:		dc.b	$0B,$E9,$26,$9C,$F0,$00
					dc.b	$08,$09,$26,$A8,$F8,$FF
MAPSon2_Wait2:		dc.b	$0B,$E9,$26,$9C,$F0,$00
					dc.b	$08,$09,$26,$A8,$F8,$FF
MAPSon2_BlncIn1:	dc.b	$0F,$EC,$26,$9C,$EE,$00					; Balance in 1
					dc.b	$00,$0C,$26,$AC,$F8,$FF
MAPSon2_BlncIn2:	dc.b	$0F,$EA,$26,$9C,$EC,$00					; Balance in 2
					dc.b	$04,$0A,$26,$AC,$F0,$FF
MAPSon2_BlncIn3:	dc.b	$0E,$EB,$26,$9C,$EC,$00					; Balance in 3
					dc.b	$09,$03,$26,$A8,$ED,$FF
MAPSon2_BlncOut1:	dc.b	$0B,$EC,$26,$9C,$FC,$00					; Balance out 1
					dc.b	$05,$F6,$26,$A8,$EC,$00
					dc.b	$04,$0C,$26,$AC,$04,$FF
MAPSon2_BlncOut2:	dc.b	$0E,$EC,$26,$9C,$F4,$00					; Balance out 2
					dc.b	$00,$F8,$26,$A8,$EC,$00
					dc.b	$05,$04,$26,$A9,$FD,$FF
MAPSon2_BlncOut3:	dc.b	$0D,$EC,$26,$9C,$F0,$00					; Balance out 3
					dc.b	$09,$FC,$26,$A4,$F4,$00
					dc.b	$00,$0C,$26,$AA,$03,$FF
; ---------------------------------------------------------------------------
; Walking (Angle: 000* 180* degrees)
MAPSon2_Walk5_000:	dc.b	$0F,$E9,$26,$9C,$EC,$00
					dc.b	$01,$F9,$26,$AC,$0C,$00
					dc.b	$0C,$09,$26,$AE,$EF,$FF
MAPSon2_Walk6_000:	dc.b	$08,$E9,$26,$9C,$F3,$00
					dc.b	$0D,$F1,$26,$9F,$F3,$00
					dc.b	$0D,$01,$26,$A7,$F4,$FF
MAPSon2_Walk1_000:	dc.b	$0B,$EB,$26,$9C,$F4,$00
					dc.b	$04,$0B,$26,$A8,$F7,$FF
MAPSon2_Walk2_000:	dc.b	$0A,$EA,$26,$9C,$F4,$00
					dc.b	$0D,$02,$26,$A5,$F2,$FF
MAPSon2_Walk3_000:	dc.b	$0A,$EB,$26,$9C,$F4,$00
					dc.b	$0C,$03,$26,$A5,$EC,$00
					dc.b	$04,$0B,$26,$A9,$FF,$FF
MAPSon2_Walk4_000:	dc.b	$0D,$EB,$26,$9C,$F3,$00
					dc.b	$0A,$FB,$26,$A4,$F4,$FF
; ---------------------------------------------------------------------------
; Walking (Angle: 045* 225* degrees)
MAPSon2_Walk5_045:	dc.b	$0E,$ED,$26,$9C,$EC,$00
					dc.b	$01,$F5,$26,$A8,$0C,$00
					dc.b	$06,$05,$26,$AA,$F8,$FF
MAPSon2_Walk6_045:	dc.b	$0F,$ED,$26,$9C,$EC,$00
					dc.b	$05,$FC,$26,$AC,$0C,$00
					dc.b	$04,$0D,$26,$B0,$FB,$FF
MAPSon2_Walk1_045:	dc.b	$09,$ED,$26,$9C,$F0,$00
					dc.b	$0D,$FD,$26,$A2,$F4,$00
					dc.b	$04,$0D,$26,$AA,$03,$FF
MAPSon2_Walk2_045:	dc.b	$0F,$ED,$26,$9C,$F0,$00
					dc.b	$01,$F6,$26,$AC,$10,$00
					dc.b	$01,$0D,$26,$AE,$FE,$FF
MAPSon2_Walk3_045:	dc.b	$0B,$ED,$26,$9C,$F0,$00
					dc.b	$05,$FD,$26,$A8,$08,$00
					dc.b	$08,$0D,$26,$AC,$FD,$FF
MAPSon2_Walk4_045:	dc.b	$0F,$ED,$26,$9C,$EC,$00
					dc.b	$00,$01,$26,$AC,$0C,$00
					dc.b	$04,$0D,$26,$AD,$FE,$FF
; ---------------------------------------------------------------------------
; Walking (Angle: 090* 270* degrees)
MAPSon2_Walk5_090:	dc.b	$0F,$F4,$26,$9C,$E9,$00
					dc.b	$04,$EC,$26,$AC,$F9,$00
					dc.b	$03,$F1,$26,$AE,$09,$FF
MAPSon2_Walk6_090:	dc.b	$0B,$F2,$26,$9C,$EB,$00
					dc.b	$07,$ED,$26,$A8,$03,$FF
MAPSon2_Walk1_090:	dc.b	$0E,$F4,$26,$9C,$EB,$00
					dc.b	$01,$FC,$26,$A8,$0B,$FF
MAPSon2_Walk2_090:	dc.b	$0A,$F4,$26,$9C,$EA,$00
					dc.b	$07,$EE,$26,$A5,$02,$FF
MAPSon2_Walk3_090:	dc.b	$0E,$F4,$26,$9C,$EB,$00
					dc.b	$01,$F5,$26,$A8,$0B,$00
					dc.b	$00,$0C,$26,$AA,$05,$FF
MAPSon2_Walk4_090:	dc.b	$07,$F2,$26,$9C,$EB,$00
					dc.b	$0A,$F4,$26,$A4,$FB,$FF
; ---------------------------------------------------------------------------
; Walking (Angle: 135* 315* degrees)
MAPSon2_Walk5_135:	dc.b	$0B,$F4,$26,$9C,$EC,$00
					dc.b	$04,$EC,$26,$A8,$F4,$00
					dc.b	$09,$F9,$26,$AA,$04,$FF
MAPSon2_Walk6_135:	dc.b	$0F,$F4,$26,$9C,$EC,$00
					dc.b	$05,$E4,$26,$AC,$FB,$00
					dc.b	$01,$F5,$26,$B0,$0C,$FF
MAPSon2_Walk1_135:	dc.b	$0A,$F8,$26,$9C,$EC,$00
					dc.b	$05,$E8,$26,$A5,$01,$00
					dc.b	$05,$F8,$26,$A9,$04,$FF
MAPSon2_Walk2_135:	dc.b	$0A,$F8,$26,$9C,$EC,$00
					dc.b	$05,$E8,$26,$A5,$F5,$00
					dc.b	$09,$F9,$26,$A9,$04,$FF
MAPSon2_Walk3_135:	dc.b	$0E,$F8,$26,$9C,$EC,$00
					dc.b	$09,$E8,$26,$A8,$FC,$00
					dc.b	$00,$FC,$26,$AE,$0C,$FF
MAPSon2_Walk4_135:	dc.b	$0F,$F2,$26,$9C,$EC,$00
					dc.b	$00,$EA,$26,$AC,$01,$00
					dc.b	$01,$F2,$26,$AD,$0C,$FF
; ---------------------------------------------------------------------------
MAPSon2_Run1_000:	dc.b	$09,$ED,$26,$9C,$F6,$00
					dc.b	$0E,$FD,$26,$A2,$EF,$FF
MAPSon2_Run2_000:	dc.b	$09,$ED,$26,$9C,$F6,$00
					dc.b	$0E,$FD,$26,$A2,$EE,$FF
MAPSon2_Run3_000:	dc.b	$09,$ED,$26,$9C,$F6,$00
					dc.b	$0E,$FD,$26,$A2,$EE,$FF
MAPSon2_Run4_000:	dc.b	$09,$ED,$26,$9C,$F6,$00
					dc.b	$0E,$FD,$26,$A2,$EE,$FF
MAPSon2_Run1_045:	dc.b	$0D,$EB,$26,$9C,$EE,$00
					dc.b	$0E,$FB,$26,$A4,$F5,$FF
MAPSon2_Run2_045:	dc.b	$0D,$EB,$26,$9C,$EE,$00
					dc.b	$0E,$FB,$26,$A4,$F5,$FF
MAPSon2_Run3_045:	dc.b	$0D,$EB,$26,$9C,$EE,$00
					dc.b	$0E,$FB,$26,$A4,$F5,$FF
MAPSon2_Run4_045:	dc.b	$0D,$EB,$26,$9C,$EE,$00
					dc.b	$0E,$FB,$26,$A4,$F5,$FF
MAPSon2_Run1_090:	dc.b	$06,$F2,$26,$9C,$ED,$00
					dc.b	$0B,$F2,$26,$A2,$FD,$FF
MAPSon2_Run2_090:	dc.b	$06,$F2,$26,$9C,$ED,$00
					dc.b	$0B,$F2,$26,$A2,$FD,$FF
MAPSon2_Run3_090:	dc.b	$06,$F2,$26,$9C,$ED,$00
					dc.b	$0B,$F2,$26,$A2,$FD,$FF
MAPSon2_Run4_090:	dc.b	$06,$F2,$26,$9C,$ED,$00
					dc.b	$0B,$F2,$26,$A2,$FD,$FF
MAPSon2_Run1_135:	dc.b	$0B,$EB,$26,$9C,$FB,$00
					dc.b	$07,$F2,$26,$A8,$EB,$FF
MAPSon2_Run2_135:	dc.b	$0B,$EA,$26,$9C,$FB,$00
					dc.b	$07,$F2,$26,$A8,$EB,$FF
MAPSon2_Run3_135:	dc.b	$0B,$EB,$26,$9C,$FB,$00
					dc.b	$07,$F2,$26,$A8,$EB,$FF
MAPSon2_Run4_135:	dc.b	$0B,$EA,$26,$9C,$FB,$00
					dc.b	$07,$F2,$26,$A8,$EB,$FF
; ---------------------------------------------------------------------------
MAPSon2_Skid1:		dc.b	$0A,$ED,$26,$9C,$F8,$00
					dc.b	$0D,$05,$26,$A5,$F0,$FF
MAPSon2_Skid2:		dc.b	$0A,$E9,$26,$9C,$F8,$00
					dc.b	$09,$01,$26,$A5,$EE,$00
					dc.b	$04,$01,$26,$AB,$06,$FF
MAPSon2_Skid3:		dc.b	$0F,$ED,$26,$9C,$F0,$00
					dc.b	$01,$F9,$26,$AC,$10,$00
					dc.b	$04,$0D,$26,$AE,$F0,$FF
MAPSon2_Pull1:		dc.b	$0F,$F1,$26,$9C,$EC,$FF
MAPSon2_Pull2:		dc.b	$0E,$E9,$26,$9C,$EC,$00
					dc.b	$0D,$01,$26,$A8,$F4,$FF
MAPSon2_Roll1:		dc.b	$0F,$F0,$26,$9C,$F0,$FF
MAPSon2_Roll2:		dc.b	$0F,$F0,$26,$9C,$F0,$FF
MAPSon2_Roll3:		dc.b	$0F,$F0,$26,$9C,$F0,$FF
MAPSon2_Roll4:		dc.b	$0F,$F0,$26,$9C,$F0,$FF
MAPSon2_Roll5:		dc.b	$0F,$F0,$26,$9C,$F0,$FF
MAPSon2_Dizzy1:		dc.b	$04,$E9,$26,$9C,$F8,$00
					dc.b	$0D,$F1,$26,$9E,$F3,$00
					dc.b	$09,$01,$26,$A6,$F8,$FF
MAPSon2_Dizzy2:		dc.b	$0A,$EC,$26,$9C,$F2,$00
					dc.b	$05,$04,$26,$A5,$F7,$FF
MAPSon2_Dizzy3:		dc.b	$0E,$E9,$26,$9C,$F0,$00
					dc.b	$05,$01,$26,$A8,$FA,$FF
MAPSon2_Dizzy4:		dc.b	$09,$E9,$26,$9C,$F7,$00
					dc.b	$0A,$F9,$26,$A2,$F3,$FF
MAPSon2_Dizzy5:		dc.b	$04,$E9,$26,$9C,$F8,$00
					dc.b	$0E,$F1,$26,$9E,$F0,$00
					dc.b	$08,$09,$26,$AA,$F6,$FF
MAPSon2_Dizzy6:		dc.b	$09,$E9,$26,$9C,$F8,$00
					dc.b	$0D,$F9,$26,$A2,$F8,$00
					dc.b	$04,$09,$26,$AA,$FD,$FF
; ---------------------------------------------------------------------------
; Unused
MAPSon2_Climb1:		dc.b	$0B,$00,$26,$9C,$01,$00
					dc.b	$09,$20,$26,$A8,$07,$FF
MAPSon2_Climb2:		dc.b	$0B,$00,$26,$9C,$00,$00
					dc.b	$05,$20,$26,$A8,$07,$FF
MAPSon2_Climb3:		dc.b	$0A,$00,$26,$9C,$00,$00
					dc.b	$09,$18,$26,$A5,$0A,$FF
MAPSon2_Climb4:		dc.b	$09,$00,$26,$9C,$00,$00
					dc.b	$0D,$10,$26,$A2,$00,$FF
MAPSon2_Climb5:		dc.b	$0F,$00,$26,$9C,$00,$00
					dc.b	$04,$20,$26,$AC,$10,$FF
MAPSon2_Throw1:		dc.b	$0F,$E9,$26,$9C,$EC,$00
					dc.b	$0C,$09,$26,$AC,$EC,$00
					dc.b	$00,$06,$26,$B0,$0C,$FF
MAPSon2_Throw2:		dc.b	$0A,$E9,$26,$9C,$F3,$00
					dc.b	$0D,$01,$26,$A5,$EF,$FF
MAPSon2_Throw3:		dc.b	$0F,$E9,$26,$9C,$F4,$00
					dc.b	$08,$09,$26,$AC,$F9,$FF
MAPSon2_Throw4:		dc.b	$0B,$E9,$26,$9C,$F4,$00
					dc.b	$04,$09,$26,$A8,$F7,$FF
MAPSon2_WallJump1:	dc.b	$0F,$00,$26,$9C,$10,$00
					dc.b	$01,$02,$26,$AC,$08,$00
					dc.b	$05,$12,$26,$AE,$00,$FF
MAPSon2_WallJump2:	dc.b	$0F,$00,$26,$9C,$00,$FF
MAPSon2_WallJump3:	dc.b	$0E,$00,$26,$9C,$00,$00
					dc.b	$09,$18,$26,$A8,$00,$FF
MAPSon2_WallJump4:	dc.b	$0E,$00,$26,$9C,$08,$00
					dc.b	$01,$08,$26,$A8,$00,$FF
MAPSon2_WallJump5:	dc.b	$0B,$00,$26,$9C,$10,$00
					dc.b	$06,$00,$26,$A8,$00,$FF
; ---------------------------------------------------------------------------
MAPSon2_Spindash1:	dc.b	$0F,$F5,$26,$9C,$F0,$FF
MAPSon2_Spindash2:	dc.b	$0F,$F5,$26,$9C,$F0,$FF
MAPSon2_Spindash3:	dc.b	$0F,$F5,$26,$9C,$F0,$FF
MAPSon2_Spindash4:	dc.b	$0F,$F5,$26,$9C,$F0,$FF
MAPSon2_Spindash5:	dc.b	$0F,$F5,$26,$9C,$F0,$FF
MAPSon2_Spindash6:	dc.b	$0F,$F5,$26,$9C,$F0,$FF

MAPSon2_Spring:		
					dc.b	$0B,$F8,$26,$9C,$F0,$00
					dc.b	$05,$18,$26,$A8,$F8,$FF
					even
; ---------------------------------------------------------------------------
; ===========================================================================