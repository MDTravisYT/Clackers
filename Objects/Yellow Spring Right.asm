Obj_YelSpring_Right:				; CODE XREF: ROM:0000D258j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_DACE
		move.l	#Map_SpringLR,obMap(a6)
		move.w	#$2407,obVRAM(a6)
		move.w	#$8080,4(a6)
		move.b	#8,obWidth(a6)
		move.b	#$10,obHeight(a6)
		move.w	#0,obFlags(a6)

loc_DACE:				; CODE XREF: ROM:0000DAA6j
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_DB14
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#0,d4
		beq.s	loc_DB00
		cmpi.w	#2,d4
		beq.s	loc_DB00
		bra.s	loc_DB14
; ---------------------------------------------------------------------------

loc_DB00:				; CODE XREF: ROM:0000DAF6j
					; ROM:0000DAFCj
		ori.w	#1,obFlags(a6)
		move.l	#ARTUNC_Tails,d0 ; "\x0E윸0Eº̜x0E²ª\x0E¹2\x0E»I\x0E넮´»컬»\x0E˜x0Ẹ윦x01\x1E\x1E"...
		moveq	#0,d1
		jsr	(SpeedToPos).l

loc_DB14:				; CODE XREF: ROM:0000DADCj
					; ROM:0000DAFEj
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_DB5A
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#0,d4
		beq.s	loc_DB46
		cmpi.w	#2,d4
		beq.s	loc_DB46
		bra.s	loc_DB5A
; ---------------------------------------------------------------------------

loc_DB46:				; CODE XREF: ROM:0000DB3Cj
					; ROM:0000DB42j
		ori.w	#1,obFlags(a6)
		move.l	#ARTUNC_Tails,d0 ; "\x0E윸0Eº̜x0E²ª\x0E¹2\x0E»I\x0E넮´»컬»\x0E˜x0Ẹ윦x01\x1E\x1E"...
		moveq	#0,d1
		jsr	(SpeedToPos).l

loc_DB5A:				; CODE XREF: ROM:0000DB22j
					; ROM:0000DB44j
		move.w	obFlags(a6),d0
		btst	#0,d0
		beq.s	loc_DB80
		lea	(unk_42358).l,a0
		lea	(Ani_SpringLR).l,a1
		bsr.w	AnimateSprite
		cmpi.b	#$FF,d0
		bne.s	loc_DB80
		andi.w	#$FFFE,obFlags(a6)

loc_DB80:				; CODE XREF: ROM:0000DB62j
					; ROM:0000DB78j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_DB8A
		bsr.w	DeleteSprite

locret_DB8A:				; CODE XREF: ROM:0000DB84j
		rts