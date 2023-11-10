Obj_YelSpring_Down:				; CODE XREF: ROM:0000D264j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_DD9A
		move.l	#Map_SpringUp,obMap(a6)
		move.w	#$3407,obVRAM(a6)
		move.w	#$8080,4(a6)
		move.b	#$10,obWidth(a6)
		move.b	#8,obHeight(a6)
		move.w	#0,obFlags(a6)

loc_DD9A:				; CODE XREF: ROM:0000DD72j
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_DDE0
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#4,d4
		beq.s	loc_DDCC
		cmpi.w	#5,d4
		beq.s	loc_DDCC
		bra.s	loc_DDE0
; ---------------------------------------------------------------------------

loc_DDCC:				; CODE XREF: ROM:0000DDC2j
					; ROM:0000DDC8j
		ori.w	#1,obFlags(a6)
		move.l	#ARTUNC_Tails,d1 ; "\x0E윸0Eº̜x0E²ª\x0E¹2\x0E»I\x0E넮´»컬»\x0E˜x0Ẹ윦x01\x1E\x1E"...
		moveq	#0,d0
		jsr	(SpeedToPos).l

loc_DDE0:				; CODE XREF: ROM:0000DDA8j
					; ROM:0000DDCAj
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_DE26
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#5,d4
		beq.s	loc_DE12
		cmpi.w	#4,d4
		beq.s	loc_DE12
		bra.s	loc_DE26
; ---------------------------------------------------------------------------

loc_DE12:				; CODE XREF: ROM:0000DE08j
					; ROM:0000DE0Ej
		ori.w	#1,obFlags(a6)
		move.l	#ARTUNC_Tails,d1 ; "\x0E윸0Eº̜x0E²ª\x0E¹2\x0E»I\x0E넮´»컬»\x0E˜x0Ẹ윦x01\x1E\x1E"...
		moveq	#0,d0
		jsr	(SpeedToPos).l

loc_DE26:				; CODE XREF: ROM:0000DDEEj
					; ROM:0000DE10j
		move.w	obFlags(a6),d0
		btst	#0,d0
		beq.s	loc_DE4C
		lea	(unk_4235E).l,a0
		lea	(word_E2A4).l,a1
		bsr.w	AnimateSprite
		cmpi.b	#$FF,d0
		bne.s	loc_DE4C
		andi.w	#$FFFE,obFlags(a6)

loc_DE4C:				; CODE XREF: ROM:0000DE2Ej
					; ROM:0000DE44j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_DE56
		bsr.w	DeleteSprite

locret_DE56:				; CODE XREF: ROM:0000DE50j
		rts
; ---------------------------------------------------------------------------