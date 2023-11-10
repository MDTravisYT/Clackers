
TailsMain:				; DATA XREF: ROM:0000A1D2o
		move.w	#$C0D,obWidth(a6)
		moveq	#0,d0
		move.b	7(a6),d0
		pea	loc_C746(pc)
        move.w  TailsIndex(pc,d0.w),d0
        jmp     TailsIndex(pc,d0.w)
; ---------------------------------------------------------------------------
TailsIndex:       rts         ; DATA XREF: ROM:0000AB44↑o
                                        ; ROM:0000AB4A↓o ...
                dc.w loc_AB5C-TailsIndex
                dc.w loc_AE3A-TailsIndex
                dc.w loc_AF20-TailsIndex
                dc.w loc_AF2E-TailsIndex
                dc.w loc_AFE0-TailsIndex
                dc.w loc_B240-TailsIndex
                dc.w loc_B274-TailsIndex
                dc.w loc_B2A8-TailsIndex
                dc.w loc_B32A-TailsIndex
; ---------------------------------------------------------------------------

loc_AB5C:                               ; DATA XREF: ROM:0000AB4A↑o
		pea	loc_ADB8(pc)
		bset	#0,$25(a6)
		bclr	#4,$25(a6)
		clr.l	$18(a6)
		clr.l	obYVel(a6)
		cmpi.w	#$1A,$26(a6)
		beq.w	loc_AD66
		tst.b	(a5)
		bpl.s	loc_AB92
		move.b	($FFFFC93C).w,d0	; Tails' holding a b c
		andi.b	#$50,d0	; 'p'
		beq.s	loc_AB92
		clr.w	$2C(a6)
		bra.s	loc_AB9A
; ---------------------------------------------------------------------------

loc_AB92:				; CODE XREF: ROM:0000AB80j
					; ROM:0000AB8Aj
		move.w	obX(a5),d0
		bne.w	loc_AC98

loc_AB9A:				; CODE XREF: ROM:0000AB90j
		move.w	#$FFF0,d0
		move.w	$2C(a6),d1
		beq.s	loc_ABB6
		bpl.s	loc_ABAA
		neg.w	d0
		neg.w	d1

loc_ABAA:				; CODE XREF: ROM:0000ABA4j
		move.w	#$30,$26(a6)
		cmpi.w	#$10,d1
		bcc.w	loc_ACE0
		clr.w	$2C(a6)

loc_ABB6:				; CODE XREF: ROM:0000ABA2j
		btst	#3,$25(a6)
		sne	d0
		andi.b	#8,d0
		move.b	d0,obVRAM(a6)
		move.b	#$A,($FFFFFAE8).w
		move.b	obFlags(a6),d0
		addi.b	#$10,d0
		cmpi.b	#$20,d0	; ' '
		bcc.s	loc_AC50
		move.w	obX(a6),d0
		moveq	#0,d1
		move.b	obHeight(a6),d1
		add.w	obY(a6),d1
		move.w	$24(a6),d4
		andi.w	#2,d4
		bsr.w	sub_BF84
		cmpi.w	#$FF80,d5
		bne.s	loc_AC50
		btst	#3,$25(a6)
		bne.s	loc_AC1C
		move.b	#8,obVRAM(a6)
		moveq	#0,d3
		move.b	obWidth(a6),d3
		add.w	d3,d0
		bsr.w	sub_BF84
		cmpi.w	#$FF80,d5
		bne.s	loc_AC42
		bra.s	loc_AC34
; ---------------------------------------------------------------------------

loc_AC1C:				; CODE XREF: ROM:0000AC00j
		move.b	#0,obVRAM(a6)
		moveq	#0,d3
		move.b	obWidth(a6),d3
		sub.w	d3,d0
		bsr.w	sub_BF84
		cmpi.w	#$FF80,d5
		bne.s	loc_AC42

loc_AC34:				; CODE XREF: ROM:0000AC1Aj
		move.w	#$18,$26(a6)
		andi.b	#3,$28(a6)
		rts
; ---------------------------------------------------------------------------

