ObjGoal:				; CODE XREF: ROM:0000D280j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	GoalRout1
		move.l	#Map_SpikesLR,$10(a6)
		move.w	#$430,$20(a6)
		move.w	#$8080,4(a6)
		move.b	#$10,$22(a6)
		move.b	#$10,$23(a6)

GoalRout1:				; CODE XREF: ROM:0000E654j
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	GoalRout3
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#8,d4
		blo.s	GoalRout2
		bra.s	GoalRout3
; ---------------------------------------------------------------------------

GoalRout2:				; CODE XREF: ROM:0000E69Ej
					; ROM:0000E6A4j
		moveq	#1,d0
		jsr	(GTO_GameOver).l

GoalRout3:				; CODE XREF: ROM:0000E684j
					; ROM:0000E6A6j
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	GoalRout5
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#8,d4
		blo.s	GoalRout4
		bra.s	GoalRout5
; ---------------------------------------------------------------------------

GoalRout4:				; CODE XREF: ROM:0000E6D8j
					; ROM:0000E6DEj
		moveq	#1,d0
		jsr	(GTO_GameOver).l

GoalRout5:				; CODE XREF: ROM:0000E6BEj
					; ROM:0000E6E0j
		bsr.w	SpriteScreenCheck
		bcc.s	GoalRout6
		bsr.w	DeleteObject

GoalRout6:				; CODE XREF: ROM:0000E6EEj
		rts
; ---------------------------------------------------------------------------
