Obj_DiagRedSprng_LD:				; CODE XREF: ROM:0000D244j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_D9BE
		move.l	#Map_SpringAngUp,obMap(a6)
		move.w	#$1C07,obVRAM(a6)
		move.w	#$8080,4(a6)
		move.b	#$C,obWidth(a6)
		move.b	#$C,obHeight(a6)
		move.w	#0,obFlags(a6)

loc_D9BE:				; CODE XREF: ROM:0000D996j
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_DA16
		move.w	obX(a6),d0
		move.w	obY(a6),d1
		move.w	obX(a0),d2
		move.w	obY(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#1,d4
		beq.s	loc_D9FC
		cmpi.w	#5,d4
		beq.s	loc_D9FC
		cmpi.w	#3,d4
		beq.s	loc_D9FC
		cmpi.w	#4,d4
		beq.s	loc_D9FC
		bra.s	loc_DA16
; ---------------------------------------------------------------------------

loc_D9FC:				; CODE XREF: ROM:0000D9E6j
					; ROM:0000D9ECj ...
		move.b	#$A8,d0
		jsr		Play_Sound
		ori.w	#1,obFlags(a6)
		move.l	#$A8F98,d0
		move.l	#$A8F98,d1
		neg.l	d0
		jsr	(SpeedToPos).l

loc_DA16:				; CODE XREF: ROM:0000D9CCj
					; ROM:0000D9FAj
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_DA6E
		move.w	obX(a6),d0
		move.w	obY(a6),d1
		move.w	obX(a0),d2
		move.w	obY(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#1,d4
		beq.s	loc_DA54
		cmpi.w	#5,d4
		beq.s	loc_DA54
		cmpi.w	#3,d4
		beq.s	loc_DA54
		cmpi.w	#4,d4
		beq.s	loc_DA54
		bra.s	loc_DA6E
; ---------------------------------------------------------------------------

loc_DA54:				; CODE XREF: ROM:0000DA3Ej
					; ROM:0000DA44j ...
		ori.w	#1,obFlags(a6)
		move.l	#$A8F98,d0
		move.l	#$A8F98,d1
		neg.l	d0
		jsr	(SpeedToPos).l

loc_DA6E:				; CODE XREF: ROM:0000DA24j
					; ROM:0000DA52j
		move.w	obFlags(a6),d0
		btst	#0,d0
		beq.s	loc_DA94
		lea	(unk_42364).l,a0
		lea	(word_E2B0).l,a1
		bsr.w	AnimateSprite
		cmpi.b	#$FF,d0
		bne.s	loc_DA94
		andi.w	#$FFFE,obFlags(a6)

loc_DA94:				; CODE XREF: ROM:0000DA76j
					; ROM:0000DA8Cj
		bsr.w	SpriteScreenCheck
		bcc.s	locret_DA9E
		bsr.w	DeleteSprite

locret_DA9E:				; CODE XREF: ROM:0000DA98j
		rts
; ---------------------------------------------------------------------------
