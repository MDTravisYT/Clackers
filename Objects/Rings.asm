Obj_Rings:				; CODE XREF: ROM:0000D280j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	RingsRout1
		move.l	#Map_Rings,obMap(a6)
		move.w	#$0000,obVRAM(a6)
		move.w	#$8080,4(a6)
		move.b	#$8,obWidth(a6)
		move.b	#$8,obHeight(a6)

RingsRout1:		
		movea.w	($FFFFD862).w,a0
		move.w	obFlags(a6),d0                      ; load flags to d0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	RingsRout5
		move.w	obX(a6),d0
		move.w	obY(a6),d1
		move.w	obX(a0),d2
		move.w	obY(a0),d3
		move.l	#Map_Rings,obMap(a6)
		bsr.w	Distance_GetSet
		cmpi.w	#$8,d4
		blo.s	RingsRout2
		bra.s	RingsRout5
		
RingsRout2:	
		move.b	#$A6,d0
		jsr		Play_Sound_2
		add.b	#1,$FFFFA000
		jsr	(DeleteObject).l
		rts
	
RingsRout5:			
		lea	(Def_Rings).l,a0
		lea	(Ani_Rings).l,a1			; load spring's Animation script
		bsr.w	AnimateSprite				; animate the spring
		bsr.w	SpriteScreenCheck
		bcc.s	RingsRout6
		bsr.w	DeleteSprite

RingsRout6:				; CODE XREF: ROM:0000E6EEj
		rts
; ---------------------------------------------------------------------------
