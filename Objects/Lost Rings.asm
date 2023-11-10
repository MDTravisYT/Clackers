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

loc_E356:				; CODE XREF: ROM:0000D298j
		tst.b	$28(a6)
		bne.s	loc_E37C
		move.w	#0,4(a6)
		move.w	#$2020,obWidth(a6)
		move.l	#$E376,obMap(a6)
		addq.b	#1,$28(a6)
		bra.s	loc_E37C
; ---------------------------------------------------------------------------
		dc.w	$FF0
		dc.w	$8001
		dc.w	$F0FF
; ---------------------------------------------------------------------------

loc_E37C:				; CODE XREF: ROM:0000E35Aj
					; ROM:0000E374j
		jsr	SpriteScreenCheck
		bcc.s	loc_E38A
		jmp	DeleteSprite
; ---------------------------------------------------------------------------

loc_E38A:				; CODE XREF: ROM:0000E382j
		movea.w	($FFFFD862).w,a0
		jsr	sub_EAA0
		bcc.s	loc_E398
		bsr.s	sub_E3A8

loc_E398:				; CODE XREF: ROM:0000E394j
		movea.w	($FFFFD864).w,a0
		jsr	sub_EAA0
		bcc.s	locret_E3A6
		bsr.s	sub_E3A8

locret_E3A6:				; CODE XREF: ROM:0000E3A2j
		rts

; =============== S U B	R O U T	I N E =======================================


sub_E3A8:				; CODE XREF: ROM:0000E396p
					; ROM:0000E3A4p
		move.w	obX(a0),d0
		sub.w	obX(a6),d0
		move.w	obY(a0),d1
		sub.w	obY(a6),d1
		moveq	#0,d2
		move.b	$29(a6),d2
		jmp	loc_E3DE(pc,d2.w)
; End of function sub_E3A8

; ---------------------------------------------------------------------------

loc_E3C2:				; CODE XREF: ROM:0000E400j
					; ROM:0000E410j ...
		bclr	#7,$25(a0)

loc_E3C8:				; CODE XREF: ROM:0000E3E0j
					; ROM:0000E3EAj ...
		bclr	#1,$25(a0)
		rts
; ---------------------------------------------------------------------------

loc_E3D0:				; CODE XREF: ROM:0000E408j
					; ROM:0000E418j ...
		bclr	#7,$25(a0)

loc_E3D6:				; CODE XREF: ROM:0000E3E2j
					; ROM:0000E3E8j ...
		bset	#1,$25(a0)
		rts
; ---------------------------------------------------------------------------

loc_E3DE:
		tst.w	d0
		bpl.s	loc_E3C8
		bra.s	loc_E3D6
; ---------------------------------------------------------------------------
		nop
		tst.w	d0
		bpl.s	loc_E3D6
		bra.s	loc_E3C8
; ---------------------------------------------------------------------------
		nop
		tst.w	d1
		bpl.s	loc_E3C8
		bra.s	loc_E3D6
; ---------------------------------------------------------------------------
		nop
		tst.w	d1
		bpl.s	loc_E3D6
		bra.s	loc_E3C8
; ---------------------------------------------------------------------------
		nop
		tst.w	d0
		bpl.s	loc_E3C2
		bra.s	loc_E44C
; ---------------------------------------------------------------------------
		nop
		tst.w	d0
		bpl.s	loc_E3D0
		bra.s	loc_E43E
; ---------------------------------------------------------------------------
		nop
		tst.w	d1
		bpl.s	loc_E3C2
		bra.s	loc_E44C
; ---------------------------------------------------------------------------
		nop
		tst.w	d1
		bpl.s	loc_E3D0
		bra.s	loc_E43E
; ---------------------------------------------------------------------------
		nop
		tst.w	d0
		bpl.s	loc_E43E
		bra.s	loc_E3D0
; ---------------------------------------------------------------------------
		nop
		tst.w	d0
		bpl.s	loc_E44C
		bra.s	loc_E3C2
