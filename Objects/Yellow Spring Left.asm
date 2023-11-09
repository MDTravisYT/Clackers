; ---------------------------------------------------------------------------
; Object coding for Spring

Obj_YelSpring_Left:
		moveq	#7,d0					; prepare bits 0000 0111
		bclr	d0,$28(a6)				; clear those bits
		beq.s	loc_DBBA				; if any of those were set, branch
		move.l	#Map_SpringLR,$10(a6)			; mappings to load for object
		move.w	#$2C07,$20(a6)				; set ????
		move.w	#$8080,4(a6)				; ??
		move.b	#8,$22(a6)
		move.b	#$10,$23(a6)
		move.w	#0,$2A(a6)

loc_DBBA:				; CODE XREF: ROM:0000DB92j
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_DC02
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#1,d4
		beq.s	loc_DBEC
		cmpi.w	#3,d4
		beq.s	loc_DBEC
		bra.s	loc_DC02
; ---------------------------------------------------------------------------

loc_DBEC:				; CODE XREF: ROM:0000DBE2j
					; ROM:0000DBE8j
		ori.w	#1,$2A(a6)
		move.l	#ARTUNC_Tails,d0 ; "\x0E윸0Eº̜x0E²ª\x0E¹2\x0E»I\x0E넮´»컬»\x0E˜x0Ẹ윦x01\x1E\x1E"...
		neg.l	d0
		moveq	#0,d1
		jsr	(SpeedToPos).l

loc_DC02:				; CODE XREF: ROM:0000DBC8j
					; ROM:0000DBEAj
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_DC4A
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#1,d4
		beq.s	loc_DC34
		cmpi.w	#3,d4
		beq.s	loc_DC34
		bra.s	loc_DC4A
; ---------------------------------------------------------------------------

loc_DC34:				; CODE XREF: ROM:0000DC2Aj
					; ROM:0000DC30j
		ori.w	#1,$2A(a6)
		move.l	#ARTUNC_Tails,d0 ; "\x0E윸0Eº̜x0E²ª\x0E¹2\x0E»I\x0E넮´»컬»\x0E˜x0Ẹ윦x01\x1E\x1E"...
		neg.l	d0
		moveq	#0,d1
		jsr	(SpeedToPos).l

loc_DC4A:				; CODE XREF: ROM:0000DC10j
					; ROM:0000DC32j
		move.w	$2A(a6),d0
		btst	#0,d0
		beq.s	loc_DC70
		lea	(unk_42358).l,a0
		lea	(Ani_SpringLR).l,a1
		bsr.w	AnimateSprite
		cmpi.w	#$FF,d0
		bne.s	loc_DC70
		andi.w	#$FFFE,$2A(a6)

loc_DC70:				; CODE XREF: ROM:0000DC52j
					; ROM:0000DC68j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_DC7A
		bsr.w	DeleteObject

locret_DC7A:				; CODE XREF: ROM:0000DC74j
		rts
; ---------------------------------------------------------------------------