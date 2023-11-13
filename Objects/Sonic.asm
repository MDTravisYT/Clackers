SonicMain:				; DATA XREF: ROM:off_A1CEo
		move.w	#$C10,obWidth(a6)
		moveq	#0,d0
		move.b	7(a6),d0
		pea	loc_C746(pc)
                move.w  SonicIndex(pc,d0.w),d0
                jmp     SonicIndex(pc,d0.w)
; ---------------------------------------------------------------------------

SonicIndex:                           ; DATA XREF: ROM:0000A27E↑o
                                        ; ROM:0000A284↓o ...
                rts
; ---------------------------------------------------------------------------
                dc.w loc_A296-SonicIndex
                dc.w loc_A588-SonicIndex
                dc.w loc_A66E-SonicIndex
                dc.w loc_A67C-SonicIndex
                dc.w loc_A72E-SonicIndex
                dc.w locret_A992-SonicIndex
                dc.w ObjSonic_Spindash-SonicIndex
                dc.w loc_A9C8-SonicIndex
                dc.w loc_AA46-SonicIndex
; ---------------------------------------------------------------------------

loc_A296:                               ; DATA XREF: ROM:0000A284↑o
		pea	loc_A506(pc)
		bset	#0,$25(a6)
		bclr	#4,$25(a6)
		clr.l	obXVel(a6)
		clr.l	obYVel(a6)
		cmpi.w	#$1A,obAnim(a6)
		beq.w	loc_A4B4
		tst.b	(a5)
		bpl.s	loc_A2CC
		move.b	($FFFFC93C).w,d0	; Sonic's holding a b c
		andi.b	#$50,d0	; 'p'
		beq.s	loc_A2CC
		clr.w	$2C(a6)
		bra.s	loc_A2D4
; ---------------------------------------------------------------------------

loc_A2CC:				; CODE XREF: ROM:0000A2BAj
					; ROM:0000A2C4j
		move.w	obX(a5),d0
		bne.w	loc_A3D2

loc_A2D4:				; CODE XREF: ROM:0000A2CAj
		move.w	#$FFF0,d0
		move.w	$2C(a6),d1
		beq.s	loc_A2F0
		bpl.s	loc_A2E4
		neg.w	d0
		neg.w	d1

loc_A2E4:				; CODE XREF: ROM:0000A2DEj
		move.w	#$30,obAnim(a6)	 
		cmpi.w	#$C,d1
		bcc.w	loc_A42E
		clr.w	$2C(a6)

loc_A2F0:				; CODE XREF: ROM:0000A2DCj
		btst	#3,$25(a6)
		sne	d0
		andi.b	#8,d0
		move.b	d0,obVRAM(a6)
		move.b	#$A,($FFFFFAE8).w
		move.b	obFlags(a6),d0
		addi.b	#$10,d0
		cmpi.b	#$20,d0	; ' '
		bcc.s	loc_A38A
		move.w	obX(a6),d0
		moveq	#0,d1
		move.b	obHeight(a6),d1
		add.w	obY(a6),d1
		move.w	$24(a6),d4
		andi.w	#2,d4
		bsr.w	sub_BF84
		cmpi.w	#$FF80,d5
		bne.s	loc_A38A
		btst	#3,$25(a6)
		bne.s	loc_A356
		move.b	#8,obVRAM(a6)
		moveq	#0,d3
		move.b	obWidth(a6),d3
		add.w	d3,d0
		bsr.w	sub_BF84
		cmpi.w	#$FF80,d5
		bne.s	loc_A37C
		bra.s	loc_A36E
; ---------------------------------------------------------------------------

loc_A356:				; CODE XREF: ROM:0000A33Aj
		move.b	#0,obVRAM(a6)
		moveq	#0,d3
		move.b	obWidth(a6),d3
		sub.w	d3,d0
		bsr.w	sub_BF84
		cmpi.w	#$FF80,d5
		bne.s	loc_A37C

loc_A36E:				; CODE XREF: ROM:0000A354j
		move.w	#$18,obAnim(a6)
		andi.b	#3,obFrame(a6)
		rts
; ---------------------------------------------------------------------------

loc_A37C:				; CODE XREF: ROM:0000A352j
					; ROM:0000A36Cj
		move.w	#$16,obAnim(a6)
		andi.b	#3,obFrame(a6)
		rts
