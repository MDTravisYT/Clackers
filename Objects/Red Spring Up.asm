Obj_RedSpring_Up:				; CODE XREF: ROM:0000D22Cj
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_D4B2
		move.l	#Map_SpringUp,$10(a6)
		move.w	#$407,$20(a6)
		move.w	#$8080,4(a6)
		move.b	#$10,$22(a6)
		move.b	#8,$23(a6)
		move.w	#0,$2A(a6)

loc_D4B2:				; CODE XREF: ROM:0000D48Aj
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_D4FA
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#7,d4
		beq.s	loc_D4E4
		cmpi.w	#6,d4
		beq.s	loc_D4E4
		bra.s	loc_D4FA
; ---------------------------------------------------------------------------

loc_D4E4:				; CODE XREF: ROM:0000D4DAj
					; ROM:0000D4E0j
		move.b	#$A8,d0
		jsr		Play_Sound
		ori.w	#1,$2A(a6)
		move.l	#$F0000,d1
		neg.l	d1
		moveq	#0,d0
		jsr	(loc_CB1C).l

loc_D4FA:				; CODE XREF: ROM:0000D4C0j
					; ROM:0000D4E2j
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_D542
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#7,d4
		beq.s	loc_D52C
		cmpi.w	#6,d4
		beq.s	loc_D52C
		bra.s	loc_D542
; ---------------------------------------------------------------------------

loc_D52C:				; CODE XREF: ROM:0000D522j
					; ROM:0000D528j
		ori.w	#1,$2A(a6)
		move.l	#$F0000,d1
		neg.l	d1
		moveq	#0,d0
		jsr	(loc_CB1C).l

loc_D542:				; CODE XREF: ROM:0000D508j
					; ROM:0000D52Aj
		move.w	$2A(a6),d0
		btst	#0,d0
		beq.s	loc_D568
		lea	(unk_4235E).l,a0
		lea	(word_E2A4).l,a1
		bsr.w	AnimateSprite
		cmpi.b	#$FF,d0
		bne.s	loc_D568
		andi.w	#$FFFE,$2A(a6)

loc_D568:				; CODE XREF: ROM:0000D54Aj
					; ROM:0000D560j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_D572
		bsr.w	DeleteObject

locret_D572:				; CODE XREF: ROM:0000D56Cj
		rts
; ---------------------------------------------------------------------------
