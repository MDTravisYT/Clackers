Obj_DiagYelSprng_RD:				; CODE XREF: ROM:0000D270j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_E0AA
		move.l	#Map_SpringAngUp,obMap(a6)
		move.w	#$3407,obVRAM(a6)
		move.w	#$8080,4(a6)
		move.b	#$C,obWidth(a6)
		move.b	#$C,obHeight(a6)
		move.w	#0,obFlags(a6)

loc_E0AA:				; CODE XREF: ROM:0000E082j
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E100
		move.w	obX(a6),d0
		move.w	obY(a6),d1
		move.w	obX(a0),d2
		move.w	obY(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#0,d4
		beq.s	loc_E0E8
		cmpi.w	#4,d4
		beq.s	loc_E0E8
		cmpi.w	#2,d4
		beq.s	loc_E0E8
		cmpi.w	#5,d4
		beq.s	loc_E0E8
		bra.s	loc_E100
; ---------------------------------------------------------------------------

loc_E0E8:				; CODE XREF: ROM:0000E0D2j
					; ROM:0000E0D8j ...
		move.b	#$A8,d0
		jsr		Play_Sound
		ori.w	#1,obFlags(a6)
		move.l	#$32985,d0
		move.l	#$32985,d1
		jsr	(SpeedToPos).l

loc_E100:				; CODE XREF: ROM:0000E0B8j
					; ROM:0000E0E6j
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E156
		move.w	obX(a6),d0
		move.w	obY(a6),d1
		move.w	obX(a0),d2
		move.w	obY(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#0,d4
		beq.s	loc_E13E
		cmpi.w	#4,d4
		beq.s	loc_E13E
		cmpi.w	#2,d4
		beq.s	loc_E13E
		cmpi.w	#5,d4
		beq.s	loc_E13E
		bra.s	loc_E156
; ---------------------------------------------------------------------------

loc_E13E:				; CODE XREF: ROM:0000E128j
					; ROM:0000E12Ej ...
		ori.w	#1,obFlags(a6)
		move.l	#$32985,d0
		move.l	#$32985,d1
		jsr	(SpeedToPos).l

loc_E156:				; CODE XREF: ROM:0000E10Ej
					; ROM:0000E13Cj
		move.w	obFlags(a6),d0
		btst	#0,d0
		beq.s	loc_E17C
		lea	(unk_42364).l,a0
		lea	(word_E2B0).l,a1
		bsr.w	AnimateSprite
		cmpi.b	#$FF,d0
		bne.s	loc_E17C
		andi.w	#$FFFE,obFlags(a6)

loc_E17C:				; CODE XREF: ROM:0000E15Ej
					; ROM:0000E174j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_E186
		bsr.w	DeleteSprite

locret_E186:				; CODE XREF: ROM:0000E180j
		rts
; ---------------------------------------------------------------------------
