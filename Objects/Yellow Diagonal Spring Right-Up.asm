Obj_DiagYelSprng_RU:				; CODE XREF: ROM:0000D268j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_DE86
		move.l	#Map_SpringAngUp,obMap(a6)
		move.w	#$2407,obVRAM(a6)
		move.w	#$8080,4(a6)
		move.b	#$C,obWidth(a6)
		move.b	#$C,obHeight(a6)
		move.w	#0,obFlags(a6)

loc_DE86:				; CODE XREF: ROM:0000DE5Ej
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_DEDE
		move.w	obX(a6),d0
		move.w	obY(a6),d1
		move.w	obX(a0),d2
		move.w	obY(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#2,d4
		beq.s	loc_DEC4
		cmpi.w	#6,d4
		beq.s	loc_DEC4
		cmpi.w	#7,d4
		beq.s	loc_DEC4
		cmpi.w	#0,d4
		beq.s	loc_DEC4
		bra.s	loc_DEDE
; ---------------------------------------------------------------------------

loc_DEC4:				; CODE XREF: ROM:0000DEAEj
					; ROM:0000DEB4j ...
		move.b	#$A8,d0
		jsr		Play_Sound
		ori.w	#1,obFlags(a6)
		move.l	#$32985,d0
		move.l	#$32985,d1
		neg.l	d1
		jsr	(SpeedToPos).l

loc_DEDE:				; CODE XREF: ROM:0000DE94j
					; ROM:0000DEC2j
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_DF36
		move.w	obX(a6),d0
		move.w	obY(a6),d1
		move.w	obX(a0),d2
		move.w	obY(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#2,d4
		beq.s	loc_DF1C
		cmpi.w	#6,d4
		beq.s	loc_DF1C
		cmpi.w	#7,d4
		beq.s	loc_DF1C
		cmpi.w	#0,d4
		beq.s	loc_DF1C
		bra.s	loc_DF36
; ---------------------------------------------------------------------------

loc_DF1C:				; CODE XREF: ROM:0000DF06j
					; ROM:0000DF0Cj ...
		ori.w	#1,obFlags(a6)
		move.l	#$32985,d0
		move.l	#$32985,d1
		neg.l	d1
		jsr	(SpeedToPos).l

loc_DF36:				; CODE XREF: ROM:0000DEECj
					; ROM:0000DF1Aj
		move.w	obFlags(a6),d0
		btst	#0,d0
		beq.s	loc_DF5C
		lea	(unk_42364).l,a0
		lea	(word_E2B0).l,a1
		bsr.w	AnimateSprite
		cmpi.b	#$FF,d0
		bne.s	loc_DF5C
		andi.w	#$FFFE,obFlags(a6)

loc_DF5C:				; CODE XREF: ROM:0000DF3Ej
					; ROM:0000DF54j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_DF66
		bsr.w	DeleteSprite

locret_DF66:				; CODE XREF: ROM:0000DF60j
		rts
; ---------------------------------------------------------------------------