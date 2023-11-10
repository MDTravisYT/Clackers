Obj_DiagRedSprng_RD:				; CODE XREF: ROM:0000D240j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_D8B2
		move.l	#Map_SpringAngUp,obMap(a6)
		move.w	#$1407,obVRAM(a6)
		move.w	#$8080,4(a6)
		move.b	#$C,obWidth(a6)
		move.b	#$C,obHeight(a6)
		move.w	#0,obFlags(a6)

loc_D8B2:				; CODE XREF: ROM:0000D88Aj
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_D908
		move.w	obX(a6),d0
		move.w	obY(a6),d1
		move.w	obX(a0),d2
		move.w	obY(a0),d3
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
		ori.w	#1,obFlags(a6)
		move.l	#$A8F98,d0
		move.l	#$A8F98,d1
		jsr	(SpeedToPos).l

loc_D908:				; CODE XREF: ROM:0000D8C0j
					; ROM:0000D8EEj
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_D95E
		move.w	obX(a6),d0
		move.w	obY(a6),d1
		move.w	obX(a0),d2
		move.w	obY(a0),d3
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
		ori.w	#1,obFlags(a6)
		move.l	#$A8F98,d0
		move.l	#$A8F98,d1
		jsr	(SpeedToPos).l

loc_D95E:				; CODE XREF: ROM:0000D916j
					; ROM:0000D944j
		move.w	obFlags(a6),d0
		btst	#0,d0
		beq.s	loc_D984
		lea	(unk_42364).l,a0
		lea	(word_E2B0).l,a1
		bsr.w	AnimateSprite
		cmpi.b	#$FF,d0
		bne.s	loc_D984
		andi.w	#$FFFE,obFlags(a6)

loc_D984:				; CODE XREF: ROM:0000D966j
					; ROM:0000D97Cj
		bsr.w	SpriteScreenCheck
		bcc.s	locret_D98E
		bsr.w	DeleteSprite

locret_D98E:				; CODE XREF: ROM:0000D988j
		rts
; ---------------------------------------------------------------------------
