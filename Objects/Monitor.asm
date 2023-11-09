ObjMonitor:				; CODE XREF: ROM:0000D280j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	MonitorRout1
		move.l	#Map_SpikesLR,$10(a6)
		move.w	#$430,$20(a6)
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
		cmpi.w	#8,d4
		blo.s	MonitorRout2
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
		cmpi.w	#8,d4
		blo.s	MonitorRout4
		bra.s	MonitorRout5
; ---------------------------------------------------------------------------

MonitorRout4:				; CODE XREF: ROM:0000E6D8j
					; ROM:0000E6DEj
		moveq	#1,d0
		jsr	(GTO_GameOver).l

MonitorRout5:				; CODE XREF: ROM:0000E6BEj
					; ROM:0000E6E0j
		bsr.w	SpriteScreenCheck
		bcc.s	MonitorRout6
		bsr.w	DeleteSprite

MonitorRout6:				; CODE XREF: ROM:0000E6EEj
		rts
; ---------------------------------------------------------------------------
