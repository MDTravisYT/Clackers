; ===========================================================================
; ---------------------------------------------------------------------------
; Mappings - Tails (And his Tails)
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
MAPTal_Stand:		dc.b	$0B,$EE,$06,$9C,$F4,$FF
MAPTal_LookUp:		dc.b	$0B,$EE,$06,$9C,$F4,$FF
MAPTal_LookDown:	dc.b	$0A,$F6,$06,$9C,$FC,$FF
MAPTal_WaitBlink2:	dc.b	$0B,$EE,$06,$9C,$F4,$FF		; Blink (eyes half closed)
MAPTal_WaitBlink1:	dc.b	$0B,$EE,$06,$9C,$F4,$FF		; Blink (eyes closed)
MAPTal_WaitStare:	dc.b	$0B,$EE,$06,$9C,$F4,$FF		; Waiting (Looking at player)
MAPTal_WaitYawn1:	dc.b	$0B,$EE,$06,$9C,$F4,$FF		; Yawn (eyes half closed)
MAPTal_WaitYawn2:	dc.b	$0B,$EE,$06,$9C,$F4,$FF		; Yawn (Hand wave away)
MAPTal_WaitYawn3:	dc.b	$0B,$EE,$06,$9C,$F4,$FF		; Yawn (Hand wave close)
; ---------------------------------------------------------------------------
; Walking (Angle: 000* 180* degrees)
MAPTal_Walk7_000:	dc.b	$09,$EE,$06,$9C,$F2,$00		; Walk 7
			dc.b	$0D,$FE,$06,$A2,$F2,$00
			dc.b	$09,$FE,$06,$AC,$E4,$FF
MAPTal_Walk8_000:	dc.b	$0A,$EE,$06,$9C,$F2,$00		; Walk 8
			dc.b	$0C,$06,$06,$A5,$F2,$00
			dc.b	$09,$FE,$06,$AC,$E6,$FF
MAPTal_Walk1_000:	dc.b	$0A,$EE,$06,$9C,$FA,$00		; Walk 1
			dc.b	$08,$06,$06,$A5,$F8,$00
			dc.b	$09,$FB,$06,$AC,$E6,$FF
MAPTal_Walk2_000:	dc.b	$0A,$EE,$06,$9C,$F2,$00		; Walk 2
			dc.b	$0C,$06,$06,$A5,$F2,$00
			dc.b	$09,$FB,$06,$AC,$E6,$FF
MAPTal_Walk3_000:	dc.b	$09,$EE,$06,$9C,$F2,$00		; Walk 3
			dc.b	$0D,$FE,$06,$A2,$F2,$00
			dc.b	$09,$FE,$06,$AC,$E4,$FF
MAPTal_Walk4_000:	dc.b	$0A,$EE,$06,$9C,$F2,$00		; Walk 4
			dc.b	$0C,$06,$06,$A5,$F2,$00
			dc.b	$09,$FE,$06,$AC,$E6,$FF
MAPTal_Walk5_000:	dc.b	$0A,$EE,$06,$9C,$FA,$00		; Walk 5
			dc.b	$04,$06,$06,$A5,$FA,$00
			dc.b	$09,$FB,$06,$AC,$E6,$FF
MAPTal_Walk6_000:	dc.b	$0B,$EE,$06,$9C,$F2,$00		; Walk 6
			dc.b	$09,$FB,$06,$AC,$E6,$FF
; ---------------------------------------------------------------------------
; Walking (Angle: 045* 225* degrees)
MAPTal_Walk7_045:	dc.b	$0E,$EE,$06,$9C,$F2,$00
			dc.b	$09,$06,$06,$A8,$F2,$FF
MAPTal_Walk8_045:	dc.b	$0F,$EE,$06,$9C,$F2,$00
			dc.b	$08,$0E,$06,$AC,$F2,$00
			dc.b	$00,$FC,$06,$AF,$12,$FF
MAPTal_Walk1_045:	dc.b	$0A,$E7,$06,$9C,$EF,$00
			dc.b	$0E,$FF,$06,$A5,$EE,$FF
MAPTal_Walk2_045:	dc.b	$0A,$EE,$06,$9C,$F1,$00
			dc.b	$0D,$06,$06,$A5,$EC,$00
			dc.b	$04,$FE,$06,$AD,$09,$FF
MAPTal_Walk3_045:	dc.b	$0E,$EE,$06,$9C,$F2,$00
			dc.b	$09,$06,$06,$A8,$F2,$FF