; ---------------------------------------------------------------------------
		nop
		tst.w	d1
		bpl.s	loc_E43E
		bra.s	loc_E3D0
; ---------------------------------------------------------------------------
		nop
		tst.w	d1
		bpl.s	loc_E44C
		bra.s	loc_E3C2
; ---------------------------------------------------------------------------
		nop

loc_E43E:				; CODE XREF: ROM:0000E40Aj
					; ROM:0000E41Aj ...
		bset	#7,$25(a0)
		bclr	#1,$25(a0)
		rts
; ---------------------------------------------------------------------------

loc_E44C:				; CODE XREF: ROM:0000E402j
					; ROM:0000E412j ...
		bset	#7,$25(a0)
		bset	#1,$25(a0)
		rts
; ---------------------------------------------------------------------------

loc_E45A:				; CODE XREF: ROM:0000D29Cj
		tst.b	$28(a6)
		bne.s	loc_E480
		move.w	#0,4(a6)
		move.w	#$2020,obWidth(a6)
		move.l	#$E47A,obMap(a6)
		addq.b	#1,$28(a6)
		bra.s	loc_E480
; ---------------------------------------------------------------------------
		dc.w	$FF0
		dc.w	$8001
		dc.w	$F0FF
; ---------------------------------------------------------------------------

loc_E480:				; CODE XREF: ROM:0000E45Ej
					; ROM:0000E478j
		jsr	SpriteScreenCheck
		bcc.s	loc_E48E
		jmp	DeleteSprite
; ---------------------------------------------------------------------------

loc_E48E:				; CODE XREF: ROM:0000E486j
		movea.w	($FFFFD862).w,a0
		jsr	sub_EAA0
		bcc.s	loc_E49C
		bsr.s	sub_E4AC

loc_E49C:				; CODE XREF: ROM:0000E498j
		movea.w	($FFFFD864).w,a0
		jsr	sub_EAA0
		bcc.s	locret_E4AA
		bsr.s	sub_E4AC

locret_E4AA:				; CODE XREF: ROM:0000E4A6j
		rts

; =============== S U B	R O U T	I N E =======================================


sub_E4AC:				; CODE XREF: ROM:0000E49Ap
					; ROM:0000E4A8p
		moveq	#0,d0
		move.b	$29(a6),d0
		jmp	loc_E4B6(pc,d0.w)
; End of function sub_E4AC

; ---------------------------------------------------------------------------

loc_E4B6:
		bra.s	loc_E4C8
; ---------------------------------------------------------------------------
		bra.s	loc_E4D6
; ---------------------------------------------------------------------------
		bra.s	loc_E4C2
; ---------------------------------------------------------------------------
		bra.s	loc_E4D0
; ---------------------------------------------------------------------------
		bra.s	loc_E4DE
; ---------------------------------------------------------------------------
		bra.s	loc_E4EC
; ---------------------------------------------------------------------------

loc_E4C2:				; CODE XREF: ROM:0000E4BAj
		bclr	#7,$25(a0)

loc_E4C8:				; CODE XREF: ROM:loc_E4B6j
		bclr	#1,$25(a0)
		rts
; ---------------------------------------------------------------------------

loc_E4D0:				; CODE XREF: ROM:0000E4BCj
		bclr	#7,$25(a0)

loc_E4D6:				; CODE XREF: ROM:0000E4B8j
		bset	#1,$25(a0)
		rts
; ---------------------------------------------------------------------------

loc_E4DE:				; CODE XREF: ROM:0000E4BEj
		bset	#7,$25(a0)
		bclr	#1,$25(a0)
		rts
; ---------------------------------------------------------------------------

loc_E4EC:				; CODE XREF: ROM:0000E4C0j
		bset	#7,$25(a0)
		bset	#1,$25(a0)
		rts
; ---------------------------------------------------------------------------

locret_E4FA:				; CODE XREF: ROM:0000D2A0j
		rts
; ---------------------------------------------------------------------------

locret_E4FC:				; CODE XREF: ROM:0000D2A4j
		rts
; ---------------------------------------------------------------------------