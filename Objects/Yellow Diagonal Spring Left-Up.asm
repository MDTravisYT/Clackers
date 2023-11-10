Obj_DiagYelSprng_LU:				; CODE XREF: ROM:0000D26Cj
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_DF96
		move.l	#Map_SpringAngUp,obMap(a6)
		move.w	#$2C07,obVRAM(a6)
		move.w	#$8080,4(a6)
		move.b	#$C,obWidth(a6)
		move.b	#$C,obHeight(a6)
		move.w	#0,obFlags(a6)

loc_DF96:				; CODE XREF: ROM:0000DF6Ej
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_DFF0
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#3,d4
		beq.s	loc_DFD4
		cmpi.w	#7,d4
		beq.s	loc_DFD4
		cmpi.w	#6,d4
		beq.s	loc_DFD4
		cmpi.w	#1,d4
		beq.s	loc_DFD4
		bra.s	loc_DFF0
; ---------------------------------------------------------------------------

loc_DFD4:				; CODE XREF: ROM:0000DFBEj
					; ROM:0000DFC4j ...
		move.b	#$A8,d0
		jsr		Play_Sound
		ori.w	#1,obFlags(a6)
		move.l	#$32985,d0
		move.l	#$32985,d1
		neg.l	d0
		neg.l	d1
		jsr	(SpeedToPos).l

loc_DFF0:				; CODE XREF: ROM:0000DFA4j
					; ROM:0000DFD2j
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E04A
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#3,d4
		beq.s	loc_E02E
		cmpi.w	#7,d4
		beq.s	loc_E02E
		cmpi.w	#6,d4
		beq.s	loc_E02E
		cmpi.w	#1,d4
		beq.s	loc_E02E
		bra.s	loc_E04A
; ---------------------------------------------------------------------------

loc_E02E:				; CODE XREF: ROM:0000E018j
					; ROM:0000E01Ej ...
		ori.w	#1,obFlags(a6)
		move.l	#$32985,d0
		move.l	#$32985,d1
		neg.l	d0
		neg.l	d1
		jsr	(SpeedToPos).l

loc_E04A:				; CODE XREF: ROM:0000DFFEj
					; ROM:0000E02Cj
		move.w	obFlags(a6),d0
		btst	#0,d0
		beq.s	loc_E070
		lea	(unk_42364).l,a0
		lea	(word_E2B0).l,a1
		bsr.w	AnimateSprite
		cmpi.b	#$FF,d0
		bne.s	loc_E070
		andi.w	#$FFFE,obFlags(a6)

loc_E070:				; CODE XREF: ROM:0000E052j
					; ROM:0000E068j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_E07A
		bsr.w	DeleteSprite

locret_E07A:				; CODE XREF: ROM:0000E074j
		rts
; ---------------------------------------------------------------------------