; ---------------------------------------------------------------------------

loc_A38A:				; CODE XREF: ROM:0000A312j
					; ROM:0000A332j
		move.w	$A(a5),d0
		beq.s	loc_A3A6
		move.l	#$100,obAnim(a6)
		tst.w	d0
		bmi.s	locret_A3A4
		move.l	#$200,obAnim(a6)

locret_A3A4:				; CODE XREF: ROM:0000A39Aj
		rts
; ---------------------------------------------------------------------------

loc_A3A6:				; CODE XREF: ROM:0000A38Ej
		cmpi.w	#$14,obAnim(a6)
		beq.s	locret_A3D0
		tst.w	obAnim(a6)
		beq.s	loc_A3B8
		clr.w	obFrame(a6)

loc_A3B8:				; CODE XREF: ROM:0000A3B2j
		move.w	#0,obAnim(a6)
		tst.b	$29(a6)
		bpl.s	loc_A3CA
		move.w	#$14,obAnim(a6)

loc_A3CA:				; CODE XREF: ROM:0000A3C2j
		move.b	#0,obFrame(a6)

locret_A3D0:				; CODE XREF: ROM:0000A3ACj
		rts
; ---------------------------------------------------------------------------

loc_A3D2:				; CODE XREF: ROM:0000A2D0j
		move.b	3(a5),d1
		andi.b	#$C,d1
		beq.s	loc_A3E0
		clr.w	obFrame(a6)

loc_A3E0:				; CODE XREF: ROM:0000A3DAj
		move.w	$24(a6),d1
		eor.w	d0,d1
		move.w	$2C(a6),d2
		ext.l	d2
		swap	d2
		eor.w	d2,d1
		andi.w	#8,d1
		beq.s	loc_A42A
		move.w	$2C(a6),d0
		bpl.s	loc_A412
		neg.w	d0

loc_A412:				; CODE XREF: ROM:0000A40Ej
		cmpi.w	#$80,d0	; ''
		bcc.s	loc_A420
		eor.w	d1,$24(a6)
		moveq	#0,d0
		bra.s	loc_A432
; ---------------------------------------------------------------------------

loc_A420:				; CODE XREF: ROM:0000A416j
		move.l	#$1A0000,obAnim(a6)
		rts
; ---------------------------------------------------------------------------

loc_A42A:				; CODE XREF: ROM:0000A402j
		move.w	#$10,d0

loc_A42E:				; CODE XREF: ROM:0000A2E8j
		add.w	$2C(a6),d0

loc_A432:				; CODE XREF: ROM:0000A41Ej
		move.w	d0,$2C(a6)
		bpl.s	loc_A43A
		neg.w	d0

loc_A43A:				; CODE XREF: ROM:0000A436j
		cmpi.w	#$400,d0
		bcs.s	loc_A44A
		moveq	#$A,d2
		andi.w	#$1FF,obFrame(a6)
		bra.s	loc_A45A
; ---------------------------------------------------------------------------

loc_A44A:				; CODE XREF: ROM:0000A43Ej
		lsr.w	#4,d0
		cmpi.w	#$10,d0
		bcc.s	loc_A454
		moveq	#$10,d0

loc_A454:				; CODE XREF: ROM:0000A450j
		add.w	d0,obFrame(a6)
		moveq	#2,d2

loc_A45A:				; CODE XREF: ROM:0000A448j
		move.b	obFlags(a6),d0
		btst	#3,$25(a6)
		bne.s	loc_A488
		subi.b	#$10,d0
		neg.b	d0
		lsr.w	#4,d0
		btst	#3,d0
		sne	d1
		andi.w	#6,d0
		add.w	d2,d0
		move.w	d0,obAnim(a6)	;	handles sonic's movement animation when going right
		andi.b	#$18,d1
		move.b	d1,obVRAM(a6)
		rts
; ---------------------------------------------------------------------------

loc_A488:				; CODE XREF: ROM:0000A464j
		subi.b	#$80,d0
		neg.b	d0
		subi.b	#$10,d0
		neg.b	d0
		lsr.w	#4,d0
		btst	#3,d0
		sne	d1
		andi.w	#6,d0
		add.w	d2,d0
		move.w	d0,obAnim(a6)	;	handles sonic's movement animation when going left
		andi.b	#$18,d1
		eori.b	#$10,d1
		move.b	d1,obVRAM(a6)
		rts
