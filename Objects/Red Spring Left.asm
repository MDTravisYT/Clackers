Obj_RedSpring_Left:				; CODE XREF: ROM:0000D228j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_D3C2
		move.l	#Map_SpringLR,$10(a6)
		move.w	#$C07,$20(a6)
		move.w	#$8080,4(a6)
		move.b	#8,$22(a6)
		move.b	#$10,$23(a6)
		move.w	#0,$2A(a6)

loc_D3C2:				; CODE XREF: ROM:0000D39Aj
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_D40A
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#1,d4
		beq.s	loc_D3F4
		cmpi.w	#3,d4
		beq.s	loc_D3F4
		bra.s	loc_D40A
; ---------------------------------------------------------------------------

loc_D3F4:				; CODE XREF: ROM:0000D3EAj
					; ROM:0000D3F0j
		move.b	#$A8,d0
		jsr		Play_Sound
		ori.w	#1,$2A(a6)
		move.l	#$F0000,d0
		neg.l	d0
		moveq	#0,d1
		jsr	(loc_CB1C).l

loc_D40A:				; CODE XREF: ROM:0000D3D0j
					; ROM:0000D3F2j
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_D452
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#1,d4
		beq.s	loc_D43C
		cmpi.w	#3,d4
		beq.s	loc_D43C
		bra.s	loc_D452
; ---------------------------------------------------------------------------

loc_D43C:				; CODE XREF: ROM:0000D432j
					; ROM:0000D438j
		ori.w	#1,$2A(a6)
		move.l	#$F0000,d0
		neg.l	d0
		moveq	#0,d1
		jsr	(loc_CB1C).l

loc_D452:				; CODE XREF: ROM:0000D418j
					; ROM:0000D43Aj
		move.w	$2A(a6),d0
		btst	#0,d0
		beq.s	loc_D478
		lea	(unk_42358).l,a0
		lea	(Ani_SpringLR).l,a1
		bsr.w	AnimateSprite
		cmpi.w	#$FF,d0
		bne.s	loc_D478
		andi.w	#$FFFE,$2A(a6)

loc_D478:
		bsr.w	SpriteScreenCheck
		bcc.s	locret_D482
		bsr.w	DeleteObject

locret_D482:
		rts
; ---------------------------------------------------------------------------
