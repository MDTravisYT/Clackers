Obj_Rings:				; CODE XREF: ROM:0000D280j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	RingsRout5
		move.l	#Map_Rings,obMap(a6)
		move.w	#$0000,obVRAM(a6)
		move.w	#$8080,4(a6)
		move.b	#$8,obWidth(a6)
		move.b	#$8,obHeight(a6)

RingsRout5:			
		bsr.w	SpriteScreenCheck
		bcc.s	RingsRout6
		bsr.w	DeleteSprite

RingsRout6:				; CODE XREF: ROM:0000E6EEj
		rts
; ---------------------------------------------------------------------------
