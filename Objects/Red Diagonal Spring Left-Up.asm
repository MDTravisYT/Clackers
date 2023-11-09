Obj_DiagRedSprng_LU:				; CODE XREF: ROM:0000D23Cj
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_D79E
		move.l	#Map_SpringAngUp,$10(a6)
		move.w	#$C07,$20(a6)
		move.w	#$8080,4(a6)
		move.b	#$C,$22(a6)
		move.b	#$C,$23(a6)
		move.w	#0,$2A(a6)

loc_D79E:				; CODE XREF: ROM:0000D776j
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_D7F8
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#3,d4
		beq.s	loc_D7DC
		cmpi.w	#7,d4
		beq.s	loc_D7DC
		cmpi.w	#6,d4
		beq.s	loc_D7DC
		cmpi.w	#1,d4
		beq.s	loc_D7DC
		bra.s	loc_D7F8
; ---------------------------------------------------------------------------

loc_D7DC:				; CODE XREF: ROM:0000D7C6j
					; ROM:0000D7CCj ...
		move.b	#$A8,d0
		jsr		Play_Sound
		ori.w	#1,$2A(a6)
		move.l	#$A8F98,d0
		move.l	#$A8F98,d1
		neg.l	d0
		neg.l	d1
		jsr	(SpeedToPos).l

loc_D7F8:				; CODE XREF: ROM:0000D7ACj
					; ROM:0000D7DAj
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_D852
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#3,d4
		beq.s	loc_D836
		cmpi.w	#7,d4
		beq.s	loc_D836
		cmpi.w	#6,d4
		beq.s	loc_D836
		cmpi.w	#1,d4
		beq.s	loc_D836
		bra.s	loc_D852
; ---------------------------------------------------------------------------

loc_D836:				; CODE XREF: ROM:0000D820j
					; ROM:0000D826j ...
		ori.w	#1,$2A(a6)
		move.l	#$A8F98,d0
		move.l	#$A8F98,d1
		neg.l	d0
		neg.l	d1
		jsr	(SpeedToPos).l

loc_D852:				; CODE XREF: ROM:0000D806j
					; ROM:0000D834j
		move.w	$2A(a6),d0
		btst	#0,d0
		beq.s	loc_D878
		lea	(unk_42364).l,a0
		lea	(word_E2B0).l,a1
		bsr.w	AnimateSprite
		cmpi.b	#$FF,d0
		bne.s	loc_D878
		andi.w	#$FFFE,$2A(a6)

loc_D878:				; CODE XREF: ROM:0000D85Aj
					; ROM:0000D870j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_D882
		bsr.w	DeleteObject

locret_D882:				; CODE XREF: ROM:0000D87Cj
		rts