Obj_YelSpring_Up:				; CODE XREF: ROM:0000D260j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_DCAA
		move.l	#Map_SpringUp,obMap(a6)
		move.w	#$2407,obVRAM(a6)
		move.w	#$8080,4(a6)
		move.b	#$10,obWidth(a6)
		move.b	#8,obHeight(a6)
		move.w	#0,obFlags(a6)

loc_DCAA:				; CODE XREF: ROM:0000DC82j
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_DCF2
		move.w	obX(a6),d0
		move.w	obY(a6),d1
		move.w	obX(a0),d2
		move.w	obY(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#7,d4
		beq.s	loc_DCDC
		cmpi.w	#6,d4
		beq.s	loc_DCDC
		bra.s	loc_DCF2
; ---------------------------------------------------------------------------

loc_DCDC:				; CODE XREF: ROM:0000DCD2j
					; ROM:0000DCD8j
		ori.w	#1,obFlags(a6)
		move.l	#ARTUNC_Tails,d1 ; "\x0E윸0Eº̜x0E²ª\x0E¹2\x0E»I\x0E넮´»컬»\x0E˜x0Ẹ윦x01\x1E\x1E"...
		neg.l	d1
		moveq	#0,d0
		jsr	(SpeedToPos).l

loc_DCF2:				; CODE XREF: ROM:0000DCB8j
					; ROM:0000DCDAj
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_DD3A
		move.w	obX(a6),d0
		move.w	obY(a6),d1
		move.w	obX(a0),d2
		move.w	obY(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#7,d4
		beq.s	loc_DD24
		cmpi.w	#6,d4
		beq.s	loc_DD24
		bra.s	loc_DD3A
; ---------------------------------------------------------------------------

loc_DD24:				; CODE XREF: ROM:0000DD1Aj
					; ROM:0000DD20j
		ori.w	#1,obFlags(a6)
		move.l	#ARTUNC_Tails,d1 ; "\x0E윸0Eº̜x0E²ª\x0E¹2\x0E»I\x0E넮´»컬»\x0E˜x0Ẹ윦x01\x1E\x1E"...
		neg.l	d1
		moveq	#0,d0
		jsr	(SpeedToPos).l

loc_DD3A:				; CODE XREF: ROM:0000DD00j
					; ROM:0000DD22j
		move.w	obFlags(a6),d0
		btst	#0,d0
		beq.s	loc_DD60
		lea	(unk_4235E).l,a0
		lea	(word_E2A4).l,a1
		bsr.w	AnimateSprite
		cmpi.b	#$FF,d0
		bne.s	loc_DD60
		andi.w	#$FFFE,obFlags(a6)

loc_DD60:				; CODE XREF: ROM:0000DD42j
					; ROM:0000DD58j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_DD6A
		bsr.w	DeleteSprite

locret_DD6A:				; CODE XREF: ROM:0000DD64j
		rts
; ---------------------------------------------------------------------------