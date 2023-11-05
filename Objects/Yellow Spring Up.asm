Obj_YelSpring_Up:				; CODE XREF: ROM:0000D260j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_DCAA
		move.l	#Map_SpringUp,$10(a6)
		move.w	#$2407,$20(a6)
		move.w	#$8080,4(a6)
		move.b	#$10,$22(a6)
		move.b	#8,$23(a6)
		move.w	#0,$2A(a6)

loc_DCAA:				; CODE XREF: ROM:0000DC82j
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_DCF2
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#7,d4
		beq.s	loc_DCDC
		cmpi.w	#6,d4
		beq.s	loc_DCDC
		bra.s	loc_DCF2
; ---------------------------------------------------------------------------

loc_DCDC:				; CODE XREF: ROM:0000DCD2j
					; ROM:0000DCD8j
		ori.w	#1,$2A(a6)
		move.l	#ARTUNC_Tails,d1 ; "\x0E윸0Eº̜x0E²ª\x0E¹2\x0E»I\x0E넮´»컬»\x0E˜x0Ẹ윦x01\x1E\x1E"...
		neg.l	d1
		moveq	#0,d0
		jsr	(loc_CB1C).l

loc_DCF2:				; CODE XREF: ROM:0000DCB8j
					; ROM:0000DCDAj
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_DD3A
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#7,d4
		beq.s	loc_DD24
		cmpi.w	#6,d4
		beq.s	loc_DD24
		bra.s	loc_DD3A
; ---------------------------------------------------------------------------

loc_DD24:				; CODE XREF: ROM:0000DD1Aj
					; ROM:0000DD20j
		ori.w	#1,$2A(a6)
		move.l	#ARTUNC_Tails,d1 ; "\x0E윸0Eº̜x0E²ª\x0E¹2\x0E»I\x0E넮´»컬»\x0E˜x0Ẹ윦x01\x1E\x1E"...
		neg.l	d1
		moveq	#0,d0
		jsr	(loc_CB1C).l

loc_DD3A:				; CODE XREF: ROM:0000DD00j
					; ROM:0000DD22j
		move.w	$2A(a6),d0
		btst	#0,d0
		beq.s	loc_DD60
		lea	(unk_4235E).l,a0
		lea	(word_E2A4).l,a1
		bsr.w	AnimateSprite
		cmpi.b	#$FF,d0
		bne.s	loc_DD60
		andi.w	#$FFFE,$2A(a6)

loc_DD60:				; CODE XREF: ROM:0000DD42j
					; ROM:0000DD58j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_DD6A
		bsr.w	DeleteObject

locret_DD6A:				; CODE XREF: ROM:0000DD64j
		rts
; ---------------------------------------------------------------------------