loc_AC42:				; CODE XREF: ROM:0000AC18j
					; ROM:0000AC32j
		move.w	#$16,$26(a6)
		andi.b	#3,$28(a6)
		rts
; ---------------------------------------------------------------------------

loc_AC50:				; CODE XREF: ROM:0000ABD8j
					; ROM:0000ABF8j
		move.w	$A(a5),d0
		beq.s	loc_AC6C
		move.l	#$100,$26(a6)
		tst.w	d0
		bmi.s	locret_AC6A
		move.l	#$200,$26(a6)

locret_AC6A:				; CODE XREF: ROM:0000AC60j
		rts
; ---------------------------------------------------------------------------

loc_AC6C:				; CODE XREF: ROM:0000AC54j
		cmpi.w	#$14,$26(a6)
		beq.s	locret_AC96
		tst.w	$26(a6)
		beq.s	loc_AC7E
		clr.w	$28(a6)

loc_AC7E:				; CODE XREF: ROM:0000AC78j
		move.w	#0,$26(a6)
		tst.b	$29(a6)
		bpl.s	loc_AC90
		move.w	#$14,$26(a6)

loc_AC90:				; CODE XREF: ROM:0000AC88j
		move.b	#0,$28(a6)

locret_AC96:				; CODE XREF: ROM:0000AC72j
		rts
; ---------------------------------------------------------------------------

loc_AC98:				; CODE XREF: ROM:0000AB96j
		move.b	3(a5),d1
		andi.b	#$C,d1
		beq.s	loc_ACA6
		clr.w	$28(a6)

loc_ACA6:				; CODE XREF: ROM:0000ACA0j
		move.w	$24(a6),d1
		eor.w	d0,d1
		move.w	$2C(a6),d2
		ext.l	d2
		swap	d2
		eor.w	d2,d1
		andi.w	#8,d1
		beq.s	loc_ACDC
		move.w	$2C(a6),d0
		bpl.s	loc_ACC4
		neg.w	d0

loc_ACC4:				; CODE XREF: ROM:0000ACC0j
		cmpi.w	#$80,d0	; ''
		bcc.s	loc_ACD2
		eor.w	d1,$24(a6)
		moveq	#0,d0
		bra.s	loc_ACE4
; ---------------------------------------------------------------------------

loc_ACD2:				; CODE XREF: ROM:0000ACC8j
		move.l	#$1A0000,$26(a6)
		rts
; ---------------------------------------------------------------------------

loc_ACDC:				; CODE XREF: ROM:0000ACBAj
		move.w	#$10,d0

loc_ACE0:				; CODE XREF: ROM:0000ABAEj
		add.w	$2C(a6),d0

loc_ACE4:				; CODE XREF: ROM:0000ACD0j
		move.w	d0,$2C(a6)
		bpl.s	loc_ACEC
		neg.w	d0

loc_ACEC:				; CODE XREF: ROM:0000ACE8j
		cmpi.w	#$400,d0
		bcs.s	loc_ACFC
		moveq	#$A,d2
		andi.w	#$1FF,$28(a6)
		bra.s	loc_AD0C
; ---------------------------------------------------------------------------

loc_ACFC:				; CODE XREF: ROM:0000ACF0j
		lsr.w	#4,d0
		cmpi.w	#$10,d0
		bcc.s	loc_AD06
		moveq	#$10,d0

loc_AD06:				; CODE XREF: ROM:0000AD02j
		add.w	d0,$28(a6)
		moveq	#2,d2

loc_AD0C:				; CODE XREF: ROM:0000ACFAj
		move.b	obFlags(a6),d0
		btst	#3,$25(a6)
		bne.s	loc_AD3A
		subi.b	#$10,d0
		neg.b	d0
		lsr.w	#4,d0
		btst	#3,d0
		sne	d1
		andi.w	#6,d0
		add.w	d2,d0
		move.w	d0,$26(a6)
		andi.b	#$18,d1
		move.b	d1,obVRAM(a6)
		rts
; ---------------------------------------------------------------------------

