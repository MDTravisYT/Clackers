Obj_Rings:				; CODE XREF: ROM:0000D280j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	RingsRout5
		move.l	#Map_Monitor,obMap(a6)
		move.w	#$458,obVRAM(a6)
		move.w	#$8080,4(a6)
		move.b	#$10,obWidth(a6)
		move.b	#$10,obHeight(a6)

RingsRout5:			
		bsr.w	SpriteScreenCheck
		bcc.s	RingsRout6
		bsr.w	DeleteSprite

RingsRout6:				; CODE XREF: ROM:0000E6EEj
		rts
; ---------------------------------------------------------------------------
