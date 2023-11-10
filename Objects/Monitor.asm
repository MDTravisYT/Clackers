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
	
ANI_Monitor:
	dc.w	$1000,$1001,$8080
	
Def_Monitor:
	dc.w	MapMon_Still-ANI_Monitor_2
	dc.w	MapMon_Ex1-ANI_Monitor_2

ObjMonitor:				; CODE XREF: ROM:0000D280j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	MonitorRout1
		move.l	#Map_Monitor,$10(a6)
		move.w	#$458,$20(a6)
		move.w	#$8080,4(a6)
		move.b	#$10,$22(a6)
		move.b	#$10,$23(a6)

MonitorRout1:				; CODE XREF: ROM:0000E654j
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	MonitorRout3
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#$07,d4							;	is object on top side, above and closer to character on X?
		beq.s	MonitorRout2					;	if so, branch
		cmpi.w	#$06,d4							;	is object on top side, below and closer to character on X?
		beq.s	MonitorRout2					;	if so, branch
		bra.s	MonitorRout3
; ---------------------------------------------------------------------------

MonitorRout2:
		bclr	#$00,$25(a0)
		move.l	#$FFFB0000,$1C(a0)
		jsr	(DeleteObject).l
		rts

MonitorRout3:				; CODE XREF: ROM:0000E684j
					; ROM:0000E6A6j
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	MonitorRout5
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#$07,d4							;	is object on top side, above and closer to character on X?
		beq.s	MonitorRout4					;	if so, branch
		cmpi.w	#$06,d4							;	is object on top side, below and closer to character on X?
		beq.s	MonitorRout4					;	if so, branch
		bra.s	MonitorRout5
; ---------------------------------------------------------------------------

MonitorRout4:				; CODE XREF: ROM:0000E6D8j
					; ROM:0000E6DEj
		moveq	#1,d0
		jsr	(GTO_GameOver).l

MonitorRout5:				; CODE XREF: ROM:0000E6BEj
					; ROM:0000E6E0j
		lea	(Def_Monitor).l,a0
		lea	(ANI_Monitor).l,a1			; load spring's Animation script
		bsr.w	AnimateSprite				; animate the spring
					
		bsr.w	SpriteScreenCheck
		bcc.s	MonitorRout6
		bsr.w	DeleteSprite

MonitorRout6:				; CODE XREF: ROM:0000E6EEj
		rts
; ---------------------------------------------------------------------------
