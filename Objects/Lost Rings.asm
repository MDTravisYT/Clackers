Obj_LostRings:				; CODE XREF: ROM:0000D24Cj
		subq.w	#1,$26(a6)
		bne.s	loc_E2C8
		jmp	DeleteObject
; ---------------------------------------------------------------------------

loc_E2C8:				; CODE XREF: ROM:0000E2C2j
		move.w	obX(a6),d0
		move.w	obY(a6),d1
		jsr	sub_1DA8
		beq.s	loc_E2E6
		move.l	obYVel(a6),d6
		neg.l	d6
		move.l	d6,d7
		asr.l	#2,d7
		sub.l	d7,d6
		move.l	d6,obYVel(a6)

loc_E2E6:				; CODE XREF: ROM:0000E2D4j
		move.w	d0,obX(a6)
		move.w	d1,obY(a6)
		move.l	obXVel(a6),d0
		add.l	d0,obX(a6)
		move.l	obYVel(a6),d0
		addi.l	#$1800,d0
		move.l	d0,obYVel(a6)
		add.l	d0,obY(a6)
		move.w	($FFFFF000).l,d0
		andi.w	#$C,d0
		add.w	d0,d0
		lea	word_E334(pc,d0.w),a0
		move.l	a0,obMap(a6)
		btst	#6,5(a6)
		beq.s	loc_E32C
		bclr	#7,5(a6)
		rts
; ---------------------------------------------------------------------------

loc_E32C:				; CODE XREF: ROM:0000E322j
		bset	#7,5(a6)
		rts
; ---------------------------------------------------------------------------
word_E334:	dc.w	$5F8
		dc.w	$25F0
		dc.w	$F8FF
		dc.w	$4E71
		dc.w	$5F8
		dc.w	$25F4
		dc.w	$F8FF
		dc.w	$4E71
		dc.w	$1F8
		dc.w	$25B4
		dc.w	$FCFF
		dc.w	$4E71
		dc.w	$5F8
		dc.w	$2DF4
		dc.w	$F8FF
; ---------------------------------------------------------------------------

locret_E352:				; CODE XREF: ROM:0000D250j
		rts
; ---------------------------------------------------------------------------

locret_E354:				; CODE XREF: ROM:0000D254j
		rts
; ---------------------------------------------------------------------------