loc_AD3A:				; CODE XREF: ROM:0000AD16j
		subi.b	#$80,d0
		neg.b	d0
		subi.b	#$10,d0
		neg.b	d0
		lsr.w	#4,d0
		btst	#3,d0
		sne	d1
		andi.w	#6,d0
		add.w	d2,d0
		move.w	d0,$26(a6)
		andi.b	#$18,d1
		eori.b	#$10,d1
		move.b	d1,obVRAM(a6)
		rts
; ---------------------------------------------------------------------------

loc_AD66:				; CODE XREF: ROM:0000AB7Aj
		btst	#3,$25(a6)
		sne	d0
		not.b	d0
		andi.b	#8,d0
		move.b	d0,obVRAM(a6)
		move.w	#$FF80,d0
		move.w	$2C(a6),d1
		beq.s	loc_AD92
		bpl.s	loc_AD88
		neg.w	d0
		neg.w	d1

loc_AD88:				; CODE XREF: ROM:0000AD82j
		cmpi.w	#$80,d1	; ''
		bcc.s	loc_ADA2
		clr.w	$2C(a6)

loc_AD92:				; CODE XREF: ROM:0000AD80j
		move.l	#0,$26(a6)
		eori.b	#8,$25(a6)
		rts
; ---------------------------------------------------------------------------

loc_ADA2:				; CODE XREF: ROM:0000AD8Cj
		add.w	$2C(a6),d0
		move.w	d0,$2C(a6)
		move.w	#$1A,$26(a6)
		andi.b	#3,$28(a6)
		move.b	#$A4,d0
		bsr.w	Play_Sound_2
		rts
; ---------------------------------------------------------------------------

loc_ADB8:				; DATA XREF: ROM:0000AB5Co
		cmpi.l	#$200,$26(a6)
		beq.s	loc_ADD0
		tst.b	(a5)
		bmi.s	@ContPartner
		bsr.w	ObjTails_ThrowPartner
	@ContPartner:
		bsr.w	ObjTails_Jump
		bra.s	loc_ADE2
; ---------------------------------------------------------------------------

loc_ADD0:				; CODE XREF: ROM:0000ADC0j
		move.b	3(a5),d0
		andi.b	#$70,d0	; 'p'
		beq.s	loc_ADE2
		move.b	#$E,7(a6)
		rts
; ---------------------------------------------------------------------------

loc_ADE2:				; CODE XREF: ROM:0000ADC4j
					; ROM:0000ADCEj ...
		bsr.w	nullsub_3
		bsr.w	sub_CBC0
		jsr	sub_C49A
		jsr	sub_C29E
		beq.s	loc_AE02
		move.w	d0,($FFFFFAC0).w
		move.w	d1,($FFFFFAC2).w
		rts
; ---------------------------------------------------------------------------

loc_AE02:				; CODE XREF: ROM:0000ADF6j
		bclr	#0,$25(a6)
		move.b	#8,7(a6)
		move.b	obFlags(a6),d2
		btst	#3,$25(a6)
		beq.s	loc_AE1E
		addi.b	#-$80,d2

loc_AE1E:				; CODE XREF: ROM:0000AE18j
		jsr	CalcSine
		move.w	$2C(a6),d2
		muls.w	d2,d0
		muls.w	d2,d1
		asr.l	#6,d0
		asr.l	#6,d1
		move.l	d0,$18(a6)
		move.l	d1,obYVel(a6)
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------
loc_AE3A:  
		btst	#0,$25(a6)
		bne.w	loc_AEF0
		pea	loc_AECC(pc)
		addi.l	#$3800,obYVel(a6)
		bclr	#0,$25(a6)
		bset	#4,$25(a6)
		move.w	#$12,$26(a6)
		clr.b	obFlags(a6)
		clr.w	$2C(a6)
		move.w	obX(a5),d0
		bne.s	loc_AE96
		move.l	$18(a6),d0
		move.l	d0,d1
		bpl.s	loc_AE7A
		neg.l	d1

loc_AE7A:				; CODE XREF: ROM:0000AE76j
		andi.l	#$FFFFF800,d1
		bne.s	loc_AE88
		clr.l	$18(a6)
		bra.s	loc_AEAE
