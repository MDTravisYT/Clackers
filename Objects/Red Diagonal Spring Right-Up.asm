Obj_DiagRedSprng_RU:				; CODE XREF: ROM:0000D238j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_D68E
		move.l	#Map_SpringAngUp,obMap(a6)
		move.w	#$407,obVRAM(a6)
		move.w	#$8080,4(a6)
		move.b	#$C,obWidth(a6)
		move.b	#$C,obHeight(a6)
		move.w	#0,obFlags(a6)

loc_D68E:				; CODE XREF: ROM:0000D666j
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_D6E6
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#2,d4
		beq.s	loc_D6CC
		cmpi.w	#6,d4
		beq.s	loc_D6CC
		cmpi.w	#7,d4
		beq.s	loc_D6CC
		cmpi.w	#0,d4
		beq.s	loc_D6CC
		bra.s	loc_D6E6
; ---------------------------------------------------------------------------

loc_D6CC:				; CODE XREF: ROM:0000D6B6j
					; ROM:0000D6BCj ...
		move.b	#$A8,d0
		jsr		Play_Sound
		ori.w	#1,obFlags(a6)
		move.l	#$A8F98,d0
		move.l	#$A8F98,d1
		neg.l	d1
		jsr	(SpeedToPos).l

loc_D6E6:				; CODE XREF: ROM:0000D69Cj
					; ROM:0000D6CAj
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_D73E
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#2,d4
		beq.s	loc_D724
		cmpi.w	#6,d4
		beq.s	loc_D724
		cmpi.w	#7,d4
		beq.s	loc_D724
		cmpi.w	#0,d4
		beq.s	loc_D724
		bra.s	loc_D73E
; ---------------------------------------------------------------------------

loc_D724:				; CODE XREF: ROM:0000D70Ej
					; ROM:0000D714j ...
		ori.w	#1,obFlags(a6)
		move.l	#$A8F98,d0
		move.l	#$A8F98,d1
		neg.l	d1
		jsr	(SpeedToPos).l

loc_D73E:				; CODE XREF: ROM:0000D6F4j
					; ROM:0000D722j
		move.w	obFlags(a6),d0
		btst	#0,d0
		beq.s	loc_D764
		lea	(unk_42364).l,a0
		lea	(word_E2B0).l,a1
		bsr.w	AnimateSprite
		cmpi.b	#$FF,d0
		bne.s	loc_D764
		andi.w	#$FFFE,obFlags(a6)

loc_D764:				; CODE XREF: ROM:0000D746j
					; ROM:0000D75Cj
		bsr.w	SpriteScreenCheck
		bcc.s	locret_D76E
		bsr.w	DeleteSprite

locret_D76E:				; CODE XREF: ROM:0000D768j
		rts
; ---------------------------------------------------------------------------