; ---------------------------------------------------------------------------

loc_A4B4:				; CODE XREF: ROM:0000A2B4j
		btst	#3,$25(a6)
		sne	d0
		not.b	d0
		andi.b	#8,d0
		move.b	d0,obVRAM(a6)
		move.w	#$FF80,d0
		move.w	$2C(a6),d1
		beq.s	loc_A4E0
		bpl.s	loc_A4D6
		neg.w	d0
		neg.w	d1

loc_A4D6:				; CODE XREF: ROM:0000A4D0j
		cmpi.w	#$80,d1	; ''
		bcc.s	loc_A4F0
		clr.w	$2C(a6)

loc_A4E0:				; CODE XREF: ROM:0000A4CEj
		move.l	#0,obAnim(a6)
		eori.b	#8,$25(a6)
		rts
; ---------------------------------------------------------------------------

loc_A4F0:				; CODE XREF: ROM:0000A4DAj
		add.w	$2C(a6),d0
		move.w	d0,$2C(a6)
		move.w	#$1A,obAnim(a6)
		andi.b	#3,obFrame(a6)
		move.b	#$A4,d0
		bsr.w	Play_Sound_2
		rts
; ---------------------------------------------------------------------------

loc_A506:				; DATA XREF: ROM:0000A296o
		cmpi.l	#$200,obAnim(a6)
		beq.s	loc_A51E
		bsr.w	ObjSonic_Roll
	;	tst.b	(a5)
	;	bmi.s	loc_A530
		bsr.w	ObjSonic_SummonPartner
		bsr.w	ObjSonic_ThrowPartner
		bsr.w	ObjSonic_Jump
		bra.s	loc_A530
; ---------------------------------------------------------------------------

loc_A51E:				; CODE XREF: ROM:0000A50Ej
		move.b	3(a5),d0
		andi.b	#$70,d0	; 'p'
		beq.s	loc_A530
		move.b	#$E,7(a6)
		rts
; ---------------------------------------------------------------------------

ObjSonic_Roll:
		cmpi.w	#$180,$2C(a6)
		blo.s	.rts
		move.b	$FFFFC93C,d0
		andi.b	#$02,d0	; 'p'
		beq.s	.rts
		move.w	#$12,obAnim(a6)
	.rts:
		rts

ObjSonic_SummonPartner:
		move.b	$FFFFC93D,d0
		andi.b	#$40,d0	; 'p'
		beq.s	SonicSummon_Return
		
		movea.w	($FFFFD862).w,a0			; load Sonic's ram address to a0
		movea.w	($FFFFD864).w,a1			; load Tails's ram address to a1
		move.w	obX(a0),d0				; load Sonic's X position to d0
		move.w	obY(a0),d1				; load Sonic's Y position to d1
		move.w	obX(a1),d2				; load Tails's X position to d2
		move.w	obY(a1),d3				; load Tails's Y position to d3
		move.w	d0,obX(a1)				; save to Tails's X position
		move.w	d1,obY(a1)				; save to Tails's Y position
		
		
SonicSummon_Return:
		rts

loc_A530:				; CODE XREF: ROM:0000A512j
					; ROM:0000A51Cj ...
		bsr.w	nullsub_2
		bsr.w	sub_CBC0
		jsr	sub_C49A
		jsr	sub_C29E
		beq.s	loc_A550
		move.w	d0,($FFFFFAC0).w
		move.w	d1,($FFFFFAC2).w
		rts
; ---------------------------------------------------------------------------

loc_A550:				; CODE XREF: ROM:0000A544j
		bclr	#0,$25(a6)
		move.b	#8,7(a6)
		move.b	obFlags(a6),d2
		btst	#3,$25(a6)
		beq.s	loc_A56C
		addi.b	#-$80,d2

