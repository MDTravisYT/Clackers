Obj_RedSpring_Down:				; CODE XREF: ROM:0000D230j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_D5A2
		move.l	#Map_SpringUp,$10(a6)
		move.w	#$1407,$20(a6)
		move.w	#$8080,4(a6)
		move.b	#$10,$22(a6)
		move.b	#8,$23(a6)
		move.w	#0,$2A(a6)

loc_D5A2:				; CODE XREF: ROM:0000D57Aj
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_D5E8
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#4,d4
		beq.s	loc_D5D4
		cmpi.w	#5,d4
		beq.s	loc_D5D4
		bra.s	loc_D5E8
; ---------------------------------------------------------------------------

loc_D5D4:				; CODE XREF: ROM:0000D5CAj
					; ROM:0000D5D0j
		move.b	#$A8,d0
		jsr		Play_Sound
		ori.w	#1,$2A(a6)
		move.l	#$F0000,d1
		moveq	#0,d0
		jsr	(loc_CB1C).l

loc_D5E8:				; CODE XREF: ROM:0000D5B0j
					; ROM:0000D5D2j
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_D62E
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#5,d4
		beq.s	loc_D61A
		cmpi.w	#4,d4
		beq.s	loc_D61A
		bra.s	loc_D62E
; ---------------------------------------------------------------------------
loc_D61A:				; CODE XREF: ROM:0000D610j
					; ROM:0000D616j
		ori.w	#1,$2A(a6)
		move.l	#$F0000,d1
		moveq	#0,d0
		jsr	(loc_CB1C).l

loc_D62E:				; CODE XREF: ROM:0000D5F6j
					; ROM:0000D618j
		move.w	$2A(a6),d0
		btst	#0,d0
		beq.s	loc_D654
		lea	(unk_4235E).l,a0
		lea	(word_E2A4).l,a1
		bsr.w	AnimateSprite
		cmpi.b	#$FF,d0
		bne.s	loc_D654
		andi.w	#$FFFE,$2A(a6)

loc_D654:				; CODE XREF: ROM:0000D636j
					; ROM:0000D64Cj
		bsr.w	SpriteScreenCheck
		bcc.s	locret_D65E
		bsr.w	DeleteObject

locret_D65E:				; CODE XREF: ROM:0000D658j
		rts
; ---------------------------------------------------------------------------