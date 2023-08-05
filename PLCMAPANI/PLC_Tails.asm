; ===========================================================================
; ---------------------------------------------------------------------------
; Patter Load Cues - Tails
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
PLCTal_Stand:		PLC	$0180,ARTUNC_Tails+$0000,$D380,$FFFF
PLCTal_LookUp:		PLC	$0180,ARTUNC_Tails+$0180,$D380,$FFFF
PLCTal_LookDown:	PLC	$0120,ARTUNC_Tails+$0300,$D380,$FFFF
PLCTal_WaitBlink2:	dc.w	$C000,$9705,$0210,$D380,$FFFF	; Blink (eyes half closed)
PLCTal_WaitBlink1:	dc.w	$C000,$9705,$02D0,$D380,$FFFF	; Blink (eyes closed)
PLCTal_WaitStare:	dc.w	$C000,$9705,$0390,$D380,$FFFF	; Waiting (Looking at player)
PLCTal_WaitYawn1:	dc.w	$C000,$9705,$0450,$D380,$FFFF	; Yawn (eyes half closed)
PLCTal_WaitYawn2:	dc.w	$C000,$9705,$0510,$D380,$FFFF	; Yawn (Hand wave away)
PLCTal_WaitYawn3:	dc.w	$C000,$9705,$05D0,$D380,$FFFF	; Yawn (Hand wave close)
; ---------------------------------------------------------------------------
; Walking (Angle: 000* 180* degrees)
PLCTal_Walk7_000:	dc.w	$E000,$9705,$0690,$D380,$0000
			dc.w	$6000,$9705,$4A20,$D580,$FFFF
PLCTal_Walk8_000:	dc.w	$D000,$9705,$0770,$D380,$0000
			dc.w	$6000,$9705,$4A80,$D580,$FFFF
PLCTal_Walk1_000:	dc.w	$C000,$9705,$0840,$D380,$0000
			dc.w	$6000,$9705,$4AE0,$D580,$FFFF
PLCTal_Walk2_000:	dc.w	$D000,$9705,$0900,$D380,$0000
			dc.w	$6000,$9705,$4B40,$D580,$FFFF
PLCTal_Walk3_000:	dc.w	$E000,$9705,$09D0,$D380,$0000
			dc.w	$6000,$9705,$4A20,$D580,$FFFF
PLCTal_Walk4_000:	dc.w	$D000,$9705,$0AB0,$D380,$0000
			dc.w	$6000,$9705,$4A80,$D580,$FFFF
PLCTal_Walk5_000:	dc.w	$B000,$9705,$0B80,$D380,$0000
			dc.w	$6000,$9705,$4AE0,$D580,$FFFF
PLCTal_Walk6_000:	dc.w	$C000,$9705,$0C30,$D380,$0000
			dc.w	$6000,$9705,$4B40,$D580,$FFFF
; ---------------------------------------------------------------------------
; Walking (Angle: 045* 225* degrees)
PLCTal_Walk7_045:	dc.w	$2001,$9705,$0CF0,$D380,$FFFF
PLCTal_Walk8_045:	dc.w	$4001,$9705,$0E10,$D380,$FFFF
PLCTal_Walk1_045:	dc.w	$5001,$9705,$0F50,$D380,$FFFF
PLCTal_Walk2_045:	dc.w	$3001,$9705,$10A0,$D380,$FFFF
PLCTal_Walk3_045:	dc.w	$2001,$9705,$11D0,$D380,$FFFF
PLCTal_Walk4_045:	dc.w	$1001,$9705,$12F0,$D380,$FFFF
PLCTal_Walk5_045:	dc.w	$3001,$9705,$1400,$D380,$FFFF
PLCTal_Walk6_045:	dc.w	$2001,$9705,$1530,$D380,$FFFF
; ---------------------------------------------------------------------------
; Walking (Angle: 090* 270* degrees)
PLCTal_Walk7_090:	dc.w	$D000,$9705,$1650,$D380,$0000
			dc.w	$6000,$9705,$4D20,$D580,$FFFF
PLCTal_Walk8_090:	dc.w	$D000,$9705,$1720,$D380,$0000
			dc.w	$6000,$9705,$4D80,$D580,$FFFF
PLCTal_Walk1_090:	dc.w	$D000,$9705,$17F0,$D380,$0000
			dc.w	$6000,$9705,$4DE0,$D580,$FFFF
PLCTal_Walk2_090:	dc.w	$D000,$9705,$18C0,$D380,$0000
			dc.w	$6000,$9705,$4E40,$D580,$FFFF