loc_A56C:				; CODE XREF: ROM:0000A566j
		jsr	CalcSine
		move.w	$2C(a6),d2
		muls.w	d2,d0
		muls.w	d2,d1
		asr.l	#6,d0
		asr.l	#6,d1
		move.l	d0,obXVel(a6)
		move.l	d1,obYVel(a6)
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------
loc_A588:  
		btst	#0,$25(a6)
		bne.w	loc_A63E
		pea	loc_A61A(pc)
		addi.l	#$3800,obYVel(a6)
		bclr	#0,$25(a6)
		bset	#4,$25(a6)
		move.w	#$12,obAnim(a6)
		clr.b	obFlags(a6)
		clr.w	$2C(a6)
		move.w	obX(a5),d0
		bne.s	loc_A5E4
		move.l	obXVel(a6),d0
		move.l	d0,d1
		bpl.s	loc_A5C8
		neg.l	d1

loc_A5C8:				; CODE XREF: ROM:0000A5C4j
		andi.l	#$FFFFF800,d1
		bne.s	loc_A5D6
		clr.l	obXVel(a6)
		bra.s	loc_A5FC
; ---------------------------------------------------------------------------

loc_A5D6:				; CODE XREF: ROM:0000A5CEj
		swap	d0
		ext.l	d0
		swap	d0
		ori.w	#1,d0
		neg.w	d0
		bra.s	loc_A5F2
; ---------------------------------------------------------------------------

loc_A5E4:				; CODE XREF: ROM:0000A5BCj
		move.w	$24(a6),d1
		eor.w	d0,d1
		andi.w	#8,d1
		eor.w	d1,$24(a6)

loc_A5F2:				; CODE XREF: ROM:0000A5E2j
		swap	d0
		sub.w	d0,d0
		asr.l	#4,d0
		add.l	d0,obXVel(a6)

loc_A5FC:				; CODE XREF: ROM:0000A5D4j
		move.b	2(a5),d0
		andi.b	#$70,d0	; 'p'
		bne.s	locret_A618
		cmpi.l	#$FFFC8000,obYVel(a6)
		bge.s	locret_A618
		move.l	#$FFFC8000,obYVel(a6)

locret_A618:				; CODE XREF: ROM:0000A604j
					; ROM:0000A60Ej
		rts
; ---------------------------------------------------------------------------

loc_A61A:				; DATA XREF: ROM:0000A592o
		bsr.w	sub_CBC0
		bsr.w	ObjSonic_ThrowPartner
		jsr	sub_C49A
		jsr	sub_C636
		bne.s	loc_A632
		rts
; ---------------------------------------------------------------------------

loc_A632:				; CODE XREF: ROM:0000A62Ej
		tst.l	obYVel(a6)
		bpl.s	loc_A63E
		clr.l	obYVel(a6)
		rts
; ---------------------------------------------------------------------------

loc_A63E:				; CODE XREF: ROM:0000A58Ej
					; ROM:0000A636j
		move.l	obXVel(a6),d0
		bpl.s	loc_A64E
		btst	#3,$25(a6)
		bne.s	loc_A656
		bra.s	loc_A658
; ---------------------------------------------------------------------------

loc_A64E:				; CODE XREF: ROM:0000A642j
		btst	#3,$25(a6)
		beq.s	loc_A658

loc_A656:				; CODE XREF: ROM:0000A64Aj
		neg.l	d0

loc_A658:				; CODE XREF: ROM:0000A64Cj
					; ROM:0000A654j
		asr.l	#8,d0
		move.w	d0,$2C(a6)
		move.b	#2,7(a6)
		move.l	#0,obAnim(a6)
		rts
; ---------------------------------------------------------------------------
loc_A66E:
		move.b	#2,7(a6)
		bset	#4,$25(a6)
		rts
; ---------------------------------------------------------------------------
loc_A67C:
		pea	loc_A6E8(pc)
		addi.l	#$3800,obYVel(a6)
		bclr	#0,$25(a6)
		bset	#4,$25(a6)
		move.w	#$12,obAnim(a6)	;	force roll anim when in air
		clr.b	obFlags(a6)
		clr.w	$2C(a6)
		move.w	obX(a5),d0
		bne.s	loc_A6CE
		move.l	obXVel(a6),d0
		move.l	d0,d1
		bpl.s	loc_A6B2
		neg.l	d1

loc_A6B2:				; CODE XREF: ROM:0000A6AEj
		andi.l	#$FFFFF800,d1
		bne.s	loc_A6C0
		clr.l	obXVel(a6)
		rts