MAPTal_Walk4_045:	dc.b	$09,$EE,$06,$9C,$F2,$00
			dc.b	$0D,$FE,$06,$A2,$F5,$00
			dc.b	$08,$0E,$06,$AA,$F2,$FF
MAPTal_Walk5_045:	dc.b	$09,$EC,$06,$9C,$F0,$00
			dc.b	$0E,$FC,$06,$A2,$EE,$00
			dc.b	$00,$14,$06,$AE,$F0,$FF
MAPTal_Walk6_045:	dc.b	$09,$EE,$06,$9C,$F1,$00
			dc.b	$0C,$FE,$06,$A2,$F1,$00
			dc.b	$0D,$06,$06,$A6,$EC,$FF
; ---------------------------------------------------------------------------
; Walking (Angle: 090* 270* degrees)
MAPTal_Walk7_090:	dc.b	$00,$EC,$06,$9C,$03,$00
			dc.b	$0E,$F4,$06,$9D,$EE,$00
			dc.b	$06,$02,$06,$AC,$FE,$FF
MAPTal_Walk8_090:	dc.b	$00,$EC,$06,$9C,$06,$00
			dc.b	$0E,$F4,$06,$9D,$EE,$00
			dc.b	$06,$00,$06,$AC,$FE,$FF
MAPTal_Walk1_090:	dc.b	$0E,$EC,$06,$9C,$EE,$00
			dc.b	$00,$04,$06,$A8,$06,$00
			dc.b	$06,$00,$06,$AC,$FB,$FF
MAPTal_Walk2_090:	dc.b	$00,$EC,$06,$9C,$06,$00
			dc.b	$0E,$F4,$06,$9D,$EE,$00
			dc.b	$06,$00,$06,$AC,$FB,$FF
MAPTal_Walk3_090:	dc.b	$04,$EC,$06,$9C,$FE,$00
			dc.b	$0E,$F4,$06,$9E,$EE,$00
			dc.b	$06,$02,$06,$AC,$FE,$FF
MAPTal_Walk4_090:	dc.b	$00,$EC,$06,$9C,$06,$00
			dc.b	$0E,$F4,$06,$9D,$EE,$00
			dc.b	$06,$00,$06,$AC,$FE,$FF
MAPTal_Walk5_090:	dc.b	$08,$EC,$06,$9C,$EE,$00
			dc.b	$0D,$F4,$06,$9F,$EE,$00
			dc.b	$06,$00,$06,$AC,$FB,$FF
MAPTal_Walk6_090:	dc.b	$0E,$F4,$06,$9C,$EE,$00
			dc.b	$06,$00,$06,$AC,$FB,$FF
; ---------------------------------------------------------------------------
; Walking (Angle: 135* 315* degrees)
MAPTal_Walk7_135:	dc.b	$04,$EE,$06,$9C,$F4,$00
			dc.b	$0E,$F6,$06,$9E,$EC,$00
			dc.b	$02,$F6,$06,$AA,$0C,$FF
MAPTal_Walk8_135:	dc.b	$05,$E6,$06,$9C,$F9,$00
			dc.b	$0E,$F6,$06,$A0,$EC,$00
			dc.b	$02,$F6,$06,$AC,$0C,$FF
MAPTal_Walk1_135:	dc.b	$0F,$F2,$06,$9C,$F6,$00
			dc.b	$05,$F8,$06,$AC,$E6,$FF
MAPTal_Walk2_135:	dc.b	$0F,$F4,$06,$9C,$F4,$00
			dc.b	$01,$FC,$06,$AC,$EC,$00
			dc.b	$00,$EC,$06,$AE,$01,$FF
MAPTal_Walk3_135:	dc.b	$0B,$EE,$06,$9C,$EC,$00
			dc.b	$06,$F6,$06,$A8,$04,$FF
MAPTal_Walk4_135:	dc.b	$0E,$F6,$06,$9C,$F6,$00
			dc.b	$01,$F8,$06,$A8,$EE,$00
			dc.b	$05,$E6,$06,$AA,$FE,$FF
MAPTal_Walk5_135:	dc.b	$0F,$F2,$06,$9C,$F8,$00
			dc.b	$06,$F9,$06,$AC,$E8,$FF
MAPTal_Walk6_135:	dc.b	$0F,$F4,$06,$9C,$F4,$00
			dc.b	$01,$FC,$06,$AC,$EC,$00
			dc.b	$00,$EC,$06,$AE,$02,$FF