PLCTal_Walk3_090:	dc.w	$E000,$9705,$1990,$D380,$0000
			dc.w	$6000,$9705,$4D20,$D580,$FFFF
PLCTal_Walk4_090:	dc.w	$D000,$9705,$1A70,$D380,$0000
			dc.w	$6000,$9705,$4D80,$D580,$FFFF
PLCTal_Walk5_090:	dc.w	$B000,$9705,$1B40,$D380,$0000
			dc.w	$6000,$9705,$4DE0,$D580,$FFFF
PLCTal_Walk6_090:	dc.w	$C000,$9705,$1BF0,$D380,$0000
			dc.w	$6000,$9705,$4E40,$D580,$FFFF
; ---------------------------------------------------------------------------
; Walking (Angle: 135* 315* degrees)
PLCTal_Walk7_135:	dc.w	$1001,$9705,$1CB0,$D380,$FFFF
PLCTal_Walk8_135:	dc.w	$3001,$9705,$1DC0,$D380,$FFFF
PLCTal_Walk1_135:	dc.w	$4001,$9705,$1EF0,$D380,$FFFF
PLCTal_Walk2_135:	dc.w	$3001,$9705,$2030,$D380,$FFFF
PLCTal_Walk3_135:	dc.w	$2001,$9705,$2160,$D380,$FFFF
PLCTal_Walk4_135:	dc.w	$2001,$9705,$2280,$D380,$FFFF
PLCTal_Walk5_135:	dc.w	$6001,$9705,$23A0,$D380,$FFFF
PLCTal_Walk6_135:	dc.w	$3001,$9705,$2500,$D380,$FFFF
; ---------------------------------------------------------------------------
PLCTal_Run1_000:	dc.w	$C000,$9705,$2630,$D380,$FFFF
PLCTal_Run2_000:	dc.w	$C000,$9705,$26F0,$D380,$FFFF
PLCTal_Run1_045:	dc.w	$D000,$9705,$27B0,$D380,$FFFF
PLCTal_Run2_045:	dc.w	$D000,$9705,$2880,$D380,$FFFF
PLCTal_Run1_090:	dc.w	$E000,$9705,$2950,$D380,$FFFF
PLCTal_Run2_090:	dc.w	$E000,$9705,$2A30,$D380,$FFFF
PLCTal_Run1_135:	dc.w	$D000,$9705,$2B10,$D380,$FFFF
PLCTal_Run2_135:	dc.w	$D000,$9705,$2BE0,$D380,$FFFF
; ---------------------------------------------------------------------------
PLCTal_Roll1:		dc.w	$0001,$9705,$2CB0,$D380,$FFFF
PLCTal_Roll2:		dc.w	$0001,$9705,$2DB0,$D380,$FFFF
PLCTal_Roll3:		dc.w	$0001,$9705,$2EB0,$D380,$FFFF
PLCTal_Spindsh1:	dc.w	$0001,$9705,$2FB0,$D380,$FFFF
PLCTal_Spindsh2:	dc.w	$C000,$9705,$30B0,$D380,$FFFF
PLCTal_Spindsh3:	dc.w	$0001,$9705,$3170,$D380,$FFFF
; ---------------------------------------------------------------------------
PLCTal_Hurt:		dc.w	$0001,$9705,$3270,$D380,$FFFF
PLCTal_Fly:		dc.w	$0001,$9705,$3370,$D380,$FFFF	; Tails Flying (Unused)
PLCTal_FlyTired1:	dc.w	$0001,$9705,$3470,$D380,$FFFF	; Tails Flying When Tired 1 (Unused)
PLCTal_FlyTired2:	dc.w	$0001,$9705,$3570,$D380,$FFFF	; Tails Flying When Tired 2 (Unused)
PLCTal_FlyHeliTails:	dc.w	$4000,$9705,$3670,$D380,$FFFF	; Tails' "Tails" (Flying Helicopter Tails) (Unused)
PLCTal_Skid1:		dc.w	$E000,$9705,$36B0,$D380,$FFFF	; Skidding 1
PLCTal_Skid2:		dc.w	$E000,$9705,$3790,$D380,$FFFF	; Skidding 2
PLCTal_Skid3:		dc.w	$C000,$9705,$3870,$D380,$FFFF	; Skidding 3 (Turn Direction)
PLCTal_UnkSkid1:	dc.w	$C000,$9705,$3930,$D380,$FFFF	; Unused Hulting 1
PLCTal_UnkSkid2:	dc.w	$E000,$9705,$39F0,$D380,$FFFF	; Unused Hulting 2
PLCTal_BlncOut1:	dc.w	$0001,$9705,$3AD0,$D380,$FFFF	; Balancing 1 (Facing outwards)
PLCTal_BlncOut2:	dc.w	$E000,$9705,$3BD0,$D380,$FFFF	; Balancing 2 (Facing outwards)
PLCTal_BlncOut3:	dc.w	$C000,$9705,$3CB0,$D380,$FFFF	; Balancing 3 (Facing outwards)
PLCTal_BlncIn1:		dc.w	$A000,$9705,$3D70,$D380,$FFFF	; Balancing 1 (Facing inwards)
PLCTal_BlncIn2:		dc.w	$C000,$9705,$3E10,$D380,$FFFF	; Balancing 2 (Facing inwards)
PLCTal_BlncIn3:		dc.w	$E000,$9705,$3ED0,$D380,$FFFF	; Balancing 3 (Facing inwards)
; ---------------------------------------------------------------------------
; Unused
PLCTal_Throw1:		dc.w	$1001,$9705,$3FB0,$D380,$FFFF	; Throwing 1 (Unused)
PLCTal_Throw2:		dc.w	$D000,$9705,$40C0,$D380,$FFFF	; Throwing 2 (Unused)
PLCTal_Throw3:		dc.w	$D000,$9705,$4190,$D380,$FFFF	; Throwing 3 (Unused)
PLCTal_Throw4:		dc.w	$C000,$9705,$4260,$D380,$FFFF	; Throwing 4/Hanging 1? (Unused)
PLCTal_Hang2:		dc.w	$C000,$9705,$4320,$D380,$FFFF	; Hanging 2 (Unused)
; ---------------------------------------------------------------------------
PLCTal_Dizzy1:		dc.w	$C000,$9705,$43E0,$D380,$FFFF	; Spinning Dizzy 1
PLCTal_Dizzy2:		dc.w	$C000,$9705,$44A0,$D380,$FFFF	; Spinning Dizzy 2
PLCTal_Dizzy3:		dc.w	$C000,$9705,$4560,$D380,$FFFF	; Spinning Dizzy 3
PLCTal_Dizzy4:		dc.w	$C000,$9705,$4620,$D380,$FFFF	; Spinning Dizzy 4
PLCTal_Dizzy5:		dc.w	$C000,$9705,$46E0,$D380,$FFFF	; Spinning Dizzy 5
PLCTal_Dizzy6:		dc.w	$E000,$9705,$47A0,$D380,$FFFF	; Spinning Dizzy 6
PLCTal_Dizzy7:		dc.w	$E000,$9705,$4880,$D380,$FFFF	; Spinning Dizzy 7
PLCTal_Dizzy8:		dc.w	$C000,$9705,$4960,$D380,$FFFF	; Spinning Dizzy 8
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; This next section is for Tails' tails
; ---------------------------------------------------------------------------
; Tails' Tails When Jumping (moving left or right) (Angle: 000* 180* degrees)
PLCTal_TalJmp01_000:	dc.w	$6000,$9705,$4A20,$D5C0,$FFFF
PLCTal_TalJmp02_000:	dc.w	$6000,$9705,$4A80,$D5C0,$FFFF
PLCTal_TalJmp03_000:	dc.w	$6000,$9705,$4AE0,$D5C0,$FFFF
PLCTal_TalJmp04_000:	dc.w	$6000,$9705,$4B40,$D5C0,$FFFF
; ---------------------------------------------------------------------------
; Tails' Tails When Jumping (moving left or right and up) (Angle: 045* 225* degrees)
PLCTal_TalJmp01_045:	dc.w	$6000,$9705,$4BA0,$D5C0,$FFFF
PLCTal_TalJmp02_045:	dc.w	$6000,$9705,$4C00,$D5C0,$FFFF
PLCTal_TalJmp03_045:	dc.w	$6000,$9705,$4C60,$D5C0,$FFFF
PLCTal_TalJmp04_045:	dc.w	$6000,$9705,$4CC0,$D5C0,$FFFF
; ---------------------------------------------------------------------------
; Tails' Tails When Jumping (moving Up or down) (Angle: 090* 270* degrees)
PLCTal_TalJmp01_090:	dc.w	$6000,$9705,$4D20,$D5C0,$FFFF
PLCTal_TalJmp02_090:	dc.w	$6000,$9705,$4D80,$D5C0,$FFFF
PLCTal_TalJmp03_090:	dc.w	$6000,$9705,$4DE0,$D5C0,$FFFF
PLCTal_TalJmp04_090:	dc.w	$6000,$9705,$4E40,$D5C0,$FFFF
; ---------------------------------------------------------------------------
; Tails' Tails When Jumping (moving left or right and down) (Angle: 135* 315* degrees)
PLCTal_TalJmp01_135:	dc.w	$6000,$9705,$4EA0,$D5C0,$FFFF
PLCTal_TalJmp02_135:	dc.w	$6000,$9705,$4F00,$D5C0,$FFFF
PLCTal_TalJmp03_135:	dc.w	$6000,$9705,$4F60,$D5C0,$FFFF
PLCTal_TalJmp04_135:	dc.w	$6000,$9705,$4FC0,$D5C0,$FFFF
; ---------------------------------------------------------------------------
; Running Normal and Fast (Angle: 000* 180* degrees)
PLCTal_RunNorm01_000:	dc.w	$8000,$9705,$5020,$D580,$FFFF	; RUN normal 1 000 (Unused)
PLCTal_RunNorm02_000:	dc.w	$4000,$9705,$50A0,$D580,$FFFF	; RUN normal 2 000 (Unused)
PLCTal_RunFast01_000:	dc.w	$2000,$9705,$50E0,$D580,$FFFF	; RUN fast 1 000
PLCTal_RunFast02_000:	dc.w	$8000,$9705,$5100,$D580,$FFFF	; RUN fast 2 000
; ---------------------------------------------------------------------------
; Running Normal and Fast (Angle: 045* 225* degrees)
PLCTal_RunNorm01_045:	dc.w	$8000,$9705,$5180,$D580,$FFFF	; RUN normal 1 045 (Unused)
PLCTal_RunNorm02_045:	dc.w	$4000,$9705,$5200,$D580,$FFFF	; RUN normal 2 045 (Unused)
PLCTal_RunFast01_045:	dc.w	$4000,$9705,$5240,$D580,$FFFF	; RUN fast 1 045 (Unused)
PLCTal_RunFast02_045:	dc.w	$8000,$9705,$5280,$D580,$FFFF	; RUN fast 2 045 (Unused)
; ---------------------------------------------------------------------------
; Running Normal and Fast (Angle: 090* 270* degrees)
PLCTal_RunNorm01_090:	dc.w	$4000,$9705,$5300,$D580,$FFFF	; RUN normal 1 090 (Unused)
PLCTal_RunNorm02_090:	dc.w	$8000,$9705,$5340,$D580,$FFFF	; RUN normal 2 090 (Unused)
PLCTal_RunFast01_090:	dc.w	$4000,$9705,$53C0,$D580,$FFFF	; RUN fast 1 090 (Unused)
PLCTal_RunFast02_090:	dc.w	$2000,$9705,$5400,$D580,$FFFF	; RUN fast 2 090 (Unused)
; ---------------------------------------------------------------------------
; Running Normal and Fast (Angle: 135* 315* degrees)
PLCTal_RunNorm01_135:	dc.w	$8000,$9705,$5420,$D580,$FFFF	; RUN normal 1 135 (Unused)
PLCTal_RunNorm02_135:	dc.w	$7000,$9705,$54A0,$D580,$FFFF	; RUN normal 2 135 (Unused)
PLCTal_RunFast01_135:	dc.w	$4000,$9705,$5510,$D580,$FFFF	; RUN fast 1 135 (Unused)
PLCTal_RunFast02_135:	dc.w	$4000,$9705,$5550,$D580,$FFFF	; RUN fast 2 135 (Unused)
; ---------------------------------------------------------------------------
PLCTal_UnkTails1:	dc.w	$8000,$9705,$5590,$D580,$FFFF	; Unknown frames (looks like the tails are flipping or snapping, or something on them lines)
PLCTal_UnkTails2:	dc.w	$4000,$9705,$5610,$D580,$FFFF	; ''
PLCTal_Wait01:		dc.w	$6000,$9705,$5650,$D580,$FFFF	; waiting, Looking up, looking down (Tails' Idle tails)
PLCTal_Wait02:		dc.w	$9000,$9705,$56B0,$D580,$FFFF	; ''
PLCTal_Wait03:		dc.w	$9000,$9705,$5740,$D580,$FFFF	; ''
PLCTal_Wait04:		dc.w	$6000,$9705,$57D0,$D580,$FFFF	; ''
PLCTal_Wait05:		dc.w	$9000,$9705,$5830,$D580,$FFFF	; ''
; ---------------------------------------------------------------------------
; ===========================================================================