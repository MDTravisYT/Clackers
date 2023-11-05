Obj_DiagRedSprng_RD:				; CODE XREF: ROM:0000D240j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_D8B2
		move.l	#Map_SpringAngUp,$10(a6)
		move.w	#$1407,$20(a6)
		move.w	#$8080,4(a6)
		move.b	#$C,$22(a6)
		move.b	#$C,$23(a6)
		move.w	#0,$2A(a6)

loc_D8B2:				; CODE XREF: ROM:0000D88Aj
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_D908
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#0,d4
		beq.s	loc_D8F0
		cmpi.w	#4,d4
		beq.s	loc_D8F0
		cmpi.w	#2,d4
		beq.s	loc_D8F0
		cmpi.w	#5,d4
		beq.s	loc_D8F0
		bra.s	loc_D908
; ---------------------------------------------------------------------------

loc_D8F0:				; CODE XREF: ROM:0000D8DAj
					; ROM:0000D8E0j ...
		move.b	#$A8,d0
		jsr		Play_Sound
		ori.w	#1,$2A(a6)
		move.l	#$A8F98,d0
		move.l	#$A8F98,d1
		jsr	(loc_CB1C).l

loc_D908:				; CODE XREF: ROM:0000D8C0j
					; ROM:0000D8EEj
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_D95E
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#0,d4
		beq.s	loc_D946
		cmpi.w	#4,d4
		beq.s	loc_D946
		cmpi.w	#2,d4
		beq.s	loc_D946
		cmpi.w	#5,d4
		beq.s	loc_D946
		bra.s	loc_D95E
; ---------------------------------------------------------------------------

loc_D946:				; CODE XREF: ROM:0000D930j
					; ROM:0000D936j ...
		ori.w	#1,$2A(a6)
		move.l	#$A8F98,d0
		move.l	#$A8F98,d1
		jsr	(loc_CB1C).l

loc_D95E:				; CODE XREF: ROM:0000D916j
					; ROM:0000D944j
		move.w	$2A(a6),d0
		btst	#0,d0
		beq.s	loc_D984
		lea	(unk_42364).l,a0
		lea	(word_E2B0).l,a1
		bsr.w	AnimateSprite
		cmpi.b	#$FF,d0
		bne.s	loc_D984
		andi.w	#$FFFE,$2A(a6)

loc_D984:				; CODE XREF: ROM:0000D966j
					; ROM:0000D97Cj
		bsr.w	SpriteScreenCheck
		bcc.s	locret_D98E
		bsr.w	DeleteObject

locret_D98E:				; CODE XREF: ROM:0000D988j
		rts
; ---------------------------------------------------------------------------