; ---------------------------------------------------------------------------
MAPTal_Run1_000:	dc.b	$09,$F0,$06,$9C,$F8,$00
			dc.b	$09,$00,$06,$A2,$F1,$FF
MAPTal_Run2_000:	dc.b	$09,$F0,$06,$9C,$F8,$00
			dc.b	$09,$00,$06,$A2,$F1,$FF
MAPTal_Run1_045:	dc.b	$0A,$EC,$06,$9C,$F0,$00
			dc.b	$05,$04,$06,$A5,$F8,$FF
MAPTal_Run2_045:	dc.b	$0A,$EC,$06,$9C,$F0,$00
			dc.b	$05,$04,$06,$A5,$F8,$FF
MAPTal_Run1_090:	dc.b	$09,$F0,$06,$9C,$F0,$00
			dc.b	$0D,$00,$06,$A2,$F0,$FF
MAPTal_Run2_090:	dc.b	$09,$F0,$06,$9C,$F0,$00
			dc.b	$0D,$00,$06,$A2,$F0,$FF
MAPTal_Run1_135:	dc.b	$0A,$FA,$06,$9C,$EC,$00
			dc.b	$05,$FA,$06,$A5,$04,$FF
MAPTal_Run2_135:	dc.b	$0A,$FA,$06,$9C,$EC,$00
			dc.b	$05,$FA,$06,$A5,$04,$FF
; ---------------------------------------------------------------------------
MAPTal_Roll1:		dc.b	$0F,$F0,$06,$9C,$F0,$FF
MAPTal_Roll2:		dc.b	$0F,$F0,$06,$9C,$F0,$FF
MAPTal_Roll3:		dc.b	$0F,$F0,$06,$9C,$F0,$FF
MAPTal_Spindsh1:	dc.b	$0F,$F4,$06,$9C,$F0,$FF
MAPTal_Spindsh2:	dc.b	$0E,$F8,$06,$9C,$F0,$FF
MAPTal_Spindsh3:	dc.b	$0F,$F4,$06,$9C,$F0,$FF
; ---------------------------------------------------------------------------
MAPTal_Hurt:		dc.b	$0F,$F0,$06,$9C,$F0,$FF
MAPTal_Fly:		dc.b	$0F,$F0,$06,$9C,$F0,$FF		; Tails Flying (Unused)
MAPTal_FlyTired1:	dc.b	$0F,$F0,$06,$9C,$F0,$FF		; Tails Flying When Tired 1 (Unused)
MAPTal_FlyTired2:	dc.b	$0F,$F0,$06,$9C,$F0,$FF		; Tails Flying When Tired 2 (Unused)
MAPTal_FlyHeliTails:	dc.b	$0C,$08,$06,$9C,$00,$FF		; Tails' "Tails" (Flying Helicopter Tails) (Unused)
MAPTal_Skid1:		dc.b	$09,$F0,$06,$9C,$F0,$00		; Skidding 1
			dc.b	$0D,$00,$06,$A2,$F0,$FF
MAPTal_Skid2:		dc.b	$09,$F0,$06,$9C,$F0,$00		; Skidding 2
			dc.b	$0D,$00,$06,$A2,$F0,$FF
MAPTal_Skid3:		dc.b	$0B,$F0,$06,$9C,$F0,$FF		; Skidding 3 (Turn Direction)
MAPTal_UnkSkid1:	dc.b	$0A,$F0,$06,$9C,$F0,$00		; Unused Hulting 1
			dc.b	$08,$08,$06,$A5,$F8,$FF
MAPTal_UnkSkid2:	dc.b	$09,$F0,$06,$9C,$F0,$00		; Unused Hulting 2
			dc.b	$0D,$00,$06,$A2,$F0,$FF
MAPTal_BlncOut1:	dc.b	$0F,$F0,$06,$9C,$F0,$FF		; Balancing 1 (Facing outwards)
MAPTal_BlncOut2:	dc.b	$09,$F0,$06,$9C,$F0,$00		; Balancing 2 (Facing outwards)
			dc.b	$0D,$00,$06,$A2,$F0,$FF
MAPTal_BlncOut3:	dc.b	$0B,$F0,$06,$9C,$F5,$FF		; Balancing 3 (Facing outwards)
MAPTal_BlncIn1:		dc.b	$09,$F1,$06,$9C,$F3,$00		; Balancing 1 (Facing inwards)
			dc.b	$05,$01,$06,$A2,$F3,$FF