; ---------------------------------------------------------------------------

loc_A6C0:				; CODE XREF: ROM:0000A6B8j
		swap	d0
		ext.l	d0
		swap	d0
		ori.w	#1,d0
		neg.w	d0
		bra.s	loc_A6DC
; ---------------------------------------------------------------------------

loc_A6CE:				; CODE XREF: ROM:0000A6A6j
		move.w	$24(a6),d1
		eor.w	d0,d1
		andi.w	#8,d1
		eor.w	d1,$24(a6)

loc_A6DC:				; CODE XREF: ROM:0000A6CCj
		swap	d0
		sub.w	d0,d0
		asr.l	#4,d0
		add.l	d0,obXVel(a6)
		rts
; ---------------------------------------------------------------------------

loc_A6E8:				; DATA XREF: ROM:0000A67Co
		bsr.w	sub_CBC0
		bsr.w	ObjSonic_ThrowPartner
		jsr	sub_C49A
		jsr	sub_C636
		beq.s	locret_A72C
		move.l	obXVel(a6),d0
		bpl.s	loc_A70E
		btst	#3,$25(a6)
		bne.s	loc_A716
		bra.s	loc_A718
; ---------------------------------------------------------------------------

loc_A70E:				; CODE XREF: ROM:0000A702j
		btst	#3,$25(a6)
		beq.s	loc_A718

loc_A716:				; CODE XREF: ROM:0000A70Aj
		neg.l	d0

loc_A718:				; CODE XREF: ROM:0000A70Cj
					; ROM:0000A714j
		asr.l	#8,d0
		move.w	d0,$2C(a6)
		move.b	#2,7(a6)
		move.l	#0,obAnim(a6)

locret_A72C:				; CODE XREF: ROM:0000A6FCj
		rts
; ---------------------------------------------------------------------------
loc_A72E: 
		btst	#4,$25(a6)
		beq.s	loc_A738
		rts
; ---------------------------------------------------------------------------

loc_A738:				; CODE XREF: ROM:0000A734j
		move.w	obX(a6),obX(a4)
		move.w	obY(a6),d0
		subi.w	#$20,d0	; ' '
		move.w	d0,obY(a4)
		clr.l	obYVel(a4)
		move.b	#$C,7(a4)
		move.w	#$12,obAnim(a4)
		pea	loc_A8D6(pc)
		bclr	#4,$25(a6)
		btst	#0,$25(a6)
		beq.s	loc_A778
		clr.l	obXVel(a6)
		clr.l	obYVel(a6)

loc_A778:				; CODE XREF: ROM:0000A76Ej
		cmpi.w	#$1A,obAnim(a6)
		beq.w	loc_A88A
		move.w	obX(a5),d0
		bne.w	loc_A7CE
		move.w	#$FFF4,d0
		move.w	$2C(a6),d1
		beq.s	loc_A7A6
		bpl.s	loc_A79A
		neg.w	d0
		neg.w	d1

loc_A79A:				; CODE XREF: ROM:0000A794j
		cmpi.w	#$C,d1
		bcc.w	loc_A804
		clr.w	$2C(a6)

loc_A7A6:				; CODE XREF: ROM:0000A792j
		btst	#3,$25(a6)
		sne	d0
		andi.b	#8,d0
		move.b	d0,obVRAM(a6)
		move.l	#$1C0000,obAnim(a6)
		move.w	$A(a5),d0
		bpl.s	locret_A7CC
		move.l	#$1C0100,obAnim(a6)

locret_A7CC:				; CODE XREF: ROM:0000A7C2j
		rts
; ---------------------------------------------------------------------------

loc_A7CE:				; CODE XREF: ROM:0000A786j
		move.w	$24(a6),d1
		eor.w	d0,d1
		andi.w	#8,d1
		bne.s	loc_A7E0
		tst.w	$2C(a6)
		bpl.s	loc_A800

loc_A7E0:				; CODE XREF: ROM:0000A7D8j
		move.w	$2C(a6),d0
		bpl.s	loc_A7E8
		neg.w	d0

loc_A7E8:				; CODE XREF: ROM:0000A7E4j
		cmpi.w	#$80,d0	; ''
		bcc.s	loc_A7F6
		eor.w	d1,$24(a6)
		moveq	#0,d0
		bra.s	loc_A808