; ---------------------------------------------------------------------------

loc_AE88:				; CODE XREF: ROM:0000AE80j
		swap	d0
		ext.l	d0
		swap	d0
		ori.w	#1,d0
		neg.w	d0
		bra.s	loc_AEA4
; ---------------------------------------------------------------------------

loc_AE96:				; CODE XREF: ROM:0000AE6Ej
		move.w	$24(a6),d1
		eor.w	d0,d1
		andi.w	#8,d1
		eor.w	d1,$24(a6)

loc_AEA4:				; CODE XREF: ROM:0000AE94j
		swap	d0
		sub.w	d0,d0
		asr.l	#4,d0
		add.l	d0,$18(a6)

loc_AEAE:				; CODE XREF: ROM:0000AE86j
		move.b	2(a5),d0
		andi.b	#$70,d0	; 'p'
		bne.s	locret_AECA
		cmpi.l	#$FFFC0000,obYVel(a6)
		bge.s	locret_AECA
		move.l	#$FFFC0000,obYVel(a6)

locret_AECA:				; CODE XREF: ROM:0000AEB6j
					; ROM:0000AEC0j
		rts
; ---------------------------------------------------------------------------

loc_AECC:				; DATA XREF: ROM:0000AE44o
		bsr.w	sub_CBC0
		bsr.w	ObjTails_ThrowPartner
		jsr	sub_C49A
		jsr	sub_C636
		bne.s	loc_AEE4
		rts
; ---------------------------------------------------------------------------

loc_AEE4:				; CODE XREF: ROM:0000AEE0j
		tst.l	obYVel(a6)
		bpl.s	loc_AEF0
		clr.l	obYVel(a6)
		rts
; ---------------------------------------------------------------------------

loc_AEF0:				; CODE XREF: ROM:0000AE40j
					; ROM:0000AEE8j
		move.l	$18(a6),d0
		bpl.s	loc_AF00
		btst	#3,$25(a6)
		bne.s	loc_AF08
		bra.s	loc_AF0A
; ---------------------------------------------------------------------------

loc_AF00:				; CODE XREF: ROM:0000AEF4j
		btst	#3,$25(a6)
		beq.s	loc_AF0A

loc_AF08:				; CODE XREF: ROM:0000AEFCj
		neg.l	d0

loc_AF0A:				; CODE XREF: ROM:0000AEFEj
					; ROM:0000AF06j
		asr.l	#8,d0
		move.w	d0,$2C(a6)
		move.b	#2,7(a6)
		move.l	#0,$26(a6)
		rts
; ---------------------------------------------------------------------------
loc_AF20:
		move.b	#2,7(a6)
		bset	#4,$25(a6)
		rts
; ---------------------------------------------------------------------------
loc_AF2E:
		pea	loc_AF9A(pc)
		addi.l	#$3800,obYVel(a6)
		bclr	#0,$25(a6)
		bset	#4,$25(a6)
		move.w	#$12,$26(a6)
		clr.b	obFlags(a6)
		clr.w	$2C(a6)
		move.w	obX(a5),d0
		bne.s	loc_AF80
		move.l	$18(a6),d0
		move.l	d0,d1
		bpl.s	loc_AF64
		neg.l	d1

loc_AF64:				; CODE XREF: ROM:0000AF60j
		andi.l	#$FFFFF800,d1
		bne.s	loc_AF72
		clr.l	$18(a6)
		rts
; ---------------------------------------------------------------------------

loc_AF72:				; CODE XREF: ROM:0000AF6Aj
		swap	d0
		ext.l	d0
		swap	d0
		ori.w	#1,d0
		neg.w	d0
		bra.s	loc_AF8E
; ---------------------------------------------------------------------------

loc_AF80:				; CODE XREF: ROM:0000AF58j
		move.w	$24(a6),d1
		eor.w	d0,d1
		andi.w	#8,d1
		eor.w	d1,$24(a6)

