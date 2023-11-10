Obj_DiagYelSprng_LD:				; CODE XREF: ROM:0000D274j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_E1B6
		move.l	#Map_SpringAngUp,obMap(a6)
		move.w	#$3C07,obVRAM(a6)
		move.w	#$8080,4(a6)
		move.b	#$C,obWidth(a6)
		move.b	#$C,obHeight(a6)
		move.w	#0,obFlags(a6)

loc_E1B6:				; CODE XREF: ROM:0000E18Ej
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E20E
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#1,d4
		beq.s	loc_E1F4
		cmpi.w	#5,d4
		beq.s	loc_E1F4
		cmpi.w	#3,d4
		beq.s	loc_E1F4
		cmpi.w	#4,d4
		beq.s	loc_E1F4
		bra.s	loc_E20E
; ---------------------------------------------------------------------------

loc_E1F4:				; CODE XREF: ROM:0000E1DEj
					; ROM:0000E1E4j ...
		move.b	#$A8,d0
		jsr		Play_Sound
		ori.w	#1,obFlags(a6)
		move.l	#$32985,d0
		move.l	#$32985,d1
		neg.l	d0
		jsr	(SpeedToPos).l

loc_E20E:				; CODE XREF: ROM:0000E1C4j
					; ROM:0000E1F2j
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E266
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#1,d4
		beq.s	loc_E24C
		cmpi.w	#5,d4
		beq.s	loc_E24C
		cmpi.w	#3,d4
		beq.s	loc_E24C
		cmpi.w	#4,d4
		beq.s	loc_E24C
		bra.s	loc_E266
; ---------------------------------------------------------------------------

loc_E24C:				; CODE XREF: ROM:0000E236j
					; ROM:0000E23Cj ...
		ori.w	#1,obFlags(a6)
		move.l	#$32985,d0
		move.l	#$32985,d1
		neg.l	d0
		jsr	(SpeedToPos).l

loc_E266:				; CODE XREF: ROM:0000E21Cj
					; ROM:0000E24Aj
		move.w	obFlags(a6),d0
		btst	#0,d0
		beq.s	loc_E28C
		lea	(unk_42364).l,a0
		lea	(word_E2B0).l,a1
		bsr.w	AnimateSprite
		cmpi.b	#$FF,d0
		bne.s	loc_E28C
		andi.w	#$FFFE,obFlags(a6)

loc_E28C:				; CODE XREF: ROM:0000E26Ej
					; ROM:0000E284j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_E296
		bsr.w	DeleteSprite

locret_E296:				; CODE XREF: ROM:0000E290j
		rts