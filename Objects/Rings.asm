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
		movea.w	($FFFFD862).w,a0					;	load Sonic's object RAM to a0
		move.w	obFlags(a6),d0                      ; load flags to d0
		move.w	#$F,d0
	;	jsr	(SolidObject).l
		beq.s	RingsRout5
		move.w	obX(a0),d0						;	load character's X position to d0
		move.w	obY(a0),d1						;	load character's Y position to d1
		move.w	obX(a6),d2						;	load object's X position to d2...
		move.w	obX(a6),d3						;	...and d3
		move.w	obY(a6),d4						;	load object's Y position to d4...
		move.w	obY(a6),d5						;	...and d5
		sub.b	#15,	d3	;	X	LEFT
		add.b	#15,	d2	;	X	RIGHT
		sub.b	#15,	d5	;	Y	TOP
		add.b	#15,	d4	;	Y	BOTTOM		
		
		cmp.w	d0,	d3	;	compare player X to left of obj
		blo.s	@chkRight
		bra.s	RingsRout5

	@chkRight:
		cmp.w	d0,	d2	;	compare player X to right of obj
		bhi.s	@chkUp
		bra.s	RingsRout5
	
	@chkUp:
		cmp.w	d1,	d5	;	compare player Y to top of obj
		blo.s	@chkDown
		bhi.s	RingsRout5
		
	@chkDown:
		cmp.w	d1,	d4	;	compare player Y to bottom of obj
		blo.s	RingsRout5
		
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