loc_AF8E:				; CODE XREF: ROM:0000AF7Ej
		swap	d0
		sub.w	d0,d0
		asr.l	#4,d0
		add.l	d0,$18(a6)
		rts
; ---------------------------------------------------------------------------

loc_AF9A:				; DATA XREF: ROM:0000AF2Eo
		bsr.w	sub_CBC0
		bsr.w	ObjTails_ThrowPartner
		jsr	sub_C49A
		jsr	sub_C636
		beq.s	locret_AFDE
		move.l	$18(a6),d0
		bpl.s	loc_AFC0
		btst	#3,$25(a6)
		bne.s	loc_AFC8
		bra.s	loc_AFCA
; ---------------------------------------------------------------------------

loc_AFC0:				; CODE XREF: ROM:0000AFB4j
		btst	#3,$25(a6)
		beq.s	loc_AFCA

loc_AFC8:				; CODE XREF: ROM:0000AFBCj
		neg.l	d0

loc_AFCA:				; CODE XREF: ROM:0000AFBEj
					; ROM:0000AFC6j
		asr.l	#8,d0
		move.w	d0,$2C(a6)
		move.b	#2,7(a6)
		move.l	#0,$26(a6)

locret_AFDE:				; CODE XREF: ROM:0000AFAEj
		rts
; ---------------------------------------------------------------------------
loc_AFE0:
		btst	#4,$25(a6)
		beq.s	loc_AFEA
		rts
; ---------------------------------------------------------------------------

loc_AFEA:				; CODE XREF: ROM:0000AFE6j
		move.w	obX(a6),obX(a4)
		move.w	obY(a6),d0
		subi.w	#$20,d0	; ' '
		move.w	d0,obY(a4)
		clr.l	obYVel(a4)
		move.b	#$C,7(a4)
		move.w	#$12,$26(a4)
		pea	loc_B184(pc)
		bclr	#4,$25(a6)
		btst	#0,$25(a6)
		beq.s	loc_B026
		clr.l	$18(a6)
		clr.l	obYVel(a6)

loc_B026:				; CODE XREF: ROM:0000B01Cj
		cmpi.w	#$1A,$26(a6)
		beq.w	loc_B138
		move.w	obX(a5),d0
		bne.w	loc_B07C
		move.w	#$FFF0,d0
		move.w	$2C(a6),d1
		beq.s	loc_B054
		bpl.s	loc_B048
		neg.w	d0
		neg.w	d1

loc_B048:				; CODE XREF: ROM:0000B042j
		cmpi.w	#$10,d1
		bcc.w	loc_B0B2
		clr.w	$2C(a6)

loc_B054:				; CODE XREF: ROM:0000B040j
		btst	#3,$25(a6)
		sne	d0
		andi.b	#8,d0
		move.b	d0,obVRAM(a6)
		move.l	#$1C0000,$26(a6)
		move.w	$A(a5),d0
		bpl.s	locret_B07A
		move.l	#$1C0100,$26(a6)

locret_B07A:				; CODE XREF: ROM:0000B070j
		rts
; ---------------------------------------------------------------------------

loc_B07C:				; CODE XREF: ROM:0000B034j
		move.w	$24(a6),d1
		eor.w	d0,d1
		andi.w	#8,d1
		bne.s	loc_B08E
		tst.w	$2C(a6)
		bpl.s	loc_B0AE

loc_B08E:				; CODE XREF: ROM:0000B086j
		move.w	$2C(a6),d0
		bpl.s	loc_B096
		neg.w	d0

loc_B096:				; CODE XREF: ROM:0000B092j
		cmpi.w	#$80,d0	; ''
		bcc.s	loc_B0A4
		eor.w	d1,$24(a6)
		moveq	#0,d0
		bra.s	loc_B0B6
; ---------------------------------------------------------------------------

loc_B0A4:				; CODE XREF: ROM:0000B09Aj
		move.l	#$1A0000,$26(a6)
		rts
; ---------------------------------------------------------------------------

loc_B0AE:				; CODE XREF: ROM:0000B08Cj
		move.w	#$10,d0

