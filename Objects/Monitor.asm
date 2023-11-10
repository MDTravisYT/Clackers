Map_Monitor:
;	$SS   = Shape and size of sprite piece
;	$YY   = Y position of sprite piece
;	$TTTT = Tile to read in VRam
;	$XX   = X position of sprite piece
;	$ZZ   = whether it's the last map to use in the sprite or not (00 Include next map in sprite/FF End of sprite)
;	dc.b	$SS,$YY,$TT,$TT,$XX,$ZZ
	MapMon_Still:
		dc.b	$0F,$F0,$00,$4E,$F0,$FF
	MapMon_Ex1:
		dc.b	$05,$F8,$00,$46,$F8,$00
		dc.b	$0F,$F0,$00,$4E,$F0,$FF
	MapMon_Ex2:
		dc.b	$05,$F8,$20,$00,$F8,$00
		dc.b	$0F,$F0,$00,$4E,$F0,$FF
	MapMon_Ex3:
		dc.b	$0A,$F4,$20,$04,$F4,$00
		dc.b	$0F,$F0,$00,$4E,$F0,$FF
	MapMon_Ex4:
		dc.b	$07,$F0,$20,$0D,$F0,$00
		dc.b	$07,$F0,$38,$0D,$00,$00
		dc.b	$0D,$00,$00,$5E,$F0,$00
		dc.b	$05,$01,$00,$40,$E5,$00
		dc.b	$05,$01,$08,$40,$0B,$FF
	MapMon_Ex5:
		dc.b	$09,$EC,$00,$15,$EC,$00
		dc.b	$06,$FC,$00,$1B,$EC,$00
		dc.b	$00,$FC,$00,$21,$FC,$00
		dc.b	$09,$04,$18,$15,$FC,$00
		dc.b	$06,$EC,$18,$1B,$04,$00
		dc.b	$0D,$00,$00,$5E,$F0,$00
		dc.b	$05,$01,$00,$40,$E1,$00
		dc.b	$05,$01,$08,$40,$0F,$FF
	MapMon_Ex6:
		dc.b	$09,$EC,$00,$22,$EC,$00
		dc.b	$06,$FC,$00,$28,$EC,$00
		dc.b	$00,$FC,$00,$2E,$FC,$00
		dc.b	$09,$04,$18,$22,$FC,$00
		dc.b	$06,$EC,$18,$28,$04,$00
		dc.b	$0D,$00,$00,$5E,$F0,$00
		dc.b	$05,$01,$00,$40,$DF,$00
		dc.b	$05,$01,$08,$40,$11,$FF
	MapMon_Ex7:
		dc.b	$0D,$00,$00,$5E,$F0,$00
		dc.b	$05,$01,$00,$40,$DD,$00
		dc.b	$05,$01,$08,$40,$13,$FF
	MapMon_Ex8:
		dc.b	$0D,$00,$00,$5E,$F0,$00
		dc.b	$04,$09,$00,$44,$D9,$00
		dc.b	$04,$09,$08,$44,$17,$FF
	MapMon_Ex9:
		dc.b	$0D,$00,$00,$5E,$F0,$00
		dc.b	$04,$09,$00,$44,$D8,$00
		dc.b	$04,$09,$08,$44,$18,$FF
	MapMon_ExA:
		dc.b	$0D,$00,$00,$5E,$F0,$00
		dc.b	$04,$09,$00,$44,$D7,$00
		dc.b	$04,$09,$08,$44,$19,$FF
	MapMon_ExB:
		dc.b	$0D,$00,$00,$5E,$F0,$00
		dc.b	$04,$09,$00,$44,$D6,$00
		dc.b	$04,$09,$08,$44,$1A,$FF
	MapMon_ExC:
		dc.b	$0D,$00,$00,$5E,$F0,$00
		dc.b	$00,$08,$00,$4A,$DC,$00
		dc.b	$00,$08,$08,$4A,$1C,$FF
	MapMon_ExD:
		dc.b	$0D,$00,$00,$5E,$F0,$00
		dc.b	$00,$08,$00,$4B,$DB,$00
		dc.b	$00,$08,$08,$4B,$1D,$FF
	MapMon_ExE:
		dc.b	$0D,$00,$00,$5E,$F0,$00
		dc.b	$00,$07,$00,$4C,$DB,$00
		dc.b	$00,$07,$08,$4C,$1D,$FF
	MapMon_ExF:
		dc.b	$0D,$00,$00,$5E,$F0,$00
		dc.b	$00,$07,$00,$4D,$DA,$00
		dc.b	$00,$07,$08,$4D,$1E,$FF
	MapMon_Dead:
		dc.b	$0D,$00,$00,$5E,$F0,$FF
	