; ---------------------------------------------------------------------------

loc_A7F6:				; CODE XREF: ROM:0000A7ECj
		move.l	#$1A0000,obAnim(a6)
		rts
; ---------------------------------------------------------------------------

loc_A800:				; CODE XREF: ROM:0000A7DEj
		move.w	#$C,d0

loc_A804:				; CODE XREF: ROM:0000A79Ej
		add.w	$2C(a6),d0

loc_A808:				; CODE XREF: ROM:0000A7F4j
		move.w	d0,$2C(a6)
		bpl.s	loc_A810
		neg.w	d0

loc_A810:				; CODE XREF: ROM:0000A80Cj
		cmpi.w	#$400,d0
		bcs.s	loc_A820
		moveq	#$26,d2	; '&'
		andi.w	#$3FF,obFrame(a6)
		bra.s	loc_A830
; ---------------------------------------------------------------------------

loc_A820:				; CODE XREF: ROM:0000A814j
		lsr.w	#4,d0
		cmpi.w	#$10,d0
		bcc.s	loc_A82A
		moveq	#$10,d0

loc_A82A:				; CODE XREF: ROM:0000A826j
		add.w	d0,obFrame(a6)
		moveq	#$1E,d2

loc_A830:				; CODE XREF: ROM:0000A81Ej
		move.b	obFlags(a6),d0
		btst	#3,$25(a6)
		bne.s	loc_A85E
		subi.b	#$10,d0
		neg.b	d0
		lsr.w	#4,d0
		btst	#3,d0
		sne	d1
		andi.w	#6,d0
		add.w	d2,d0
		move.w	d0,obAnim(a6)
		andi.b	#$18,d1
		move.b	d1,obVRAM(a6)
		rts
; ---------------------------------------------------------------------------

loc_A85E:				; CODE XREF: ROM:0000A83Aj
		subi.b	#$80,d0
		neg.b	d0
		subi.b	#$10,d0
		neg.b	d0
		lsr.w	#4,d0
		btst	#3,d0
		sne	d1
		andi.w	#6,d0
		add.w	d2,d0
		move.w	d0,obAnim(a6)
		andi.b	#$18,d1
		eori.b	#$10,d1
		move.b	d1,obVRAM(a6)
		rts
; ---------------------------------------------------------------------------

loc_A88A:				; CODE XREF: ROM:0000A77Ej
		btst	#3,$25(a6)
		sne	d0
		not.b	d0
		andi.b	#8,d0
		move.b	d0,obVRAM(a6)
		move.w	#$FF80,d0
		move.w	$2C(a6),d1
		beq.s	loc_A8B6
		bpl.s	loc_A8AC
		neg.w	d0
		neg.w	d1

loc_A8AC:				; CODE XREF: ROM:0000A8A6j
		cmpi.w	#$80,d1	; ''
		bcc.s	loc_A8C6
		clr.w	$2C(a6)

loc_A8B6:				; CODE XREF: ROM:0000A8A4j
		move.l	#$1C0000,obAnim(a6)
		eori.b	#8,$25(a6)
		rts
; ---------------------------------------------------------------------------

loc_A8C6:				; CODE XREF: ROM:0000A8B0j
		add.w	$2C(a6),d0
		move.w	d0,$2C(a6)
		andi.b	#3,obFrame(a6)
		rts
; ---------------------------------------------------------------------------

loc_A8D6:				; DATA XREF: ROM:0000A75Eo
		move.b	2(a5),d0
		move.b	d0,d1
		andi.b	#$70,d0	; 'p'
		bne.s	loc_A928

	; tossing player
		move.b	#$A7,d0
		bsr.w	Play_Sound

		move.b	5(a5),d2
		andi.b	#$F,d1
		bne.s	loc_A8F8
		moveq	#$FFFFFFA0,d2
		btst	#3,$25(a6)
		bne.s	loc_A8F8
		moveq	#$FFFFFFE0,d2