MAPTal_BlncIn2:		dc.b	$09,$F0,$06,$9C,$F7,$00		; Balancing 2 (Facing inwards)
			dc.b	$09,$00,$06,$A2,$F2,$FF
MAPTal_BlncIn3:		dc.b	$09,$F0,$06,$9C,$F8,$00		; Balancing 3 (Facing inwards)
			dc.b	$0D,$00,$06,$A2,$F0,$FF
; ---------------------------------------------------------------------------
; Unused
MAPTal_Throw1:		dc.b	$0A,$E8,$06,$9C,$F0,$00		; Throwing 1 (Unused)
			dc.b	$0D,$00,$06,$A5,$F0,$FF
MAPTal_Throw2:		dc.b	$0A,$F0,$06,$9C,$F0,$00		; Throwing 2 (Unused)
			dc.b	$05,$08,$06,$A5,$F6,$FF
MAPTal_Throw3:		dc.b	$0A,$F2,$06,$9C,$F2,$00		; Throwing 3 (Unused)
			dc.b	$05,$0A,$06,$A5,$F7,$FF
MAPTal_Throw4:		dc.b	$0B,$F4,$06,$9C,$FA,$FF		; Throwing 4/Hanging 1? (Unused)
MAPTal_Hang2:		dc.b	$09,$00,$06,$9C,$03,$00		; Hanging 2 (Unused)
			dc.b	$06,$10,$06,$A2,$07,$FF
; ---------------------------------------------------------------------------
MAPTal_Dizzy1:		dc.b	$0B,$EF,$06,$9C,$F5,$FF		; Spinning Dizzy 1
MAPTal_Dizzy2:		dc.b	$09,$F1,$06,$9C,$F2,$00		; Spinning Dizzy 2
			dc.b	$09,$01,$06,$A2,$F9,$FF
MAPTal_Dizzy3:		dc.b	$08,$F0,$06,$9C,$F3,$00		; Spinning Dizzy 3
			dc.b	$0A,$F8,$06,$9F,$F5,$FF
MAPTal_Dizzy4:		dc.b	$0B,$F0,$06,$9C,$F2,$FF		; Spinning Dizzy 4
MAPTal_Dizzy5:		dc.b	$0B,$EF,$06,$9C,$F6,$FF		; Spinning Dizzy 5
MAPTal_Dizzy6:		dc.b	$09,$F1,$06,$9C,$F9,$00		; Spinning Dizzy 6
			dc.b	$0D,$01,$06,$A2,$F1,$FF
MAPTal_Dizzy7:		dc.b	$0E,$F0,$06,$9C,$F3,$00		; Spinning Dizzy 7
			dc.b	$04,$08,$06,$A8,$F6,$FF
MAPTal_Dizzy8:		dc.b	$0B,$F0,$06,$9C,$F8,$FF		; Spinning Dizzy 8
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; This next section is for Tails' tails
; ---------------------------------------------------------------------------
; Tails' Tails When Jumping (moving left or right) (Angle: 000* 180* degrees)
MAPTal_TalJmp01_000:	dc.b	$09,$00,$06,$AE,$00,$FF
MAPTal_TalJmp02_000:	dc.b	$09,$00,$06,$AE,$00,$FF
MAPTal_TalJmp03_000:	dc.b	$09,$00,$06,$AE,$00,$FF
MAPTal_TalJmp04_000:	dc.b	$09,$00,$06,$AE,$00,$FF
; ---------------------------------------------------------------------------
; Tails' Tails When Jumping (moving left or right and up) (Angle: 045* 225* degrees)
MAPTal_TalJmp01_045:	dc.b	$09,$00,$06,$AE,$00,$FF
MAPTal_TalJmp02_045:	dc.b	$09,$00,$06,$AE,$00,$FF
MAPTal_TalJmp03_045:	dc.b	$09,$00,$06,$AE,$00,$FF
MAPTal_TalJmp04_045:	dc.b	$09,$00,$06,$AE,$00,$FF
; ---------------------------------------------------------------------------
; Tails' Tails When Jumping (moving Up or down) (Angle: 090* 270* degrees)
MAPTal_TalJmp01_090:	dc.b	$06,$00,$06,$AE,$00,$FF
MAPTal_TalJmp02_090:	dc.b	$06,$00,$06,$AE,$00,$FF
MAPTal_TalJmp03_090:	dc.b	$06,$00,$06,$AE,$00,$FF
MAPTal_TalJmp04_090:	dc.b	$06,$00,$06,$AE,$00,$FF
; ---------------------------------------------------------------------------
; Tails' Tails When Jumping (moving left or right and down) (Angle: 135* 315* degrees)
MAPTal_TalJmp01_135:	dc.b	$06,$00,$06,$AE,$00,$FF
MAPTal_TalJmp02_135:	dc.b	$06,$00,$06,$AE,$00,$FF
MAPTal_TalJmp03_135:	dc.b	$06,$00,$06,$AE,$00,$FF
MAPTal_TalJmp04_135:	dc.b	$06,$00,$06,$AE,$00,$FF
; ---------------------------------------------------------------------------
; Running Normal and Fast (Angle: 000* 180* degrees)
MAPTal_RunNorm01_000:	dc.b	$07,$00,$06,$AC,$00,$FF		; RUN normal 1 000 (Unused)
MAPTal_RunNorm02_000:	dc.b	$05,$08,$06,$AC,$00,$FF		; RUN normal 2 000 (Unused)
MAPTal_RunFast01_000:	dc.b	$04,$0C,$06,$AC,$00,$FF		; RUN fast 1 000
MAPTal_RunFast02_000:	dc.b	$07,$F0,$06,$AC,$F8,$FF		; RUN fast 2 000
; ---------------------------------------------------------------------------
; Running Normal and Fast (Angle: 045* 225* degrees)
MAPTal_RunNorm01_045:	dc.b	$09,$00,$06,$AC,$00,$00		; RUN normal 1 045 (Unused)
			dc.b	$01,$10,$06,$B2,$10,$FF		; ''