ANI_Monitor:
	dc.w	$0301,$0302,$0303,$0304,$0305,$0306,$0307,$0308,$0309,$030A,$030B,$030C,$030D,$030E,$030F,$7F10,$7F10,$7F10,$7F10,$7F10,$7F10,$7F10,$7F10,$7F10,$7F10,$8080
	
Def_Monitor:
	dc.w	MapMon_Still-Def_Monitor
	dc.w	MapMon_Ex1-Def_Monitor
	dc.w	MapMon_Ex2-Def_Monitor
	dc.w	MapMon_Ex3-Def_Monitor
	dc.w	MapMon_Ex4-Def_Monitor
	dc.w	MapMon_Ex5-Def_Monitor
	dc.w	MapMon_Ex6-Def_Monitor
	dc.w	MapMon_Ex7-Def_Monitor
	dc.w	MapMon_Ex8-Def_Monitor
	dc.w	MapMon_Ex9-Def_Monitor
	dc.w	MapMon_ExA-Def_Monitor
	dc.w	MapMon_ExB-Def_Monitor
	dc.w	MapMon_ExC-Def_Monitor
	dc.w	MapMon_ExD-Def_Monitor
	dc.w	MapMon_ExE-Def_Monitor
	dc.w	MapMon_ExF-Def_Monitor
	dc.w	MapMon_Dead-Def_Monitor

ObjMonitor:				; CODE XREF: ROM:0000D280j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	MonitorRout1
		move.l	#Map_Monitor,obMap(a6)
		move.w	#$458,obVRAM(a6)
		move.w	#$8080,4(a6)
		move.b	#$10,obWidth(a6)
		move.b	#$10,obHeight(a6)

MonitorRout1:				; CODE XREF: ROM:0000E654j
		move.w	obFlags(a6),d0                      ; load flags to d0
		btst	#0,d0                           ; was the animation flag set?
		bne.s	MonitorRout3                 ; if so, branch
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	MonitorRout3
		move.w	obX(a6),d0
		move.w	obY(a6),d1
		move.w	obX(a0),d2
		move.w	obY(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#$07,d4							;	is object on top side, above and closer to character on X?
		beq.s	MonitorRout2					;	if so, branch
		cmpi.w	#$06,d4							;	is object on top side, below and closer to character on X?
		beq.s	MonitorRout2					;	if so, branch
		bra.s	MonitorRout3
; ---------------------------------------------------------------------------

MonitorRout2:
		ori.w	#$01,obFlags(a6)					;	set flag to animate
		bclr	#$00,$25(a0)
		move.l	#$FFFB0000,obYVel(a0)
	;	jsr	(DeleteObject).l
		rts

MonitorRout3:
		move.w	obFlags(a6),d0                      ; load flags to d0
		btst	#0,d0                           ; was the animation flag set?
		bne.s	Anim_Monitor                 ; if so, branch
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	Anim_Monitor
		move.w	obX(a6),d0
		move.w	obY(a6),d1
		move.w	obX(a0),d2
		move.w	obY(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#$07,d4							;	is object on top side, above and closer to character on X?
		beq.s	MonitorRout4					;	if so, branch
		cmpi.w	#$06,d4							;	is object on top side, below and closer to character on X?
		beq.s	MonitorRout4					;	if so, branch
		bra.s	Anim_Monitor
; ---------------------------------------------------------------------------

MonitorRout4:
		ori.w	#$01,obFlags(a6)					;	set flag to animate
		bclr	#$00,$25(a0)
		move.l	#$FFFB0000,obYVel(a0)
	;	jsr	(DeleteObject).l
		rts
		
Anim_Monitor:
		move.w	obFlags(a6),d0                      ; load flags to d0
		btst	#0,d0                           ; was the animation flag set?
		beq.s	MonitorRout5                 ; if not, branch
		lea	(Def_Monitor).l,a0
		lea	(ANI_Monitor).l,a1			; load spring's Animation script
		bsr.w	AnimateSprite				; animate the spring

MonitorRout5:			
		bsr.w	SpriteScreenCheck
		bcc.s	MonitorRout6
		bsr.w	DeleteSprite

MonitorRout6:				; CODE XREF: ROM:0000E6EEj
		rts
; ---------------------------------------------------------------------------