loc_B0B2:				; CODE XREF: ROM:0000B04Cj
		add.w	$2C(a6),d0

loc_B0B6:				; CODE XREF: ROM:0000B0A2j
		move.w	d0,$2C(a6)
		bpl.s	loc_B0BE
		neg.w	d0

loc_B0BE:				; CODE XREF: ROM:0000B0BAj
		cmpi.w	#$400,d0
		bcs.s	loc_B0CE
		moveq	#$26,d2	; '&'
		andi.w	#$1FF,$28(a6)
		bra.s	loc_B0DE
; ---------------------------------------------------------------------------

loc_B0CE:				; CODE XREF: ROM:0000B0C2j
		lsr.w	#4,d0
		cmpi.w	#$10,d0
		bcc.s	loc_B0D8
		moveq	#$10,d0

loc_B0D8:				; CODE XREF: ROM:0000B0D4j
		add.w	d0,$28(a6)
		moveq	#$1E,d2

loc_B0DE:				; CODE XREF: ROM:0000B0CCj
		move.b	obFlags(a6),d0
		btst	#3,$25(a6)
		bne.s	loc_B10C
		subi.b	#$10,d0
		neg.b	d0
		lsr.w	#4,d0
		btst	#3,d0
		sne	d1
		andi.w	#6,d0
		add.w	d2,d0
		move.w	d0,$26(a6)
		andi.b	#$18,d1
		move.b	d1,obVRAM(a6)
		rts
; ---------------------------------------------------------------------------

loc_B10C:				; CODE XREF: ROM:0000B0E8j
		subi.b	#$80,d0
		neg.b	d0
		subi.b	#$10,d0
		neg.b	d0
		lsr.w	#4,d0
		btst	#3,d0
		sne	d1
		andi.w	#6,d0
		add.w	d2,d0
		move.w	d0,$26(a6)
		andi.b	#$18,d1
		eori.b	#$10,d1
		move.b	d1,obVRAM(a6)
		rts
; ---------------------------------------------------------------------------

loc_B138:				; CODE XREF: ROM:0000B02Cj
		btst	#3,$25(a6)
		sne	d0
		not.b	d0
		andi.b	#8,d0
		move.b	d0,obVRAM(a6)
		move.w	#$FF80,d0
		move.w	$2C(a6),d1
		beq.s	loc_B164
		bpl.s	loc_B15A
		neg.w	d0
		neg.w	d1

loc_B15A:				; CODE XREF: ROM:0000B154j
		cmpi.w	#$80,d1	; ''
		bcc.s	loc_B174
		clr.w	$2C(a6)

loc_B164:				; CODE XREF: ROM:0000B152j
		move.l	#$1C0000,$26(a6)
		eori.b	#8,$25(a6)
		rts
; ---------------------------------------------------------------------------

loc_B174:				; CODE XREF: ROM:0000B15Ej
		add.w	$2C(a6),d0
		move.w	d0,$2C(a6)
		andi.b	#3,$28(a6)
		rts
; ---------------------------------------------------------------------------

loc_B184:				; DATA XREF: ROM:0000B00Co
		move.b	2(a5),d0
		move.b	d0,d1
		andi.b	#$70,d0	; 'p'
		bne.s	loc_B1D6

	; tossing player
		move.b	#$A7,d0
		bsr.w	Play_Sound

		move.b	5(a5),d2
		andi.b	#$F,d1
		bne.s	loc_B1A6
		moveq	#$FFFFFFA0,d2
		btst	#3,$25(a6)
		bne.s	loc_B1A6
		moveq	#$FFFFFFE0,d2

loc_B1A6:				; CODE XREF: ROM:0000B198j
					; ROM:0000B1A2j
		jsr	CalcSine
		ext.l	d0
		ext.l	d1
		asl.l	#5,d0
		asl.l	#5,d1
		add.l	d0,obX(a4)
		add.l	d1,obY(a4)
		add.l	$18(a6),d0
		add.l	obYVel(a6),d1
		move.l	d0,$18(a4)
		move.l	d1,obYVel(a4)
		move.b	#8,7(a4)
		move.b	#2,7(a6)