loc_A8F8:				; CODE XREF: ROM:0000A8EAj
					; ROM:0000A8F4j
		jsr	CalcSine
		ext.l	d0
		ext.l	d1
		asl.l	#5,d0
		asl.l	#5,d1
		add.l	d0,obX(a4)
		add.l	d1,obY(a4)
		add.l	obXVel(a6),d0
		add.l	obYVel(a6),d1
		move.l	d0,obXVel(a4)
		move.l	d1,obYVel(a4)
		move.b	#8,7(a4)
		move.b	#2,7(a6)

loc_A928:				; CODE XREF: ROM:0000A8E0j
		bsr.w	nullsub_2
		bsr.w	sub_CBC0
		jsr	sub_C49A
		jsr	sub_C29E
		beq.s	loc_A94E
		bset	#0,$25(a6)
		move.w	d0,($FFFFFAC0).w
		move.w	d1,($FFFFFAC2).w
		rts
; ---------------------------------------------------------------------------

loc_A94E:				; CODE XREF: ROM:0000A93Cj
		bclr	#0,$25(a6)
		beq.s	loc_A988
		move.b	#8,7(a6)
		move.b	obFlags(a6),d2
		btst	#3,$25(a6)
		beq.s	loc_A96C
		addi.b	#-$80,d2

loc_A96C:				; CODE XREF: ROM:0000A966j
		jsr	CalcSine
		move.w	$2C(a6),d2
		muls.w	d2,d0
		muls.w	d2,d1
		asr.l	#6,d0
		asr.l	#6,d1
		move.l	d0,obXVel(a6)
		move.l	d1,obYVel(a6)
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------

loc_A988:				; CODE XREF: ROM:0000A954j
		addi.l	#$3800,obYVel(a6)
		rts
; ---------------------------------------------------------------------------
locret_A992:
		cmpi.b	#$A,7(a4)
		beq.s	loc_B250_B
		move.b	#8,7(a6)
		rts
; ---------------------------------------------------------------------------

loc_B250_B:
		bclr	#0,$25(a6)
		bset	#4,$25(a6)
		move.w	#$12,obAnim(a6)
		moveq	#0,d0
		move.w	d0,$2C(a6)
		move.l	d0,obXVel(a6)
		moveq	#$FFFFFFFF,d0
		move.l	d0,obYVel(a6)
		rts
; ---------------------------------------------------------------------------

ObjSonic_Spindash:
		cmpi.b	#1,($FFFFFFFF)
		beq.s	@cont
		move.b	#$A2,d0
		bsr.w	Play_Sound
	@cont:
		bclr	#4,$25(a6)
		move.w	#$2E,obAnim(a6) ; '.'
		addq.b	#1,obFrame(a6)
		move.b	#1,($FFFFFFFF)
		tst.l	$2C(a6)
		bne.s	loc_A9B2
		btst	#1,2(a5)
		bne.s	loc_A9C0

loc_A9B2:				; CODE XREF: ROM:0000A9A8j
		move.b	#0,($FFFFFFFF)
		move.w	#$800,$2C(a6)
		move.b	#6,7(a6)
		rts
; ---------------------------------------------------------------------------

loc_A9C0:				; CODE XREF: ROM:0000A9B0j
		jsr	sub_CBC0
		rts
; ---------------------------------------------------------------------------
loc_A9C8:
		move.w	#$100,$30(a6)
		btst	#0,$25(a6)
		bne.w	loc_AA08
		addi.l	#$3800,obYVel(a6)
		bclr	#0,$25(a6)
		move.w	#$30,obAnim(a6) ; '0'
		clr.b	obFlags(a6)
		clr.w	$2C(a6)
		bsr.w	sub_CBC0
		bsr.w	ObjSonic_ThrowPartner
		jsr	sub_C49A
		jsr	sub_C636
		bne.s	loc_AA08
		rts
; ---------------------------------------------------------------------------

loc_AA08:				; CODE XREF: ROM:0000A9D4j
					; ROM:0000AA04j
		move.l	obXVel(a6),d0
		bpl.s	loc_AA18
		btst	#3,$25(a6)
		bne.s	loc_AA20
		bra.s	loc_AA22
; ---------------------------------------------------------------------------

loc_AA18:				; CODE XREF: ROM:0000AA0Cj
		btst	#3,$25(a6)
		beq.s	loc_AA22

loc_AA20:				; CODE XREF: ROM:0000AA14j
		neg.l	d0