MAPTal_RunNorm02_045:	dc.b	$05,$00,$06,$AC,$00,$FF		; RUN normal 2 045 (Unused)
MAPTal_RunFast01_045:	dc.b	$05,$00,$06,$AC,$00,$FF		; RUN fast 1 045 (Unused)
MAPTal_RunFast02_045:	dc.b	$09,$01,$06,$AC,$00,$00		; RUN fast 2 045 (Unused)
			dc.b	$04,$11,$06,$B2,$08,$FF		; ''
; ---------------------------------------------------------------------------
; Running Normal and Fast (Angle: 090* 270* degrees)
MAPTal_RunNorm01_090:	dc.b	$05,$00,$06,$AC,$00,$FF		; RUN normal 1 090 (Unused)
MAPTal_RunNorm02_090:	dc.b	$0D,$00,$06,$AC,$00,$FF		; RUN normal 2 090 (Unused)
MAPTal_RunFast01_090:	dc.b	$05,$00,$06,$AC,$08,$FF		; RUN fast 1 090 (Unused)
MAPTal_RunFast02_090:	dc.b	$01,$00,$06,$AC,$0C,$FF		; RUN fast 2 090 (Unused)
; ---------------------------------------------------------------------------
; Running Normal and Fast (Angle: 135* 315* degrees)
MAPTal_RunNorm01_135:	dc.b	$0D,$00,$06,$AC,$00,$FF		; RUN normal 1 135 (Unused)
MAPTal_RunNorm02_135:	dc.b	$08,$00,$06,$AC,$03,$00		; RUN normal 2 135 (Unused)
			dc.b	$05,$08,$06,$AF,$00,$FF		; ''
MAPTal_RunFast01_135:	dc.b	$05,$00,$06,$AC,$00,$FF		; RUN fast 1 135 (Unused)
MAPTal_RunFast02_135:	dc.b	$05,$00,$06,$AC,$00,$FF		; RUN fast 2 135 (Unused)
; ---------------------------------------------------------------------------
MAPTal_UnkTails1:	dc.b	$04,$00,$06,$AC,$08,$00		; Unknown frames (looks like the tails are flipping or snapping, or something on them lines)
			dc.b	$09,$08,$06,$AE,$00,$FF		; ''
MAPTal_UnkTails2:	dc.b	$05,$00,$06,$AC,$00,$FF		; ''
MAPTal_Wait01:		dc.b	$06,$08,$06,$AC,$10,$FF		; waiting, Looking up, looking down (Tails' Idle tails)
MAPTal_Wait02:		dc.b	$0A,$08,$06,$AC,$08,$FF		; ''
MAPTal_Wait03:		dc.b	$0A,$08,$06,$AC,$08,$FF		; ''
MAPTal_Wait04:		dc.b	$09,$10,$06,$AC,$08,$FF		; ''
MAPTal_Wait05:		dc.b	$0A,$08,$06,$AC,$08,$FF		; ''
			even
; ---------------------------------------------------------------------------
; ===========================================================================