loc_B1D6:				; CODE XREF: ROM:0000B18Ej
		bsr.w	nullsub_3
		bsr.w	sub_CBC0
		jsr	sub_C49A
		jsr	sub_C29E
		beq.s	loc_B1FC
		bset	#0,$25(a6)
		move.w	d0,($FFFFFAC0).w
		move.w	d1,($FFFFFAC2).w
		rts
; ---------------------------------------------------------------------------

loc_B1FC:				; CODE XREF: ROM:0000B1EAj
		bclr	#0,$25(a6)
		beq.s	loc_B236
		move.b	#8,7(a6)
		move.b	obFlags(a6),d2
		btst	#3,$25(a6)
		beq.s	loc_B21A
		addi.b	#-$80,d2

loc_B21A:				; CODE XREF: ROM:0000B214j
		jsr	CalcSine
		move.w	$2C(a6),d2
		muls.w	d2,d0
		muls.w	d2,d1
		asr.l	#6,d0
		asr.l	#6,d1
		move.l	d0,$18(a6)
		move.l	d1,obYVel(a6)
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------

loc_B236:				; CODE XREF: ROM:0000B202j
		addi.l	#$3800,obYVel(a6)
		rts
; ---------------------------------------------------------------------------
loc_B240:
		cmpi.b	#$A,7(a4)
		beq.s	loc_B250
		move.b	#8,7(a6)
		rts
; ---------------------------------------------------------------------------

loc_B250:				; CODE XREF: ROM:0000B246j
		bclr	#0,$25(a6)
		bset	#4,$25(a6)
		move.w	#$12,$26(a6)
		moveq	#0,d0
		move.w	d0,$2C(a6)
		move.l	d0,$18(a6)
		moveq	#$FFFFFFFF,d0
		move.l	d0,obYVel(a6)
		rts
; ---------------------------------------------------------------------------
loc_B274:
		cmpi.b	#1,($FFFFFFFF)
		beq.s	@cont
		move.b	#$A2,d0
		bsr.w	Play_Sound
	@cont:
		bclr	#4,$25(a6)
		move.w	#$2E,$26(a6) ; '.'
		addq.b	#1,$28(a6)
		move.b	#1,($FFFFFFFF)
		tst.l	$2C(a6)
		bne.s	loc_B292
		btst	#1,2(a5)
		bne.s	loc_B2A0

loc_B292:				; CODE XREF: ROM:0000B288j
		move.b	#0,($FFFFFFFF)
		move.w	#$800,$2C(a6)
		move.b	#6,7(a6)
		rts
; ---------------------------------------------------------------------------

loc_B2A0:				; CODE XREF: ROM:0000B290j
		jsr	sub_CBC0
		rts
; ---------------------------------------------------------------------------
loc_B2A8:
		move.w	#$100,$30(a6)
		btst	#0,$25(a6)
		bne.w	loc_B2EC
		addi.l	#$3800,obYVel(a6)
		bclr	#0,$25(a6)
		move.w	#$30,$26(a6) ; '0'
		clr.b	obFlags(a6)
		clr.w	$2C(a6)
		bsr.w	sub_CBC0
		bsr.w	ObjTails_ThrowPartner
		jsr	sub_C49A
		jsr	sub_C636
		bne.s	loc_B2EC
		rts
; ---------------------------------------------------------------------------

loc_B2EC:				; CODE XREF: ROM:0000B2B4j
					; ROM:0000B2E8j
		move.l	$18(a6),d0
		bpl.s	loc_B2FC
		btst	#3,$25(a6)
		bne.s	loc_B304
		bra.s	loc_B306
; ---------------------------------------------------------------------------

loc_B2FC:				; CODE XREF: ROM:0000B2F0j
		btst	#3,$25(a6)
		beq.s	loc_B306

loc_B304:				; CODE XREF: ROM:0000B2F8j
		neg.l	d0