loc_AA22:				; CODE XREF: ROM:0000AA16j
					; ROM:0000AA1Ej
		asr.l	#8,d0
		move.w	d0,$2C(a6)
		tst.w	$32(a6)
		bmi.s	loc_AA3E
		move.b	#2,7(a6)
		move.l	#0,obAnim(a6)
		rts
; ---------------------------------------------------------------------------

loc_AA3E:				; CODE XREF: ROM:0000AA2Cj
		move.b	#$12,7(a6)
		rts
; ---------------------------------------------------------------------------
loc_AA46:
		andi.b	#8,obVRAM(a6)
		moveq	#0,d0
		move.w	d0,$2C(a6)
		move.l	d0,obXVel(a6)
		move.l	d0,obYVel(a6)
		tst.w	$30(a6)
		bne.s	loc_AA6E
		move.w	#$10,$32(a6)
		move.b	#2,7(a6)
		rts
; ---------------------------------------------------------------------------

loc_AA6E:				; CODE XREF: ROM:0000AA5Ej
		move.w	#$32,obAnim(a6) ; '2'
		rts

; =============== S U B	R O U T	I N E =======================================


ObjSonic_ThrowPartner:				; CODE XREF: ROM:0000A514p
					; ROM:0000A61Ep ...
		move.b	$FFFFC93D,d0
		andi.b	#$10,d0	; 'p'
		beq.s	locret_AAA2

	; Sonic Jump (start)

		move.w	($FFFFFAE0).w,d0
		cmpi.w	#$18,d0
		bcc.s	locret_AAA2
		move.b	#$A,7(a6)
		bclr	#4,$25(a6)
		andi.b	#$F,2(a5)
		andi.b	#$F,3(a5)

locret_AAA2:				; CODE XREF: ObjSonic_ThrowPartner+8j ObjSonic_ThrowPartner+12j
		rts
; End of function ObjSonic_ThrowPartner


; =============== S U B	R O U T	I N E =======================================


ObjSonic_Jump:				; CODE XREF: ROM:0000A518p
		move.b	$FFFFC93D,d0
		andi.b	#$20,d0	; 'p'
		beq.s	locret_AAF6
		move.b	#4,7(a6)
		clr.w	obFrame(a6)
		bclr	#0,$25(a6)
		move.b	obFlags(a6),d2
		jsr	CalcSine
		move.w	d0,d3
		move.w	d1,d4
		btst	#3,$25(a6)
		beq.s	loc_AAD4
		neg.w	d0
		neg.w	d1

loc_AAD4:				; CODE XREF: ObjSonic_Jump+2Cj
		move.w	$2C(a6),d2
		muls.w	d2,d0
		muls.w	d2,d1
		move.w	#$680,d2
		muls.w	d2,d3
		muls.w	d2,d4
		add.l	d4,d0
		sub.l	d3,d1
		asr.l	#6,d0
		asr.l	#6,d1
		move.l	d0,obXVel(a6)
		move.l	d1,obYVel(a6)
		move.b	#$A0,d0
		bsr.w	Play_Sound_2
		rts
; ---------------------------------------------------------------------------

locret_AAF6:				; CODE XREF: ObjSonic_Jump+8j
		rts
; End of function ObjSonic_Jump


; =============== S U B	R O U T	I N E =======================================


nullsub_2:				; CODE XREF: ROM:loc_A530p
					; ROM:loc_A928p
					
		tst.w	$2C(a6)
		bne.s	loc_AB02

locret_AB00:				; CODE XREF: ROM:0000AB10j
		rts
; ---------------------------------------------------------------------------

loc_AB02:				; CODE XREF: ROM:0000AAFEj
		move.b	obFlags(a6),d0
		move.b	d0,d2
		subi.b	#$20,d0	; ' '
		cmpi.b	#$C0,d0
		bcc.s	locret_AB00
		jsr	CalcSine
		asr.w	#8,d1
		ext.w	d2
		ext.l	d2
		swap	d2
		move.w	$24(a6),d0
		btst	#3,d0
		beq.s	loc_AB2A
		neg.w	d1

loc_AB2A:				; CODE XREF: ROM:0000AB26j
		add.w	d1,$2C(a6)
		rts
; ---------------------------------------------------------------------------