loc_B306:				; CODE XREF: ROM:0000B2FAj
					; ROM:0000B302j
		asr.l	#8,d0
		move.w	d0,$2C(a6)
		tst.w	$32(a6)
		bmi.s	loc_B322
		move.b	#2,7(a6)
		move.l	#0,$26(a6)
		rts
; ---------------------------------------------------------------------------

loc_B322:				; CODE XREF: ROM:0000B310j
		move.b	#$12,7(a6)
		rts
; ---------------------------------------------------------------------------
loc_B32A:
		andi.b	#8,obVRAM(a6)
		moveq	#0,d0
		move.w	d0,$2C(a6)
		move.l	d0,$18(a6)
		move.l	d0,obYVel(a6)
		tst.w	$30(a6)
		bne.s	loc_B352
		move.w	#$10,$32(a6)
		move.b	#2,7(a6)
		rts
; ---------------------------------------------------------------------------

loc_B352:				; CODE XREF: ROM:0000B342j
		move.w	#$32,$26(a6) ; '2'
		rts

; =============== S U B	R O U T	I N E =======================================


ObjTails_ThrowPartner:				; CODE XREF: ROM:0000ADC6p
					; ROM:0000AED0p ...
		tst.b	(a5)
		bmi.s	locret_B386
		move.b	3(a5),d0
		andi.b	#$10,d0	; 'p'
		beq.s	locret_B386

	; Tails jump (start)

		move.w	($FFFFFAE0).w,d0
		cmpi.w	#$18,d0
		bcc.s	locret_B386
		move.b	#$A,7(a6)
		bclr	#4,$25(a6)
		andi.b	#$F,2(a5)
		andi.b	#$F,3(a5)

locret_B386:				; CODE XREF: ObjTails_ThrowPartner+8j ObjTails_ThrowPartner+12j
		rts
; End of function ObjTails_ThrowPartner


; =============== S U B	R O U T	I N E =======================================


ObjTails_Jump:				; CODE XREF: ROM:0000ADCAp
		move.b	3(a5),d0
		andi.b	#$20,d0	; 'p'
		beq.s	locret_B3DA
		move.b	#4,7(a6)
		clr.w	$28(a6)
		bclr	#0,$25(a6)
		move.b	obFlags(a6),d2
		jsr	CalcSine
		move.w	d0,d3
		move.w	d1,d4
		btst	#3,$25(a6)
		beq.s	loc_B3B8
		neg.w	d0

loc_B3B8:				; CODE XREF: ObjTails_Jump+2Cj
		move.w	$2C(a6),d2
		muls.w	d2,d0
		muls.w	d2,d1
		move.w	#$700,d2
		muls.w	d2,d3
		muls.w	d2,d4
		add.l	d4,d0
		sub.l	d3,d1
		asr.l	#6,d0
		asr.l	#6,d1
		move.l	d0,$18(a6)
		move.l	d1,obYVel(a6)
		move.b	#$A0,d0
		bsr.w	Play_Sound_2
		rts
; ---------------------------------------------------------------------------

locret_B3DA:				; CODE XREF: ObjTails_Jump+8j
		rts
; End of function ObjTails_Jump


; =============== S U B	R O U T	I N E =======================================


nullsub_3:				; CODE XREF: ROM:loc_ADE2p
					; ROM:loc_B1D6p

		tst.w	$2C(a6)
		bne.s	loc_B3E6

locret_B3E4:				; CODE XREF: ROM:0000B3F4j
		rts
; ---------------------------------------------------------------------------

loc_B3E6:				; CODE XREF: ROM:0000B3E2j
		move.b	obFlags(a6),d0
		move.b	d0,d2
		subi.b	#$20,d0	; ' '
		cmpi.b	#$C0,d0
		bcc.s	locret_B3E4
		jsr	CalcSine
		asr.w	#8,d1
		ext.w	d2
		ext.l	d2
		swap	d2
		move.w	$24(a6),d0
		btst	#3,d0
		beq.s	loc_B40E
		neg.w	d1

loc_B40E:				; CODE XREF: ROM:0000B40Aj
		add.w	d1,$2C(a6)
		rts
; ---------------------------------------------------------------------------