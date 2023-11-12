; ===========================================================================
; ---------------------------------------------------------------------------
; Sonic Crackers
; ---------------------------------------------------------------------------

; Disassembled by: MarkeyJester (DrXInsanity)
; Special thanks to:
; -> Hivebrain (for SCHG sonic crackers location guide on SonicRetro)
; -> Malevolence (for the SST Object defining/labling)
; -> Selbi (for research and labling)
; -> Stealth (for more additional and corrective research)

; ===========================================================================
; ---------------------------------------------------------------------------
; Includes
; ---------------------------------------------------------------------------

Combi	=	1

		include	"Debugger.asm"
		include	"SonCraMacro.asm"
		include	"Constants.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; Sonic Crackers Disassembly
; ---------------------------------------------------------------------------

RomStart:	dc.l	$00FF0200,	EntryPoint
	dc.l BusError		; Bus error
	dc.l AddressError	; Address error (4)
	dc.l IllegalInstr	; Illegal instruction
	dc.l ZeroDivide		; Division by zero
	dc.l ChkInstr		; CHK exception
	dc.l TrapvInstr		; TRAPV exception (8)
	dc.l PrivilegeViol	; Privilege violation
	dc.l Trace			; TRACE exception
	dc.l Line1010Emu	; Line-A emulator
	dc.l Line1111Emu	; Line-F emulator (12)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved) (16)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved) (20)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved) (24)
	dc.l ErrorExcept	; Spurious exception
	dc.l ErrorExcept	; IRQ level 1
	dc.l ErrorExcept	; IRQ level 2
	dc.l ErrorExcept	; IRQ level 3 (28)
	dc.l $FFFFC836			; IRQ level 4 (horizontal retrace interrupt)
	dc.l ErrorExcept	; IRQ level 5
	dc.l $FFFFC830			; IRQ level 6 (vertical retrace interrupt)
	dc.l ErrorExcept	; IRQ level 7 (32)
	dc.l ErrorExcept	; TRAP #00 exception
	dc.l ErrorExcept	; TRAP #01 exception
	dc.l ErrorExcept	; TRAP #02 exception
	dc.l ErrorExcept	; TRAP #03 exception (36)
	dc.l ErrorExcept	; TRAP #04 exception
	dc.l ErrorExcept	; TRAP #05 exception
	dc.l ErrorExcept	; TRAP #06 exception
	dc.l ErrorExcept	; TRAP #07 exception (40)
	dc.l ErrorExcept	; TRAP #08 exception
	dc.l ErrorExcept	; TRAP #09 exception
	dc.l ErrorExcept	; TRAP #10 exception
	dc.l ErrorExcept	; TRAP #11 exception (44)
	dc.l ErrorExcept	; TRAP #12 exception
	dc.l ErrorExcept	; TRAP #13 exception
	dc.l ErrorExcept	; TRAP #14 exception
	dc.l ErrorExcept	; TRAP #15 exception (48)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved) (52)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved) (56)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved) (60)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved)
	dc.l ErrorExcept	; Unused (reserved) (64)
ConsoleName:	dc.b	'SEGA MEGA DRIVE '
ProductDate:	dc.b	'MDTRAVIS AUG2023'
LocalTitle:	dc.b	'SONIC WITHOUT CLACKERS                          '
InterTitle:	dc.b	'SONIC WITHOUT CLACKERS                          '
SerialNo:	dc.b	'GM XXXXXXXX-XX'
Checksum:	dc.w	$0000
IOS:		dc.b	'J               '
ROM_Start:	dc.l	$00000000
ROM_Finish:	dc.l	$001FFFFF
RAM_Start:	dc.l	$00FF0000
RAM_Finish:	dc.l	$00FFFFFF
SRAMSupport:	dc.b	'  ',%00100000,%00100000
SRAM_Start:	dc.l	$20202020
SRAM_Finish:	dc.l	$20202020
ProductNotes:	dc.b	'Sonic', $27, 's clacker privilege has been revoked.         '
RegionsFor:	dc.b	'JUE             '

; ===========================================================================
; ---------------------------------------------------------------------------
; Beginning Entry Point of Game
; ---------------------------------------------------------------------------

EntryPoint:						; Offset: 00000200
		tst.l	($A10008).l				; are controller ports A or B initiated?
		bne.s	Setup_Controls				; if so, branch
		tst.w	($A1000C).l				; is controller port C initiated?

Setup_Controls:						; Offset: 0000020E
		bne.s	Setup_Skip				; if port A, B or C are already initiated, branch to skip setup (Soft reset was hit)
		lea	SetupValues(pc),a5			; load address of setup values array to a5
		movem.w	(a5)+,d5-d7				; load first three words from array to d5, d6 & d7
		movem.l	(a5)+,a0-a4				; load Hardware addresses to a0, a1, a2, a3 & a4
		move.b	-$10FF(a1),d0				; load Hardware version to d0
		andi.b	#$0F,d0					; get only the end nybble
		beq.s	Setup_NoSecurity			; if it's null, branch (Not version 0)
		move.l	#'SEGA',$2F00(a1)			; set SEGA security code

Setup_NoSecurity:					; Offset: 0000022E
		move.w	(a4),d0					; load data from VDP Address port (to check that VDP is working)
		moveq	#0,d0					; clear d0
		movea.l	d0,a6					; move to a6 (Clearing usp must be done from an "An" register)
		move.l	a6,usp					; clear usp (setting to $00000000)
		moveq	#$17,d1					; set repeat times

Setup_VDPRegisters:					; Offset: 00000238
		move.b	(a5)+,d5				; load VDP register setting data (adding to $8000)
		move.w	d5,(a4)					; dump to VDP
		add.w	d7,d5					; add 100 to increase to next register ID
		dbf	d1,Setup_VDPRegisters			; repeat til all $18 registers have been set
		move.l	(a5)+,(a4)				; set VDP to VRam write mode (Misc Stuff)
		move.w	d0,(a3)					; set to $0000 default (Clears screen)
		move.w	d7,(a1)					; request Z80 on (stop Z80)
		move.w	d7,(a2)					; reset Z80 off

Setup_Z80Wait:						; Offset: 0000024A
		btst	d0,(a1)					; has the Z80 stopped yet?
		bne.s	Setup_Z80Wait				; if not, loop til stopped
		moveq	#$25,d2					; set repeat times

Setup_Z80Ram:						; Offset: 00000250
		move.b	(a5)+,(a0)+				; Dump Z80 instruction to Z80 Ram
		dbf	d2,Setup_Z80Ram				; repeat til all Z80 instructions have been dumped
		move.w	d0,(a2)					; reset Z80 on
		move.w	d0,(a1)					; request Z80 off (start Z80)
		move.w	d7,(a2)					; reset Z80 off

Setup_68KRam:						; Offset: 0000025C
		move.l	d0,-(a6)				; clear long-word of 68K Ram
		dbf	d6,Setup_68KRam				; repeat til 68K Ram is cleared
		move.l	(a5)+,(a4)				; set Display and increment register modes
		move.l	(a5)+,(a4)				; set VDP to CRam write mode
		moveq	#$1F,d3					; set repeat times

Setup_VDP_CRam:						; Offset: 00000268
		move.l	d0,(a3)					; clear CRam colour
		dbf	d3,Setup_VDP_CRam			; repeat til CRam is fully cleared
		move.l	(a5)+,(a4)				; set VDP to VSRam write mode
		moveq	#$13,d4					; set repeat times

Setup_VDP_VSRam:					; Offset: 00000272
		move.l	d0,(a3)					; clear VSRam scroll A/B codes
		dbf	d4,Setup_VDP_VSRam			; repeat til VSRam is fully cleared
		moveq	#3,d5					; set repeat times

Setup_PSG:						; Offset: 0000027A
		move.b	(a5)+,$11(a3)				; set PSG reset
		dbf	d5,Setup_PSG				; repeat for all 4 bytes
		move.w	d0,(a2)					; reset Z80 on
		movem.l	(a6),d0-a6				; clear registers from d0 to a6
		move	#$2700,sr				; set the status register (disable interrupts)

Setup_Skip:						; Offset: 0000028C
		bra.s	SoftReset				; continue to the soft reset setup routine

; ===========================================================================
; ---------------------------------------------------------------------------
SetupValues:						; Offset: 0000028E
		dc.w	$8000					; VDP register Start
		dc.w	$3FFF					; Repeat times for clearing 68k ram
		dc.w	$0100					; VDP register Number increase (Also used for Z80 functioning)

		dc.l	$00A00000				; Z80 Ram start
		dc.l	$00A11100				; Z80 Bus port
		dc.l	$00A11200				; Z80 reset port
		dc.l	$00C00000				; VDP Data port
		dc.l	$00C00004				; VDP Address port

		dc.b	$04					; Register 80 [H-Interrupt Off];[H,V Counter On];
		dc.b	$14					; Register 81 [Display Off];[V-Interrupt Off];[DMA On];[V 28 Cell PAL/NTSC Mode];
		dc.b	$30					; Register 82 [Scroll Plane A Map Table VRam address: $C000];
		dc.b	$3C					; Register 83 [Window Plane A Map Table VRam address: $F000];
		dc.b	$07					; Register 84 [Scroll Plane B Map Table VRam address: $E000];
		dc.b	$6C					; Register 85 [Sprite Plane Map Table VRam address: $D800];
		dc.b	$00					; Register 86 [Unknown/Unused Register];
		dc.b	$00					; Register 87 [Backdrop Colour: Palette Line 0/Colour ID 0];
		dc.b	$00					; Register 88 [Unknown/Unused Register];
		dc.b	$00					; Register 89 [Unknown/Unused Register];
		dc.b	$FF					; Register 8A [H-Interrupt Register];
		dc.b	$00					; Register 8B [External Interrupt Off];[V-Scroll: Full];[H-Scroll: Full];[Line: By Cell];
		dc.b	$81					; Register 8C [H-Mode: 40 Cell];[Shadow/Hi-Lighting Off];[Interlace Off];
		dc.b	$37					; Register 8D [Horizontal Scroll Table VRam address: $DC00];
		dc.b	$00					; Register 8E [Unknown/Unused Register];
		dc.b	$01					; Register 8F [Auto Increament: By 1];
		dc.b	$01					; Register 90 [VDP Screen Map Size: Vertical Size 32 Cell/Horizontal Size 64 Cell];
		dc.b	$00					; Register 91 [Window Horizontal Position: 00];
		dc.b	$00					; Register 92 [Window Vertical Position: 00];
		dc.b	$FF					; Register 93 [DMA Transfer Size (Lower Byte XX00)];
		dc.b	$FF					; Register 94 [DMA Transfer Size (Upper Byte 00XX)];
		dc.b	$00					; Register 95 [DMA Transfer Source (Low Byte XXXX00)];
		dc.b	$00					; Register 96 [DMA Transfer Source (Mid Byte XX00XX)];
		dc.b	$80					; Register 97 [DMA Transfer Source (Hi- Byte 00XXXX)];

		dc.l	$40000080				; VDP Misc Stuff

		dc.b	$AF,$01,$D9,$1F,$11,$27,$00,$21,$26,$00	; Z80 Machine Code Instructions
		dc.b	$F9,$77,$ED,$B0,$DD,$E1,$FD,$E1,$ED,$47
		dc.b	$ED,$4F,$D1,$E1,$F1,$08,$D9,$C1,$D1,$E1
		dc.b	$F1,$F9,$F3,$ED,$56,$36,$E9,$E9

		dc.w	$8104					; Display off/V Interupt off/DMA off/V 28 cell (PAL or NTSC)
		dc.w	$8F02					; VDP Increment by 2
		dc.l	$C0000000				; VDP CRam (Colour) address
		dc.l	$40000010				; VDP VSRam (Vertical scroll) address
		dc.b	$9F,$BF,$DF,$FF				; PSG Attenuation (Volume) Reset Values (Sets the volumes to off for all four channels)
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Game Start (Soft Reset)
; ---------------------------------------------------------------------------

SoftReset:						; Offset: 000002FA
		tst.w	($C00004).l				; (it is assumed that this is to check if the VDP works, all Megadrive games seem to do the same)
		lea	($FFFFFFC0).w,a0			; load misc storage location to a0
		move.l	(a0),d0					; load "SEGA" value from storage
		cmpi.l	#'SEGA',d0				; have the misc stuff been cleared yet?
		bne.s	SR_MiscNotCleared			; if not, branch
		move.b	($A10009).l,d0				; load Port A initiation code
		and.b	($A1000B).l,d0				; and Port B initiation code
		and.b	($A1000D).l,d0				; and Extra Port
		btst	#$06,d0					; are all Ports initiated correctly (bit 6 set on all)?
		bne.s	SR_MiscSkipClear			; if so, branch

SR_MiscNotCleared:					; Offset: 00000326
		moveq	#$0F,d0					; set repeat times
		lea	(a0),a1					; load misc storage location to a1

SR_ClearMisc:						; Offset: 0000032A
		clr.l	(a1)+					; clear misc storage data
		dbf	d0,SR_ClearMisc				; repeat til ram (00FFFFC0 to 00FFFFFF) is cleared
		move.l	#'SEGA',(a0)				; set "SEGA" to tell the engine, the misc stuff has been cleared already

SR_MiscSkipClear:					; Offset: 00000336
		moveq	#$00,d0					; clear d0
		moveq	#$00,d1					; clear d1
		moveq	#$00,d2					; clear d2
		moveq	#$00,d3					; clear d3
		moveq	#$00,d4					; clear d4
		moveq	#$00,d5					; clear d5
		moveq	#$00,d6					; clear d6
		movea.w	d0,a2					; clear a2
		move.w	#$07FD,d7				; set repeat times

SR_68KRam:						; Offset: 0000034A
		movem.l	d0-d6/a2,-(a0)				; clear rest of MC68 data
		dbf	d7,SR_68KRam				; repeat til ram (00FF0000 to 00FFFFBF) is cleared
		lea	($FFFFC800).w,a0			; load machine code ram to a0
		move.w	#$4EF9,d0				; move "jmp" instruction code to d0
		lea	Code_rts(pc),a1				; load location of "rts" instruction code to a1
		moveq	#$02,d7					; set repeat times

SR_MachineCodeRTS:					; Offset: 00000360
		move.w	d0,(a0)+				; dump "jmp"
		move.l	a1,(a0)+				; dump location to "rts"
		dbf	d7,SR_MachineCodeRTS			; repeat 2 more times
		lea	Code_rte(pc),a1				; load location of "rte" instruction code to a1
		moveq	#$06,d7					; set repeat times

SR_MachineCodeRTE:					; Offset: 0000036E
		move.w	d0,(a0)+				; dump "jmp"
		move.l	a1,(a0)+				; dump location to "rte"
		dbf	d7,SR_MachineCodeRTE			; repeat 6 more times
		moveq	#$40,d0					; prepare Initiation value
		move.b	d0,($A10009).l				; ...dump to Control Port A
		move.b	d0,($A1000B).l				; ...Control Port B
		move.b	d0,($A1000D).l				; ...and Extra port

SR_WaitVDP:						; Offset: 0000038A
		move.w	($C00004).l,d0				; load value from VDP address port to d0
		btst	#$01,d0					; is VDP busy?
		bne.s	SR_WaitVDP				; if so, recheck
		lea	($C00000).l,a0				; load VDP data port location to a0
		move.w	#$8F02,($C00004).l			; set VDP auto increment on
		move.w	#$8F02,($FFFFC9D6).w			; store VDP register 0F data
		moveq	#$00,d0					; clear d0
		move.l	#$40000000,($C00004).l			; set VDP to V-Ram write mode
		move.w	#$0FFF,d1				; set repeat times

SR_VDP_VRam:						; Offset: 000003BA
		move.l	d0,(a0)					; clear V-Ram
		move.l	d0,(a0)					; ''
		move.l	d0,(a0)					; ''
		move.l	d0,(a0)					; ''
		dbf	d1,SR_VDP_VRam				; repeat til V-Ram is fully cleared
		move.l	#$C0000000,($C00004).l			; set VDP to C-Ram write mode
		move.w	#$0007,d1				; set repeat times

SR_VDP_CRam:						; Offset: 000003D4
		move.l	d0,(a0)					; clear C-Ram
		move.l	d0,(a0)					; ''
		move.l	d0,(a0)					; ''
		move.l	d0,(a0)					; ''
		dbf	d1,SR_VDP_CRam				; repeat til C-Ram is clear
		move.l	#$40000010,($C00004).l			; set VDP to VS-Ram write mode
		move.w	#$0004,d1				; set repeat times

SR_VDP_VSRam:						; Offset: 000003EE
		move.l	d0,(a0)					; clear VS-Ram
		move.l	d0,(a0)					; ''
		move.l	d0,(a0)					; ''
		move.l	d0,(a0)					; ''
		dbf	d1,SR_VDP_VSRam				; repeat til VS-Ram is clear
		lea	SR_VDPRegData(pc),a0			; load VDP register setup values
		jsr	(StoreVDPRegisters).l			; save VDP register data to ram spaces
		move.w	#$0100,($A11200).l			; request Z80 reset (ON)
		move	#$2000,sr				; set the status register

SR_MainProgram:						; Offset: 00000410
		jsr	(MainProg_Loop).w			; run through the Main Program Loop
		bra.s	SR_MainProgram				; loop

; ===========================================================================
; ---------------------------------------------------------------------------	
Code_rte:	dc.w	$4E73 		; Offset: 00000416	; 68K Assembly code 'rte'
Code_rts:	dc.w	$4E75		; Offset: 00000418	; 68K Assembly code 'rts
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to trap the 68K processor in a constant cycle (processing virtually nothing)
; ---------------------------------------------------------------------------

ErrorTrapper:						; Offset: 0000041A
		nop						; Delay
		nop						; Delay
		bra.s	ErrorTrapper				; Loop (Trap in a loop)

; ===========================================================================
; ---------------------------------------------------------------------------
SR_VDPRegData:						; Offset: 00000420
		dc.w	$8004					; [H-Interrupt Off];[H,V Counter On];
		dc.w	$8104					; [Display Off];[V-Interrupt Off];[DMA Off];[V 28 Cell PAL/NTSC Mode];
		dc.w	$8230					; [Scroll Plane A Map Table VRam address: $C000];
		dc.w	$832C					; [Window Plane A Map Table VRam address: $B000];
		dc.w	$8407					; [Scroll Plane B Map Table VRam address: $E000];
		dc.w	$8578					; [Sprite Plane Map Table VRam address: $F000];
		dc.w	$8600					; [Unknown/Unused Register];
		dc.w	$8730					; [Backdrop Colour: Palette Line 3/Colour ID 0];
		dc.w	$8800					; [Unknown/Unused Register];
		dc.w	$8900					; [Unknown/Unused Register];
		dc.w	$8A00					; [H-Interrupt Register];
		dc.w	$8B00					; [External Interrupt Off];[V-Scroll: Full];[H-Scroll: Full];[Line: By Cell];
		dc.w	$8C81					; [H-Mode: 40 Cell];[Shadow/Hi-Lighting Off];[Interlace Off];
		dc.w	$8D34					; [Horizontal Scroll Table VRam address: $D000];
		dc.w	$8E00					; [Unknown/Unused Register];
		dc.w	$8F02					; [Auto Increament: By 2];
		dc.w	$9001					; [VDP Screen Map Size: Vertical Size 32 Cell/Horizontal Size 64 Cell];
		dc.w	$9100					; [Window Horizontal Position: 00];
		dc.w	$9200					; [Window Horizontal Position: 00];
		dc.w	$0000					; Null - (This tells the routine reading this, that it's the end of the table)
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to DMA transfer palette data to C-Ram during game modes
; ---------------------------------------------------------------------------

DMA_MovePalette:					; Offset: 00000448
		move.w	#$0100,($A11100).l			; request Z80 hult (ON)

DMAMP_WaitZ80:						; Offset: 00000450
		btst	#$00,($A11100).l			; has Z80 stopped?
		bne.s	DMAMP_WaitZ80				; if not, recheck
		move.w	#$8F02,($C00004).l			; set VDP auto increment on
		move.w	#$8F02,($FFFFC9D6).w			; store VDP register 0F data
		lea	($C00004).l,a0				; load VDP address port to a0
		ori.w	#$8114,($FFFFC9BA).w			; [Display Off];[V-Interrupt Off];[DMA On];[V 28 Cell PAL/NTSC Mode];
		move.w	($FFFFC9BA).w,(a0)			; set VDP DMA on
		lea	DMAMP_Values(pc),a1			; load DMA values location to a1
		move.w	(a1)+,(a0)				; dump upper size byte
		move.w	(a1),(a0)				; dump lower size byte
		move.w	#$9500,d0				; prepared register ID starting from 95
		lea	DMAMP_Values+$08(pc),a1			; load DMA values location (Starting from "transfer source")to a1
		moveq	#$02,d1					; set repeat times

DMAMP_SetSource:					; Offset: 0000048A
		move.b	-(a1),d0				; load source value from table to d0
		move.w	d0,(a0)					; dump to VDP
		addi.w	#$100,d0				; increase register ID
		dbf	d1,DMAMP_SetSource			; repeat til 95, 96 and 97 registers have been set
		move.w	#$C000,(a0)				; set DMA dump location C-Ram write mode
		move.w	#$0080,-(sp)				; ''
		move.w	(sp)+,(a0)				; ''
		andi.w	#$FFEF,($FFFFC9BA).w			; turn DMA off in VDP register 01's data
		move.w	($FFFFC9BA).w,(a0)			; ...and set that register
		move.w	#$0000,($A11100).l			; request Z80 hult (OFF)
		move.l	#$C0000000,($C00004).l			; set VDP to C-Ram write mode
		move.w	($FFFFD3E4).w,-$04(a0)			; move first colour from menu palette to C-Ram
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
DMAMP_Values:						; Offset: 000004A0
		dc.w	$9340					; [DMA Transfer Size (Lower Byte XX00)];
		dc.w	$9400					; [DMA Transfer Size (Upper Byte 00XX)];
		dc.l	($00FFD3E4/$02)				; [DMA Transfer Source [For Registers 95, 96 & 97];
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to process the DMA cue data, setting the VDP to process all DMA entries
; ---------------------------------------------------------------------------

DMA_ProcessCue:						; Offset: 000004CC
		lea	($C00004).l,a4				; load VDP address port address to a4
		moveq	#$00,d3					; clear d3
		move.w	#$0100,($A11100).l			; request Z80 hult (ON)

DMAPC_WaitZ80:						; Offset: 000004DC
		btst	#$00,($A11100).l			; has Z80 stopped?
		bne.s	DMAPC_WaitZ80				; if not, recheck
		move.w	($FFFFC9BA).w,d0			; load VDP register 01 storage
		bset	#$04,d0					; enable DMA
		move.w	d0,(a4)					; set VDP's register
		move.w	#$8F02,($C00004).l			; set VDP's register [Auto Increament: By 2];
		move.w	#$8F02,($FFFFC9D6).w			; ...and set VDP register 0F storage too
		lea	($FFFFD4F8).w,a1			; load DMA cues address to a1
		move.w	(a1)+,d7				; load number of entries (repeat times)
		bra.s	DMAPC_ReduceDBFCounter			; branch directly to dbf (because it's 1 higher)

DMAPC_NextEntry:					; Offset: 00000506
		lea	DMAPC_Values(pc),a0			; load VDP register ID's address
		movem.w	(a0),d0-d4				; load DMA register ID's to d0, d1, d2, d3 and d4
		addq.l	#$06,a0					; advance to 96 and 97 registers
		move.b	(a1)+,d1				; load size (Upper Byte 00XX)
		move.b	(a1)+,d0				; load size (Lower Byte XX00)
		move.b	(a1)+,d4				; skip a byte in the cue (quickest way to do it)
		move.b	(a1)+,d4				; load source (Hi- Byte 00XXXX)
		move.b	(a1)+,d3				; load source (Mid Byte XX00XX)
		move.b	(a1)+,d2				; load source (Low Byte XXXX00)
		move.w	d0,(a4)					; set DMA size (Lower Byte XX00)
		move.w	d1,(a4)					; set DMA size (Upper Byte 00XX)
		move.w	d2,(a4)					; set DMA source (Low Byte XXXX00)
		move.w	d3,(a4)					; set DMA source (Mid Byte XX00XX)
		move.w	d4,(a4)					; set DMA source (Hi- Byte 00XXXX)
		move.w	(a1)+,(a4)				; set destination (Upper word 0000XXXX)
		move.w	(a1)+,d1				; load destination (Lower word XXXX0000)
		ori.w	#$0080,d1				; set DMA flag onto it
		move.w	d1,-(sp)				; store in the stack
		move.w	(sp)+,(a4)				; set destination (Lower word XXXX0000)

; ---------------------------------------------------------------------------
; This extra small bit saves the first word of art "manually" after DMA is
; set, this is because sometimes the first word of data doesn't always transfer
; ---------------------------------------------------------------------------

		move.l	-(a1),d1				; load destination
		move.w	d1,(a4)					; set destination (Lower word XXXX0000)
		move.l	-(a1),d1				; load source
		lsl.l	#$01,d1					; multiply by 2 (to get real address)
		movea.l	d1,a2					; set address of art to a2
		move.w	(a2),-$04(a4)				; save first 2 bytes to V-Ram manually
		addq.w	#$08,a1					; advance to next cue slot

; ---------------------------------------------------------------------------

DMAPC_ReduceDBFCounter:					; Offset: 00000542
		dbf	d7,DMAPC_NextEntry			; repeat til all entries in the cue are processed
		move.w	($FFFFC9BA).w,d1			; load VDP register 01 storage
		bclr	#$04,d1					; disable DMA
		move.w	d1,(a4)					; set VDP's register
		move.w	#$0000,($A11100).l			; request Z80 hult (OFF)
		clr.w	($FFFFD4F8).w				; reset DMA cues to no entries
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
DMAPC_Values:						; Offset: 0000055E
		dc.w	$9300					; [DMA Transfer Size (Lower Byte XX00)];
		dc.w	$9400					; [DMA Transfer Size (Upper Byte 00XX)];
		dc.w	$9500					; [DMA Transfer Source (Low Byte XXXX00)];
		dc.w	$9600					; [DMA Transfer Source (Mid Byte XX00XX)];
		dc.w	$9700					; [DMA Transfer Source (Hi- Byte 00XXXX)];
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write DMA data to the DMA cues ready for processing
; ---------------------------------------------------------------------------
; d0 = Address of the art itself
; d1 = V-Ram address
; d2 = Number of bytes to transfer (divide by 2)
; ---------------------------------------------------------------------------

DMA_WriteCueEntry:					; Offset: 00000568
		moveq	#$00,d3					; clear d3
		move.w	d2,d3					; load number of bytes (division of 2)
		add.w	d2,d3					; multiply by 2 to get the actual size
		add.l	d0,d3					; add address of art (to get the end of art offset)
		eor.l	d0,d3					; remove the address bits
		btst	#$11,d3					; was the most significant bit of "no of bytes" set?
		beq.s	DMA_WCE_CheckCueSlot			; if not, branch

; ---------------------------------------------------------------------------
; Not exactly sure why, but if the "Number of bytes to transfer" has been set
; to +8000 (i.e. bit set), this routine below is ran instead.
; ---------------------------------------------------------------------------

		eor.l	d0,d3					; restore the address bits
		move.l	d3,d4					; copy to d4
		andi.l	#$FFFE0000,d4				; get only in multiples of 20000 bytes
		move.l	d4,d5					; copy to d5
		sub.l	d0,d4					; subtract the address of art
		move.w	d4,d6					; load the right word of the address d6
		add.w	d1,d6					; add the V-Ram address
		move.w	d4,d2					; load the right word of the address d2
		lsr.w	#$01,d2					; divide by 2
		move.l	d3,d7					; load address + size to d7
		sub.l	d5,d7					; subtract address of multiples of 20000 bytes
		lsr.w	#$01,d7					; divide by 2
		movem.l	d5-d7,-(sp)				; store register data
		bsr.w	DMA_WCE_CheckCueSlot			; write info to DMA cue (if possible)
		movem.l	(sp)+,d5-d7				; restore register data
		move.l	d5,d0					; load source to write
		move.l	d6,d1					; load destination to write
		move.l	d7,d2					; load size to write

; ---------------------------------------------------------------------------

DMA_WCE_CheckCueSlot:					; Offset: 000005A6
		moveq	#$00,d3					; clear d3
		lea	($FFFFD4F8).w,a0			; load DMA cue address
		move.w	(a0)+,d3				; load number of entries already in the cue
		cmpi.w	#$0010,d3				; are there already 10 entries in the list?
		bcs.s	DMA_WCE_FindCueSlot			; if not, branch
		rts						; return (cue is full)

DMA_WCE_FindCueSlot:					; Offset: 000005B6
		moveq	#$00,d4					; clear d4
		move.w	d3,d4					; load number of entries
		bra.s	DMA_WCE_ReduceDBFCounter		; continue

DMA_WCE_NextSlot:					; Offset: 000005BC
		adda.w	#$000A,a0				; increase to next slot

DMA_WCE_ReduceDBFCounter:				; Offset: 000005C0
		dbf	d4,DMA_WCE_NextSlot			; repeat til it's got to the free empty slot
		move.w	d2,(a0)+				; save size (upper and lower bytes are reversed)
		andi.l	#$00FFFFFF,d0				; clear end useless address byte
		lsr.l	#$01,d0					; divide by 2 for DMA
		move.l	d0,(a0)+				; save source
		andi.l	#$0000FFFF,d1				; get V-Ram address
		lsl.l	#$02,d1					; send far left bits to left side
		lsr.w	#$02,d1					; and send the rest back
		ori.w	#$4000,d1				; set V-Ram write mode
		swap	d1					; swap sides
		move.l	d1,(a0)					; save destination
		addq.w	#$01,($FFFFD4F8).w			; increase entry counter
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to set the VDP to DMA transfer any data requested
; ---------------------------------------------------------------------------
; d0 = Source Location (normal)
; d1 = V-Ram Destination (normal)
; d2 = size (divided by 2)
; ---------------------------------------------------------------------------

DMA_WriteData:						; Offset: 000005E8
		moveq	#$00,d3					; clear d3
		move.w	d2,d3					; load number of bytes (division of 2)
		add.w	d2,d3					; multiply by 2 to get the actual size
		add.l	d0,d3					; add address of art (to get the end of art offset)
		eor.l	d0,d3					; remove the address bits
		btst	#$11,d3					; was the most significant bit of "no of bytes" set?
		beq.s	DMAWD_WriteDMA				; if not, branch

; ---------------------------------------------------------------------------
; (Same as above subroutine)
; Not exactly sure why, but if the "Number of bytes to transfer" has been set
; to +8000, this routine below is ran instead.
; ---------------------------------------------------------------------------

		eor.l	d0,d3					; restore the address bits
		move.l	d3,d4					; copy to d4
		andi.l	#$FFFE0000,d4				; get only in multiples of 20000 bytes
		move.l	d4,d5					; copy to d5
		sub.l	d0,d4					; subtract the address of art
		move.w	d4,d6					; load the right word of the address d6
		add.w	d1,d6					; add the V-Ram address
		move.w	d4,d2					; load the right word of the address d2
		lsr.w	#$01,d2					; divide by 2
		move.l	d3,d7					; load address + size to d7
		sub.l	d5,d7					; subtract address of multiples of 20000 bytes
		lsr.w	#$01,d7					; divide by 2
		movem.l	d5-d7,-(sp)				; store register data
		bsr.w	DMAWD_WriteDMA				; write DMA
		movem.l	(sp)+,d5-d7				; restore register data
		move.l	d5,d0					; load source to write
		move.l	d6,d1					; load destination to write
		move.l	d7,d2					; load size to write

DMAWD_WriteDMA:						; Offset: 00000626
		move.l	d0,d6					; store source to d6
		andi.l	#$00FFFFFF,d0				; clear end useless address byte
		lsr.l	#$01,d0					; divide by 2
		move.w	d1,d3					; load destination
		andi.w	#$3FFF,d3				; clear bits were VDP "settings" are stored
		ori.w	#$4000,d3				; set "setting" V-Ram write bit
		rol.w	#$02,d1					; align the cleared bits (part of address)
		andi.w	#$0003,d1				; get only those address bits
		lea	($C00004).l,a0				; load VDP address port address to a0
		move.w	#$0100,($A11100).l			; request Z80 hult (ON)

DMAWD_WaitZ80:						; Offset: 0000064E
		btst	#$00,($A11100).l			; has Z80 stopped?
		bne.s	DMAWD_WaitZ80				; if not, recheck
		move.w	($FFFFC9BA).w,d4			; load VDP register 01 storage
		bset	#$04,d4					; enable DMA
		move.w	d4,(a0)					; set VDP's register
		move.w	#$8F02,($C00004).l			; set VDP's register [Auto Increament: By 2];
		move.w	#$8F02,($FFFFC9D6).w			; ...and set VDP register 0F storage too
		move.w	d2,d4					; load size to d4
		move.w	#$9300,d5				; prepare DMA size reg lower byte
		move.b	d4,d5					; load lower byte
		move.w	d5,(a0)					; save to VDP
		rol.w	#$08,d2					; get upper byte
		move.w	#$9400,d5				; prepare DMA size reg upper byte
		move.b	d2,d5					; load upper byte
		move.w	d5,(a0)					; save to VDP
		move.l	d0,d2					; load source location
		move.w	#$9500,d5				; prepare DMA size reg lower byte
		move.b	d2,d5					; load lower byte
		move.w	d5,(a0)					; save to VDP
		rol.w	#$08,d2					; get mid byte
		move.w	#$9600,d5				; prepare DMA size reg mid byte
		move.b	d2,d5					; load mid byte
		move.w	d5,(a0)					; save to VDP
		swap	d2					; get upper byte
		move.w	#$9700,d5				; prepare DMA size reg upper byte
		move.b	d2,d5					; load upper byte
		move.w	d5,(a0)					; save to VDP
		move.w	d3,(a0)					; save DMA destination to VDP
		move.w	d1,d2					; load second part of destination
		ori.w	#$0080,d2				; set the DMA bit setting
		move.w	d2,-(sp)				; store to the stack
		move.w	(sp)+,(a0)				; reload and save to VDP

; ---------------------------------------------------------------------------
; (Same as two subroutines above)
; This extra small bit saves the first word of data "manually" after DMA is
; set.
; ---------------------------------------------------------------------------

		move.w	d3,(a0)					; save first part destination to VDP
		move.w	d1,(a0)					; save second part of destination
		movea.l	d6,a1					; load data's start address to a1
		move.w	(a1),-$04(a0)				; save first word of data to V-Ram
		move.w	($FFFFC9BA).w,d4			; load VDP register 01 storage
		bclr	#$04,d4					; disable DMA
		move.w	d4,(a0)					; set VDP's register
		move.w	#$0000,($A11100).l			; request Z80 hult (OFF)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to fade a palette to black at the speed of d0
; ---------------------------------------------------------------------------

Pal_FadeBlack:						; Offset: 000006CC
		clr.w	$FFFFD3E4
		moveq	#$15,d4

PFB_FadeFrame:
		bclr	#$7,($FFFFFFC9).w			; set to not run this routine til V-Blank has run

Fade_WaitVB:						; Offset: 000064FE
		tst.b	($FFFFFFC9).w				; is the routine ready to continue?
		bpl.s	Fade_WaitVB				; if not, loop and recheck
		bsr.s	PFB_FadeBuffer
		dbf	d4,	PFB_FadeFrame

PFB_NotFinished:					; Offset: 000006FC
		rts						; return

; ---------------------------------------------------------------------------
; Subroutine to fade a buffer's colours to black once
; ---------------------------------------------------------------------------

PFB_FadeBuffer:							; Offset: 000006FE
		lea	($FFFFD3E4).w,a0			; load palette buffer address
		move.w	#$0040,d0				; set repeat times
	;	adda.w	d0,a0
	;	subq.w	#$01,d0					; subtract 1 (most likely for the dbf instruction)

PFB_NextColour:						; Offset: 00000708
	;	move.w	d2,d0					; copy colour to d0
		bsr.s	PFB_DecreaseColour			; process red
		dbf	d0,PFB_NextColour			; repeat til all colours processed
		rts						; return

; ---------------------------------------------------------------------------
; Subroutine to decrease a single colour nybble
; ---------------------------------------------------------------------------

PFB_DecreaseColour:					; Offset: 0000072C
dered:
		move.w	(a0),d2
		beq.s	next
		move.w	d2,d1
		andi.w	#$E,d1
		beq.s	degreen
		subq.w	#2,(a0)+	; decrease red value
		rts	
; ===========================================================================

degreen:
		move.w	d2,d1
		andi.w	#$E0,d1
		beq.s	deblue
		subi.w	#$20,(a0)+	; decrease green value
		rts	
; ===========================================================================

deblue:
		move.w	d2,d1
		andi.w	#$E00,d1
		beq.s	next
		subi.w	#$200,(a0)+	; decrease blue	value
		rts	
; ===========================================================================

next:
		addq.w	#2,a0
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Unused subroutine to fade palette to white at the speed of d0
; ---------------------------------------------------------------------------

Pal_FadeWhite_Unused:					; Offset: 00000736
		move.b	($FFFFD4E7).w,d1			; load overall delay time
		bne.s	loc_750					; if time has been set, it's already during fade, so branch
		move.b	d0,($FFFFD4E7).w			; set overall delay time
		move.b	d0,($FFFFD4E8).w			; set current frame delay time
		move.b	#$08,($FFFFD4E9).w			; set number of frames to fade for
		move.w	#$000E,($FFFFD4EA).w			; set colour to check (maximum E)

loc_750:						; Offset: 00000750
		subq.b	#$01,($FFFFD4E8).w			; decrease delay time
		beq.s	loc_758					; if finished, branch
		rts						; return (skip a frame of fading)

loc_758:						; Offset: 00000758
		move.b	($FFFFD4E7).w,($FFFFD4E8).w		; reset delay time for next fade
		bsr.s	sub_76E					; process fading
		subq.b	#$01,($FFFFD4E9).w			; decrease frame counter
		bne.s	locret_76C				; if not finished, branch
		move.b	#$00,($FFFFD4E7).w			; clear overall delay time (finished fading)

locret_76C:						; Offset: 0000076C
		rts						; return

; ---------------------------------------------------------------------------
; Subroutine to fade a buffer's colours to white once
; ---------------------------------------------------------------------------

sub_76E:						; Offset: 0000076E
		lea	($FFFFD3E4).w,a0			; load palette buffer address
		lea	($FFFFD464).w,a1			
		move.w	($FFFFD4EA).w,d2
		move.w	#$003F,d7

loc_77E:						; Offset: 0000077E
		move.w	(a1)+,d0
		move.w	d0,d1
		andi.w	#$000F,d1
		cmp.w	d2,d1
		bls.s	loc_78C
		addq.w	#$02,(a0)

loc_78C:						; Offset: 0000078C
		move.w	d2,d3
		lsl.w	#$04,d3
		move.w	d0,d1
		andi.w	#$00F0,d1
		cmp.w	d3,d1
		bls.s	loc_79E
		addi.w	#$0020,(a0)

loc_79E:						; Offset: 0000079E
		move.w	d0,d1
		move.w	d2,d3
		lsl.w	#$08,d3
		andi.w	#$0F00,d1
		cmp.w	d3,d1
		bls.s	loc_7B0
		addi.w	#$0200,(a0)

loc_7B0:						; Offset: 000007B0
		adda.l	#$00000002,a0
		dbf	d7,loc_77E
		subq.w	#$02,($FFFFD4EA).w
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Unused subroutine to fade the palettes in some form (have to find out how)
; ---------------------------------------------------------------------------

		move.b	($FFFFD4EC).w,d2
		bne.s	loc_7DC
		move.b	d0,($FFFFD4EC).w
		move.b	d0,($FFFFD4ED).w
		subq.b	#1,d1
		move.b	d1,($FFFFD4EE).w
		move.l	a1,($FFFFD4F0).w
		move.l	a2,($FFFFD4F4).w

loc_7DC:						; Offset: 000007DC
		subq.b	#1,($FFFFD4ED).w
		bne.s	locret_7EC
		move.b	($FFFFD4EC).w,($FFFFD4ED).w
		bsr.w	sub_7EE

locret_7EC:						; Offset: 000007EC
		rts

sub_7EE:						; Offset: 000007EE
		movea.l	($FFFFD4F0).w,a1
		movea.l	($FFFFD4F4).w,a2
		moveq	#0,d6
		move.b	($FFFFD4EE).w,d6
		moveq	#0,d7

loc_7FE:						; Offset: 000007FE
		moveq	#0,d5
		move.w	(a1)+,d0
		move.w	(a2),d1
		move.w	#$200,d4
		move.w	d0,d2
		move.w	d1,d3
		andi.w	#$F00,d2
		andi.w	#$F00,d3
		cmp.w	d2,d3
		beq.s	loc_820
		bcs.s	loc_81C
		neg.w	d4

loc_81C:						; Offset: 0000081C
		add.w	d4,d3
		addq.w	#1,d7

loc_820:						; Offset: 00000820
		or.w	d3,d5
		move.w	#$20,d4
		move.w	d0,d2
		move.w	d1,d3
		andi.w	#$F0,d2
		andi.w	#$F0,d3
		cmp.w	d2,d3
		beq.s	loc_83E
		bcs.s	loc_83A
		neg.w	d4

loc_83A:						; Offset: 0000083A
		add.w	d4,d3
		addq.w	#1,d7

loc_83E:						; Offset: 0000083E
		or.w	d3,d5
		move.w	#2,d4
		move.w	d0,d2
		move.w	d1,d3
		andi.w	#$F,d2
		andi.w	#$F,d3
		cmp.w	d2,d3
		beq.s	loc_85C
		bcs.s	loc_858
		neg.w	d4

loc_858:						; Offset: 00000858
		add.w	d4,d3
		addq.w	#1,d7

loc_85C:						; Offset: 0000085C
		or.w	d3,d5
		move.w	d5,(a2)+
		dbf	d6,loc_7FE
		tst.w	d7
		bne.s	locret_86C
		clr.b	($FFFFD4EC).w

locret_86C:						; Offset: 0000086C
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to map a single value to a screen plane in V-Ram
; ---------------------------------------------------------------------------
; d0 = columns
; d1 = rows
; d2 = single value to dump
; d3 = VRam location to dump the value to
; ---------------------------------------------------------------------------

MapScreenSingle:					; Offset: 0000086E
		lea	($C00000).l,a1				; load VDP data port to a1
		moveq	#$00,d6					; clear d6
		move.w	($FFFFD820).w,d6			; load number of tiles to increase to for each set of columns to d6
		swap	d6					; swap words (Sets it to left for long-word amount)
		subq.w	#$01,d0					; decrease number of columns by 1
		subq.w	#$01,d1					; decrease number of rows by 1
		lsl.l	#$02,d3					; send far left bits to left side
		lsr.w	#$02,d3					; and send the rest back
		ori.w	#$4000,d3				; set V-Ram write mode (Map location)
		swap	d3					; swap sides
		andi.w	#$0003,d3				; clear all except the V-Ram location bits

MSS_RepeatRows:						; Offset: 0000088E
		move.l	d3,4(a1)				; set VDP to V-Ram write mode with location
		move.w	d0,d5					; load number of columns to d5

MSS_RepeatCols:						; Offset: 00000894
		move.w	d2,(a1)					; dump single value to V-Ram
		dbf	d5,MSS_RepeatCols			; repeat til all columns are done
		add.l	d6,d3					; increase to next map line
		dbf	d1,MSS_RepeatRows			; repeat til all rows are are
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to map tiles to a screen plane in V-Ram
; ---------------------------------------------------------------------------
; d0 = V-Ram location (Arranged)
; d1 = number of columns
; d2 = number of rows
; d3 = value to add to data
; a1 = location of data to be dumped
; ---------------------------------------------------------------------------

MapScreen:						; Offset: 000008A2
		lea	($C00000).l,a0				; load VDP data port to a0
		moveq	#$00,d6					; clear d6
		move.w	($FFFFD820).w,d6			; load number of tiles to increase to for each set of columns to d6
		swap	d6					; swap words (Sets it to left for long-word amount)

MS_RepeatRows:						; Offset: 000008B0
		move.l	d0,4(a0)				; set to VDP register
		move.w	d1,d5					; load number of columns to d5

MS_RepeatCols:						; Offset: 000008B6
		move.w	(a1)+,d4				; load map
		add.w	d3,d4					; add colour/plane/flip (Render Flag)
		move.w	d4,(a0)					; dump to VRam
		dbf	d5,MS_RepeatCols			; repeat til columns are dumped
		add.l	d6,d0					; increase VRam location for next set of columns
		dbf	d2,MS_RepeatRows			; repeat til all rows are dumped
		cmp.w	d0,d0					; ?? Probably left in by accident
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Sets the C (Carry) flag (Answer is true).
; NOTE: You'll find quite a few of these, I'm assuming they were used
; temporarily for testing while these routines were being written.
; ---------------------------------------------------------------------------
		ori	#1,ccr
		rts
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to store all VDP register data to specific ram spaces
; ---------------------------------------------------------------------------

StoreVDPRegisters:					; Offset: 000008D0
		lea	($FFFFC9B8).w,a1			; load VDP register storage ram

SVR_CheckNext:						; Offset: 000008D4
		move.w	(a0),d0					; load register data from table
		beq.s	SVR_CalcLocation			; if it's null, branch finish table
		moveq	#$7F,d1					; prepare 7F in d1
		and.b	(a0),d1					; keep all bits of register number (except the 7th)
		cmpi.b	#$13,d1					; is this register 13 or higher (DMA register)?
		bge.s	SVR_SkipDMA				; if so, branch
		add.w	d1,d1					; multiply by 2
		move.w	(a0),(a1,d1.w)				; save register data to correct storage area in ram
		move.w	(a0)+,($C00004).l			; ...and dump it to the VDP
		bra.s	SVR_CheckNext				; loop

SVR_SkipDMA:						; Offset: 000008F0
		addq.w	#$02,a0					; skip DMA register
		bra.s	SVR_CheckNext				; loop

; ===========================================================================
; ---------------------------------------------------------------------------
; Sets the C (Carry) flag (Answer is true).
; ---------------------------------------------------------------------------
		ori	#1,ccr
		rts
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; This routine calculates the correct V-Ram locations using the register data
; and then saves the locations to ram.
; ---------------------------------------------------------------------------

SVR_CalcLocation:					; Offset: 000008FA
		lea	$04(a1),a1				; load location of VDP register 02 to a1
		move.w	(a1)+,d0				; load "Scroll Plane A Map Table VRam address" register
		lsl.w	#2,d0					; multiply by...
		lsl.w	#8,d0					; ...400
		move.w	d0,($FFFFD816).w			; save to ram
		move.w	(a1)+,d0				; load "Window Plane A Map Table VRam address" register
		lsl.w	#2,d0					; multiply by...
		lsl.w	#8,d0					; ...400
		move.w	d0,($FFFFD81E).w			; save to ram
		move.w	(a1)+,d0				; load "Scroll Plane B Map Table VRam address" register
		lsl.w	#5,d0					; multiply by...
		lsl.w	#8,d0					; ...2000
		move.w	d0,($FFFFD818).w			; save to ram
		move.w	(a1),d0					; load "Sprite Plane Map Table VRam address" register
		lsl.w	#1,d0					; multiply by...
		lsl.w	#8,d0					; ...200
		move.w	d0,($FFFFD81A).w			; save to ram
		move.w	($FFFFC9D2).w,d0			; load "Horizontal Scroll Table VRam address" register
		lsl.w	#2,d0					; multiply by...
		lsl.w	#8,d0					; ,,,400
		move.w	d0,($FFFFD81C).w			; save to ram
		cmp.w	d0,d0					; ?? Probably left in by accident
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Unused Subroutine to initiate the control ports (As this is done during the
; soft reset routines, it is not needed as a subroutine at any time)
; ---------------------------------------------------------------------------

ControlInit_Unused:					; Offset: 00000936
		move.b	#$01,($A11200).l			; request Z80 reset (ON)
		move.w	#$0100,($A11100).l			; request Z80 hult (ON)

CI_WaitZ80:						; Offset: 00000946
		btst	#$00,($A11100).l			; has the Z80 stopped?
		bne.s	CI_WaitZ80				; if not, loop til stopped
		moveq	#$40,d0					; prepare Initiation value
		move.b	d0,($A10009).l				; ...dump to Control Port A
		move.b	d0,($A1000B).l				; ...Control Port B
		move.b	d0,($A1000D).l				; ...and Extra port
		move.w	#$0000,($A11100).l			; request Z80 hult (OFF)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to get the buttons being pressed from the control ports and
; dumping them to ram
; ---------------------------------------------------------------------------

GetControls:						; Offset: 0000096E
		lea	($FFFFC93C).w,a0 ; address where joypad states are written
		lea	($A10003).l,a1	; first	joypad port
		bsr.s	@read		; do the first joypad
		addq.w	#2,a1		; do the second	joypad

	@read:
		move.b	#0,(a1)
		nop	
		nop	
		move.b	(a1),d0
		lsl.b	#2,d0
		andi.b	#$C0,d0
		move.b	#$40,(a1)
		nop	
		nop	
		move.b	(a1),d1
		andi.b	#$3F,d1
		or.b	d1,d0
		not.b	d0
		move.b	(a0),d1
		eor.b	d0,d1
		move.b	d0,(a0)+
		and.b	d0,d1
		move.b	d1,(a0)+
		rts	

; ===========================================================================
; ---------------------------------------------------------------------------
; Control list - each entry is a different controller type (3 button, 6 button, mouse, etc)
; ---------------------------------------------------------------------------
loc_9E6:	nop
		rts
; ---------------------------------------------------------------------------
		bra.w	loc_A5A

; ---------------------------------------------------------------------------
		nop
		rts
; ---------------------------------------------------------------------------
		bra.w	loc_C70

; ---------------------------------------------------------------------------
		nop
		rts
; ---------------------------------------------------------------------------
		nop
		rts
; ---------------------------------------------------------------------------
		bra.w	loc_B30

; ---------------------------------------------------------------------------
		bra.w	loc_BBA

; ---------------------------------------------------------------------------
; ===========================================================================

sub_A06:
		move.w	#$100,($A11100).l		; stop the Z80
		move.b	#$40,6(a0)
		move.b	#$40,(a0)
		moveq	#0,d0
		moveq	#0,d1
		moveq	#$F,d2
		nop
		move.b	(a0),d1
		and.b	d1,d2
		swap	d1
		or.b	byte_A4A(pc,d2.w),d0
		move.b	#0,(a0)
		lsl.w	#2,d0
		moveq	#$F,d2
		nop
		move.b	(a0),d1
		and.b	d1,d2
		or.b	byte_A4A(pc,d2.w),d0
		move.b	#$40,(a0)
		move.w	#0,($A11100).l
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
byte_A4A:	dc.b $00,$01,$01,$01
		dc.b $02,$03,$03,$03
		dc.b $02,$03,$03,$03
		dc.b $02,$03,$03,$03
; ---------------------------------------------------------------------------
; ===========================================================================

loc_A5A:
		move.b  #2,0(a1)
		move.w	#$FF,d7
		move.w	#$100,($A11100).l
		move.b	#$60,6(a0)
		move.b	#$20,(a0)
		btst	#4,(a0)
		beq.s	loc_AAC
		bsr.w	sub_C48
		bcs.w	loc_AAC
		moveq	#0,d6
		bsr.w	sub_C2E
		bcs.w	loc_AAC
		bsr.w	sub_ACA
		move.b	#$60,(a0)

loc_A96:
		btst	#4,(a0)
		dbne	d7,loc_A96
		beq.w	loc_C62
		move.w	#0,($A11100).l
		rts

loc_AAC:
		lea	$10(a1),a1
		move.b	#$60,(a0)

loc_AB4:
		btst	#4,(a0)
		dbne	d7,loc_AB4
		beq.w	loc_C62
		move.w	#0,($A11100).l
		rts

sub_ACA:
		bsr.w	sub_C2E
		bcs.w	loc_C5C
		andi.w	#$F,d0
		move.b	d0,1(a1)
		bsr.w	sub_C2E
		bcs.w	loc_C5C
		andi.w	#$F,d0
		move.b	d0,2(a1)
		bsr.w	sub_C2E
		bcs.w	loc_C5C
		andi.w	#$F,d0
		move.b	d0,3(a1)
		bsr.w	sub_C2E
		bcs.w	loc_C5C
		andi.w	#$F,d0
		move.b	d0,4(a1)
		bsr.w	sub_C2E
		bcs.w	loc_C5C
		andi.w	#$F,d0
		move.b	d0,5(a1)
		bsr.w	sub_C2E
		bcs.w	loc_C5C
		andi.w	#$F,d0
		move.b	d0,6(a1)
		lea	$10(a1),a1
		rts

; ===========================================================================

loc_B30:
		move.w	#$100,($A11100).l			; stop the Z80
		move.b	#$40,6(a0)
		moveq	#2,d3

loc_B40:
		move.l	d1,d0
		andi.b	#$F,d0
		beq.s	loc_B6E
		move.b	#$40,(a0)
		moveq	#0,d1
		nop
		nop
		nop
		move.b	(a0),d1
		move.b	#0,(a0)
		swap	d1
		nop
		nop
		nop
		move.b  0(a0),d1
		dbf	d3,loc_B40
		bra.w	loc_BDA

loc_B6E:
		move.b	#$40,(a0)
		moveq	#0,d2
		move.b  0(a0),d2
		move.b	#0,(a0)
		swap	d2
		move.b  0(a0),d2
		move.w	#0,($A11100).l
		move.b  #1,0(a1)
		move.w	d1,d0
		swap	d1
		asl.b	#2,d0
		andi.w	#$C0,d0
		andi.w	#$3F,d1
		or.b	d1,d0
		not.b	d0
		bsr.w	sub_C0A
		swap	d2
		move.w	d2,d0
		not.b	d0
		andi.w	#$F,d0
		bsr.w	sub_C1C
		lea	$10(a1),a1
		rts

loc_BBA:
		move.b  #$F,0(a1)
		clr.b	1(a1)
		clr.w	2(a1)
		clr.l	4(a1)
		clr.l	8(a1)
		clr.l	$C(a1)
		lea	$10(a1),a1
		rts

loc_BDA:
		clr.b	  0(a1)
		move.b	#$40,6(a0)
		move.w	d1,d0
		swap	d1
		move.b	#$40,(a0)
		move.w	#0,($A11100).l
		asl.b	#2,d0
		andi.w	#$C0,d0
		andi.w	#$3F,d1
		or.b	d1,d0
		not.b	d0
		bsr.s	sub_C0A
		lea	$10(a1),a1
		rts


sub_C0A:
		move.b	4(a1),d1
		eor.b	d0,d1
		move.b	d0,4(a1)
		and.b	d0,d1
		move.b	d1,5(a1)
		rts

sub_C1C:
		move.b	3(a1),d1
		eor.b	d0,d1
		move.b	d0,3(a1)
		and.b	d0,d1
		move.b	d1,6(a1)
		rts

sub_C2E:
		bchg	#0,d6
		bne.s	sub_C48

loc_C34:
		move.b	#$20,(a0)

loc_C38:
		move.b	(a0),d0
		btst	#4,d0
		dbne	d7,loc_C38
		beq.s	loc_C5C
		move.b	(a0),d0
		rts

sub_C48:
		move.b	#0,(a0)

loc_C4C:
		move.b	(a0),d0
		btst	#4,d0
		dbeq	d7,loc_C4C
		bne.s	loc_C5C
		move.b	(a0),d0
		rts

loc_C5C:
		ori	#1,ccr
		rts

loc_C62:
		move.w	#0,($A11100).l
		ori	#1,ccr
		rts

; ===========================================================================

loc_C70:
		move.w	#$100,($A11100).l
		move.b	#$20,(a0)
		move.b	#$60,6(a0)
		move.w	#$FF,d7
		btst	#4,(a0)
		beq.w	loc_D10
		bsr.s	sub_C48
		bcs.w	loc_D10
		andi.b	#$F,d0
		bsr.s	loc_C34
		bcs.w	loc_D10
		andi.b	#$F,d0
		bsr.s	sub_C48
		bcs.w	loc_D10
		andi.b	#$F,d0
		move.b  d0,0(a1)
		bsr.s	loc_C34
		bcs.w	loc_D10
		andi.b	#$F,d0
		move.b	d0,$10(a1)
		bsr.s	sub_C48
		bcs.w	loc_D10
		andi.b	#$F,d0
		move.b	d0,$20(a1)
		moveq	#0,d6
		bsr.w	sub_C2E
		bcs.w	loc_D10
		andi.b	#$F,d0
		move.b	d0,$30(a1)
		bsr.s	sub_D3A
		bcs.w	loc_D10
		bsr.s	sub_D3A
		bcs.w	loc_D14
		bsr.s	sub_D3A
		bcs.w	loc_D18
		bsr.s	sub_D3A
		bcs.w	loc_D1C
		move.b	#$60,(a0)

loc_CFA:
		btst	#4,(a0)
		dbne	d7,loc_CFA
		beq.w	loc_C62
		move.w	#0,($A11100).l
		rts

loc_D10:
		lea	$10(a1),a1

loc_D14:
		lea	$10(a1),a1

loc_D18:
		lea	$10(a1),a1

loc_D1C:
		lea	$10(a1),a1
		move.b	#$60,(a0)

loc_D24:
		btst	#4,(a0)
		dbne	d7,loc_D24
		beq.w	loc_C62
		move.w	#0,($A11100).l
		rts

sub_D3A:
		moveq	#0,d0
		move.b	(a1),d0
		cmpi.b	#2,d0
		bhi.s	loc_D58
		add.w	d0,d0
		add.w	d0,d0
		jmp	loc_D4C(pc,d0.w)

; ===========================================================================
; ---------------------------------------------------------------------------
loc_D4C:	bra.w	loc_D98
		bra.w	loc_D72
		bra.w	sub_ACA
; ---------------------------------------------------------------------------
; ===========================================================================

loc_D58:
		clr.b	1(a1)
		clr.w	2(a1)
		clr.l	4(a1)
		clr.l	8(a1)
		clr.l	$C(a1)
		lea	$10(a1),a1
		rts

; ===========================================================================

loc_D72:
		bsr.w	sub_DAA
		bsr.w	sub_C2E
		bcs.w	loc_C5C
		not.b	d0
		andi.w	#$F,d0
		move.b	d0,d2
		move.b	d1,d0
		bsr.w	sub_C0A
		move.b	d2,d0
		bsr.w	sub_C1C
		lea	$10(a1),a1
		rts

loc_D98:
		bsr.s	sub_DAA
		bcs.w	loc_C5C
		move.b	d1,d0
		bsr.w	sub_C0A
		lea	$10(a1),a1
		rts

sub_DAA:
		bsr.w	sub_C2E
		bcs.w	loc_C5C
		andi.w	#$F,d0
		move.w	d0,d1
		bsr.w	sub_C2E
		bcs.w	loc_C5C
		asl.w	#4,d0
		or.b	d0,d1
		not.b	d1
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Nemesis Decompression Algorithm
; ---------------------------------------------------------------------------

NemDec:
		lea	loc_E76(pc),a3
		lea	($C00000).l,a4
		bra.s	loc_DD8

NemDec_Ram:						; Offset: 00000DD4
		lea	loc_E8C(pc),a3

loc_DD8:
		lea	($FFFFD59A).w,a1
		move.w	(a0)+,d2
		lsl.w	#1,d2
		bcc.s	loc_DE6
		adda.w	#$A,a3

loc_DE6:
		lsl.w	#2,d2
		movea.w	d2,a5
		moveq	#8,d3
		moveq	#0,d2
		moveq	#0,d4
		bsr.w	sub_EA2
		move.b	(a0)+,d5
		asl.w	#8,d5
		move.b	(a0)+,d5
		move.w	#$10,d6

loc_DFE:
		move.w	d6,d7
		subq.w	#8,d7
		move.w	d5,d1
		lsr.w	d7,d1
		cmpi.b	#$FC,d1
		bcc.s	loc_E4A
		andi.w	#$FF,d1
		add.w	d1,d1
		move.b	(a1,d1.w),d0
		ext.w	d0
		sub.w	d0,d6
		cmpi.w	#9,d6
		bcc.s	loc_E26
		addq.w	#8,d6
		asl.w	#8,d5
		move.b	(a0)+,d5

loc_E26:
		move.b	1(a1,d1.w),d1
		move.w	d1,d0
		andi.w	#$F,d1
		andi.w	#$F0,d0

loc_E34:
		lsr.w	#4,d0

loc_E36:
		lsl.l	#4,d4
		or.b	d1,d4
		subq.w	#1,d3
		bne.s	loc_E44
		jmp	(a3)

sub_E40:
		moveq	#0,d4
		moveq	#8,d3

loc_E44:
		dbf	d0,loc_E36
		bra.s	loc_DFE

loc_E4A:
		subq.w	#6,d6
		cmpi.w	#9,d6
		bcc.s	loc_E58
		addq.w	#8,d6
		asl.w	#8,d5
		move.b	(a0)+,d5

loc_E58:
		subq.w	#7,d6
		move.w	d5,d1
		lsr.w	d6,d1
		move.w	d1,d0
		andi.w	#$F,d1
		andi.w	#$70,d0
		cmpi.w	#9,d6
		bcc.s	loc_E34
		addq.w	#8,d6
		asl.w	#8,d5
		move.b	(a0)+,d5
		bra.s	loc_E34

loc_E76:
		move.l	d4,(a4)
		subq.w	#1,a5
		move.w	a5,d4
		bne.s	sub_E40
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Unused in Nemesis Decompression Algorithm
		eor.l	d4,d2
		move.l	d2,(a4)
		subq.w	#1,a5
		move.w	a5,d4
		bne.s	sub_E40
		rts
; ---------------------------------------------------------------------------
; ===========================================================================

loc_E8C:
		move.l	d4,(a4)+
		subq.w	#1,a5
		move.w	a5,d4
		bne.s	sub_E40
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Unused in Nemesis Decompression Algorithm
		eor.l	d4,d2
		move.l	d2,(a4)+
		subq.w	#1,a5
		move.w	a5,d4
		bne.s	sub_E40
		rts
; ---------------------------------------------------------------------------
; ===========================================================================

sub_EA2:
		move.b	(a0)+,d0

loc_EA4:
		cmpi.b	#$FF,d0
		bne.s	loc_EAC
		rts

loc_EAC:
		move.w	d0,d7

loc_EAE:
		move.b	(a0)+,d0
		cmpi.b	#$80,d0
		bcc.s	loc_EA4
		move.b	d0,d1
		andi.w	#$F,d7
		andi.w	#$70,d1
		or.w	d1,d7
		andi.w	#$F,d0
		move.b	d0,d1
		lsl.w	#8,d1
		or.w	d1,d7
		moveq	#8,d1
		sub.w	d0,d1
		bne.s	loc_EDC
		move.b	(a0)+,d0
		add.w	d0,d0
		move.w	d7,(a1,d0.w)
		bra.s	loc_EAE

loc_EDC:
		move.b	(a0)+,d0
		lsl.w	d1,d0
		add.w	d0,d0
		moveq	#1,d5
		lsl.w	d1,d5
		subq.w	#1,d5

loc_EE8:
		move.w	d7,(a1,d0.w)
		addq.w	#2,d0
		dbf	d5,loc_EE8
		bra.s	loc_EAE

; ===========================================================================
; ---------------------------------------------------------------------------
; Unused subroutine
; ---------------------------------------------------------------------------

		lea	($FFFFD79A).w,a1

loc_EF8:
		tst.l	(a1)
		beq.s	loc_F00
		addq.w	#6,a1
		bra.s	loc_EF8

loc_F00:
		move.w	(a0)+,d0
		bmi.s	locret_F0C

loc_F04:
		move.l	(a0)+,(a1)+
		move.w	(a0)+,(a1)+
		dbf	d0,loc_F04

locret_F0C:
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Unused subroutine
; ---------------------------------------------------------------------------

		bsr.s	sub_F22
		lea	($FFFFD79A).w,a1
		move.w	(a0)+,d0
		bmi.s	locret_F20

loc_F18:
		move.l	(a0)+,(a1)+
		move.w	(a0)+,(a1)+
		dbf	d0,loc_F18

locret_F20:
		rts

sub_F22:
		lea	($FFFFD79A).w,a1
		moveq	#$F,d0

loc_F28:
		clr.l	(a1)+
		clr.w	(a1)+
		dbf	d0,loc_F28
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Unused subroutine
; ---------------------------------------------------------------------------

		tst.l	($FFFFD79A).w
		beq.s	locret_F84
		tst.w	($FFFFD812).w
		bne.s	locret_F84
		movea.l	($FFFFD79A).w,a0
		lea	loc_E76(pc),a3
		lea	($FFFFD59A).w,a1
		move.w	(a0)+,d2
		bpl.s	loc_F52
		adda.w	#$A,a3

loc_F52:
		andi.w	#$7FFF,d2
		move.w	d2,($FFFFD812).w
		bsr.w	sub_EA2
		move.b	(a0)+,d5
		asl.w	#8,d5
		move.b	(a0)+,d5
		moveq	#$10,d6
		moveq	#0,d0
		move.l	a0,($FFFFD79A).w
		move.l	a3,($FFFFD80E).w
		move.l	d0,($FFFFD7FA).w
		move.l	d0,($FFFFD7FE).w
		move.l	d0,($FFFFD802).w
		move.l	d5,($FFFFD806).w
		move.l	d6,($FFFFD80A).w

locret_F84:
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Unused subroutine
; ---------------------------------------------------------------------------

		tst.w	($FFFFD812).w
		beq.w	locret_101E
		move.w	#6,($FFFFD814).w
		moveq	#0,d0
		move.w	($FFFFD79E).w,d0
		addi.w	#$C0,($FFFFD79E).w
		bra.s	loc_FBA

; ===========================================================================
; ---------------------------------------------------------------------------
; Unused subroutine to decompress and use art from Pattern Load Cues
; ---------------------------------------------------------------------------

		tst.w	($FFFFD812).w
		beq.s	locret_101E
		move.w	#3,($FFFFD814).w
		moveq	#0,d0
		move.w	($FFFFD79E).w,d0
		addi.w	#$60,($FFFFD79E).w

loc_FBA:
		lea	($C00004).l,a4
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0
		move.l	d0,(a4)
		subq.w	#4,a4
		movea.l	($FFFFD79A).w,a0
		move.l	($FFFFD7FA).w,d0
		move.l	($FFFFD7FE).w,d1
		move.l	($FFFFD802).w,d2
		move.l	($FFFFD806).w,d5
		move.l	($FFFFD80A).w,d6
		movea.l	($FFFFD80E).w,a3
		lea	($FFFFD59A).w,a1

loc_FEE:
		movea.w	#8,a5
		bsr.w	sub_E40
		subq.w	#1,($FFFFD812).w
		beq.s	loc_1020
		subq.w	#1,($FFFFD814).w
		bne.s	loc_FEE
		move.l	a0,($FFFFD79A).w
		move.l	d0,($FFFFD7FA).w
		move.l	d1,($FFFFD7FE).w
		move.l	d2,($FFFFD802).w
		move.l	d5,($FFFFD806).w
		move.l	d6,($FFFFD80A).w
		move.l	a3,($FFFFD80E).w

locret_101E:
		rts

loc_1020:
		lea	($FFFFD79A).w,a0
		moveq	#$15,d0

loc_1026:
		move.l	6(a0),(a0)+
		dbf	d0,loc_1026
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Unused subroutine to run Pattern Load Cues
; ---------------------------------------------------------------------------

		lea	(a0),a1
		move.w	(a1)+,d1

loc_1034:
		movea.l	(a1)+,a0
		moveq	#0,d0
		move.w	(a1)+,d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0
		move.l	d0,($C00004).l
		movem.l	d1/a1,-(sp)
		bsr.w	NemDec
		movem.l	(sp)+,d1/a1
		dbf	d1,loc_1034
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Enigma Decompression Algorithm
; ---------------------------------------------------------------------------

EniDec:
		movea.w	d0,a3
		move.b	(a0)+,d0
		ext.w	d0
		movea.w	d0,a5
		move.b	(a0)+,d4
		lsl.b	#3,d4
		movea.w	(a0)+,a2
		adda.w	a3,a2
		movea.w	(a0)+,a4
		adda.w	a3,a4
		move.b	(a0)+,d5
		asl.w	#8,d5
		move.b	(a0)+,d5
		moveq	#$10,d6

loc_1078:
		moveq	#7,d0
		move.w	d6,d7
		sub.w	d0,d7
		move.w	d5,d1
		lsr.w	d7,d1
		andi.w	#$7F,d1
		move.w	d1,d2
		cmpi.w	#$40,d1
		bcc.s	loc_1092
		moveq	#6,d0
		lsr.w	#1,d2

loc_1092:
		bsr.w	sub_11C2
		andi.w	#$F,d2
		lsr.w	#4,d1
		add.w	d1,d1
		jmp	loc_10EE(pc,d1.w)

loc_10A2:
		move.w	a2,(a1)+
		addq.w	#1,a2
		dbf	d2,loc_10A2
		bra.s	loc_1078

loc_10AC:
		move.w	a4,(a1)+
		dbf	d2,loc_10AC
		bra.s	loc_1078

loc_10B4:
		bsr.w	sub_1112

loc_10B8:
		move.w	d1,(a1)+
		dbf	d2,loc_10B8
		bra.s	loc_1078

loc_10C0:
		bsr.w	sub_1112

loc_10C4:
		move.w	d1,(a1)+
		addq.w	#1,d1
		dbf	d2,loc_10C4
		bra.s	loc_1078

loc_10CE:
		bsr.w	sub_1112

loc_10D2:
		move.w	d1,(a1)+
		subq.w	#1,d1
		dbf	d2,loc_10D2
		bra.s	loc_1078

loc_10DC:
		cmpi.w	#$F,d2
		beq.s	loc_10FE

loc_10E2:
		bsr.w	sub_1112
		move.w	d1,(a1)+
		dbf	d2,loc_10E2
		bra.s	loc_1078

; ===========================================================================
; ---------------------------------------------------------------------------
; Index array table for Enigma Decompression
; ---------------------------------------------------------------------------

loc_10EE:
		bra.s	loc_10A2
; ---------------------------------------------------------------------------
		bra.s	loc_10A2
; ---------------------------------------------------------------------------
		bra.s	loc_10AC
; ---------------------------------------------------------------------------
		bra.s	loc_10AC
; ---------------------------------------------------------------------------
		bra.s	loc_10B4
; ---------------------------------------------------------------------------
		bra.s	loc_10C0
; ---------------------------------------------------------------------------
		bra.s	loc_10CE
; ---------------------------------------------------------------------------
		bra.s	loc_10DC
; ---------------------------------------------------------------------------
; ===========================================================================

loc_10FE:
		subq.w	#1,a0
		cmpi.w	#$10,d6
		bne.s	loc_1108
		subq.w	#1,a0

loc_1108:
		move.w	a0,d0
		lsr.w	#1,d0
		bcc.s	locret_1110
		addq.w	#1,a0

locret_1110:
		rts

sub_1112:
		move.w	a3,d3
		move.b	d4,d1
		add.b	d1,d1
		bcc.s	loc_1124
		subq.w	#1,d6
		btst	d6,d5
		beq.s	loc_1124
		ori.w	#$8000,d3

loc_1124:
		add.b	d1,d1
		bcc.s	loc_1132
		subq.w	#1,d6
		btst	d6,d5
		beq.s	loc_1132
		addi.w	#$4000,d3

loc_1132:
		add.b	d1,d1
		bcc.s	loc_1140
		subq.w	#1,d6
		btst	d6,d5
		beq.s	loc_1140
		addi.w	#$2000,d3

loc_1140:
		add.b	d1,d1
		bcc.s	loc_114E
		subq.w	#1,d6
		btst	d6,d5
		beq.s	loc_114E
		ori.w	#$1000,d3

loc_114E:
		add.b	d1,d1
		bcc.s	loc_115C
		subq.w	#1,d6
		btst	d6,d5
		beq.s	loc_115C
		ori.w	#$800,d3

loc_115C:
		move.w	d5,d1
		move.w	d6,d7
		sub.w	a5,d7
		bcc.s	loc_118C
		move.w	d7,d6
		addi.w	#$10,d6
		neg.w	d7
		lsl.w	d7,d1
		move.b	(a0),d5
		rol.b	d7,d5
		add.w	d7,d7
		and.w	loc_11A0(pc,d7.w),d5
		add.w	d5,d1

loc_117A:
		move.w	a5,d0
		add.w	d0,d0
		and.w	loc_11A0(pc,d0.w),d1
		add.w	d3,d1
		move.b	(a0)+,d5
		lsl.w	#8,d5
		move.b	(a0)+,d5
		rts

loc_118C:
		beq.s	loc_119E
		lsr.w	d7,d1
		move.w	a5,d0
		add.w	d0,d0
		and.w	loc_11A0(pc,d0.w),d1
		add.w	d3,d1
		move.w	a5,d0
		bra.s	sub_11C2

loc_119E:
		moveq	#$10,d6

loc_11A0:
		bra.s	loc_117A

; ===========================================================================
; ---------------------------------------------------------------------------
; Enigma Decompression Values
		dc.w	$0001
		dc.w	$0003
		dc.w	$0007
		dc.w	$000F
		dc.w	$001F
		dc.w	$003F
		dc.w	$007F
		dc.w	$00FF
		dc.w	$01FF
		dc.w	$03FF
		dc.w	$07FF
		dc.w	$0FFF
		dc.w	$1FFF
		dc.w	$3FFF
		dc.w	$7FFF
		dc.w	$FFFF
; ---------------------------------------------------------------------------
; ===========================================================================

sub_11C2:
		sub.w	d0,d6
		cmpi.w	#9,d6
		bcc.s	locret_11D0
		addq.w	#8,d6
		asl.w	#8,d5
		move.b	(a0)+,d5

locret_11D0:
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; (Unused) Kosinski Decompression Algorithm
; ---------------------------------------------------------------------------

KosDec_Unused:
		subq.l	#2,sp
		move.b	(a0)+,1(sp)
		move.b	(a0)+,(sp)
		move.w	(sp),d5
		moveq	#$F,d4

loc_11DE:
		lsr.w	#1,d5
		move	sr,d6
		dbf	d4,loc_11F0
		move.b	(a0)+,1(sp)
		move.b	(a0)+,(sp)
		move.w	(sp),d5
		moveq	#$F,d4

loc_11F0:
		move	d6,ccr
		bcc.s	loc_11F8
		move.b	(a0)+,(a1)+
		bra.s	loc_11DE

loc_11F8:
		moveq	#0,d3
		lsr.w	#1,d5
		move	sr,d6
		dbf	d4,loc_120C
		move.b	(a0)+,1(sp)
		move.b	(a0)+,(sp)
		move.w	(sp),d5
		moveq	#$F,d4

loc_120C:
		move	d6,ccr
		bcs.s	loc_123C
		lsr.w	#1,d5
		dbf	d4,loc_1220
		move.b	(a0)+,1(sp)
		move.b	(a0)+,(sp)
		move.w	(sp),d5
		moveq	#$F,d4

loc_1220:
		roxl.w	#1,d3
		lsr.w	#1,d5
		dbf	d4,loc_1232
		move.b	(a0)+,1(sp)
		move.b	(a0)+,(sp)
		move.w	(sp),d5
		moveq	#$F,d4

loc_1232:
		roxl.w	#1,d3
		addq.w	#1,d3
		moveq	#$FFFFFFFF,d2
		move.b	(a0)+,d2
		bra.s	loc_1252

loc_123C:
		move.b	(a0)+,d0
		move.b	(a0)+,d1
		moveq	#$FFFFFFFF,d2
		move.b	d1,d2
		lsl.w	#5,d2
		move.b	d0,d2
		andi.w	#7,d1
		beq.s	loc_125E
		move.b	d1,d3
		addq.w	#1,d3

loc_1252:
		move.b	(a1,d2.w),d0
		move.b	d0,(a1)+
		dbf	d3,loc_1252
		bra.s	loc_11DE

loc_125E:
		move.b	(a0)+,d1
		beq.s	loc_126E
		cmpi.b	#1,d1
		beq.w	loc_11DE
		move.b	d1,d3
		bra.s	loc_1252

loc_126E:
		addq.l	#2,sp
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write level blocks to the buffer on a full "horizontal" plane line
; ---------------------------------------------------------------------------

DrawBlocksHorizontally:					; Offset: 00001272
		bsr.w	VRam_GetPlanePosition			; get the plane map address/position to draw
		move.w	d2,(a3)+				; store address/position for later
		bsr.w	GetBlockPosition_Reversed		; get reversed positions and store them
		lsr.w	#$04,d0					; divide X and Y positions by 10 (block size)
		lsr.w	#$04,d1					; ''
		moveq	#$00,d3					; clear d3
		move.b	$06(a1),d3				; load Y80 multiplier
		moveq	#$1F,d7					; set X repeat times (Number of blocks to draw horizontally)

DBH_WriteBlock:						; Offset: 00001288
		bsr.s	FindChunkAndBlockID			; find chunk address and block ID
		movea.l	$28(a1),a6				; load 16x16 block address to a6
		bsr.w	WriteBlockToBuffer_ByX			; write block tiles to buffer space (by X)
		addq.w	#$01,d0					; increase X right by 1 for next block
		dbf	d7,DBH_WriteBlock			; repeat til all the blocks on the X line have been written
		rts						; return

; ---------------------------------------------------------------------------
; Subroutine to write level blocks to the buffer on a full "vertical" plane line
; ---------------------------------------------------------------------------

DrawBlocksVertically:					; Offset: 0000129A
		bsr.w	VRam_GetPlanePosition			; get the plane map address/position to draw
		move.w	d2,(a3)+				; store address/position for later
		bsr.w	GetBlockPosition_Reversed		; get reversed positions and store them
		lsr.w	#$04,d0					; divide X and Y positions by 10 (block size)
		lsr.w	#$04,d1					; ''
		moveq	#$00,d3					; clear d3
		move.b	$06(a1),d3				; load Y80 multiplier
		moveq	#$0F,d7					; set Y repeat times (Number of blocks to draw horizontally)

DBV_WriteBlock:						; Offset: 000012B0
		bsr.s	FindChunkAndBlockID			; find chunk address and block ID
		movea.l	$28(a1),a6				; load 16x16 block address to a6
		bsr.w	WriteBlockToBuffer_ByY			; write block tiles to buffer space (by Y)
		addq.w	#$01,d1					; increase Y down by 1 for next block
		dbf	d7,DBV_WriteBlock			; repeat til all the blocks on the Y line have been written
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to use the X and Y position to find the block ID, in the chunk,
; in the layout.
; ---------------------------------------------------------------------------

FindChunkAndBlockID:					; Offset: 000012C2
		move.w	d0,d4					; load X pos (/10) to d4
		move.w	d1,d5					; load Y pos (/10) to d5
		movea.l	$20(a1),a6				; load layout ram address to a6
		lsr.w	#$03,d4					; divide X position by 8 (10 x 8 = 80 | divide by 80)
		lsr.w	#$03,d5					; divide Y position by 8 (10 x 8 = 80 | divide by 80)
		lsl.w	d3,d5					; multiply by Y80 multiplier
		add.w	d5,d4					; add Y to X
		move.b	(a6,d4.w),d4				; get correct chunk ID to draw from
		andi.w	#$00FF,d4				; keep within 100 chunks
		movea.l	$24(a1),a6				; load 128x128 chunk address to a6
		lsl.w	#$07,d4					; multiply by 80 (80 bytes per chunk) (chunk address)
		move.w	d0,d5					; load X position
		add.w	d5,d5					; multiply by 2
		andi.w	#$000E,d5				; keep in multiples of 2 max 10 (2 bytes per block on the chunk's X)
		add.w	d5,d4					; add to chunk address
		move.w	d1,d5					; load Y position
		lsl.w	#$04,d5					; multiply by 10
		andi.w	#$0070,d5				; keep in multiples of 10 max 80 (10 bytes per block on the chunk's Y)
		add.w	d5,d4					; add to chunk address
		move.w	(a6,d4.w),d4				; get correct block ID
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to collect the V-Ram address on the map plane based on the X and Y positions
; ---------------------------------------------------------------------------

VRam_GetPlanePosition:					; Offset: 000012FA
		move.w	d0,d2					; load X position to d2
		move.w	d1,d3					; load Y position to d3
		lsl.w	#$04,d3					; multiply Y by 10
		andi.w	#$0F00,d3				; keep in multiples of 100
		lsr.w	#$02,d2					; multiply X by 4
		andi.w	#$007C,d2				; keep in multiples of 4
		add.w	d3,d2					; add Y to X
		or.w	$18(a1),d2				; set V-Ram settings
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to get the X and Y position draws from the reversed sides
; (right for X and bottom for Y, insted of left for X and top for Y)
; ---------------------------------------------------------------------------

GetBlockPosition_Reversed:				; Offset: 00001312
		move.w  $00(a1),d2				; load screen's X position
		move.w	$10(a1),d3				; load screen's Y position
		lsl.w	#$04,d3					; multiply Y by 10
		andi.w	#$0F00,d3				; keep in multiples of 100
		move.w	#$1000,d4				; prepare the maximum value
		sub.w	d3,d4					; subtract Y pos from maximum (d4 = reversed of position)
		andi.w	#$0F00,d4				; keep in multiples of 100
		lsr.w	#$08,d4					; divide by 100
		move.b	d4,$17(a1)				; save to Y draw from bottom position
		lsr.w	#$02,d2					; multiply X by 4
		andi.w	#$007C,d2				; keep in multiples of 4
		move.w	#$0080,d4				; prepare the maximum value
		sub.w	d2,d4					; subtract X pos from maximum (d4 = reversed of position)
		andi.w	#$007C,d4				; keep in multiples of 4
		lsr.w	#$02,d4					; divide by 4
		move.b	d4,$07(a1)				; save to X draw from right position
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw tiles from a block to plane ram (by Y (horizontal lines))
; ---------------------------------------------------------------------------
; |-|-|
; |1|2|			; Left two first then right two after
; |-|-|			; OR
; |3|4|			; Right two first then left two after
; |-|-|
; ---------------------------------------------------------------------------

WriteBlockToBuffer_ByY:					; Offset: 00001348
		btst	#$0A,d4					; is the block mirrored?
		beq.s	WBTBY_CheckFlip				; if not, branch
		btst	#$0B,d4					; is the block flipped?
		bne.w	WBTBY_WriteMirrorFlip			; if so, branch
		bra.s	WBTBY_WriteMirror			; continue to mirrored block routine

WBTBY_CheckFlip:					; Offset: 00001358
		btst	#$0B,d4					; is the block flipped?
		bne.s	WBTBY_WriteFlip				; if so, branch

; ---------------------------------------------------------------------------
; write normal block
; ---------------------------------------------------------------------------

WBTBY_WriteNormal:					; Offset: 0000135E
		andi.w	#$03FF,d4				; clear the flip mirror data of the block ID
		lsl.w	#$03,d4					; multiply by 8 (8 bytes per block data (4 words, 4 tiles)
		move.w	(a6,d4.w),d5				; load tile 1
		swap	d5					; send left side
		move.w	$04(a6,d4.w),d5				; load tile 3
		move.l	d5,(a3)+				; save to map plane buffer
		move.w	$02(a6,d4.w),d5				; load tile 2
		swap	d5					; send left side
		move.w	$06(a6,d4.w),d5				; load tile 4
		move.l	d5,$3C(a3)				; save to map plane buffer
		rts						; return

; ---------------------------------------------------------------------------
; write mirrored block
; ---------------------------------------------------------------------------

WBTBY_WriteMirror:					; Offset: 00001380
		andi.w	#$03FF,d4				; clear the flip mirror data of the block ID
		lsl.w	#$03,d4					; multiply by 8 (8 bytes per block data (4 words, 4 tiles)
		move.w	$02(a6,d4.w),d5				; load tile 2
		eori.w	#$0800,d5				; set mirror bit
		swap	d5					; send left side
		move.w	$06(a6,d4.w),d5				; load tile 4
		eori.w	#$0800,d5				; set mirror bit
		move.l	d5,(a3)+				; save to map plane buffer
		move.w	(a6,d4.w),d5				; load tile 1
		eori.w	#$0800,d5				; set mirror bit
		swap	d5					; send left side
		move.w	$04(a6,d4.w),d5				; load tile 3
		eori.w	#$0800,d5				; set mirror bit
		move.l	d5,$3C(a3)				; save to map plane buffer
		rts						; return

; ---------------------------------------------------------------------------
; write flipped block
; ---------------------------------------------------------------------------

WBTBY_WriteFlip:					; Offset: 000013B2
		andi.w	#$03FF,d4				; clear the flip mirror data of the block ID
		lsl.w	#$03,d4					; multiply by 8 (8 bytes per block data (4 words, 4 tiles)
		move.w	$04(a6,d4.w),d5				; load tile 3
		eori.w	#$1000,d5				; set flip bit
		swap	d5					; send left side
		move.w	(a6,d4.w),d5				; load tile 1
		eori.w	#$1000,d5				; set flip bit
		move.l	d5,(a3)+				; save to map plane buffer
		move.w	$06(a6,d4.w),d5				; load tile 4
		eori.w	#$1000,d5				; set flip bit
		swap	d5					; send left side
		move.w	$02(a6,d4.w),d5				; load tile 2
		eori.w	#$1000,d5				; set flip bit
		move.l	d5,$3C(a3)				; save to map plane buffer
		rts						; return

; ---------------------------------------------------------------------------
; write mirrored and flipped block
; ---------------------------------------------------------------------------

WBTBY_WriteMirrorFlip:					; Offset: 000013E4
		andi.w	#$03FF,d4				; clear the flip mirror data of the block ID
		lsl.w	#$03,d4					; multiply by 8 (8 bytes per block data (4 words, 4 tiles)
		move.w	$06(a6,d4.w),d5				; load tile 4
		eori.w	#$1800,d5				; set mirror AND flip bits
		swap	d5					; send left side
		move.w	$02(a6,d4.w),d5				; load tile 2
		eori.w	#$1800,d5				; set mirror AND flip bits
		move.l	d5,(a3)+				; save to map plane buffer
		move.w	$04(a6,d4.w),d5				; load tile 3
		eori.w	#$1800,d5				; set mirror AND flip bits
		swap	d5					; send left side
		move.w	(a6,d4.w),d5				; load tile 1
		eori.w	#$1800,d5				; set mirror AND flip bits
		move.l	d5,$3C(a3)				; save to map plane buffer
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw tiles from a block to plane ram (by X (horizontal lines))
; ---------------------------------------------------------------------------
; |-|-|
; |1|2|			; Top two first then bottom two after
; |-|-|			; OR
; |3|4|			; Bottom two first then top two after
; |-|-|
; ---------------------------------------------------------------------------

WriteBlockToBuffer_ByX:					; Offset: 00001416
		btst	#$0A,d4					; is the block mirrored?
		beq.s	WBTBX_CheckFlip				; if not, branch
		btst	#$0B,d4					; is the block flipped?
		bne.w	WBTBX_WriteMirrorFlip			; if so, branch
		bra.s	WBTBX_WriteMirror			; continue to mirrored block routine

WBTBX_CheckFlip:					; Offset: 00001426
		btst	#$0B,d4					; is the block flipped?
		bne.s	WBTBX_WriteFlip				; if so, branch

; ---------------------------------------------------------------------------
; write normal block
; ---------------------------------------------------------------------------

WBTBX_WriteNormal:					; Offset: 0000142C
		andi.w	#$03FF,d4				; clear the flip mirror data of the block ID
		lsl.w	#$03,d4					; multiply by 8 (8 bytes per block data (4 words, 4 tiles)
		move.w	(a6,d4.w),d5				; load tile 1
		swap	d5					; send left side
		move.w	$02(a6,d4.w),d5				; load tile 2
		move.l	d5,(a3)+				; save to map plane buffer
		move.w	$04(a6,d4.w),d5				; load tile 3
		swap	d5					; send left side
		move.w	$06(a6,d4.w),d5				; load tile 4
		move.l	d5,$7C(a3)				; save to map plane buffer
		rts						; return

; ---------------------------------------------------------------------------
; write mirrored block
; ---------------------------------------------------------------------------

WBTBX_WriteMirror:					; Offset: 0000144E
		andi.w	#$03FF,d4				; clear the flip mirror data of the block ID
		lsl.w	#$03,d4					; multiply by 8 (8 bytes per block data (4 words, 4 tiles)
		move.w	$02(a6,d4.w),d5				; load tile 2
		eori.w	#$0800,d5				; set mirror bit
		swap	d5					; send left
		move.w	(a6,d4.w),d5				; load tile 1
		eori.w	#$0800,d5				; set mirror bit
		move.l	d5,(a3)+				; save to map plane buffer
		move.w	$06(a6,d4.w),d5				; load tile 4
		eori.w	#$0800,d5				; set mirror bit
		swap	d5					; send left
		move.w	$04(a6,d4.w),d5				; load tile 3
		eori.w	#$0800,d5				; set mirror bit
		move.l	d5,$7C(a3)				; save to map plane buffer
		rts						; return

; ---------------------------------------------------------------------------
; write flipped block
; ---------------------------------------------------------------------------

WBTBX_WriteFlip:					; Offset: 00001480
		andi.w	#$03FF,d4				; clear the flip mirror data of the block ID
		lsl.w	#$03,d4					; multiply by 8 (8 bytes per block data (4 words, 4 tiles)
		move.w	$04(a6,d4.w),d5				; load tile 3
		eori.w	#$1000,d5				; set flip bit
		swap	d5					; send left
		move.w	$06(a6,d4.w),d5				; load tile 4
		eori.w	#$1000,d5				; set flip bit
		move.l	d5,(a3)+				; save to map plane buffer
		move.w	(a6,d4.w),d5				; load tile 1
		eori.w	#$1000,d5				; set flip bit
		swap	d5					; send left
		move.w	$02(a6,d4.w),d5				; load tile 2
		eori.w	#$1000,d5				; set flip bit
		move.l	d5,$7C(a3)				; save to map plane buffer
		rts						; return

; ---------------------------------------------------------------------------
; write mirrored and flipped block
; ---------------------------------------------------------------------------

WBTBX_WriteMirrorFlip:					; Offset: 000014B2
		andi.w	#$03FF,d4				; clear the flip mirror data of the block ID
		lsl.w	#$03,d4					; multiply by 8 (8 bytes per block data (4 words, 4 tiles)
		move.w	$06(a6,d4.w),d5				; load tile 4
		eori.w	#$1800,d5				; set mirror AND flip bits
		swap	d5					; send left
		move.w	$04(a6,d4.w),d5				; load tile 3
		eori.w	#$1800,d5				; set mirror AND flip bits
		move.l	d5,(a3)+				; save to map plane buffer
		move.w	$02(a6,d4.w),d5				; load tile 2
		eori.w	#$1800,d5				; set mirror AND flip bits
		swap	d5					; send left
		move.w	(a6,d4.w),d5				; load tile 1
		eori.w	#$1800,d5				; set mirror AND flip bits
		move.l	d5,$7C(a3)				; save to map plane buffer
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to dump tiles from the horizontal and vertical map plane buffers
; to V-Ram planes
; ---------------------------------------------------------------------------

DumpMapPlaneBuffers:					; Offset: 000014E4
		lea	($C00004).l,a1				; load VDP address port address to a1
		lea	-$04(a1),a2				; load VDP data port address to a2
		move.w	$18(a5),d3				; load part 1 of V-Ram address to write to
		move.w	$1A(a5),d4				; load part 2 of V-Ram address to write to

; ---------------------------------------------------------------------------
; For the vertical lines on the left/right of the screen
; ---------------------------------------------------------------------------

DMPB_Vertical:						; Offset: 000014F6
		move.w	(a4),d0					; has the vertical line been given a V-Ram address?
		beq.w	DMPB_Horizontal				; if not, branch
		move.w	#$0000,(a4)+				; clear the address

; ---------------------------------------------------------------------------
; For left tiles of the block

		move.w	#$8F80,($C00004).l			; set VDP auto increment mode to 80 bytes
		move.w	#$8F80,($FFFFC9D6).w			; store VDP register 0F data
		move.w	d0,d1					; copy vertical line draw address to d1
		moveq	#$0F,d7					; set maximum repeat times
		moveq	#$00,d6					; clear d6
		move.b	$17(a5),d6				; load draw from bottom position
		sub.w	d6,d7					; subtract from max (exact position to start on plane in V-Ram)
		move.w	d0,(a1)					; set VDP to V-Ram write mode...
		move.w	d4,(a1)					; ...with plane address
		bra.s	DMPBV_DBFRegReduce1			; continue to decrease register before beginning

DMPBV_WriteBlocks1_Vram1:				; Offset: 00001520
		move.l	(a4)+,(a2)				; dump two tiles to V-Ram's plane

DMPBV_DBFRegReduce1:						; Offset: 00001522
		dbf	d6,DMPBV_WriteBlocks1_Vram1		; repeat til it's the end of the plane memory space
		move.w	d3,d2					; copy part 1 V-Ram address to d2
		addi.w	#$007C,d2				; keep in range (on the plane line in multiples of 4)
		and.w	d2,d0					; wrap the V-Ram address back to beginning of V-Ram's plane
		move.w	d0,(a1)					; set VDP to V-Ram write mode...
		move.w	d4,(a1)					; ...with plane address

DMPBV_WriteBlocks1_Vram2:				; Offset: 00001532
		move.l	(a4)+,(a2)				; dump two tiles to V-Ram's plane
		dbf	d7,DMPBV_WriteBlocks1_Vram2		; repeat for the remaining blocks left

; ---------------------------------------------------------------------------
; For right tiles of the block

		addq.w	#$02,d1					; increase address by 2 (for next tile to the right)
		moveq	#$0F,d7					; set maximum repeat times
		moveq	#$00,d6					; clear d6
		move.b	$17(a5),d6				; load draw from bottom position
		sub.w	d6,d7					; subtract from max (exact position to start on plane in V-Ram)
		move.w	d1,(a1)					; set VDP to V-Ram write mode...
		move.w	d4,(a1)					; ...with plane address
		bra.s	DMPBV_DBFRegReduce2			; continue to decrease register before beginning

DMPBV_WriteBlocks2_Vram1:				; Offset: 0000154A
		move.l	(a4)+,(a2)				; dump two tiles to V-Ram's plane

DMPBV_DBFRegReduce2:					; Offset: 0000154C
		dbf	d6,DMPBV_WriteBlocks2_Vram1		; repeat til it's the end of the plane memory space
		move.w	d3,d2					; copy part 1 V-Ram address to d2
		addi.w	#$007E,d2				; keep in range (on the plane line in multiples of 2)
		and.w	d2,d1					; wrap the V-Ram address back to beginning of V-Ram's plane
		move.w	d1,(a1)					; set VDP to V-Ram write mode...
		move.w	d4,(a1)					; ...with plane address

DMPBV_WriteBlocks2_Vram2:				; Offset: 0000155C
		move.l	(a4)+,(a2)				; dump two tiles to V-Ram's plane
		dbf	d7,DMPBV_WriteBlocks2_Vram2		; repeat for the remaining blocks left
		move.w	#$8F02,($C00004).l			; set VDP auto increment mode to 2 bytes
		move.w	#$8F02,($FFFFC9D6).w			; store VDP register 0F data

; ---------------------------------------------------------------------------
; For the horizontal lines on the top/bottom of the screen
; ---------------------------------------------------------------------------

DMPB_Horizontal:					; Offset: 00001570
		move.w	(a3),d0					; has the horizontal line been given a V-Ram address?
		beq.s	DMPB_NoWrite				; if not, branch
		move.w	#$0000,(a3)+				; clear the address

; ---------------------------------------------------------------------------
; For top tiles of the block

		move.w	d0,d1					; copy horizontal line draw address to d1
		moveq	#$1F,d7					; set maximum repeat times
		moveq	#$00,d6					; clear d6
		move.b	$07(a5),d6				; load draw from right position
		sub.w	d6,d7					; subtract from max (exact position to start on plane in V-Ram)
		move.w	d0,(a1)					; set VDP to V-Ram write mode...
		move.w	d4,(a1)					; ...with plane address
		bra.s	DMPBH_DBFRegReduce1			; continue to decrease register before beginning

DMPBH_WriteBlocks1_Vram1:				; Offset: 0000158A
		move.l	(a3)+,(a2)				; dump two tiles to V-Ram's plane

DMPBH_DBFRegReduce1:					; Offset: 0000158C
		dbf	d6,DMPBH_WriteBlocks1_Vram1		; repeat til it's the end of the plane memory space
		move.w	d3,d2					; copy part 1 V-Ram address to d2
		addi.w	#$0F00,d2				; keep in range (on the plane line in multiples of 100 (2 plane H-lines))
		and.w	d2,d0					; wrap the V-Ram address back to beginning of V-Ram's plane
		move.w	d0,(a1)					; set VDP to V-Ram write mode...
		move.w	d4,(a1)					; ...with plane address

DMPBH_WriteBlocks1_Vram2:				; Offset: 0000159C
		move.l	(a3)+,(a2)				; dump two tiles to V-Ram's plane
		dbf	d7,DMPBH_WriteBlocks1_Vram2		; repeat for the remaining blocks left

; ---------------------------------------------------------------------------
; For bottom tiles of the block

		addi.w	#$0080,d1				; increase address by 80 (for next tile to the bottom (Next line down))
		moveq	#$1F,d7					; set maximum repeat times
		moveq	#$00,d6					; clear d6
		move.b	$07(a5),d6				; load draw from right position
		sub.w	d6,d7					; subtract from max (exact position to start on plane in V-Ram)
		move.w	d1,(a1)					; set VDP to V-Ram write mode...
		move.w	d4,(a1)					; ...with plane address
		bra.s	DMPBH_DBFRegReduce2			; continue to decrease register before beginning

DMPBH_WriteBlocks2_Vram1:				; Offset: 000015B6
		move.l	(a3)+,(a2)				; dump two tiles to V-Ram's plane

DMPBH_DBFRegReduce2:					; Offset: 000015B8
		dbf	d6,DMPBH_WriteBlocks2_Vram1		; repeat til it's the end of the plane memory space
		move.w	d3,d2					; copy part 1 V-Ram address to d2
		addi.w	#$0F80,d2				; keep in range (on the plane line in multiples of 80)
		and.w	d2,d1					; wrap the V-Ram address back to beginning of V-Ram's plane
		move.w	d1,(a1)					; set VDP to V-Ram write mode...
		move.w	d4,(a1)					; ...with plane address

DMPBH_WriteBlocks2_Vram2:				; Offset: 000015C8
		move.l	(a3)+,(a2)				; dump two tiles to V-Ram's plane
		dbf	d7,DMPBH_WriteBlocks2_Vram2		; repeat for the remaining blocks left

DMPB_NoWrite:						; Offset: 000015CE
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to clear and setup the sprite table and object ram
; ---------------------------------------------------------------------------

Objects_SetupRam:					; Offset: 000015D0
		moveq	#$00,d0					; Clear d0
		lea	($FFFFD84C).w,a0			; load object storage data
		move.l	d0,(a0)+
		move.l	d0,(a0)+
		move.l	d0,(a0)+
		move.l	d0,(a0)+
		move.l	d0,(a0)+
		move.w	#$7FFF,(a0)+
		lea	($00FFAD08).l,a0			; load start of object ram to a0
		move.w	#$0400,d1				; set repeat times (40 objects 1000 bytes)

OSR_ClearSST:						; Offset: 000015EE
		move.l	d0,(a0)+				; clear object ram
		dbf	d1,OSR_ClearSST				; repeat til object ram is clear
		lea	($00FFAD08).l,a0			; load start of object ram to a0
		moveq	#$3F,d7					; set repeat times (40 objects)
		move.w	a0,($FFFFD84C).w			; store object ram location

OSR_SetupSST:						; Offset: 00001600
		lea	$40(a0),a1				; load next object slot location
		move.w	a1,(a0)					; store in this object's slot
		movea.l	a1,a0					; advance to next object slot location
		dbf	d7,OSR_SetupSST				; repeat til the object ram is setup
		clr.w	-$40(a0)				; clear last object's "Next Object" address (as it's the last object slot)
		lea	($FFFFD164).w,a0			; load sprite table buffer to a0
		moveq	#$4F,d1					; set repeat times (50 sprites)

OSR_ClearSprites:					; Offset: 00001616
		move.l	d0,(a0)+				; clear sprite slot
		move.l	d0,(a0)+				; ''
		dbf	d1,OSR_ClearSprites			; repeat til sprite table buffer is cleared
		move.l	d0,($FFFFD9F2).w
		move.l	d0,($FFFFD9F6).w
		move.w	#$0003,($FFFFD83C).w
		move.w	#$000F,($FFFFD840).w
		move.w	#$001F,($FFFFD844).w
		move.w	#$003F,($FFFFD848).w
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to dump object sprite data to the sprite table
; ---------------------------------------------------------------------------

BuildSprites:						; Offset: 00001640
		lea	($FFFFD164).w,a6			; load sprite table buffer to a6
		moveq	#$00,d6					; clear d6 (used for priority)
		lea	($FFFFD3E4).w,a5			; load palette table buffer to a5 (End of the sprite table)
		moveq	#$4F,d5
		lea	($FFFFD9F2).w,a4

loc_1650:
		move.l	(a4)+,d0				; load first half of sprite data (YYYYSSPP) (Y = Y position/S = shape/P = priority)
		move.l	d0,(a6)+				; save to sprite table buffer
		move.l	(a4)+,(a6)+				; load second half of sprite data (VVVVXXXX) (V = V-Ram location settings/X = X position)
		addq.w	#$01,d6					; increase priority counter
		tst.b	d0					; is this sprite's priority 00?
		bne.s	loc_1650				; if not, branch
		move.b	d6,-$05(a6)				; set the last dumped sprites priority
		lea	($FFFFD850).w,a4			; load Object Ram Cue 2 address to a4

loc_1664:
		move.w	(a4)+,d0				; load object's ram address to d0
		bmi.s	loc_1684				; if it's negative, branch
		beq.s	loc_1664				; otherwise if it's NULL, branch
		move.b	#$4F,-$05(a6)				; set the last dumped sprite's priority to 4F
		cmpi.w	#$4F,d5
		bne.s	loc_167E
		moveq	#$00,d0					; clear d0
		move.l	d0,-(a5)				; clear last sprite in table
		move.l	d0,-(a5)				; ''
		rts						; return (Finished)

loc_167E:
		clr.b	$03(a5)					; set next sprite's priority to 00 (Sets end of table)
		rts						; return

loc_1684:
		movea.w	d0,a0					; load the object's ram address to a0
		jsr	(Object_ChkOffScreen).l			; check if object is within screen
		tst.b	$05(a0)					; is the object set to show sprite?
		bpl.s	loc_16BA				; if not, branch
		move.w	d2,$14(a0)				; store X position
		move.w	d3,$16(a0)				; store Y position
		movea.l	$10(a0),a3				; load mappings address to a3
		move.b	$20(a0),d0				; load left byet of V-Ram location read to d0
		andi.w	#$0018,d0				; get only the flip and mirror flags
		move.w	$20(a0),d4				; reload V-Ram location read to d4
		move.w	d4,d7					; copy to d7
		andi.w	#$7FF,d4				; get only the V-Ram location for d4
		sub.w	d4,d7					; get only the render flag data for d7 (plane/colour/flip/mirror)
		tst.w	$04(a0)
		jsr	loc_16C0(pc,d0.w)			; jump to the correct routine based on the flip/mirror flags

loc_16BA:
		move.w	(a0),d0
		bmi.s	loc_1684
		bra.s	loc_1664

; ===========================================================================
; ---------------------------------------------------------------------------
; Flip/Mirror routines
; ---------------------------------------------------------------------------
loc_16C0:						; Offset: 000016C0
		bmi.w	loc_16E0				; normal 
		bra.w	loc_17FC				; normal 
; ---------------------------------------------------------------------------
		bmi.w	loc_1716				; mirrored 
		bra.w	loc_1832				; mirrored 
; ---------------------------------------------------------------------------
		bmi.w	loc_1756				; flipped 
		bra.w	loc_1872				; flipped 
; ---------------------------------------------------------------------------
		bmi.w	loc_17B4				; mirrored & flipped 
		bra.w	loc_18D0				; mirrored & flipped 
; ---------------------------------------------------------------------------
; ===========================================================================

loc_16E0:
		cmp.w	d5,d6
		bcc.s	locret_1714
		addq.w	#1,d6
		move.w	(a3)+,d0
		move.w	d0,d1
		ext.w	d0
		add.w	d3,d0
		swap	d0
		move.w	d1,d0
		move.b	d6,d0
		move.l	d0,(a6)+
		move.w	(a3)+,d0
		add.w	d4,d0
		eor.w	d7,d0
		swap	d0
		move.b	(a3)+,d0
		ext.w	d0
		add.w	d2,d0
		andi.w	#$1FF,d0
		bne.s	loc_170E
		move.w	#1,d0

loc_170E:
		move.l	d0,(a6)+
		tst.b	(a3)+
		beq.s	loc_16E0

locret_1714:
		rts

; ===========================================================================

loc_1716:
		cmp.w	d5,d6
		bcc.s	locret_1754
		addq.w	#1,d6
		move.w	(a3)+,d0
		move.w	d0,d1
		ext.w	d0
		add.w	d3,d0
		swap	d0
		move.w	d1,d0
		move.b	d6,d0
		move.l	d0,(a6)+
		move.w	(a3)+,d0
		add.w	d4,d0
		eor.w	d7,d0
		swap	d0
		sub.w	d0,d0
		move.b	-4(a3),d0
		move.b	byte_1794(pc,d0.w),d0
		sub.b	(a3)+,d0
		ext.w	d0
		add.w	d2,d0
		andi.w	#$1FF,d0
		bne.s	loc_174E
		move.w	#1,d0

loc_174E:
		move.l	d0,(a6)+
		tst.b	(a3)+
		beq.s	loc_1716

locret_1754:
		rts

; ===========================================================================

loc_1756:
		cmp.w	d5,d6
		bcc.s	locret_1792
		addq.w	#1,d6
		moveq	#0,d0
		move.b	(a3),d0
		move.w	(a3)+,d1
		move.b	byte_17A4(pc,d0.w),d0
		sub.b	d1,d0
		ext.w	d0
		add.w	d3,d0
		swap	d0
		move.w	d1,d0
		move.b	d6,d0
		move.l	d0,(a6)+
		move.w	(a3)+,d0
		add.w	d4,d0
		eor.w	d7,d0
		swap	d0
		move.b	(a3)+,d0
		ext.w	d0
		add.w	d2,d0
		andi.w	#$1FF,d0
		bne.s	loc_178C
		move.w	#1,d0

loc_178C:
		move.l	d0,(a6)+
		tst.b	(a3)+
		beq.s	loc_1756

locret_1792:
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
byte_1794:	dc.b $F8,$F8,$F8,$F8
		dc.b $F0,$F0,$F0,$F0
		dc.b $E8,$E8,$E8,$E8
		dc.b $E0,$E0,$E0,$E0
byte_17A4:	dc.b $F8,$F0,$E8,$E0
		dc.b $F8,$F0,$E8,$E0
		dc.b $F8,$F0,$E8,$E0
		dc.b $F8,$F0,$E8,$E0
		even
; ---------------------------------------------------------------------------
; ===========================================================================

loc_17B4:
		cmp.w	d5,d6
		bcc.s	locret_17FA
		addq.w	#1,d6
		moveq	#0,d0
		move.b	(a3),d0
		move.w	(a3)+,d1
		move.b	byte_17A4(pc,d0.w),d0
		sub.b	d1,d0
		ext.w	d0
		add.w	d3,d0
		swap	d0
		move.w	d1,d0
		move.b	d6,d0
		move.l	d0,(a6)+
		move.w	(a3)+,d0
		add.w	d4,d0
		eor.w	d7,d0
		swap	d0
		sub.w	d0,d0
		move.b	-4(a3),d0
		move.b	byte_1794(pc,d0.w),d0
		sub.b	(a3)+,d0
		ext.w	d0
		add.w	d2,d0
		andi.w	#$1FF,d0
		bne.s	loc_17F4
		move.w	#1,d0

loc_17F4:
		move.l	d0,(a6)+
		tst.b	(a3)+
		beq.s	loc_17B4

locret_17FA:
		rts

; ===========================================================================

loc_17FC:
		cmp.w	d6,d5
		bls.s	locret_1830
		subq.w	#1,d5
		move.w	(a3)+,d0
		move.w	d0,d1
		ext.w	d1
		add.w	d3,d1
		swap	d1
		move.w	d0,d1
		move.b	d5,d1
		move.w	(a3)+,d0
		add.w	d4,d0
		eor.w	d7,d0
		swap	d0
		move.b	(a3)+,d0
		ext.w	d0
		add.w	d2,d0
		andi.w	#$1FF,d0
		bne.s	loc_1828
		move.w	#1,d0

loc_1828:
		move.l	d0,-(a5)
		move.l	d1,-(a5)
		tst.b	(a3)+
		beq.s	loc_17FC

locret_1830:
		rts

; ===========================================================================

loc_1832:
		cmp.w	d6,d5
		bls.s	locret_1870
		subq.w	#1,d5
		move.w	(a3)+,d0
		move.w	d0,d1
		ext.w	d1
		add.w	d3,d1
		swap	d1
		move.w	d0,d1
		move.b	d5,d1
		move.w	(a3)+,d0
		add.w	d4,d0
		eor.w	d7,d0
		swap	d0
		sub.w	d0,d0
		move.b	-4(a3),d0
		move.b	byte_18B0(pc,d0.w),d0
		sub.b	(a3)+,d0
		ext.w	d0
		add.w	d2,d0
		andi.w	#$1FF,d0
		bne.s	loc_1868
		move.w	#1,d0

loc_1868:
		move.l	d0,-(a5)
		move.l	d1,-(a5)
		tst.b	(a3)+
		beq.s	loc_1832

locret_1870:
		rts

; ===========================================================================

loc_1872:
		cmp.w	d6,d5
		bls.s	locret_18AE
		subq.w	#1,d5
		moveq	#0,d1
		move.b	(a3),d1
		move.w	(a3)+,d0
		move.b	byte_18C0(pc,d1.w),d1
		sub.b	d0,d1
		ext.w	d1
		add.w	d3,d1
		swap	d1
		move.w	d0,d1
		move.b	d5,d1
		move.w	(a3)+,d0
		add.w	d4,d0
		eor.w	d7,d0
		swap	d0
		move.b	(a3)+,d0
		ext.w	d0
		add.w	d2,d0
		andi.w	#$1FF,d0
		bne.s	loc_18A6
		move.w	#1,d0

loc_18A6:
		move.l	d0,-(a5)
		move.l	d1,-(a5)
		tst.b	(a3)+
		beq.s	loc_1872

locret_18AE:
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
byte_18B0:	dc.b $F8,$F8,$F8,$F8
		dc.b $F0,$F0,$F0,$F0
		dc.b $E8,$E8,$E8,$E8
		dc.b $E0,$E0,$E0,$E0
byte_18C0:	dc.b $F8,$F0,$E8,$E0
		dc.b $F8,$F0,$E8,$E0
		dc.b $F8,$F0,$E8,$E0
		dc.b $F8,$F0,$E8,$E0
; ---------------------------------------------------------------------------
; ===========================================================================

loc_18D0:
		cmp.w	d6,d5
		bls.s	locret_1916
		subq.w	#1,d5
		moveq	#0,d1
		move.b	(a3),d1
		move.w	(a3)+,d0
		move.b	byte_18C0(pc,d1.w),d1
		sub.b	d0,d1
		ext.w	d1
		add.w	d3,d1
		swap	d1
		move.w	d0,d1
		move.b	d5,d1
		move.w	(a3)+,d0
		add.w	d4,d0
		eor.w	d7,d0
		swap	d0
		sub.w	d0,d0
		move.b	-4(a3),d0
		move.b	byte_18B0(pc,d0.w),d0
		sub.b	(a3)+,d0
		ext.w	d0
		add.w	d2,d0
		andi.w	#$1FF,d0
		bne.s	loc_190E
		move.w	#1,d0

loc_190E:
		move.l	d0,-(a5)
		move.l	d1,-(a5)
		tst.b	(a3)+
		beq.s	loc_18D0

locret_1916:
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to find a free object space
; ---------------------------------------------------------------------------

Objects_FindFreeSlot:					; Offset: 00001918
		move.l	d7,-(sp)				; store d7 data in the stack
		lea	($FFFFD83C).w,a0			; load Object Ram section 1 (04) number of objects
		move.w	-$04(a0,d0.w),d7			; collect the number of repeat times from the correct section slot
		lea	($FFFFD84C).w,a0			; load Object Ram section 1 (04) start address
		adda.w	d0,a0					; advance to correct section
		tst.w	($FFFFD84C).w				; are there any objects in section 1 (04)?
		beq.s	loc_193E				; if not, branch
		tst.l	d0					; is the section ID is negative?
		bpl.s	loc_1934				; if not, branch
		moveq	#$FFFFFFFF,d7				; set d7 to FFFFFFFF (Not sure exactly why)

loc_1934:
		tst.w	(a0)					; is the slot free?
		beq.s	loc_1946				; if so, branch
		movea.w	(a0),a0					; get next object slot location
		dbf	d7,loc_1934				; repeat til all slots have been checked for this section

loc_193E:
		move.l	(sp)+,d7				; reload data from d7
		ori	#$08,sr					; set answer negative (No free slot)
		rts						; return

loc_1946:
		move.w	($FFFFD84C).w,(a0)			; load previous object address into new object slot
		move.w	a0,d7					; load new object slot's address to d7
		movea.w	(a0),a0					; load previous object address to a0
		move.w	(a0),($FFFFD84C).w			; 
		clr.w	(a0)
		move.w	d7,2(a0)
		move.w	#$8000,4(a0)
		move.l	#Val_Unk,$10(a0)
		moveq	#0,d7
		move.l	d7,$20(a0)
		move.l	d7,8(a0)
		move.l	d7,$C(a0)
		movem.l	(sp)+,d7
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
Val_Unk:	dc.b $00,$00
		dc.b $00,$00
		dc.b $00,$FF
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; 
; ---------------------------------------------------------------------------

DeleteObject:
		move.l	a1,-(sp)
		tst.w	(a6)
		bpl.s	loc_198E
		movea.w	(a6),a1
		move.w	2(a6),2(a1)

loc_198E:
		movea.w	2(a6),a1
		move.w	(a6),(a1)
		move.w	($FFFFD84C).w,(a6)
		move.w	a6,($FFFFD84C).w
		movea.l	a1,a6
		movea.l	(sp)+,a1
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Unused subroutine
; ---------------------------------------------------------------------------

		move.l	a1,-(sp)
		tst.w	(a6)
		bpl.s	loc_19B0
		movea.w	(a6),a1
		move.w	2(a6),2(a1)

loc_19B0:
		movea.w	2(a6),a1
		move.w	(a6),(a1)
		movea.w	(a0),a1
		move.w	a1,(a6)
		move.w	a0,2(a6)
		move.w	a6,(a0)
		move.w	a6,2(a1)
		movea.l	(sp)+,a1
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Unused subroutine
; ---------------------------------------------------------------------------

		move.l	$18(a6),d0
		add.l	d0,8(a6)
		move.l	$1C(a6),d0
		add.l	d0,$C(a6)
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check if an object is within the screen's positions, and set
; a flag if not.
; ---------------------------------------------------------------------------

Object_ChkOffScreen:					; Offset: 000019DA
		moveq	#$00,d1					; clear d1
		move.w	$08(a0),d2				; load object's X position to d2
		sub.w	($FFFFC9DE).w,d2			; minus screen's X position
		cmpi.w	#$FFC0,d2				; is the object out of screen on left, more than 40 pixels?
		bge.s	OCOS_NoLeft				; if not, branch
		moveq	#$40,d1					; set offscreen flag

OCOS_NoLeft:						; Offset: 000019EC
		cmpi.w	#$0180,d2				; is the object out of screen on right, more than 3F pixels?
		blt.s	OCOS_NoRight				; if not, branch
		moveq	#$40,d1					; set offscreen flag

OCOS_NoRight:						; Offset: 000019F4
		addi.w	#$0080,d2				; add 80 to position
		move.w	$0C(a0),d3				; load Object's Y position
		sub.w	($FFFFC9EE).w,d3			; minus screen's Y position
		cmpi.w	#$FFC0,d3				; is the object out of screen from above, more than 40 pixels?
		bge.s	OCOS_NoUp				; if not, branch
		moveq	#$40,d1					; set offscreen flag

OCOS_NoUp:						; Offset: 00001A08
		cmpi.w	#$0120,d3				; is the object out of screen from below, more than 40 pixels?
		blt.s	OCOS_NoDown				; if not, branch
		moveq	#$40,d1					; set offscreen flag

OCOS_NoDown:						; Offset: 00001A10
		addi.w	#$0080,d3				; add 80 to position
		andi.w	#$FFBF,$04(a0)				; clear all flags except the offscreen flag
		or.w	d1,$04(a0)				; set the offscreen flag (if it was set previously in d4)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Unused subroutine
; ---------------------------------------------------------------------------

		bsr.w	sub_1A3C
		move.w	d7,d1
		add.w	d0,d1
		move.w	d6,d0
		move.w	d4,d2
		move.w	d5,d3
		move.w	a3,d4
		move.w	(a0),d5
		andi.w	#$F000,d5
		rol.w	#4,d5
		cmp.w	d7,d1
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; 
; ---------------------------------------------------------------------------

; Something to do with Collision's Rotation

sub_1A3C:
		movea.w	d4,a3
		move.w	d0,d6
		move.w	d1,d7
		move.w	d2,d4
		move.w	d3,d5
		bsr.w	Col_Find16x16Block
		move.w	(a0),d0
		andi.w	#$F000,d0
		rol.w	#4,d0
		lsl.w	#2,d0
		lea	($FF0200).l,a1
		move.w	a3,d1
		beq.s	loc_1A64
		lea	($FF0600).l,a1

loc_1A64:
		lea	(CollisionArrayRota).l,a2
		jmp	loc_1A6E(pc,d0.w)

; ===========================================================================
; ---------------------------------------------------------------------------
loc_1A6E:	bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C28
; ---------------------------------------------------------------------------
		bsr.w	sub_1AC8
		add.w	d7,d0
		move.w	d6,d1
		move.w	d5,d2
		move.w	d4,d3
		move.w	a3,d4
		move.w	(a0),d5
		andi.w	#$F000,d5
		rol.w	#4,d5
		cmp.w	d7,d0
		rts

; ---------------------------------------------------------------------------
; 
; ---------------------------------------------------------------------------

; Something to do with the Collision array

sub_1AC8:
		movea.w	d4,a3
		move.w	d0,d6
		move.w	d1,d7
		move.w	d2,d4
		move.w	d3,d5
		bsr.w	Col_Find16x16Block
		move.w	(a0),d0
		andi.w	#$F000,d0
		rol.w	#4,d0
		lsl.w	#2,d0
		lea	($FF0200).l,a1
		move.w	a3,d1
		beq.s	loc_1AF0
		lea	($FF0600).l,a1

loc_1AF0:
		exg	d6,d7
		exg	d4,d5
		lea	(CollisionArrayNorm).l,a2
		jmp	loc_1AFE(pc,d0.w)

; ===========================================================================
; ---------------------------------------------------------------------------
loc_1AFE:	bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C24
; ---------------------------------------------------------------------------
		bra.w	loc_1C28
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Collision Settings
; ---------------------------------------------------------------------------
; Collision format:
;
;	Collision blocks in the array are in reversed horizontally. The
;	collision ID's however are checked, if the ID is from 00 to EF, then
;	the collision continues as normal, if from F0 to FF, then the block
;	is set for flipping or mirroring, the flip or mirror is decided based
;	on the 0th bit of the ID, if it is an even value from F0 to FF, the
;	block is mirrored, if it is an odd value from F0 to FF, the block is
;	flipped insted.
;
; ---------------------------------------------------------------------------
; d0 = X position minus width
; d1 = Y position minus height
; d4 = Collision path character is on
; ---------------------------------------------------------------------------

sub_1B3E:						; Offset: 00001B3E
		move.w	d0,d6					; load X position to d6
		move.w	d1,d7					; load Y position to d7
		bsr.w	Col_Find16x16Block			; Find the block the character is standing on
		move.w	(a0),d0					; load block ID off of chunk
		move.w	d0,d3					; copy to d3
		swap	d3					; send to left side
		move.w	d0,d3					; recopy to right side too
		tst.w	d4					; is the character on the primary collision path?
		bne.s	loc_1B5C				; if not, branch
		lea	($00FF0200).l,a1			; load primary collision data location
		rol.w	#$02,d3					; get primary Top|left/Right/Down collision settings
		bra.s	loc_1B64				; continue...

loc_1B5C:						; Offset: 00001B5C
		lea	($00FF0600).l,a1			; load secondary collision data location
		rol.w	#$04,d3					; get secondary Top|left/Right/Down collision settings

loc_1B64:						; Offset: 00001B64
		andi.w	#$0003,d3				; get only the Top|left/Right/Down settings (clear rest of block data)
		swap	d3					; send to left side
		andi.w	#$03FF,d0				; get only the block ID (d0 = CCCCTTTT) (CCCC = Collision settings|TTTT = Tile ID)
		move.b	(a1,d0.w),d0				; load correct collision block ID based on level block's ID
		andi.w	#$00FF,d0				; d0 = CCCC--II (CCCC = Collision settings|II = Collision ID)
		lea	CurveResistMappings(pc),a3		; load resistance mappings (Angle Map) address to a3
		move.b	(a3,d0.w),d2				; load correct angle to d2
		cmpi.w	#$00F0,d0				; is the collision ID lower than F0?
		bcs.s	loc_1B90				; if so, branch
		moveq	#$0A,d1					; prepare bit number setting for mirroring
		btst	#$00,d0					; is the collision ID an odd value?
		beq.s	loc_1B8E				; if not, branch
		addq.w	#$01,d1					; add 1 (bit number setting for flipping now)

loc_1B8E:						; Offset: 00001B8E
		bchg	d1,d3					; change the mirror or flip settings on the block based on the collision ID's flipping

loc_1B90:						; Offset: 00001B90
		lsl.w	#$04,d0					; multiply collision ID by 10 (10 per collision block)
		lea	(CollisionArrayRota).l,a1		; load rotational collision address to a1
		lea	(CollisionArrayNorm).l,a2		; load Normal collision address to a2
		lea	(a1,d0.w),a1				; load address of collision block the character is standing on
		lea	(a2,d0.w),a2				; ''
		moveq	#$0F,d0					; prepare 0F (Far right of collision block)
		moveq	#$0F,d1					; ''
		and.w	d6,d0					; and X pos of collision block location
		and.w	d7,d1					; and Y pos of collision block location
		andi.w	#$0C00,d3				; get only the flip/mirror status of the level block
		rol.w	#$07,d3					; send to far right and multiply by 2
		jsr	locret_1BC6(pc,d3.w)			; run routine to correct the information based on block's flip/mirror status
		ror.w	#$07,d3					; restore d3 to normal
		swap	d3					; send back to left side
		adda.w	d0,a1					; add X pos to rotational block
		adda.w	d1,a2					; add Y pos to normal block
		move.w	d6,d0					; restore X pos back into d0
		move.w	d7,d1					; restore X pos back into d1
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Collision Block reading routines
; ---------------------------------------------------------------------------
; Normal Block
; ---------------------------------------------------------------------------

locret_1BC6:						; Offset: 00001BC6
		rts						; return (Block is already setup)

; ---------------------------------------------------------------------------
; Mirrored Block
; ---------------------------------------------------------------------------

		bra.s	loc_1BDE				; run mirrored block routine

; ---------------------------------------------------------------------------
; Flipped Block
; ---------------------------------------------------------------------------

		bra.s	loc_1BE8				; run flipped block routine

; ---------------------------------------------------------------------------
; Flipped & Mirrored Block / flipped & mirrored block routine
; ---------------------------------------------------------------------------

		addi.b	#-$80,d2				; add -80 to angle map ID (up-side down)
		neg.w	d1					; reverse position of Y collision location
		addi.w	#$0F,d1					; keep back within 0F
		neg.w	d0					; reverse position of X collision location
		addi.w	#$0F,d0					; keep back within 0F
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; mirrored block routine
; ---------------------------------------------------------------------------

loc_1BDE:
		neg.b	d2					; negate angle map to opposite (reversed L/R direction)
		neg.w	d0					; reverse position of X collision location
		addi.w	#$0F,d0					; keep back within 0F
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Flipped Block
; ---------------------------------------------------------------------------

loc_1BE8:
		neg.b	d2					; negate angle map to opposite (reversed L/R direction)
		addi.b	#-$80,d2				; add -80 to angle map ID (up-side down)
		neg.w	d1					; reverse position of Y collision location
		addi.w	#$0F,d1					; keep back within 0F
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to find the block the character is colliding with on a chunk
; ---------------------------------------------------------------------------
; d0 = X position minus width
; d1 = Y position minus height
; ---------------------------------------------------------------------------

Col_Find16x16Block:					; Offset: 00001BF6
		moveq	#$70,d2					; prepare 70 for X..
		moveq	#$70,d3					; ...and Y
		and.w	d0,d2					; d2 = X position within 70 in multiples of 10
		and.w	d1,d3					; d3 = Y position within 70 in multiples of 10
		lsr.w	#$03,d2					; send X pos right a nybble and multiply by 2 (for reading a word at a time, word per block)
		add.w	d2,d3					; d3 = Block position on chunk (Number of bytes to add on chunk)
		lsr.w	#$07,d0					; Divide X pos by 80
		lsr.w	#$07,d1					; Divide Y pos by 80
		move.b	($FFFFC9E4).w,d2			; load number of X chunks to d2 (04 = TTZ | 07 = SSZ)
		lsl.w	d2,d1					; multiply Y pos by X max size (Y = Y / 80 / X Max)
		add.w	d0,d1					; add X position to it
		movea.l	($FFFFC9FE).w,a0			; load layout address to a0
		move.b	(a0,d1.w),d2				; get correct chunk ID character is standing on
		lsl.w	#$07,d2					; multiply by 80 (Size of one chunk)
		add.w	d3,d2					; add block's position on chunk
		movea.l	($FFFFCA02).w,a0			; load chunk address to a0
		lea	(a0,d2.w),a0				; load correct address of the block on the chunk data
		rts						; return

; ===========================================================================

loc_1C24:
		moveq	#0,d0
		rts

; ===========================================================================

loc_1C28:
		move.w	(a0),d0
		move.w	d0,d2
		moveq	#0,d1
		andi.w	#$3FF,d0
		move.b	(a1,d0.w),d1
		move.w	d1,d0
		lsl.w	#4,d0
		lea	(a2,d0.w),a1
		cmpi.w	#$F0,d1
		bcs.s	loc_1C50
		moveq	#$A,d0
		btst	#0,d1
		beq.s	loc_1C4E
		addq.w	#1,d0

loc_1C4E:
		bchg	d0,d2

loc_1C50:
		andi.w	#$C00,d2
		rol.w	#6,d2
		moveq	#$F,d0
		and.w	d6,d0
		tst.w	d5
		bmi.s	loc_1C60
		addq.w	#4,d2

loc_1C60:
		add.w	d2,d2
		move.w	word_1C6A(pc,d2.w),d2
		jmp	word_1C6A(pc,d2.w)

; ===========================================================================
; ---------------------------------------------------------------------------
word_1C6A:	dc.w	W1C6A_loc01-word_1C6A
		dc.w	W1C6A_loc03-word_1C6A
		dc.w	W1C6A_loc05-word_1C6A
		dc.w	W1C6A_loc07-word_1C6A
		dc.w	W1C6A_loc00-word_1C6A
		dc.w	W1C6A_loc02-word_1C6A
		dc.w	W1C6A_loc04-word_1C6A
		dc.w	W1C6A_loc06-word_1C6A
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
W1C6A_loc00:
		adda.w	d0,a1
		move.b	(a1),d0
		move.w	d7,d1
		andi.w	#$F,d1
		sub.w	d1,d0
		subq.w	#1,d0
		bpl.s	loc_1C24
		rts
; ---------------------------------------------------------------------------
W1C6A_loc01:
		adda.w	d0,a1
		move.b	(a1),d0
		cmpi.w	#$10,d0
		beq.s	loc_1C24
		move.w	d7,d0
		andi.w	#$F,d0
		neg.w	d0
		addi.w	#$10,d0
		rts
; ---------------------------------------------------------------------------
W1C6A_loc02:
		neg.w	d0
		lea	$F(a1,d0.w),a1
		move.b	(a1),d0
		ext.w	d0
		move.l	d7,d1
		andi.w	#$F,d1
		sub.w	d1,d0
		subq.w	#1,d0
		bpl.w	loc_1C24
		rts
; ---------------------------------------------------------------------------
W1C6A_loc03:
		neg.w	d0
		lea	$F(a1,d0.w),a1
		move.b	(a1),d0
		cmpi.b	#$10,d0
		beq.w	loc_1C24
		move.w	d7,d0
		andi.w	#$F,d0
		neg.w	d0
		addi.w	#$10,d0
		rts
; ---------------------------------------------------------------------------
W1C6A_loc04:
		adda.w	d0,a1
		move.b	(a1),d0
		cmpi.b	#$10,d0
		beq.w	loc_1C24
		move.w	d7,d0
		andi.w	#$F,d0
		addq.w	#1,d0
		neg.w	d0
		rts
; ---------------------------------------------------------------------------
W1C6A_loc05:
		adda.w	d0,a1
		move.b	(a1),d0
		neg.w	d0
		addi.w	#$F,d0
		move.w	d7,d1
		andi.w	#$F,d1
		sub.w	d0,d1
		bgt.w	loc_1C24
		neg.w	d1
		addq.w	#1,d1
		move.w	d1,d0
		rts
; ---------------------------------------------------------------------------
W1C6A_loc06:
		neg.w	d0
		lea	$F(a1,d0.w),a1
		move.b	(a1),d0
		cmpi.b	#$10,d0

loc_1D1E:
		beq.w	loc_1C24
		move.w	d7,d0
		andi.w	#$F,d0
		addq.w	#1,d0
		neg.w	d0
		rts
; ---------------------------------------------------------------------------
W1C6A_loc07:
		neg.w	d0
		lea	$F(a1,d0.w),a1
		move.b	(a1),d0
		ext.w	d0
		neg.w	d0
		addi.w	#$F,d0
		move.w	d7,d1
		andi.w	#$F,d1
		sub.w	d0,d1
		bgt.w	loc_1C24
		neg.w	d1
		addq.w	#1,d1
		move.w	d1,d0
		rts
; ---------------------------------------------------------------------------
W1C6A_loc08:
		swap	d0
		swap	d1
		movea.w	d2,a3
		move.w	d0,d6
		move.w	d1,d7
		bsr.w	Col_Find16x16Block
		move.w	(a0),d0
		move.w	a3,d1
		lea	($FF0200).l,a1
		beq.s	loc_1D72
		lea	($FF0600).l,a1

loc_1D72:
		move.w	d0,d1
		andi.w	#$3FF,d0
		andi.w	#$C00,d1
		rol.w	#6,d1
		adda.w	d0,a1
		moveq	#0,d0
		move.b	(a1),d0
		lea	CurveResistMappings(pc),a1
		move.b	(a1,d0.w),d0
		add.w	d1,d1
		jmp	locret_1D92(pc,d1.w)

; ===========================================================================
; ---------------------------------------------------------------------------
locret_1D92:	rts
; ---------------------------------------------------------------------------
		bra.s	loc_1D9C
; ---------------------------------------------------------------------------
		bra.s	loc_1D9C
; ---------------------------------------------------------------------------
		bra.s	loc_1DA4
; ---------------------------------------------------------------------------
		bra.s	loc_1D9E
; ---------------------------------------------------------------------------
; ===========================================================================

loc_1D9C:
		neg.b	d0

loc_1D9E:
		addi.b	#-$80,d0
		rts

loc_1DA4:
		neg.b	d0
		rts

sub_1DA8:
		tst.b	$1C(a6)
		bpl.s	loc_1DB2
		cmp.w	d0,d0
		rts

loc_1DB2:
		move.w	d0,d6
		move.w	d1,d7
		bsr.w	Col_Find16x16Block
		move.w	(a0),d0
		move.w	d0,d1
		andi.w	#$C000,d0
		beq.w	loc_1E0C
		move.w	d1,d0
		andi.w	#$3FF,d0
		lea	($FF0200).l,a1
		move.b	(a1,d0.w),d0
		andi.w	#$FF,d0
		lsl.w	#4,d0
		lea	(CollisionArrayRota).l,a1
		adda.w	d0,a1
		moveq	#$F,d0
		and.w	d6,d0
		btst	#$A,d1
		beq.s	loc_1DF4
		neg.w	d0
		addi.w	#$F,d0

loc_1DF4:
		adda.w	d0,a1
		move.b	(a1),d0
		cmpi.b	#$10,d0
		beq.s	loc_1E0C
		move.w	d6,d0
		move.w	#$FFF0,d1
		and.w	d7,d1
		subq.w	#1,d1
		cmp.w	d1,d7
		rts

loc_1E0C:
		move.w	d6,d0
		move.w	d7,d1
		cmp.w	d1,d7
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
CollisionArrayNorm:
		incbin	Collision\CollisionArray_Normal.bin
		even
CollisionArrayRota:
		incbin	Collision\CollisionArray_Rotated.bin
		even
CurveResistMappings:
		incbin	Collision\CurveAndResistanceMappings.bin
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to calculate the Circular sinewave
; ---------------------------------------------------------------------------

CalcSine:
		move.w	d2,d0
		add.w	d0,d0
		andi.w	#$1FE,d0
		move.w	Data_Sinewave(pc,d0.w),d1
		addi.w	#$80,d0
		move.w	Data_Sinewave(pc,d0.w),d0
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Sinewave Data
; ---------------------------------------------------------------------------
Data_Sinewave:	incbin	"Uncompressed/Misc_Sinewave.bin"
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to calculate the Angle between two X and Y positions (arctangent)
; ---------------------------------------------------------------------------

CalcAngle:
		movem.l	d1-d5,-(sp)
		sub.w	d1,d3					; minus point A's X pos from point B's
		beq.s	loc_4204				; if they're at the same position, branch
		smi	d0					; if point B is behind point A, set d0
		bpl.s	loc_41B8				; if point B is infront of point A, branch
		neg.w	d3					; convert X distance to positive

loc_41B8:
		sub.w	d2,d4					; minus point A's Y pos from point B's
		beq.s	loc_4216				; if they're at the same position, branch
		smi	d5					; if point B is above point A, set d5
		bpl.s	loc_41C2				; if point B is below point A, branch
		neg.w	d4					; convert Y distance to positive

loc_41C2:
		ext.l	d4					; sign extend as long-word
		asl.l	#$08,d4					; multiply by 100
		divu.w	d3,d4					; divide Y distance by X distance
		moveq	#$00,d1					; clear d1
		moveq	#$3F,d2
		swap	d5					; store Y direction

loc_41CE:
		move.w	d2,d3
		add.w	d1,d3
		lsr.w	#1,d3
		move.w	d3,d5
		add.w	d5,d5
		cmp.w	Data_angles(pc,d5.w),d4
		bcs.s	loc_41E2
		move.w	d3,d1
		move.w	d2,d3

loc_41E2:
		move.w	d3,d2
		sub.w	d1,d3
		subq.w	#1,d3
		bne.s	loc_41CE
		swap	d5
		andi.w	#$80,d0
		eor.b	d0,d5
		bpl.s	loc_41FC
		sub.b	d2,d0
		movem.l	(sp)+,d1-d5
		rts

loc_41FC:
		add.b	d2,d0
		movem.l	(sp)+,d1-d5
		rts

loc_4204:
		sub.w	d2,d4					; minus point A's Y pos from point B's
		smi	d0					; if negative, set d0
		andi.w	#$80,d0					; keep in range
		addi.w	#$40,d0					; increase right
		movem.l	(sp)+,d1-d5
		rts

loc_4216:
		andi.w	#$80,d0
		movem.l	(sp)+,d1-d5
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Angles Data
; ---------------------------------------------------------------------------
Data_angles:	incbin	"Uncompressed/Misc_Angles.bin"
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to calculate the distance between two X and Y positions on a 360 radius
; ---------------------------------------------------------------------------

Calc360:
		move.l	d0,d1					; load the X*X+Y*Y calculation to d1
		moveq	#0,d2					; clear d2
		moveq	#0,d3					; clear d3
		moveq	#$F,d4					; set repeat times

loc_42A8:
		add.w	d0,d0
		add.l	d1,d1
		addx.l	d3,d3
		add.l	d1,d1
		addx.l	d3,d3
		add.l	d2,d2
		addq.l	#1,d2
		cmp.l	d2,d3
		bcs.s	loc_42C6
		addq.w	#1,d0
		sub.l	d2,d3
		addq.l	#1,d2
		dbf	d4,loc_42A8
		rts

loc_42C6:
		subq.l	#1,d2
		dbf	d4,loc_42A8
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to
; ---------------------------------------------------------------------------

sub_42CE:
		movem.l	d0-d1/d3-d5,-(sp)
		move.w	d0,d3
		move.w	d1,d4
		moveq	#0,d1
		moveq	#0,d2
		sub.w	d1,d3
		beq.s	loc_433E
		smi	d0
		bpl.s	loc_42E4
		neg.w	d3

loc_42E4:
		sub.w	d2,d4
		beq.s	loc_4356
		smi	d5
		bpl.s	loc_42EE
		neg.w	d4

loc_42EE:
		ext.l	d4
		asl.l	#8,d4
		divu.w	d3,d4
		moveq	#0,d1
		moveq	#$3F,d2
		swap	d5

loc_42FA:
		move.w	d2,d3
		add.w	d1,d3
		lsr.w	#1,d3
		move.w	d3,d5
		add.w	d5,d5
		cmp.w	word_4368(pc,d5.w),d4
		bcs.s	loc_430E
		move.w	d3,d1
		move.w	d2,d3

loc_430E:
		move.w	d3,d2
		sub.w	d1,d3
		subq.w	#1,d3
		bne.s	loc_42FA
		swap	d5
		andi.w	#$80,d0
		eor.b	d0,d5
		bpl.s	loc_4330
		sub.b	d2,d0
		move.b	d0,d2
		movem.l	(sp)+,d0-d1/d3-d5
		addq.b	#8,d2
		andi.b	#$F0,d2
		rts

loc_4330:
		add.b	d0,d2
		movem.l	(sp)+,d0-d1/d3-d5
		addq.b	#8,d2
		andi.b	#$F0,d2
		rts

loc_433E:
		sub.w	d2,d4
		smi	d2
		andi.w	#$80,d2
		addi.w	#$40,d2
		movem.l	(sp)+,d0-d1/d3-d5
		addq.b	#8,d2
		andi.b	#$F0,d2
		rts

loc_4356:
		andi.w	#$80,d0
		move.b	d0,d2
		movem.l	(sp)+,d0-d1/d3-d5
		addq.b	#8,d2
		andi.b	#$F0,d2
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; 
; ---------------------------------------------------------------------------

; sinewave??	this is possibly the original sinewave while the one above is
;		probably a co-sinewave or second sinewave of somekind.

word_4368:	dc.w	$0000
		dc.w	$0006
		dc.w	$000D
		dc.w	$0013
		dc.w	$0019
		dc.w	$0020
		dc.w	$0026
		dc.w	$002C
		dc.w	$0033
		dc.w	$0039
		dc.w	$0040
		dc.w	$0047
		dc.w	$004E
		dc.w	$0055
		dc.w	$005C
		dc.w	$0063
		dc.w	$006A
		dc.w	$0071
		dc.w	$0079
		dc.w	$0081
		dc.w	$0089
		dc.w	$0091
		dc.w	$0099
		dc.w	$00A2
		dc.w	$00AB
		dc.w	$00B4
		dc.w	$00BE
		dc.w	$00C8
		dc.w	$00D2
		dc.w	$00DD
		dc.w	$00E8
		dc.w	$00F4
		dc.w	$0100
		dc.w	$010D
		dc.w	$011A
		dc.w	$0129
		dc.w	$0138
		dc.w	$0148
		dc.w	$0159
		dc.w	$016B
		dc.w	$017F
		dc.w	$0194
		dc.w	$01AB
		dc.w	$01C4
		dc.w	$01DF
		dc.w	$01FD
		dc.w	$021D
		dc.w	$0242
		dc.w	$026A
		dc.w	$0298
		dc.w	$02CB
		dc.w	$0307
		dc.w	$034C
		dc.w	$039D
		dc.w	$03FE
		dc.w	$0474
		dc.w	$0507
		dc.w	$05C3
		dc.w	$06BE
		dc.w	$081C
		dc.w	$0A27
		dc.w	$0D8F
		dc.w	$145B
		dc.w	$28BC

		dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	$008A
		dc.w	$008D
		dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	$008A
		dc.w	$008D
		dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	$008B
		dc.w	$008E
		dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	$0000

		dc.w	$487F
		dc.w	$3E34
		dc.w	$023F
		dc.w	$BFE5
		dc.w	$7292
		dc.w	$74E3
		dc.w	$531A
		dc.w	$7CDA
		dc.w	$6500
		dc.w	$1251
		dc.w	$FF51
		dc.w	$FF4C
		dc.w	$044E
		dc.w	$7616
		dc.w	$38E2
		dc.w	$C844
		dc.w	$4530
		dc.w	$5212
		dc.w	$51FF
		dc.w	$51FF
		dc.w	$51FF
		dc.w	$4C04
		dc.w	$4E48
		dc.w	$4102
		dc.w	$21C8
		dc.w	$4C01
		dc.w	$4101
		dc.w	$4E08
		dc.w	$1000
		dc.w	$4AD8
		dc.w	$6730
		dc.w	$D802
		dc.w	$0006
		dc.w	$004E
		dc.w	$0064
		dc.w	$4300
		dc.w	$41D3
		dc.w	$7220
		dc.w	$51FF
		dc.w	$3000
		dc.w	$616B
		dc.w	$6171
		dc.w	$0281
		dc.w	$C933
		dc.w	$C900
		dc.w	$0042
		dc.w	$D84E
		dc.w	$0095
		dc.w	$6103
		dc.w	$4E00
		dc.w	$F14E
		dc.w	$1531
		dc.w	$00D8
		dc.w	$3100
		dc.w	$D831
		dc.w	$00D8
		dc.w	$3100
		dc.w	$D84E
		dc.w	$00BE
		dc.w	$4E00
		dc.w	$D14E
		dc.w	$00EF
		dc.w	$4E00
		dc.w	$8C46
		dc.w	$234E
		dc.w	$008C
		dc.w	$4E00
		dc.w	$ED4A
		dc.w	$D866
		dc.w	$42D8
		dc.w	$42D8
		dc.w	$42C9
		dc.w	$42C9
		dc.w	$42CA
		dc.w	$42CA
		dc.w	$616C
		dc.w	$0081
		dc.w	$C933
		dc.w	$C900
		dc.w	$0061
		dc.w	$6B4E
		dc.w	$00F9
		dc.w	$6000

PAL_Unknown_1:	dc.w	$0A00,$060A,$0E0E,$0E0C,$0E08,$0000,$0000,$0000
		dc.w	$0A00,$060A,$0E08,$0402,$0008,$0000,$0204,$0000
		even

		dc.b $82, $83, $84, $85, $8D, $90, $87,	$8B, $8C, $91, $92, 0, $48, 0, $89, 8
		dc.b 0,	$FF, $4A, $FF, $6A, $61, $69, $4E, 0, $8A, $4E,	0, $8B,	$4E, 0,	$CC
		dc.b $4E, 0, $A1, $4E, 0, $95, $4E, 0, $F1, $4E, 0, $D2, $4E, 0, $EB, $4E
		dc.b 0,	$F9, $46, $27, $4E, $16, $46, $23, $4E,	$4E, 9,	$47, $C9, $72, $12, $D8
		dc.b $70, $C0, $10, $56, $10, $10, $12,	2, 0, $56, $82,	2, 0, $80, $49,	$FB
		dc.b $12, $FF, 2, 0, $14, $10, $19, $10, $52, $FF, $19,	$FF, $49, $D8, $61, 0
		dc.b $10, $FA, $47, $C9, $72, $12, $D8,	$6B, $70, $C0, $10, $56, $10, $10, $12,	2
		dc.b 0,	$56, $82, 2, 0,	$80, $49, $D8, $60, 0, $19, 0, 0, $19, 0, $12
		dc.b 0,	$B1, $67, $42, 0, $52, 0, $C2, $19, 0, 2, 0, $19, 0, 0,	$72
		dc.b $C2, $E2, $48, $34, $48, $84, $39,	0, 2, 0, $E6, $48, $32,	$48, $82, $39
		dc.b 0,	$4E, 0,	$40, $80, $60, 0, $20, $80, $60, $48, $FF, $4E,	0, $9F,	$4E
		dc.b 4,	$4E, 4,	$4E, 0,	$C9, $20, $FF, $D1, $32, $D8, $34, 1, $4E, 5, $47
		dc.b 0,	$A, $49, 0, $B,	$4B, $C9, $4E, $14, $47, 0, $B,	$49, 0,	$C, $4B
		dc.b $CA, $4E, $14, 0, 0, $FF, $52, $F0, $4C, $7F, $4E,	$4A, $D8, $6A, 0, $10
		dc.b $C9, 2, 0,	$C, 0, $66, $46, $27, $91, $2E,	$20, $4E, $48, $FF, 8, 0
		dc.b $FF, $4A, $FF, $6A, $4E, 0, $8A, $30, $D8,	$32, $D8, $D0, $D0, $D2, $D2, $30
		dc.b $D8, $D1, 0, $D3, 0, $30, $D8, $D1, 0, $D3, 0, $4E, 0, $CC, $4E, 0
		dc.b $95, $4E, $16, $61, $67, $4A, $C9,	$6A, $4C, $7F, $4E, $70, $30, $D8, 2, 0
		dc.b $E5, $20, 0, $43, 0, $34, $36, $4E, $3F, 7, 7, $F,	0, $23,	0, $23
		dc.b 0,	$23, 0,	$23, $4A, $D8, $67, $46, $27, $41, 0, $1B, $23,	$40, 0,	0
		dc.b 0,	$4E, $D, $46, $27, $41,	0, $22,	$23, $7E, 0, 0,	0, $4E,	$D, $46
		dc.b $27, $41, 0, $1F, $23, $77, 0, 0, 0, $4E, $D, $4E,	$43, 0,	$8C, $70
		dc.b $30, $C, $FF, $67,	$48, $FF, $20, $E5, $E4, 0, $40, $48, 2, 0, $46, $27
		dc.b $23, 0, 0,	$4E, $D, $4C, $7F, $60,	$4E, $80, 0, $1B, $7E, 0, $22, $77
		dc.b 0,	$1F, $FF, $72, $32, $D8, 2, 0, $E3, $4E, $10, $60, $60,	$4E, $70, $30
		dc.b $D8, 2, 0,	$ED, $43, 0, $8D, $D3, $41, $D4, $1E, 0, $30, $51, $FF,	$4E


; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Main Game Program
; ---------------------------------------------------------------------------

MainProg_Loop:						; Offset: 00005000
		move.w	($FFFFD822).w,d0			; load Screen/Game mode to d0
		andi.w	#$78,d0					; keep within 80
		jsr	GameModeArray(pc,d0.w)			; run through correct mode routine
		bra.s	MainProg_Loop				; loop

; ===========================================================================
; ---------------------------------------------------------------------------
; Main Game mode array
; ---------------------------------------------------------------------------
; The "nop"s you see below do not get read as code, they are there to take up
; the space of 2 bytes, the "jmp" commands take up 6 bytes, 6 + 2 = 8 bytes.
; 8 bytes is the size in which the Screen/Game mode IDs are set.
; ---------------------------------------------------------------------------

GameModeArray:						; Offset: 0000500E
		jmp	(SegaScreen).l				; (00) SEGA screen
		nop
		jmp	(TitleScreen).l				; (08) Title Screen
		nop
		jmp	(Fields).l				; (10) Fields Screen
		nop
		jmp	Levels					; (18) Level Zones
		nop
		jmp	SpecialStage				; (20) Special Stage
		nop
		jmp	UnkRet001				; (28) Null
		nop
		jmp	LevelSelect				; (30) "SELECT" (Level Select)
		nop
		jmp	UnkRet002				; (38) Null
		nop
		jmp	OptionsSoundTest			; (40) "OPTION" (Sound Test) 
		nop
		jmp	(GMAReturn).l				; (48) Null
		nop
		jmp	(GMAReturn).l				; (50) Null
		nop
		jmp	(GMAReturn).l				; (58) Null
		nop
		jmp	(GMAReturn).l				; (60) Null
		nop
		jmp	(GMAReturn).l				; (68) Null
		nop
		jmp	(GMAReturn).l				; (70) Null
		nop
		jmp	(GMAReturn).l				; (78) Null
		nop

; ===========================================================================
; ---------------------------------------------------------------------------
; Game Mode Array universal returning subroutine
; ---------------------------------------------------------------------------

GMAReturn:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to map a word hexadecimal number on screen for menus
; ---------------------------------------------------------------------------
; d0 = number ID
; d1 = V-Ram plane map location
; ---------------------------------------------------------------------------

MapNumbers:						; Offset: 00005090
		moveq	#$00,d3					; clear d3
		move.w	d1,d3					; load V-Ram location to d3
		lsl.l	#$02,d3					; send far left bits to left side
		lsr.w	#$02,d3					; and send the rest back
		ori.w	#$4000,d3				; set V-Ram write mode (Map location)
		swap	d3					; swap sides
		move.l	d3,($C00004).l				; set VDP to V-Ram write mode with location
		move.w	d0,d1					; load number to print on screen
		rol.w	#$04,d1					; get first far left nybble
		bsr.s	MN_DumpNybble				; dump nybble ID to map
		rol.w	#$04,d1					; get second nybble
		bsr.s	MN_DumpNybble				; dump it to map
		rol.w	#$04,d1					; get third nybble
		bsr.s	MN_DumpNybble				; dump to map
		rol.w	#$04,d1					; get forth nybble
						; Continue to..	; dump to map

MN_DumpNybble:						; Offset: 000050B4
		move.w	d1,d2					; copy ID to d2
		andi.w	#$000F,d2				; get only the far right nybble
		move.w	#$0000,d3				; clear d0
		add.b	MN_HexIDs(pc,d2.w),d3			; collect correct map ID for hex ID
		move.w	d3,($C00000).l				; save the map location in V-Ram
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; V-Ram map hex ID's for ASCII letters (10 - 19 = 0 to 9) (21 - 26 = A to F)
; ---------------------------------------------------------------------------
MN_HexIDs:						; Offset: 000050CA
		dc.b	$10,$11,$12,$13,$14,$15,$16,$17
		dc.b	$18,$19,$21,$22,$23,$24,$25,$26
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; 
; ---------------------------------------------------------------------------

		movem.l	d2-d6/a0-a1,-(sp)
		moveq	#0,d3
		move.w	d1,d3
		lsl.l	#2,d3
		lsr.w	#2,d3
		ori.w	#$4000,d3
		swap	d3
		move.l	d3,($C00004).l
		cmpi.w	#$FFFF,d0
		bcs.s	loc_50FC
		move.w	#$FFFF,d0

loc_50FC:				; CODE XREF: ROM:000050F6j
		lea	loc_5152(pc),a0
		moveq	#4,d1
		move.w	#0,d4
		move.w	#$10,d5
		moveq	#0,d6
		lea	($C00000).l,a1
		tst.w	d0
		beq.s	loc_5142

loc_5116:				; CODE XREF: ROM:loc_5138j
		moveq	#0,d2
		move.w	(a0)+,d3

loc_511A:				; CODE XREF: ROM:00005120j
		sub.w	d3,d0
		bcs.s	loc_5122
		addq.w	#1,d2
		bra.s	loc_511A
; ---------------------------------------------------------------------------

loc_5122:				; CODE XREF: ROM:0000511Cj
		add.w	d3,d0
		tst.b	d6
		bne.s	loc_5130
		tst.w	d2
		beq.s	loc_5136
		move.b	#1,d6

loc_5130:				; CODE XREF: ROM:00005126j
		add.w	d5,d2
		move.w	d2,(a1)
		bra.s	loc_5138
; ---------------------------------------------------------------------------

loc_5136:				; CODE XREF: ROM:0000512Aj
		move.w	d4,(a1)

loc_5138:				; CODE XREF: ROM:00005134j
		dbf	d1,loc_5116
		movem.l	(sp)+,d2-d6/a0-a1
		rts
; ---------------------------------------------------------------------------

loc_5142:				; CODE XREF: ROM:00005114j
		subq.w	#1,d1

loc_5144:				; CODE XREF: ROM:00005146j
		move.w	d4,(a1)
		dbf	d1,loc_5144
		move.w	d5,(a1)
		movem.l	(sp)+,d2-d6/a0-a1
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
loc_5152:						; Offset: 00005152
		dc.w	$2710
		dc.w	$03E8
		dc.w	$0064
		dc.w	$000A
		dc.w	$0001
		dc.w	$7400
		dc.w	$3400
		dc.w	$E58A
		dc.w	$E44A
		dc.w	$0042
		dc.w	$4000
		dc.w	$4842
		dc.w	$23C2
		dc.w	$00C0
		dc.w	$0004
		dc.w	$7000
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Unknown subroutine to move data to the VDP's V-Ram
; ---------------------------------------------------------------------------

UnknownRout002:						; Offset: 00005172
		move.b	(a0)+,d0				; load data
		bmi.s	UR002_Return				; if it's negative, branch
		subi.w	#$0020,d0				; minus 20
		addi.w	#$0000,d0				; add 00?
		or.w	d1,d0					; set unknown bits of data in d1 onto d0
		move.w	d0,($C00000).l				; save to VDP's ram (unknown location)
		bra.s	UnknownRout002				; loop

UR002_Return:						; Offset: 00005188
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load the Z80
; ---------------------------------------------------------------------------

Z80Load:						; Offset: 0000518A
		move	#$2700,sr				; set the status register (disable interrupts)
		move.w	#$100,($A11100).l			; request Z80 hult (ON)

Z80WaitStop:						; Offset: 00005196
		btst	#0,($A11100).l				; has the Z80 stopped?
		bne.s	Z80WaitStop				; if not, recheck til stopped
		move.w	#$100,($A11200).l			; request Z80 reset (OFF)
		lea	Z80Rom(pc),a0				; load Z80 location on Rom to a0
		lea	($A00000).l,a1				; load current Z80 Ram
		move.w	#(Z80Rom_End-Z80Rom)-$01,d0		; set repeat times

Z80DumpRep:						; Offset: 000051B6
		move.b	(a0)+,(a1)+				; dump Z80 to Z80 Ram
		dbf	d0,Z80DumpRep				; repeat til Z80 is dumped

Z80WaitEnd:						; Offset: 000051BC
		move.b	#0,(a1)+				; clear the remaining Z80 space
		cmpa.l	#$A02000,a1				; has the end of Z80 been reached?
		bne.s	Z80WaitEnd				; if not, loop til it has
		move.w	#$0000,($A11200).l			; request Z80 reset (ON)
		moveq	#$7F,d0					; set repeat times

Z80Lag:							; Offset: 000051D2
		dbf	d0,Z80Lag				; loop? (I think this simply lags the system for a short while)
		move.w	#0,($A11100).l				; request z80 hult (OFF)
		move.w	#$100,($A11200).l			; request Z80 reset (OFF)
		move	#$2300,sr				; set the status register (enable interrupts)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
Z80Rom:							; Offset: 000051EC
		incbin	Z80\Z80.bin				; Zilog	Z80 ROM
Z80Rom_End:	even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to save BGM number to Z80 to play music
; ---------------------------------------------------------------------------

PlayMusic:						; Offset: 00006402
		move.w	#$100,($A11100).l			; stop the Z80

PM_WaitZ80:						; Offset: 0000640A
		btst	#0,($A11100).l				; has the Z80 stopped?
		bne.s	PM_WaitZ80				; if not, loop til stopped
		move.b	d0,($A01C0A).l				; save BGM number to Z80
		move.w	#0,($A11100).l				; start the Z80
		rts						; return

Play_Sound:	;	ported from S3K
		move.w	#$100,($A11100).l

loc_15EA:
		btst	#0,($A11100).l
		bne.s	loc_15EA
		move.b	d0,($A00000+$1C0A).l
		move.w	#0,($A11100).l
		rts
; End of function Play_Sound

; ---------------------------------------------------------------------------

Play_Sound_Local:
		tst.b	4(a0)
		bpl.s	locret_164A

; =============== S U B R O U T I N E =======================================


Play_Sound_2:
		move.w	#$100,($A11100).l

loc_1612:
		btst	#0,($A11100).l
		bne.s	loc_1612
		cmp.b	($A00000+$1C0B).l,d0
		beq.s	loc_1642
		tst.b	($A00000+$1C0B).l
		bne.s	loc_163C
		move.b	d0,($A00000+$1C0B).l
		move.w	#0,($A11100).l
		rts
; ---------------------------------------------------------------------------

loc_163C:
		move.b	d0,($A00000+$1C0C).l

loc_1642:
		move.w	#0,($A11100).l

locret_164A:
		rts
; End of function Play_Sound_2

; ===========================================================================
; ---------------------------------------------------------------------------
; Sega Screen (Mode: 00)
; ---------------------------------------------------------------------------

SegaScreen:						; Offset: 00006424
		pea	(a0)					; send a0 data to the stack
		lea	VB_SegaScreen(pc),a0			; load location V-Blank routine to run
		move.l	a0,($FFFFC832).w			; set to run it during Sega Screen
		movem.l	(sp)+,a0				; reload a0 data from stack
		jsr	(Z80Load).l				; load the Z80
	;	move	#$2700,sr				; set the status register (disable interrupts)
		lea	SS_VDPRegData(pc),a0			; load VDP register setup values
		jsr	StoreVDPRegisters			; save VDP register data to ram spaces
		bra.s	SS_Start				; continue

; ===========================================================================
; ---------------------------------------------------------------------------
SS_VDPRegData:						; Offset: 00006442
		dc.w	$8230					; [Scroll Plane A Map Table VRam address: $C000];
		dc.w	$8407					; [Scroll Plane B Map Table VRam address: $E000];
		dc.w	$833C					; [Window Plane A Map Table VRam address: $F000];
		dc.w	$857C					; [Sprite Plane Map Table VRam address: $F800];
		dc.w	$8D3F					; [Horizontal Scroll Table VRam address: $FC00];
		dc.w	$8B00					; [External Interrupt Off];[V-Scroll: Full];[H-Scroll: Full];[Line: By Cell];
		dc.w	$8C81					; [H-Mode: 40 Cell];[Shadow/Hi-Lighting Off];[Interlace Off];
		dc.w	$9011					; [VDP Screen Map Size: Vertical Size 64 Cell/Horizontal Size 64 Cell];
		dc.w	$8700					; [Backdrop Colour: Palette Line 0/Colour ID 0];
		dc.w	$9100					; [Window Horizontal Position: 00];
		dc.w	$9200					; [Window Horizontal Position: 00];
		dc.w	$0000					; Null - End of table
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Sega Screen Startup
; ---------------------------------------------------------------------------

SS_Start:						; Offset: 0000645A
		move.w	#$0080,($FFFFD820).w			; set map increase amount (one line)
		moveq	#$3F,d0					; set number of columns to dump
		moveq	#$3F,d1					; set number of rows to dump
		moveq	#$00,d2					; set value to dump
		move.w	($FFFFD816).w,d3			; set V-Ram location to dump to
		jsr	MapScreenSingle				; dump the value to V-Ram (Clear plane A)
		moveq	#$3F,d0					; set number of columns to dump
		moveq	#$3F,d1					; set number of rows to dump
		moveq	#$00,d2					; set value to dump
		move.w	($FFFFD818).w,d3			; set V-Ram location to dump to
		jsr	MapScreenSingle				; dump the value to V-Ram (Clear plane B)
;		bsr.w	SEGA_LoadArt				; dump the different sized pixel tiles for the SEGA screen effect
		move.l	#$00000F01,d0				; set sprite XXXX YY ZZ (XXXX = Y position/YY = shape/ZZ = priority)
		moveq	#$01,d1					; set sprite XXXX YYYY (XXXX = V-Ram location/YYYY = X position)
		lea	($FFFFD164).w,a0			; load sprite table to a0
		moveq	#$06,d7					; set to dump 7 sprites

SS_LoadSprites:						; Offset: 000064AA
		move.l	d0,(a0)+				; dump Y pos, shape, priority
		move.l	d1,(a0)+				; dump V-Ram loc, X pos
		addq.w	#$01,d0					; increase priority number by 1 for next sprite
		dbf	d7,SS_LoadSprites			; repeat for 7 sprites
		move.l	#$00000F00,(a0)+			; set 8th sprite (Priority 00 sets end of sprite table)
		move.l	d1,(a0)					; dump V-Ram loc, X pos
		clr.w	($FFFFFAC4).w				; reset SEGA effect counter to 0
		move.w	#$0001,($FFFFFAC6).w			; set delay
		move.w	($FFFFFFC4).w,d0			; load random number
		andi.w	#$0004,d0				; keep either 0 or 4
		move.w	d0,($FFFFFAC8).w			; save to SEGA Effect Routine Number
		ori.w	#$8124,($FFFFC9BA).w			; [Display ?];[V-Interrupt On];[DMA ?];[? Mode];
		move.w	($FFFFC9BA).w,($C00004).l		; ...set the register
		ori.w	#$8144,($FFFFC9BA).w			; [Display On];[V-Interrupt ?];[DMA ?];[? Mode];
		move.w	($FFFFC9BA).w,($C00004).l		; ...set the register
		addq.w	#$04,($FFFFD824).w			; increase routine counter

SS_StackLoc:						; Offset: 000064F2
		pea	(SS_StackLoc).l				; save the offset starting HERE to the stack
		bclr	#7,($FFFFFFC9).w			; set to not run this routine til V-Blank has run

SS_WaitVB:						; Offset: 000064FE
		tst.b	($FFFFFFC9).w				; is the routine ready to continue?
		bpl.s	SS_WaitVB				; if not, loop and recheck
		move.w	($FFFFD824).w,d0			; load routine counter to d0
		jmp	SS_Routines(pc,d0.w)			; jump to correct routine based on the counter

; ===========================================================================
; ---------------------------------------------------------------------------
SS_Routines:						; Offset: 0000650C
		bra.w	SegaScreen				; Sega Screen loop
	;	bra.w	SDKSega
	;	bra.w	SegaEffects				; Sega Screen effect to use (Main/Scroll)
	;	bra.w	SegaPaletteStart			; Sega Screen palette cycling startup routine
	;	bra.w	SegaPaletteCycle			; Sega Screen palette cycling routine
	;	bra.w	SegaPaletteFade				; Sega Screen Palette fading/finishing routine
		bra.w	SegaStartButton				; Sega Screen finish routine (For when the start button is pressed only)
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to return without doing anything (Used in multiple routines)
; ---------------------------------------------------------------------------

SDKSega:
		lea	PAL_Segalogo(pc),a0			; load Sega Palette address to a0
		lea	($FFFFD3E4).w,a1			; load temp palette buffer location to a1
		movem.l	(a0)+,d0-d7				; load first 10 colours to registers d0 to d7
		movem.l	d0-d7,(a1)				; ...and save to temp palette buffer
		lea	$20(a1),a1				; advance 10 colours in buffer
		movem.l	(a0)+,d0-d7				; load next 10 colours to registers d0 to d7
		movem.l	d0-d7,(a1)				; ...and save to temp palette buffer

		ori.w	#$4000,d0				; set V-Ram write mode (Map location)
		swap	d0					; swap sides
		andi.w	#$0003,d0				; clear all except the V-Ram location bits
		move.l	d0,($C00004).l				; set VDP to V-Ram write mode with location (H-Scroll table)
		move	#$2700,sr				; set the status register (disable interrupts)

		lea	ARTNEM_SegaLogo(pc),a0		; load Main Menu text art address to a0
		move.l	#$40000000,($C00004).l			; set VDP location to dump
		jsr	NemDec					; decompress and dump
		move.l	#$40000003,d0				; prepare VDP settings
		
		lea	($FFFF0000&$FFFFFF).l,a1
		lea	(MAPENI_SegaLogo).l,a0
		move.w	#0,d0
		bsr.w	EniDec
		
		lea	($FFFF0000&$FFFFFF).l,a1
		move.l	#$40000000+(($C61C&$3FFF)<<16)+(($C61C&$C000)>>14),d0
		moveq	#$B,d1
		moveq	#$3,d2
		bsr.w	MapScreen
		
		move	#$2300,sr				; set the status register (enable interrupts)
		
		move.w	#$28,($FFFFF632).w
		move.w	#0,($FFFFF650+$12).w
		move.w	#0,($FFFFF650+$10).w
	;	move.w	#$60,($FFFFF614).w
		move.w	($FFFFF60C).w,d0
		ori.b	#$40,d0
		move.w	d0,($C00004).l
;
loc_2528:
		bclr	#7,($FFFFFFC9).w			; set to not run this routine til V-Blank has run

SSCyc_WaitVB:						; Offset: 000064FE
		tst.b	($FFFFFFC9).w				; is the routine ready to continue?
		subi	#$1,($FFFFF614).w
;		bpl.s	SSCyc_WaitVB				; if not, loop and recheck
;		jsr	GetControls
;		bsr.w	PalCycSega
	;	cmpi.w	#$1,($FFFFF614).w
	;	bge.s	loc_2544
	;	bra.s	loc_2528
;		andi.b	#$80,($FFFFF605).w
;		beq.s	loc_2544

loc_2544:
		addq.w #$04,($FFFFD824).w ; increase routine counter

MultiReturn:						; Offset: 00006524
		rts						; return

PalCycSega:
		subq.w	#1,($FFFFF634).w
		bpl.s	.locret
		move.w	#3,($FFFFF634).w
		move.w	($FFFFF632).w,d0
		bmi.s	.locret
		subq.w	#2,($FFFFF632).w
		lea	(PAL_Segalogo).l,a0
		lea	($FFFFFB00+4).w,a1
		adda.w	d0,a0
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.w	(a0)+,(a1)+

.locret:
		rts

; ===========================================================================

; ===========================================================================
; ---------------------------------------------------------------------------
; Sega Screen finish routine (For when the start button is pressed only)
; ---------------------------------------------------------------------------

SegaStartButton:					; Offset: 000065F6
		jsr		Pal_FadeBlack				; fade the palettes to black
		move.w	#$0008,($FFFFD822).w			; set Screen/Game mode to title screen
		clr.l	($FFFFD824).w				; clear routine counter
		movea.l	($00000000).w,sp			; set stack pointer to location 00000000
		jmp	MainProg_Loop				; jump to Main game array


; ===========================================================================
; ---------------------------------------------------------------------------
; Vertical Blanking Interval (Sega Screen)
; ---------------------------------------------------------------------------

VB_SegaScreen:						; Offset: 00006EB4
		movem.l	d0-a6,-(sp)				; store register data to the stack
		jsr	GetControls				; get buttons pressed
		move.l	#$FFFFD164,d0				; prepare source location (sprite table buffer)
		move.w	($FFFFD81A).w,d1			; prepare V-Ram destination (sprite table)
		move.w	#($0280/$02),d2				; prepare size (number of bytes divide by 2)
		jsr	DMA_WriteData				; set VDP to DMA transfer the sprite table
		jsr	DMA_MovePalette				; set VDP to DMA transfer the SEGA palette
		move.w	($FFFFD81C).w,d0			; load V-Ram horizontal scroll table location to d0
		lsl.l	#$02,d0					; send far left bits to left side
		lsr.w	#$02,d0					; and send the rest back
		ori.w	#$4000,d0				; set V-Ram write mode (Map location)
		swap	d0					; swap sides
		andi.w	#$0003,d0				; clear all except the V-Ram location bits
		move.l	d0,($C00004).l				; set VDP to V-Ram write mode with location (H-Scroll table)
		move.l	($FFFFCA5E).w,($C00000).l		; dump FG and BG X scroll position to the H-Scroll table
		move.l	#$40000010,($C00004).l			; set VDP to VS-Ram write mode
		move.l	($FFFFCDDE).w,($C00000).l		; dump FG and BG Y scroll position to the V-Scroll table
		move.w	($FFFFFFC4).w,d0			; load random number
		add.w	d0,d0					; multiply by... 2
		add.w	d0,d0					; ...4
		add.w	($FFFFFFC4).w,d0			; ...6
		addq.w	#$01,d0					; plus 1 (Multiply by 7)
		move.w	d0,($FFFFFFC4).w			; save back as random number
		ori.b	#$80,($FFFFFFC9).w			; allow normal routine to run
		addq.w	#$01,($FFFFF000).w
		movem.l	(sp)+,d0-a6				; reload register data from the stack
		rte						; return


; ===========================================================================
; ---------------------------------------------------------------------------
PAL_Segalogo:						; Offset: 00006F62
		incbin	Palettes\PalSegaLogo.bin		; palettes used in the Sega logo
		even
ARTNEM_SegaLogo:					; Offset: 00006FA2
		incbin	NemesisComp\SegaLogo.bin		; compressed Sega patterns
		even
MAPENI_SegaLogo:
		incbin	EnigmaComp\MapeniSegaLogo.bin
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Title Screen (Mode: 08)
; ---------------------------------------------------------------------------

TitleScreen:						; Offset: 00007356
		move.w	($FFFFD824).w,d0			; load routine counter to d0
		jmp	TS_Routines(pc,d0.w)			; go to correct routine dependant on the counter

; ===========================================================================
; ---------------------------------------------------------------------------
TS_Routines:						; Offset: 0000735E
		bra.w	TS_StartUp				; Start up of Title Screen
		bra.w	TS_Select				; Selection during the Main Menu
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Start up of Title Screen
; ---------------------------------------------------------------------------

TS_StartUp:						; Offset: 00007366
		pea	(a0)					; send a0 data to the stack
		lea	VB_TitleScreen(pc),a0			; load location V-Blank routine to run
		move.l	a0,($FFFFC832).w			; set to run it during Title Screen
		movem.l	(sp)+,a0				; reload a0 data from stack
		move	#$2700,sr				; set the status register (disable interrupts)
	;	lea	TS_VDPRegData(pc),a0			; load VDP register setup values
	;	jsr	StoreVDPRegisters			; save VDP register data to ram spaces
		bra.s	TS_Start				; continue

; ===========================================================================
; ---------------------------------------------------------------------------
TS_VDPRegData:						; Offset: 00007382
		dc.w	$8230					; [Scroll Plane A Map Table VRam address: $C000];
		dc.w	$8407					; [Scroll Plane B Map Table VRam address: $E000];
		dc.w	$833C					; [Window Plane A Map Table VRam address: $F000];
		dc.w	$857C					; [Sprite Plane Map Table VRam address: $F800];
		dc.w	$8D3F					; [Horizontal Scroll Table VRam address: $FC00];
		dc.w	$8B00					; [External Interrupt Off];[V-Scroll: Full];[H-Scroll: Full];[Line: By Cell];
		dc.w	$8C81					; [H-Mode: 40 Cell];[Shadow/Hi-Lighting Off];[Interlace Off];
		dc.w	$9011					; [VDP Screen Map Size: Vertical Size 64 Cell/Horizontal Size 64 Cell];
		dc.w	$8700					; [Backdrop Colour: Palette Line 0/Colour ID 0];
		dc.w	$9100					; [Window Horizontal Position: 00];
		dc.w	$9200					; [Window Horizontal Position: 00];
		dc.w	$0000					; Null - End of table
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Start of Title Screen Routines
; ---------------------------------------------------------------------------

TS_Start:						; Offset: 0000739A
		move.w	($FFFFD81C).w,d0			; load V-Ram horizontal scroll table location to d0
		lsl.l	#$02,d0					; send far left bits to left side
		lsr.w	#$02,d0					; and send the rest back
		ori.w	#$4000,d0				; set V-Ram write mode (Map location)
		swap	d0					; swap sides
		andi.w	#$0003,d0				; clear all except the V-Ram location bits
		move.l	d0,($C00004).l				; set VDP to V-Ram write mode with location (H-Scroll table)
		move.l	#$00000000,($C00000).l			; reset the FG and BG H-Scroll positions to 0
		move.l	#$40000010,($C00004).l			; set VDP to VS-Ram write mode
		move.l	#$00000000,($C00000).l			; reset the FG and BG V-Scroll positions to 0
		moveq	#$3F,d0					; set number of columns to dump
		moveq	#$3F,d1					; set number of rows to dump
		moveq	#$00,d2					; set value to dump
		move.w	#$C000,d3				; set V-Ram location to dump to
		jsr	MapScreenSingle				; dump the value to V-Ram (Clears Plane A Map Table)
		moveq	#$3F,d0					; set number of columns to dump
		moveq	#$3F,d1					; set number of rows to dump
		moveq	#$00,d2					; set value to dump
		move.w	#$E000,d3				; set V-Ram location to dump to
		jsr	MapScreenSingle				; dump the value to V-Ram (Clears Plane B Map Table)
		lea	ARTNEM_MainMenusText(pc),a0		; load Main Menu text art address to a0
		move.l	#$40000000,($C00004).l			; set VDP location to dump
		jsr	NemDec					; decompress and dump
		move.l	#$40000003,d0				; prepare VDP settings
		lea	MAPUNC_TitleMenu_1(pc),a1		; load uncompressed title mappings to a1 (Title Screen "Banner")
		moveq	#$27,d1					; set X loop
		moveq	#$B,d2					; set Y loop
		move.w	#0,d3					; set to use palette line 0 (and to map behind object plane)
		jsr	MapScreen				; map it on screen correctly
		move.l	#$4A180003,d0				; prepare VDP location & settings
		lea	MAPUNC_TitleMenu_2(pc),a1		; load uncompressed title mappings to a1 (Title Screen "Main Menu Selection")
		moveq	#7,d1					; set X loop
		moveq	#3,d2					; set Y loop
		move.w	#0,d3					; set to use palette line 0 (and to map behind object plane)
		move.w	#$0100,($FFFFD820).w			; set map increase amount (two line)
		jsr	MapScreen				; map it on screen correctly
		move.w	#$0080,($FFFFD820).w			; set map increase amount (one line)
		move.l	#$4BBC0003,d0				; prepare VDP location & settings
		lea	MAPUNC_TitleMenu_3(pc),a1		; load uncompressed title mappings to a1 (Title Screen "1ST	ROM 19940401")
		moveq	#7,d1					; set X loop
		moveq	#1,d2					; set Y loop
		move.w	#0,d3					; set to use palette line 0 (and to map behind object plane)
		move.w	#$0100,($FFFFD820).w			; set map increase amount (two line)
		jsr	MapScreen				; map it on screen correctly
		move.w	#$0080,($FFFFD820).w			; set map increase amount (one line)
		lea	PAL_MainMenus(pc),a0			; load menu palette location to a0
		lea	($FFFFD3E4).w,a1			; load palette buffer to a1
		moveq	#$0F,d0					; set repeat times (20 colours

TS_DumpPal:						; Offset: 00007462
		move.l	(a0)+,(a1)+				; dump two colours to buffer
		dbf	d0,TS_DumpPal				; repeat til 20 colours have been dumped
		jsr	DMA_MovePalette				; DMA transfer the palette to C-Ram
		move.l	#$78000003,($C00004).l			; set VDP to V-Ram write mode (Sprite table)
		move.l	#$00000000,($C00000).l			; set 1st sprite's Y pos, shape and priority to 0 (Sets end of table)
		move.l	#$001E00D0,($C00000).l			; set 1st sprite's V-Ram, X pos
		clr.w	($FFFFD826).w				; clear main menu current selection
		clr.w	($FFFFD832).w				; clear Screen's FG Y position
		move	#$2300,sr				; set the status register (enable interrupts)
		addq.w	#$04,($FFFFD824).w			; increase routine counter
		move.b	#$89,d0					; set "fade out" music
		jsr	(PlayMusic).l				; play music
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
PAL_MainMenus:						; Offset: 0000749C
		incbin	Palettes\PalMainMenus.bin		; Main Menu palette
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Selection during the Main Menu
; ---------------------------------------------------------------------------

TS_Select:						; Offset: 000074DC
		bclr	#$07,($FFFFFFC9).w			; set to not run this routine til V-Blank has run

TS_Sel_WaitVB:						; Offset: 000074E2
		tst.b	($FFFFFFC9).w				; is the routine ready to continue?
		bpl.s	TS_Sel_WaitVB				; if not, loop and recheck
		move.w	($FFFFC946).w,d0			; load menu select data
		add.w	($FFFFD826).w,d0			; add Main Menu current selection
		bpl.s	TS_Sel_NoNeg				; if positive, branch (if 0000 - 7FFF)
		moveq	#$00,d0					; reset to d0

TS_Sel_NoNeg:						; Offset: 000074F4
		cmpi.w	#$0003,d0				; has it passed the 4th selection on the menu?
		bls.s	TS_Sel_Above4th				; if not, branch
		moveq	#$03,d0					; set back to 4th

TS_Sel_Above4th:					; Offset: 000074FC
		move.w	d0,($FFFFD826).w			; save new selection
		lsl.w	#$04,d0					; multiply by 10
		addi.w	#$0120,d0				; add 120
		move.w	d0,($FFFFD832).w			; save to Screen's FG Y position (doesn't function during the menu though)
		tst.b	($FFFFC93D).w				; has player 1 pressed start?
		bmi.s	TSS_Start				; if so, branch
		rts						; return

; ---------------------------------------------------------------------------
; When start is pressed during the Menu
; ---------------------------------------------------------------------------

MultiReturn2:
		rts

TSS_Start:						; Offset: 00007512
		clr.w	($FFFFD83A).w				; reset Level time of day
		clr.w	($FFFFD824).w				; reset routine counter
		move.w	($FFFFD826).w,d3			; load selection to d0
		beq.s	TSS_1P2PStart				; if it's at the 1st selection, branch
		cmpi.w	#1,d3					; is it at the second selection?
		bne.s	TSS_Not1P2P				; if not, branch

TSS_1P2PStart:						; Offset: 00007526
		jsr		Pal_FadeBlack				; fade the palettes to black
		move.w	#$0001,($FFFFD834).w			; set Zone/World ID to 1 (dubbed TechnoTowerZone)
		move.w	#$0001,($FFFFD836).w			; set Level/Act/Field ID to 1
		move.w	#$0018,($FFFFD822).w			; set Screen/Game mode to Level
		move.b	#$00,($FFFFD89C).w			; set player 1 user mode
		tst.w	d3					; is the selection "1P START"?
		bne.s	TSS_2PStart				; if not, branch
		move.b	#%11111111,($FFFFD8AC).w			; set player 2 CPU mode
		rts						; return

TSS_2PStart:						; Offset: 0000754A
		move.b	#$10,($FFFFD8AC).w			; set player 2 user mode
		rts						; return

TSS_Not1P2P:						; Offset: 00007552
		cmpi.w	#$0002,($FFFFD826).w			; is it at the third selection?
		bne.s	TSS_NotOptions				; if not, branch
		move.w	#$0040,($FFFFD822).w			; set Screen/Game mode to Options (Sound Test)
		rts						; return

TSS_NotOptions:						; Offset: 00007562
		move.b	#$00,($FFFFD89C).w			; set player 1 user mode
		move.b	#$FF,($FFFFD8AC).w			; set player 2 CPU mode
		move.w	#$0030,($FFFFD822).w			; set Screen/Game mode to Select (Level Select)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Vertical Blanking Interval (Title Screen)
; ---------------------------------------------------------------------------

VB_TitleScreen:						; Offset: 00007576
		movem.l	d0-a6,-(sp)				; store register data to the stack
		move.l	#$78000003,($C00004).l			; set VDP to V-Ram write mode (Sprite Table)
		move.w	($FFFFD832).w,($C00000).l		; save Screen's FG Y position (To the sprite table?? ok)
		jsr	GetControls				; get controls being pressed/held
		move.b	($FFFFC93C).w,d0			; load player 1 held controls to d0
		bsr.s	VB_TS_ButtonToIDAdd			; get add ID
		move.w	d1,($FFFFC940).w			; set right nybble to add (Left byte)
		move.w	d2,($FFFFC942).w			; set left nybble to add (Left byte)
		move.b	($FFFFC93D).w,d0			; load player 1 pressed controls to d0
		bsr.s	VB_TS_ButtonToIDAdd			; get add ID
		move.w	d1,($FFFFC944).w			; set right nybble to add (Right byte)
		move.w	d2,($FFFFC946).w			; set left nybble to add (Right byte)
		jsr	DMA_MovePalette				; set VDP to DMA transfer the menu palette
		ori.b	#$80,($FFFFFFC9).w			; allow normal routine to run
		movem.l	(sp)+,d0-a6				; reload register data from the stack
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; This subroutine converts button values to the correct ID value that needs
; adding, d2 = left nybble, d1 = right nybble.
; ---------------------------------------------------------------------------
; d2 = if down is pressed/held, value is FFFF, if up, 0001, otherwise 0000
; d1 = if left is pressed/held, value is FFFF, if right, 0001 otherwise 0000
; ---------------------------------------------------------------------------

VB_TS_ButtonToIDAdd:					; Offset: 000075BC
		moveq	#$03,d1					; set 3 in d1
		and.w	d0,d1					; get only button bits that were pressed of d1
		ror.w	#$01,d1					; send up button to far left, and down button to far right
		ext.l	d1					; set word signed (if up was pressed, sets FFFF on left side)
		move.w	d1,d2					; copy button arrangements to d2
		swap	d1					; swap words
		or.w	d1,d2					; set d1 bits onto d2 (if up was pressed, FFFF will be set in d2, if down 0001, otherwise 0000)
		andi.w	#$000C,d0				; get only right/left button bits
		ror.w	#$03,d0					; send right button to far right, and left button to far left
		ext.l	d0					; set word signed (if left was pressed, sets FFFF on left side)
		move.w	d0,d1					; copy button arrangements to d1
		swap	d0					; swap words
		or.w	d0,d1					; set d1 bits onto d2 (if left was pressed, FFFF will be set in d2, if right 0001, otherwise 0000)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
ARTNEM_MainMenusText:					; Offset: 000075DA
		incbin  NemesisComp\ArtnemMainMenusText.bin	; Nemesis compressed menu text art
		even
MAPUNC_TitleMenu_1:					; Offset: 000078E8
		incbin  Uncompressed\MapuncTitleMenu01.bin	; Uncompressed mappings	for the	title screen banner
		even			
MAPUNC_TitleMenu_2:					; Offset: 00007DA8
	if	Combi	=	1
		incbin  Uncompressed\MapuncTitleMenu02_C.bin	; Uncompressed mappings	for the	title menu selection
	else
		incbin  Uncompressed\MapuncTitleMenu02.bin	; Uncompressed mappings	for the	title menu selection
	endif
		even
MAPUNC_TitleMenu_3:					; Offset: 00007DE8
		incbin  Uncompressed\MapuncTitleMenu03.bin	; Uncompressed mappings	for the	title menu (1ST	ROM 19940401)
		even
MAPUNC_TitleMenu_4:					; Offset: 000078E8
		incbin  Uncompressed\MapuncTitleMenu04.bin	; Uncompressed mappings	for the	title screen banner
		even	
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Field Screens (Mode: 10)
; ---------------------------------------------------------------------------

Fields:							; Offset: 00007E08
		pea	(a0)					; send a0 data to the stack
		lea	VB_Fields(pc),a0			; load location V-Blank routine to run
		move.l	a0,($FFFFC832).w			; set to run it during Fields
		movem.l	(sp)+,a0				; reload a0 data from stack
		lea	Fields_VDPRegData(pc),a0		; load VDP register setup values
		jsr	StoreVDPRegisters			; save VDP register data to ram spaces
		move.b	#$8A,d0					; load BGM 81
		jsr	(PlayMusic).l				; Play BGM
		lea	PAL_PrimaryColours_Field(pc),a0		; load primary Field palettes address to a0
		lea	($FFFFD3E4).w,a1			; load palette buffer to a1
		movem.l	(a0)+,d0-d7				; load first 10 colours
		movem.l	d0-d7,(a1)				; ...and dump to buffer
		lea	$20(a1),a1				; advance to the next 10 colours location
		movem.l	(a0)+,d0-d7				; load next 10 colours
		movem.l	d0-d7,(a1)				; ...and dump to buffer
		andi.w	#$81BC,($FFFFC9BA).w			; Turn Display off in VDP register 01's data
		move.w	($FFFFC9BA).w,($C00004).l		; ...and save to that VDP register
		jsr	Field_LoadData				; load rainbow field data
		jsr	Objects_SetupRam			; clear and setup the sprite table and object ram (SST)
		move.w	#$0005,($FFFFD83C).w
		move.w	#$0007,($FFFFD840).w
		move.w	#$003F,($FFFFD844).w
		move.w	#$003F,($FFFFD848).w
		jsr	Fields_LoadPlayers			; load Player/Character objects
		jsr	Combi_LoadStars				; load combi star objects
		jsr	DMA_LoadHudArt				; load HUD art to V-Ram
		ori.w	#$8144,($FFFFC9BA).w			; turn Display on of VDP register 01 storage
		move.w	($FFFFC9BA).w,($C00004).l		; ...and set that register
		bra.w	Fields_Start				; continue

; ===========================================================================
; ---------------------------------------------------------------------------
PAL_PrimaryColours_Field:				; Offset: 00007E98
		incbin	 "Palettes\PalPrimaryColoursField.bin"
		even
; ---------------------------------------------------------------------------
Fields_VDPRegData:					; Offset: 00007ED8
		dc.w	$8230					; [Scroll Plane A Map Table VRam address: $C000];
		dc.w	$832C					; [Window Plane A Map Table VRam address: $B000];
		dc.w	$8407					; [Scroll Plane B Map Table VRam address: $E000];
		dc.w	$8554					; [Sprite Plane Map Table VRam address: $A800];
		dc.w	$8D2B					; [Horizontal Scroll Table VRam address: $AC00];
		dc.w	$9011					; [VDP Screen Map Size: Vertical Size 64 Cell/Horizontal Size 64 Cell];
		dc.w	$8720					; [Backdrop Colour: Palette Line 2/Colour ID 0];
		dc.w	$8B03					; [External Interrupt Off];[V-Scroll: Full];[H-Scroll: Full];[Line: By Line];
		dc.w	$8C89					; [H-Mode: 40 Cell];[Shadow/Hi-Lighting On];[Interlace Off];
		dc.w	$0000					; Null - End of table
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Start of Field Routines
; ---------------------------------------------------------------------------

Fields_Start:						; Offset: 00007EEC
		pea	(Fields_Start).l			; save the offset starting HERE to the stack
		bclr	#$07,($FFFFFFC9).w			; set to not run this routine til V-Blank has run

FS_WaitVB:						; Offset: 00007EF8
		tst.b	($FFFFFFC9).w				; is the routine ready to continue?
		bpl.s	FS_WaitVB				; if not, loop and recheck
		bsr.w	Pause_WindowOut				; check to slide Pause Window out
		jsr	(Fields_GetControls).l			; get controls configured for the Field
		jsr	Fields_Pause				; loading, removing and controlling the pause bar mode
		jsr	Control_Combi				; run the combi related controls
		jsr	Fields_RunPlayers			; run through player object routines
		jsr	Fields_DeformScrollPalcyc		; run deformation, screen boundaries and cycle palettes
		move	#$2700,sr				; set the status register (disable interrupts)
		jsr	BuildSprites				; build object sprites
		move	#$2300,sr				; set the status register (enable interrupts)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load the control button data for the Fields
; ---------------------------------------------------------------------------

Fields_GetControls:					; Offset: 00007F2E
		jsr	GetControls				; load controls
		lea	($FFFFC938).w,a3			; load starting address of where controls were dumped to
		moveq	#$00,d1					; clear d1
		move.b	($FFFFD89C).w,d1
		moveq	#$07,d0
		and.b	$03(a3,d1.w),d0
		sne	d2
		move.b	$04(a3,d1.w),d0
		move.b	d0,d1
		andi.b	#$70,d1
		sne	d1
		or.b	d2,d1
		andi.b	#$70,d1
		or.b	d1,d0
		lea	($FFFFFB00).w,a4
		move.b	-1(a4),d1
		andi.w	#$F,d1
		move.b	(a4,d1.w),d2
		move.b	d0,(a4,d1.w)
		addq.b	#1,-1(a4)
		move.b	d2,-2(a4)
		lea	($FFFFD89C).w,a4
		bsr.w	sub_7FB0
		move.b	($FFFFFAFE).w,d0
		lea	($FFFFC938).w,a3
		moveq	#0,d1
		move.b	($FFFFD8AC).w,d1
		bmi.s	loc_7FA8
		moveq	#7,d0
		and.b	3(a3,d1.w),d0
		sne	d2
		move.b	4(a3,d1.w),d0
		move.b	d0,d1
		andi.b	#$70,d1	; 'p'
		sne	d1
		or.b	d2,d1
		andi.b	#$70,d1	; 'p'
		or.b	d1,d0

loc_7FA8:
		lea	($FFFFD8AC).w,a4
		bra.w	sub_7FB0


sub_7FB0:
		move.b	2(a4),4(a4)
		move.b	d0,2(a4)
		move.b	4(a4),d1
		eor.b	d0,d1
		beq.s	loc_7FC6
		clr.b	6(a4)

loc_7FC6:
		addq.b	#1,6(a4)
		and.b	d0,d1
		move.b	d1,3(a4)
		andi.w	#$F,d0
		move.b	byte_8000(pc,d0.w),5(a4)
		moveq	#3,d1
		and.w	d0,d1
		ror.w	#1,d1
		ext.l	d1
		move.w	d1,d2
		swap	d1
		or.w	d1,d2
		move.w	d2,$A(a4)
		andi.w	#$C,d0
		ror.w	#3,d0
		ext.l	d0
		move.w	d0,d1
		swap	d0
		or.w	d0,d1
		move.w	d1,8(a4)
		rts
; End of function sub_7FB0

; ---------------------------------------------------------------------------
byte_8000:	dc.b $00,$C0,$40,$C0
		dc.b $80,$A0,$60,$A0
		dc.b $00,$E0,$20,$E0
		dc.b $80,$A0,$60,$A0
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Vertical Blanking Interval (Fields)
; ---------------------------------------------------------------------------

VB_Fields:						; Offset: 00008010
		movem.l	d0-a6,-(sp)				; store register data to the stack
		move.l	#$FFFFCA5E,d0				; prepare source location (scroll table buffer)
		move.w	($FFFFD81C).w,d1			; prepare V-Ram destination (scroll table)
		move.w	#($0380/$02),d2				; prepare size (number of bytes divide by 2)
		jsr	DMA_WriteData				; set VDP to DMA transfer the scroll table
		move.l	#$40000010,($C00004).l			; set VDP to VS-Ram write mode
		move.l	($FFFFCDDE).w,($C00000).l		; dump FG and BG Y scroll position to the V-Scroll table
		jsr	DMA_MovePalette				; set VDP to DMA transfer the palette to C-Ram
		jsr	DMA_WriteCharactersPLC
		move.l	#$FFFFD164,d0				; prepare source location (sprite table buffer)
		move.w	($FFFFD81A).w,d1			; prepare V-Ram destination (sprite table)
		move.w	#($0280/$02),d2				; prepare size (number of bytes divide by 2)
		jsr	DMA_WriteData				; set VDP to DMA transfer the sprite table
		ori.b	#$80,($FFFFFFC9).w			; allow normal routine to run
		addq.w	#1,($FFFFF000).w
		movem.l	(sp)+,d0-a6				; reload register data from the stack
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control the Pause menu functions during Fields
; ---------------------------------------------------------------------------

Fields_Pause:						; Offset: 00008064
		tst.b	($FFFFD89F).w				; has player 1 pressed pause?
		bpl.w	Fields_NoPause				; if not, branch
		move.b	($FFFFC93C).w,d0			; load player 1 menu held buttons to d0
		andi.b	#$70,d0					; get only if A, B or C have been pressed
		cmpi.b	#$70,d0					; were A, B or C been held BEFORE start was pressed?
		bne.s	Fields_NoReset				; if not, branch
		move	#$2700,sr				; set the status register (disable interrupts)
		suba.l	a0,a0					; decrease a0 from itself (clears a0 more quickly)
		movea.l	(a0)+,sp				; reset the stack pointer location
		movea.l	(a0)+,a0				; reset a0 location
		jmp	(a0)					; jump to that location (Resetting the entire rom)

Fields_NoReset:						; Offset: 00008086
		movem.l	d0-a6,-(sp)				; store register data to the stack

; ---------------------------------------------------------------------------
; Pause Main Loop
; ---------------------------------------------------------------------------

Fields_PauseLoop:					; Offset: 0000808A
		bclr	#$07,($FFFFFFC9).w			; set to not run this routine til V-Blank has run

FPL_WaitVB:						; Offset: 00008090
		tst.b	($FFFFFFC9).w				; is the routine ready to continue?
		bpl.s	FPL_WaitVB				; if not, loop and recheck
		jsr	(Fields_GetControls).l			; get controls configured for the Field
		move.b	($FFFFD89E).w,d0			; load player 1 held level buttons to d0
		andi.b	#$70,d0					; have A, B or C been pressed?
		beq.w	FPL_ResumePause				; if not, branch
		moveq	#$00,d0					; clear d0
		lea	($FFFFF9C0).w,a0
		move.w	#$17F,d1

loc_80B2:						; Offset: 000080B2
		move.l	d0,(a0)+
		dbf	d1,loc_80B2
		move.w	d0,($FFFFD830).w			; reset Screen's new FG X position
		move.w	d0,($FFFFD832).w			; reset Screen's new FG Y position
		lea	($FFFFC9DE).w,a0
		moveq	#$0F,d1

loc_80C6:						; Offset: 000080C6
		move.l	d0,(a0)+
		dbf	d1,loc_80C6
		lea	($FFFFCA1E).w,a0
		moveq	#$0F,d1

loc_80D2:						; Offset: 000080D2
		move.l	d0,(a0)+
		dbf	d1,loc_80D2
		lea	($FFFFCA5E).w,a0			; load horizontal scroll table buffer
		move.w	#$00DF,d1				; set repeat times

FPL_ClearScroll:					; Offset: 000080E0
		move.l	d0,(a0)+				; clear horizontal scroll table buffer
		dbf	d1,FPL_ClearScroll			; repeat til buffer is clear
		move.l	d0,($FFFFCDDE).w			; reset FG & BG Y scroll positions
		lea	($C00000).l,a0				; load VDP data port to a0
		move.w	#$8F02,($C00004).l			; set auto increment to 2
		move.w	#$8F02,($FFFFC9D6).w			; ...and store in VDP register 07 storage
		moveq	#$00,d0					; clear d0
		move.l	#$40000000,($C00004).l			; set VDP to V-Ram write mode (Start of V-Ram)
		move.w	#$0FFF,d1				; set repeat times

FPL_ClearVRam:						; Offset: 0000810E
		move.l	d0,(a0)					; clear V-Ram
		move.l	d0,(a0)					; ''
		move.l	d0,(a0)					; ''
		move.l	d0,(a0)					; ''
		dbf	d1,FPL_ClearVRam			; repeat til V-Ram is cleared
		move.l	#$40000010,($C00004).l			; set VDP to VS-Ram write mode
		move.l	($FFFFCDDE).w,($C00000).l		; set FG and BG Y scroll positions
		clr.w	($FFFFD824).w				; clear sound ID
		addq.w	#$01,($FFFFD836).w			; increase Level/Act/Field ID
		tst.w	($FFFFD834).w				; is Zone/World ID at 00 (Rainbow/SSZ)?
		beq.s	FPL_SkipTimeOfDay			; if so, skip time of day increase
		addq.w	#$01,($FFFFD83A).w			; increase Level time of day value

FPL_SkipTimeOfDay:					; Offset: 0000813E
		move.w	#$0018,($FFFFD822).w			; set Screen/Game mode to Level
		movea.l	($00000000).w,sp			; set stack pointer to location 00000000
		jmp	MainProg_Loop				; jump to Main game array

; ---------------------------------------------------------------------------
; Resuming/Continuing the pause menu loop
; ---------------------------------------------------------------------------

FPL_ResumePause:					; Offset: 0000814C
		move.w	($FFFFD8A4).w,d0			; load pause main X speed control
		move.w	($FFFFD8A6).w,d1			; load pause main Y speed control
		add.w	d0,d0					; multiply X...
		add.w	d0,d0					; ...by 4
		add.w	d1,d1					; multiply Y...
		add.w	d1,d1					; ...by 4
		movea.w	($FFFFD862).w,a0			; load Sonic's ram address to a0
		add.w	d0,$08(a0)				; add to Sonic's X position
		add.w	d1,$0C(a0)				; add to Sonic's Y position
		movea.w	($FFFFD864).w,a0			; load Tails' ram address to a0
		add.w	d0,$08(a0)				; add to Tails' X position
		add.w	d1,$0C(a0)				; add to Tails' Y position
		jsr	Control_Combi				; run the combi related controls
		jsr	Fields_DeformScrollPalcyc		; run deformation, screen boundaries and cycle palettes
		jsr	BuildSprites				; build object sprites
		bsr.w	Pause_WindowIn				; check to slide Pause Window in
		tst.b	($FFFFC93D).w				; has player 1 pressed pause?
		bpl.w	Fields_PauseLoop			; if not, branch to loop the pause system
		movem.l	(sp)+,d0-a6				; retore registers

Fields_NoPause:						; Offset: 00008194
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load the Player/Character Objects to SST for Fields
; ---------------------------------------------------------------------------

Fields_LoadPlayers:					; Offset: 00008196
		move.w	#$0000,($FFFFD866).w			; set Player 1's character as Sonic
		move.w	#$0004,($FFFFD868).w			; set Player 2's character as Tails
		moveq	#$04,d0					; set to read the 1st Object Ram section
		jsr	Objects_FindFreeSlot			; find free object space
		bmi.s	FLP_NoChar1				; if there is no space, branch
		move.w	#$0080,$04(a0)
		move.w	#$0002,$06(a0)
		move.w	#$0070,$08(a0)				; set starting X position
		move.w	#$0070,$0C(a0)				; set starting Y position
		move.w	#$8000,$20(a0)				; set starting V-Ram location read
		move.w	a0,($FFFFD862).w			; store Player 1's ram location to storage

FLP_NoChar1:						; Offset: 000081CC
		moveq	#$04,d0					; set to read the 1st Object Ram section
		jsr	Objects_FindFreeSlot			; find free object space
		bmi.s	FLP_NoChar2				; if there is no space, branch
		move.w	#$0080,$04(a0)
		move.w	#$0802,$06(a0)
		move.w	#$00B0,$08(a0)				; set starting X position
		move.w	#$0070,$0C(a0)				; set starting Y position
		move.w	#$8000,$20(a0)				; set starting V-Ram location read
		move.w	a0,($FFFFD864).w			; store Player 2's ram location to storage

FLP_NoChar2:						; Offset: 000081F6
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to run through the object routines during the Field
; (Only Sonic and Tails)
; ---------------------------------------------------------------------------

Fields_RunPlayers:					; Offset: 000081F8
		lea	($FFFFD850).w,a6			; load 2nd Object ram cue to a6

FRP_Object:						; Offset: 000081FC
		move.w  $00(a6),d0				; load object ram location
		bne.s	FRP_CheckChar				; if not null, then it's an object
		rts						; return (finish)

FRP_CheckChar:						; Offset: 00008204
		movea.w	d0,a6					; load that objects address to a6
		tst.b	$06(a6)					; is the object sonic? (00 = Sonic/08 = Tails)
		bne.s	FRP_CC_Tails				; if not, branch
		lea	($FFFFD89C).w,a5			; load player 1 info address to a5
		bsr.s	FRP_PlayerControl			; run controls and settings for this character
		bra.s	FRP_Object				; continue for next object

FRP_CC_Tails:						; Offset: 00008214
		lea	($FFFFD8AC).w,a5			; load player 2 info address to a5
		bsr.s	FRP_PlayerControl			; run controls and settings for this character
		bra.s	FRP_Object				; continue for next object

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to run controls and settings for the characters
; ---------------------------------------------------------------------------

FRP_PlayerControl:					; Offset: 0000821C
		pea	(Fields_SetCharacter).l			; push character map, PLC, etc routine to the stack
		pea	FRP_Unknown(pc)				; push incomplete/unknown routine to the stack
		tst.b	(a5)					; is the control mode set as User?
		bpl.s	FRP_UserChkX				; if so, branch
		move.b	($FFFFD89E).w,d0			; load player 1 held controls
		andi.b	#$70,d0					; has A, B or C been held?
		bne.w	FRP_Stand				; if so, branch

FRP_UserChkX:						; Offset: 00008236
		move.w	$08(a5),d0				; load pause main X speed control
		beq.s	FRP_UserChkY				; if it's null, branch
		add.w	d0,d0					; multiply by 2
		add.w	d0,$08(a6)				; add to the player's X position
		tst.w	d0					; is it moving right (Positive)?
		bpl.s	FRP_UserRight				; if so, branch
		move.w	#$0004,$26(a6)				; set running left/right animation
		move.w	#$8000,$20(a6)				; set V-Ram location (deseting Mirror Flag)
		bra.s	FRP_UserChkY				; continue

FRP_UserRight:						; Offset: 00008254
		move.w	#$0004,$26(a6)				; set running left/right animation
		move.w	#$8800,$20(a6)				; set V-Ram location (seting Mirror Flag)

FRP_UserChkY:						; Offset: 00008260
		move.w	$0A(a5),d1				; load pause main Y speed control
		beq.s	FRP_Stand				; if it's null, branch
		add.w	d1,d1					; multiply by 2
		add.w	d1,$0C(a6)				; add to the player's Y position
		tst.w	d1					; is it moving down (Positive)?
		bpl.s	FRP_UserDown				; if so, branch
		move.w	#$0006,$26(a6)				; set running up animation
		move.w	#$8000,$20(a6)				; set V-Ram location (deseting Mirror Flag)
		rts						; return

FRP_UserDown:						; Offset: 0000827E
		move.w	#$0002,$26(a6)				; set running down animation
		move.w	#$8000,$20(a6)				; Set V-Ram location (deseting Mirror Flag)
		rts						; return

FRP_Stand:						; Offset: 0000828C
		or.w	d1,d0					; have the character's moved at all?
		bne.s	FRP_NoStand				; if so, branch
		move.w	$26(a6),d0				; load animation ID
		beq.s	FRP_NoStand				; if null, branch
		lsr.w	#$01,d0					; divide it by 2
		subq.w	#$01,d0					; decrease by 1
		move.b	d0,$28(a6)				; set direction to face
		move.w	#$0000,$26(a6)				; set standing animation animation

FRP_NoStand:						; Offset: 000082A4
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Unknown Incomplete subroutine, does something based on the control (User or CPU)
; ---------------------------------------------------------------------------

FRP_Unknown:						; Offset: 000082A6
		tst.b	(a5)					; is the control mode set as CPU?
		bmi.s	FRP_UnkCPU				; if so, branch
		bsr.w	FRP_UnkUser				; run subroutine

FRP_UnkCPU:						; Offset: 000082AE
		rts						; return

FRP_UnkUser:						; Offset: 000082B0
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to run deformation, screen boundaries and cycle palettes for
; Fields
; ---------------------------------------------------------------------------

Fields_DeformScrollPalcyc:				; Offset: 000082B2
		move.w	($FFFFD830).w,d0			; load Screen's new FG X position to d0
		bpl.s	FDSP_CheckRight				; if still positive (if screen has not passed the far left of the Field), branch
		moveq	#$00,d0					; set the position directly to far left if negative

FDSP_CheckRight:					; Offset: 000082BA
		cmpi.w	#$00BF,d0				; has the screen passed the far right of the Field?
		bcs.s	FDSP_RightOK				; if not, branch
		move.w	#$00BF,d0				; set the position directly to far right

FDSP_RightOK:						; Offset: 000082C4
		move.w	d0,($FFFFD830).w			; set new Screen new FG X position
		move.w	d0,($FFFFC9DE).w			; store X position
		move.w	($FFFFD832).w,d0			; load Screen's new FG Y position to d0
		bpl.s	FDSP_CheckDown				; if still positive (if screen has not passed the far top of the Field), branch
		moveq	#$00,d0					; set the position directly to far top if negative

FDSP_CheckDown:						; Offset: 000082D4
		cmpi.w	#$011F,d0				; has the screen passed the far bottom of the Field?
		bcs.s	FDSP_DownOK				; if not, branch
		move.w	#$011F,d0				; set the position directly to far bottom

FDSP_DownOK:						; Offset: 000082DE
		move.w	d0,($FFFFD832).w			; set new Screen new FG Y position
		move.w	d0,($FFFFC9EE).w			; store Y position
		move.w	d0,d1					; copy Y position to d1
		lsr.w	#$01,d1					; divide by 2 (For BG's position)
		swap	d0					; send Y pos for FG to left word of d0
		move.w	d1,d0					; save Y pos for BG to right word of d0
		move.l	d0,($FFFFCDDE).w			; save to horizontal scroll table buffer
		tst.w	($FFFFD834).w				; is Zone/World ID set to (Rainbow/SSZ)?
		bne.w	FDSP_ElectField				; if not, branch
		subq.w	#$03,($FFFFFAEE).w			; decrease scroll counter 1
		subq.w	#$05,($FFFFFAF0).w			; decrease scroll counter 2
		move.w	($FFFFD830).w,d0			; reload Screen's new FG X position to d0
		neg.w	d0					; negate to opposite (Negative/Positive)
		move.w	d0,d1					; copy to d1 (d0 = FG & BG slice 1/d1 = FG & BG slice 2)
		swap	d0					; swap to left word
		swap	d1					; ''
		move.w	($FFFFFAEE).w,d0			; load scroll counter 1
		move.w	($FFFFFAF0).w,d1			; load scroll counter 2
		btst	#$00,($FFFFCDE1).w			; is the BG scroll position on an even position?
		beq.s	FDSP_RF_EvenLine			; if so, branch
		exg	d0,d1					; swap the scroll lines (So that when going down, the deformation stays fixed with the art)

FDSP_RF_EvenLine:					; Offset: 00008320
		lea	($FFFFCA5E).w,a0			; load horizontal scroll table buffer
		move.w	#$006F,d2				; set repeat times

FDSP_RF_Scroll:						; Offset: 00008328
		move.l	d0,(a0)+				; save FG and BG positions for the first line
		move.l	d1,(a0)+				; save FG and BG positions for the second line
		dbf	d2,FDSP_RF_Scroll			; repeat for all horizontal lines
		cmpi.w	#$0005,($FFFFFAEA).w			; has palette cycle timer reached 5?
		bcs.s	FDSP_RF_WaitTime			; if not, branch
		clr.w	($FFFFFAEA).w				; reset timer to 0
		addq.w	#$01,($FFFFFAEC).w			; increase palette cycle counter
		move.w	($FFFFFAEC).w,d0			; then load it to d0
		andi.w	#$0003,d0				; keep within 3 (no higher)
		lsl.w	#$03,d0					; multiply by 8
		move.l	PALCY_RnbwFld(pc,d0.w),($FFFFD43C).w	; load correct first two colours to palette based on counter
		move.l	PALCY_RnbwFld+$4(pc,d0.w),($FFFFD440).w	; load correct second two colours to palette based on counter

FDSP_RF_WaitTime:					; Offset: 00008356
		addq.w	#1,($FFFFFAEA).w			; increase palette cycle timer
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Palette cycle data for the Rainbow Field
; ---------------------------------------------------------------------------

PALCY_RnbwFld:						; Offset: 0000835C
		dc.w	$0EEA,$0EC4,$0E82,$0E40			; 1st set
		dc.w	$0EC4,$0E82,$0E40,$0EEA			; 2nd set
		dc.w	$0E82,$0E40,$0EEA,$0EC4			; 3rd set
		dc.w	$0E40,$0EEA,$0EC4,$0E82			; 4th set
		even
; ---------------------------------------------------------------------------
; ===========================================================================

FDSP_ElectField:					; Offset: 0000837C
		move.w	($FFFFD830).w,d0			; reload Screen's new FG X position to d0
		neg.w	d0					; negate to opposite (Negative/Positive)
		move.w	d0,d1					; copy to d1 (d0 = FG/d1 = BG)
		lsr.w	#$01,d1					; divide BG position by 2
		swap	d0					; swap FG to left side
		move.w	d1,d0					; save BG to right side
		lea	($FFFFCA5E).w,a0			; load horizontal scroll table buffer
		move.w	#$00DF,d1				; set repeat times

FDSP_EF_Scroll:						; Offset: 00008392
		move.l	d0,(a0)+				; dump scroll positions (FG and BG) to the buffer
		dbf	d1,FDSP_EF_Scroll			; repeat til dumped to all slots
		lea	PALCY_ElctFldB1(pc),a0			; load data for 1st "B" palette
		bsr.w	FDSP_CyclePalB				; cycle 1st "B" palette
		lea	PALCY_ElctFldB2(pc),a0			; load data for 2nd "B" palette
		bsr.w	FDSP_CyclePalB				; cycle 2nd "B" palette
		cmpi.w	#$000A,($FFFFFAF0).w			; has timer reached A?
		bcs.s	FDSP_EF_WaitTime			; if not, branch
		clr.w	($FFFFFAF0).w				; reset timer to 0
		move.w	($FFFFFAF2).w,d0			; load counter
		andi.w	#$7FF0,d0				; keep within 7FF0 in multiples of 10
		addi.w	#$0010,d0				; increase by 10
		cmpi.w	#$0180,d0				; has it reached 180?
		bcs.s	FDSP_EF_Cont				; if not, branch
		moveq	#$00,d0					; reset counter

FDSP_EF_Cont:						; Offset: 000083C8
		move.w	d0,($FFFFFAF2).w			; update counter
		move.l	PALCY_ElctFldA(pc,d0.w),($FFFFD44A).w	; load correct 1st colour to palette buffer
		move.l	PALCY_ElctFldA+$4(pc,d0.w),($FFFFD44E).w; load correct 2nd colour to palette buffer
		move.l	PALCY_ElctFldA+$8(pc,d0.w),($FFFFD452).w; load correct 3rd colour to palette buffer
		move.l	PALCY_ElctFldA+$C(pc,d0.w),($FFFFD456).w; load correct 4th colour to palette buffer

FDSP_EF_WaitTime:					; Offset: 000083E4
		addq.w	#$01,($FFFFFAF0).w			; increase palette cycle timer
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Palette Cycle Data "A" - each 4 colours per cycle
; ---------------------------------------------------------------------------

PALCY_ElctFldA:						; Offset: 000083EA
		dc.w	$0CE0,$0AC2,$0880,$0642			; Timeline
		dc.w	$0EAE,$0A8E,$086A,$0626
		dc.w	$0CE0,$0AC2,$0880,$0642			; V
		dc.w	$0EAE,$0A8E,$086A,$0626			; V
		dc.w	$0AC2,$0880,$0642,$0420			; V
		dc.w	$0A8E,$086A,$0626,$0404
		dc.w	$0880,$0642,$0420,$0200
		dc.w	$086A,$0626,$0404,$0200
		dc.w	$0642,$0420,$0200,$0200
		dc.w	$0626,$0404,$0200,$0200
		dc.w	$0420,$0200,$0200,$0200
		dc.w	$0404,$0200,$0200,$0200
		dc.w	$0200,$0200,$0200,$0200
		dc.w	$0200,$0200,$0200,$0200
		dc.w	$0200,$0200,$0200,$0200
		dc.w	$0200,$0200,$0200,$0200
		dc.w	$0420,$0200,$0200,$0200
		dc.w	$0404,$0200,$0200,$0200
		dc.w	$0626,$0404,$0200,$0200
		dc.w	$0642,$0420,$0200,$0200
		dc.w	$086A,$0626,$0404,$0200
		dc.w	$0880,$0642,$0420,$0200
		dc.w	$0A8E,$086A,$0626,$0404
		dc.w	$0AC2,$0880,$0642,$0420
		dc.w	$0EAE,$0A8E,$086A,$0626
		dc.w	$0CE0,$0AC2,$0880,$0642
		dc.w	$0EAE,$0A8E,$086A,$0626
		dc.w	$0CE0,$0AC2,$0880,$0642
		dc.w	$0A8E,$086A,$0626,$0404
		dc.w	$0AC2,$0880,$0642,$0420
		dc.w	$086A,$0626,$0404,$0200
		dc.w	$0880,$0642,$0420,$0200
		dc.w	$0626,$0404,$0200,$0200
		dc.w	$0642,$0420,$0200,$0200
		dc.w	$0404,$0200,$0200,$0200
		dc.w	$0420,$0200,$0200,$0200
		dc.w	$0200,$0200,$0200,$0200
		dc.w	$0200,$0200,$0200,$0200
		dc.w	$0200,$0200,$0200,$0200
		dc.w	$0200,$0200,$0200,$0200
		dc.w	$0404,$0200,$0200,$0200
		dc.w	$0420,$0200,$0200,$0200
		dc.w	$0642,$0420,$0200,$0200
		dc.w	$0626,$0404,$0200,$0200
		dc.w	$0880,$0642,$0420,$0200
		dc.w	$086A,$0626,$0404,$0200
		dc.w	$0AC2,$0880,$0642,$0420
		dc.w	$0A8E,$086A,$0626,$0404
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Palette Cycle Data "B" 1st
; ---------------------------------------------------------------------------
; First long-word is the location where the timer/counter is stored
; Second long-word is the palette buffer location of the colours we're cycling
; each long-word following is a colour, and a timer
; ---------------------------------------------------------------------------

PALCY_ElctFldB1:					; Offset: 0000856A
		dc.l	$FFFFFAEC				; timer/counter address
		dc.l	$FFFFD41C				; palette address
; ---------------------------------------------------------------------------
;		dc.w	$CCCC,$TTTT
; CCCC	= Colour to dump
; TTTT	= Time to wait before moving to the next line, (If FFFF, end of script)
; ---------------------------------------------------------------------------
		dc.w	$0EE0,$0064				; Timeline
		dc.w	$0420,$0032
		dc.w	$0EE0,$0002				; V
		dc.w	$0420,$0002				; V
		dc.w	$0EE0,$0002				; V
		dc.w	$0420,$0002
		dc.w	$0EE0,$0002
		dc.w	$0420,$0002
		dc.w	$0EE0,$0002
		dc.w	$0420,$0002
		dc.w	$0EE0,$0002
		dc.w	$0420,$0002
		dc.w	$0EE0,$000A
		dc.w	$0420,$000A
		dc.w	$0EE0,$0014
		dc.w	$0420,$0002
		dc.w	$0EE0,$0002
		dc.w	$0420,$0002
		dc.w	$0EE0,$0002
		dc.w	$0420,$0002
		dc.w	$0EE0,$0002
		dc.w	$0420,$0002
		dc.w	$0EE0,$0002
		dc.w	$0420,$0002
		dc.w	$0EE0,$FFFF
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Palette Cycle Data "B" 2nd (Same format as 1st)
; ---------------------------------------------------------------------------

PALCY_ElctFldB2:					; Offset: 000085D6
		dc.l	$FFFFFAEE				; timer/counter address
		dc.l	$FFFFD41E				; palette address
; ---------------------------------------------------------------------------
;		dc.w	$CCCC,$TTTT (Same format as 1st)
; ---------------------------------------------------------------------------
		dc.w	$08E0,$0032				; Timeline
		dc.w	$06C0,$0005
		dc.w	$04A0,$0005				; V
		dc.w	$0280,$0005				; V
		dc.w	$0060,$0005				; V
		dc.w	$0040,$0005
		dc.w	$0060,$0005
		dc.w	$0280,$0005
		dc.w	$04A0,$0005
		dc.w	$06C0,$0005
		dc.w	$08E0,$FFFF
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to calculate, cycle and dump the correct colour to the buffer
; For Palette Cycle B
; ---------------------------------------------------------------------------

FDSP_CyclePalB:					; Offset: 0000860A
		movea.l	(a0)+,a1				; load timer/counter location to a1
		movea.l	(a0)+,a2				; load palette buffer location to a2
		subq.b	#$01,$01(a1)				; decrease timer
		bne.s	FDSP_WaitTimer				; if not null, branch to skip
		addq.b	#$04,(a1)				; increase counter by 4
		move.b	(a1),d0					; load counter to d0
		andi.w	#$00FC,d0				; keep within FC in multiples of 4
		move.w	(a0,d0.w),(a2)				; load correct colour from palette cycle data to the buffer
		move.w	$02(a0,d0.w),d0				; load timer to d0
		bpl.s	FDSP_NoReset				; if it's positive (a.k.a. not FFFF), then branch
		move.w	$02(a0),(a1)				; load timer to set counter/timer
		rts						; return

FDSP_NoReset:						; Offset: 0000862C
		move.b	d0,$01(a1)				; set new timer amount

FDSP_WaitTimer:						; Offset: 00008630
		rts						; return
		rts						; another return (Possibly left in by mistake)

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load the Field level data
; ---------------------------------------------------------------------------

Field_LoadData:						; Offset: 00008634
		tst.w	($FFFFD834).w				; is Zone/World ID at 00?
		bne.w	FLD_Electric				; if not, branch
		lea	(PAL_RainbowField).l,a0			; load Rainbow palette
		bsr.w	Field_LoadPal				; dump palette to buffer
		lea	(ARTCRA_RainbowField8x8).l,a0		; load crackers compressed Rainbow art
		bsr.w	Field_LoadArt				; decompress and dump to V-Ram
		lea	(MAPUNC_RainbowFieldFG).l,a0		; load Rainbow FG mappings
		movea.w	($FFFFD816).w,a1			; load V-Ram plane A location to a1
		bsr.w	Field_LoadMap				; dump mappings to plane A
		lea	(MAPUNC_RainbowFieldBG).l,a0		; load Rainbow BG mappings
		movea.w	($FFFFD818).w,a1			; load V-Ram plane B location to a1
		bsr.w	Field_LoadMap				; dump mappings to plane B
		rts						; return

FLD_Electric:						; Offset: 0000866E
		lea	(PAL_ElectricField).l,a0		; load Electric palette
		bsr.w	Field_LoadPal				; dump palette to buffer
		lea	(ARTCRA_ElectricField8x8).l,a0		; load crackers compressed Electric art
		bsr.w	Field_LoadArt				; decompress and dump to V-Ram
		lea	(MAPUNC_ElectricFieldFG).l,a0		; load Electric FG mappings
		movea.w	($FFFFD816).w,a1			; load V-Ram plane A location to a1
		bsr.w	Field_LoadMap				; dump mappings to plane A
		lea	(MAPUNC_ElectricFieldBG).l,a0		; load Electric BG mappings
		movea.w	($FFFFD818).w,a1			; load V-Ram plane B location to a1
		bsr.w	Field_LoadMap				; dump mappings to plane B
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to dump two palette lines to the palette buffer starting at
; line 2 (Only used for Fields)
; ---------------------------------------------------------------------------

Field_LoadPal:						; Offset: 000086A0
		lea	($FFFFD424).w,a1			; load palette buffer (Starting at line 2)
		movem.l	(a0)+,d0-d7				; load first 10 colours
		movem.l	d0-d7,(a1)				; ...and dump to buffer
		lea	$20(a1),a1				; advance to the next 10 colours location
		movem.l	(a0)+,d0-d7				; load next 10 colours
		movem.l	d0-d7,(a1)				; ...and dump to buffer
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to decompress the Crackers compressed art for the fields using
; the table provided
; ---------------------------------------------------------------------------

Field_LoadArt:						; Offset: 000086BA
		move.w	(a0)+,d7				; load number of entires (Number of art files to decompress in table)

FLA_NextEntry:						; Offset: 000086BC
		move.w	d7,-(sp)				; store number of entires in the stack
		move	#$2700,sr				; set the status register (disable interrupts)
		lea	($00FF0200).l,a1			; load ram space to dump the art
		move.l	a1,d0					; prepare source location (sprite table buffer)
		move.w	(a0)+,d1				; prepare V-Ram destination (sprite table)
		move.w	(a0)+,d2				; prepare size (number of bytes divide by 20)
		lsl.w	#$04,d2					; multiply by 10
		jsr	CracDec					; decompress the art and dump to "source location"
		move.l	a0,-(sp)				; store current location for next entry
		jsr	DMA_WriteData				; set VDP to DMA transfer the uncompressed art
		movea.l	(sp)+,a0				; reload location of next entry from stack
		move	#$2300,sr				; set the status register (enable interrupts)
		move.w	(sp)+,d7				; reload number of entires to d7
		dbf	d7,FLA_NextEntry			; repeat til all entries are decompressed and dumped
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to dump the uncompress mappings for the Fields to a specified
; plane
; ---------------------------------------------------------------------------

Field_LoadMap:						; Offset: 000086EA
		move.w	(a0)+,d7				; load number of entries

FLM_NextEntry:						; Offset: 000086EC
		move.w	d7,-(sp)				; store in the stack
		move	#$2700,sr				; set the status register (disable interrupts)
		move.w	(a0)+,d6				; load V-Ram location
		add.w	a1,d6					; add the plane location
		move.w	(a0)+,d5				; load priority/colour/flip/mirror settings
		move.w	(a0)+,d4				; load number of X tiles to dump
		move.w	(a0)+,d3				; load number of Y lines to dump

FLM_NextYLine:						; Offset: 000086FC
		move.w	d6,d0					; copy V-Ram location to d0
		lsl.l	#$02,d0					; send far left bits to left side
		lsr.w	#$02,d0					; and send the rest back
		ori.w	#$4000,d0				; set V-Ram write mode (Map location)
		swap	d0					; swap sides
		andi.w	#$0003,d0				; clear all except the V-Ram location bits
		move.l	d0,($C00004).l				; set VDP to V-Ram write mode with location (H-Scroll table)
		move.w	d4,d2					; load number of X tiles to d2

FLM_NextXTile:						; Offset: 00008714
		move.w	(a0)+,d0				; load map tile ID
		add.w	d5,d0					; add priority/colour/flip/mirror settings
		move.w	d0,($C00000).l				; save to the V-Ram plane
		dbf	d2,FLM_NextXTile			; repeat for number of X tiles
		addi.w	#$0080,d6				; increase V-Ram value to the next map line
		dbf	d3,FLM_NextYLine			; repeat for number of Y lines
		move	#$2300,sr				; set the status register (enable interrupts)
		move.w	(sp)+,d7				; reload number of entries
		dbf	d7,FLM_NextEntry			; repeat til all entries are dumped
		rts						; return

; ===========================================================================


Fields_SetCharacter:						; Offset: 00008736
		tst.b	6(a6)
		bne.s	loc_8748
		lea	($FFFFD87C).w,a4
		moveq	#1,d2
		move.w	($FFFFD866).w,d0
		bra.s	loc_8752
; ---------------------------------------------------------------------------

loc_8748:				; CODE XREF: Fields_SetCharacter+4j
		lea	($FFFFD888).w,a4
		moveq	#8,d2
		move.w	($FFFFD868).w,d0

loc_8752:				; CODE XREF: Fields_SetCharacter+10j
		lea	word_87BC(pc,d0.w),a3
		movea.l	(a3),a0
		movea.l	$20(a3),a1
		movea.l	$40(a3),a2
		movea.l	$60(a3),a3
		move.w	$26(a6),d0
		adda.w	(a0,d0.w),a0
		moveq	#0,d1
		move.b	$28(a6),d1
		move.b	3(a0,d1.w),d0
		cmp.b	1(a0),d1
		bls.s	loc_878A
		move.b	2(a0),d0
		move.b	d0,$28(a6)
		move.b	3(a0,d0.w),d0
		bra.s	loc_87A0
; ---------------------------------------------------------------------------

loc_878A:				; CODE XREF: Fields_SetCharacter+44j
		move.b	(a0),d1
		add.w	d1,$28(a6)
		move.b	$28(a6),d1
		cmp.b	1(a0),d1
		bls.s	loc_87A4
		move.b	2(a0),$28(a6)

loc_87A0:				; CODE XREF: Fields_SetCharacter+52j
		clr.b	$29(a6)

loc_87A4:				; CODE XREF: Fields_SetCharacter+62j
		add.w	d0,d0
		add.w	d0,d0
		adda.w	(a1,d0.w),a3
		adda.w	2(a1,d0.w),a2
		move.l	a2,(a4)
		or.b	d2,($FFFFD87A).w
		move.l	a3,$10(a6)
		rts
; End of function Fields_SetCharacter

; ---------------------------------------------------------------------------
word_87BC:	dc.l	ANI_SonicFields
		dc.l	ANI_TailsFields
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	PLCMAP_SonicFields_MainIndex
		dc.l	PLCMAP_TailsFields_MainIndex
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	PLC_SonicFields
		dc.l	PLC_TailsFields
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	Map_SonicFields
		dc.l	Map_TailsFields
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000

; ===========================================================================
; ---------------------------------------------------------------------------
; Crackers Decompression Algorithm
; ---------------------------------------------------------------------------
; see http://info.sonicretro.org/Sonic_Crackers_art_compression for more info
; ---------------------------------------------------------------------------

CracDec:						; Offset: 0000883C
		movem.l	d1-d7/a2,-(sp)				; store register data to the stack
		move.w	(a0)+,d7				; load number of sections and "Retrace/Copy" privilege bits
		move.w	d7,d2					; copy to d2
		andi.w	#$3FFF,d7				; get number of sections of d7
		eor.w	d7,d2					; get "Retrace/Copy" bits of d2
		rol.w	#$02,d2					; send bits to far right
		moveq	#$04,d1					; prepare 4 in d1
		sub.w	d2,d1					; subtract "Retrace/Copy" bits from 4 (d1 = Copy Privilege Bits)
		moveq	#$01,d2					; prepare 1 in d1
		lsl.w	d1,d2					; shift left by 4 (-"Retrace/Copy" bits) (Multiplying by 2, 4, 8 or 10
		subq.w	#$01,d2					; decrease by 1 (1, 3, 7 or F) (d2 = Copy Privilege Hex)

CD_NextSection:						; Offset: 00008856
		move.b	(a0)+,d5				; load the "Phase Switch" byte for this section
		moveq	#$07,d6					; set repeat times (8 phases per 1 section)

CD_NextPhase:						; Offset: 0000885A
		add.b	d5,d5					; multiply "Phase Switch" by 2 (Checks the far left bit)
		bcs.w	CD_RetraceCopy				; if the current bit was set, branch for phase 2 (Retrace and Copy)
		move.b	(a0)+,(a1)+				; dump the uncompressed byte
		dbf	d6,CD_NextPhase				; repeat for 8 phases
		dbf	d7,CD_NextSection			; repeat til all sections are done
		movem.l	(sp)+,d1-d7/a2				; reload register data from the stack
		rts						; return

CD_RetraceCopy:						; Offset: 00008870
		moveq	#$00,d3					; clear d3
		move.b	(a0)+,d3				; load the data
		move.w	d3,d4					; copy to d4
		lsr.w	d1,d3					; get only the "Retrace" amount by using the number of "Copy Privilege Bits" that were stored
		and.w	d2,d4					; get only the "Copy" amount by using the value of "Copy Privilege Hex"
		neg.w	d3					; negate the "Retrace" amount to negative so it can search backwards
		lea	-1(a1,d3.w),a2				; search backwards by "Retrace" amount and store location in a2
		addq.w	#$01,d4					; increase "Copy" amount by 1

CD_NextCopyByte:					; Offset: 00008882
		move.b	(a2)+,(a1)+				; copy the byte from the previous location to the new location
		dbf	d4,CD_NextCopyByte			; repeat til "Copy" amount has elapsed
		dbf	d6,CD_NextPhase				; repeat for 8 phases
		dbf	d7,CD_NextSection			; repeat til all sections are done
		movem.l	(sp)+,d1-d7/a2				; reload register data from the stack
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Level Zones (Mode: 18)
; ---------------------------------------------------------------------------

	if	Combi	=	1
	else

Cool1:
		jsr	Levels_LoadPlayers			; load Player/Character objects
		jsr	LevelLoadRet
Cool2:
		jsr	Levels_LoadPlayersTail			; load Player/Character objects
		jsr	LevelLoadRet
		
	endif

Levels:							; Offset: 00008896
		moveq	#$28,d0					; set number of columns to dump
		moveq	#$20,d1					; set number of rows to dump
		move.w	#$8002,d2				; set value/tile to dump
		move.w	($FFFFD816).w,d3			; set V-Ram location to dump to (V-Ram plane A)
		jsr	MapScreenSingle				; dump to plane map
		pea	(a0)					; send a0 data to the stack
		lea	VB_Levels(pc),a0			; load location V-Blank routine to run
		move.l	a0,($FFFFC832).w			; set to run it during Levels
		movem.l	(sp)+,a0				; reload a0 data from stack
		lea	Levels_VDPRegData(pc),a0		; load VDP register setup values
		jsr	StoreVDPRegisters			; save VDP register data to ram spaces
		move.b	#$89,d0					; load BGM 81
		cmpi.w	#0,($FFFFD834).w				; is level SSZ?
		beq.s	TT_PlayMusic				; if yes, branch
		cmpi.w	#1,($FFFFD834).w				; is level TTZ?
		beq.s	SS_PlayMusic				; if yes, branch
		cmpi.w	#2,($FFFFD834).w				; is level IIZ?
		beq.s	II_PlayMusic				; if yes, branch
		cmpi.w	#3,($FFFFD834).w				; is level Flora?
		beq.s	II_PlayMusic				; if yes, branch
		bra.s	LV_PlayMusic
		
SS_PlayMusic:
		move.b	#$81,d0					; load BGM 81
		bra.s	LV_PlayMusic
TT_PlayMusic:
		move.b	#$87,d0					; load BGM 81
		bra.s	LV_PlayMusic
II_PlayMusic:
		move.b	#$88,d0					; load BGM 81
LV_PlayMusic:						; Offset: 000088C2
		jsr	(PlayMusic).l				; Play BGM
		lea	PAL_PrimaryColours(pc),a1		; load primary Level palettes address to a1
		lea	($FFFFD3E4).w,a0			; load palette buffer to a0
		moveq	#$0F,d1					; set repeat times (20 colours)

LV_DumpPalette:						; Offset: 000088D2
		move.l	(a1)+,(a0)+				; dump two colours to buffer
		dbf	d1,LV_DumpPalette			; repeat til all colours are dumped
		move.w	#$0000,(a0)				; clear the first colour in palette line 3
		bsr.w	DMA_LoadTitleCardArt			; load title card art to V-Ram
		bsr.w	DMA_LoadHudArt				; load HUD art to V-Ram
		andi.w	#$81BC,($FFFFC9BA).w			; Turn Display off in VDP register 01's data
		move.w	($FFFFC9BA).w,($C00004).l		; ...and save to that VDP register
		clr.l	($FFFFD82C).w				; reset level event counter to 0
		jsr	LevelLoadAndEvents			; run level events
		bsr.w	ObjectPosition_Load			; load object position data
		jsr	ObjectPosiion_Start			; run object position data (Start up)
		jsr	Objects_SetupRam
		move.w	#$0005,($FFFFD83C).w
		move.w	#$0007,($FFFFD840).w
		move.w	#$003F,($FFFFD844).w
		move.w	#$003F,($FFFFD848).w
		
	if	Combi	=	1
		jsr	Levels_LoadPlayers			; load Player/Character objects
		jsr	Combi_LoadStars				; load combi star objects
	else
		
		cmpi.b	#$FF,	($FFFFD8AC).w
		beq.w	Cool1
		bra.w	Cool2
		
	endif
		
LevelLoadRet:
		jsr	Levels_LoadEssentialArt			; load the essential art (springs/spikes)
		move	#$2300,sr				; set the status register (enable interrupts)
		jsr	Levels_LoadPalette			; load time of day palette for level
		jsr	Levels_LoadPalCycleObjects		; load the object to deal with palette cycling

; ---------------------------------------------------------------------------
; For SSZ it resets the camera positions for some reason
; ---------------------------------------------------------------------------

	;	tst.w	($FFFFD834).w				; is Zone/World ID set to SSZ?
	;	bne.s	Levels_SkipCameraReset			; if not, branch
	;	clr.w	($FFFFD830).w				; clear Screen's starting X position
	;	clr.w	($FFFFD832).w				; clear Screen's starting Y position
		move.w	($FFFFC9DE).w,	($FFFFFFDE).w
		move.w	($FFFFC9EE).w,	($FFFFFFEE).w
		clr.w	($FFFFC9DE).w				; clear Screen's X FG position
		clr.w	($FFFFC9EE).w				; clear Screen's Y FG position
	;	clr.w	($FFFFCA1E).w				; clear Screen's X BG position
	;	clr.w	($FFFFCA2E).w				; clear Screen's Y BG position

; ---------------------------------------------------------------------------

Levels_SkipCameraReset:					; Offset: 00008968

		bsr.w	ClearScreen_ForTitleCard		; clear the screen for the titlecard
		ori.w	#$8144,($FFFFC9BA).w			; Turn Display on in VDP register 01's data
		move.w	($FFFFC9BA).w,($C00004).l		; ...and save to that VDP register
		bsr.w	TitleCardSlide_In			; run title card slide in routines
		jsr	sub_F94A
		bra.w	Levels_Start				; continue

; ===========================================================================
; ---------------------------------------------------------------------------
PAL_PrimaryColours:					; Offset: 00008988
		incbin  Palettes\PalPrimaryColours.bin
		even
; ---------------------------------------------------------------------------
Levels_VDPRegData:					; Offset: 000089C8
		dc.w	$8230					; [Scroll Plane A Map Table VRam address: $C000];
		dc.w	$832C					; [Window Plane A Map Table VRam address: $B000];
		dc.w	$8407					; [Scroll Plane B Map Table VRam address: $E000];
		dc.w	$8578					; [Sprite Plane Map Table VRam address: $F000];
		dc.w	$8D34					; [Horizontal Scroll Table VRam address: $D000];
		dc.w	$9001					; [VDP Screen Map Size: Vertical Size 32 Cell/Horizontal Size 64 Cell];
		dc.w	$8730					; [Backdrop Colour: Palette Line 3/Colour ID 0];
		dc.w	$8B00					; [External Interrupt Off];[V-Scroll: Full];[H-Scroll: Full];[Line: By Screen];
		dc.w	$8C81					; [H-Mode: 40 Cell];[Shadow/Hi-Lighting Off];[Interlace Off];
		dc.w	$9100					; [Window Horizontal Position: 00];
		dc.w	$9200					; [Window Vertical Position: 00];
		dc.w	$0000					; Null - End of table
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Levels routine start/loop
; ---------------------------------------------------------------------------

Levels_Start:						; Offset: 000089E0
		pea	(Levels_Start).l			; save the offset starting HERE to the stack
		bclr	#$07,($FFFFFFC9).w			; set to not run this routine til V-Blank has run

LS_WaitVB:						; Offset: 000089EC
		tst.b	($FFFFFFC9).w				; is the routine ready to continue?
		bpl.s	LS_WaitVB				; if not, loop and recheck
		bsr.w	Pause_WindowOut				; check to slide Pause Window out
		jsr	Levels_GetControls			; get controls configured for the Level
		jsr	Levels_Pause				; check for pause
		jsr	Control_Combi				; run the combi related controls
		jsr	Control_Players				; run the player related controls
		jsr	LevelLoadAndEvents			; run level events
		jsr	ObjectPosiion_Run			; run object position data
		jsr	RunObjects				; run object routines
		jsr	sub_EBAE
		jsr	sub_F954
		move	#$2700,sr				; set the status register (disable interrupts)
		jsr	BuildSprites				; build object sprites
		move	#$2300,sr				; set the status register (enable interrupts)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load the control button data for the Levels
; ---------------------------------------------------------------------------

Levels_GetControls:						; Offset: 00008A3A
		jsr	GetControls
		lea	($FFFFC938).w,a3
		moveq	#0,d1
		move.b	($FFFFD89C).w,d1
		moveq	#7,d0
		and.b	3(a3,d1.w),d0
		sne	d2
		move.b	4(a3,d1.w),d0
		move.b	d0,d1
		andi.b	#$70,d1	; 'p'
		sne	d1
		or.b	d2,d1
		andi.b	#$70,d1	; 'p'
		or.b	d1,d0
		lea	($FFFFFB00).w,a4
		move.b	-1(a4),d1
		andi.w	#$F,d1
		move.b	(a4,d1.w),d2
		move.b	d0,(a4,d1.w)
		addq.b	#1,-1(a4)
		move.b	d2,-2(a4)
		lea	($FFFFD89C).w,a4
		bsr.w	sub_8ABC
		move.b	($FFFFFAFE).w,d0
		lea	($FFFFC938).w,a3
		moveq	#0,d1
		move.b	($FFFFD8AC).w,d1
		bmi.s	loc_8AB4
		moveq	#7,d0
		and.b	3(a3,d1.w),d0
		sne	d2
		move.b	4(a3,d1.w),d0
		move.b	d0,d1
		andi.b	#$70,d1	; 'p'
		sne	d1
		or.b	d2,d1
		andi.b	#$70,d1	; 'p'
		or.b	d1,d0

loc_8AB4:				; CODE XREF: Levels_GetControls+5Cj
		lea	($FFFFD8AC).w,a4
		bra.w	*+4
; End of function Levels_GetControls


; =============== S U B	R O U T	I N E =======================================


sub_8ABC:				; CODE XREF: Levels_GetControls+4Ap
		move.b	2(a4),4(a4)
		move.b	d0,2(a4)
		move.b	4(a4),d1
		eor.b	d0,d1
		beq.s	loc_8AD2
		clr.b	6(a4)

loc_8AD2:				; CODE XREF: sub_8ABC+10j
		addq.b	#1,6(a4)
		and.b	d0,d1
		move.b	d1,3(a4)
		andi.w	#$F,d0
		move.b	byte_8B0C(pc,d0.w),5(a4)
		moveq	#3,d1
		and.w	d0,d1
		ror.w	#1,d1
		ext.l	d1
		move.w	d1,d2
		swap	d1
		or.w	d1,d2
		move.w	d2,$A(a4)
		andi.w	#$C,d0
		ror.w	#3,d0
		ext.l	d0
		move.w	d0,d1
		swap	d0
		or.w	d0,d1
		move.w	d1,8(a4)
		rts
; End of function sub_8ABC

; ---------------------------------------------------------------------------
byte_8B0C:	dc.b 0,	$C0, $40, $C0
		dc.b $80, $A0, $60, $A0
		dc.b 0,	$E0, $20, $E0
		dc.b $80, $A0, $60, $A0
; ---------------------------------------------------------------------------

VB_Levels:						; Offset: 00008B1C
		movem.l	d0-a6,-(sp)
		jsr	sub_9F7C
		jsr	DMA_ProcessCue
		jsr	DMA_MovePalette
		jsr	DMA_WriteCharactersPLC
		move.l	#$FFFFD164,d0
		move.w	($FFFFD81A).w,d1
		move.w	#$140,d2
		jsr	DMA_WriteData
		lea	($FF0A00).l,a3
		lea	($FF0B02).l,a4
		lea	($FFFFC9DE).w,a5
		jsr	DumpMapPlaneBuffers
		lea	($FF0B84).l,a3
		lea	($FF0C86).l,a4
		lea	($FFFFCA1E).w,a5
		jsr	DumpMapPlaneBuffers
		ori.b	#$80,($FFFFFFC9).w
		addq.w	#1,($FFFFF000).w
		movem.l	(sp)+,d0-a6
		rte

; =============== S U B	R O U T	I N E =======================================

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control the Pause menu functions during Levels
; ---------------------------------------------------------------------------


Levels_Pause:						; Offset: 00008B7E
		tst.b	($FFFFD89F).w				; has player 1 pressed pause?
		bpl.w	Levels_NoPause				; if not, branch
		move.b	($FFFFC93C).w,d0			; load player 1 menu held buttons to d0
		andi.b	#$70,d0					; get only if A, B or C have been pressed
		cmpi.b	#$70,d0					; were A, B or C been held BEFORE start was pressed?
		bne.s	Levels_NoReset				; if not, branch
		jsr	Pal_FadeBlack				; fade the palettes to black
		move	#$2700,sr				; set the status register (disable interrupts)
		suba.l	a0,a0					; decrease a0 from itself (clears a0 more quickly)
		movea.l	(a0)+,sp				; reset the stack pointer location
		movea.l	(a0)+,a0				; reset a0 location
		jmp	(a0)					; jump to that location (Resetting the entire rom)

Levels_NoReset:						; Offset: 00008BA0
		movem.l	d0-a6,-(sp)				; store register data to the stack

; ---------------------------------------------------------------------------
; Pause Main Loop
; ---------------------------------------------------------------------------

Levels_PauseLoop:					; Offset: 00008BA4
		bclr	#$07,($FFFFFFC9).w			; set to not run this routine til V-Blank has run

LPL_WaitVB:						; Offset: 00008BAA
		tst.b	($FFFFFFC9).w				; is the routine ready to continue?
		bpl.s	LPL_WaitVB				; if not, loop and recheck
		jsr	(Levels_GetControls).l			; get controls configured for the Level
		move.w	($FFFFD8A4).w,d0			; load pause main X speed control
		move.w	($FFFFD8A6).w,d1			; load pause main Y speed control
		add.w	d0,d0					; multiply X...
		add.w	d0,d0					; ...by 4
		add.w	d1,d1					; multiply Y...
		add.w	d1,d1					; ...by 4
		movea.w	($FFFFD862).w,a0			; load Sonic's ram address to a0
		add.w	d0,$08(a0)				; add to Sonic's X position
		add.w	d1,$0C(a0)				; add to Sonic's Y position
		movea.w	($FFFFD864).w,a0			; load Tails' ram address to a0
		add.w	d0,$08(a0)				; add to Tails' X position
		add.w	d1,$0C(a0)				; add to Tails' Y position
		jsr	Control_Combi				; run the combi related controls
		jsr	LevelLoadAndEvents			; run level events
		jsr	BuildSprites				; build object sprites
		bsr.w	Pause_WindowIn				; check to slide Pause Window in
		tst.b	($FFFFC93D).w				; has player 1 pressed pause again?
		bpl.s	Levels_PauseLoop			; if not, loop pause system
		movem.l	(sp)+,d0-a6				; retore registers

Levels_NoPause:						; Offset: 00008BFC
		rts						; return
; End of function Levels_Pause

; ===========================================================================
; ---------------------------------------------------------------------------
; Object Position Loading
; ---------------------------------------------------------------------------

ObjectPosition_Load:					; Offset: 00008BFE
		moveq	#$00,d0					; clear d0
		move.w	($FFFFD834).w,d0			; load Zone/World ID
	;	andi.w	#$0001,d0				; make sure only Zones 0 and 1 are useable
		lsl.l	#$02,d0					; multiply by 4 (long-word)
		movea.l	OPL_ObjectLists(pc,d0.w),a0		; load Object Position address to use
		lea	OPL_LevelSizes(pc,d0.w),a1		; load level sizes address
		move.w	(a1)+,d2				; max X size of level for objects to be loaded
		move.w	(a1),d3					; max Y size of level for objects to be loaded
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Screen Sizes
; ---------------------------------------------------------------------------
OPL_LevelSizes:						; Offset: 00008C18
		dc.w	$3FFF					; Max X size (SSZ)
		dc.w	$07FF					; Max Y size (SSZ)
		dc.w	$07FF					; Max X size (TTZ)
		dc.w	$0FFF					; Max Y size (TTZ)
		dc.w	$1FFF					; Max X size (TTZ)
		dc.w	$0FFF					; Max Y size (TTZ)	
		dc.w	$1FFF					; Max X size (TTZ)
		dc.w	$0FFF					; Max Y size (TTZ)	
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Object position lists
; ---------------------------------------------------------------------------
OPL_ObjectLists:					; Offset: 00008C20
		dc.l	Objpos_SSZ
		dc.l	Objpos_TTZ
		dc.l	Objpos_IIZ
		dc.l	Objpos_FLRA
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load essential art (Not for SSZ)
; ---------------------------------------------------------------------------

Levels_LoadEssentialArt:				; Offset: 00008C30
		tst.w	($FFFFD834).w				; is Zone/World ID set to SSZ?
		beq.s	LLEA_NotForSSZ				; if so, skip art loading
		move	#$2700,sr				; set the status register (disable interrupts)
		lea	(ARTNEM_Springs).l,a0			; load compress "Spring" art address
		move.l	#$40E00002,($C00004).l			; set VDP V-Ram address and modes
		jsr	NemDec					; decompress and dump
		move	#$2700,sr				; set the status register (disable interrupts)
		lea	(ARTNEM_SpikesVer).l,a0			; load compress "Vertical Spikes" art address
		move.l	#$7EE00001,($C00004).l			; set VDP V-Ram address and modes
		jsr	NemDec					; decompress and dump
		move	#$2700,sr				; set the status register (disable interrupts)
		lea	(ARTNEM_SpikesHoz).l,a0			; load compress "Horizontal Spikes" art address
		move.l	#$77E00001,($C00004).l			; set VDP V-Ram address and modes
		jsr	NemDec					; decompress and dump
		move	#$2700,sr				; set the status register (disable interrupts)
		lea	(ARTNEM_Goal).l,a0			; load compress "Horizontal Spikes" art address
		move.l	#$49000002,($C00004).l			; set VDP V-Ram address and modes
		jsr	NemDec					; decompress and dump
		move	#$2700,sr				; set the status register (disable interrupts)
		lea	(ARTNEM_Monitor).l,a0			; load compress "Horizontal Spikes" art address
		move.l	#$4B000002,($C00004).l			; set VDP V-Ram address and modes
		jsr	NemDec					; decompress and dump

LLEA_NotForSSZ:						; Offset: 00008C7E
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; UNUSED - DO NOT ALTER THESE EXPECTING CHANGES, THE CORRECT ROUTINE IS ABOVE
; ---------------------------------------------------------------------------
; Unused subroutine to load spring and spikes art (Another method)
; ---------------------------------------------------------------------------

Levels_UnusedLoadEssentialArt:				; Offset: 00008C80
		lea	(LULEA_ArtList).l,a1			; load compress art list

LULEA_NextEntry:					; Offset: 00008C86
		moveq	#$00,d0					; clear d0
		move.w	(a1)+,d0				; load V-Ram address
		cmpi.w	#$FFFF,d0				; is it the end of the list?
		beq.s	LULEA_Finish				; if so, branch
		movem.l	d0-a6,-(sp)				; store register data
		movea.l	(a1)+,a0				; load art address to a0
		lsl.l	#$02,d0					; send far left bits to left side
		lsr.w	#$02,d0					; and send the rest back
		ori.w	#$4000,d0				; set V-Ram write mode
		swap	d0					; swap sides
		andi.w	#$0003,d0				; clear all except the V-Ram location bits
		move	#$2700,sr				; set the status register (disable interrupts)
		move.l	d0,($C00004).l				; set VDP V-Ram write mode with address
		jsr	NemDec					; decompress and dump art
		movem.l	(sp)+,d0-a6				; reload register data
		bra.s	LULEA_NextEntry				; repeat for next entry

LULEA_Finish:						; Offset: 00008CB8
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; UNUSED - DO NOT ALTER THESE EXPECTING CHANGES, THE CORRECT ROUTINE IS ABOVE
; ---------------------------------------------------------------------------
LULEA_ArtList:						; Offset: 00008CBA
		dc.w	$80E0					; V-Ram address
		dc.l	ARTNEM_Springs				; Compressed art address
		dc.w	$7EE0					; ''
		dc.l	ARTNEM_SpikesVer			; ''
		dc.w	$77E0					; ''
		dc.l	ARTNEM_SpikesHoz			; ''
		dc.w	$FFFF					; end if list
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load the time of day palettes
; ---------------------------------------------------------------------------

Levels_LoadPalette:					; Offset: 00008CCE
		moveq	#$00,d1					; clear d1
		move.w	($FFFFD834).w,d1			; load Zone/World ID
;		andi.w	#$0001,d1				; get only Zone's 0 and 1
		lsl.l	#$01,d1					; multiply by 2
		jmp	LLPal_Levels(pc,d1.w)			; jump to correct routine

; ===========================================================================
; ---------------------------------------------------------------------------
LLPal_Levels:						; Offset: 00008CDE
		bra.s	LLPal_SSZ				; 00
		bra.s	LLPal_SSZ				; 02
		bra.s	LLPal_SSZ				; 00
		bra.s	LLPal_SSZ				; 00
		rts
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Time of day palettes for SSZ
; ---------------------------------------------------------------------------

LLPal_SSZ:						; Offset: 00008CE2
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Time of day palettes for TTZ
; ---------------------------------------------------------------------------

LLPal_TTZ:						; Offset: 00008CE4
		moveq	#$00,d0					; clear d0
		move.w	($FFFFD83A).w,d0			; load "Level time of day value"
		andi.w	#$0003,d0				; get only time of days from 0 to 3
		lsl.l	#$06,d0					; multiply by 40 (number of bytes per palette)
		lea	(PAL_TechnoTowerZone_Day1).l,a1		; load first day palette address
		adda.l	d0,a1					; add to the correct day palette address
		lea	($FFFFD424).w,a0			; load palette buffer
		move.b	#$1F,d7					; set repeat times

LLPal_TTZ_Dump:						; Offset: 00008D00
		move.w	(a1)+,(a0)+				; dump palette data to palette buffer
		dbf	d7,LLPal_TTZ_Dump			; repeat til time of day palette is dumped
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Colour Palettes for TTZ
; ---------------------------------------------------------------------------

PAL_TechnoTowerZone_Day1:				; Offset: 00008D08
		incbin  "Palettes\PalTechnoTowerZone 1.bin"	; Morning
		even

PAL_TechnoTowerZone_Day2:				; Offset: 00008D48
		incbin  "Palettes\PalTechnoTowerZone 2.bin"	; Day-time
		even

PAL_TechnoTowerZone_Day3:				; Offset: 00008D88
		incbin  "Palettes\PalTechnoTowerZone 3.bin"	; Evening
		even

PAL_TechnoTowerZone_Day4:				; Offset: 00008DC8
		incbin  "Palettes\PalTechnoTowerZone 4.bin"	; Night-time
		even

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Special Stage (Blank) (Mode: 20)
; ---------------------------------------------------------------------------

SpecialStage:						; Offset: 00008E06
		move.w	($FFFFD824).w,d0			; load routine counter
		jmp	Special_Routines(pc,d0.w)			; jump to correct routine based on counter
		
Special_Routines:
		bra.w	SpecialStartup
		bra.w	SSLoop

SpecialStartup
		move.b	#$86,d0					; set music $86 to d0 (Game Over music)
		jsr	(PlayMusic).l				; play song
		pea	(a0)					; send a0 data to the stack
		lea	VB_OptionsSoundTest(pc),a0		; load location V-Blank routine to run
		move.l	a0,($FFFFC832).w			; set to run it during Sound Test
		movem.l	(sp)+,a0				; reload a0 data from stack
		move	#$2700,sr				; set the status register (disable interrupts)
		moveq	#$3F,d0					; set number of columns to dump
		moveq	#$3F,d1					; set number of rows to dump
		moveq	#$00,d2					; set value to dump
		move.w	#$C000,d3				; set V-Ram location to dump to
		jsr	MapScreenSingle				; dump the value to V-Ram (Clears screen)
		moveq	#$3F,d0					; set number of columns to dump
		moveq	#$3F,d1					; set number of rows to dump
		move.w	#$E000,d3				; set V-Ram location to dump to
		jsr	MapScreenSingle				; dump the value to V-Ram (Clears screen)
		move.l	#$45180003,d0				; set V-Ram location to dump to
		lea	SorryNothing(pc),a1			; load location of "OPTION" letter to a1
		moveq	#$0D,d1					; set number of columns to dump (6 letters)
		moveq	#$00,d2					; set number of rows to dump
		move.w	#$0000,d3				; set to use palette line 0 (and to map behind object plane)
		jsr	MapScreen				; map to screen planes
		
		move.l	#$78000003,($C00004).l			; set VRam location (sprite table)
		move.l	#$00000000,($C00000).l			; clear the arrow sprite
		move.l	#$00000000,($C00000).l			; ''
		move.w	#$0080,($FFFFD82A).w			; set Sound Test ID to start with
		move	#$2300,sr				; set the status register (enable interrupts)
		addq.w	#$04,($FFFFD824).w			; increase routine counter
		
		clr.w	($FFFF0000)
		
		rts
				
SSLoop:
		bclr	#$07,($FFFFFFC9).w			; set to not run this routine til V-Blank has run

SSWait:
		tst.b	($FFFFFFC9).w				; is the routine ready to continue?
		bpl.s	SSWait				; if not, loop and recheck
		add.w	#1,	($FFFF0000)
		cmpi.w	#$150,	($FFFF0000)
		blo.s	SSLoop
		move.w	#$0008,($FFFFD822).w			; set Screen/Game mode to title screen
		clr.l	($FFFFD824).w				; reset routine counter to 0
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Tile map ID's that spell "OPTION"
; ---------------------------------------------------------------------------
SorryNothing:						; Offset: 00009440
		dc.w	$0033
		dc.w	$002F
		dc.w	$0032
		dc.w	$0032
		dc.w	$0039
		dc.w	$0000
		dc.w	$002E
		dc.w	$002F
		dc.w	$0034
		dc.w	$0028
		dc.w	$0029
		dc.w	$002E
		dc.w	$0027
		even
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Unknown Screen/Game mode (Mode: 28)
; ---------------------------------------------------------------------------

UnkRet001:						; Offset: 00008E08
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Select (Level Select) (Mode: 30)
; ---------------------------------------------------------------------------

LevelSelect:						; Offset: 00008E0C
		move.w	($FFFFD824).w,d0			; load routine counter
		jmp	LS_Routines(pc,d0.w)			; jump to correct routine based on counter

; ===========================================================================
; ---------------------------------------------------------------------------
LS_Routines:						; Offset: 00008E14
		bra.w	LS_StartUp				; Start up of Level Select
		bra.w	LS_Selection				; Level Select main routine
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Start up of Level Select
; ---------------------------------------------------------------------------

LS_StartUp:						; Offset: 00008E1C
		pea	(a0)					; send a0 data to the stack
		lea	VB_LevelSelect(pc),a0			; load location V-Blank routine to run
		move.l	a0,($FFFFC832).w			; set to run it during Level Select
		movem.l	(sp)+,a0				; reload a0 data from stack
		move	#$2700,sr				; set the status register (disable interrupts)
		moveq	#$3F,d0					; set number of columns to dump
		moveq	#$3F,d1					; set number of rows to dump
		moveq	#$00,d2					; set value to dump
		move.w	#$C000,d3				; set V-Ram location to dump to
		jsr	MapScreenSingle				; dump the value to V-Ram (Clears Plane A Map Table)
		lea	ARTNEM_MenuSelectorBorder(pc),a0	; load compressed art for selector border
		move.l	#$4C000000,($C00004).l			; set V-Ram location to decompress to
		jsr	NemDec					; decompress
		move.l	#$42000003,d0				; prepare V-Ram location for the top "W 1", "W 2", etc
		lea	MAPUNC_SelectMenu_1(pc),a1		; load mappings for the top "W 1", "W 2", etc
		moveq	#$27,d1					; set columns to dump
		moveq	#$03,d2					; set rows to dump
		move.w	#$0000,d3				; set to use palette line 0 (and to map behind object plane)
		jsr	MapScreen				; map to screen
		move.l	#$78000003,($C00004).l			; set VDP to V-Ram write mode (Sprite Table)
		move.l	#$01000001,($C00000).l			; Arrow XXXX YYZZ (Y pos, Shape & Priority)
		move.l	#$001E00A8,($C00000).l			; Arrow XXXX YYYY (VRam, X pos)
		move.l	#$00A00F00,($C00000).l			; Selector Border XXXX YYZZ (Y pos, Shape & Priority)
		move.l	#$00600110,($C00000).l			; Selector Border YYYY (VRam, X pos)
		move.w	#$0000,($FFFFD834).w			; Zone/World ID (Vertical)
		move.w	#$0000,($FFFFD836).w			; Level/Act/Field ID (Horizontal)
		move.l	#$00000EEE,($FFFFD3E4).w		; set background and border colour to use
		move.l	#$00000EEE,($FFFFD404).w		; set unknown colours
		jsr	DMA_MovePalette				; set VDP to DMA transfer the Menu palette
		move	#$2300,sr				; set the status register (enable interrupts)
		addq.w	#$04,($FFFFD824).w			; increase routine counter
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Level Select main routine
; ---------------------------------------------------------------------------

LS_Selection:						; Offset: 00008EC0
		bclr	#7,($FFFFFFC9).w			; set to not run this routine til V-Blank has run

LSS_WaitVB:						; Offset: 00008EC6
		tst.b	($FFFFFFC9).w				; is the routine ready to continue?
		bpl.s	LSS_WaitVB				; if not, loop and recheck
		move.w	($FFFFC944).w,d0			; load horizontal selection to d0
		add.w	($FFFFD834).w,d0			; add Zone/World ID to d0
		bpl.s	LSS_NoFarLeft				; if positive, branch
		moveq	#$00,d0					; reset to 00

LSS_NoFarLeft:						; Offset: 00008ED8
		cmpi.w	#$0009,d0				; has the selection gone passed 09?
		bls.s	LSS_NoFarRight				; if not, branch
		moveq	#9,d0					; reset to 09

LSS_NoFarRight:						; Offset: 00008EE0
		move.w	d0,($FFFFD834).w			; save ID to Zone/World ID
		move.w	d0,d1					; copy to d1
		lsl.w	#$05,d1					; multiply by 20
		subi.w	#$0090,d1				; decrease by 90
		move.w	d1,($FFFFD830).w			; save to Screen's new FG X position
		lea	MAPUNC_SelectMenu_2(pc),a1		; load "WORLD ?" mappings to a1
		lsl.w	#$04,d0					; multiply by 20 (size of each "SelectMenu" mappings)
		adda.w	d0,a1					; add to correct "WORLD ?" number mappings
		move.l	#$65080003,d0				; set V-Ram location to map
		moveq	#$07,d1					; set number of columns to dump
		moveq	#$00,d2					; set number of rows to dump
		move.w	#$0000,d3				; set to use palette line 0 (and to map behind object plane)
		jsr	MapScreen				; map to screen
		move.w	($FFFFD834).w,d1			; load Zone/World ID to d1
		cmpi.w	#$07,d1					; is the selection currently passed 07?
		bcc.s	LSS_Premium				; if so, branch

; ---------------------------------------------------------------------------
; Mapping screen for "WORLD ?" selections
; ---------------------------------------------------------------------------

		move.w	#$0100,($FFFFD820).w			; set map increase amount (two lines)
		move.l	#$66100003,d0				; set V-Ram location to map
		lea	MAPUNC_SelectMenu_3(pc),a1		; load "ATTRACTION LV.?" mappings to a1
		moveq	#$0F,d1					; set number of columns to dump
		moveq	#$05,d2					; set number of rows to dump
		move.w	#$0000,d3				; set to use palette line 0 (and to map behind object plane)
		jsr	MapScreen				; map to screen
		move.w	#$0080,($FFFFD820).w			; set map increase amount (one line)
		bra.w	LSS_CheckSelection			; continue

; ---------------------------------------------------------------------------
; Mapping screen for "PREMIUM?" selections
; ---------------------------------------------------------------------------

LSS_Premium:						; Offset: 00008F3A
		cmpi.w	#$09,d1					; is the selection currently passed 07?
		bcc.s	LSS_Special				; if so, branch
		moveq	#$00,d0					; clear d0
		move.l	#$66100003,($C00004).l			; set V-Ram location to map
		move.w	#$17F,d1				; set repeat times

LSS_PremiumClear:					; Offset: 00008F50
		move.l	d0,($C00000).l				; clear mappings
		dbf	d1,LSS_PremiumClear			; repeat til mappings (where ATTRACTION LV.? were) are erased
		move.l	#$6B100003,d0				; set V-Ram location for ("PREMIUM"s) "FIELD"
		lea	MAPUNC_SelectMenu_4(pc),a1		; load ("PREMIUM"s) "ATTRACTION/FIELD" mappings to a1
		moveq	#$0F,d1					; set number of columns to dump
		moveq	#$00,d2					; set number of rows to dump
		move.w	#$0000,d3				; set to use palette line 0 (and to map behind object plane)
		jsr	MapScreen				; map "FIELD" to screen
		move.l	#$6A100003,d0				; set V-Ram location for ("PREMIUM"s) "ATTRACTION"
		moveq	#$0F,d1					; set number of columns to dump
		moveq	#$00,d2					; set number of rows to dump
		move.w	#$0000,d3				; set to use palette line 0 (and to map behind object plane)
		jsr	MapScreen				; map "ATTRACTION" to screen
		bra.s	LSS_CheckSelection			; continue

; ---------------------------------------------------------------------------
; Mapping screen for "SPECIAL" selection
; ---------------------------------------------------------------------------

LSS_Special:						; Offset: 00008F84
		moveq	#$00,d0					; clear d0
		move.l	#$66100003,($C00004).l			; set V-Ram location to map
		move.w	#$17F,d1				; set repeat times

LSS_SpecialClear:					; Offset: 00008F94
		move.l	d0,($C00000).l				; clear mappings
		dbf	d1,LSS_SpecialClear			; repeat til mappings (where ATTRACTION LV.? were) are erased
		move.l	#$6B100003,d0				; set V-Ram location for "SPECIAL STAGE"
		lea	MAPUNC_SelectMenu_5(pc),a1		; load mappings for "SPECIAL STAGE" to a1
		moveq	#$0F,d1					; set number of columns to dump
		moveq	#$00,d2					; set number of rows to dump
		move.w	#$0000,d3				; set to use palette line 0 (and to map behind object plane)
		jsr	MapScreen				; map to screen
		bra.s	LSS_CheckSelection			; continue

; ===========================================================================
; ---------------------------------------------------------------------------
; Maximum Selection Data, each word is the maximum selection amount for each
; WORLD/PREMIUM/SPECIAL
; ---------------------------------------------------------------------------
LSS_MaxSelData:						; Offset: 00008FB6
		dc.w	$0005					; WORLD 1 (6 selections)
		dc.w	$0005					; WORLD 2 (6 selections)			
		dc.w	$0005					; WORLD 3 (6 selections)
		dc.w	$0005					; WORLD 4 (6 selections)
		dc.w	$0005					; WORLD 5 (6 selections)
		dc.w	$0005					; WORLD 6 (6 selections)
		dc.w	$0005					; WORLD 7 (6 selections)
		dc.w	$0001					; PREMIUM1 (2 selections)
		dc.w	$0001					; PREMIUM2 (2 selections)
		dc.w	$0000					; SPECIAL (1 selection)
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Selection on Y
; ---------------------------------------------------------------------------

LSS_CheckSelection:					; Offset: 00008FCA
		move.w	($FFFFD834).w,d1			; load Zone/World ID to d1
		add.w	d1,d1					; multiply by 2
		move.w	LSS_MaxSelData(pc,d1.w),d1		; get correct maximum selection based on Zone/World ID
		move.w	($FFFFC946).w,d0			; load vertical selection to d0
		neg.w	d0					; negate to negative
		add.w	($FFFFD836).w,d0			; add Level/Act/Field ID
		bpl.s	LSS_CS_NoFarDown			; if it's positive, branch
		moveq	#$00,d0					; reset to 00

LSS_CS_NoFarDown:					; Offset: 00008FE2
		cmp.w	d1,d0					; is it further up than it's suppose to be?
		bls.s	LSS_CS_NoFarUp				; if not, branch
		move.w	d1,d0					; set maximum (top)

LSS_CS_NoFarUp:						; Offset: 00008FE8
		move.w	d0,($FFFFD836).w			; save to Level/Act/Field ID
		lsl.w	#$04,d0					; multiply by 10
		neg.w	d0					; negate to negative
		addi.w	#$130,d0				; add 130 to it
		move.w	d0,($FFFFD832).w			; save to Screen's new FG Y position
		tst.b	($FFFFC93D).w				; has player 1 pressed start?
		bmi.s	LSS_CS_RunSelection			; if so, branch
		rts						; return

; ---------------------------------------------------------------------------
; Setting Screen/Game modes and settings depending on the selection
; ---------------------------------------------------------------------------

LSS_CS_RunSelection:					; Offset: 00009000
		clr.l	($FFFFD824).w				; clear routine counter
		cmpi.w	#$0009,($FFFFD834).w			; is Zone/World ID at 09?
		bne.s	LSS_CS_NotSpecial			; if not, branch
		move.w	#$0020,($FFFFD822).w			; set Screen/Game mode to special stage
		rts						; return

LSS_CS_NotSpecial:					; Offset: 00009014
		tst.w	($FFFFD836).w				; is Level/Act/Field ID at 00 (Field)?
		bne.s	LSS_CS_NotField				; if not, branch
		move.w	#$0010,($FFFFD822).w			; set Screen/Game mode to fields
		rts						; return

LSS_CS_NotField:					; Offset: 00009022
		move.w	($FFFFD836).w,d0			; load Level/Act/Field ID to d0
		andi.w	#$0003,d0				; get only within 03
		move.w	d0,($FFFFD83A).w			; set time of day for level
		move.w	#$0001,($FFFFD836).w			; set Level/Act/Field ID to 01
		move.w	#$0018,($FFFFD822).w			; set Screen/Game mode to level
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Vertical Blanking Interval (Level Select)
; ---------------------------------------------------------------------------

VB_LevelSelect:						; Offset: 0000903C
		movem.l	d0-a6,-(sp)				; store register data to the stack
		move.l	#$7C000003,($C00004).l			; set VDP to V-Ram write mode (Horizontal Scroll Table)
		move.w	($FFFFD830).w,d0			; load Screen's new FG X position
		neg.w	d0					; negate to opposite
		move.w	d0,($C00000).l				; save to horizontal scroll table (For table to move left/right)
		move.l	#$78000003,($C00004).l			; set VDP to V-Ram write mode (sprite Table again?? ok)
		move.w	($FFFFD832).w,($C00000).l		; save Screen's new FG Y position
		jsr	GetControls				; get controls being pressed/held
		move.b	($FFFFC93C).w,d0			; load player 1 held controls to d0
		bsr.s	VB_LS_ButtonToIDAdd			; get add ID
		move.w	d1,($FFFFC940).w			; set right nybble to add (Left byte)
		move.w	d2,($FFFFC942).w			; set left nybble to add (Left byte)
		move.b	($FFFFC93D).w,d0			; load player 1 pressed controls to d0
		bsr.s	VB_LS_ButtonToIDAdd			; get add ID
		move.w	d1,($FFFFC944).w			; set right nybble to add (Right byte)
		move.w	d2,($FFFFC946).w			; set left nybble to add (Right byte)
		jsr	DMA_MovePalette				; set VDP to DMA transfer the menu palette
		ori.b	#$80,($FFFFFFC9).w			; allow normal routine to run
		movem.l	(sp)+,d0-a6				; reload register data from the stack
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; This subroutine is the same as routine "VB_TS_ButtonToIDAdd"
; ---------------------------------------------------------------------------

VB_LS_ButtonToIDAdd:					; Offset: 00009098
		moveq	#$03,d1					; set 3 in d1
		and.w	d0,d1					; get only button bits that were pressed of d1
		ror.w	#$01,d1					; send up button to far left, and down button to far right
		ext.l	d1					; set word signed (if up was pressed, sets FFFF on left side)
		move.w	d1,d2					; copy button arrangements to d2
		swap	d1					; swap words
		or.w	d1,d2					; set d1 bits onto d2 (if up was pressed, FFFF will be set in d2, if down 0001, otherwise 0000)
		andi.w	#$000C,d0				; get only right/left button bits
		ror.w	#$03,d0					; send right button to far right, and left button to far left
		ext.l	d0					; set word signed (if left was pressed, sets FFFF on left side)
		move.w	d0,d1					; copy button arrangements to d1
		swap	d0					; swap words
		or.w	d0,d1					; set d1 bits onto d2 (if left was pressed, FFFF will be set in d2, if right 0001, otherwise 0000)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Level Select map data
; ---------------------------------------------------------------------------
ARTNEM_MenuSelectorBorder:				; Offset: 000090B6
		incbin  NemesisComp\ArtnemMenuSelectorBorder.bin	; Selector Art for Select Menu screen
		even
MAPUNC_SelectMenu_1:					; Offset: 000090EA	
		incbin  Uncompressed\MapuncSelectMenu01.bin		; Uncompressed mappings	for the	select menu (Top W? numbers that scroll)
		even
MAPUNC_SelectMenu_2:					; Offset: 0000922A
		incbin  Uncompressed\MapuncSelectMenu02.bin		; Uncompressed mappings for the select menu (World ? words)
		even
MAPUNC_SelectMenu_3:					; Offset: 000092CA
		incbin  Uncompressed\MapuncSelectMenu03.bin		; Uncompressed mappings	for the	select menu (Attraction	LV.? words)
		even
MAPUNC_SelectMenu_4:					; Offset: 0000936A
		incbin  Uncompressed\MapuncSelectMenu04.bin		; Uncompressed mappings	for the	select menu (Field/Attraction words)
		even
MAPUNC_SelectMenu_5:					; Offset; 000093AA
		incbin  Uncompressed\MapuncSelectMenu05.bin		; Uncompressed mappings	for the	select menu (Special Stage word)
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Unknown Screen/Game mode (Mode: 38)
; ---------------------------------------------------------------------------

UnkRet002:						; Offset: 000093CA
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Options (Sound Test) (Mode: 40)
; ---------------------------------------------------------------------------

OptionsSoundTest:					; Offset: 000093CC
		move.w	($FFFFD824).w,d0			; load routine counter to d0
		jmp	OST_Routines(pc,d0.w)			; jump to correct routine based on counter

; ===========================================================================
; ---------------------------------------------------------------------------
OST_Routines:						; Offset: 000093D4
		bra.w	OST_StartUp				; Start up of Sound Test
		bra.w	OST_SoundID				; Sound Test main routine
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Start up of Sound Test
; ---------------------------------------------------------------------------

OST_StartUp:						; Offset: 000093DC
		move.b	#$FF,d0					; set music $86 to d0 (Game Over music)
		jsr	(PlayMusic).l				; play song
		pea	(a0)					; send a0 data to the stack
		lea	VB_OptionsSoundTest(pc),a0		; load location V-Blank routine to run
		move.l	a0,($FFFFC832).w			; set to run it during Sound Test
		movem.l	(sp)+,a0				; reload a0 data from stack
		move	#$2700,sr				; set the status register (disable interrupts)
		moveq	#$3F,d0					; set number of columns to dump
		moveq	#$3F,d1					; set number of rows to dump
		moveq	#$00,d2					; set value to dump
		move.w	#$C000,d3				; set V-Ram location to dump to
		jsr	MapScreenSingle				; dump the value to V-Ram (Clears screen)
		move.l	#$44200003,d0				; set V-Ram location to dump to
		lea	OST_MapTiles(pc),a1			; load location of "OPTION" letter to a1
		moveq	#$05,d1					; set number of columns to dump (6 letters)
		moveq	#$00,d2					; set number of rows to dump
		move.w	#$0000,d3				; set to use palette line 0 (and to map behind object plane)
		jsr	MapScreen				; map to screen planes
		
		move.l	#$44120003,d0				; prepare VDP settings
		lea	MAPUNC_TitleMenu_4(pc),a1		; load uncompressed title mappings to a1 (Title Screen "Banner")
		moveq	#18,d1					; set X loop
		moveq	#5,d2					; set Y loop
		move.w	#0,d3					; set to use palette line 0 (and to map behind object plane)
		jsr	MapScreen				; map it on screen correctly
		
		move.l	#$78000003,($C00004).l			; set VRam location (sprite table)
		move.l	#$00000000,($C00000).l			; clear the arrow sprite
		move.l	#$00000000,($C00000).l			; ''
		move.w	#$0080,($FFFFD82A).w			; set Sound Test ID to start with
		move	#$2300,sr				; set the status register (enable interrupts)
		addq.w	#$04,($FFFFD824).w			; increase routine counter
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Tile map ID's that spell "OPTION"
; ---------------------------------------------------------------------------
OST_MapTiles:						; Offset: 00009440
		dc.w	$002F					; O Tile ID
		dc.w	$0030					; P Tile ID
		dc.w	$0034					; T Tile ID
		dc.w	$0029					; I Tile ID
		dc.w	$002F					; O Tile ID
		dc.w	$002E					; N Tile ID
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Sound Test main routine
; ---------------------------------------------------------------------------

OST_SoundID:						; Offset: 0000944C
		bclr	#$07,($FFFFFFC9).w			; set to not run this routine til V-Blank has run

OST_SID_WaitVB:						; Offset: 00009452
		tst.b	($FFFFFFC9).w				; is the routine ready to continue?
		bpl.s	OST_SID_WaitVB				; if not, loop and recheck
		move.w	($FFFFC944).w,d0			; load right nybble of sound test ID to d0
		add.b	d0,($FFFFD82B).w			; save to sound ID storage
		move.w	($FFFFC946).w,d0			; load left nybble of sound test ID to d0
		lsl.w	#$04,d0					; shift to left nybble
		add.b	d0,($FFFFD82B).w			; save to sound ID storage
		move	#$2700,sr				; set the status register (disable interrupts)
		move.w	($FFFFD82A).w,d0			; load sound ID to d0
		move.w	($FFFFD816).w,d1			; load V-Ram map location to dump to
		addi.w	#$0820,d1				; increase by 820 (Set V-Ram location)
		jsr	(MapNumbers).l				; dump sound ID as mappings on screen
		move	#$2300,sr				; set the status register (enable interrupts)
		move.b	($FFFFC93D).w,d0			; load controls to d0
		bpl.s	OST_SID_NoStart				; if positive (if start was not pressed), branch
		move.b	#$E0,d0					; set "fade out" music
		jsr	(PlayMusic).l				; play music
		move.w	#$0008,($FFFFD822).w			; set game mode to main menu
		clr.l	($FFFFD824).w				; reset routine counter to 0
		rts						; return

OST_SID_NoStart:					; Offset: 000094A0
		andi.b	#$70,d0					; is A, B or C pressed?
		bne.s	OST_SID_PlayMusic			; if so, branch
		rts						; return

OST_SID_PlayMusic:					; Offset: 000094A8
		move.w	($FFFFD82A).w,d0			; load sound ID storage to d0
		jsr	(PlayMusic).l				; play that ID
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Vertical Blanking Interval (Options Sound Test)
; ---------------------------------------------------------------------------

VB_OptionsSoundTest:					; Offset: 000094B4
		movem.l	d0-a6,-(sp)				; store register data to the stack
		move.l	#$78000003,($C00004).l			; set VDP to V-Ram write mode (sprite table)
		move.w	($FFFFD832).w,($C00000).l		; save Screen's new FG Y position (to sprite Table???)
		jsr	GetControls				; get controls being pressed/held
		move.b	($FFFFC93C).w,d0			; load player 1 held controls to d0
		bsr.s	VB_OST_ButtonToIDAdd			; convert buttons to add ID
		move.w	d1,($FFFFC940).w			; set right nybble to add (Left byte)
		move.w	d2,($FFFFC942).w			; set left nybble to add (Left byte)
		move.b	($FFFFC93D).w,d0			; load player 1 pressed controls to d0
		bsr.s	VB_OST_ButtonToIDAdd			; convert buttons to add ID
		move.w	d1,($FFFFC944).w			; set right nybble to add (Right byte)
		move.w	d2,($FFFFC946).w			; set left nybble to add (Right byte)
		ori.b	#$80,($FFFFFFC9).w			; allow normal routine to run
		movem.l	(sp)+,d0-a6				; reload register data from the stack
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; This subroutine is the same as routine "VB_TS_ButtonToIDAdd"
; ---------------------------------------------------------------------------

VB_OST_ButtonToIDAdd:					; Offset: 000094F6
		moveq	#$03,d1					; set 3 in d1
		and.w	d0,d1					; get only button bits that were pressed of d1
		ror.w	#$01,d1					; send up button to far left, and down button to far right
		ext.l	d1					; set word signed (if up was pressed, sets FFFF on left side)
		move.w	d1,d2					; copy button arrangements to d2
		swap	d1					; swap words
		or.w	d1,d2					; set d1 bits onto d2 (if up was pressed, FFFF will be set in d2, if down 0001, otherwise 0000)
		andi.w	#$000C,d0				; get only right/left button bits
		ror.w	#$03,d0					; send right button to far right, and left button to far left
		ext.l	d0					; set word signed (if left was pressed, sets FFFF on left side)
		move.w	d0,d1					; copy button arrangements to d1
		swap	d0					; swap words
		or.w	d0,d1					; set d1 bits onto d2 (if left was pressed, FFFF will be set in d2, if right 0001, otherwise 0000)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Main core routine to load level data and to control a level during game
; ---------------------------------------------------------------------------

LevelLoadAndEvents:					; Offset: 00009514
		move.w	($FFFFD834).w,d0			; load Zone/World ID to d0
		lsl.w	#$03,d0					; multiply by 8
		add.w	($FFFFD836).w,d0			; add Act ID
		add.w	d0,d0					; multiply by...
		add.w	d0,d0					; ...x4 (bra.w are 4 bytes each)
		jmp	LLAE_Levels(pc,d0.w)			; jump to correct branch command based on zone and act

; ---------------------------------------------------------------------------
; All act 0's branch here to return
; ---------------------------------------------------------------------------

Null_Act00:						; Offset: 00009526
		rts						; return (null)

; ===========================================================================
; ---------------------------------------------------------------------------
; Each Zone/World has about 8 acts (0 to 7), however 0 is never used, and
; there are a total of 9 zones, though Zones from 2 to 9 are unused (don't exist).
; ---------------------------------------------------------------------------

LLAE_Levels:						; Offset: 00009528

; ---------------------------------------------------------------------------
; Zone 00: SSZ (Speed Slider Zone)
; ---------------------------------------------------------------------------
		bra.w	Null_Act00				; Zone: 00 Act: 0
		bra.w	SSZ_Act01				; Zone: 00 Act: 1
		bra.w	SSZ_Act02				; Zone: 00 Act: 2
		bra.w	SSZ_Act03				; Zone: 00 Act: 3
		bra.w	SSZ_Act04				; Zone: 00 Act: 4
		bra.w	SSZ_Act05				; Zone: 00 Act: 5
		bra.w	Null_Act00				; Zone: 00 Act: 6
		bra.w	Null_Act00				; Zone: 00 Act: 7
; ---------------------------------------------------------------------------
; Zone 01: TTZ (Techno Tower Zone)
; ---------------------------------------------------------------------------
		bra.w	Null_Act00				; Zone: 01 Act: 0
		bra.w	TTZ_Act01				; Zone: 01 Act: 1
		bra.w	TTZ_Act02				; Zone: 01 Act: 2
		bra.w	TTZ_Act03				; Zone: 01 Act: 3
		bra.w	TTZ_Act04				; Zone: 01 Act: 4
		bra.w	TTZ_Act05				; Zone: 01 Act: 5
		bra.w	Null_Act00				; Zone: 01 Act: 6
		bra.w	Null_Act00				; Zone: 01 Act: 7
; ---------------------------------------------------------------------------
; Zone 02: Unknown (Unused)
; ---------------------------------------------------------------------------
		bra.w	Null_Act00				; Zone: 02 Act: 0
		bra.w	U2Z_Act01				; Zone: 02 Act: 1
		bra.w	U2Z_Act02				; Zone: 02 Act: 2
		bra.w	U2Z_Act03				; Zone: 02 Act: 3
		bra.w	U2Z_Act04				; Zone: 02 Act: 4
		bra.w	U2Z_Act05				; Zone: 02 Act: 5
		bra.w	Null_Act00				; Zone: 02 Act: 6
		bra.w	Null_Act00				; Zone: 02 Act: 7
; ---------------------------------------------------------------------------
; Zone 03: Unknown (Unused)
; ---------------------------------------------------------------------------
		bra.w	Null_Act00				; Zone: 03 Act: 0
		bra.w	U3Z_Act01				; Zone: 03 Act: 1
		bra.w	U3Z_Act02				; Zone: 03 Act: 2
		bra.w	U3Z_Act03				; Zone: 03 Act: 3
		bra.w	U3Z_Act04				; Zone: 03 Act: 4
		bra.w	U3Z_Act05				; Zone: 03 Act: 5
		bra.w	Null_Act00				; Zone: 03 Act: 6
		bra.w	Null_Act00				; Zone: 03 Act: 7
; ---------------------------------------------------------------------------
; Zone 04: Unknown (Unused)
; ---------------------------------------------------------------------------
		bra.w	Null_Act00				; Zone: 04 Act: 0
		bra.w	U4Z_Act01				; Zone: 04 Act: 1
		bra.w	U4Z_Act02				; Zone: 04 Act: 2
		bra.w	U4Z_Act03				; Zone: 04 Act: 3
		bra.w	U4Z_Act04				; Zone: 04 Act: 4
		bra.w	U4Z_Act05				; Zone: 04 Act: 5
		bra.w	Null_Act00				; Zone: 04 Act: 6
		bra.w	Null_Act00				; Zone: 04 Act: 7
; ---------------------------------------------------------------------------
; Zone 05: Unknown (Unused)
; ---------------------------------------------------------------------------
		bra.w	Null_Act00				; Zone: 05 Act: 0
		bra.w	U5Z_Act01				; Zone: 05 Act: 1
		bra.w	U5Z_Act02				; Zone: 05 Act: 2
		bra.w	U5Z_Act03				; Zone: 05 Act: 3
		bra.w	U5Z_Act04				; Zone: 05 Act: 4
		bra.w	U5Z_Act05				; Zone: 05 Act: 5
		bra.w	Null_Act00				; Zone: 05 Act: 6
		bra.w	Null_Act00				; Zone: 05 Act: 7
; ---------------------------------------------------------------------------
; Zone 06: Unknown (Unused)
; ---------------------------------------------------------------------------
		bra.w	Null_Act00				; Zone: 06 Act: 0
		bra.w	U6Z_Act01				; Zone: 06 Act: 1
		bra.w	U6Z_Act02				; Zone: 06 Act: 2
		bra.w	U6Z_Act03				; Zone: 06 Act: 3
		bra.w	U6Z_Act04				; Zone: 06 Act: 4
		bra.w	U6Z_Act05				; Zone: 06 Act: 5
		bra.w	Null_Act00				; Zone: 06 Act: 6
		bra.w	Null_Act00				; Zone: 06 Act: 7
; ---------------------------------------------------------------------------
; Zone 07: Unknown (Unused)
; ---------------------------------------------------------------------------
		bra.w	Null_Act00				; Zone: 07 Act: 0
		bra.w	U7Z_Act01				; Zone: 07 Act: 1
		bra.w	Null_Act00				; Zone: 07 Act: 2
		bra.w	Null_Act00				; Zone: 07 Act: 3
		bra.w	Null_Act00				; Zone: 07 Act: 4
		bra.w	Null_Act00				; Zone: 07 Act: 5
		bra.w	Null_Act00				; Zone: 07 Act: 6
		bra.w	Null_Act00				; Zone: 07 Act: 7
; ---------------------------------------------------------------------------
; Zone 08: Unknown (Unused)
; ---------------------------------------------------------------------------
		bra.w	Null_Act00				; Zone: 08 Act: 0
		bra.w	U8Z_Act01				; Zone: 08 Act: 1
		bra.w	Null_Act00				; Zone: 08 Act: 2
		bra.w	Null_Act00				; Zone: 08 Act: 3
		bra.w	Null_Act00				; Zone: 08 Act: 4
		bra.w	Null_Act00				; Zone: 08 Act: 5
		bra.w	Null_Act00				; Zone: 08 Act: 6
		bra.w	Null_Act00				; Zone: 08 Act: 7
; ---------------------------------------------------------------------------
; Zone 09: Unknown (Unused)
; ---------------------------------------------------------------------------
		bra.w	Null_Act00				; Zone: 09 Act: 0
		bra.w	U9Z_Act01				; Zone: 09 Act: 1
		bra.w	Null_Act00				; Zone: 09 Act: 2
		bra.w	Null_Act00				; Zone: 09 Act: 3
		bra.w	Null_Act00				; Zone: 09 Act: 4
		bra.w	Null_Act00				; Zone: 09 Act: 5
		bra.w	Null_Act00				; Zone: 09 Act: 6
		bra.w	Null_Act00				; Zone: 09 Act: 7
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 00: SSZ (Speed Slider Zone) (Act 01)
; ---------------------------------------------------------------------------

SSZ_Act01:						; Offset: 00009668
		move.w	($FFFFD82C).w,d0			; load level event counter
		jmp	SSZ01_Events(pc,d0.w)			; jump to correct event routine

; ===========================================================================
; ---------------------------------------------------------------------------
SSZ01_Events:						; Offset: 00009670
		bra.w	SSZ01_StartUp				; 00
		bra.w	SSZ01_StartLevel			; 04
		bra.w	SSZ01_RunLevel				; 08
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Loading SSZ's level data
; ---------------------------------------------------------------------------

SSZ01_StartUp:						; Offset: 0000967C
		move	#$2700,sr				; set the status register (disable interrupts)
		lea	(ArtnemAPZ_TitleCard).l,a0			; load compress "Horizontal Spikes" art address
		move.l	#$42200000,($C00004).l			; set VDP V-Ram address and modes
		jsr	NemDec					; decompress and dump
		lea	($FFFFC9DE).w,a1			; load address of positions and sizes ram (FG)
		move.w	#$0104,$1E(a1)
		lea	PAL_SpeedSliderZone(pc),a0		; load SSZ palette
		lea	($FFFFD424).w,a2			; load palette buffer address to a2
		bsr.w	LoadHalfPalette				; dump the palette to the buffer
		lea	SSZ_FG_StartLocCam(pc),a0		; load level FG setup data address to a0
		lea	($FFFFD816).w,a2			; load address of V-Ram plane A storage
		bsr.w	LoadLevelPositionAndSize		; save the positions and sizes of the level
		movea.l	a1,a0					; copy address of positions and sizes ram to a0
		lea	SSZ_ArtLocs(pc),a2			; load address of level compressed art locations
		bsr.w	DMA_NemLevelArtLoad			; decompress and DMA transfer art
		lea	($FFFFC9DE).w,a0			; load address of positions and sizes ram
		move.l	#$00FF0D08,$28(a0)			; set ram address to decompress the map data to
		lea	SSZ_MapFGLocs(pc),a2			; load level map/collision data address to a2
		bsr.w	EniLevelMapLoad				; decompress and dump mappings
		move.l	a1,($FFFFCA46).w			; ??? stores the end address of the FG layout, but for what reason?
		bsr.w	LoadCollisionPaths			; load collision data
		lea	SSZ_BG_StartLocCam(pc),a0		; load level BG setup data address to a0
		lea	($FFFFCA1E).w,a1			; load address of positions and sizes ram (BG)
		move.w	#$0104,$1E(a1)
		lea	($FFFFD818).w,a2			; load address of V-Ram plane B storage
		bsr.w	LoadLevelPositionAndSize		; save the positions and sizes of the level
		movea.l	a1,a0					; copy address of positions and sizes ram to a0
		lea	SSZ_MapBGLocs(pc),a2			; load level map/collision data address to a2
		bsr.w	EniLevelMapLoad				; decompress and dump mappings
		move.l	a1,($FFFFFBC0).w			; ??? stores the end address of the BG layout, but for what reason?
		movea.l	a0,a1					; copy address of positions and sizes ram back to a0
		lea	($00FF0B84).l,a3			; load BG horizontal map plane buffer address
		lea	($00FF0C86).l,a4			; load BG vertical map plane buffer address
		clr.w	($00FF0A00).l				; set no FG horizontal V-Ram plane address
		clr.w	($00FF0B02).l				; set no FG vertical V-Ram plane address
		clr.w	($00FF0B84).l				; set no BG horizontal V-Ram plane address
		clr.w	($00FF0C86).l				; set no BG vertical V-Ram plane address
		bsr.w	DrawScreen_Full				; draw the entire screen/planes (For BG only)
		move	#$2300,sr				; set the status register (enable interrupts)
		addq.w	#$04,($FFFFD82C).w			; increase level event counter
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Starting up of SSZ's level
; ---------------------------------------------------------------------------

SSZ01_StartLevel:					; Offset: 00009720
		jsr	TitleCardSlide_Out			; slide title card out
		addq.w	#$04,($FFFFD82C).w			; increase level event counter

; ---------------------------------------------------------------------------
; Running/During SSZ
; ---------------------------------------------------------------------------

SSZ01_RunLevel:						; Offset: 0000972A
		movea.w	($FFFFD862).w,a0			; load Sonic's ram address to a0
		lea	($FFFFC9DE).w,a1			; load FG positions and sizes ram to a1
		lea	($00FF0A00).l,a3			; load FG horizontal map plane buffer address
		lea	($00FF0B02).l,a4			; load FG vertical map plane buffer address
		bsr.w	Control_ScreenPosX			; keep X position clean
		bsr.w	Control_ScreenPosY			; keep Y position clean
		bsr.w	DrawScreen_Void				; draw FG void sides
		movea.w	($FFFFD862).w,a0			; load Sonic's ram address to a0
		lea	($FFFFCA1E).w,a1			; load BG positions and sizes ram to a1
		lea	($00FF0B84).l,a3			; load BG horizontal map plane buffer address
		lea	($00FF0C86).l,a4			; load BG vertical map plane buffer address
		bsr.s	ControlSSZ_BGScreenPos			; control SSZ's BG screen position
		bsr.w	DrawScreen_Void				; draw BG void sides
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Unused routine to control the X screen position (possibly for the BG)
; ---------------------------------------------------------------------------

		move.w  $00(a1),d0				; load X position
		move.w	d0,$02(a1)				; save as last frame's X position
		move.w	($FFFFD830).w,d1			; load screen's new X position
		sub.w	d0,d1					; subtract X pos from new X pos
		blt.s	ContUnk_LeftCheck			; if it's negative, branch
		cmpi.w	#$0010,d1				; is it further than 10 pixels right?
		ble.s	ContUnk_CheckOther			; if not, branch
		move.w	#$0010,d1				; set 10 pixels right max
		bra.s	ContUnk_CheckOther			; continue

ContUnk_LeftCheck:					; Offset: 00009782
		cmpi.w	#$FFF0,d1				; is it further than 10 pixels left?
		bgt.s	ContUnk_CheckOther			; if not, branch
		move.w	#$FFF0,d1				; set 10 pixels left max

ContUnk_CheckOther:					; Offset: 0000978C
		add.w	d1,d0					; add to X position
		move.w	d0,d1					; copy to d1
		move.w	$08(a1),d2				; load X start position
		addi.w	#$013F,d2				; add 13F (140 is size of screen)
		and.w	d2,d1
		move.w  d1,$00(a1)				; save new X position
		move.w	$08(a1),d1				; load X start position
		cmp.w	d1,d0					; is it higher than the new X position?
		bgt.s	ContUnk_UpdatePosition			; if so, branch
		move.w	$0A(a1),d1
		cmp.w	d1,d0					; is it higher than the new X position?
		bgt.s	ContUnk_NoUpdatePosition		; if so, branch

ContUnk_UpdatePosition:					; Offset: 000097AE
		move.w  d1,$00(a1)				; save new X position

ContUnk_NoUpdatePosition:				; Offset: 000097B2
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control the BG's screen position (For SSZ only)
; ---------------------------------------------------------------------------

ControlSSZ_BGScreenPos:					; Offset: 000097B4
		move.w	$10(a1),d0				; load screen's Y position
		move.w	d0,$12(a1)				; save as last frame's Y position
		move.w	$0C(a0),d1				; load character's Y position
		subi.w	#$0080,d1				; minus 80 pixels
		mulu.w	#$02,d1					; multiply by 2
		ext.l	d1					; extend incase it's negative
		divu.w	#$05,d1					; divide by 5
		move.w	d1,$10(a1)				; save screen's new Y position
		move.w	$0C(a1),d0				; load Y start position
		cmp.w	d0,d1					; is it higher than the new X position?
		bgt.s	CSSZ_BSP_UpdatePosition			; if so, branch
		move.w	$0E(a1),d0
		cmp.w	d0,d1					; is it higher than the new X position?
		bgt.s	CSSZ_BSP_NoUpdatePosition		; if so, branch

CSSZ_BSP_UpdatePosition:				; Offset: 000097E2
		move.w	d0,$10(a1)				; save new X position

CSSZ_BSP_NoUpdatePosition:				; Offset: 000097E6
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Unknown (Unused) routine
; ---------------------------------------------------------------------------

		lea	($FFFFCA5E).w,a2
		clr.w	($FFFFFBC8).w
		move.w	($FFFFC9DE).w,d3
		neg.w	d3
		addq.w	#3,($FFFFFBC4).w
		move.w	($FFFFFBC4).w,d2
		move.w	#$6F,d7	; 'o'
		move.w	$10(a1),d0
		move.w	d0,d1
		andi.w	#1,d1
		bne.s	loc_9846

loc_980E:						; Offset: 0000980E
		jsr	CalcSine
		move.w	d3,(a2)+
		lsr.w	#8,d1
		ext.w	d1
		neg.w	d1
		move.w	d1,(a2)+
		move.w	d3,(a2)+
		neg.w	d1
		move.w	d1,(a2)+
		addi.l	#$1000,($FFFFFBC8).w
		sub.w	($FFFFFBC8).w,d2
		dbf	d7,loc_980E
		move.l	#$FFFFCA5E,d0
		move.w	($FFFFD81C).w,d1
		move.w	#$1C0,d2
		jsr	DMA_WriteCueEntry
		rts

loc_9846:						; Offset: 00009846
		jsr	CalcSine
		move.w	d3,(a2)+
		lsr.w	#8,d1
		ext.w	d1
		move.w	d1,(a2)+
		move.w	d3,(a2)+
		neg.w	d1
		move.w	d1,(a2)+
		addi.l	#$1000,($FFFFFBC8).w
		sub.w	($FFFFFBC8).w,d2
		dbf	d7,loc_9846
		move.l	#$FFFFCA5E,d0
		move.w	($FFFFD81C).w,d1
		move.w	#$1C0,d2
		jsr	DMA_WriteCueEntry
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 00: SSZ (Speed Slider Zone) (Act 02)
; ---------------------------------------------------------------------------

SSZ_Act02:						; Offset: 0000987C
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 00: SSZ (Speed Slider Zone) (Act 03)
; ---------------------------------------------------------------------------

SSZ_Act03:						; Offset: 0000987E
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 00: SSZ (Speed Slider Zone) (Act 04)
; ---------------------------------------------------------------------------


SSZ_Act04:						; Offset: 00009880
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 00: SSZ (Speed Slider Zone) (Act 05)
; ---------------------------------------------------------------------------


SSZ_Act05:						; Offset: 00009882
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 01: TTZ (Techno Tower Zone) (Act 01)
; ---------------------------------------------------------------------------

TTZ_Act01:						; Offset: 00009884
		move.w	($FFFFD82C).w,d0			; load level event counter
		jmp	TTZ01_Events(pc,d0.w)			; jump to correct event routine

; ===========================================================================
; ---------------------------------------------------------------------------
TTZ01_Events:						; Offset: 0000988C
		bra.w	TTZ01_StartUp				; 00
		bra.w	TTZ01_StartLevel			; 04
		bra.w	TTZ01_RunLevel				; 08
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Loading TTZ's level data
; ---------------------------------------------------------------------------

TTZ01_StartUp:						; Offset: 00009898
		move	#$2700,sr				; set the status register (disable interrupts)
		lea	(ArtnemRHZ_TitleCard).l,a0			; load compress "Horizontal Spikes" art address
		move.l	#$42200000,($C00004).l			; set VDP V-Ram address and modes
		jsr	NemDec					; decompress and dump
		lea	($FFFFC9DE).w,a1			; load address of positions and sizes ram (FG)
		lea	TTZ_FG_StartLocCam(pc),a0		; load level FG setup data address to a0
		lea	($FFFFD816).w,a2			; load address of V-Ram plane A storage
		bsr.w	LoadLevelPositionAndSize		; save the positions and sizes of the level
		movea.l	a1,a0					; copy address of positions and sizes ram to a0
		lea	TTZ_ArtLocs(pc),a2			; load address of level compressed art locations
		bsr.w	DMA_NemLevelArtLoad			; decompress and DMA transfer art
		lea	($FFFFC9DE).w,a0			; load address of positions and sizes ram
		move.l	#$00FF0D08,$28(a0)			; set ram address to decompress the map data to
		lea	TTZ_MapFGLocs(pc),a2			; load level map/collision data address to a2
		bsr.w	EniLevelMapLoad				; decompress and dump mappings
		move.l	a1,($FFFFCA46).w			; ??? stores the end address of the FG layout, but for what reason?
		bsr.w	LoadCollisionPaths			; load collision data
		lea	TTZ_BG_StartLocCam(pc),a0		; load level BG setup data address to a0
		lea	($FFFFCA1E).w,a1			; load address of positions and sizes ram (BG)
		move.w	#$104,$1E(a1)
		lea	($FFFFD818).w,a2			; load address of V-Ram plane B storage
		bsr.w	LoadLevelPositionAndSize		; save the positions and sizes of the level
		movea.l	a1,a0					; copy address of positions and sizes ram to a0
		lea	TTZ_MapBGLocs(pc),a2			; load level map/collision data address to a2
		bsr.w	EniLevelMapLoad				; decompress and dump mappings
		move.l	a1,($FFFFFBC0).w			; ??? stores the end address of the BG layout, but for what reason?
		movea.l	a0,a1					; copy address of positions and sizes ram back to a0
		lea	($00FF0B84).l,a3			; load BG horizontal map plane buffer address
		lea	($00FF0C86).l,a4			; load BG vertical map plane buffer address
		bsr.w	DrawScreen_Full				; draw the entire screen/planes (For BG only)
		move	#$2300,sr				; set the status register (enable interrupts)
		addq.w	#$04,($FFFFD82C).w			; increase level event counter
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Starting up of TTZ's level
; ---------------------------------------------------------------------------

TTZ01_StartLevel:					; Offset: 0000991E
		jsr		LLPal_TTZ
	;	lea	($FFFFD424).w,a2			; load palette buffer address to a2
	;	bsr.w	LoadHalfPalette				; dump the palette to the buffer
		jsr	TitleCardSlide_Out			; slide title card out
		addq.w	#$04,($FFFFD82C).w			; increase level event counter

; ---------------------------------------------------------------------------
; Running/During TTZ
; ---------------------------------------------------------------------------

TTZ01_RunLevel:						; Offset: 00009928
		movea.w	($FFFFD862).w,a0			; load Sonic's ram address to a0
		lea	($FFFFC9DE).w,a1			; load FG positions and sizes ram to a1
		lea	($00FF0A00).l,a3			; load FG horizontal map plane buffer address
		lea	($00FF0B02).l,a4			; load FG vertical map plane buffer address
		bsr.w	Control_ScreenPosX			; keep X position clean
		bsr.w	Control_ScreenPosY			; keep Y position clean
		bsr.w	DrawScreen_Void				; draw FG void sides
		movea.w	($FFFFD862).w,a0			; load Sonic's ram address to a0
		lea	($FFFFCA1E).w,a1			; load BG positions and sizes ram to a1
		lea	($00FF0B84).l,a3			; load BG horizontal map plane buffer address
		lea	($00FF0C86).l,a4			; load BG vertical map plane buffer address
		bsr.s	ControlTTZ_BGScreenPos			; control TTZ's BG screen position
		bsr.w	Control_ScreenPosY			; keep Y position clean
		jsr	DrawScreen_Void				; draw BG void sides
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control the BG's screen position (For TTZ only)
; ---------------------------------------------------------------------------

ControlTTZ_BGScreenPos:					; Offset: 0000996A
		moveq	#$00,d1					; clear d1
		move.w	$00(a1),d0				; load X position
		move.w	d0,$02(a1)				; save as last frame X position
		move.w	($FFFFD830).w,d1			; load screen's new X position
		mulu.w	#$13,d1					; multiply by 13
		divu.w	#$1B,d1					; divide by 1B
		move.w  d1,$00(a1)				; save as X position
		move.w	$08(a1),d0				; load X start position
		cmp.w	d0,d1					; is it higher than the new X position?
		bgt.s	CTTZ_BSP_UpdatePosition			; if so, branch
		move.w	$0A(a1),d0
		cmp.w	d0,d1					; is it higher than the new X position?
		bgt.s	CTTZ_BSP_NoUpdatePosition		; if so, branch

CTTZ_BSP_UpdatePosition:				; Offset: 00009994
		move.w  d0,$00(a1)				; save new X position

CTTZ_BSP_NoUpdatePosition:				; Offset: 00009998
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Unkown (Unused) routine
; ---------------------------------------------------------------------------

		moveq	#0,d0
		move.w	($FFFFC9EE).w,d0
		move.w	($FFFFC9F0).w,d1
		move.w	d0,d2
		sub.w	d1,d0
		beq.s	loc_99CC
		swap	d0
		move.l	d0,d1
		lsr.l	#1,d0
		add.l	d0,($FFFFFBC4).w
		move.l	d1,d0
		lsr.l	#2,d0
		add.l	d0,($FFFFFBC8).w
		move.l	d1,d0
		lsr.l	#3,d0
		add.l	d0,($FFFFFBCC).w
		move.l	d1,d0
		lsr.l	#4,d0
		add.l	d0,($FFFFFBD0).w

loc_99CC:						; Offset: 000099CC
		lea	($FFFFCDDE).w,a2
		move.w  0(a1),d1
		addi.w	#$F,d1
		lsr.w	#2,d1
		andi.w	#$FFFC,d1
		lea	dword_99F0(pc,d1.w),a3
		moveq	#$13,d7

loc_99E4:						; Offset: 000099E4
		move.w	d2,(a2)+
		movea.l	(a3)+,a4
		move.w	(a4),(a2)+
		dbf	d7,loc_99E4
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; List of what appears to be ram addresses
; ---------------------------------------------------------------------------
dword_99F0:	dc.l	$FFFFFBC4,$FFFFFBC4,$FFFFFBC4,$FFFFFBC4
		dc.l	$FFFFFBC4,$FFFFFBC4,$FFFFFBC4,$FFFFFBC4
		dc.l	$FFFFFBC8,$FFFFFBC8,$FFFFFBC8,$FFFFFBC8
		dc.l	$FFFFFBCC,$FFFFFBCC,$FFFFFBD0,$FFFFFBD0
		dc.l	$FFFFFBD8,$FFFFFBD8,$FFFFFBD8,$FFFFFBD8
		dc.l	$FFFFFBD8,$FFFFFBD8,$FFFFFBD8,$FFFFFBD8
		dc.l	$FFFFFBD0,$FFFFFBD0,$FFFFFBCC,$FFFFFBCC
		dc.l	$FFFFFBC8,$FFFFFBC8,$FFFFFBC8,$FFFFFBC8
		dc.l	$FFFFFBC4,$FFFFFBC4,$FFFFFBC4,$FFFFFBC4
		dc.l	$FFFFFBC4,$FFFFFBC4,$FFFFFBC4,$FFFFFBC4
		dc.l	$FFFFFBC4,$FFFFFBC4,$FFFFFBC4,$FFFFFBC4
		dc.l	$FFFFFBC4,$FFFFFBC4,$FFFFFBC4,$FFFFFBC4
		dc.l	$FFFFFBC4,$FFFFFBC4,$FFFFFBC4,$FFFFFBC4
		dc.l	$FFFFFBC4,$FFFFFBC4,$FFFFFBC4,$FFFFFBC4
		dc.l	$FFFFFBC4,$FFFFFBC4,$FFFFFBC4,$FFFFFBC4
		dc.l	$FFFFFBC4,$FFFFFBC4,$FFFFFBC4,$FFFFFBC4
		dc.l	$FFFFFBC8,$FFFFFBC8,$FFFFFBC8,$FFFFFBC8
		dc.l	$FFFFFBCC,$FFFFFBCC,$FFFFFBD0,$FFFFFBD0
		dc.l	$FFFFFBD8,$FFFFFBD8,$FFFFFBD8,$FFFFFBD8
		dc.l	$FFFFFBD8,$FFFFFBD8,$FFFFFBD8,$FFFFFBD8
		dc.l	$FFFFFBD0,$FFFFFBD0,$FFFFFBCC,$FFFFFBCC
		dc.l	$FFFFFBC8,$FFFFFBC8,$FFFFFBC8,$FFFFFBC8
		dc.l	$FFFFFBC4,$FFFFFBC4,$FFFFFBC4,$FFFFFBC4
		dc.l	$FFFFFBC4,$FFFFFBC4,$FFFFFBC4,$FFFFFBC4
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Unkown (Unused) routine
; ---------------------------------------------------------------------------

		cmpi.w	#$D60,($FFFFC9EE).w
		bcc.s	loc_9B80
		move.w	#$10C,($FFFFC9FC).w
		bra.s	locret_9BDE

loc_9B80:						; Offset: 00009B80
		move.w	#$114,($FFFFC9FC).w
		lea	($FFFFCA5E).w,a3
		move.w	($FFFFC9DE).w,d3
		neg.w	d3
		move.w	($FFFFCA1E).w,d4
		neg.w	d4
		moveq	#$1B,d7
		move.w	($FFFFCA1C).w,d2
		addq.w	#1,d2
		move.w	d2,($FFFFCA1C).w

loc_9BA2:						; Offset: 00009BA2
		moveq	#6,d6

loc_9BA4:						; Offset: 00009BA4
		addq.w	#1,d2
		jsr	CalcSine
		andi.w	#3,d0
		add.w	d3,d0
		move.w	d0,(a3)+
		move.w	d4,(a3)+
		dbf	d6,loc_9BA4
		addq.w	#4,d2
		jsr	CalcSine
		andi.w	#4,d0
		add.w	d3,d0
		move.w	d0,(a3)+
		move.w	d4,(a3)+
		dbf	d7,loc_9BA2
		move.l	#$FFFFCA5E,d0
		move.w	($FFFFD81C).w,d1
		move.w	#$1C0,d2
		jsr	DMA_WriteCueEntry

locret_9BDE:						; Offset: 00009BDE
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 01: TTZ (Techno Tower Zone) (Act 02)
; ---------------------------------------------------------------------------

TTZ_Act02:						; Offset: 00009BE0
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 01: TTZ (Techno Tower Zone) (Act 03)
; ---------------------------------------------------------------------------

TTZ_Act03:						; Offset: 00009BE2
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 01: TTZ (Techno Tower Zone) (Act 04)
; ---------------------------------------------------------------------------

TTZ_Act04:						; Offset: 00009BE4
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 01: TTZ (Techno Tower Zone) (Act 05)
; ---------------------------------------------------------------------------

TTZ_Act05:						; Offset: 00009BE6
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 02: U2Z (Unkown 2nd Zone) (Act 01)
; ---------------------------------------------------------------------------

U2Z_Act01:						; Offset: 00009BE8
		move.w	($FFFFD82C).w,d0			; load level event counter
		jmp	UZ01_Events(pc,d0.w)			; jump to correct event routine
		
UZ01_Events:
		bra.w	UZ01_StartUp				; 00
		bra.w	UZ01_StartLevel			; 04
		bra.w	UZ01_RunLevel				; 08
		
UZ01_StartUp:
		move	#$2700,sr				; set the status register (disable interrupts)
		lea	(ArtnemIIZ_TitleCard).l,a0			; load compress "Horizontal Spikes" art address
		move.l	#$42200000,($C00004).l			; set VDP V-Ram address and modes
		jsr	NemDec					; decompress and dump
		lea	($FFFFC9DE).w,a1			; load address of positions and sizes ram (FG)
		lea	UZ01_FG_StartLocCam(pc),a0		; load level FG setup data address to a0
		lea	($FFFFD816).w,a2			; load address of V-Ram plane A storage
		bsr.w	LoadLevelPositionAndSize		; save the positions and sizes of the level
		movea.l	a1,a0					; copy address of positions and sizes ram to a0
		lea	UZ01_ArtLocs(pc),a2			; load address of level compressed art locations
		bsr.w	DMA_NemLevelArtLoad			; decompress and DMA transfer art
		lea	($FFFFC9DE).w,a0			; load address of positions and sizes ram
		move.l	#$00FF0D08,$28(a0)			; set ram address to decompress the map data to
		lea	UZ01_MapFGLocs(pc),a2			; load level map/collision data address to a2
		bsr.w	EniLevelMapLoad				; decompress and dump mappings
		move.l	a1,($FFFFCA46).w			; ??? stores the end address of the FG layout, but for what reason?
		bsr.w	LoadCollisionPaths			; load collision data
		lea	TTZ_BG_StartLocCam(pc),a0		; load level BG setup data address to a0
		lea	($FFFFCA1E).w,a1			; load address of positions and sizes ram (BG)
		move.w	#$104,$1E(a1)
		lea	($FFFFD818).w,a2			; load address of V-Ram plane B storage
	;	bsr.w	LoadLevelPositionAndSize		; save the positions and sizes of the level
	;	movea.l	a1,a0					; copy address of positions and sizes ram to a0
	;	lea	TTZ_MapBGLocs(pc),a2			; load level map/collision data address to a2
	;	bsr.w	EniLevelMapLoad				; decompress and dump mappings
	;	move.l	a1,($FFFFFBC0).w			; ??? stores the end address of the BG layout, but for what reason?
	;	movea.l	a0,a1					; copy address of positions and sizes ram back to a0
	;	lea	($00FF0B84).l,a3			; load BG horizontal map plane buffer address
	;	lea	($00FF0C86).l,a4			; load BG vertical map plane buffer address
		bsr.w	DrawScreen_Full				; draw the entire screen/planes (For BG only)
		move	#$2300,sr				; set the status register (enable interrupts)
		addq.w	#$04,($FFFFD82C).w			; increase level event counter
		rts						; return

UZ01_StartLevel:					; Offset: 0000991E
		moveq	#$28,d0					; set number of columns to dump
		moveq	#$20,d1					; set number of rows to dump
		move.w	#$0040,d2				; set value/tile to dump
		move.w	($FFFFD818).w,d3			; set V-Ram location to dump to (V-Ram plane A)
		jsr	MapScreenSingle				; dump to plane map
		lea	PAL_IsolatedIsland(pc),a0	; load TTZ palette
		lea	($FFFFD424).w,a2			; load palette buffer address to a2
		bsr.w	LoadHalfPalette				; dump the palette to the buffer
		jsr	TitleCardSlide_Out			; slide title card out
		addq.w	#$04,($FFFFD82C).w			; increase level event counter

UZ01_RunLevel:						; Offset: 00009928
		movea.w	($FFFFD862).w,a0			; load Sonic's ram address to a0
		lea	($FFFFC9DE).w,a1			; load FG positions and sizes ram to a1
		lea	($00FF0A00).l,a3			; load FG horizontal map plane buffer address
		lea	($00FF0B02).l,a4			; load FG vertical map plane buffer address
		bsr.w	Control_ScreenPosX			; keep X position clean
		bsr.w	Control_ScreenPosY			; keep Y position clean
		bsr.w	DrawScreen_Void				; draw FG void sides
		movea.w	($FFFFD862).w,a0			; load Sonic's ram address to a0
		lea	($FFFFCA1E).w,a1			; load BG positions and sizes ram to a1
		lea	($00FF0B84).l,a3			; load BG horizontal map plane buffer address
		lea	($00FF0C86).l,a4			; load BG vertical map plane buffer address
	;	bsr.s	ControlTTZ_BGScreenPos			; control TTZ's BG screen position
	;	bsr.w	Control_ScreenPosY			; keep Y position clean
	;	jsr	DrawScreen_Void				; draw BG void sides
		rts						; return


UZ01_FG_StartLocCam:					; Offset: 00009CB0
		dc.w	$0015					; X starting location
		dc.w	$01E0					; Y starting location
		dc.b	$40					; Level Size - MDT
		dc.b	$20					; Level Size - MDT
		dc.b	$10
		dc.b	$20
		dc.w	($0800/$20)				; V-Ram address to write the level art to
		dc.w	$1EC0					; Maximum X display area
		dc.w	$0000
		dc.w	$2000					; Maximum Y display area
		dc.w	$0000

UZ01_ArtLocs:						; Offset: 00009CA8
		dc.l	ARTNEM_IIZ8x8_FG
		dc.l	ARTNEM_IIZ8x8_BG
		
UZ01_MapFGLocs:						; Offset: 00009CC2
		dc.l	MAPENI_IIZ16x16_FG
		dc.l	MAPENI_IIZ128x128_FG
		dc.l	MAPENI_IIZLayout_FG
		dc.l	COL_IIZPrimary
		dc.l	COL_IIZSecondary

PAL_IsolatedIsland:				; Offset: 00009CF0
		incbin  Palettes\PalIsolatedIsland.bin
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 02: U2Z (Unkown 2nd Zone) (Act 02)
; ---------------------------------------------------------------------------

U2Z_Act02:						; Offset: 00009BEA
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 02: U2Z (Unkown 2nd Zone) (Act 03)
; ---------------------------------------------------------------------------

U2Z_Act03:						; Offset: 00009BEC
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 02: U2Z (Unkown 2nd Zone) (Act 04)
; ---------------------------------------------------------------------------

U2Z_Act04:						; Offset: 00009BEE
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 02: U2Z (Unkown 2nd Zone) (Act 05)
; ---------------------------------------------------------------------------

U2Z_Act05:						; Offset: 00009BF0
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 03: U2Z (Unkown 2nd Zone) (Act 01)
; ---------------------------------------------------------------------------

U3Z_Act01:						; Offset: 00009BF2
		move.w	($FFFFD82C).w,d0			; load level event counter
		jmp	UZ02_Events(pc,d0.w)			; jump to correct event routine
		
UZ02_Events:
		bra.w	UZ02_StartUp				; 00
		bra.w	UZ02_StartLevel			; 04
		bra.w	UZ02_RunLevel				; 08
		
UZ02_StartUp:
		move	#$2700,sr				; set the status register (disable interrupts)
		lea	(ArtnemFLRA_TitleCard).l,a0			; load compress "Horizontal Spikes" art address
		move.l	#$42200000,($C00004).l			; set VDP V-Ram address and modes
		jsr	NemDec					; decompress and dump
		lea	($FFFFC9DE).w,a1			; load address of positions and sizes ram (FG)
		lea	UZ02_FG_StartLocCam(pc),a0		; load level FG setup data address to a0
		lea	($FFFFD816).w,a2			; load address of V-Ram plane A storage
		bsr.w	LoadLevelPositionAndSize		; save the positions and sizes of the level
		movea.l	a1,a0					; copy address of positions and sizes ram to a0
		lea	UZ02_ArtLocs(pc),a2			; load address of level compressed art locations
		bsr.w	DMA_NemLevelArtLoad			; decompress and DMA transfer art
		lea	($FFFFC9DE).w,a0			; load address of positions and sizes ram
		move.l	#$00FF0D08,$28(a0)			; set ram address to decompress the map data to
		lea	UZ02_MapFGLocs(pc),a2			; load level map/collision data address to a2
		bsr.w	EniLevelMapLoad				; decompress and dump mappings
		move.l	a1,($FFFFCA46).w			; ??? stores the end address of the FG layout, but for what reason?
		bsr.w	LoadCollisionPaths			; load collision data
		lea	TTZ_BG_StartLocCam(pc),a0		; load level BG setup data address to a0
		lea	($FFFFCA1E).w,a1			; load address of positions and sizes ram (BG)
		move.w	#$104,$1E(a1)
		lea	($FFFFD818).w,a2			; load address of V-Ram plane B storage
	;	bsr.w	LoadLevelPositionAndSize		; save the positions and sizes of the level
	;	movea.l	a1,a0					; copy address of positions and sizes ram to a0
	;	lea	TTZ_MapBGLocs(pc),a2			; load level map/collision data address to a2
	;	bsr.w	EniLevelMapLoad				; decompress and dump mappings
	;	move.l	a1,($FFFFFBC0).w			; ??? stores the end address of the BG layout, but for what reason?
	;	movea.l	a0,a1					; copy address of positions and sizes ram back to a0
	;	lea	($00FF0B84).l,a3			; load BG horizontal map plane buffer address
	;	lea	($00FF0C86).l,a4			; load BG vertical map plane buffer address
		bsr.w	DrawScreen_Full				; draw the entire screen/planes (For BG only)
		move	#$2300,sr				; set the status register (enable interrupts)
		addq.w	#$04,($FFFFD82C).w			; increase level event counter
		rts						; return

UZ02_StartLevel:					; Offset: 0000991E
		moveq	#$28,d0					; set number of columns to dump
		moveq	#$20,d1					; set number of rows to dump
		move.w	#$0040,d2				; set value/tile to dump
		move.w	($FFFFD818).w,d3			; set V-Ram location to dump to (V-Ram plane A)
		jsr	MapScreenSingle				; dump to plane map122222
		lea	PAL_Flora(pc),a0	; load TTZ palette
		lea	($FFFFD424).w,a2			; load palette buffer address to a2
		bsr.w	LoadHalfPalette				; dump the palette to the buffer
		jsr	TitleCardSlide_Out			; slide title card out
		addq.w	#$04,($FFFFD82C).w			; increase level event counter
		
UZ02_RunLevel:						; Offset: 00009928
		movea.w	($FFFFD862).w,a0			; load Sonic's ram address to a0
		lea	($FFFFC9DE).w,a1			; load FG positions and sizes ram to a1
		lea	($00FF0A00).l,a3			; load FG horizontal map plane buffer address
		lea	($00FF0B02).l,a4			; load FG vertical map plane buffer address
		bsr.w	Control_ScreenPosX			; keep X position clean
		bsr.w	Control_ScreenPosY			; keep Y position clean
		bsr.w	DrawScreen_Void				; draw FG void sides
		movea.w	($FFFFD862).w,a0			; load Sonic's ram address to a0
		lea	($FFFFCA1E).w,a1			; load BG positions and sizes ram to a1
		lea	($00FF0B84).l,a3			; load BG horizontal map plane buffer address
		lea	($00FF0C86).l,a4			; load BG vertical map plane buffer address
	;	bsr.s	ControlTTZ_BGScreenPos			; control TTZ's BG screen position
	;	bsr.w	Control_ScreenPosY			; keep Y position clean
	;	jsr	DrawScreen_Void				; draw BG void sides
		rts						; return
		
UZ02_FG_StartLocCam:					; Offset: 00009CB0
		dc.w	$0015					; X starting location
		dc.w	$01E0					; Y starting location
		dc.b	$40					; Level Size - MDT
		dc.b	$10					; Level Size - MDT
		dc.b	$10
		dc.b	$20
		dc.w	($0800/$20)				; V-Ram address to write the level art to
		dc.w	$1EC0					; Maximum X display area
		dc.w	$0000
		dc.w	$2000					; Maximum Y display area
		dc.w	$0000

UZ02_ArtLocs:						; Offset: 00009CA8
		dc.l	ARTNEM_FLRA8x8_FG
		dc.l	ARTNEM_IIZ8x8_BG
		
UZ02_MapFGLocs:						; Offset: 00009CC2
		dc.l	MAPENI_FLRA16x16_FG
		dc.l	MAPENI_FLRA128x128_FG
		dc.l	MAPENI_FLRALayout_FG
		dc.l	COL_FLRAPrimary
		dc.l	COL_FLRASecondary
		
PAL_Flora:				; Offset: 00009CF0
		incbin  Palettes\PalFlora.bin
		even
		
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 03: U2Z (Unkown 2nd Zone) (Act 02)
; ---------------------------------------------------------------------------

U3Z_Act02:						; Offset: 00009BF4
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 03: U2Z (Unkown 2nd Zone) (Act 03)
; ---------------------------------------------------------------------------

U3Z_Act03:						; Offset: 00009BF6
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 03: U2Z (Unkown 2nd Zone) (Act 04)
; ---------------------------------------------------------------------------

U3Z_Act04:						; Offset: 00009BF8
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 03: U2Z (Unkown 2nd Zone) (Act 05)
; ---------------------------------------------------------------------------

U3Z_Act05:						; Offset: 00009BFA
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 04: U2Z (Unkown 2nd Zone) (Act 01)
; ---------------------------------------------------------------------------

U4Z_Act01:						; Offset: 00009BFC
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 04: U2Z (Unkown 2nd Zone) (Act 02)
; ---------------------------------------------------------------------------

U4Z_Act02:						; Offset: 00009BFE
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 04: U2Z (Unkown 2nd Zone) (Act 03)
; ---------------------------------------------------------------------------

U4Z_Act03:						; Offset: 00009C00
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 04: U2Z (Unkown 2nd Zone) (Act 04)
; ---------------------------------------------------------------------------

U4Z_Act04:						; Offset: 00009C02
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 04: U2Z (Unkown 2nd Zone) (Act 05)
; ---------------------------------------------------------------------------

U4Z_Act05:						; Offset: 00009C04
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 05: U2Z (Unkown 2nd Zone) (Act 01)
; ---------------------------------------------------------------------------

U5Z_Act01:						; Offset: 00009C06
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 05: U2Z (Unkown 2nd Zone) (Act 02)
; ---------------------------------------------------------------------------

U5Z_Act02:						; Offset: 00009C08
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 05: U2Z (Unkown 2nd Zone) (Act 03)
; ---------------------------------------------------------------------------

U5Z_Act03:						; Offset: 00009C0A
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 05: U2Z (Unkown 2nd Zone) (Act 04)
; ---------------------------------------------------------------------------

U5Z_Act04:						; Offset: 00009C0C
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 05: U2Z (Unkown 2nd Zone) (Act 05)
; ---------------------------------------------------------------------------

U5Z_Act05:						; Offset: 00009C0E
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 06: U2Z (Unkown 2nd Zone) (Act 01)
; ---------------------------------------------------------------------------

U6Z_Act01:						; Offset: 00009C10
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 06: U2Z (Unkown 2nd Zone) (Act 02)
; ---------------------------------------------------------------------------

U6Z_Act02:						; Offset: 00009C12
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 06: U2Z (Unkown 2nd Zone) (Act 03)
; ---------------------------------------------------------------------------

U6Z_Act03:						; Offset: 00009C14
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 06: U2Z (Unkown 2nd Zone) (Act 04)
; ---------------------------------------------------------------------------

U6Z_Act04:						; Offset: 00009C16
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 06: U2Z (Unkown 2nd Zone) (Act 05)
; ---------------------------------------------------------------------------

U6Z_Act05:						; Offset: 00009C18
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 07: U2Z (Unkown 2nd Zone) (Act 01)
; ---------------------------------------------------------------------------

U7Z_Act01:						; Offset: 00009C1A
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 08: U2Z (Unkown 2nd Zone) (Act 01)
; ---------------------------------------------------------------------------

U8Z_Act01:						; Offset: 00009C1C
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Zone 09: U2Z (Unkown 2nd Zone) (Act 01)
; ---------------------------------------------------------------------------

U9Z_Act01:						; Offset: 00009C1E
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Art locations, starting locations and camera display area for SSZ.
; ---------------------------------------------------------------------------

SSZ_ArtLocs:						; Offset: 00009C20
		dc.l	ARTNEM_SSZ8x8_FG
		dc.l	ARTNEM_SSZ8x8_BG

; ---------------------------------------------------------------------------
; Foreground starting locations and display area of the camera for plane and
; characters.
; ---------------------------------------------------------------------------

SSZ_FG_StartLocCam:					; Offset: 00009C28
		dc.w	$0000					; X starting location
		dc.w	$00D0					; Y starting location
		dc.b	$80					; Y80 multiplier (see "LoadLevelPositionAndSize" for more information)
		dc.b	$10
		dc.b	$80
		dc.b	$0C
		dc.w	($0800/$20)				; V-Ram address to write the level art to
		dc.w	$7EC0					; Maximum X display area
		dc.w	$0000
		dc.w	$0520					; Maximum Y display area
		dc.w	$0000

; ---------------------------------------------------------------------------		
; Foreground maps and collision
; ---------------------------------------------------------------------------

SSZ_MapFGLocs:						; Offset: 00009C3A
		dc.l	MAPENI_SSZ16x16_FG
		dc.l	MAPENI_SSZ128x128_FG
		dc.l	MAPENI_SSZLayout_FG
		dc.l	COL_SSZPrimary

; ---------------------------------------------------------------------------		
; Background starting locations and display area of the camera.
; ---------------------------------------------------------------------------

SSZ_BG_StartLocCam:					; Offset: 00009C4A
		dc.w	$0000					; Starting X position of BG plane
		dc.w	$0054					; Starting Y position of BG plane
		dc.b	$04					; Y80 multiplier (see "LoadLevelPositionAndSize" for more information)
		dc.b	$08
		dc.b	$04
		dc.b	$06
		dc.w	($6660/$20)				; V-Ram address to write the level art to
		dc.w	$00C0					; Maximum X display area
		dc.w	$0000
		dc.w	$0220					; Maximum Y display area
		dc.w	$0000

; ---------------------------------------------------------------------------		
; Background maps
; ---------------------------------------------------------------------------

SSZ_MapBGLocs:						; Offset: 00009C5C
		dc.l	MAPENI_SSZ16x16_BG
		dc.l	MAPENI_SSZ128x128_BG
		dc.l	MAPENI_SSZLayout_BG

; ---------------------------------------------------------------------------		
; Palette
; ---------------------------------------------------------------------------

PAL_SpeedSliderZone:					; Offset: 00009C68
		incbin  Palettes\PalSpeedSliderZone.bin
		even

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Art locations, starting locations and camera display area for TTZ.
; ---------------------------------------------------------------------------

TTZ_ArtLocs:						; Offset: 00009CA8
		dc.l	ARTNEM_TTZ8x8_FG
		dc.l	ARTNEM_TTZ8x8_BG

; ---------------------------------------------------------------------------
; Starting locations and display area of the camera for plane and
; characters.
; ---------------------------------------------------------------------------

TTZ_FG_StartLocCam:					; Offset: 00009CB0
		dc.w	$0015					; X starting location
		dc.w	$0DE0					; Y starting location
		dc.b	$10					; Level Size - MDT
		dc.b	$20					; Level Size - MDT
		dc.b	$10
		dc.b	$20
		dc.w	($0800/$20)				; V-Ram address to write the level art to
		dc.w	$06C0					; Maximum X display area
		dc.w	$0000
		dc.w	$0F20					; Maximum Y display area
		dc.w	$0000

; ---------------------------------------------------------------------------
; Foreground maps and collision
; ---------------------------------------------------------------------------

TTZ_MapFGLocs:						; Offset: 00009CC2
		dc.l	MAPENI_TTZ16x16_FG
		dc.l	MAPENI_TTZ128x128_FG
		dc.l	MAPENI_TTZLayout_FG
		dc.l	COL_TTZPrimary
		dc.l	COL_TTZSecondary

; ---------------------------------------------------------------------------
; Starting locations and display area of the camera.
; ---------------------------------------------------------------------------

TTZ_BG_StartLocCam:					; Offset: 00009CD2
		dc.w	$0030					; X starting location
		dc.w	$0A60					; Y starting location
		dc.b	$10					; Y80 multiplier (see "LoadLevelPositionAndSize" for more information)
		dc.b	$20
		dc.b	$0C
		dc.b	$18
		dc.w	($2DE0/$20)				; V-Ram address to write the level art to
		dc.w	$04C0					; Maximum X display area
		dc.w	$0000
		dc.w	$0B20					; Maximum Y display area
		dc.w	$0000

; ---------------------------------------------------------------------------
; Background mappings
; ---------------------------------------------------------------------------

TTZ_MapBGLocs:						; Offset: 00009CE4
		dc.l	MAPENI_TTZ16x16_BG
		dc.l	MAPENI_TTZ128x128_BG
		dc.l	MAPENI_TTZLayout_BG

; ---------------------------------------------------------------------------
; Unused palette (This is the original palette, similar to Day 2's palette).
; ---------------------------------------------------------------------------

PAL_TechnoTowerZoneUnused:				; Offset: 00009CF0
		incbin  Palettes\PalTechnoTowerZoneUnused.bin
		even

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to decompress nemesis art (for level) to a ram space and DMA transfer it
; ---------------------------------------------------------------------------

DMA_NemLevelArtLoad:					; Offset: 00009D30
		move.l	a0,-(sp)				; store positions and sizes address
		movea.l	(a2)+,a0				; load FG compressed art address
		lea	($00FF0200).l,a4			; load ram space to dump to
		jsr	NemDec_Ram				; decompress and dump
		movea.l	(a2)+,a0				; load BG compressed art address
		jsr	NemDec_Ram				; decompress and dump
		movea.l	(sp)+,a0				; restore positions and sizes address
		move.l	#$00FF0200,d0				; set DMA source address (Ram space we just dumped the art to)
		moveq	#$00,d1					; clear d1
		move.w	$1C(a0),d1				; load 
		lsl.w	#$05,d1					; multiply by 20
		move.l	d0,d2					; copy source address to d2
		sub.l	a4,d2					; subtract end address to get size
		neg.w	d2					; negate to positive
		lsr.w	#1,d2					; divide by 2 (because of decrement mode for VDP)
		jsr	DMA_WriteData				; set DMA to transfer level art
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to decompress enigma mappings (for level) to a ram space
; ---------------------------------------------------------------------------

EniLevelMapLoad:					; Offset: 00009D26
		movea.l	$28(a0),a1				; load ram address to dump mappings
		move.w	$1C(a0),d0				; load V-Ram address the art was written to
		move.l	a0,-(sp)				; store positions and sizes ram to the stack
		movea.l	(a2)+,a0				; load compressed 16x16 mappings address
		move.l	a2,-(sp)				; store map address to the stack
		jsr	EniDec					; decompress 16x16 block mappings
		movea.l	(sp)+,a2				; restore map address
		movea.l	(sp)+,a0				; restore positions and sizes ram
		move.l	a1,$24(a0)				; save start address of chunks
		move.l	a0,-(sp)				; store positions and sizes ram to the stack
		movea.l	(a2)+,a0				; load compressed 128x128 mappings address
		moveq	#$0000,d0				; clear d0 (don't need to add art address)
		move.l	a2,-(sp)				; store map address to the stack
		jsr	EniDec					; decompress 128x128 chunk mappings
		movea.l	(sp)+,a2				; restore map address
		movea.l	(sp)+,a0				; restore positions and sizes ram
		move.l	a1,$20(a0)				; save start address of layout
		move.l	a0,-(sp)				; store positions and sizes ram to the stack
		movea.l	(a2)+,a0				; load compressed layout address
		moveq	#$0000,d0				; clear d0 (don't need to add art address)
		move.l	a2,-(sp)				; store map address to the stack
		jsr	EniDec					; decompress layout
		movea.l	(sp)+,a2				; restore map address
		movea.l	(sp)+,a0				; restore positions and sizes ram
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load collision path data (for level)
; ---------------------------------------------------------------------------

LoadCollisionPaths:					; Offset: 00009DA2
		movea.l	(a2)+,a1				; load address of collision data
		lea	($00FF0200).l,a2			; load collision path 1 ram address
		moveq	#$7F,d0					; set repeat times (200 blocks)

LCP_DumpPath1:						; Offset: 00009DAC
		move.l	(a1)+,(a2)+				; dump 2 blocks
		move.l	(a1)+,(a2)+				; ''
		dbf	d0,LCP_DumpPath1			; repeat til 200 blocks have been dumped
		lea	($00FF0600).l,a2			; load collision path 2 ram address
		moveq	#$7F,d0					; set repeat times (200 blocks)

LCP_DumpPath2:						; Offset: 00009DBC
		move.l	(a1)+,(a2)+				; dump 2 blocks
		move.l	(a1)+,(a2)+				; ''
		dbf	d0,LCP_DumpPath2			; repeat til 200 blocks have been dumped
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw the entire map planes (the whole screen)
; ---------------------------------------------------------------------------
; Draw in "Full"
; ---------------------------------------------------------------------------

DrawScreen_Full:					; Offset: 00009DC6
		move.w	$10(a1),d0				; store screen's Y position
		movea.l	a1,a5					; copy level ram data to a5
		moveq	#$0F,d7					; set repeat times (number of 16x16 blocks on the Y screen size)

DSF_NextLine:						; Offset: 00009DCE
		movem.l	d0-a6,-(sp)				; store registers to the stack
		movea.l	a3,a0					; store map plane buffer address
		move.w  $00(a1),d0				; load screen's X position
		move.w	$10(a1),d1				; load screen's Y position
		move.w	$18(a1),d4				; load load V-Ram address where art is written to
		jsr	DrawBlocksHorizontally			; draw blocks to the horizontal buffer
		movea.l	a0,a3					; reload map plane buffer address
		jsr	DumpMapPlaneBuffers			; dump the horizontal buffer to V-Ram map plane
		movem.l	(sp)+,d0-a6				; reload registers from the stack
		addi.w	#$0010,$10(a1)				; increase down to next block line
		dbf	d7,DSF_NextLine				; repeat until all horizontal block lines on screen have been drawn
		move.w	d0,$10(a1)				; restore Y position to normal
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw the map plane lines (vertical and horizontal out the screen
; as it moves).  Draw in the "void" space out the screen.
; ---------------------------------------------------------------------------
; For vertical (left/right)
; ---------------------------------------------------------------------------

DrawScreen_Void:					; Offset: 00009DFE
		move.l	a3,-(sp)				; store horizontal map plane buffer address
		move.w  $00(a1),d0				; load X position
		move.w	$02(a1),d1				; load last frame's X position
		eor.w	d1,d0					; not the selected bits
		andi.w	#$FFF0,d0				; keep in multiples of 10
		beq.s	DSV_SkipVerticals			; if the screen has not moved 10 pixels, branch to skip drawing
		cmp.w	$00(a1),d1				; check position
		blt.s	DSV_DrawRight				; if it's lower than, we're moving right
		move.w  $00(a1),d0				; load X position
		move.w	$10(a1),d1				; load Y position
		movea.l	a4,a3					; load vertical map buffer address to a3
		jsr	DrawBlocksVertically			; draw the vertical blocks to the left side
		bra.s	DSV_SkipVerticals			; continue

DSV_DrawRight:						; Offset: 00009E26
		move.w	$02(a1),d0				; load last frame's X position
		addi.w	#$0200,d0				; add 200 (to draw right)
		move.w	$10(a1),d1				; load Y position
		movea.l	a4,a3					; load vertical map buffer address to a3
		jsr	DrawBlocksVertically			; draw the vertical blocks to the right side

; ---------------------------------------------------------------------------
; For horizontal (top/bottom)
; ---------------------------------------------------------------------------

DSV_SkipVerticals:					; Offset: 00009E38
		movea.l	(sp)+,a3				; reload horizontal store map plane buffer address
		move.w	$10(a1),d0				; load Y position
		move.w	$12(a1),d1				; load last frame's Y position
		eor.w	d1,d0					; not the selected bits
		andi.w	#$FFF0,d0				; keep in multiples of 10
		beq.s	DSV_SkipHorizontals			; if the screen has not moved 10 pixels, branch to skip drawing
		cmp.w	$10(a1),d1				; check position
		blt.s	DSV_DrawDown				; if it's lower than, we're moving down
		move.w  $00(a1),d0				; load X position
		move.w	$10(a1),d1				; load Y position
		jmp	DrawBlocksHorizontally			; draw the horizontal blocks to the above (top)

DSV_DrawDown:						; Offset: 00009E5C
		move.w  $00(a1),d0				; load X position
		move.w	$12(a1),d1				; load last frame's Y position
		addi.w	#$0100,d1				; add 100 (to draw bottom)
		jmp	DrawBlocksHorizontally			; draw the horizontal blocks to the below (bottom)

DSV_SkipHorizontals:					; Offset: 00009E6C
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to transfer half a palette from address of a0 to address of a2
; ---------------------------------------------------------------------------

LoadHalfPalette:					; Offset: 00009E6E
		movem.l	(a0)+,d0-d7				; load first 10 colours to registers d0 to d7
		movem.l	d0-d7,(a2)				; ...and save to temp palette buffer
		adda.w	#$0020,a2				; advance 10 colours in buffer
		movem.l	(a0)+,d0-d7				; load next 10 colours to registers d0 to d7
		movem.l	d0-d7,(a2)				; ...and save to temp palette buffer
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load the position, sizes, etc to their respected ram spaces
; ---------------------------------------------------------------------------

LoadLevelPositionAndSize:				; Offset: 00009E84
		moveq	#$00,d0					; clear d0
		move.w	(a2),d0					; load V-Ram address of map plane
		lsl.l	#$02,d0					; send far left bits to left side
		lsr.w	#$02,d0					; and send the rest back
		ori.w	#$4000,d0				; set V-Ram write mode (Map location)
		swap	d0					; swap sides
		andi.w	#$0003,d0				; clear all except the V-Ram location bits
		move.l	d0,$18(a1)
		move.w	(a0)+,d1				; load starting X position
		move.w  d1,$00(a1)				; save to screen's X FG position
		move.w	d1,$02(a1)				; save to screen's last frame X FG position
		move.w	(a0)+,d1				; load starting Y position
		move.w	d1,$10(a1)				; save to screen's Y FG position
		move.w	d1,$12(a1)				; save to screen's last frame Y FG position
		move.b	(a0)+,$04(a1)
		move.b	(a0)+,$14(a1)
		move.b	(a0)+,$05(a1)
		move.b	(a0)+,$15(a1)
		move.w	(a0)+,$1C(a1)
		move.w	(a0)+,$08(a1)				; load X start position
		move.w	(a0)+,$0A(a1)
		move.w	(a0)+,$0C(a1)				; load Y start position
		move.w	(a0)+,$0E(a1)

; ---------------------------------------------------------------------------
; This routine converts the value in $04(a-) and $14(a-) into Y80 values.
;
; If the value was 80+, the value will save as 07 (x80)
; If the value was 40+, the value will save as 06 (x40)
; If the value was 20+, the value will save as 05 (x20)
; If the value was 10+, the value will save as 04 (x10)
; If the value was 08+, the value will save as 03 (x08)
; If the value was 04+, the value will save as 02 (x04)
; If the value was 02+, the value will save as 01 (x02)
; If the value was 01+, the value will save as 00 (x01)
;
; This value is used to multiply a position value...
;
; Y Pos / 80 = Y Chunk Pos << (shift left) Y80
;
; ...in order to find the correct layout chunk to read for drawing blocks/tiles
; ---------------------------------------------------------------------------

		moveq	#$00,d0					; clear d0
		move.b	$04(a1),d0
		moveq	#$0F,d2					; set repeat times

loc_9EDA:						; Offset: 00009EDA
		add.w	d0,d0					; multiply by 2
		dbcs	d2,loc_9EDA				; repeat until it "was" negative before multiplying by 2 (or counter is finished)
		move.b	d2,$06(a1)				; save as Y80 multiplier
		moveq	#$00,d0					; clear d0
		move.b	$14(a1),d0
		moveq	#$0F,d2					; set repeat times

loc_9EEC:						; Offset: 00009EEC
		add.w	d0,d0					; multiply by 2
		dbcs	d2,loc_9EEC				; repeat until it "was" negative before multiplying by 2 (or counter is finished)
		move.b	d2,$16(a1)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control the screen's X position to make sure it doesn't move
; more than 10 pixels for the level draw code
; ---------------------------------------------------------------------------

Control_ScreenPosX:					; Offset: 00009EF8
		move.w  $00(a1),d0				; load X position
		move.w	d0,$02(a1)				; save as last frame's X position
		move.w	($FFFFD830).w,d1			; load screen's new X position
		sub.w	d0,d1					; subtract X pos from new X pos
		blt.s	CSP_X_LeftCheck				; if it's negative, branch
		cmpi.w	#$0010,d1				; is it further than 10 pixels right?
		ble.s	CSP_X_CheckOther			; if not, branch
		move.w	#$0010,d1				; set 10 pixels right max
		bra.s	CSP_X_CheckOther			; continue

CSP_X_LeftCheck:					; Offset: 00009F14
		cmpi.w	#$FFF0,d1				; is it further than 10 pixels left?
		bgt.s	CSP_X_CheckOther			; if not, branch
		move.w	#$FFF0,d1				; set 10 pixels left max

CSP_X_CheckOther:					; Offset: 00009F1E
		add.w	d1,d0					; add to X position
		move.w  d0,$00(a1)				; save new X position
		move.w	$08(a1),d1				; load X start position
		cmp.w	d1,d0					; is it higher than the new X position?
		bgt.s	CSP_X_UpdatePosition			; if so, branch
		move.w	$0A(a1),d1
		cmp.w	d1,d0					; is it higher than the new X position?
		bgt.s	CSP_X_NoUpdatePosition			; if so, branch

CSP_X_UpdatePosition:					; Offset: 00009F34
		move.w  d1,$00(a1)				; save new X position

CSP_X_NoUpdatePosition:					; Offset: 00009F38
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control the screen's Y position to make sure it doesn't move
; more than 10 pixels for the level draw code
; ---------------------------------------------------------------------------

Control_ScreenPosY:					; Offset: 00009F3A
		move.w	$10(a1),d0				; load Y position
		move.w	d0,$12(a1)				; save as last frame's Y position
		move.w	($FFFFD832).w,d1			; load screen's new Y position
		sub.w	d0,d1					; subtract Y pos from new Y pos
		blt.s	CSP_Y_UpCheck				; if it's negative, branch
		cmpi.w	#$0010,d1				; is it further than 10 pixels down?
		ble.s	CSP_Y_CheckOther			; if not, branch
		move.w	#$0010,d1				; set 10 pixels down max
		bra.s	CSP_Y_CheckOther			; continue

CSP_Y_UpCheck:						; Offset: 00009F56
		cmpi.w	#$FFF0,d1				; is it further than 10 pixels up?
		bgt.s	CSP_Y_CheckOther			; if not, branch
		move.w	#$FFF0,d1				; set 10 pixels up max

CSP_Y_CheckOther:					; Offset: 00009F60
		add.w	d1,d0					; add to Y position
		move.w	d0,$10(a1)				; save new Y position
		move.w	$0C(a1),d1				; load Y start position
		cmp.w	d1,d0					; is it higher than the new Y position?
		bgt.s	CSP_Y_UpdatePosition			; if so, branch
		move.w	$0E(a1),d1
		cmp.w	d1,d0					; is it higher than the new Y position?
		bgt.s	CSP_Y_NoUpdatePosition			; if so, branch

CSP_Y_UpdatePosition:					; Offset: 00009F76
		move.w	d1,$10(a1)				; save new Y position

CSP_Y_NoUpdatePosition:					; Offset: 00009F7A
		rts						; return

; ===========================================================================

; =============== S U B	R O U T	I N E =======================================


sub_9F7C:				; CODE XREF: ROM:00008B20p
		bsr.w	sub_9F82
		rts
; End of function sub_9F7C


; =============== S U B	R O U T	I N E =======================================


sub_9F82:				; CODE XREF: sub_9F7Cp
		lea	($FFFFC9DE).w,a1
		moveq	#0,d0
		move.b	$1F(a1),d0
		jmp	loc_9F90(pc,d0.w)
; End of function sub_9F82

; ---------------------------------------------------------------------------

loc_9F90:
		bra.w	loc_9FAC
; ---------------------------------------------------------------------------
		bra.w	loc_9FFA
; ---------------------------------------------------------------------------
		bra.w	loc_A062
; ---------------------------------------------------------------------------
		bra.w	loc_A098
; ---------------------------------------------------------------------------
		bra.w	locret_A132
; ---------------------------------------------------------------------------
		bra.w	loc_A0FE
; ---------------------------------------------------------------------------
		bra.w	locret_A134
; ---------------------------------------------------------------------------

loc_9FAC:				; CODE XREF: ROM:loc_9F90j
		move.b	$1E(a1),d0
		beq.s	locret_9FF8
		move.w	#$8B00,($C00004).l
		move.w	#$8B00,($FFFFC9CE).w
		moveq	#0,d0
		move.l	#$40000010,($C00004).l
		move.l	d0,($C00000).l
		moveq	#0,d1
		move.w	($FFFFD81C).w,d1
		lsl.l	#2,d1
		lsr.w	#2,d1
		ori.w	#$4000,d1
		swap	d1
		andi.w	#3,d1
		move.l	d1,($C00004).l
		move.l	d0,($C00000).l
		move.b	#0,$1E(a1)

locret_9FF8:				; CODE XREF: ROM:00009FB0j
		rts
; ---------------------------------------------------------------------------

loc_9FFA:				; CODE XREF: ROM:00009F94j
		move.b	$1E(a1),d0
		beq.s	loc_A014
		move.w	#$8B00,($C00004).l
		move.w	#$8B00,($FFFFC9CE).w
		move.b	#0,$1E(a1)

loc_A014:				; CODE XREF: ROM:00009FFEj
		move.l	#$40000010,($C00004).l
		move.w	$10(a1),($C00000).l
		move.w	($FFFFCA2E).w,($C00000).l
		moveq	#0,d0
		move.w	($FFFFD81C).w,d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0
		andi.w	#3,d0
		move.l	d0,($C00004).l
		move.w  0(a1),d0
		neg.w	d0
		move.w	d0,($C00000).l
		move.w	($FFFFCA1E).w,d1
		neg.w	d1
		move.w	d1,($C00000).l
		rts
; ---------------------------------------------------------------------------

loc_A062:				; CODE XREF: ROM:00009F98j
		move.b	$1E(a1),d0
		beq.s	loc_A07C
		move.w	#$8B03,($C00004).l
		move.w	#$8B03,($FFFFC9CE).w
		move.b	#0,$1E(a1)

loc_A07C:				; CODE XREF: ROM:0000A066j
		move.l	#$40000010,($C00004).l
		move.w	$10(a1),($C00000).l
		move.w	($FFFFCA2E).w,($C00000).l
		rts
; ---------------------------------------------------------------------------

loc_A098:				; CODE XREF: ROM:00009F9Cj
		move.b	$1E(a1),d0
		beq.s	loc_A0B2
		move.w	#$8B04,($C00004).l
		move.w	#$8B04,($FFFFC9CE).w
		move.b	#0,$1E(a1)

loc_A0B2:				; CODE XREF: ROM:0000A09Cj
		lea	($FFFFCDDE).w,a3
		lea	($C00000).l,a4
		move.l	#$40000010,($C00004).l
		bsr.w	sub_A14E
		moveq	#0,d0
		move.w	($FFFFD81C).w,d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0
		andi.w	#3,d0
		move.l	d0,($C00004).l
		move.w  0(a1),d0
		neg.w	d0
		move.w	d0,($C00000).l
		move.w	($FFFFCA1E).w,d1
		neg.w	d1
		move.w	d1,($C00000).l
		rts
; ---------------------------------------------------------------------------

loc_A0FE:				; CODE XREF: ROM:00009FA4j
		move.b	$1E(a1),d0
		beq.s	loc_A118
		move.w	#$8B07,($C00004).l
		move.w	#$8B07,($FFFFC9CE).w
		move.b	#0,$1E(a1)

loc_A118:				; CODE XREF: ROM:0000A102j
		lea	($FFFFCDDE).w,a3
		lea	($C00000).l,a4
		move.l	#$40000010,($C00004).l
		bsr.w	sub_A14E
		rts
; ---------------------------------------------------------------------------

locret_A132:				; CODE XREF: ROM:00009FA0j
		rts
; ---------------------------------------------------------------------------

locret_A134:				; CODE XREF: ROM:00009FA8j
		rts
; ---------------------------------------------------------------------------
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)

; =============== S U B	R O U T	I N E =======================================


sub_A14E:				; CODE XREF: ROM:0000A0C6p
					; ROM:0000A12Cp
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		move.l	(a3)+,(a4)
		rts
; End of function sub_A14E


; =============== S U B	R O U T	I N E =======================================

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control the players/characters
; ---------------------------------------------------------------------------

Control_Players:					; Offset: 0000A178
		lea	($FFFFD850).w,a6

loc_A17C:
		move.w  0(a6),d0
		bne.s	loc_A184
		rts
; ---------------------------------------------------------------------------

loc_A184:				; CODE XREF: Control_Players+8j
		movea.w	d0,a6
		moveq	#0,d0
		move.b	6(a6),d0
		jsr	loc_A192(pc,d0.w)
		bra.s	loc_A17C
; End of function Control_Players

; ---------------------------------------------------------------------------
; this is related to the controls of Sonic/Tails

loc_A192:
		bra.w	loc_A1AA	; sonic controls
; ---------------------------------------------------------------------------
		bra.w	loc_A1BC	; tails controls
; ---------------------------------------------------------------------------
		bra.w	loc_A1F2	; seems to effect the positioning of sonic's arm
; ---------------------------------------------------------------------------
		bra.w	loc_A1FC	; something to do with when tails is still and sonic is running at full speed
; ---------------------------------------------------------------------------
		bra.w	loc_A22A	; (I think) sonic's loading parts
; ---------------------------------------------------------------------------
		bra.w	loc_A234	; tails' loading parts (his two tails etc)
; ---------------------------------------------------------------------------

loc_A1AA:				; CODE XREF: ROM:loc_A192j
		move.w	($FFFFD866).w,d0
		movea.l	off_A1CE(pc,d0.w),a0
		lea	($FFFFD89C).w,a5
		movea.w	($FFFFD864).w,a4
		jmp	(a0)
; ---------------------------------------------------------------------------

loc_A1BC:				; CODE XREF: ROM:0000A196j
		move.w	($FFFFD868).w,d0
		movea.l	off_A1CE(pc,d0.w),a0
		lea	($FFFFD8AC).w,a5
		movea.w	($FFFFD862).w,a4
		jmp	(a0)
; ---------------------------------------------------------------------------
off_A1CE:	dc.l	SonicMain			; something to do with stopping reflexes
		dc.l	TailsMain
		dc.l	TailsMain
		dc.l	locret_B416
		dc.l	locret_B418
		dc.l	locret_B41A
		dc.l	locret_B41C
		dc.l	locret_B41E
		dc.l	locret_B420
; ---------------------------------------------------------------------------

loc_A1F2:				; CODE XREF: ROM:0000A19Aj
		move.w	($FFFFD866).w,d0
		movea.l	off_A206(pc,d0.w),a0
		jmp	(a0)
; ---------------------------------------------------------------------------

loc_A1FC:				; CODE XREF: ROM:0000A19Ej
		move.w	($FFFFD868).w,d0
		movea.l	off_A206(pc,d0.w),a0
		jmp	(a0)
; ---------------------------------------------------------------------------
off_A206:	dc.l	loc_B422
		dc.l	loc_B81A
		dc.l	loc_A262
		dc.l	loc_A262
		dc.l	loc_A262
		dc.l	loc_A262
		dc.l	loc_A262
		dc.l	loc_A262
		dc.l	loc_A262
; ---------------------------------------------------------------------------

loc_A22A:				; CODE XREF: ROM:0000A1A2j
		move.w	($FFFFD866).w,d0
		movea.l	off_A23E(pc,d0.w),a0
		jmp	(a0)
; ---------------------------------------------------------------------------

loc_A234:				; CODE XREF: ROM:0000A1A6j
		move.w	($FFFFD868).w,d0
		movea.l	off_A23E(pc,d0.w),a0
		jmp	(a0)
; ---------------------------------------------------------------------------
off_A23E:	dc.l	loc_A262
		dc.l	loc_BC30
		dc.l	loc_A262
		dc.l	loc_A262
		dc.l	loc_A262
		dc.l	loc_A262
		dc.l	loc_A262
		dc.l	loc_A262
		dc.l	loc_A262
; ---------------------------------------------------------------------------

loc_A262:				; DATA XREF: ROM:0000A20Eo
					; ROM:0000A212o ...
		andi.w	#$FF7F,4(a6)
		rts
; ---------------------------------------------------------------------------

	include		"Objects/Sonic.asm"
	include		"Objects/Tails.asm"

locret_B414:				; DATA XREF: ROM:0000A1D6o
		rts
; ---------------------------------------------------------------------------

locret_B416:				; DATA XREF: ROM:0000A1DAo
		rts
; ---------------------------------------------------------------------------

locret_B418:				; DATA XREF: ROM:0000A1DEo
		rts
; ---------------------------------------------------------------------------

locret_B41A:				; DATA XREF: ROM:0000A1E2o
		rts
; ---------------------------------------------------------------------------

locret_B41C:				; DATA XREF: ROM:0000A1E6o
		rts
; ---------------------------------------------------------------------------

locret_B41E:				; DATA XREF: ROM:0000A1EAo
		rts
; ---------------------------------------------------------------------------

locret_B420:				; DATA XREF: ROM:0000A1EEo
		rts
; ---------------------------------------------------------------------------

loc_B422:				; DATA XREF: ROM:off_A206o
		movea.w	$24(a6),a5
		tst.b	5(a5)
		bmi.s	loc_B436
		andi.w	#$FF7F,4(a6)
		bra.w	loc_B7D2
; ---------------------------------------------------------------------------

loc_B436:				; CODE XREF: ROM:0000B42Aj
		pea	(loc_B7D2).l
		move.w	$26(a5),d7
		move.w	word_B448(pc,d7.w),d7
		jmp	word_B448(pc,d7.w)
; ---------------------------------------------------------------------------
word_B448:	dc.w	$34
		dc.w	$CA
		dc.w	$100
		dc.w	$138
		dc.w	$170
		dc.w	$1A8
		dc.w	$1C8
		dc.w	$1EA
		dc.w	$20A
		dc.w	$22C
		dc.w	$234
		dc.w	$25A
		dc.w	$284
		dc.w	$2AE
		dc.w	$2B6
		dc.w	$2CC
		dc.w	$2EC
		dc.w	$30E
		dc.w	$32E
		dc.w	$2CC
		dc.w	$2EC
		dc.w	$30E
		dc.w	$32E
		dc.w	$350
		dc.w	$358
		dc.w	$360
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		cmpi.b	#2,$28(a5)
		bne.s	loc_B492
		andi.w	#$FF7F,4(a6)
		rts
; ---------------------------------------------------------------------------

loc_B492:				; CODE XREF: ROM:0000B488j
		moveq	#$FFFFFFF5,d0
		moveq	#$FFFFFFFA,d1
		bsr.w	sub_CA82
		move.w	#$14,$26(a6)
		rts
; ---------------------------------------------------------------------------

loc_B4A2:				; CODE XREF: ROM:0000B516j
					; ROM:0000B5BCj
		tst.w	$2E(a5)
		beq.s	sub_B4EC
		ori.w	#$80,4(a6) ; '€'
		move.b	$2B(a5),d0
		addq.b	#8,d0
		lsr.w	#3,d0
		andi.w	#$1E,d0
		move.w	word_B4CC(pc,d0.w),$26(a6)
		clr.b	$20(a6)
		moveq	#0,d0
		moveq	#$FFFFFFFE,d1
		bra.w	loc_CA8A
; ---------------------------------------------------------------------------
word_B4CC:	dc.w	$9C
		dc.w	$98
		dc.w	$94
		dc.w	$90
		dc.w	$8C
		dc.w	$88
		dc.w	$84
		dc.w	$80
		dc.w	$7C
		dc.w	$B8
		dc.w	$B4
		dc.w	$B0
		dc.w	$AC
		dc.w	$A8
		dc.w	$A4
		dc.w	$A0

; =============== S U B	R O U T	I N E =======================================


sub_B4EC:				; CODE XREF: ROM:0000B4A6j
					; ROM:0000B6D0p
		ori.w	#$80,4(a6) ; '€'
		moveq	#0,d4
		move.b	$28(a5),d4
		add.w	d4,d4
		add.w	d4,d4
		add.w	d4,d4
		move.w	(a0,d4.w),$26(a6)
		move.w	2(a0,d4.w),d0
		move.w	4(a0,d4.w),d1
		bsr.w	sub_CA82
		rts
; End of function sub_B4EC

; ---------------------------------------------------------------------------
		lea	loc_B518(pc),a0
		bra.s	loc_B4A2
; ---------------------------------------------------------------------------
loc_B518:	dc.w	$14		; DATA XREF: ROM:0000B512o
		dc.w	$FFF3
		dc.w	$FFFA
		dc.w	0
		dc.w	$18
		dc.w	$FFE6
		dc.w	$FFFE
		dc.w	0
		dc.w	$1C
		dc.w	$FFF4
		dc.w	$FFFA
		dc.w	0
		dc.w	$20
		dc.w	$FFF6
		dc.w	$FFF9
		dc.w	0
		dc.w	$C
		dc.w	$FFFC
		dc.w	$FFF5
		dc.w	0
		dc.w	$10
		dc.w	$FFFB
		dc.w	0
		dc.w	0
		dc.w	$41FA
		dc.w	6
		dc.w	$6000
		dc.w	$FF54
		dc.w	$2C
		dc.w	1
		dc.w	0
		dc.w	0
		dc.w	$30
		dc.w	$FFF5
		dc.w	$FFFF
		dc.w	0
		dc.w	$34
		dc.w	$FFFF
		dc.w	$FFF6
		dc.w	0
		dc.w	$38
		dc.w	2
		dc.w	$FFF5
		dc.w	0
		dc.w	$24
		dc.w	6
		dc.w	$FFEC
		dc.w	0
		dc.w	$28
		dc.w	3
		dc.w	$FFF5
		dc.w	0
		dc.w	$41FA
		dc.w	6
		dc.w	$6000
		dc.w	$FF1C
		dc.w	$44
		dc.w	$FFFA
		dc.w	$FFFF
		dc.w	0
		dc.w	$48
		dc.w	$FFFE
		dc.w	3
		dc.w	0
		dc.w	$4C
		dc.w	$FFFA
		dc.w	$FFFE
		dc.w	0
		dc.w	$50
		dc.w	$FFF9
		dc.w	$FFF3
		dc.w	0
		dc.w	$3C
		dc.w	$FFF5
		dc.w	$FFEC
		dc.w	0
		dc.w	$40
		dc.w	0
		dc.w	$FFEF
		dc.w	0
; ---------------------------------------------------------------------------
		lea	loc_B5C0(pc),a0
		bra.w	loc_B4A2
; ---------------------------------------------------------------------------
loc_B5C0:	dc.w	$5C		; DATA XREF: ROM:0000B5B8o
		dc.w	7
		dc.w	$FFF9
		dc.w	0
		dc.w	$60
		dc.w	6
		dc.w	5
		dc.w	0
		dc.w	$64
		dc.w	$FFFD
		dc.w	$FFFB
		dc.w	0
		dc.w	$68
		dc.w	$FFFC
		dc.w	$FFF8
		dc.w	0
		dc.w	$54
		dc.w	$FFF3
		dc.w	$FFF4
		dc.w	0
		dc.w	$58
		dc.w	$FFFC
		dc.w	$FFEF
		dc.w	0
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#$FFFFFFF2,d0
		moveq	#$FFFFFFF3,d1
		btst	#0,$28(a5)
		beq.s	loc_B604
		moveq	#$FFFFFFF1,d0

loc_B604:				; CODE XREF: ROM:0000B600j
		bsr.w	sub_CA82
		move.w	#$6C,$26(a6) ; 'l'
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#$FFFFFFFE,d0
		moveq	#$FFFFFFF6,d1
		btst	#0,$28(a5)
		beq.s	loc_B626
		moveq	#$FFFFFFFD,d0
		moveq	#$FFFFFFF7,d1

loc_B626:				; CODE XREF: ROM:0000B620j
		bsr.w	sub_CA82
		move.w	#$70,$26(a6) ; 'p'
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#$FFFFFFF3,d0
		moveq	#$FFFFFFF8,d1
		btst	#0,$28(a5)
		beq.s	loc_B646
		moveq	#$FFFFFFF9,d1

loc_B646:				; CODE XREF: ROM:0000B642j
		bsr.w	sub_CA82
		move.w	#$74,$26(a6) ; 't'
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#$FFFFFFFD,d0
		moveq	#$FFFFFFF4,d1
		btst	#0,$28(a5)
		beq.s	loc_B668
		moveq	#$FFFFFFFE,d0
		moveq	#$FFFFFFF5,d1

loc_B668:				; CODE XREF: ROM:0000B662j
		bsr.w	sub_CA82
		move.w	#$78,$26(a6) ; 'x'
		rts
; ---------------------------------------------------------------------------
		andi.w	#$FF7F,4(a6)
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#$FFFFFFEA,d0
		moveq	#$FFFFFFF4,d1
		bsr.w	sub_CA82
		moveq	#0,d0
		move.b	$28(a5),d0
		add.w	d0,d0
		move.w	word_B69A(pc,d0.w),$26(a6)
		rts
; ---------------------------------------------------------------------------
word_B69A:	dc.w	0
		dc.w	4
		dc.w	8
		dc.w	4
		dc.w	$41FA
		dc.w	8
		dc.w	$6100
		dc.w	$FE44
		dc.b $4E ; N
		dc.b $75 ; u
		dc.w	$F4
		dc.w	$FFEE
		dc.w	$FFEC
		dc.w	0
		dc.w	$F8
		dc.w	$FFEC
		dc.w	$FFEA
		dc.w	0
		dc.w	$FC
		dc.w	$FFEC
		dc.w	$FFEA
		dc.w	0
		dc.w	$F8
		dc.w	$FFEC
		dc.w	$FFEA
		dc.w	0
; ---------------------------------------------------------------------------
		lea	loc_B6D6(pc),a0
		bsr.w	sub_B4EC
		rts
; ---------------------------------------------------------------------------
loc_B6D6:	dc.w	$100		; DATA XREF: ROM:0000B6CCo
		dc.w	$FFEC
		dc.w	$FFEC
		dc.w	0
		dc.w	$104
		dc.w	$FFEC
		dc.w	$FFEA
		dc.w	0
		dc.w	$108
		dc.w	$FFEC
		dc.w	$FFEC
		dc.w	0
		dc.w	$104
		dc.w	$FFEC
		dc.w	$FFEC
		dc.w	0
; ---------------------------------------------------------------------------
		andi.w	#$FF7F,4(a6)
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#$FFFFFFFD,d0
		moveq	#$FFFFFFF3,d1
		bsr.w	sub_CA82
		move.w	#$BC,$26(a6) ; '¼'
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#0,d0
		moveq	#$FFFFFFF3,d1
		btst	#0,$28(a5)
		beq.s	loc_B728
		moveq	#$FFFFFFFE,d0

loc_B728:				; CODE XREF: ROM:0000B724j
		bsr.w	sub_CA82
		move.w	#$BC,$26(a6) ; '¼'
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#4,d0
		moveq	#$FFFFFFE7,d1
		btst	#0,$28(a5)
		beq.s	loc_B74A
		moveq	#3,d0
		moveq	#$FFFFFFE8,d1

loc_B74A:				; CODE XREF: ROM:0000B744j
		bsr.w	sub_CA82
		move.w	#$C0,$26(a6) ; 'À'
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#$FFFFFFFB,d0
		moveq	#$FFFFFFE9,d1
		btst	#0,$28(a5)
		beq.s	loc_B76A
		moveq	#$FFFFFFEB,d1

loc_B76A:				; CODE XREF: ROM:0000B766j
		bsr.w	sub_CA82
		move.w	#$C4,$26(a6) ; 'Ä'
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#$FFFFFFEE,d0
		moveq	#$FFFFFFF6,d1
		btst	#0,$28(a5)
		beq.s	loc_B78C
		moveq	#$FFFFFFEF,d0
		moveq	#$FFFFFFF7,d1

loc_B78C:				; CODE XREF: ROM:0000B786j
		bsr.w	sub_CA82
		move.w	#$C8,$26(a6) ; 'È'
		rts
; ---------------------------------------------------------------------------
		andi.w	#$FF7F,4(a6)
		rts
; ---------------------------------------------------------------------------
		andi.w	#$FF7F,4(a6)
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#$FFFFFFF0,d0
		moveq	#$FFFFFFE9,d1
		bsr.w	sub_CA82
		moveq	#0,d0
		move.b	$28(a5),d0
		add.w	d0,d0
		move.w	word_B7C6(pc,d0.w),$26(a6)
		rts
; ---------------------------------------------------------------------------
word_B7C6:	dc.w	$FC
		dc.w	$100
		dc.w	$104
		dc.w	$108
		dc.w	$10C
		dc.w	$110
; ---------------------------------------------------------------------------

loc_B7D2:				; CODE XREF: ROM:0000B432j
					; DATA XREF: ROM:loc_B436o
		tst.b	5(a6)
		bmi.s	loc_B7DA
		rts
; ---------------------------------------------------------------------------

loc_B7DA:				; CODE XREF: ROM:0000B7D6j
		move.w	$26(a6),d0
		lea	(PLCMAP_SonArm_MainIndex).l,a0
		lea	(Map_SonicArm).l,a1
		lea	(PLC_SonicArm).l,a2
		adda.w	(a0,d0.w),a1
		adda.w	2(a0,d0.w),a2
		move.l	a1,$10(a6)
		tst.b	6(a5)
		bne.s	loc_B80E
		move.l	a2,($FFFFD888).w
		ori.b	#8,($FFFFD87A).w
		rts
; ---------------------------------------------------------------------------

loc_B80E:				; CODE XREF: ROM:0000B800j
		move.l	a2,($FFFFD88C).w
		ori.b	#$10,($FFFFD87A).w
		rts
; ---------------------------------------------------------------------------

loc_B81A:				; DATA XREF: ROM:0000A20Ao
		movea.w	$24(a6),a5
		tst.b	5(a5)
		bmi.s	loc_B82E
		andi.w	#$FF7F,4(a6)
		bra.w	loc_BBE8
; ---------------------------------------------------------------------------

loc_B82E:				; CODE XREF: ROM:0000B822j
		pea	(loc_BBE8).l
		move.w	$26(a5),d7
		move.w	word_B840(pc,d7.w),d7
		jmp	word_B840(pc,d7.w)
; ---------------------------------------------------------------------------
word_B840:	dc.w	$34
		dc.w	$D6
		dc.w	$11C
		dc.w	$164
		dc.w	$1AC
		dc.w	$1F4
		dc.w	$20A
		dc.w	$220
		dc.w	$236
		dc.w	$24C
		dc.w	$254
		dc.w	$274
		dc.w	$29E
		dc.w	$2C8
		dc.w	$2D0
		dc.w	$2E6
		dc.w	$306
		dc.w	$328
		dc.w	$348
		dc.w	$2E6
		dc.w	$306
		dc.w	$328
		dc.w	$348
		dc.w	$36A
		dc.w	$372
		dc.w	$37A
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		cmpi.b	#2,$28(a5)
		bne.s	loc_B892
		moveq	#$FFFFFFF9,d0
		moveq	#$FFFFFFF6,d1
		bsr.w	sub_CA82
		move.w	#$64,$26(a6) ; 'd'
		rts
; ---------------------------------------------------------------------------

loc_B892:				; CODE XREF: ROM:0000B880j
		moveq	#$FFFFFFF4,d0
		moveq	#$FFFFFFEE,d1
		bsr.w	sub_CA82
		move.w	#$5C,$26(a6) ; '\'
		rts
; ---------------------------------------------------------------------------

loc_B8A2:				; CODE XREF: ROM:0000B91Aj
					; ROM:0000B960j ...
		tst.w	$2E(a5)
		beq.s	sub_B8F0
		ori.w	#$80,4(a6) ; '€'
		move.b	$2B(a5),d0
		addq.b	#8,d0
		lsr.w	#3,d0
		andi.w	#$1E,d0
		move.w	word_B8D0(pc,d0.w),$26(a6)
		clr.b	$20(a6)
		moveq	#0,d0
		moveq	#$FFFFFFFE,d1
		move.b	$20(a5),d2
		bra.w	loc_CA8A
; ---------------------------------------------------------------------------
word_B8D0:	dc.w	$20
		dc.w	$1C
		dc.w	$18
		dc.w	$14
		dc.w	$10
		dc.w	$C
		dc.w	8
		dc.w	4
		dc.w	0
		dc.w	$3C
		dc.w	$38
		dc.w	$34
		dc.w	$30
		dc.w	$2C
		dc.w	$28
		dc.w	$24

; =============== S U B	R O U T	I N E =======================================


sub_B8F0:				; CODE XREF: ROM:0000B8A6j
					; ROM:0000BAB8p ...
		ori.w	#$80,4(a6) ; '€'
		moveq	#0,d4
		move.b	$28(a5),d4
		add.w	d4,d4
		add.w	d4,d4
		add.w	d4,d4
		move.w	(a0,d4.w),$26(a6)
		move.w	2(a0,d4.w),d0
		move.w	4(a0,d4.w),d1
		bsr.w	sub_CA82
		rts
; End of function sub_B8F0

; ---------------------------------------------------------------------------
		lea	loc_Unamed_01(pc),a0
		bra.s	loc_B8A2
; ---------------------------------------------------------------------------
loc_Unamed_01:	dc.w	$60		; DATA XREF: ROM:0000B916o
		dc.w	$FFF4
		dc.w	$FFEE
		dc.w	0
		dc.w	$64
		dc.w	$FFF4
		dc.w	$FFEE
		dc.w	0
		dc.w	$58
		dc.w	$FFF4
		dc.w	$FFEE
		dc.w	0
		dc.w	$5C
		dc.w	$FFF4
		dc.w	$FFEE
		dc.w	0
		dc.w	$60
		dc.w	$FFF4
		dc.w	$FFEE
		dc.w	0
		dc.w	$64
		dc.w	$FFF4
		dc.w	$FFEE
		dc.w	0
		dc.w	$58
		dc.w	$FFF4
		dc.w	$FFEE
		dc.w	0
		dc.w	$5C
		dc.w	$FFF4
		dc.w	$FFEE
		dc.w	0
; ---------------------------------------------------------------------------
		lea	loc_B964(pc),a0
		bra.w	loc_B8A2
; ---------------------------------------------------------------------------
loc_B964:	dc.w	$70		; DATA XREF: ROM:0000B95Co
		dc.w	$FFF0
		dc.w	$FFE9
		dc.w	0
		dc.w	$74
		dc.w	$FFF0
		dc.w	$FFE9
		dc.w	0
		dc.w	$68
		dc.w	$FFF0
		dc.w	$FFE9
		dc.w	0
		dc.w	$6C
		dc.w	$FFF0
		dc.w	$FFE9
		dc.w	0
		dc.w	$70
		dc.w	$FFF0
		dc.w	$FFE9
		dc.w	0
		dc.w	$74
		dc.w	$FFF0
		dc.w	$FFE9
		dc.w	0
		dc.w	$68
		dc.w	$FFF0
		dc.w	$FFE9
		dc.w	0
		dc.w	$6C
		dc.w	$FFF0
		dc.w	$FFE9
		dc.w	0
; ---------------------------------------------------------------------------
		lea	loc_B9AC(pc),a0
		bra.w	loc_B8A2
; ---------------------------------------------------------------------------
loc_B9AC:	dc.w	$80		; DATA XREF: ROM:0000B9A4o
		dc.w	$FFEE
		dc.w	$FFEC
		dc.w	0
		dc.w	$84
		dc.w	$FFEE
		dc.w	$FFEC
		dc.w	0
		dc.w	$78
		dc.w	$FFEE
		dc.w	$FFEC
		dc.w	0
		dc.w	$7C
		dc.w	$FFEE
		dc.w	$FFEC
		dc.w	0
		dc.w	$80
		dc.w	$FFEE
		dc.w	$FFEC
		dc.w	0
		dc.w	$84
		dc.w	$FFEE
		dc.w	$FFEC
		dc.w	0
		dc.w	$78
		dc.w	$FFEE
		dc.w	$FFEC
		dc.w	0
		dc.w	$7C
		dc.w	$FFEE
		dc.w	$FFEC
		dc.w	0
; ---------------------------------------------------------------------------
		lea	loc_B9F4(pc),a0
		bra.w	loc_B8A2
; ---------------------------------------------------------------------------
loc_B9F4:	dc.w	$80		; DATA XREF: ROM:0000B9ECo
		dc.w	$FFF0
		dc.w	$FFE8
		dc.w	0
		dc.w	$84
		dc.w	$FFF0
		dc.w	$FFE8
		dc.w	0
		dc.w	$78
		dc.w	$FFF0
		dc.w	$FFE8
		dc.w	0
		dc.w	$7C
		dc.w	$FFF0
		dc.w	$FFE8
		dc.w	0
		dc.w	$80
		dc.w	$FFF0
		dc.w	$FFE8
		dc.w	0
		dc.w	$84
		dc.w	$FFF0
		dc.w	$FFE8
		dc.w	0
		dc.w	$78
		dc.w	$FFF0
		dc.w	$FFE8
		dc.w	0
		dc.w	$7C
		dc.w	$FFF0
		dc.w	$FFE8
; ---------------------------------------------------------------------------
		ori.b	#$6E,d0	; 'n'
		ori.l	#$470F0,d0
		moveq	#$FFFFFFEE,d1
		bsr.w	sub_CA82
		move.w	#$A8,$26(a6) ; '¨'
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#$FFFFFFF0,d0
		moveq	#$FFFFFFE9,d1
		bsr.w	sub_CA82
		move.w	#$AC,$26(a6) ; '¬'
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#$FFFFFFEE,d0
		moveq	#$FFFFFFF0,d1
		bsr.w	sub_CA82
		move.w	#$B0,$26(a6) ; '°'
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#$FFFFFFF0,d0
		moveq	#$FFFFFFE8,d1
		bsr.w	sub_CA82
		move.w	#$B4,$26(a6) ; '´'
		rts
; ---------------------------------------------------------------------------
		andi.w	#$FF7F,4(a6)
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#$FFFFFFF4,d0
		cmpi.b	#$14,$28(a5)
		bcs.s	loc_BAA6
		subq.w	#1,d0

loc_BAA6:				; CODE XREF: ROM:0000BAA2j
		moveq	#$FFFFFFEE,d1
		bsr.w	sub_CA82
		move.w	#$5C,$26(a6) ; '\'
		rts
; ---------------------------------------------------------------------------
		lea	loc_BABE(pc),a0
		bsr.w	sub_B8F0
		rts
; ---------------------------------------------------------------------------
loc_BABE:	dc.w	$40		; DATA XREF: ROM:0000BAB4o
		dc.w	$FFEE
		dc.w	$FFEC
		dc.w	0
		dc.w	$44
		dc.w	$FFEC
		dc.w	$FFEA
		dc.w	0
		dc.w	$48
		dc.w	$FFEC
		dc.w	$FFEA
		dc.w	0
		dc.w	$44
		dc.w	$FFEC
		dc.w	$FFEA
		dc.w	0
; ---------------------------------------------------------------------------
		lea	loc_BAE8(pc),a0
		bsr.w	sub_B8F0
		rts
; ---------------------------------------------------------------------------
loc_BAE8:	dc.w	$4C		; DATA XREF: ROM:0000BADEo
		dc.w	$FFEC
		dc.w	$FFEC
		dc.w	0
		dc.w	$50
		dc.w	$FFEC
		dc.w	$FFEA
		dc.w	0
		dc.w	$54
		dc.w	$FFEC
		dc.w	$FFEC
		dc.w	0
		dc.w	$50
		dc.w	$FFEC
		dc.w	$FFEC
		dc.w	0
; ---------------------------------------------------------------------------
		andi.w	#$FF7F,4(a6)
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#$FFFFFFFD,d0
		moveq	#$FFFFFFFB,d1
		bsr.w	sub_CA82
		move.w	#$BC,$26(a6) ; '¼'
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#0,d0
		moveq	#$FFFFFFFB,d1
		btst	#0,$28(a5)
		beq.s	loc_BB3A
		moveq	#$FFFFFFFE,d0

loc_BB3A:				; CODE XREF: ROM:0000BB36j
		bsr.w	sub_CA82
		move.w	#$BC,$26(a6) ; '¼'
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#4,d0
		moveq	#$FFFFFFE7,d1
		btst	#0,$28(a5)
		beq.s	loc_BB5C
		moveq	#3,d0
		moveq	#$FFFFFFE8,d1

loc_BB5C:				; CODE XREF: ROM:0000BB56j
		bsr.w	sub_CA82
		move.w	#$C0,$26(a6) ; 'À'
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#$FFFFFFFB,d0
		moveq	#$FFFFFFE9,d1
		btst	#0,$28(a5)
		beq.s	loc_BB7C
		moveq	#$FFFFFFEB,d1

loc_BB7C:				; CODE XREF: ROM:0000BB78j
		bsr.w	sub_CA82
		move.w	#$C4,$26(a6) ; 'Ä'
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#$FFFFFFEE,d0
		moveq	#$FFFFFFF6,d1
		btst	#0,$28(a5)
		beq.s	loc_BB9E
		moveq	#$FFFFFFEF,d0
		moveq	#$FFFFFFF7,d1

loc_BB9E:				; CODE XREF: ROM:0000BB98j
		bsr.w	sub_CA82
		move.w	#$C8,$26(a6) ; 'È'
		rts
; ---------------------------------------------------------------------------
		andi.w	#$FF7F,4(a6)
		rts
; ---------------------------------------------------------------------------
		andi.w	#$FF7F,4(a6)
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#$FFFFFFF4,d0
		moveq	#$FFFFFFEE,d1
		bsr.w	sub_CA82
		moveq	#0,d0
		move.b	$28(a5),d0
		add.w	d0,d0
		move.w	word_BBD8(pc,d0.w),$26(a6)
		rts
; ---------------------------------------------------------------------------
word_BBD8:	dc.w	$F0
		dc.w	$F4
		dc.w	$F8
		dc.w	$FC
		dc.w	$100
		dc.w	$104
		dc.w	$108
		dc.w	$10C
; ---------------------------------------------------------------------------

loc_BBE8:				; CODE XREF: ROM:0000B82Aj
					; DATA XREF: ROM:loc_B82Eo
		tst.b	5(a6)
		bmi.s	loc_BBF0
		rts
; ---------------------------------------------------------------------------

loc_BBF0:				; CODE XREF: ROM:0000BBECj
		move.w	$26(a6),d0
		lea	(PLCMAP_TalArm_MainIndex).l,a0
		lea	(MAP_TailsArm).l,a1
		lea	(PLC_TailsArm).l,a2
		adda.w	(a0,d0.w),a1
		adda.w	2(a0,d0.w),a2
		move.l	a1,$10(a6)
		tst.b	6(a5)
		bne.s	loc_BC24
		move.l	a2,($FFFFD888).w
		ori.b	#8,($FFFFD87A).w
		rts
; ---------------------------------------------------------------------------

loc_BC24:				; CODE XREF: ROM:0000BC16j
		move.l	a2,($FFFFD88C).w
		ori.b	#$10,($FFFFD87A).w
		rts
; ---------------------------------------------------------------------------

loc_BC30:				; DATA XREF: ROM:0000A242o
		movea.w	$24(a6),a5
		tst.b	5(a5)
		bmi.s	loc_BC44
		andi.w	#$FF7F,4(a6)
		bra.w	loc_BE26
; ---------------------------------------------------------------------------

loc_BC44:				; CODE XREF: ROM:0000BC38j
		pea	(loc_BE26).l
		move.w	$26(a5),d7
		move.w	word_BC56(pc,d7.w),d7
		jmp	word_BC56(pc,d7.w)
; ---------------------------------------------------------------------------
word_BC56:	dc.w	$34
		dc.w	$66
		dc.w	$66
		dc.w	$66
		dc.w	$66
		dc.w	$6E
		dc.w	$6E
		dc.w	$6E
		dc.w	$6E
		dc.w	$9A
		dc.w	$34
		dc.w	$34
		dc.w	$34
		dc.w	$180
		dc.w	$34
		dc.w	$66
		dc.w	$66
		dc.w	$66
		dc.w	$66
		dc.w	$6E
		dc.w	$6E
		dc.w	$6E
		dc.w	$6E
; ---------------------------------------------------------------------------
		movep.w	d0,$1C0(a0)
		movep.l	d0,$6E(a0)
		ori.l	#$4302E,d0
		dc.w	$002A,$0640,$0020 ;[ori.b	#$40,$20(a2)]
		cmpi.w	#$500,d0
		bcs.s	loc_BCA0
		moveq	#0,d0

loc_BCA0:				; CODE XREF: ROM:0000BC9Cj
		move.w	d0,$2A(a6)
		moveq	#0,d0
		move.b	$2A(a6),d0
		addi.w	#$76,d0	; 'v'
		move.w	d0,$26(a6)
		moveq	#$FFFFFFDC,d0
		moveq	#$FFFFFFEE,d1
		bsr.w	sub_CA82
		rts
; ---------------------------------------------------------------------------
		andi.w	#$FF7F,4(a6)
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		move.w	#$67,$26(a6) ; 'g'
		moveq	#$FFFFFFF0,d0
		moveq	#0,d1
		move.b	#0,$20(a6)
		tst.b	$28(a5)
		beq.s	loc_BCE6
		move.b	#$18,$20(a6)

loc_BCE6:				; CODE XREF: ROM:0000BCDEj
		move.b	$20(a5),d2
		bsr.w	loc_CA8A
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		move.w	$18(a5),d0
		move.w	$1C(a5),d1
		jsr	sub_42CE
		addi.w	#$10,d2
		andi.w	#$E0,d2	; 'à'
		lsr.w	#2,d2
		move.w	word_BD3A(pc,d2.w),d0
		move.b	$28(a5),d1
		andi.w	#$1E,d1
		add.w	d1,d0
		move.w	word_BD76(pc,d0.w),$26(a6)
		move.w	word_BD36(pc,d2.w),d0
		move.w	word_BD38(pc,d2.w),d1
		move.w	word_BD3C(pc,d2.w),d2
		move.b	d2,$20(a6)
		bsr.w	loc_CA8A
		rts
; ---------------------------------------------------------------------------
word_BD36:	dc.w	$FFDC
word_BD38:	dc.w	$FFF8
word_BD3A:	dc.w	0
word_BD3C:	dc.w	0
		dc.w	7
		dc.w	7
		dc.w	$48
		dc.w	$18
		dc.w	$FFF8
		dc.w	$C
		dc.w	$30
		dc.w	$18
		dc.w	$FFE1
		dc.w	7
		dc.w	$18
		dc.w	$18
		dc.w	$FFDC
		dc.w	$FFF8
		dc.w	0
		dc.w	$18
		dc.w	7
		dc.w	7
		dc.w	$48
		dc.w	0
		dc.w	$FFF8
		dc.w	$C
		dc.w	$30
		dc.w	0
		dc.w	$FFE1
		dc.w	7
		dc.w	$18
		dc.w	0
word_BD76:	dc.w	$54
		dc.w	$55
		dc.w	$56
		dc.w	$57
		dc.w	$54
		dc.w	$55
		dc.w	$56
		dc.w	$57
		dc.w	$54
		dc.w	$55
		dc.w	$56
		dc.w	$57
		dc.w	$58
		dc.w	$59
		dc.w	$5A
		dc.w	$5B
		dc.w	$58
		dc.w	$59
		dc.w	$5A
		dc.w	$5B
		dc.w	$58
		dc.w	$59
		dc.w	$5A
		dc.w	$5B
		dc.w	$5C
		dc.w	$5D
		dc.w	$5E
		dc.w	$5F
		dc.w	$5C
		dc.w	$5D
		dc.w	$5E
		dc.w	$5F
		dc.w	$5C
		dc.w	$5D
		dc.w	$5E
		dc.w	$5F
		dc.w	$60
		dc.w	$61
		dc.w	$62
		dc.w	$63
		dc.w	$60
		dc.w	$61
		dc.w	$62
		dc.w	$63
		dc.w	$60
		dc.w	$61
		dc.w	$62
		dc.w	$63
; ---------------------------------------------------------------------------
		andi.w	#$FF7F,4(a6)
		rts
; ---------------------------------------------------------------------------
		ori.w	#$80,4(a6) ; '€'
		moveq	#0,d0
		move.b	$28(a5),d0
		add.w	d0,d0
		move.w	word_BDFC(pc,d0.w),$26(a6)
		moveq	#$FFFFFFE0,d0
		moveq	#$FFFFFFFC,d1
		bsr.w	sub_CA82
		rts
; ---------------------------------------------------------------------------
word_BDFC:	dc.w	$54
		dc.w	$54
		dc.w	$54
		dc.w	$55
		dc.w	$55
		dc.w	$55
		dc.w	$56
		dc.w	$56
		dc.w	$56
		dc.w	$57
		dc.w	$57
		dc.w	$57
		dc.w	$FFFF
; ---------------------------------------------------------------------------
		andi.w	#$FF7F,4(a6)
		rts
; ---------------------------------------------------------------------------
		andi.w	#$FF7F,4(a6)
		rts
; ---------------------------------------------------------------------------

loc_BE26:				; CODE XREF: ROM:0000BC40j
					; DATA XREF: ROM:loc_BC44o
		tst.b	5(a6)
		bmi.s	loc_BE2E
		rts
; ---------------------------------------------------------------------------

loc_BE2E:				; CODE XREF: ROM:0000BE2Aj
		move.w	$26(a6),d0
		add.w	d0,d0
		add.w	d0,d0
		lea	(PLCMAP_Tails_MainIndex).l,a0
		lea	(MAP_Tails).l,a1
		lea	(PLC_Tails).l,a2
		adda.w	(a0,d0.w),a1
		adda.w	2(a0,d0.w),a2
		move.l	a1,$10(a6)
		tst.b	6(a5)
		bne.s	loc_BE66
		move.l	a2,($FFFFD894).w
		ori.b	#$40,($FFFFD87A).w ; '@'
		rts
; ---------------------------------------------------------------------------

loc_BE66:				; CODE XREF: ROM:0000BE58j
		move.l	a2,($FFFFD898).w
		ori.b	#$80,($FFFFD87A).w
		rts

; =============== S U B	R O U T	I N E =======================================

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load the Player/Character Objects to SST for Levels
; ---------------------------------------------------------------------------

Levels_LoadPlayers:					; Offset: 0000BE72
		move.w	#$0000,($FFFFD866).w			; set Player 1's character as Sonic	

	if	Combi	=	1
	else
	
		move.w	#$0000,($FFFFD868).w			; set Player 2's character as Tails
		jmp		LLLLLCont
		nop
		
Levels_LoadPlayersTail:					; Offset: 0000BE72
		move.w	#$0004,($FFFFD866).w			; set Player 1's character as Sonic
	
	endif
		
		move.w	#$0004,($FFFFD868).w			; set Player 2's character as Tails
		jmp		LLLLLCont

; ---------------------------------------------------------------------------
; Loading Player 1's Arm
; ---------------------------------------------------------------------------
LLLLLCont:
		moveq	#$04,d0					; set to read the 1st Object Ram section
		jsr	Objects_FindFreeSlot			; find free object space
		bmi.s	LLP_NoChar1Arm				; if there is no space, branch
		move.w	#$0080,$04(a0)
		move.w	#$0800,$06(a0)
		move.w	#$0000,$20(a0)				; set V-Ram location read
		move.w	a0,($FFFFD862).w

; ---------------------------------------------------------------------------
; Loading Player 1
; ---------------------------------------------------------------------------

LLP_NoChar1Arm:						; Offset: 0000BE9C
		moveq	#$04,d0					; set to read the 1st Object Ram section
		jsr	Objects_FindFreeSlot			; find free object space
		bmi.s	LLP_NoChar1				; if there is no space, branch
		move.w	#$0080,$04(a0)
		move.w	#$0002,$06(a0)
		move.w	($FFFFC9DE).w,d0			; load screen's X position
		addi.w	#$00B8,d0				; add B8 (just over half the size)
		move.w	d0,$08(a0)				; set X position
		move.w	($FFFFC9EE).w,d0			; load screen's Y position
		addi.w	#$0070,d0				; add 70 (half the size)
		move.w	d0,$0C(a0)				; set Y position
		move.w	#$0000,$20(a0)				; set V-Ram location read
		movea.w	($FFFFD862).w,a6			; load last object's address
		move.w	a0,($FFFFD862).w			; save new object's address
		move.w	a0,$24(a6)				; store new object's address to last object
		move.w	#$0010,$32(a0)

; ---------------------------------------------------------------------------
; Loading Player 1's Additional Object (A Tail, A Body Piece, etc)
; ---------------------------------------------------------------------------

LLP_NoChar1:						; Offset: 0000BEE0
		moveq	#$04,d0					; set to read the 1st Object Ram section
		jsr	Objects_FindFreeSlot			; find free object space
		bmi.s	LLP_NoChar1Piece			; if there is no space, branch
		move.w	#$0080,$04(a0)
		move.w	#$1000,$06(a0)
		move.w	#$0000,$20(a0)				; set V-Ram location read
		move.w	($FFFFD862).w,$24(a0)

; ---------------------------------------------------------------------------
; Loading Player 2's Arm
; ---------------------------------------------------------------------------

LLP_NoChar1Piece:					; Offset: 0000BF00
	if	Combi	=	1
		moveq	#$04,d0					; set to read the 1st Object Ram section
		jsr	Objects_FindFreeSlot			; find free object space
		bmi.s	LLP_NoChar2Arm				; if there is no space, branch
		move.w	#$0080,$04(a0)
		move.w	#$0C00,$06(a0)
		move.w	#$0021,$20(a0)				; set V-Ram location read
		move.w	a0,($FFFFD864).w
	else
	endif


; ---------------------------------------------------------------------------
; Loading Player 2
; ---------------------------------------------------------------------------

LLP_NoChar2Arm:						; Offset: 0000BF1E
	if	Combi	=	1
		moveq	#$04,d0					; set to read the 1st Object Ram section
		jsr	Objects_FindFreeSlot			; find free object space
		bmi.s	LLP_NoChar2				; if there is no space, branch
		move.w	#$0080,$04(a0)
		move.w	#$0402,$06(a0)
		move.w	($FFFFC9DE).w,d0			; load screen's X position
		addi.w	#$0088,d0				; add 88 (just under half the size)
		move.w	d0,$08(a0)				; set X position
		move.w	($FFFFC9EE).w,d0			; load screen's Y position
		addi.w	#$0070,d0				; add 70 (half the size)
		move.w	d0,$0C(a0)				; set Y position
		move.w	#$0021,$20(a0)				; set V-Ram location read
		movea.w	($FFFFD864).w,a6			; load last object's address
		move.w	a0,($FFFFD864).w			; save new object's address
		move.w	a0,$24(a6)				; store new object's address to last object
		move.w	#$0010,$32(a0)
	else
	endif

; ---------------------------------------------------------------------------
; Loading Player 2's Additional Object (A Tail, A Body Piece, etc)
; ---------------------------------------------------------------------------

LLP_NoChar2:						; Offset: 0000BF62
	if	Combi	=	1
		moveq	#$04,d0					; set to read the 1st Object Ram section
		jsr	Objects_FindFreeSlot			; find free object space
		bmi.s	LLP_NoChar2Piece			; if there is no space, branch
		move.w	#$0080,$04(a0)
		move.w	#$1400,$06(a0)
		move.w	#$0021,$20(a0)				; set V-Ram location read
		move.w	($FFFFD864).w,$24(a0)
	else
	endif

LLP_NoChar2Piece:					; Offset: 0000BF82
		rts						; return

; ===========================================================================


; =============== S U B	R O U T	I N E =======================================


sub_BF84:				; CODE XREF: ROM:0000A32Ap
					; ROM:0000A34Ap ...
		jsr	sub_1B3E
		moveq	#0,d5
		tst.b	d2
		bne.s	loc_BF90
		moveq	#0,d2

loc_BF90:				; CODE XREF: sub_BF84+8j
		btst	d3,($FFFFFAE8).w
		beq.s	loc_BFB4
		move.b	(a1),d5
		beq.s	loc_BFF8
		cmpi.b	#$10,d5
		beq.s	loc_BFB4
		btst	#$1B,d3
		bne.s	loc_BFF6
		move.w	d1,d6
		andi.w	#$F,d6
		sub.w	d6,d5
		neg.w	d5
		addq.w	#1,d5
		rts
; ---------------------------------------------------------------------------

loc_BFB4:				; CODE XREF: sub_BF84+10j sub_BF84+1Aj
		addi.w	#$10,d1
		jsr	sub_1B3E
		moveq	#0,d5
		tst.b	d2
		bne.s	loc_BFC4
		moveq	#0,d2

loc_BFC4:				; CODE XREF: sub_BF84+3Cj
		subi.w	#$10,d1
		btst	d3,($FFFFFAE8).w
		beq.s	loc_BFD6
		move.b	(a1),d5
		cmpi.b	#$10,d5
		bne.s	loc_BFDA

loc_BFD6:				; CODE XREF: sub_BF84+48j sub_BF84+6Aj
		moveq	#$FFFFFF80,d5
		rts
; ---------------------------------------------------------------------------

loc_BFDA:				; CODE XREF: sub_BF84+50j
		btst	#$1B,d3
		beq.s	loc_BFE4
		moveq	#0,d5
		moveq	#0,d2

loc_BFE4:				; CODE XREF: sub_BF84+5Aj
		move.w	d1,d6
		andi.w	#$F,d6
		sub.w	d6,d5
		neg.w	d5
		bmi.s	loc_BFD6
		subi.w	#$F,d5
		rts
; ---------------------------------------------------------------------------

loc_BFF6:				; CODE XREF: sub_BF84+20j
		moveq	#0,d2

loc_BFF8:				; CODE XREF: sub_BF84+14j
		subi.w	#$10,d1
		move.w	d2,-(sp)
		move.l	d3,-(sp)
		jsr	sub_1B3E
		moveq	#0,d5
		tst.b	d2
		bne.s	loc_C00C
		moveq	#0,d2

loc_C00C:				; CODE XREF: sub_BF84+84j
		move.l	(sp)+,d7
		move.w	(sp)+,d6
		addi.w	#$10,d1
		btst	d3,($FFFFFAE8).w
		beq.s	loc_C03A
		move.b	(a1),d5
		cmpi.b	#$10,d5
		beq.s	loc_C03A
		move.w	d1,d6
		andi.w	#$F,d6
		neg.w	d5
		addi.w	#$11,d5
		add.w	d6,d5
		cmpi.w	#$10,d5
		bls.s	locret_C038
		moveq	#$10,d5

locret_C038:				; CODE XREF: sub_BF84+B0j
		rts
; ---------------------------------------------------------------------------

loc_C03A:				; CODE XREF: sub_BF84+94j sub_BF84+9Cj
		move.w	d1,d5
		andi.w	#$F,d5
		addq.w	#1,d5
		move.w	d6,d2
		move.l	d7,d3
		rts
; End of function sub_BF84


; =============== S U B	R O U T	I N E =======================================


sub_C048:				; CODE XREF: ROM:0000C43Ep
					; ROM:0000C45Ap ...
		jsr	sub_1B3E
		moveq	#0,d5
		tst.b	d2
		bne.s	loc_C054
		moveq	#$FFFFFFC0,d2

loc_C054:				; CODE XREF: sub_C048+8j
		btst	d3,($FFFFFAE8).w
		beq.s	loc_C078
		move.b	(a2),d5
		beq.s	loc_C0C6
		cmpi.b	#$10,d5
		beq.s	loc_C078
		btst	#$1A,d3
		bne.s	loc_C0C4
		move.w	d0,d6
		andi.w	#$F,d6
		sub.w	d6,d5
		neg.w	d5
		addq.w	#1,d5
		rts
; ---------------------------------------------------------------------------

loc_C078:				; CODE XREF: sub_C048+10j sub_C048+1Aj
		addi.w	#$10,d0
		jsr	sub_1B3E
		moveq	#0,d5
		tst.b	d2
		bne.s	loc_C088
		moveq	#$FFFFFFC0,d2

loc_C088:				; CODE XREF: sub_C048+3Cj
		subi.w	#$10,d0
		btst	d3,($FFFFFAE8).w
		beq.s	loc_C09A
		move.b	(a2),d5
		cmpi.b	#$10,d5
		bne.s	loc_C09E

loc_C09A:				; CODE XREF: sub_C048+48j sub_C048+74j
		moveq	#$FFFFFF80,d5
		rts
; ---------------------------------------------------------------------------

loc_C09E:				; CODE XREF: sub_C048+50j
		btst	#$1A,d3
		beq.s	loc_C0B2
		move.w	d0,d5
		andi.w	#$F,d5
		subi.w	#$F,d5
		moveq	#$FFFFFFC0,d2
		rts
; ---------------------------------------------------------------------------

loc_C0B2:				; CODE XREF: sub_C048+5Aj
		move.w	d0,d6
		andi.w	#$F,d6
		sub.w	d6,d5
		neg.w	d5
		bmi.s	loc_C09A
		subi.w	#$F,d5
		rts
; ---------------------------------------------------------------------------

loc_C0C4:				; CODE XREF: sub_C048+20j
		moveq	#$FFFFFFC0,d2

loc_C0C6:				; CODE XREF: sub_C048+14j
		subi.w	#$10,d0
		move.w	d2,-(sp)
		move.l	d3,-(sp)
		jsr	sub_1B3E
		moveq	#0,d5
		tst.b	d2
		bne.s	loc_C0DA
		moveq	#$FFFFFFC0,d2

loc_C0DA:				; CODE XREF: sub_C048+8Ej
		move.l	(sp)+,d7
		move.w	(sp)+,d6
		addi.w	#$10,d0
		btst	d3,($FFFFFAE8).w
		beq.s	loc_C108
		move.b	(a2),d5
		cmpi.b	#$10,d5
		beq.s	loc_C108
		move.w	d0,d6
		andi.w	#$F,d6
		neg.w	d5
		addi.w	#$11,d5
		add.w	d6,d5
		cmpi.w	#$10,d5
		bls.s	locret_C106
		moveq	#$10,d5

locret_C106:				; CODE XREF: sub_C048+BAj
		rts
; ---------------------------------------------------------------------------

loc_C108:				; CODE XREF: sub_C048+9Ej sub_C048+A6j
		move.w	d0,d5
		andi.w	#$F,d5
		addq.w	#1,d5
		move.w	d6,d2
		move.l	d7,d3
		rts
; End of function sub_C048


; =============== S U B	R O U T	I N E =======================================


sub_C116:				; CODE XREF: ROM:0000C3CCp
					; ROM:0000C3E8p ...
		jsr	sub_1B3E
		moveq	#0,d5
		tst.b	d2
		bne.s	loc_C122
		moveq	#$FFFFFF80,d2

loc_C122:				; CODE XREF: sub_C116+8j
		btst	d3,($FFFFFAE8).w
		beq.s	loc_C146
		move.b	(a1),d5
		beq.s	loc_C188
		cmpi.b	#$10,d5
		beq.s	loc_C146
		btst	#$1B,d3
		beq.s	loc_C186
		move.w	d1,d6
		andi.w	#$F,d6
		subi.w	#$10,d6
		add.w	d6,d5
		rts
; ---------------------------------------------------------------------------

loc_C146:				; CODE XREF: sub_C116+10j sub_C116+1Aj
		subi.w	#$10,d1
		jsr	sub_1B3E
		moveq	#0,d5
		tst.b	d2
		bne.s	loc_C156
		moveq	#$FFFFFF80,d2

loc_C156:				; CODE XREF: sub_C116+3Cj
		addi.w	#$10,d1
		btst	d3,($FFFFFAE8).w
		beq.s	loc_C168
		move.b	(a1),d5
		cmpi.b	#$10,d5
		bne.s	loc_C16C

loc_C168:				; CODE XREF: sub_C116+48j
		moveq	#$7F,d5	; ''
		rts
; ---------------------------------------------------------------------------

loc_C16C:				; CODE XREF: sub_C116+50j
		btst	#$1B,d3
		bne.s	loc_C17C
		move.w	d1,d5
		andi.w	#$F,d5
		moveq	#$FFFFFF80,d2
		rts
; ---------------------------------------------------------------------------

loc_C17C:				; CODE XREF: sub_C116+5Aj
		move.w	d1,d6
		andi.w	#$F,d6
		add.w	d6,d5
		rts
; ---------------------------------------------------------------------------

loc_C186:				; CODE XREF: sub_C116+20j
		moveq	#$FFFFFF80,d2

loc_C188:				; CODE XREF: sub_C116+14j
		addi.w	#$10,d1
		move.w	d2,-(sp)
		move.l	d3,-(sp)
		jsr	sub_1B3E
		moveq	#0,d5
		tst.b	d2
		bne.s	loc_C19C
		moveq	#$FFFFFF80,d2

loc_C19C:				; CODE XREF: sub_C116+82j
		move.l	(sp)+,d7
		move.w	(sp)+,d6
		subi.w	#$10,d1
		btst	d3,($FFFFFAE8).w
		beq.s	loc_C1CA
		move.b	(a1),d5
		cmpi.b	#$10,d5
		beq.s	loc_C1CA
		move.w	d1,d6
		andi.w	#$F,d6
		subi.w	#$20,d6	; ' '
		sub.w	d5,d6
		move.w	d6,d5
		cmpi.w	#$FFF0,d5
		bcc.s	locret_C1C8
		moveq	#$FFFFFFF0,d5

locret_C1C8:				; CODE XREF: sub_C116+AEj
		rts
; ---------------------------------------------------------------------------

loc_C1CA:				; CODE XREF: sub_C116+92j sub_C116+9Aj
		move.w	d1,d5
		andi.w	#$F,d5
		subi.w	#$10,d5
		move.w	d6,d2
		move.l	d7,d3
		rts
; End of function sub_C116


; =============== S U B	R O U T	I N E =======================================


sub_C1DA:				; CODE XREF: ROM:0000C356p
					; ROM:0000C374p ...
		jsr	sub_1B3E
		moveq	#0,d5
		tst.b	d2
		bne.s	loc_C1E6
		moveq	#$40,d2	; '@'

loc_C1E6:				; CODE XREF: sub_C1DA+8j
		btst	d3,($FFFFFAE8).w
		beq.s	loc_C20A
		move.b	(a2),d5
		beq.s	loc_C24C
		cmpi.b	#$10,d5
		beq.s	loc_C20A
		btst	#$1A,d3
		beq.s	loc_C24A
		move.w	d0,d6
		andi.w	#$F,d6
		subi.w	#$10,d6
		add.w	d6,d5
		rts
; ---------------------------------------------------------------------------

loc_C20A:				; CODE XREF: sub_C1DA+10j sub_C1DA+1Aj
		subi.w	#$10,d0
		jsr	sub_1B3E
		moveq	#0,d5
		tst.b	d2
		bne.s	loc_C21A
		moveq	#$40,d2	; '@'

loc_C21A:				; CODE XREF: sub_C1DA+3Cj
		addi.w	#$10,d0
		btst	d3,($FFFFFAE8).w
		beq.s	loc_C22C
		move.b	(a2),d5
		cmpi.b	#$10,d5
		bne.s	loc_C230

loc_C22C:				; CODE XREF: sub_C1DA+48j
		moveq	#$7F,d5	; ''
		rts
; ---------------------------------------------------------------------------

loc_C230:				; CODE XREF: sub_C1DA+50j
		btst	#$1A,d3
		bne.s	loc_C240
		move.w	d0,d5
		andi.w	#$F,d5
		moveq	#$40,d2	; '@'
		rts
; ---------------------------------------------------------------------------

loc_C240:				; CODE XREF: sub_C1DA+5Aj
		move.w	d0,d6
		andi.w	#$F,d6
		add.w	d6,d5
		rts
; ---------------------------------------------------------------------------

loc_C24A:				; CODE XREF: sub_C1DA+20j
		moveq	#$40,d2	; '@'

loc_C24C:				; CODE XREF: sub_C1DA+14j
		addi.w	#$10,d0
		move.w	d2,-(sp)
		move.l	d3,-(sp)
		jsr	sub_1B3E
		moveq	#0,d5
		tst.b	d2
		bne.s	loc_C260
		moveq	#$40,d2	; '@'

loc_C260:				; CODE XREF: sub_C1DA+82j
		move.l	(sp)+,d7
		move.w	(sp)+,d6
		subi.w	#$10,d0
		btst	d3,($FFFFFAE8).w
		beq.s	loc_C28E
		move.b	(a2),d5
		cmpi.b	#$10,d5
		beq.s	loc_C28E
		move.w	d0,d6
		andi.w	#$F,d6
		subi.w	#$20,d6	; ' '
		sub.w	d5,d6
		move.w	d6,d5
		cmpi.w	#$FFF0,d5
		bcc.s	locret_C28C
		moveq	#$FFFFFFF0,d5

locret_C28C:				; CODE XREF: sub_C1DA+AEj
		rts
; ---------------------------------------------------------------------------

loc_C28E:				; CODE XREF: sub_C1DA+92j sub_C1DA+9Aj
		move.w	d0,d5
		andi.w	#$F,d5
		subi.w	#$10,d5
		move.w	d6,d2
		move.l	d7,d3
		rts
; End of function sub_C1DA


; =============== S U B	R O U T	I N E =======================================


sub_C29E:				; CODE XREF: ROM:0000A53Ep
					; ROM:0000A936p ...
		move.w	$24(a6),d4
		andi.w	#2,d4
		move.b	#$A,($FFFFFAE8).w
		move.b	$2A(a6),d0
		addi.b	#$20,d0	; ' '
		andi.w	#$C0,d0	; 'À'
		lsr.w	#4,d0
		jmp	loc_C2BE(pc,d0.w)
; End of function sub_C29E

; ---------------------------------------------------------------------------

loc_C2BE:
		bra.w	loc_C2CE
; ---------------------------------------------------------------------------
		bra.w	loc_C340
; ---------------------------------------------------------------------------
		bra.w	loc_C3B4
; ---------------------------------------------------------------------------
		bra.w	loc_C428
; ---------------------------------------------------------------------------

loc_C2CE:				; CODE XREF: ROM:loc_C2BEj
		moveq	#0,d0
		move.b	$22(a6),d0
		add.w	8(a6),d0
		moveq	#0,d1
		move.b	$23(a6),d1
		add.w	$C(a6),d1
		bsr.w	sub_BF84
		move.l	d3,-(sp)
		move.w	d2,-(sp)
		move.w	d5,-(sp)
		move.b	d2,($FFFFFAC5).w
		move.l	a0,($FFFFFACA).w
		moveq	#0,d2
		move.b	$22(a6),d2
		neg.w	d2
		add.w	d2,d0
		add.w	d2,d0
		bsr.w	sub_BF84
		move.b	d2,($FFFFFAC4).w
		move.l	a0,($FFFFFAC6).w
		move.w	d5,d0
		move.w	(sp)+,d1
		cmp.w	d1,d0
		bgt.s	loc_C326
		beq.s	loc_C334
		sub.w	d1,$C(a6)
		move.w	(sp)+,d2
		move.b	d2,$2A(a6)
		move.l	(sp)+,d3
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C326:				; CODE XREF: ROM:0000C312j
					; ROM:0000C33Aj
		sub.w	d0,$C(a6)
		move.b	d2,$2A(a6)
		addq.l	#6,sp
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C334:				; CODE XREF: ROM:0000C314j
		moveq	#0,d2
		cmpi.w	#$FF80,d0
		bne.s	loc_C326
		addq.l	#6,sp
		rts
; ---------------------------------------------------------------------------

loc_C340:				; CODE XREF: ROM:0000C2C2j
		moveq	#0,d0
		move.b	$22(a6),d0
		neg.w	d0
		add.w	8(a6),d0
		moveq	#0,d1
		move.b	$23(a6),d1
		add.w	$C(a6),d1
		bsr.w	sub_C1DA
		move.l	d3,-(sp)
		move.w	d2,-(sp)
		move.w	d5,-(sp)
		move.b	d2,($FFFFFAC5).w
		move.l	a0,($FFFFFACA).w
		moveq	#0,d2
		move.b	$23(a6),d2
		neg.w	d2
		add.w	d2,d1
		add.w	d2,d1
		bsr.w	sub_C1DA
		move.b	d2,($FFFFFAC4).w
		move.l	a0,($FFFFFAC6).w
		move.w	d5,d0
		move.w	(sp)+,d1
		cmp.w	d1,d0
		blt.s	loc_C39A
		beq.s	loc_C3A8
		sub.w	d1,8(a6)
		move.w	(sp)+,d2
		move.b	d2,$2A(a6)
		move.l	(sp)+,d3
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C39A:				; CODE XREF: ROM:0000C386j
					; ROM:0000C3AEj
		sub.w	d0,8(a6)
		move.b	d2,$2A(a6)
		addq.l	#6,sp
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C3A8:				; CODE XREF: ROM:0000C388j
		moveq	#$40,d2	; '@'
		cmpi.w	#$7F,d0	; ''
		bne.s	loc_C39A
		addq.l	#6,sp
		rts
; ---------------------------------------------------------------------------

loc_C3B4:				; CODE XREF: ROM:0000C2C6j
		moveq	#0,d0
		move.b	$22(a6),d0
		neg.w	d0
		add.w	8(a6),d0
		moveq	#0,d1
		move.b	$23(a6),d1
		neg.w	d1
		add.w	$C(a6),d1
		bsr.w	sub_C116
		move.l	d3,-(sp)
		move.w	d2,-(sp)
		move.w	d5,-(sp)
		move.b	d2,($FFFFFAC5).w
		move.l	a0,($FFFFFACA).w
		moveq	#0,d2
		move.b	$22(a6),d2
		add.w	d2,d0
		add.w	d2,d0
		bsr.w	sub_C116
		move.b	d2,($FFFFFAC4).w
		move.l	a0,($FFFFFAC6).w
		move.w	d5,d0
		move.w	(sp)+,d1
		cmp.w	d1,d0
		blt.s	loc_C40E
		beq.s	loc_C41C
		sub.w	d1,$C(a6)
		move.w	(sp)+,d2
		move.b	d2,$2A(a6)
		move.l	(sp)+,d3
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C40E:				; CODE XREF: ROM:0000C3FAj
					; ROM:0000C422j
		sub.w	d0,$C(a6)
		move.b	d2,$2A(a6)
		addq.l	#6,sp
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C41C:				; CODE XREF: ROM:0000C3FCj
		moveq	#$FFFFFF80,d2
		cmpi.w	#$7F,d0	; ''
		bne.s	loc_C40E
		addq.l	#6,sp
		rts
; ---------------------------------------------------------------------------

loc_C428:				; CODE XREF: ROM:0000C2CAj
		moveq	#0,d0
		move.b	$22(a6),d0
		add.w	8(a6),d0
		moveq	#0,d1
		move.b	$23(a6),d1
		neg.w	d1
		add.w	$C(a6),d1
		bsr.w	sub_C048
		move.l	d3,-(sp)
		move.w	d2,-(sp)
		move.w	d5,-(sp)
		move.b	d2,($FFFFFAC5).w
		move.l	a0,($FFFFFACA).w
		moveq	#0,d2
		move.b	$23(a6),d2
		add.w	d2,d1
		add.w	d2,d1
		bsr.w	sub_C048
		move.b	d2,($FFFFFAC4).w
		move.l	a0,($FFFFFAC6).w
		move.w	d5,d0
		move.w	(sp)+,d1
		cmp.w	d1,d0
		bgt.s	loc_C480
		beq.s	loc_C48E
		sub.w	d1,8(a6)
		move.w	(sp)+,d2
		move.b	d2,$2A(a6)
		move.l	(sp)+,d3
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C480:				; CODE XREF: ROM:0000C46Cj
					; ROM:0000C494j
		sub.w	d0,8(a6)
		move.b	d2,$2A(a6)
		addq.l	#6,sp
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C48E:				; CODE XREF: ROM:0000C46Ej
		moveq	#$FFFFFFC0,d2
		cmpi.w	#$FF80,d0
		bne.s	loc_C480
		addq.l	#6,sp
		rts

; =============== S U B	R O U T	I N E =======================================


sub_C49A:				; CODE XREF: ROM:0000A538p
					; ROM:0000A622p ...
		move.w	$24(a6),d4
		andi.w	#2,d4
		move.b	#8,($FFFFFAE8).w
		move.b	$2A(a6),d0
		addi.b	#$20,d0	; ' '
		andi.w	#$40,d0	; '@'
		lsr.w	#4,d0
		jmp	loc_C4BA(pc,d0.w)
; End of function sub_C49A

; ---------------------------------------------------------------------------

loc_C4BA:
		bra.w	loc_C4CA
; ---------------------------------------------------------------------------
		bra.w	loc_C524
; ---------------------------------------------------------------------------
		bra.w	loc_C580
; ---------------------------------------------------------------------------
		bra.w	loc_C5DC
; ---------------------------------------------------------------------------

loc_C4CA:				; CODE XREF: ROM:loc_C4BAj
		moveq	#0,d0
		move.b	$22(a6),d0
		addq.w	#1,d0
		neg.w	d0
		add.w	8(a6),d0
		moveq	#0,d1
		move.b	$23(a6),d1
		add.w	$C(a6),d1
		subq.w	#8,d1
		bsr.w	sub_C1DA
		tst.w	d5
		bpl.s	loc_C4FC
		sub.w	d5,8(a6)
		clr.w	$2C(a6)
		clr.l	$18(a6)
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C4FC:				; CODE XREF: ROM:0000C4EAj
		moveq	#0,d0
		move.b	$22(a6),d0
		addq.w	#1,d0
		add.w	8(a6),d0
		bsr.w	sub_C048
		tst.w	d5
		bmi.s	loc_C520
		sub.w	d5,8(a6)
		clr.w	$2C(a6)
		clr.l	$18(a6)
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C520:				; CODE XREF: ROM:0000C50Ej
		moveq	#0,d5
		rts
; ---------------------------------------------------------------------------

loc_C524:				; CODE XREF: ROM:0000C4BEj
		moveq	#0,d0
		move.b	$22(a6),d0
		neg.w	d0
		add.w	8(a6),d0
		addq.w	#8,d0
		moveq	#0,d1
		move.b	$23(a6),d1
		addq.w	#1,d1
		neg.w	d1
		add.w	$C(a6),d1
		bsr.w	sub_C116
		tst.w	d5
		bpl.s	loc_C558
		sub.w	d5,$C(a6)
		clr.w	$2C(a6)
		clr.l	$1C(a6)
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C558:				; CODE XREF: ROM:0000C546j
		moveq	#0,d1
		move.b	$23(a6),d1
		addq.w	#1,d1
		add.w	$C(a6),d1
		bsr.w	sub_BF84
		tst.w	d5
		bmi.s	loc_C57C
		sub.w	d5,$C(a6)
		clr.w	$2C(a6)
		clr.l	$1C(a6)
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C57C:				; CODE XREF: ROM:0000C56Aj
		moveq	#0,d5
		rts
; ---------------------------------------------------------------------------

loc_C580:				; CODE XREF: ROM:0000C4C2j
		moveq	#0,d0
		move.b	$22(a6),d0
		addq.w	#1,d0
		neg.w	d0
		add.w	8(a6),d0
		moveq	#0,d1
		move.b	$23(a6),d1
		neg.w	d1
		add.w	$C(a6),d1
		addq.w	#8,d1
		bsr.w	sub_C1DA
		tst.w	d5
		bpl.s	loc_C5B4
		sub.w	d5,8(a6)
		clr.w	$2C(a6)
		clr.l	$18(a6)
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C5B4:				; CODE XREF: ROM:0000C5A2j
		moveq	#0,d0
		move.b	$22(a6),d0
		addq.w	#1,d0
		add.w	8(a6),d0
		bsr.w	sub_C048
		tst.w	d5
		bmi.s	loc_C5D8
		sub.w	d5,8(a6)
		clr.w	$2C(a6)
		clr.l	$18(a6)
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C5D8:				; CODE XREF: ROM:0000C5C6j
		moveq	#0,d5
		rts
; ---------------------------------------------------------------------------

loc_C5DC:				; CODE XREF: ROM:0000C4C6j
		moveq	#0,d0
		move.b	$22(a6),d0
		add.w	8(a6),d0
		subq.w	#8,d0
		moveq	#0,d1
		move.b	$23(a6),d1
		addq.w	#1,d1
		neg.w	d1
		add.w	$C(a6),d1
		bsr.w	sub_C116
		tst.w	d5
		bpl.s	loc_C60E
		sub.w	d5,$C(a6)
		clr.w	$2C(a6)
		clr.l	$1C(a6)
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C60E:				; CODE XREF: ROM:0000C5FCj
		moveq	#0,d1
		move.b	$23(a6),d1
		addq.w	#1,d1
		add.w	$C(a6),d1
		bsr.w	sub_BF84
		tst.w	d5
		bmi.s	loc_C632
		sub.w	d5,$C(a6)
		clr.w	$2C(a6)
		clr.l	$1C(a6)
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C632:				; CODE XREF: ROM:0000C620j
		moveq	#0,d5
		rts

; =============== S U B	R O U T	I N E =======================================


sub_C636:				; CODE XREF: ROM:0000A628p
					; ROM:0000A6F6p ...
		tst.l	$1C(a6)
		bpl.w	loc_C68A
		move.b	#8,($FFFFFAE8).w
		moveq	#0,d0
		move.b	$22(a6),d0
		neg.w	d0
		add.w	8(a6),d0
		moveq	#0,d1
		move.b	$23(a6),d1
		neg.w	d1
		add.w	$C(a6),d1
		bsr.w	sub_C116
		tst.w	d5
		bpl.s	loc_C66C
		sub.w	d5,$C(a6)
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C66C:				; CODE XREF: sub_C636+2Cj
		moveq	#0,d0
		move.b	$22(a6),d0
		add.w	8(a6),d0
		bsr.w	sub_C116
		tst.w	d5
		bpl.s	loc_C686
		sub.w	d5,$C(a6)
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C686:				; CODE XREF: sub_C636+46j
		moveq	#0,d5
		rts
; ---------------------------------------------------------------------------

loc_C68A:				; CODE XREF: sub_C636+4j
		move.b	#$A,($FFFFFAE8).w
		moveq	#0,d0
		move.b	$22(a6),d0
		add.w	8(a6),d0
		moveq	#0,d1
		move.b	$23(a6),d1
		add.w	$C(a6),d1
		bsr.w	sub_BF84
		tst.w	d5
		bmi.s	loc_C6B4
		sub.w	d5,$C(a6)
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C6B4:				; CODE XREF: sub_C636+74j
		moveq	#0,d0
		move.b	$22(a6),d0
		neg.w	d0
		add.w	8(a6),d0
		bsr.w	sub_BF84
		tst.w	d5
		bmi.s	loc_C6D0
		sub.w	d5,$C(a6)
		moveq	#$FFFFFFFF,d5
		rts
; ---------------------------------------------------------------------------

loc_C6D0:				; CODE XREF: sub_C636+90j
		moveq	#0,d5
		rts
; End of function sub_C636


; =============== S U B	R O U T	I N E =======================================


sub_C6D4:				; CODE XREF: ROM:loc_C7BCp
		move.l	$18(a6),d0
		bpl.s	loc_C6EC
		cmpi.l	#$FFF00000,d0
		bge.s	loc_C6FC
		move.l	#$FFF00000,$18(a6)
		bra.s	loc_C6FC
; ---------------------------------------------------------------------------

loc_C6EC:				; CODE XREF: sub_C6D4+4j
		cmpi.l	#$100000,d0
		bcs.s	loc_C6FC
		move.l	#$100000,$18(a6)

loc_C6FC:				; CODE XREF: sub_C6D4+Cj sub_C6D4+16j	...
		move.l	$1C(a6),d0
		bpl.s	loc_C714
		cmpi.l	#$FFF00000,d0
		bge.s	loc_C724
		move.l	#$FFF00000,$1C(a6)
		rts
; ---------------------------------------------------------------------------

loc_C714:				; CODE XREF: sub_C6D4+2Cj
		cmpi.l	#$100000,d0
		bcs.s	loc_C724
		move.l	#$100000,$1C(a6)

loc_C724:				; CODE XREF: sub_C6D4+34j sub_C6D4+46j
		move.w	$2C(a6),d0
		bpl.s	loc_C738
		cmpi.w	#$F000,d0
		bge.s	locret_C744
		move.w	#$F000,$2C(a6)
		rts
; ---------------------------------------------------------------------------

loc_C738:				; CODE XREF: sub_C6D4+54j
		cmpi.w	#$1000,d0
		bcs.s	locret_C744
		move.w	#$1000,$2C(a6)

locret_C744:				; CODE XREF: sub_C6D4+5Aj sub_C6D4+68j
		rts
; End of function sub_C6D4

; ---------------------------------------------------------------------------

loc_C746:				; DATA XREF: ROM:0000A276o
					; ROM:0000AB3Co
		move.w	4(a6),d7
		ori.w	#$80,d7	; '€'
		btst	#6,5(a6)
		beq.s	loc_C75A
		andi.w	#$FF7F,d7

loc_C75A:				; CODE XREF: ROM:0000C754j
		tst.w	$30(a6)
		beq.s	loc_C76C
		bmi.s	loc_C768
		subq.w	#1,$30(a6)
		bra.s	loc_C76C
; ---------------------------------------------------------------------------

loc_C768:				; CODE XREF: ROM:0000C760j
		clr.w	$30(a6)

loc_C76C:				; CODE XREF: ROM:0000C75Ej
					; ROM:0000C766j
		move.w	d7,4(a6)
		move.b	$25(a6),d0
		andi.b	#$80,d0
		move.b	$20(a6),d1
		andi.b	#$7F,d1	; ''
		or.b	d1,d0
		move.b	d0,$20(a6)
		tst.b	6(a6)
		bne.w	loc_C7BC
		cmpi.b	#$A,7(a6)
		beq.s	loc_C7BC
		move.w	($FFFFFAE0).w,d0
		cmpi.w	#$10,d0
		bcc.s	loc_C7BC
		movea.w	($FFFFD864).w,a0
		move.w	8(a6),d0
		sub.w	8(a0),d0
		smi	d0
		ext.w	d0
		ori.w	#1,d0
		add.w	d0,8(a6)
		sub.w	d0,8(a0)

loc_C7BC:				; CODE XREF: ROM:0000C78Aj
					; ROM:0000C794j ...
		bsr.w	sub_C6D4
		bsr.w	sub_C8CA
		tst.b	6(a6)
		bne.s	loc_C7D6
		lea	($FFFFD87C).w,a4
		moveq	#1,d2
		move.w	($FFFFD866).w,d0
		bra.s	loc_C7E0
; ---------------------------------------------------------------------------

loc_C7D6:				; CODE XREF: ROM:0000C7C8j
		lea	($FFFFD880).w,a4
		moveq	#2,d2
		move.w	($FFFFD868).w,d0

loc_C7E0:				; CODE XREF: ROM:0000C7D4j
		lea	off_C84A(pc,d0.w),a3
		movea.l	(a3),a0
		movea.l	$20(a3),a1
		movea.l	$40(a3),a2
		movea.l	$60(a3),a3
		move.w	$26(a6),d0		; load animation frame number?
		adda.w	(a0,d0.w),a0
		moveq	#0,d1
		move.b	$28(a6),d1
		move.b	3(a0,d1.w),d0
		cmp.b	1(a0),d1
		bls.s	loc_C818
		move.b	2(a0),d0
		move.b	d0,$28(a6)
		move.b	3(a0,d0.w),d0
		bra.s	loc_C82E
; ---------------------------------------------------------------------------

loc_C818:				; CODE XREF: ROM:0000C808j
		move.b	(a0),d1
		add.w	d1,$28(a6)
		move.b	$28(a6),d1
		cmp.b	1(a0),d1
		bls.s	loc_C832
		move.b	2(a0),$28(a6)

loc_C82E:				; CODE XREF: ROM:0000C816j
		clr.b	$29(a6)

loc_C832:				; CODE XREF: ROM:0000C826j
		add.w	d0,d0
		add.w	d0,d0
		adda.w	(a1,d0.w),a3
		adda.w	2(a1,d0.w),a2
		move.l	a2,(a4)
		or.b	d2,($FFFFD87A).w
		move.l	a3,$10(a6)
		rts
; ---------------------------------------------------------------------------
off_C84A:	dc.l	ANI_Sonic
		dc.l	ANI_Tails
		dc.l	ANI_Sonic
		dc.l	0
		dc.l	0
		dc.l	0
		dc.l	0
		dc.l	0
		dc.l	PLCMAP_Sonic_MainIndex
		dc.l	PLCMAP_Tails_MainIndex
		dc.l	PLCMAP_Sonic2_MainIndex
		dc.l	0
		dc.l	0
		dc.l	0
		dc.l	0
		dc.l	0
		dc.l	PLC_Sonic
		dc.l	PLC_Tails
		dc.l	PLC_Sonic
		dc.l	0
		dc.l	0
		dc.l	0
		dc.l	0
		dc.l	0
		dc.l	MAP_Sonic
		dc.l	MAP_Tails
		dc.l	MAP_Sonic2
		dc.l	0
		dc.l	0
		dc.l	0
		dc.l	0
		dc.l	0

; =============== S U B	R O U T	I N E =======================================

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to display Debug numbers in the window pause screen (Doesn't work properly)
; ---------------------------------------------------------------------------

sub_C8CA:				; CODE XREF: ROM:0000C7C0p
		tst.b	6(a6)
		bne.w	locret_C9DC
		move	#$2700,sr
		move.w	6(a6),d0
		move.w	($FFFFD81E).w,d1
		addi.w	#$C00,d1
		jsr	(MapNumbers).l
		move.w	$24(a6),d0
		move.w	($FFFFD81E).w,d1
		addi.w	#$C08,d1
		jsr	(MapNumbers).l
		move.w	$26(a6),d0
		move.w	($FFFFD81E).w,d1
		addi.w	#$C88,d1
		jsr	(MapNumbers).l
		move.w	$28(a6),d0
		move.w	($FFFFD81E).w,d1
		addi.w	#$D08,d1
		jsr	(MapNumbers).l
		moveq	#0,d0
		move.w	$2A(a6),d0
		move.w	($FFFFD81E).w,d1
		addi.w	#$C12,d1
		jsr	(MapNumbers).l
		move.w	$2C(a6),d0
		move.w	($FFFFD81E).w,d1
		addi.w	#$C92,d1
		jsr	(MapNumbers).l
		move.w	$2E(a6),d0
		move.w	($FFFFD81E).w,d1
		addi.w	#$D12,d1
		jsr	(MapNumbers).l
		move.w	($FFFFFAC0).w,d0
		move.w	($FFFFD81E).w,d1
		addi.w	#$C9C,d1
		jsr	(MapNumbers).l
		move.w	($FFFFFAC2).w,d0
		move.w	($FFFFD81E).w,d1
		addi.w	#$CA6,d1
		jsr	(MapNumbers).l
		movea.l	($FFFFFAC6).w,a0
		move.w	(a0),d0
		move.w	($FFFFD81E).w,d1
		addi.w	#$D1C,d1
		jsr	(MapNumbers).l
		movea.l	($FFFFFACA).w,a0
		move.w	(a0),d0
		move.w	($FFFFD81E).w,d1
		addi.w	#$D26,d1
		jsr	(MapNumbers).l
		move.w	8(a6),d0
		move.w	($FFFFD81E).w,d1
		addi.w	#$C1C,d1
		jsr	(MapNumbers).l
		move.w	$C(a6),d0
		move.w	($FFFFD81E).w,d1
		addi.w	#$C26,d1
		jsr	(MapNumbers).l
		move.w	$30(a6),d0
		move.w	($FFFFD81E).w,d1
		addi.w	#$C30,d1
		jsr	(MapNumbers).l
		move	#$2300,sr

locret_C9DC:				; CODE XREF: sub_C8CA+4j
		rts
; End of function sub_C8CA


; =============== S U B	R O U T	I N E =======================================


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to update all 8 character's art (mainly Sonic and Tails')
; ---------------------------------------------------------------------------

DMA_WriteCharactersPLC:					; Offset: 0000C9DE
		lea	($C00004).l,a6				; load VDP address port to a6
		move.w	#$0100,($A11100).l			; request Z80 hult (ON)

DWCP_WaitZ80:						; Offset: 0000C9EC
		btst	#$00,($A11100).l			; has the Z80 stopped?
		bne.s	DWCP_WaitZ80				; if not, loop til stopped
		move.w	#$8154,(a6)				; disable Vertical interrupt and enable DMA
		move.b	($FFFFD87A).w,d3			; load character display bits that were set
		clr.b	($FFFFD87A).w				; clear the display bits for next frame
		lea	($FFFFD87C).w,a1			; load character PLC address/locations to a1
		lea	DWCP_VRamAddData(pc),a2			; load hard coded V-Ram address data
		moveq	#$07,d4					; set repeat times (8 characters)

DWCP_NextCharacter:					; Offset: 0000CA0C
		lsr.w	#$01,d3					; check least significant bit (character bit)
		bcc.s	DWCP_SkipCharacter			; if the bit was clear, branch to skip character
		movea.l	(a1),a0					; load PLC address
		move.w	(a2),d2					; load V-Ram add address
		bsr.s	DMA_WritePLCEntries			; transfer PLC list/entries

DWCP_SkipCharacter:					; Offset: 0000CA16
		addq.w	#$04,a1					; advance to next PLC character slot
		addq.w	#$02,a2					; advance to next V-Ram add address slot
		dbf	d4,DWCP_NextCharacter			; repeat til all 8 characters have been checked and/or ran
		move.w	#$8164,(a6)				; enable Vertical interrupt and disable DMA
		move.w	#$0000,($A11100).l			; request Z80 hult (OFF)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
DWCP_VRamAddData:					; Offset: 0000CA2C
		dc.w	$0000					; Character 1 Address
		dc.w	$0420					; Character 2 Address
		dc.w	$0000					; Character 3 Address
		dc.w	$0000					; Character 4 Address
		dc.w	$0420					; Character 5 Address
		dc.w	$0000					; Character 6 Address
		dc.w	$0000					; Character 7 Address
		dc.w	$0420					; Character 8 Address
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to read PLC data and convert it to DMA data for processing
; ---------------------------------------------------------------------------

DMA_WritePLCEntries:					; Offset: 0000CA3C
		move.l	#$94009300,d0				; prepare DMA size registers
		move.b	(a0)+,d0				; load lower byte of size
		swap	d0					; send left
		move.b	(a0)+,d0				; load upper byte of size
		move.l	d0,(a6)					; save DMA size to VDP
		move.w	(a0)+,d0				; load upper byte of source (with DMA register ID)
		swap	d0					; send left
		move.w	#$9600,d0				; prepare DMA source register
		move.b	(a0)+,d0				; load mid byte of source address
		move.l	d0,(a6)					; save to VDP
		move.w	#$9500,d0				; prepare DMA source register
		move.b	(a0)+,d0				; load lower byte of source
		swap	d0					; send left
		move.w	(a0)+,d0				; load destination
		move.w	d0,d1					; copy to d1
		add.w	d2,d0					; add destination address
		andi.w	#$3FFF,d0				; keep in range
		ori.w	#$4000,d0				; set VDP mode bits
		move.l	d0,(a6)					; save to VDP
		rol.w	#$02,d1					; align the end two bits for VDP properly
		andi.w	#$0003,d1				; clear the rest
		ori.w	#$0080,d1				; set DMA mode bit
		move.w	d1,-(sp)				; store it in the stack
		move.w	(sp)+,(a6)				; save to DMA (Done this way to ensure the first word of data is sent properly)
		tst.w	(a0)+					; are there anymore entries?
		beq.s	DMA_WritePLCEntries			; if so, branch
		rts						; return

; ===========================================================================


sub_CA82:				; CODE XREF: ROM:0000B496p
					; sub_B4EC+20p	...
		move.b	$20(a5),d2
		move.b	d2,$20(a6)

loc_CA8A:				; CODE XREF: ROM:0000B4C8j
					; ROM:0000B8CCj ...
		move.w	8(a5),d3
		btst	#3,d2
		bne.s	loc_CAB4
		add.w	d0,d3
		move.w	d3,8(a6)
		move.w	$C(a5),d3
		btst	#4,d2
		bne.s	loc_CAAC
		add.w	d1,d3
		move.w	d3,$C(a6)
		rts
; ---------------------------------------------------------------------------

loc_CAAC:				; CODE XREF: sub_CA82+20j
		sub.w	d1,d3
		move.w	d3,$C(a6)
		rts
; ---------------------------------------------------------------------------

loc_CAB4:				; CODE XREF: sub_CA82+10j
		sub.w	d0,d3
		move.w	d3,8(a6)
		move.w	$C(a5),d3
		btst	#4,d2
		bne.s	loc_CACC
		add.w	d1,d3
		move.w	d3,$C(a6)
		rts
; ---------------------------------------------------------------------------

loc_CACC:				; CODE XREF: sub_CA82+40j
		sub.w	d1,d3
		move.w	d3,$C(a6)
		rts
; End of function sub_CA82

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to allow an object to be solid if a character touches it
; ---------------------------------------------------------------------------
; if d0 returns a null value, the object was not touched by the character
; if d0 returns FFFFFFFF (Negative), the object was touched by the character
; ---------------------------------------------------------------------------

SolidObject:
		movem.l	d0-d7,-(sp)				; store register data in the stack
		jsr	SolidCheck				; check the solidness status of character/object
		cmp.w	$08(a0),d0				; does character's X position match the new position returned?
		bne.s	loc_CAEA				; if not, branch
		cmp.w	$C(a0),d1				; does character's Y position match the new position returned?
		beq.s	loc_CB14				; if so, branch

loc_CAEA:
		tst.w	-$20(sp)				; did the character touch the object within any distances?
		beq.s	loc_CB14				; if not, branch
		move.w	d0,$08(a0)				; save new X position to character
		move.w	d1,$0C(a0)				; save new Y position to character
		moveq	#$00,d0					; clear d0
		move.w	d0,$2C(a0)				; stop ground speed
		move.l	d0,$18(a0)				; stop X speed
		move.l	d0,$1C(a0)				; stop Y speed
		bset	#$00,$25(a0)				; set object as touched
		moveq	#$FFFFFFFF,d0				; move negative value to d0 (setting object as touched by character)
		movem.l	(sp)+,d0-d7				; reload register data from the stack
		rts						; return

loc_CB14:
		moveq	#$00,d0					; move null value to d0 (setting object as untouched by character)
		movem.l	(sp)+,d0-d7				; reload register data from the stack
		rts						; return

; ===========================================================================

; =============== S U B	R O U T	I N E =======================================

; SOme sort of Speed to Position subroutine

SpeedToPos:
		move.l	d2,-(sp)
		move.l	$18(a0),d2
		add.l	d2,d0
		eor.l	d0,d2
		bpl.s	loc_CB2C
		eor.l	d0,d2
		sub.l	d2,d0

loc_CB2C:				; CODE XREF: SpeedToPos+Aj
		tst.l	d0
		bpl.s	loc_CB40
		cmpi.l	#$FFF00000,d0
		bge.s	loc_CB4E
		move.l	#$FFF00000,d0
		bra.s	loc_CB4E
; ---------------------------------------------------------------------------

loc_CB40:				; CODE XREF: SpeedToPos+12j
		cmpi.l	#$100000,d0
		bcs.s	loc_CB4E
		move.l	#$100000,d0

loc_CB4E:				; CODE XREF: SpeedToPos+1Aj SpeedToPos+22j ...
		move.l	d0,$18(a0)
		move.l	$1C(a0),d2
		add.l	d2,d1
		eor.l	d1,d2
		bpl.s	loc_CB60
		eor.l	d1,d2
		sub.l	d2,d1

loc_CB60:				; CODE XREF: SpeedToPos+3Ej
		tst.l	d1
		bpl.s	loc_CB74
		cmpi.l	#$FFF00000,d1
		bge.s	loc_CB82
		move.l	#$FFF00000,d1
		bra.s	loc_CB82
; ---------------------------------------------------------------------------

loc_CB74:				; CODE XREF: SpeedToPos+46j
		cmpi.l	#$100000,d1
		bcs.s	loc_CB82
		move.l	#$100000,d1

loc_CB82:				; CODE XREF: SpeedToPos+4Ej SpeedToPos+56j ...
		move.l	d1,$1C(a0)
		move.b	#8,7(a0)
		move.l	(sp)+,d2
		rts
; End of function SpeedToPos

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to set sonic as hurt
; ---------------------------------------------------------------------------

HurtPlayer:						; Offset: 0000CB90
		sub.w	d0,$32(a0)
		bclr	#$00,$25(a0)				; deset character off an object (on/off object flag me thinks)
		move.b	#$10,$07(a0)
		move.l	#$00010000,$18(a0)			; set the character's X speed (0001 right)
		move.l	#$FFFB0000,$1C(a0)			; set the character's Y speed (FFFB upwards)
		movem.l	d0-a6,-(sp)				; store register data to the stack
		movea.l	a0,a6					; get character's RAM and move it to a6
		moveq	#$1F,d7				;	set lost ring count to 32
		bsr.w	SpawnBouncingRings			; create spawn bouncing rings
		movem.l	(sp)+,d0-a6				; restore register data from stack
		move.b	#$A5,d0
		jsr		Play_Sound
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; 
; ---------------------------------------------------------------------------

sub_CBC0:
		move.l	$18(a6),d3
		move.l	$1C(a6),d4
		move.b	$2A(a6),d2
		btst	#3,$25(a6)
		beq.s	loc_CBD8
		addi.b	#-$80,d2

loc_CBD8:
		jsr	CalcSine
		move.w	$2C(a6),d2
		muls.w	d2,d0
		muls.w	d2,d1
		tst.w	d2
		beq.s	loc_CC0E
		asr.l	#6,d0
		asr.l	#6,d1
		add.l	d0,d3
		add.l	d1,d4
		move.l	d3,d2
		or.l	d4,d2
		beq.s	loc_CC0E
		move.b	$2B(a6),d2
		jsr	CalcSine
		move.w	$2E(a6),d2
		muls.w	d2,d0
		muls.w	d2,d1
		asr.l	#6,d0
		asr.l	#6,d1
		add.l	d0,d3
		add.l	d1,d4

loc_CC0E:				; CODE XREF: sub_CBC0+26j sub_CBC0+34j
		tst.l	d3
		bpl.s	loc_CC22
		cmpi.l	#$FFF00000,d3
		bge.s	loc_CC30
		move.l	#$FFF00000,d3
		bra.s	loc_CC30
; ---------------------------------------------------------------------------

loc_CC22:				; CODE XREF: sub_CBC0+50j
		cmpi.l	#$100000,d3
		bcs.s	loc_CC30
		move.l	#$100000,d3

loc_CC30:				; CODE XREF: sub_CBC0+58j sub_CBC0+60j ...
		tst.l	d4
		bpl.s	loc_CC44
		cmpi.l	#$FFF00000,d4
		bge.s	loc_CC52
		move.l	#$FFF00000,d4
		bra.s	loc_CC52
; ---------------------------------------------------------------------------

loc_CC44:				; CODE XREF: sub_CBC0+72j
		cmpi.l	#$100000,d4
		bcs.s	loc_CC52
		move.l	#$100000,d4

loc_CC52:				; CODE XREF: sub_CBC0+7Aj sub_CBC0+82j ...
		add.l	d3,8(a6)
		add.l	d4,$C(a6)
		rts
; End of function sub_CBC0


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to create spawning rings when a player is hurt.
; ---------------------------------------------------------------------------

SpawnBouncingRings:					; Offset: 0000CC5C
		move.w	#$0288,d6				; set starting sinewave position (top)
	;	moveq	#$1F,d7					; set number of rings to be spawned to $20 ($1F + 1 for first run) [32 rings]

SBR_Loop:						; Offset: 0000CC62
		moveq	#$0C,d0					; set to read the 3rd Object Ram section
		jsr	Objects_FindFreeSlot			; check if there's any free space for the object
		bmi.s	SBR_Return				; if not, branch
		move.w	#$0080,$04(a0)
		move.w	#$0028,$06(a0)
		move.w	#$0028,$06(a0)
		move.w	#$00FF,$26(a0)				; set time until rings get deleted to $FF frames
		move.w	$08(a6),$08(a0)				; move ring to character on the X axis
		move.w	$0C(a6),$0C(a0)				; move ring to character on the Y axis
		move.w	d6,d2					; copy sinewave position to d2
		bmi.s	SBR_MultiSkip				; if still negative, branch
		jsr	CalcSine				; calculate the correct circular sinewave based on d2
		lsr.w	#$08,d2					; divide by 100
		ext.l	d0					; set word signed for Y speed
		ext.l	d1					; set word signed for X speed
		asl.l	#$02,d0					; multiply Y speed by 4
		asl.l	#$02,d1					; multiply X speed by 4
		asl.l	d2,d0					; multiply Y speed by d2 amount
		asl.l	d2,d1					; multiply X speed by d2 amount
		move.l	d0,d3					; copy Y speed to d3
		move.l	d1,d4					; copy X speed to d4
		addi.b	#$10,d6					; increase sinewave value (circularing the ring's directions)
		bcc.s	SBR_MultiSkip
		subi.w	#$0080,d6				; decrease by 80 (for inner rings)
		bcc.s	SBR_MultiSkip
		move.w	#$0288,d6				; reset starting sinewave position

SBR_MultiSkip:						; Offset: 0000CCB8
		move.l	d4,$18(a0)				; save the X speed of the ring
		move.l	d3,$1C(a0)				; save the Y speed of the ring
		neg.l	d4					; negate the X speed the opposite direction
		neg.w	d6					; negate the sinewave position
		dbf	d7,SBR_Loop				; repeat for all 20 rings

SBR_Return:						; Offset: 0000CCC8
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control the screen and characters positions related to the
; Combi.
; ---------------------------------------------------------------------------

Control_Combi:
		movea.w	($FFFFD862).w,a0			; load Sonic's ram address to a0
		movea.w	($FFFFD864).w,a1			; load Tails's ram address to a1
		move.w	$08(a0),d0				; load Sonic's X position to d0
		ext.l	d0					; set as signed word
		move.w	$08(a1),d1				; load Tails's X position to d1
		ext.l	d1					; set as signed word
	if	Combi	=	1
		add.l	d1,d0					; add both X positions together
		lsr.l	#$01,d0					; divide by 2
	else
	endif
		subi.w	#$00A0,d0				; decrease by half the screen's X size
		move.w	d0,($FFFFD830).w			; save to Screen's X position
		move.w	$0C(a0),d0				; load Sonic's Y position to d0
		ext.l	d0					; set as signed word
		move.w	$0C(a1),d1				; load Tails's Y position to d1
		ext.l	d1					; set as signed word
	if	Combi	=	1
		add.l	d1,d0					; add both Y positions together
		lsr.l	#$01,d0					; divide by 2
	else
	endif
		subi.w	#$0070,d0				; decrease by half the screen's Y size
		move.w	d0,($FFFFD832).w			; save to Screen's new Y position
		lea	Combi_StrainData(pc),a2			; load strain data table to a2
		moveq	#$00,d0					; clear d0

	; $2E = probably a magnified distance to pull the characters together by
	
		move.w	d0,$2E(a0)				; Clear Sonic's ??
		move.w	d0,$2E(a1)				; Clear Tails's ??
		move.w	$08(a0),d1				; load Sonic's X position to d1
		move.w	$0C(a0),d2				; load Sonic's Y position to d2
		move.w	$08(a1),d3				; load Tails's X position to d3
		move.w	$0C(a1),d4				; load Tails's Y position to d4
		jsr	CalcAngle				; get the correct angle based on the X and Y positions
		move.b	d0,$2B(a0)				; set pull angle for sonic
		addi.b	#-$80,d0				; increase by -80 to set it opposite
		move.b	d0,$2B(a1)				; set pull angle for tails
		sub.w	d3,d1					; minus Tails's X position from Sonic's
		sub.w	d4,d2					; minus Tails's Y position from sonic's
		muls.w	d1,d1					; multiply the X position by itself
		muls.w	d2,d2					; multiply the Y position by itself
		add.l	d2,d1					; add X pos to Y pos
		move.l	d1,d0					; copy to d0
		jsr	Calc360					; get the distance between Sonic and Tails
		move.w	d0,($FFFFFAE0).w
		move.w	d0,d3					; copy the distance to d3
		sub.w	(a2),d3					; decrease by "in" distance
		bmi.w	CC_SkipInStrain				; if negative, branch (Sonic and Tails are too close to each other)
		cmp.w	$02(a2),d3				; are Sonic and Tails too far appart? (comparing with "out" distance)
		bcs.s	CC_SkipOutStrain			; if not, branch
	if	Combi	=	1
	else
		rts
	endif
; ---------------------------------------------------------------------------
; Out strain (Stopping Sonic and Tails from moving further than a set line)
; ---------------------------------------------------------------------------

		move.w	$02(a2),d3				; load "out" distance to d3
		move.b	$2B(a0),d2				; load Sonic's pull angle
		addi.b	#-$80,d2				; increase by -80
		jsr	CalcSine				; collect the correct sinewave positions
		move.w	(a2),d2					; load "in" distance to d2
		add.w	2(a2),d2				; add "out" distance to d2
		muls.w	d2,d0					; multiply the X sinewave position by distances
		muls.w	d2,d1					; multiply the Y sinewave position by distances
		asl.l	#$02,d0					; multiply X by 2
		asl.l	#$02,d1					; multiply Y by 2
		add.l	$08(a1),d0				; add Tails's X position
		add.l	$0C(a1),d1				; add Tails's Y position
		move.l	d0,$08(a0)				; save to Sonic's X position
		move.l	d1,$0C(a0)				; save to Sonic's Y position

; ---------------------------------------------------------------------------
; In Strain (Pulling Sonic and Tails together towards the centre
; ---------------------------------------------------------------------------

CC_SkipOutStrain:
		andi.w	#$00FF,d3				; clear left byte of distance
		move.b	$04(a2,d3.w),d3				; collect correct speed based on the distance between the characters
		addq.w	#$01,d3					; increase by 1 (making it odd)
		lsl.w	#$03,d3					; multiply by 8
		move.b	$2B(a0),d2
		move.b	($FFFFD89E).w,d4			; load controls
		andi.b	#$0F,d4					; get only D-Pad buttons
		bne.w	loc_CE32				; if none of the D-Pad buttons were pressedn, branch
		btst	#$00,$25(a0)				; is sonic in strain mode?
		bne.s	loc_CDBC				; if not, branch
		jsr	CalcSine				; collect the correct sinewave positions
		muls.w	d3,d0					; multiply the X sinewave position by the speed data
		muls.w	d3,d1					; multiply the Y sinewave position by the speed data
		asr.l	#6,d0					; divide by X 40
		asr.l	#6,d1					; divide by Y 40
		add.l	d0,$18(a0)				; save X to Sonic's X speed
		add.l	d1,$1C(a0)				; save Y to Sonic's Y speed
		bra.w	loc_CE36
; ---------------------------------------------------------------------------

loc_CDBC:
		sub.b	$2A(a0),d2
		cmpi.b	#$A0,d2
		bcs.w	loc_CE14
		cmpi.b	#$E0,d2
		bhi.w	loc_CE14
		move.b	#8,7(a0)
		move.b	$2A(a0),d2
		btst	#3,$25(a0)
		beq.s	loc_CDE6
		addi.b	#-$80,d2

loc_CDE6:				; CODE XREF: Control_Combi+116j
		jsr	CalcSine
		move.w	$2C(a0),d2
		muls.w	d2,d0
		muls.w	d2,d1
		move.l	d0,d4
		move.l	d1,d5
		move.b	$2B(a0),d2
		jsr	CalcSine
		muls.w	d3,d0
		muls.w	d3,d1
		add.l	d4,d0
		add.l	d5,d1
		asr.l	#6,d0
		asr.l	#6,d1
		move.l	d0,$18(a0)
		move.l	d1,$1C(a0)
		bra.s	loc_CE36
; ---------------------------------------------------------------------------

loc_CE14:				; CODE XREF: Control_Combi+FAj
					; Control_Combi+102j
		jsr	CalcSine
		muls.w	d3,d0
		lsl.l	#2,d0
		swap	d0
		btst	#3,$25(a0)
		beq.s	loc_CE2C
		sub.w	d0,$2C(a0)
		bra.s	loc_CE36
; ---------------------------------------------------------------------------

loc_CE2C:				; CODE XREF: Control_Combi+15Aj
		add.w	d0,$2C(a0)
		bra.s	loc_CE36
; ---------------------------------------------------------------------------

loc_CE32:				; CODE XREF: Control_Combi+CEj
		move.w	d3,$2E(a0)

loc_CE36:				; CODE XREF: Control_Combi+EEj
					; Control_Combi+148j ...
		move.b	$2B(a1),d2
		tst.b	($FFFFD8AC).w
		bmi.s	loc_CE4E
		move.b	($FFFFD8AE).w,d4
		andi.b	#$F,d4
		bne.w	loc_CEEE
		bra.s	loc_CE5A
; ---------------------------------------------------------------------------

loc_CE4E:				; CODE XREF: Control_Combi+174j
		move.b	($FFFFD89E).w,d4
		andi.b	#$70,d4	; 'p'
		bne.w	loc_CEEE

loc_CE5A:				; CODE XREF: Control_Combi+182j
		btst	#0,$25(a1)
		bne.s	loc_CE78
		jsr	CalcSine
		muls.w	d3,d0
		muls.w	d3,d1
		asr.l	#6,d0
		asr.l	#6,d1
		add.l	d0,$18(a1)
		add.l	d1,$1C(a1)
		bra.s	CC_SkipInStrain
; ---------------------------------------------------------------------------

loc_CE78:				; CODE XREF: Control_Combi+196j
		sub.b	$2A(a1),d2
		cmpi.b	#$A0,d2
		bcs.w	loc_CED0
		cmpi.b	#$E0,d2
		bhi.w	loc_CED0
		move.b	#8,7(a1)
		move.b	$2A(a1),d2
		btst	#3,$25(a1)
		beq.s	loc_CEA2
		addi.b	#-$80,d2

loc_CEA2:				; CODE XREF: Control_Combi+1D2j
		jsr	CalcSine
		move.w	$2C(a1),d2
		muls.w	d2,d0
		muls.w	d2,d1
		move.l	d0,d4
		move.l	d1,d5
		move.b	$2B(a1),d2
		jsr	CalcSine
		muls.w	d3,d0
		muls.w	d3,d1
		add.l	d4,d0
		add.l	d5,d1
		asr.l	#6,d0
		asr.l	#6,d1
		move.l	d0,$18(a1)
		move.l	d1,$1C(a1)
		bra.s	CC_SkipInStrain
; ---------------------------------------------------------------------------

loc_CED0:				; CODE XREF: Control_Combi+1B6j
					; Control_Combi+1BEj
		jsr	CalcSine
		muls.w	d3,d0
		lsl.l	#2,d0
		swap	d0
		btst	#3,$25(a1)
		beq.s	loc_CEE8
		sub.w	d0,$2C(a1)
		bra.s	CC_SkipInStrain
; ---------------------------------------------------------------------------

loc_CEE8:				; CODE XREF: Control_Combi+216j
		add.w	d0,$2C(a1)
		bra.s	CC_SkipInStrain
; ---------------------------------------------------------------------------

loc_CEEE:				; CODE XREF: Control_Combi+17Ej
					; Control_Combi+18Cj
		move.w	d3,$2E(a1)

CC_SkipInStrain:				; CODE XREF: Control_Combi+7Ej
					; Control_Combi+1ACj ...
		movea.w	($FFFFD854).w,a0
		movea.w	($FFFFD862).w,a1
		movea.w	($FFFFD864).w,a2
		move.l	8(a2),d1
		move.l	8(a1),d3
		sub.l	d1,d3
		asr.l	#3,d3
		move.l	$C(a2),d2
		move.l	$C(a1),d4
		sub.l	d2,d4
		asr.l	#3,d4
		btst	#0,($FFFFF001).w
		beq.s	loc_CF2A
		move.l	d3,d5
		move.l	d4,d6
		asr.l	#1,d5
		asr.l	#1,d6
		add.l	d5,d1
		add.l	d6,d2

loc_CF2A:				; CODE XREF: Control_Combi+252j
		addq.w	#2,$24(a0)
		move.w	$24(a0),d5
		lea	loc_CF90(pc),a3
		andi.w	#$1E,d5
		tst.w	(a3,d5.w)
		bpl.s	loc_CF46
		moveq	#0,d5
		move.w	d5,$24(a0)

loc_CF46:				; CODE XREF: Control_Combi+274j
		lea	($FFFFD854).w,a0

loc_CF4A:				; CODE XREF: Control_Combi+2BEj
					; Control_Combi+2C2j
		move.w	(a0),d0
		beq.s	locret_CF8E
		movea.w	d0,a0
		move.l	d1,8(a0)
		move.l	d2,$C(a0)
		add.l	d3,d1
		add.l	d4,d2
		move.w	(a3,d5.w),d0
		btst	#0,($FFFFF001).w
		bne.s	loc_CF74
		tst.w	$20(a1)
		bpl.s	loc_CF7E
		ori.w	#$8000,d0
		bra.s	loc_CF7E
; ---------------------------------------------------------------------------

loc_CF74:				; CODE XREF: Control_Combi+29Cj
		tst.w	$20(a2)
		bpl.s	loc_CF7E
		ori.w	#$8000,d0

loc_CF7E:				; CODE XREF: Control_Combi+2A2j
					; Control_Combi+2A8j ...
		move.w	d0,$20(a0)
		addq.w	#2,d5
		tst.w	(a3,d5.w)
		bpl.s	loc_CF4A
		moveq	#0,d5
		bra.s	loc_CF4A
; ---------------------------------------------------------------------------

locret_CF8E:				; CODE XREF: Control_Combi+282j
		rts
; End of function Control_Combi

; ---------------------------------------------------------------------------
loc_CF90:	dc.w	$5C2		; DATA XREF: Control_Combi+268o
		dc.w	$5C2
		dc.w	$5C6
		dc.w	$5C6
		dc.w	$5CA
		dc.w	$5CA
		dc.w	$5C6
		dc.w	$5C6
		dc.w	$5C2
		dc.w	$5C2
		dc.w	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.w	$FFFF
		dc.w	$FFFF
		dc.w	$5C2
		dc.w	$5C6
		dc.w	$5CA
		dc.w	$5CE
		dc.w	$5D2
		dc.w	$5CE
		dc.w	$5CA
		dc.w	$5C6
		dc.w	$5C2
		dc.w	0
		dc.w	0
		dc.w	0
		dc.w	0
		dc.w	$FFFF
		dc.w	$FFFF
		dc.w	$FFFF

; ===========================================================================
; ---------------------------------------------------------------------------
; Strain Distance and Speed Values
; ---------------------------------------------------------------------------
; Distances:
;
;	0080 = distance to check for inside the circle
;	007F = distance to check for outside the circle)
;
; The data after it is the speed (strain power) to pull the characters
; together by, the further away they are, the further along the data the
; engine will read.
; ---------------------------------------------------------------------------

Combi_StrainData:
	if	Combi	=	1
		dc.w	$0080,$007F
		dc.b	$00,$02,$04,$06,$08,$0A,$0C,$0E
		dc.b	$10,$12,$14,$16,$18,$1A,$1C,$1E
		dc.b	$20,$22,$24,$26,$28,$2A,$2C,$2E
		dc.b	$30,$32,$34,$36,$38,$3A,$3C,$3E
		dc.b	$40,$42,$44,$46,$48,$4A,$4C,$4E
		dc.b	$50,$52,$54,$56,$58,$5A,$5C,$5E
		dc.b	$60,$62,$64,$66,$68,$6A,$6C,$6E
		dc.b	$70,$72,$74,$76,$78,$7A,$7C,$7E
		dc.b	$80,$82,$84,$86,$88,$8A,$8C,$8E
		dc.b	$90,$92,$94,$96,$98,$9A,$9C,$9E
		dc.b	$A0,$A2,$A4,$A6,$A8,$AA,$AC,$AE
		dc.b	$B0,$B2,$B4,$B6,$B8,$BA,$BC,$BE
		dc.b	$C0,$C2,$C4,$C6,$C8,$CA,$CC,$CE
		dc.b	$D0,$D2,$D4,$D6,$D8,$DA,$DC,$DE
		dc.b	$E0,$E2,$E4,$E6,$E8,$EA,$EC,$EE
		dc.b	$F0,$F2,$F4,$F6,$F8,$FA,$FC,$FE
	else
		dc.w	$0080,$0000
		dc.b	$00,$00,$00,$00,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	endif
		even
; ---------------------------------------------------------------------------
; For some reason, this data is repeated 4 times even though it doesn't
; appear to be used.
; ---------------------------------------------------------------------------
		dc.w	$0080,$007F
		dc.b	$00,$02,$04,$06,$08,$0A,$0C,$0E
		dc.b	$10,$12,$14,$16,$18,$1A,$1C,$1E
		dc.b	$20,$22,$24,$26,$28,$2A,$2C,$2E
		dc.b	$30,$32,$34,$36,$38,$3A,$3C,$3E
		dc.b	$40,$42,$44,$46,$48,$4A,$4C,$4E
		dc.b	$50,$52,$54,$56,$58,$5A,$5C,$5E
		dc.b	$60,$62,$64,$66,$68,$6A,$6C,$6E
		dc.b	$70,$72,$74,$76,$78,$7A,$7C,$7E
		dc.b	$80,$82,$84,$86,$88,$8A,$8C,$8E
		dc.b	$90,$92,$94,$96,$98,$9A,$9C,$9E
		dc.b	$A0,$A2,$A4,$A6,$A8,$AA,$AC,$AE
		dc.b	$B0,$B2,$B4,$B6,$B8,$BA,$BC,$BE
		dc.b	$C0,$C2,$C4,$C6,$C8,$CA,$CC,$CE
		dc.b	$D0,$D2,$D4,$D6,$D8,$DA,$DC,$DE
		dc.b	$E0,$E2,$E4,$E6,$E8,$EA,$EC,$EE
		dc.b	$F0,$F2,$F4,$F6,$F8,$FA,$FC,$FE
		even
; ---------------------------------------------------------------------------
		dc.w	$0080,$007F
		dc.b	$00,$02,$04,$06,$08,$0A,$0C,$0E
		dc.b	$10,$12,$14,$16,$18,$1A,$1C,$1E
		dc.b	$20,$22,$24,$26,$28,$2A,$2C,$2E
		dc.b	$30,$32,$34,$36,$38,$3A,$3C,$3E
		dc.b	$40,$42,$44,$46,$48,$4A,$4C,$4E
		dc.b	$50,$52,$54,$56,$58,$5A,$5C,$5E
		dc.b	$60,$62,$64,$66,$68,$6A,$6C,$6E
		dc.b	$70,$72,$74,$76,$78,$7A,$7C,$7E
		dc.b	$80,$82,$84,$86,$88,$8A,$8C,$8E
		dc.b	$90,$92,$94,$96,$98,$9A,$9C,$9E
		dc.b	$A0,$A2,$A4,$A6,$A8,$AA,$AC,$AE
		dc.b	$B0,$B2,$B4,$B6,$B8,$BA,$BC,$BE
		dc.b	$C0,$C2,$C4,$C6,$C8,$CA,$CC,$CE
		dc.b	$D0,$D2,$D4,$D6,$D8,$DA,$DC,$DE
		dc.b	$E0,$E2,$E4,$E6,$E8,$EA,$EC,$EE
		dc.b	$F0,$F2,$F4,$F6,$F8,$FA,$FC,$FE
		even
; ---------------------------------------------------------------------------
		dc.w	$0080,$007F
		dc.b	$00,$02,$04,$06,$08,$0A,$0C,$0E
		dc.b	$10,$12,$14,$16,$18,$1A,$1C,$1E
		dc.b	$20,$22,$24,$26,$28,$2A,$2C,$2E
		dc.b	$30,$32,$34,$36,$38,$3A,$3C,$3E
		dc.b	$40,$42,$44,$46,$48,$4A,$4C,$4E
		dc.b	$50,$52,$54,$56,$58,$5A,$5C,$5E
		dc.b	$60,$62,$64,$66,$68,$6A,$6C,$6E
		dc.b	$70,$72,$74,$76,$78,$7A,$7C,$7E
		dc.b	$80,$82,$84,$86,$88,$8A,$8C,$8E
		dc.b	$90,$92,$94,$96,$98,$9A,$9C,$9E
		dc.b	$A0,$A2,$A4,$A6,$A8,$AA,$AC,$AE
		dc.b	$B0,$B2,$B4,$B6,$B8,$BA,$BC,$BE
		dc.b	$C0,$C2,$C4,$C6,$C8,$CA,$CC,$CE
		dc.b	$D0,$D2,$D4,$D6,$D8,$DA,$DC,$DE
		dc.b	$E0,$E2,$E4,$E6,$E8,$EA,$EC,$EE
		dc.b	$F0,$F2,$F4,$F6,$F8,$FA,$FC,$FE
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load the Combi stars (Tether)
; ---------------------------------------------------------------------------

Combi_LoadStars:
		moveq	#$07,d7					; set repeat times (Number of combi star segments)

CLS_Repeat:
		moveq	#$08,d0					; set to read the 2nd Object Ram section
		jsr	Objects_FindFreeSlot			; find a free object space
		bmi.s	CLS_NoSpace				; if none are available, branch
		move.w	#$0080,$04(a0)
		move.w	#$0800,$06(a0)
		move.l	#Map_Combi,$10(a0)			; set mappings to use
		dbf	d7,CLS_Repeat				; repeat til all 8 segments have loaded

CLS_NoSpace:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Combi Mappings
; ---------------------------------------------------------------------------
Map_Combi:	dc.b $00,$FC,$00,$00,$FC,$FF
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to run object routines during the game (<< Maybe Slightly incorrect, but what the hell for now)
; ---------------------------------------------------------------------------

RunObjects:
		lea	($FFFFD858).w,a6

RO_NextObj:
		move.w  $00(a6),d0				; load ram address of next object to d0
		bne.s	RO_ValidObj				; if not null, an object is in the slot, so branch
		rts						; return

RO_ValidObj:
		movea.w	d0,a6					; move ram address to a6
		moveq	#$00,d0					; clear d0
		move.w	$06(a6),d0				; load object's ID
		jsr	RO_Routines(pc,d0.w)			; jump to the correct object routine
		bra.s	RO_NextObj				; loop

; ---------------------------------------------------------------------------
; Object Routines List
; ---------------------------------------------------------------------------

RO_Routines:
		bra.w	Obj_RedSpring_Right		; Object 00 - Red Spring Right
		bra.w	Obj_RedSpring_Left		; Object 04 - Red Spring Left
		bra.w	Obj_RedSpring_Up		; Object 08 - Red Spring Up
		bra.w	Obj_RedSpring_Down		; Object 0C - Red Spring Down
		bra.w	ObjGoal					; Object 10 - Nothing
		bra.w	Obj_DiagRedSprng_RU		; Object 14 - Diagonal Red Spring Right Up
		bra.w	Obj_DiagRedSprng_LU		; Object 18 - Diagonal Red Spring Left Up
		bra.w	Obj_DiagRedSprng_RD		; Object 1C - Diagonal Red Spring Right Down
		bra.w	Obj_DiagRedSprng_LD		; Object 20 - Diagonal Red Spring Left Up
		bra.w	ObjMonitor					; Object 24 - Nothing
		bra.w	Obj_LostRings			; Object 28 - Lost Rings
		bra.w	NullObj					; Object 2C - Nothing
		bra.w	NullObj					; Object 30 - Nothing
		bra.w	Obj_YelSpring_Right		; Object 34 - Yellow Spring Right
		bra.w	Obj_YelSpring_Left		; Object 38 - Yellow Spring Left
		bra.w	Obj_YelSpring_Up		; Object 3C - Yellow Spring Up
		bra.w	Obj_YelSpring_Down		; Object 40 - Yellow Spring Down
		bra.w	Obj_DiagYelSprng_RU		; Object 44 - Diagonal Yellow Spring Right Up
		bra.w	Obj_DiagYelSprng_LU		; Object 48 - Diagonal Yellow Spring Left Up
		bra.w	Obj_DiagYelSprng_RD		; Object 4C - Diagonal Yellow Spring Right Down
		bra.w	Obj_DiagYelSprng_LD		; Object 50 - Diagonal Yellow Spring Left Up
		bra.w	Obj_SpikesUp			; Object 54 - Spikes Up
		bra.w	Obj_SpikesDown			; Object 58 - Spikes Down
		bra.w	Obj_SpikesRight			; Object 5C - Spikes Right
		bra.w	Obj_SpikesLeft			; Object 60 - Spikes Left
		bra.w	Obj_DiagSpik_RU			; Object 64 - Diagonal Springs Right Up
		bra.w	Obj_DiagSpik_LU			; Object 68 - Diagonal Springs Left Up
		bra.w	Obj_DiagSpik_RD			; Object 6C - Diagonal Springs Right Down
		bra.w	Obj_DiagSpik_LD			; Object 70 - Diagonal Springs Left Down
		bra.w	loc_E356				; Object 74 - some sort of path swapper
		bra.w	loc_E45A				; Object 78 - some sort of path swapper
		bra.w	NullObj					; Object 7C - Nothing
		bra.w	NullObj					; Object 80 - Nothing
; ---------------------------------------------------------------------------
; ===========================================================================

NullObj:
	rts

	include		"Objects/Goal.asm"
	include		"Objects/Monitor.asm"
	include		"Objects/Red Spring Right.asm"
	include		"Objects/Red Spring Left.asm"
	include		"Objects/Red Spring Up.asm"
	include		"Objects/Red Spring Down.asm"
	include		"Objects/Red Diagonal Spring Right-Up.asm"
	include		"Objects/Red Diagonal Spring Left-Up.asm"
	include		"Objects/Red Diagonal Spring Right-Down.asm"
	include		"Objects/Red Diagonal Spring Left-Down.asm"
	include		"Objects/Yellow Spring Right.asm"
	include		"Objects/Yellow Spring Left.asm"
	include		"Objects/Yellow Spring Up.asm"
	include		"Objects/Yellow Spring Down.asm"
	include		"Objects/Yellow Diagonal Spring Right-Up.asm"
	include		"Objects/Yellow Diagonal Spring Left-Up.asm"
	include		"Objects/Yellow Diagonal Spring Right-Down.asm"
	include		"Objects/Yellow Diagonal Spring Left-Down.asm"

	include		"PLCMAPANI/ANI_Springs.asm"

	include		"Objects/Lost Rings.asm"

Obj_SpikesUp:				; CODE XREF: ROM:0000D278j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_E526
		move.l	#Map_SpikesUpLrg,$10(a6)
		move.w	#$23BF,$20(a6)
		move.w	#$8080,4(a6)
		move.b	#$10,$22(a6)
		move.b	#$10,$23(a6)

loc_E526:				; CODE XREF: ROM:0000E504j
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E560
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#7,d4
		beq.s	loc_E558
		cmpi.w	#6,d4
		beq.s	loc_E558
		bra.s	loc_E560
; ---------------------------------------------------------------------------

loc_E558:				; CODE XREF: ROM:0000E54Ej
					; ROM:0000E554j
		moveq	#1,d0
		jsr	(HurtPlayer).l
		add.b	#1,$FFFFA000

loc_E560:				; CODE XREF: ROM:0000E534j
					; ROM:0000E556j
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E59A
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#7,d4
		beq.s	loc_E592
		cmpi.w	#6,d4
		beq.s	loc_E592
		bra.s	loc_E59A
; ---------------------------------------------------------------------------

loc_E592:				; CODE XREF: ROM:0000E588j
					; ROM:0000E58Ej
		moveq	#1,d0
		jsr	(HurtPlayer).l
		add.b	#1,$FFFFA000

loc_E59A:				; CODE XREF: ROM:0000E56Ej
					; ROM:0000E590j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_E5A4
		bsr.w	DeleteSprite

locret_E5A4:				; CODE XREF: ROM:0000E59Ej
		rts
; ---------------------------------------------------------------------------

Obj_SpikesDown:				; CODE XREF: ROM:0000D27Cj
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_E5CE
		move.l	#Map_SpikesUpLrg,$10(a6)
		move.w	#$33BF,$20(a6)
		move.w	#$8080,4(a6)
		move.b	#$10,$22(a6)
		move.b	#$10,$23(a6)

loc_E5CE:				; CODE XREF: ROM:0000E5ACj
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E608
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#5,d4
		beq.s	loc_E600
		cmpi.w	#4,d4
		beq.s	loc_E600
		bra.s	loc_E608
; ---------------------------------------------------------------------------

loc_E600:				; CODE XREF: ROM:0000E5F6j
					; ROM:0000E5FCj
		moveq	#1,d0
		jsr	(HurtPlayer).l
		add.b	#1,$FFFFA000

loc_E608:				; CODE XREF: ROM:0000E5DCj
					; ROM:0000E5FEj
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E642
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#5,d4
		beq.s	loc_E63A
		cmpi.w	#4,d4
		beq.s	loc_E63A
		bra.s	loc_E642
; ---------------------------------------------------------------------------

loc_E63A:				; CODE XREF: ROM:0000E630j
					; ROM:0000E636j
		moveq	#1,d0
		jsr	(HurtPlayer).l
		add.b	#1,$FFFFA000

loc_E642:				; CODE XREF: ROM:0000E616j
					; ROM:0000E638j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_E64C
		bsr.w	DeleteSprite

locret_E64C:				; CODE XREF: ROM:0000E646j
		rts
; ---------------------------------------------------------------------------

Obj_SpikesRight:				; CODE XREF: ROM:0000D280j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_E676
		move.l	#Map_SpikesLR,$10(a6)
		move.w	#$23BF,$20(a6)
		move.w	#$8080,4(a6)
		move.b	#$10,$22(a6)
		move.b	#$10,$23(a6)

loc_E676:				; CODE XREF: ROM:0000E654j
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E6B0
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#2,d4
		beq.s	loc_E6A8
		cmpi.w	#0,d4
		beq.s	loc_E6A8
		bra.s	loc_E6B0
; ---------------------------------------------------------------------------

loc_E6A8:				; CODE XREF: ROM:0000E69Ej
					; ROM:0000E6A4j
		moveq	#1,d0
		jsr	(HurtPlayer).l

loc_E6B0:				; CODE XREF: ROM:0000E684j
					; ROM:0000E6A6j
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E6EA
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#2,d4
		beq.s	loc_E6E2
		cmpi.w	#0,d4
		beq.s	loc_E6E2
		bra.s	loc_E6EA
; ---------------------------------------------------------------------------

loc_E6E2:				; CODE XREF: ROM:0000E6D8j
					; ROM:0000E6DEj
		moveq	#1,d0
		jsr	(HurtPlayer).l

loc_E6EA:				; CODE XREF: ROM:0000E6BEj
					; ROM:0000E6E0j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_E6F4
		bsr.w	DeleteSprite

locret_E6F4:				; CODE XREF: ROM:0000E6EEj
		rts
; ---------------------------------------------------------------------------


Obj_SpikesLeft:				; CODE XREF: ROM:0000D284j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_E71E
		move.l	#Map_SpikesLR,$10(a6)
		move.w	#$2BBF,$20(a6)
		move.w	#$8080,4(a6)
		move.b	#$10,$22(a6)
		move.b	#$10,$23(a6)

loc_E71E:				; CODE XREF: ROM:0000E6FCj
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E758
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#1,d4
		beq.s	loc_E750
		cmpi.w	#3,d4
		beq.s	loc_E750
		bra.s	loc_E758
; ---------------------------------------------------------------------------

loc_E750:				; CODE XREF: ROM:0000E746j
					; ROM:0000E74Cj
		moveq	#1,d0
		jsr	(HurtPlayer).l

loc_E758:				; CODE XREF: ROM:0000E72Cj
					; ROM:0000E74Ej
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E792
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#1,d4
		beq.s	loc_E78A
		cmpi.w	#3,d4
		beq.s	loc_E78A
		bra.s	loc_E792
; ---------------------------------------------------------------------------

loc_E78A:				; CODE XREF: ROM:0000E780j
					; ROM:0000E786j
		moveq	#1,d0
		jsr	(HurtPlayer).l

loc_E792:				; CODE XREF: ROM:0000E766j
					; ROM:0000E788j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_E79C
		bsr.w	DeleteSprite

locret_E79C:				; CODE XREF: ROM:0000E796j
		rts
; ---------------------------------------------------------------------------

Obj_DiagSpik_RU:				; CODE XREF: ROM:0000D288j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_E7C6
		move.l	#Map_SpikesAng,$10(a6)
		move.w	#$2BBF,$20(a6)
		move.w	#$8080,4(a6)
		move.b	#$C,$22(a6)
		move.b	#$C,$23(a6)

loc_E7C6:				; CODE XREF: ROM:0000E7A4j
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E800
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#6,d4
		beq.s	loc_E7F8
		cmpi.w	#2,d4
		beq.s	loc_E7F8
		bra.s	loc_E800
; ---------------------------------------------------------------------------

loc_E7F8:				; CODE XREF: ROM:0000E7EEj
					; ROM:0000E7F4j
		moveq	#1,d0
		jsr	(HurtPlayer).l

loc_E800:				; CODE XREF: ROM:0000E7D4j
					; ROM:0000E7F6j
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E83A
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#6,d4
		beq.s	loc_E832
		cmpi.w	#2,d4
		beq.s	loc_E832
		bra.s	loc_E83A
; ---------------------------------------------------------------------------

loc_E832:				; CODE XREF: ROM:0000E828j
					; ROM:0000E82Ej
		moveq	#1,d0
		jsr	(HurtPlayer).l

loc_E83A:				; CODE XREF: ROM:0000E80Ej
					; ROM:0000E830j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_E844
		bsr.w	DeleteSprite

locret_E844:				; CODE XREF: ROM:0000E83Ej
		rts
; ---------------------------------------------------------------------------

Obj_DiagSpik_LU:				; CODE XREF: ROM:0000D28Cj
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_E86E
		move.l	#Map_SpikesAng,$10(a6)
		move.w	#$23BF,$20(a6)
		move.w	#$8080,4(a6)
		move.b	#$C,$22(a6)
		move.b	#$C,$23(a6)

loc_E86E:				; CODE XREF: ROM:0000E84Cj
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E8A8
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#7,d4
		beq.s	loc_E8A0
		cmpi.w	#3,d4
		beq.s	loc_E8A0
		bra.s	loc_E8A8
; ---------------------------------------------------------------------------

loc_E8A0:				; CODE XREF: ROM:0000E896j
					; ROM:0000E89Cj
		moveq	#1,d0
		jsr	(HurtPlayer).l

loc_E8A8:				; CODE XREF: ROM:0000E87Cj
					; ROM:0000E89Ej
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E8E2
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#7,d4
		beq.s	loc_E8DA
		cmpi.w	#3,d4
		beq.s	loc_E8DA
		bra.s	loc_E8E2
; ---------------------------------------------------------------------------

loc_E8DA:				; CODE XREF: ROM:0000E8D0j
					; ROM:0000E8D6j
		moveq	#1,d0
		jsr	(HurtPlayer).l

loc_E8E2:				; CODE XREF: ROM:0000E8B6j
					; ROM:0000E8D8j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_E8EC
		bsr.w	DeleteSprite

locret_E8EC:				; CODE XREF: ROM:0000E8E6j
		rts
; ---------------------------------------------------------------------------

Obj_DiagSpik_RD:				; CODE XREF: ROM:0000D290j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_E916
		move.l	#Map_SpikesAng,$10(a6)
		move.w	#$3BBF,$20(a6)
		move.w	#$8080,4(a6)
		move.b	#$C,$22(a6)
		move.b	#$C,$23(a6)

loc_E916:				; CODE XREF: ROM:0000E8F4j
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E950
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#0,d4
		beq.s	loc_E948
		cmpi.w	#4,d4
		beq.s	loc_E948
		bra.s	loc_E950
; ---------------------------------------------------------------------------

loc_E948:				; CODE XREF: ROM:0000E93Ej
					; ROM:0000E944j
		moveq	#1,d0
		jsr	(HurtPlayer).l

loc_E950:				; CODE XREF: ROM:0000E924j
					; ROM:0000E946j
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E98A
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#0,d4
		beq.s	loc_E982
		cmpi.w	#4,d4
		beq.s	loc_E982
		bra.s	loc_E98A
; ---------------------------------------------------------------------------

loc_E982:				; CODE XREF: ROM:0000E978j
					; ROM:0000E97Ej
		moveq	#1,d0
		jsr	(HurtPlayer).l

loc_E98A:				; CODE XREF: ROM:0000E95Ej
					; ROM:0000E980j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_E994
		bsr.w	DeleteSprite

locret_E994:				; CODE XREF: ROM:0000E98Ej
		rts
; ---------------------------------------------------------------------------

Obj_DiagSpik_LD:				; CODE XREF: ROM:0000D294j
		moveq	#7,d0
		bclr	d0,$28(a6)
		beq.s	loc_E9BE
		move.l	#Map_SpikesAng,$10(a6)
		move.w	#$33BF,$20(a6)
		move.w	#$8080,4(a6)
		move.b	#$C,$22(a6)
		move.b	#$C,$23(a6)

loc_E9BE:				; CODE XREF: ROM:0000E99Cj
		movea.w	($FFFFD862).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_E9F8
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#1,d4
		beq.s	loc_E9F0
		cmpi.w	#5,d4
		beq.s	loc_E9F0
		bra.s	loc_E9F8
; ---------------------------------------------------------------------------

loc_E9F0:				; CODE XREF: ROM:0000E9E6j
					; ROM:0000E9ECj
		moveq	#1,d0
		jsr	(HurtPlayer).l

loc_E9F8:				; CODE XREF: ROM:0000E9CCj
					; ROM:0000E9EEj
		movea.w	($FFFFD864).w,a0
		move.w	#$F,d0
		jsr	(SolidObject).l
		beq.s	loc_EA32
		move.w	8(a6),d0
		move.w	$C(a6),d1
		move.w	8(a0),d2
		move.w	$C(a0),d3
		bsr.w	Distance_GetSet
		cmpi.w	#1,d4
		beq.s	loc_EA2A
		cmpi.w	#5,d4
		beq.s	loc_EA2A
		bra.s	loc_EA32
; ---------------------------------------------------------------------------

loc_EA2A:				; CODE XREF: ROM:0000EA20j
					; ROM:0000EA26j
		moveq	#1,d0
		jsr	(HurtPlayer).l

loc_EA32:				; CODE XREF: ROM:0000EA06j
					; ROM:0000EA28j
		bsr.w	SpriteScreenCheck
		bcc.s	locret_EA3C
		bsr.w	DeleteSprite

locret_EA3C:				; CODE XREF: ROM:0000EA36j
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check the distance between an object and the character for
; solidiness (if touching the object, the solid values are returned)
; (d0 returns solid X position and d1 returns solid Y position)
; ---------------------------------------------------------------------------

SolidCheck:
		move.w	$08(a0),d0				; load character's X position
		move.w	$0C(a0),d1				; load character's Y position
		move.w	$08(a6),d2				; load object's X position
		move.w	$0C(a6),d3				; load object's Y position
		moveq	#$00,d4					; clear d4..
		moveq	#$00,d5					; ..and d5
		move.b	$22(a0),d4				; load width of character to d4
		move.b	$22(a6),d5				; load width of object to d5
		add.w	d5,d4					; add object's width to character's width
		move.w	d0,d5					; copy character's X position to d5
		sub.w	d2,d5					; minus object's X position
		bpl.s	SC_XChkPos				; if positive, branch
		neg.w	d5					; make it positive

SC_XChkPos:
		sub.w	d5,d4					; subtract it from width
		bpl.s	SC_YChk					; if still positive, branch (Character is within the Width)
		rts						; return (no touch)

SC_YChk:
		moveq	#$00,d6					; clear d6..
		moveq	#$00,d7					; ..and d7
		move.b	$23(a0),d6				; load height of character to d6
		move.b	$23(a6),d7				; load height of object to d7
		add.w	d7,d6					; add object's height to character's height
		move.w	d1,d7					; copy character's Y position to d7
		sub.w	d3,d7					; minus object's Y position
		bpl.s	SC_YChkPos				; if positive, branch
		neg.w	d7					; make it positive

SC_YChkPos:
		sub.w	d7,d6					; subtract it from height
		bpl.s	SC_Touch				; if still positive, branch (Character is within the height too)
		rts						; return (no touch)
; ---------------------------------------------------------------------------

SC_Touch:
		cmp.w	d4,d6					; is character closer to object on width than height?
		bcc.s	SC_XTouch				; if so, branch
		bsr.w	Solid_SetY				; get the solid Y position of object to d0
		move.w	d0,d1					; move to d1
		move.w	$08(a0),d0				; load character's X position
		rts

SC_XTouch:
		bsr.w	Solid_SetX				; get the solid X position of object to d0
		move.w	$0C(a0),d1				; load character's Y position
		rts						; return

; ===========================================================================


sub_EAA0:				; CODE XREF: ROM:0000E38Ep
					; ROM:0000E39Cp ...
		moveq	#0,d1
		move.b	$22(a0),d1
		moveq	#0,d2
		move.b	$22(a6),d2
		add.w	d2,d1
		move.w	8(a0),d0
		sub.w	8(a6),d0
		bpl.s	loc_EABA
		neg.w	d0

loc_EABA:				; CODE XREF: sub_EAA0+16j
		cmp.w	d1,d0
		bcs.s	loc_EAC0
		rts
; ---------------------------------------------------------------------------

loc_EAC0:				; CODE XREF: sub_EAA0+1Cj
		moveq	#0,d1
		move.b	$23(a0),d1
		moveq	#0,d2
		move.b	$23(a6),d2
		add.w	d2,d1
		move.w	$C(a0),d0
		sub.w	$C(a6),d0
		bpl.s	loc_EADA
		neg.w	d0

loc_EADA:				; CODE XREF: sub_EAA0+36j
		cmp.w	d1,d0
		rts
; End of function sub_EAA0


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to calculate the correct solid X position
; ---------------------------------------------------------------------------

Solid_SetX:
		moveq	#$00,d1					; clear d1
		move.b	$22(a0),d1				; load width of character to d1
		moveq	#$00,d2					; clear d2
		move.b	$22(a6),d2				; load width of object to d2
		add.w	d1,d2					; add character's width to object's width
		move.w	$08(a0),d0				; load character's X position to d0
		move.w	$08(a6),d1				; load object's X position to d1
		cmp.w	d0,d1					; compare them
		bpl.s	SSX_Pos					; if positive, branch
		neg.w	d2					; negate the width to positive

SSX_Pos:
		move.w	d1,d0					; reload object's X position
		sub.w	d2,d0					; minus the width
		rts						; retrun (d0 equals the new solid X position)

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to calculate the correct solid Y position
; ---------------------------------------------------------------------------

Solid_SetY:
		moveq	#$00,d1					; clear d1
		move.b	$23(a0),d1				; load height of character to d1
		moveq	#$00,d2					; clear d2
		move.b	$23(a6),d2				; load height of object to d2
		add.w	d1,d2					; add character's height to object's height
		move.w	$0C(a0),d0				; load Y position of character
		move.w	$0C(a6),d1				; load Y position of object
		cmp.w	d0,d1					; compare them
		bpl.s	SSY_Pos					; if positive, branch
		neg.w	d2					; negate the height to positive

SSY_Pos:
		move.w	d1,d0					; reload objects's Y position
		sub.w	d2,d0					; minus the height
		rts						; return (d0 equals the new solid Y position)

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to Animate an Object's sprite (Only Springs use this)
; ---------------------------------------------------------------------------

AnimateSprite:
		subq.b	#1,$26(a6)
		bpl.s	loc_EB2C
		clr.b	$27(a6)

loc_EB2C:				; CODE XREF: AnimateSprite+4j
		beq.s	loc_EB30
		rts
; ---------------------------------------------------------------------------

loc_EB30:				; CODE XREF: AnimateSprite:loc_EB2Cj
		moveq	#0,d1
		moveq	#0,d2

loc_EB34:				; CODE XREF: ROM:0000EB6Aj
					; ROM:0000EB76j ...
		moveq	#0,d0
		move.b	$27(a6),d0
		move.b	(a1,d0.w),d1
		bmi.s	loc_EB58
		move.b	d1,$26(a6)
		move.b	1(a1,d0.w),d1
		add.w	d1,d1
		adda.w	(a0,d1.w),a0
		addq.b	#2,$27(a6)
		move.l	a0,$10(a6)
		rts
; ---------------------------------------------------------------------------

loc_EB58:				; CODE XREF: AnimateSprite+1Cj
		add.b	d1,d1
		jmp	loc_EB5E(pc,d1.w)
; End of function AnimateSprite

; ---------------------------------------------------------------------------

loc_EB5E:
		bra.s	loc_EB66
; ---------------------------------------------------------------------------
		bra.s	loc_EB6C
; ---------------------------------------------------------------------------
		bra.s	loc_EB78
; ---------------------------------------------------------------------------
		rts
; ---------------------------------------------------------------------------

loc_EB66:				; CODE XREF: ROM:loc_EB5Ej
		clr.b	$27(a6)
		bra.s	loc_EB34
; ---------------------------------------------------------------------------

loc_EB6C:				; CODE XREF: ROM:0000EB60j
		move.b	1(a1,d0.w),d1
		add.b	d1,d1
		add.b	d1,$27(a6)
		bra.s	loc_EB34
; ---------------------------------------------------------------------------

loc_EB78:				; CODE XREF: ROM:0000EB62j
		move.b	1(a1,d0.w),d1
		move.w	d1,-(sp)
		addq.b	#2,$27(a6)
		bsr.s	loc_EB34
		move.w	(sp)+,d0
		ori	#1,ccr
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check distances between the character and object and setting
; flags in d4
; ---------------------------------------------------------------------------
; bit 0 = if set, character is on the left side of the object, not right side
; bit 1 = if set, character is above the object, not below
; bit 2 = if set, character is closer to object on the Y position, not X
; ---------------------------------------------------------------------------

Distance_GetSet:
		moveq	#$00,d4					; clear d4
		sub.w	d0,d2					; minus object's X position from character's X position
		bcc.s	DGS_NoSetRight				; if distance is positive, branch (Object is to the left of the character)
		ori.w	#$01,d4					; set bitflag 0000 0001 (object infront)
		neg.w	d2					; negate the distance to positive

DGS_NoSetRight:
		sub.w	d1,d3					; minus object's Y position from character's Y position
		bcc.s	DGS_NoSetDown				; if distance is positive, branch (Object is above the character)
		ori.w	#$02,d4					; set bitflag 0000 0010 (object below)
		neg.w	d3					; negate the distance to positive

DGS_NoSetDown:
		cmp.w	d2,d3					; is X distance larger than Y distance
		bls.s	DGS_XCloser				; if not, branch
		ori.w	#$04,d4					; set bitflag 0000 0100 (character closer on Y position)

DGS_XCloser:
		rts						; return

; ===========================================================================


locret_EBAC:				; CODE XREF: ROM:0000D234j
		rts

; =============== S U B	R O U T	I N E =======================================


sub_EBAE:				; CODE XREF: ROM:00008A20p
		lea	($FFFFD85C).w,a6

loc_EBB2:				; CODE XREF: sub_EBAE+18j
		move.w  0(a6),d0
		bne.s	loc_EBBA
		rts
; ---------------------------------------------------------------------------

loc_EBBA:				; CODE XREF: sub_EBAE+8j
		movea.w	d0,a6
		moveq	#0,d0
		move.b	6(a6),d0
		jsr	loc_EBC8(pc,d0.w)
		bra.s	loc_EBB2
; End of function sub_EBAE

; ---------------------------------------------------------------------------

loc_EBC8:
		bra.w	GameTimeOver
; ---------------------------------------------------------------------------
		bra.w	loc_ED7C
; ---------------------------------------------------------------------------
		bra.w	loc_EE0C
; ---------------------------------------------------------------------------
		bra.w	loc_EE5C
; ---------------------------------------------------------------------------
		bra.w	loc_EEDA
; ---------------------------------------------------------------------------
		bra.w	loc_EF58
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Game Over at top of level, Time Over and Timer
; ---------------------------------------------------------------------------

JumpToTitle:	
		move.w	#$0008,($FFFFD822).w			; set Screen/Game mode to title screen
		movea.l	($00000000).w,sp			; set stack pointer to location 00000000			; do...
		jmp	MainProg_Loop				; jump to Main game array

GameTimeOver:						; Offset: 0000EBE0
;	;	rts
;		tst.w	($FFFFD834).w				; check if level is not Techno Tower
;		beq.s	GTO_CheckTime				; if so, branch
;		movea.w	($FFFFD862).w,a0			; load Sonic's object RAM into a0
;		cmpi.w	#$8F,$C(a0)				; is Sonic at position $8F or below on Y-axis?
;		bcc.s	GTO_CheckTime			; if yes, branch
;	if	Combi	=	1
;		movea.w	($FFFFD864).w,a0			; load Tails' object RAM into a0
;		cmpi.w	#$8F,$C(a0)				; is Tails at position $8F or below on Y-axis?
;		bcc.s	GTO_CheckTime				; if not, branch
;	else
;	endif
;


GTO_CheckTime:						; Offset: 0000EC02
		tst.w	$26(a6)					; check if $FFFFD882 is set
		bne.s	GTO_GameOver			; if so, branch
		move.w	$24(a6),d7				; move the timer itself into d7
		addq.w	#1,d7					; add 1 to centi-seconds timer
		cmpi.w	#$2D00,d7				; is timer showing 3:00:00?
		bhi.s	GTO_GameOver				; if yes, branch
	;	tst.w	($FFFFD834).w				; is level Techno Tower?
		bne.s	GTO_UpdateTime				; if yes, branch
	;	cmpi.w	#$F00,d7				; is timer showing 1:00:00?
	;	bls.s	GTO_UpdateTime				; if not branch, branch

GTO_GameOver:						; Offset: 0000EC20
		move.b	#$86,d0					; set music $86 to d0 (Game Over music)
		jsr	(PlayMusic).l				; play song
		move.w	#$100,d0				; set delay time to $300

GTO_Loop:						; Offset: 0000EC2E
		bclr	#7,($FFFFFFC9).w			; do the lag


GTO_LagLoop:						; Offset: 0000EC34
		tst.b	($FFFFFFC9).w				; check for the lag flag
		bpl.s	GTO_LagLoop				; wait until the lag is open again
		dbf	d0,GTO_Loop				; loop

		clr.w	($FFFFD824).w				; clear sub game-mode flag
		move.w	($FFFFD834).w,d0			; get level ID
		addq.w	#1,d0					; add 1 to it
	;	andi.w	#1,d0					; and it by 1
		move.w	d0,($FFFFD834).w			; put the result back
		clr.w	($FFFFD836).w				; clear a "Press Start" releated flag
	;	addi.w	#1,($FFFFD834).w			; go to next world
		move.w	#$0001,($FFFFD836).w			; set Level/Act/Field ID to 1
	;	move.w	#$0018,($FFFFD822).w			; set Screen/Game mode to Level
		cmpi.w	#$0004,($FFFFD834).w			;	is ID higher than 4?
		bge.s	JumpToTitle					;	return if so
		movea.l	($00000000).w,sp			; set stack pointer to location 00000000			; do...
	
GameOverFadeTrans:	
		bclr	#$07,($FFFFFFC9).w			; set to not run this routine til V-Blank has run

GO_Trans_WaitVB:						; Offset: 000074E2
		tst.b	($FFFFFFC9).w				; is the routine ready to continue?
		bpl.s	GO_Trans_WaitVB				; if not, loop and recheck
		moveq	#$01,d0					; set the speed of palette fading
		jsr	Pal_FadeBlack				; fade the palettes to black
		bne.w	GameOverFadeTrans				; if fading hasn't finished, branch
		
		moveq	#$28,d0					; set number of columns to dump
		moveq	#$20,d1					; set number of rows to dump
		move.w	#$8002,d2				; set value/tile to dump
		move.w	($FFFFD816).w,d3			; set V-Ram location to dump to (V-Ram plane A)
		
		jmp	MainProg_Loop				; jump to Main game array

GTO_UpdateTime:						; Offset: 0000EC62
		move.w	d7,$24(a6)				; set "real" time to the result of GTO_CheckTime
		move.w	#$A500,d6				; sprite priority, palette, etc. (Format: $A5xx)
		move.w	d7,d0					; load "real" time into d0
		lsr.w	#6,d0					; slow down the seconds timer
		ext.l	d0					; extend it (does nothing visible)
		divu.w	#$A,d0					; make sure it starts at the second digit (of seconds)
		swap	d0					; do a swap
		move.b	d0,d6					; put result and layout together
		add.b	d6,d6					; go 2 tiles forward instead of just 1
		move.w	d6,($FFFFDA26).w			; put result into 0:0X:00 (second digit of seconds)
		swap	d0					; do another swap
		ext.l	d0					; extend (important)
		divu.w	#6,d0					; make sure it starts at minutes timer
		move.b	d0,d6					; put result and layout together
		add.b	d6,d6					; go 2 tiles forward instead of just 1
		move.w	d6,($FFFFDA0E).w			; put result into X:00:00 (minutes)
		swap	d0					; and another swap
		move.b	d0,d6					; put result and layout together
		add.b	d6,d6					; go 2 tiles forward instead of just 1
		move.w	d6,($FFFFDA1E).w			; put result into 0:X0:00 (first digit of seconds)
		move.w	d7,d0					; reload "real" time into d0
		andi.w	#$3F,d0					; make sure it's not loading anything past the 64th entry
	;	move.b	GTO_CentiArray(pc,d0.w),d0		; get number to be displayed for centi-seconds
		move.b	d0,d6					; put recieved number and layout together
		lsr.b	#4,d6					; slow down first digit of centi-seconds
		add.b	d6,d6					; go 2 tiles forward instead of just 1
		move.w	d6,($FFFFDA36).w			; put result into 0:00:X0 (first digit of centi-seconds)
		move.b	d0,d6					; put recieved number from GTO_CentiArray and layout together
		andi.b	#$F,d6					; make sure only the second digit is being used
		add.b	d6,d6					; go 2 tiles forward instead of just 1
		move.w	d6,($FFFFDA3E).w			; put result into 0:00:0X (second digit of centi-seconds)
		
	;	move.b	$FFFFA000,$FFFFA001
	

		clr.b	d1
		clr.b	$FFFFA001
		clr.b	$FFFFA002
		clr.b	$FFFFA003

		move.b	$FFFFA000,d0
		cmpi.w	#9,d0                   ;	d0 is checked if it is 9...
		ble.s	@cont100                  ;	...and the rest of the code is skipped if it is equal or lower than 9
		
	@loop:
		add.b	#1,	d1					;	2 is added to d1
		subi.b	#10,d0					;	subtract decimal 10 from d0
		cmpi.w	#9,d0					;	d0 is checked if it is below 9...
		bhi.s	@loop					;	and if it isn't, loop this subtraction code again

		move.b	d0,$FFFFA003
		move.b	d1,$FFFFA002
		
	@cont100:
		move.b	d0,$FFFFA003
		clr.b	d1

		move.b	$FFFFA000,d0
		cmpi.w	#99,d0   
		ble.s	@cont
		
	@loop2:
		add.b	#1,	d1					;	2 is added to d1
		subi.b	#100,d0					;	subtract decimal 100 from d0
		cmpi.w	#99,d0					;	d0 is checked if it is below 99...
		bhi.s	@loop2					;	and if it isn't, loop this subtraction code again
		move.b	d1,$FFFFA001

		mulu.w	#10,d1
		sub.b	d1,$FFFFA002

	@cont:
		clr.w	d0
		clr.w	d1
		clr.w	d2
		move.b	$FFFFA001,	d0
		mulu.w	#2,	d0
		add.w	#$A500,d0
		move.w	d0,($FFFFDA66).w
		move.b	$FFFFA002,	d1
		mulu.w	#2,	d1
		add.w	#$A500,d1
		move.w	d1,($FFFFDA6E).w
		move.b	$FFFFA003,	d2
		mulu.w	#2,	d2
		add.w	#$A500,d2
		move.w	d2,($FFFFDA76).w
	
		move.w	$24(a6),d0				; reload time into d0
		cmpi.w	#$2580,d0				; is timer at or over 2:30:00?
		bcc.s	GTO_RedBlinking				; if yes, branch
		tst.w	($FFFFD834).w				; is level Techno Tower?
		bne.s	GTO_Return				; if yes, branch
		cmpi.w	#$780,d0				; is timer at or over 0:30:00?
		bcs.s	GTO_Return				; if not, branch


GTO_RedBlinking:					; Offset: 0000ECCE
		andi.w	#$F,d0					; switch between yellow and red...
		bne.s	GTO_Return				; ...every 25 centi-seconds
		move.w	#$2000,d0				; load different priority, palette, etc.
		eor.w	d0,($FFFFD9F6).w			; change layout of "TIME"
		eor.w	d0,($FFFFD9FE).w			; change layout of "ATTA"
		eor.w	d0,($FFFFDA06).w			; change layout of "CK"


GTO_Return:						; Offset: 0000ECE4
		rts						; return
; ===========================================================================
; ---------------------------------------------------------------------------
; Array of values to be displayed for centi-seconds
; ---------------------------------------------------------------------------

GTO_CentiArray:						; Offset: 0000ECE6
		dc.b	$00,$02
		dc.b   3
		dc.b   5
		dc.b   6
		dc.b   8
		dc.b   9
		dc.b $11
		dc.b $13
		dc.b $14
		dc.b $16
		dc.b $17
		dc.b $19
		dc.b $20
		dc.b $22
		dc.b $23
		dc.b $25
		dc.b $27
		dc.b $28
		dc.b $30
		dc.b $31
		dc.b $33
		dc.b $34
		dc.b $36
		dc.b $38
		dc.b $39
		dc.b $41
		dc.b $42
		dc.b $44
		dc.b $45
		dc.b $47
		dc.b $48
		dc.b $50
		dc.b $52
		dc.b $53
		dc.b $55
		dc.b $56
		dc.b $58
		dc.b $59
		dc.b $61
		dc.b $63
		dc.b $64
		dc.b $66
		dc.b $67
		dc.b $69
		dc.b $70
		dc.b $72
		dc.b $73
		dc.b $75
		dc.b $77
		dc.b $78
		dc.b $80
		dc.b $81
		dc.b $83
		dc.b $84
		dc.b $86
		dc.b $88
		dc.b $89
		dc.b $91
		dc.b $92
		dc.b $94
		dc.b $95
		dc.b $97
		dc.b $99

; =============== S U B	R O U T	I N E =======================================

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load palette cycling objects
; ---------------------------------------------------------------------------
; Sonic Crackers loads an object and that object's routine deals with the
; palette cycling it seems
; ---------------------------------------------------------------------------

Levels_LoadPalCycleObjects:				; Offset: 0000ED26
		move.w	($FFFFD834).w,d0			; load Zone/World ID
		lsl.l	#$01,d0					; multiply by 2
		jmp	LLPCO_Levels(pc,d0.w)			; jump to correct address

; ===========================================================================
; ---------------------------------------------------------------------------
LLPCO_Levels:						; Offset: 0000ED30
		bra.s	LLPCO_SSZ
		bra.s	LLPCO_TTZ
		bra.s	LLPCO_SSZ
		bra.s	LLPCO_SSZ
		rts
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; 
; ---------------------------------------------------------------------------

LLPCO_SSZ:						; Offset: 0000ED34
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; 
; ---------------------------------------------------------------------------

LLPCO_TTZ:						; Offset: 0000ED36
		moveq	#$10,d0					; set to read the 4th Object Ram section
		jsr	Objects_FindFreeSlot
		bmi.w	loc_ED5E
		moveq	#$00,d7
		move.w	($FFFFD83A).w,d7
		andi.w	#$0003,d7
		addq.w	#$01,d7
		lsl.l	#$02,d7
		move.b	d7,6(a0)
		move.w	#$0000,$26(a0)
		move.w	#$0000,$24(a0)

loc_ED5E:						; Offset: 0000ED5E
		moveq	#$10,d0					; set to read the 4th Object Ram section
		jsr	Objects_FindFreeSlot
		bmi.w	locret_ED7A
		move.b	#$14,$06(a0)
		move.w	#$0000,$26(a0)
		move.w	#$0000,$24(a0)

locret_ED7A:						; Offset: 0000ED7A
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; 
; ---------------------------------------------------------------------------

loc_ED7C:				; CODE XREF: ROM:0000EBCCj
		addq.w	#1,$24(a6)
		andi.w	#3,$24(a6)
		bne.s	loc_EDA6
		addq.w	#1,$26(a6)
		andi.w	#7,$26(a6)
		moveq	#0,d2
		move.w	$26(a6),d2
		lsl.l	#1,d2
		lea	($FFFFD3E4).w,a0
		move.w	word_EDE4(pc,d2.w),d0
		move.w	d0,$7A(a0)

loc_EDA6:				; CODE XREF: ROM:0000ED86j
		addq.w	#1,$28(a6)
		andi.w	#7,$28(a6)
		bne.s	locret_EDE2
		addq.w	#1,$2A(a6)
		move.w	$2A(a6),d2
		cmpi.w	#6,d2
		bne.s	loc_EDC6
		move.w	#0,$2A(a6)

loc_EDC6:				; CODE XREF: ROM:0000EDBEj
		moveq	#0,d2
		move.w	$2A(a6),d2
		lsl.l	#1,d2
		lea	($FFFFD3E4).w,a0
		move.w	word_EDF4(pc,d2.w),d0
		move.w	d0,$7C(a0)
		move.w	word_EE00(pc,d2.w),d0
		move.w	d0,$7E(a0)

locret_EDE2:				; CODE XREF: ROM:0000EDB0j
		rts
; ---------------------------------------------------------------------------
word_EDE4:	dc.w	$E
		dc.w	$C
		dc.w	$A
		dc.w	8
		dc.w	6
		dc.w	8
		dc.w	$A
		dc.w	$C
word_EDF4:	dc.w	$A66
		dc.w	$C66
		dc.w	$C86
		dc.w	$C88
		dc.w	$A88
		dc.w	$A68
word_EE00:	dc.w	$C88
		dc.w	$C86
		dc.w	$C66
		dc.w	$A66
		dc.w	$A68
		dc.w	$A88
; ---------------------------------------------------------------------------

loc_EE0C:				; CODE XREF: ROM:0000EBD0j
		lea	($FFFFD3E4).w,a0
		move.w	#6,d0
		move.w	d0,$7A(a0)
		addq.w	#1,$28(a6)
		andi.w	#7,$28(a6)
		bne.s	locret_EE4A
		addq.w	#1,$2A(a6)
		andi.w	#3,$2A(a6)
		moveq	#0,d2
		move.w	$2A(a6),d2
		lsl.l	#1,d2
		lea	($FFFFD3E4).w,a0
		move.w	word_EE4C(pc,d2.w),d0
		move.w	d0,$7C(a0)
		move.w	word_EE54(pc,d2.w),d0
		move.w	d0,$7E(a0)

locret_EE4A:				; CODE XREF: ROM:0000EE22j
		rts
; ---------------------------------------------------------------------------
word_EE4C:	dc.w	$800
		dc.w	$820
		dc.w	$840
		dc.w	$820
word_EE54:	dc.w	$840
		dc.w	$820
		dc.w	$800
		dc.w	$820
; ---------------------------------------------------------------------------

loc_EE5C:				; CODE XREF: ROM:0000EBD4j
		addq.w	#1,$24(a6)
		andi.w	#3,$24(a6)
		bne.s	loc_EE86
		addq.w	#1,$26(a6)
		andi.w	#7,$26(a6)
		moveq	#0,d2
		move.w	$26(a6),d2
		lsl.l	#1,d2
		lea	($FFFFD3E4).w,a0
		move.w	word_EEBA(pc,d2.w),d0
		move.w	d0,$7A(a0)

loc_EE86:				; CODE XREF: ROM:0000EE66j
		addq.w	#1,$28(a6)
		andi.w	#7,$28(a6)
		bne.s	locret_EEB8
		addq.w	#1,$2A(a6)
		andi.w	#3,$2A(a6)
		moveq	#0,d2
		move.w	$2A(a6),d2
		lsl.l	#1,d2
		lea	($FFFFD3E4).w,a0
		move.w	word_EECA(pc,d2.w),d0
		move.w	d0,$7C(a0)
		move.w	word_EED2(pc,d2.w),d0
		move.w	d0,$7E(a0)

locret_EEB8:				; CODE XREF: ROM:0000EE90j
		rts
; ---------------------------------------------------------------------------
word_EEBA:	dc.w	$E
		dc.w	$C
		dc.w	$A
		dc.w	8
		dc.w	6
		dc.w	8
		dc.w	$A
		dc.w	$C
word_EECA:	dc.w	$828
		dc.w	$628
		dc.w	$62A
		dc.w	$82A
word_EED2:	dc.w	$62A
		dc.w	$82A
		dc.w	$828
		dc.w	$628
; ---------------------------------------------------------------------------

loc_EEDA:				; CODE XREF: ROM:0000EBD8j
		addq.w	#1,$24(a6)
		andi.w	#3,$24(a6)
		bne.s	loc_EF04
		addq.w	#1,$26(a6)
		andi.w	#7,$26(a6)
		moveq	#0,d2
		move.w	$26(a6),d2
		lsl.l	#1,d2
		lea	($FFFFD3E4).w,a0
		move.w	word_EF38(pc,d2.w),d0
		move.w	d0,$7A(a0)

loc_EF04:				; CODE XREF: ROM:0000EEE4j
		addq.w	#1,$28(a6)
		andi.w	#7,$28(a6)
		bne.s	locret_EF36
		addq.w	#1,$2A(a6)
		andi.w	#3,$2A(a6)
		moveq	#0,d2
		move.w	$2A(a6),d2
		lsl.l	#1,d2
		lea	($FFFFD3E4).w,a0
		move.w	word_EF48(pc,d2.w),d0
		move.w	d0,$7C(a0)
		move.w	word_EF50(pc,d2.w),d0
		move.w	d0,$7E(a0)

locret_EF36:				; CODE XREF: ROM:0000EF0Ej
		rts
; ---------------------------------------------------------------------------
word_EF38:	dc.w	$E
		dc.w	$C
		dc.w	$A
		dc.w	8
		dc.w	6
		dc.w	8
		dc.w	$A
		dc.w	$C
word_EF48:	dc.w	$200
		dc.w	$400
		dc.w	$600
		dc.w	$400
word_EF50:	dc.w	$600
		dc.w	$400
		dc.w	$200
		dc.w	$400
; ---------------------------------------------------------------------------

loc_EF58:				; CODE XREF: ROM:0000EBDCj
		addq.w	#1,$28(a6)
		andi.w	#7,$28(a6)
		bne.s	locret_EFA2
		addq.w	#1,$2A(a6)
		andi.w	#7,$2A(a6)
		move.w	$2A(a6),d2
		cmpi.w	#6,d2
		bne.s	loc_EF7E
		move.w	#0,$2A(a6)

loc_EF7E:				; CODE XREF: ROM:0000EF76j
		moveq	#0,d2
		move.w	$2A(a6),d2
		lsl.l	#1,d2
		lea	($FFFFD3E4).w,a0
		move.w	word_EFA4(pc,d2.w),d0
		move.w	d0,$54(a0)
		move.w	word_EFB4(pc,d2.w),d0
		move.w	d0,$56(a0)
		move.w	word_EFC4(pc,d2.w),d0
		move.w	d0,$58(a0)

locret_EFA2:				; CODE XREF: ROM:0000EF62j
		rts
; ---------------------------------------------------------------------------
word_EFA4:	dc.w	$EE
		dc.w	$AC
		dc.w	$68
		dc.w	$46
		dc.w	$24
		dc.w	$46
		dc.w	$68
		dc.w	$AC
word_EFB4:	dc.w	$6A
		dc.w	$48
		dc.w	$24
		dc.w	$22
		dc.w	$202
		dc.w	$22
		dc.w	$24
		dc.w	$48
word_EFC4:	dc.w	$2E
		dc.w	$A
		dc.w	6
		dc.w	4
		dc.w	2
		dc.w	4
		dc.w	6
		dc.w	$A

; =============== S U B	R O U T	I N E =======================================

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load the HUD sprites and art patterns (including "PAUSE")
; ---------------------------------------------------------------------------

Levels_LoadHudArtSprites:				; Offset: 0000EFD4
		moveq	#$10,d0					; set to read the 4th Object Ram section
		jsr	Objects_FindFreeSlot			; check if there's any free space for the object
		bmi.w	loc_F0DE				; if not, branch
		move.w	#$0000,$04(a0)
		move.l	#$00000000,$24(a0)			; clear next object address and animation ID
		lea	loc_F00E(pc),a1				; load sprite data address to a1
		lea	($FFFFD9F2).w,a2			; load sprite table address to a2
		move.w	#(((loc_F00E_End-loc_F00E)/$02)-$01),d0	; set repeat tiles

loc_EFF8:						; Offset: 0000EFF8
		move.w	(a1)+,(a2)+				; dump sprites
		dbf	d0,loc_EFF8				; repeat til all sprites are dumped
		move.b	#$00,($FFFFDA85).w			; remove the left Black bar block

loc_F00A:						; Offset: 0000F00A
		bra.w	loc_F0DE				; continue

; ===========================================================================
; ---------------------------------------------------------------------------
; Sprite data (Standard VDP sprite table format)
; ---------------------------------------------------------------------------
;		dc.w	$YYYY,$SSPP,$VVVV,$XXXX
;
;	YYYY	= Y position
;	SS	= Shape/Size
;	PP	= Priority
;	VVVV	= V-Ram address/settings
;	XXXX	= X position
; ---------------------------------------------------------------------------

loc_F00E:						; Offset: 0000F00E
		;		 YYYY  SSPP  VVVV  XXXX                                      ;	FFFFD9EE
		dc.w	$00A0,$0D01,$A514,$0098			; "TIME"                     ;	FFFFD9F6
		dc.w	$0090,$0D02,$A53E,$0098			; "ATTA"                     ;	FFFFD9FE
		dc.w	$0090,$0503,$A546,$00B8			; "CK"                       ;	FFFFD906
		dc.w	$00A0,$0104,$A500,$00F8-40		; "0" 01 Minute Digit        ;	FFFFDA0E
		dc.w	$00A0,$0005,$A54A,$0100-40		; "'"                        ;	FFFFDA16
		dc.w	$00A0,$0106,$A500,$0108-40		; "0" 10 Second Digit        ;	FFFFDA1E
		dc.w	$00A0,$0107,$A500,$0110-40		; "0" 01 Second Digit        ;	FFFFDA26
		dc.w	$00A0,$0008,$A54B,$0118-40		; "''"                       ;	FFFFDA2E
		dc.w	$00A0,$0109,$A500,$0120-40		; "0" 10 Centi-seconds Digit ;	FFFFDA36
		dc.w	$00A0,$010A,$A500,$0128-40		; "0" 01 Centi-seconds Digit ;	FFFFDA3E
		dc.w	$00B0,$0D0B,$A534,$0098			; "RING"                     ;	FFFFDA46
		dc.w	$00B0,$010C,$A53C,$00B8			; "S"                        ;	FFFFDA4E
		dc.w	$FFFF,$010D,$A500,$FFFF			; Not used                   ;	FFFFDA56
		dc.w	$FFFF,$010E,$A500,$FFFF			; Not used                   ;	FFFFDA5E
		dc.w	$00B0,$010F,$A500,$00D8			; "0"                        ;	FFFFDA66
		dc.w	$00B0,$0110,$A500,$00E0			; "0"                        ;	FFFFDA6E
		dc.w	$00B0,$0100,$A500,$00E8			; "0"                           FFFFDA76

	; The last sprite priority above is set to 00, setting the VDP to NOT
	; display the sprites below, unless it's set to 11 (which it might do
	; when pause is set.

		dc.w	$00D0,$0D12,$A54C,$00EC			; "PAUS"
		dc.w	$00D0,$0113,$A554,$010C			; "E"
		dc.w	$0080,$0714,$C7F8,$0080			; Black bar to the left
		dc.w	$00A0,$0715,$C7F8,$0080			; ''
		dc.w	$00C0,$0716,$C7F8,$0080			; ''
		dc.w	$00E0,$0717,$C7F8,$0080			; ''
		dc.w	$0100,$0718,$C7F8,$0080			; ''
		dc.w	$0120,$0719,$C7F8,$0080			; ''
		dc.w	$0140,$0700,$C7F8,$0080			; ''
loc_F00E_End:	even

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Routine to load the HUD patterns
; ---------------------------------------------------------------------------

loc_F0DE:						; Offset: 0000F0DE
		move	#$2700,sr				; set the status register (disable interrupts)
		move.l	#ARTUNC_HUD,d0				; set source address
		move.w	#$A000,d1				; set V-Ram destination
		move.w	#$0800,d2				; set size
		jsr	DMA_WriteData				; transfer hud patterns
		move.l	#$7F000003,($C00004).l			; set VDP to V-Ram write mode with address
		move.l	#$DDDDDDDD,d0				; prepare art value
		moveq	#(($08*$08)-$01),d1			; set repeat times (8 tiles)

loc_F106:						; Offset: 0000F106
		move.l	d0,($C00000).l				; dump to V-Ram
		dbf	d1,loc_F106				; repeat til all tiles are done
		move	#$2300,sr				; set the status register (enable interrupts)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to handle the Object Position Loading (During startup of level)
; ---------------------------------------------------------------------------

ObjectPosiion_Start:					; Offset: 0000F116
		bsr.w	Calc_SetupRecordList			; setup the record list
		move.w	d2,($FFFFD8E8).w			; Maximum level X size to allow objects to be loaded
		move.w	d3,($FFFFD8EA).w			; Maximum level Y size to allow objects to be loaded
		bsr.w	Calc_ScreenArea				; get screen area
		bsr.w	Calc_ObjectLoad				; load objects from the list
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to handle the Object Position Loading (During level)
; ---------------------------------------------------------------------------

ObjectPosiion_Run:						; Offset: 0000F12C
		bsr.w	Calc_ScreenArea				; get screen area
		bsr.w	Calc_ObjectLoad				; load objects from the list
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load objects from an object list, on conditions of:
; -> The object must be within the screen aread
; -> The object is not already loaded (has not set the "Object Load Record List")
; ---------------------------------------------------------------------------

Calc_ObjectLoad:					; Offset: 0000F136
		movea.l	($FFFFD8EC).w,a0			; load Object Position List address
		lea	($FFFFD8F2).w,a1			; load Object Load Record List
		moveq	#$00,d5					; clear d5

COL_NextEntry:						; Offset: 0000F140
		move.b	(a1),d0					; load entry ID
		addq.w	#$01,d5					; increase counter by 1
		cmpi.b	#$FF,d0					; is the entry null?
		beq.s	COL_EndOfList				; if so, branch to finish list
		andi.b	#$0F,d0
		cmpi.b	#$02,d0					; Has the object already been loaded?
		bne.s	COL_SkipEntry				; if so, branch to skip entry
		move.w  $00(a0),d0				; load object's X position
		move.w	($FFFFD8DC).w,d1			; load furthest left position allowed to be loaded
		move.w	($FFFFD8E0).w,d2			; load furthest right position allowed to be loaded
		bsr.w	SpriteDistCheck				; check position
		bcs.s	COL_SkipEntry				; if it's not in range of X, skip to not load
		move.w	$02(a0),d0				; load object's Y position
		move.w	($FFFFD8DE).w,d1			; load furthest top position allowed to be loaded
		move.w	($FFFFD8E2).w,d2			; load furthest bottom position allowed to be loaded
		bsr.w	SpriteDistCheck				; check position
		bcs.s	COL_SkipEntry				; if it's not in range of Y, skip to not load
		movea.l	a1,a4					; copy entry address to a4
		lea	($FFFFD8F2).w,a3			; load beginning of list to a3
		suba.l	a3,a4					; subtract from a4 to get the slot number
		movea.l	a0,a5					; store object position list to a5
		movea.l	a1,a6					; store entry list
		moveq	#$0C,d0					; set to read the 3rd Object Ram section
		jsr	Objects_FindFreeSlot			; find free object slot
		bmi.s	COL_SkipEntry				; if none is available, branch
		move.w	$04(a5),$06(a0)				; set object's ID
		move.w  $00(a5),$08(a0)				; set object's X position
		move.w	$02(a5),$0C(a0)				; set object's Y position
		move.w	a4,$24(a0)				; save slot number object is using
		move.w	$06(a5),$28(a0)
		movea.l	a5,a0					; restore object position list to a5
		movea.l	a6,a1					; store entry list
		move.b	(a1),d0					; load entry ID
		andi.b	#$F0,d0
		ori.b	#$01,d0					; set object as already loaded
		move.b	d0,(a1)					; save entry ID

COL_SkipEntry:						; Offset: 0000F1B8
		adda.l	#$00000008,a0				; increase to next object position in the list
		adda.l	#$00000001,a1				; increase to next entry slot
		bra.w	COL_NextEntry				; check next object entry

COL_EndOfList:						; Offset: 0000F1C8
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to calculate the correct screen area around the screen for objects
; to be loaded
; ---------------------------------------------------------------------------

Calc_ScreenArea:					; Offset: 0000F1CA
		lea	($FFFFC9DE).w,a0			; load FG positions and sizes address to a0
		move.w  $00(a0),d0				; load X position
		move.w	$10(a0),d1				; load Y position
		addi.w	#$00A0,d0				; add A0 (Centre of screen on X)
		addi.w	#$0070,d1				; add 70 (Centre of screen on Y)
		move.w	d0,($FFFFD8E4).w			; save central X position
		move.w	d1,($FFFFD8E6).w			; save central Y position
		subi.w	#($00A0*$02),d0				; subtract a full X screen size
		bcc.s	CSA_NoMaxLeft				; if not passed the far left, branch
		moveq	#$00,d0					; it's too far left, set max left

CSA_NoMaxLeft:						; Offset: 0000F1EE
		move.w	d0,($FFFFD8DC).w			; set far left position
		subi.w	#($0070*$02),d1				; subtract a full Y screen size
		bcc.s	CSA_NoMaxUp				; if not passed the far top, branch
		moveq	#$00,d1					; it's too far up, set max up

CSA_NoMaxUp:						; Offset: 0000F1FA
		move.w	d1,($FFFFD8DE).w			; set far top position
		move.w	($FFFFD8E4).w,d0			; load central X position
		move.w	($FFFFD8E6).w,d1			; load central Y position
		addi.w	#($00A0*$02),d0				; add a full X screen size
		cmp.w	($FFFFD8E8).w,d0			; has it passed the far right?
		bcs.s	CSA_NoMaxRight				; if not, branch
		move.w	($FFFFD8E8).w,d0			; it's too far right, set max right

CSA_NoMaxRight:						; Offset: 0000F214
		move.w	d0,($FFFFD8E0).w			; set far right position
		addi.w	#($0070*$02),d1				; add a full Y screen size
		cmp.w	($FFFFD8EA).w,d1			; has it passed the far bottom?
		bcs.s	CSA_NoMaxDown				; if not, branch
		move.w	($FFFFD8EA).w,d1			; it's too far down, set max down

CSA_NoMaxDown:						; Offset: 0000F226
		move.w	d1,($FFFFD8E2).w			; set far bottom position
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check if an object is in the screen area that was calculated
; ---------------------------------------------------------------------------

SpriteDistCheck:					; Offset: 0000F22C
		sub.w	d1,d0					; minus 1st position from Object's position
		sub.w	d1,d2					; minus 1st position from scroll 2nd position
		cmp.w	d0,d2					; is object within the screen area?
		bcc.s	SDC_NoSprite				; if not, branch
		rts						; return

SDC_NoSprite:						; Offset: 0000F236
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup the "Object Load Record List"
; ---------------------------------------------------------------------------
; A brief explanation about the "Object Load Record List":
;
; All objects in the list check to see wether they are "Within" the screen
; area, unlike S1 or S2 where all objects in the list check if they've entered
; the screen area once within a 80 pixel area.
;
; This list is designed to make sure the objects don't load a second time, so
; basically keeping a record of what's current in screen area.
; ---------------------------------------------------------------------------

Calc_SetupRecordList:						; Offset: 0000F238
		move.l	a0,($FFFFD8EC).w			; set object list address to use
		lea	($FFFFD8F2).w,a0			; load Object Load Record List address
		move.w	#$0F,d7					; set repeat times

CSRL_ResetEntries:					; Offset: 0000F244
		move.w	#$FFFF,(a0)+				; reset all entries to null
		move.w	#$FFFF,(a0)+				; ''
		move.w	#$FFFF,(a0)+				; ''
		move.w	#$FFFF,(a0)+				; ''
		move.w	#$FFFF,(a0)+				; ''
		move.w	#$FFFF,(a0)+				; ''
		move.w	#$FFFF,(a0)+				; ''
		move.w	#$FFFF,(a0)+				; ''
		dbf	d7,CSRL_ResetEntries			; repeat til all 100 entry slots are set null
		movea.l	($FFFFD8EC).w,a0			; load object list address to a0
		lea	($FFFFD8F2).w,a1

CSRL_SetFreeEntries:					; Offset: 0000F270
		move.w	(a0),d0					; load X position of object
		cmpi.w	#$FFFF,d0				; is it the end of the list?
		beq.s	CSRL_SetupFinished			; if so, branch
		move.b	#$02,(a1)+				; set first entry to usable
		adda.l	#$00000008,a0				; increase to next slot in list
		bra.s	CSRL_SetFreeEntries			; repeat

CSRL_SetupFinished:					; Offset: 0000F284
		rts						; return

; ===========================================================================






; =============== S U B	R O U T	I N E =======================================


DeleteSprite:				; CODE XREF: ROM:0000D38Ep
					; ROM:0000D47Ep ...
		move.w	$24(a6),d0
		lea	($FFFFD8F2).w,a0
		move.b	#2,(a0,d0.w)
		jsr	DeleteObject
		rts
; End of function DeleteSprite


; =============== S U B	R O U T	I N E =======================================


loc_F29A:				; CODE XREF: ROM:0000F318p
		move.w	4(a6),d0
		ori.w	#$80,d0	; '€'
		move.w	d0,4(a6)
		rts
; End of function loc_F29A


; =============== S U B	R O U T	I N E =======================================


loc_F2A8:				; CODE XREF: ROM:loc_F320p
		move.w	4(a6),d0
		andi.w	#$FF7F,d0
		move.w	d0,4(a6)
		rts
; End of function loc_F2A8

; ---------------------------------------------------------------------------
		move.w	$24(a6),d0
		lea	($FFFFD8F2).w,a1
		move.b	(a1,d0.w),d1
		andi.b	#$F0,d1
		move.b	d1,(a1,d0.w)
		jsr	DeleteObject
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check if a sprite is still in the screen area on both X & Y
; ---------------------------------------------------------------------------

SpriteScreenCheck:
		move.w	$08(a6),d0				; load object's X position to d0
		move.w	($FFFFD8DC).w,d1			; load screen's X 1st scroll position to d1
		move.w	($FFFFD8E0).w,d2			; load screen's X 2nd scroll position to d2
		bsr.w	SpriteDistCheck				; check if the object is within the screen
		bcs.s	SSC_NoSprite				; if not, branch
		move.w	$0C(a6),d0				; load object's Y position to d0
		move.w	($FFFFD8DE).w,d1			; load screen's Y 1st scroll position to d1
		move.w	($FFFFD8E2).w,d2			; load screen's Y 2nd scroll position to d2
		bsr.w	SpriteDistCheck				; check if the object is within the screen

SSC_NoSprite:
		rts						; return

; ===========================================================================

		lea	($FFFFD8F2).w,a0
		move.w	$24(a6),d1
		move.b	d0,(a0,d1.w)
		rts
; ---------------------------------------------------------------------------
		lea	($FFFFD8F2).w,a0
		move.w	$24(a6),d1
		move.b	(a0,d1.w),d0
		rts
; ---------------------------------------------------------------------------
		jsr	(SpriteScreenCheck).l
		bcs.s	loc_F320
		jsr	(loc_F29A).l
		rts
; ---------------------------------------------------------------------------

loc_F320:				; CODE XREF: ROM:0000F316j
		jsr	(loc_F2A8).l
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to DMA transfer and map the Pause Window art
; ---------------------------------------------------------------------------

DMA_LoadPauseArt:					; Offset: 0000F328
		moveq	#$00,d1					; clear d1
		move.w	#$0020,d1				; prepare V-Ram destination
		movea.l	#ARTUNC_TitleCardBGAndPause,a0		; load art location to a0
		move.w	(a0),d2					; load prepared size
		lsr.w	#$01,d2					; divide by 2
		adda.l	$02(a0),a0				; increment to the art's location
		move.l	a0,d0					; load the source location to d0
		movem.l	d7/a6,-(sp)				; store register data to the stack
		jsr	DMA_WriteData				; DAM transfer the Pause art
		movem.l	(sp)+,d7/a6				; reload register data from the stack
		moveq	#$08,d0					; set number of columns to dump
		moveq	#$13,d1					; set number of rows to dump
		move.w	#$A001,d2				; set value to dump
		move.w	($FFFFD81E).w,d3			; set V-Ram location to dump to
		addi.w	#$0040,d3				; increase by 40
		jsr	MapScreenSingle				; dump the value to V-Ram (Window Plane) (Right Yellow Bar)
		moveq	#$28,d0					; set number of columns to dump
		moveq	#$09,d1					; set number of rows to dump
		move.w	#$A001,d2				; set value to dump
		move.w	($FFFFD81E).w,d3			; set V-Ram location to dump to
		addi.w	#$0980,d3				; increase by 980
		jsr	MapScreenSingle				; dump the value to V-Ram (Window Plane) (Bottom Yellow Bar)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to slide the Pause bar in
; ---------------------------------------------------------------------------

Pause_WindowIn:						; Offset: 0000F374
		tst.b	($FFFFFDC1).w				; has the Pause Window ready started sliding in yet?
		bgt.s	PWI_NoArt				; if not, branch
		bsr.s	DMA_LoadPauseArt			; retransfer Pause art to V-Ram

PWI_NoArt:						; Offset: 0000F37C
		cmpi.b	#$08,($FFFFFDC1).w			; is the Pause Window ready for sliding in?
		bge.s	PWOI_NoSlide				; is not, branch
		move.b	#$11,($FFFFDA75).w			; set to show the word "PAUSE"
		addq.b	#$02,($FFFFFDC1).w			; increase the Pause Window in
		bra.s	PWOI_Slide				; continue

; ---------------------------------------------------------------------------
; Subroutine to slide the Pause bar out
; ---------------------------------------------------------------------------


Pause_WindowOut:						; Offset: 0000F390
		tst.b	($FFFFFDC1).w				; is the Pause Window ready for sliding out?
		beq.s	PWOI_NoSlide				; if not, branch
		move.b	($FFFFDA85).w,($FFFFDA75).w		; set to remove the word "PAUSE"
		subq.b	#$02,($FFFFFDC1).w			; decrease the Pause Window out
		tst.b	($FFFFFDC1).w				; has it finished yet?
		bgt.s	PWOI_Slide				; if not, branch
		bsr.w	DMA_LoadHudArt				; retransfer HUD art to V-Ram

; ---------------------------------------------------------------------------
; Pause "WINDOW" sliding routine
; ---------------------------------------------------------------------------

PWOI_Slide:						; Offset: 0000F3AA
		clr.w	d0					; clear d0
		move.b	($FFFFFDC1).w,d0			; load Pause Window slide counter
		jsr	SlidePositions(pc,d0.w)			; jump to correct routine based on counter

PWOI_NoSlide:						; Offset: 0000F3B4
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
SlidePositions:						; Offset: 0000F3B6
		bra.s	SL_CompletelyOut			; 00 (Completely Out)
		bra.s	SL_SlightyOut				; 02 (Slightly Out)
		bra.s	SL_MiddleOut				; 04 (Middle Out)
		bra.s	SL_MiddleIn				; 06 (Middle In)
		bra.s	SL_SlightlyIn				; 08 (Slightly In)
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; HUD update counter 0A - reset HUD update counter to 00 (Completely In)
; ---------------------------------------------------------------------------

		clr.w	($FFFFFDC1).w				; reset Pause Window counter to 00
		rts						; return

; ---------------------------------------------------------------------------
; HUD update counter 00 - set positions, Window X 00 and Y 00 (Completely Out)
; ---------------------------------------------------------------------------

SL_CompletelyOut:					; Offset: 0000F3C6
		move.w	#$9100,($C00004).l			; [Window Horizontal Position: 00];
		move.w	#$9100,($FFFFC9DA).w			; save to VDP register 11 storage too
		move.w	#$9200,($C00004).l			; [Window Vertical Position: 00];
		move.w	#$9200,($FFFFC9DC).w			; save to VDP register 12 storage too
		rts						; return

; ---------------------------------------------------------------------------
; HUD update counter 02 - set positions, Window X 93 and Y 9C (Slightly Out)
; ---------------------------------------------------------------------------

SL_SlightyOut:						; Offset: 0000F3E4
		move.w	#$9193,($C00004).l			; [Window Horizontal Position: 93];
		move.w	#$9193,($FFFFC9DA).w			; save to VDP register 11 storage too
		move.w	#$929C,($C00004).l			; [Window Vertical Position: 9C];
		move.w	#$929C,($FFFFC9DC).w			; save to VDP register 12 storage too
		rts						; return

; ---------------------------------------------------------------------------
; HUD update counter 04 - set positions, Window X 92 and Y 99 (Middle Out)
; ---------------------------------------------------------------------------

SL_MiddleOut:						; Offset: 0000F402
		move.w	#$9192,($C00004).l			; [Window Horizontal Position: 92];
		move.w	#$9192,($FFFFC9DA).w			; save to VDP register 11 storage too
		move.w	#$9299,($C00004).l			; [Window Vertical Position: 99];
		move.w	#$9299,($FFFFC9DC).w			; save to VDP register 12 storage too
		rts						; return

; ---------------------------------------------------------------------------
; HUD update counter 06 - set positions, Window X 92 and Y 96 (Middle In)
; ---------------------------------------------------------------------------

SL_MiddleIn:						; Offset: 0000F420
		move.w	#$9191,($C00004).l			; [Window Horizontal Position: 91];
		move.w	#$9191,($FFFFC9DA).w			; save to VDP register 11 storage too
		move.w	#$9296,($C00004).l			; [Window Vertical Position: 96];
		move.w	#$9296,($FFFFC9DC).w			; save to VDP register 12 storage too
		rts						; return

; ---------------------------------------------------------------------------
; HUD update counter 08 - set positions, Window X 90 and Y 93 (Slightly In)
; ---------------------------------------------------------------------------

SL_SlightlyIn:						; Offset: 0000F43E
		move.w	#$9190,($C00004).l			; [Window Horizontal Position: 90];
		move.w	#$9190,($FFFFC9DA).w			; save to VDP register 11 storage too
		move.w	#$9293,($C00004).l			; [Window Vertical Position: 93];
		move.w	#$9293,($FFFFC9DC).w			; save to VDP register 12 storage too
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to DMA transfer the level title card art to V-Ram
; ---------------------------------------------------------------------------

DMA_LoadTitleCardArt:					; Offset: 0000F45C
		moveq	#$0B,d7					; set repeat times (number of entries)
		lea	TitleCardBG_TileLocationArray(pc),a6	; load entries address to a6

DLTCA_NextEntry:					; Offset: 0000F462
		bsr.s	DLTCA_WriteDMAEntry			; convert and write DMA data to the DMA cue
		dbf	d7,DLTCA_NextEntry			; repeat til all entries are written
		jsr	DMA_ProcessCue				; process the DMA cue
		bra.w	SetupTitleCard			; setup the title card data

; ===========================================================================
; ---------------------------------------------------------------------------
; Return from subroutine (left here, unremoved)
; ---------------------------------------------------------------------------
		rts
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to convert information ready for the DMA cue writing
; ---------------------------------------------------------------------------

DLTCA_WriteDMAEntry:					; Offset: 0000F472
		moveq	#$00,d1					; clear d1
		move.w	(a6)+,d1				; load V-Ram address
		movea.l	(a6)+,a0				; load uncompressed art address
		move.w	(a0),d2					; load number of bytes to transfer
		lsr.w	#$01,d2					; divide by 2 for ?
		adda.l	$02(a0),a0				; add the jump forward address
		move.l	a0,d0					; load location of the art itself
		movem.l	d7/a6,-(sp)				; store register data to the stack
		jsr	DMA_WriteCueEntry			; save data to DMA cues
		movem.l	(sp)+,d7/a6				; reload register data from the stack
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Level Title Card art data/addresses
; ---------------------------------------------------------------------------
;		dc.w	V-Ram address
;		dc.l	Uncompress Art information address
; ---------------------------------------------------------------------------

TitleCardBG_TileLocationArray:				; Offset: 0000F490
		dc.w	$0040
		dc.l	TCBG_Tile2
		dc.w	$0060
		dc.l	TCBG_Tile3
		dc.w	$0080
		dc.l	TCBG_Tile4
		dc.w	$00A0
		dc.l	TCBG_Tile5
		dc.w	$00C0
		dc.l	TCBG_Tile6
		dc.w	$00E0
		dc.l	TCBG_Tile7
		dc.w	$0100
		dc.l	TCBG_Tile8
		dc.w	$0120
		dc.l	TCBG_Tile9
		dc.w	$0140
		dc.l	TCBG_TileA
		dc.w	$0160
		dc.l	TCBG_TileB
		dc.w	$01A0
		dc.l	TCBG_TileC
		dc.w	$01E0
		dc.l	TCBG_TileD
		even

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to set the title card trigger and set it up
; ---------------------------------------------------------------------------

SetupTitleCard:					; Offset: 0000F4D8
		move.b	#$01,($FFFFFDC2).w			; set title card trigger
		bsr.w	STCW_ResetCounters			; reset counters for title card
		rts						; return

STCW_ResetCounters:					; Offset: 0000F4E4
		clr.w	($FFFFFDC4).w				; reset title card routine counter
		clr.w	($FFFFFDC6).w				; reset "Main Board" Y draw size (to top)
		clr.w	($FFFFFDC8).w				; reset "Top Board" X draw address (to right)
		clr.w	($FFFFFDCA).w				; reset "White Board" Y draw counter (to left)
		clr.w	($FFFFFDCC).w				; reset "Corner Board" position counter (to bottom/right)
		clr.w	($FFFFFDCE).w				; reset "Red Board" X draw address (to right)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Title Card Sliding "In" routine loop area
; ---------------------------------------------------------------------------

TitleCardSlide_In:					; Offset: 0000F4FE
		bclr	#$07,($FFFFFFC9).w			; set to not run this routine til V-Blank has run

TCSI_WaitVB:						; Offset: 0000F504
		tst.b	($FFFFFFC9).w				; is the routine ready to continue?
		bpl.s	TCSI_WaitVB				; if not, loop and recheck
		move.w	($FFFFFDC4).w,d0			; load title card routine counter
		cmpi.w	#$0014,d0				; has it reached 14 or higher?
		bge.s	SIR_Finish				; if so, branch to finish
		jsr	SlideInRoutines(pc,d0.w)		; jump to correct routine
		jsr	BuildSprites				; build object sprites
		bra.s	TitleCardSlide_In			; loop

; ===========================================================================
; ---------------------------------------------------------------------------
; Return (Unused/Unread)
; ---------------------------------------------------------------------------
		rts						; return
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Slide in routines
; ---------------------------------------------------------------------------

SlideInRoutines:					; Offset: 0000F520
		bra.w	SIR_MainBoard				; 00
		bra.w	SIR_TopBoard				; 04
		bra.w	SIR_WhiteBoard				; 08
		bra.w	SIR_RedBoard				; 0C
		bra.w	SIR_CornerBoards			; 10
		clr.w	d0					; 14 (Unused/skipped)

SIR_Finish:						; Offset: 0000F536
		rts						; return (Exits title card routine)

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Title Card Sliding "Out" routine loop area
; ---------------------------------------------------------------------------

TitleCardSlide_Out:					; Offset: 0000F538
		bclr	#$07,($FFFFFFC9).w			; set to not run this routine til V-Blank has run

TCSO_WaitVB:						; Offset: 0000F53E
		tst.b	($FFFFFFC9).w				; is the routine ready to continue?
		bpl.s	TCSO_WaitVB				; if not, loop and recheck
		jsr	GetControls				; load controls
		jsr	BuildSprites				; build object sprites
		tst.b	($FFFFFDC2).w				; has title card trigger been set?
		beq.s	TCSO_RunSlideOut			; if not, branch
		btst	#$07,($FFFFC93D).w			; has player 1 pressed the start button?
		beq.s	TitleCardSlide_Out			; if not, branch
		clr.b	($FFFFFDC2).w				; clear the window trigger flag
		clr.w	($FFFFFDC4).w				; reset title card routine counter

TCSO_RunSlideOut:					; Offset: 0000F562
		move.w	($FFFFFDC4).w,d0			; load title card routine counter
		cmpi.w	#$0014,d0				; has it reached 14 or higher?
		bge.s	SOR_Finish				; if so, branch to finish window
		jsr	SlideOutRoutines(pc,d0.w)		; jump to correct routine
		bra.s	TitleCardSlide_Out			; loop

; ===========================================================================
; ---------------------------------------------------------------------------
; Return (Unused/Unread)
; ---------------------------------------------------------------------------
		rts						; return
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Slide out routines
; ---------------------------------------------------------------------------

SlideOutRoutines:					; Offset: 0000F574
		bra.w	SOR_CornerBoards			; 00
		bra.w	SOR_RedBoard				; 04
		bra.w	SOR_WhiteBoard				; 08
		bra.w	SOR_TopBoard				; 0C
		bra.w	SOR_MainBoard				; 10
		clr.w	d0					; 14 (Unused/skipped)

SOR_Finish:						; Offset: 0000F58A
		jsr	Levels_LoadHudArtSprites		; load hud and pause art/sprite data
		rts						; return (Exits title card routine and returns to game)

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; PART 00 - Setting the entire screen to a blank tile before the Title Card
; scrolls in.
; ---------------------------------------------------------------------------

ClearScreen_ForTitleCard:				; Offset: 0000F58C
		moveq	#$28,d0					; set number of columns to dump
		moveq	#$20,d1					; set number of rows to dump
		move.w	#$8002,d2				; set value/tile to dump
		move.w	($FFFFD816).w,d3			; set V-Ram location to dump to (V-Ram plane A)
		jsr	MapScreenSingle				; dump to plane map
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; PART 01 (Slide In Routines) Making "Main Board" scroll down
; ---------------------------------------------------------------------------

SIR_MainBoard:						; Offset: 0000F59E
		addq.w	#$02,($FFFFFDC6).w			; increase "Main Board" counter
		moveq	#$40,d0					; set number of columns to dump
		move.w	($FFFFFDC6).w,d1			; load "Main Board Y position" as number of rows
		move.w	#$8003,d2				; set value/tile to dump
		move.w	($FFFFD816).w,d3			; set V-Ram location to dump to (V-Ram plane A)
		jsr	MapScreenSingle				; dump to plane map
		cmpi.w	#$0020,($FFFFFDC6).w			; has the main board reached the bottom?
		ble.s	SIR_MB_NoFinish				; if not, branch
		addq.w	#$04,($FFFFFDC4).w			; increase title card counter

SIR_MB_NoFinish:					; Offset: 0000F5C0
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; PART 05 (Slide Out Routines) Making "Main Board" scroll up (drawing level)
; ---------------------------------------------------------------------------

SOR_MainBoard:						; Offset: 0000F5C2
		subq.w	#$02,($FFFFFDC6).w			; decrease "Main Board" counter
		tst.w	($FFFFFDC6).w				; has it finished yet?
		bge.s	SOR_MB_NoFInish				; if not, branch
		addq.w	#$04,($FFFFFDC4).w			; increase title card counter
		move.w	($FFFFCA3C).w,($FFFFC9FC).w
		rts						; return

SOR_MB_NoFInish:					; Offset: 0000F5D8
		lea	($FFFFC9DE).w,a1			; load FG positions and sizes ram to a1
		lea	($FF0A00).l,a3				; load horizontal Map plane buffer to a3
		lea	($FF0B02).l,a4				; load vertical Map plane buffer to a4
		movea.l	a1,a5					; copy positions and sizes ram to a5
		movea.l	a3,a0					; copy horizontal Map plane buffer to a0
		move.w  $00(a1),d0				; load screen's FG X position
		move.w	($FFFFFDC6).w,d1			; load "Main Board" counter
		lsl.w	#$03,d1					; multiply by 8 (8 pixels per 1 tile)
		add.w	$10(a1),d1				; add screen's FG Y position
		move.w	$18(a1),d4				; load FG V-Ram address where art is to be written to
		jsr	DrawBlocksHorizontally			; draw a horizontal line of blocks
		movea.l	a0,a3					; reload horizontal Map plane buffer
		move	#$2700,sr				; set status register (disable interrupts)
		jsr	DumpMapPlaneBuffers			; dump the horizontal buffer to V-Ram map plane
		move	#$2000,sr				; set status register (enable interrupts)
		move.w	($FFFFFFDE).w,	($FFFFC9DE).w
		move.w	($FFFFFFEE).w,	($FFFFC9EE).w
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; PART 02 (Slide In Routines) Making "Top Board" scroll left
; ---------------------------------------------------------------------------

SIR_TopBoard:						; Offset: 0000F612
		addq.w	#$02,($FFFFFDC8).w			; increase "Top Board" counter
		moveq	#$02,d0					; set number of columns to dump
		moveq	#$05,d1					; set number of rows to dump
		move.w	#$8004,d2				; set value/tile to dump
		moveq	#$0028,d3				; set V-Ram plane address to dump to
		sub.w	($FFFFFDC8).w,d3			; subtract "Top Board" counter
		lsl.w	#$01,d3					; multiply by 8 (4 tiles left/right)
		add.w	($FFFFD816).w,d3			; add V-Ram location to dump to (V-Ram plane A)
		jsr	MapScreenSingle				; dump to plane map
		cmpi.w	#$0028,($FFFFFDC8).w			; has the main board reached the bottom?
		blt.s	SIR_TB_NoFinish				; if not, branch
		addq.w	#$04,($FFFFFDC4).w			; increase title card counter

SIR_TB_NoFinish:					; Offset: 0000F63A
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; PART 04 (Slide Out Routines) Making "Top Board" scroll right
; ---------------------------------------------------------------------------

SOR_TopBoard:						; Offset: 0000F63C
		subq.w	#$02,($FFFFFDC8).w			; decrease "Top Board" counter
		tst.w	($FFFFFDC8).w				; has it finished yet?
		bge.s	SOR_TB_NoFinish				; if not, branch
		addq.w	#$04,($FFFFFDC4).w			; increase title card counter
		move.w	#$0104,($FFFFC9FC).w
		rts						; return

SOR_TB_NoFinish:					; Offset: 0000F652
		moveq	#$28,d0					; set number of columns to dump
		sub.w	($FFFFFDC8).w,d0			; minus "Top Board" counter
		moveq	#$05,d1					; set number of rows to dump
		move.w	#$8003,d2				; set value/tile to dump
		move.w	($FFFFD816).w,d3			; set V-Ram location to dump to (V-Ram plane A)
		jsr	MapScreenSingle				; dump to plane map
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; PART 03 (Slide In Routines) Making "White Board" scroll right
; ---------------------------------------------------------------------------

SIR_WhiteBoard:						; Offset: 0000F668
		addq.w	#$01,($FFFFFDCA).w			; increase "White Board" counter
		move.w	($FFFFFDCA).w,d0			; set number of columns to dump
		moveq	#$1C,d1					; set number of rows to dump
		move.w	#$8005,d2				; set value/tile to dump
		move.w	($FFFFD816).w,d3			; set V-Ram location to dump to (V-Ram plane A)
		move.w	d3,-(sp)				; store in stack
		jsr	MapScreenSingle				; dump to plane map (Plane white)
		move.w	(sp)+,d3				; reload V-Ram address from stack
		add.w	($FFFFFDCA).w,d3			; add "White Board" counter...
		add.w	($FFFFFDCA).w,d3			; ...x2
		move.l	#$800B800C,d0				; set "White/Gray Zig-Zag" patterns to dump
		moveq	#$05,d1					; set number of rows to dump
		move.w	d3,-(sp)				; store V-Ram address to stack
		bsr.w	MapScreenSpecialPattern			; dump patterns to plane map (White/Gray Zig-Zag)
		move.w	(sp)+,d3				; reload V-Ram address from stack
		move.l	#$800E800D,d0				; set "White/Blue Zig-Zag" patterns to dump
		moveq	#$17,d1					; set number of rows to dump
		addi.w	#$0280,d3				; add V-Ram address to start at
		bsr.w	MapScreenSpecialPattern			; dump patterns to plane map (White/Blue Zig-Zag)
		cmpi.w	#$0009,($FFFFFDCA).w			; has the counter reached the "White Board" right?
		blt.s	SIR_WB_NoFinish				; if not, branch
		addq.w	#$04,($FFFFFDC4).w			; increase title card counter

SIR_WB_NoFinish:					; Offset: 0000F6B6
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; PART 03 (Slide Out Routines) Making "White Board" scroll left
; ---------------------------------------------------------------------------

SOR_WhiteBoard:						; Offset: 0000F6B8
		subq.w	#$01,($FFFFFDCA).w			; decrease "White Board" counter
		cmpi.w	#$FFFF,($FFFFFDCA).w			; has counter finished yet?
		bge.s	SOR_WB_NoFinish				; if not, branch
		addq.w	#$04,($FFFFFDC4).w			; increase title card counter
		rts						; return

SOR_WB_NoFinish:					; Offset: 0000F6CA
		moveq	#$01,d0					; set number of columns to dump
		moveq	#$05,d1					; set number of rows to dump
		move.w	#$8004,d2				; set value/tile to dump
		move.w	($FFFFFDCA).w,d3			; load counter
		addq.w	#$01,d3					; increase by 1
		lsl.w	#$01,d3					; multiply by 2 (2 bytes = 1 tile)
		add.w	($FFFFD816).w,d3			; add V-Ram location to dump to (V-Ram plane A)
		movem.w	d0/d3,-(sp)				; store register info to stack
		jsr	MapScreenSingle				; dump tiles
		movem.w	(sp)+,d0/d3				; reload register info from stack
		moveq	#$19,d1					; set number of rows to dump
		move.w	#$8003,d2				; set value/tile to dump
		move.w	d3,-(sp)				; store V-Ram address to stack
		addi.w	#$0280,d3				; increase V-Ram to "Main Board" start line
		jsr	MapScreenSingle				; dump tiles
		move.w	(sp)+,d3				; reload V-Ram address from stack
		move.l	#$800B800C,d0				; set "White/Gray Zig-Zag" patterns to dump
		moveq	#$05,d1					; set number of rows to dump
		subq.w	#$02,d3					; decrease by 1 tile
		move.w	d3,-(sp)				; store V-Ram address to stack
		bsr.w	MapScreenSpecialPattern			; dump patterns to plane map (White/Gray Zig-Zag)
		move.w	(sp)+,d3				; reload V-Ram address from stack
		move.l	#$800E800D,d0				; set "White/Blue Zig-Zag" patterns to dump
		moveq	#$17,d1					; set number of rows to dump
		addi.w	#$0280,d3				; increase V-Ram to "Main Board" start line
		bsr.w	MapScreenSpecialPattern			; dump patterns to plane map (White/Blue Zig-Zag)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; PART 05 (Slide In Routines) Making "Corner Boards" scroll up/left
; ---------------------------------------------------------------------------

SIR_CornerBoards:					; Offset: 0000F720
		addq.w	#$01,($FFFFFDCC).w			; increase "Corner Boards" counter

; ---------------------------------------------------------------------------
; Top Right Pale Blue (From right)
; ---------------------------------------------------------------------------

		moveq	#$01,d0					; set number of columns to dump
		moveq	#$28,d3					; set V-Ram address
		sub.w	($FFFFFDCC).w,d3			; minus "Corner Boards" counter
		lsl.w	#$01,d3					; multiply by 2 (2 bytes per tile)
		add.w	($FFFFD816).w,d3			; add V-Ram location to dump to (V-Ram plane A)
		moveq	#$05,d1					; set number of rows to dump
		move.w	#$8007,d2				; set value/tile to dump
		movem.w	d0/d3,-(sp)				; store register info to stack
		jsr	MapScreenSingle				; dump tiles

; ---------------------------------------------------------------------------
; Right Blue (Above "Red Board") (From right)
; ---------------------------------------------------------------------------

		movem.w	(sp)+,d0/d3				; reload register info from stack
		moveq	#$02,d1					; set number of rows to dump
		move.w	#$8009,d2				; set value/tile to dump
		movem.w	d0/d2-d3,-(sp)				; store register info to stack
		addi.w	#$0280,d3				; add V-Ram address (line to start on)
		jsr	MapScreenSingle				; dump tiles

; ---------------------------------------------------------------------------
; Right Blue (Below "Red Board") (From right)
; ---------------------------------------------------------------------------

		movem.w	(sp)+,d0/d2-d3				; reload register info from stack
		moveq	#$0F,d1					; set number of rows to dump
		movem.w	d0/d3,-(sp)				; store register info to stack
		addi.w	#$0480,d3				; add V-Ram address (line to start on)
		jsr	MapScreenSingle				; dump tiles

; ---------------------------------------------------------------------------
; Bottom Right Blue (From right)
; ---------------------------------------------------------------------------

		movem.w	(sp)+,d0/d3				; reload register info from stack
		moveq	#$06,d1					; set number of rows to dump
		move.w	#$8008,d2				; set value/tile to dump
		addi.w	#$0B00,d3				; add V-Ram address (line to start on)
		jsr	MapScreenSingle				; dump tiles

; ---------------------------------------------------------------------------
; Bottom Left Pale Blue (From bottom)
; ---------------------------------------------------------------------------

		moveq	#$01,d1					; set number of rows to dump
		moveq	#$1C,d3					; set V-Ram address
		sub.w	($FFFFFDCC).w,d3			; minus "Corner Boards" counter
		lsl.w	#$07,d3					; multiply by 80 (80 bytes per line from bottom)
		add.w	($FFFFD816).w,d3			; add V-Ram location to dump to (V-Ram plane A)
		moveq	#$09,d0					; set number of columns to dump
		move.w	#$8006,d2				; set value/tile to dump
		movem.w	d1/d3,-(sp)				; store register info to stack
		jsr	MapScreenSingle				; dump tiles

; ---------------------------------------------------------------------------
; Bottom Left Pale Blue (Over White Zig-Zag) (From bottom)
; ---------------------------------------------------------------------------

		movem.w	(sp)+,d1/d3				; reload register info from stack
		move.l	#$800F8010,d0				; set value/tiles to pattern
		addi.w	#$0012,d3				; increase V-Ram to the white zig-zag map area
		movem.w	d1/d3,-(sp)				; store register info to stack
		bsr.w	MapScreenSpecialPattern			; dump double tile patterns

; ---------------------------------------------------------------------------
; Bottom Blue (From bottom)
; ---------------------------------------------------------------------------

		movem.w	(sp)+,d1/d3				; reload register info from stack
		moveq	#$18,d0					; set number of columns to dump
		move.w	#$8009,d2				; set value/tile to dump
		addq.w	#$02,d3					; increase V-Ram to the blue main board area
		movem.w	d1/d3,-(sp)				; store register info to stack
		jsr	MapScreenSingle				; dump tiles

; ---------------------------------------------------------------------------
; Bottom Right Blue (From bottom)
; ---------------------------------------------------------------------------

		movem.w	(sp)+,d1/d3				; reload register info from stack
		moveq	#$06,d0					; set number of columns to dump
		move.w	#$8008,d2				; set value/tile to dump
		addi.w	#$0030,d3				; increase V-Ram to the bottom/right area
		jsr	MapScreenSingle				; dump tiles
		cmpi.w	#$06,($FFFFFDCC).w			; has the "Corner Boards" finished scrolling in?
		blt.s	SIR_CB_NoFinish				; if not, branch
		cmpi.w	#$06,($FFFFFDCC).w			; '' (same as above)
		blt.s	SIR_CB_NoFinish				; ''
		addq.w	#$04,($FFFFFDC4).w			; increase title card counter

SIR_CB_NoFinish:					; Offset: 0000F7E6
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; PART 01 (Slide Out Routines) Making "Corner Boards" scroll down/right
; ---------------------------------------------------------------------------

SOR_CornerBoards:					; Offset: 0000F7E8
		subq.w	#$01,($FFFFFDCC).w			; decrease "Corner Board" counter
		tst.w	($FFFFFDCC).w				; has counter finished yet?
		bge.s	SOR_CB_NoFinish				; if not, branch
		addq.w	#$04,($FFFFFDC4).w			; increase title card counter
		rts						; return

; ---------------------------------------------------------------------------
; Top Right Pale Blue (To right)
; ---------------------------------------------------------------------------

SOR_CB_NoFinish:					; Offset: 0000F7F8
		moveq	#$06,d0					; set number of columns to dump
		sub.w	($FFFFFDCC).w,d0			; minus "Corner Board" counter
		move.w	($FFFFD816).w,d3			; add V-Ram location to dump to (V-Ram plane A)
		addi.w	#$0044,d3				; add start of the pale blue V-Ram area
		moveq	#$05,d1					; set number of row to dump
		move.w	#$8004,d2				; set value/tile to dump
		movem.w	d0/d3,-(sp)				; store register info to stack
		jsr	MapScreenSingle				; dump tiles

; ---------------------------------------------------------------------------
; Right Blue (Above "Red Board") (To right)
; ---------------------------------------------------------------------------

		movem.w	(sp)+,d0/d3				; reload register info from stack
		moveq	#$02,d1					; set number of row to dump
		move.w	#$8003,d2				; set value/tile to dump
		movem.w	d0/d2-d3,-(sp)				; store register info to stack
		addi.w	#$0280,d3				; add start of the pale blue V-Ram area
		jsr	MapScreenSingle				; dump tiles

; ---------------------------------------------------------------------------
; Right Blue (Below "Red Board") (AND Bottom Right Blue (To bottom/right)) (To right)
; ---------------------------------------------------------------------------

		movem.w	(sp)+,d0/d2-d3				; reload register info from stack
		moveq	#$13,d1					; set number of row to dump
		sub.w	($FFFFFDCC).w,d1			; minus "Corner Board" counter
		addi.w	#$0480,d3				; set value/tile to dump
		jsr	MapScreenSingle				; dump tiles

; ---------------------------------------------------------------------------
; Bottom Left Pale Blue (To bottom)
; ---------------------------------------------------------------------------

		moveq	#$06,d1					; set number of row to dump
		sub.w	($FFFFFDCC).w,d1			; minus "Corner Board" counter
		move.w	($FFFFD816).w,d3			; add V-Ram location to dump to (V-Ram plane A)
		addi.w	#$0B00,d3				; increase to borrom V-Ram area
		moveq	#$09,d0					; set number of columns to dump
		move.w	#$8005,d2				; set value/tile to dump
		movem.w	d1/d3,-(sp)				; store register info to stack
		jsr	MapScreenSingle				; dump tiles

; ---------------------------------------------------------------------------
; Bottom Left Pale Blue (Over White Zig-Zag) (To bottom)
; ---------------------------------------------------------------------------

		movem.w	(sp)+,d1/d3				; reload register info from stack
		move.l	#$800E800D,d0				; set value/tiles to pattern
		addi.w	#$0012,d3				; increase to white zig-zag V-Ram area
		movem.w	d1/d3,-(sp)				; store register info to stack
		subi.w	#$0080,d3				; subtract 80 (move up a line)
		bsr.w	MapScreenSpecialPattern			; dump double tile patterns

; ---------------------------------------------------------------------------
; Bottom Blue (To bottom)
; ---------------------------------------------------------------------------

		movem.w	(sp)+,d1/d3				; reload register info from stack
		moveq	#$18,d0					; set number of columns to dump
		move.w	#$8003,d2				; set value/tile to dump
		addq.w	#$02,d3					; increase to "Main Board" V-Ram area
		jsr	MapScreenSingle				; dump tiles
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; PART 04 (Slide In Routines) Making "Red Board" scroll left
; ---------------------------------------------------------------------------

SIR_RedBoard:						; Offset: 0000F884
		addq.w	#$03,($FFFFFDCE).w			; increase "Red Board" counter
		moveq	#$03,d0					; set number of columns to dump
		moveq	#$02,d1					; set number of rows to dump
		move.w	#$800A,d2				; set value/tile to dump
		moveq	#$28,d3					; set V-Ram address to dump to
		sub.w	($FFFFFDCE).w,d3			; minus the counter (moves it left)
		lsl.w	#$01,d3					; multiply by 2
		addi.w	#$0380,d3				; add start Y line to move it on
		add.w	($FFFFD816).w,d3			; add V-Ram location to dump to (V-Ram plane A)
		jsr	MapScreenSingle				; dump to plane map
		cmpi.w	#$0021,($FFFFFDCE).w			; has "Red Board" reached the left?
		blt.s	SIR_RB_NoFinish				; if not, branch
		addq.w	#$04,($FFFFFDC4).w			; increase title card counter

SIR_RB_NoFinish:					; Offset: 0000F8B0
		move.l	#$43900003,d0				; set V-Ram location to dump to
		lea	TT_Text(pc),a1			; load location of "OPTION" letter to a1
		
	@cont:
		moveq	#$0F,d1					; set number of columns to dump (maximum 16)
		moveq	#$01,d2					; set number of rows to dump
		move.w	#$0000,d3				; set to use palette line 0 (and to map behind object plane)
		jsr	MapScreen				; map to screen planes
		rts						; return
		
TT_Text:						; Offset: 00009440
		dc.w	$0011
		dc.w	$0012
		dc.w	$0013
		dc.w	$0014
		dc.w	$0015
		dc.w	$0016
		dc.w	$0017
		dc.w	$0018
		dc.w	$0019
		dc.w	$001A
		dc.w	$001B
		dc.w	$001C
		dc.w	$001D
		dc.w	$001E
		dc.w	$001F
		dc.w	$0020
		dc.w	$0021
		dc.w	$0022
		dc.w	$0023
		dc.w	$0024
		dc.w	$0025
		dc.w	$0026
		dc.w	$0027
		dc.w	$0028
		dc.w	$0029
		dc.w	$002A
		dc.w	$002B
		dc.w	$002C
		dc.w	$002D
		dc.w	$002E
		dc.w	$002F
		dc.w	$0030
		even
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; PART 02 (Slide Out Routines) Making "Red Board" scroll right
; ---------------------------------------------------------------------------

SOR_RedBoard:						; Offset: 0000F8B2
		subq.w	#$03,($FFFFFDCE).w			; decrease "Red Board" counter
		tst.w	($FFFFFDCE).w				; has the counter finished?
		bge.s	SOR_RB_NoFinish				; if not, branch
		addq.w	#$04,($FFFFFDC4).w			; increase title card counter
		rts						; return

SOR_RB_NoFinish:					; Offset: 0000F8C2
		moveq	#$02,d1					; set number of rows to dump
		move.w	($FFFFD816).w,d3			; set V-Ram location to dump to (V-Ram plane A)
		addi.w	#$0380,d3				; increase V-Ram to the line the red board is on
		addi.w	#$000E,d3				; increase right to the read line area
		moveq	#$1E,d0					; set number of columns to dump
		sub.w	($FFFFFDCE).w,d0			; minus "Red Board" counter
		bne.s	SOR_RB_NoZigZag				; if it's not null, branch (skip zig/zag tile draws)
		moveq	#$02,d0					; set number of columns to dump
		move.w	#$8005,d2				; set value/tile to dump
		movem.w	d1/d3,-(sp)				; store register info to the stack
		jsr	MapScreenSingle				; dump to plane map
		movem.w	(sp)+,d1/d3				; reload register info from the stack
		move.l	#$800E800D,d0				; set value/tiles to pattern
		addq.w	#$04,d3					; increase right by 2 tiles
		bsr.w	MapScreenSpecialPattern			; dump double tile patterns
		rts						; return

SOR_RB_NoZigZag:					; Offset: 0000F8F8
		move.w	#$8003,d2				; set value/tile to dump
		addq.w	#$06,d3					; increase right by 3 tiles
		jsr	MapScreenSingle				; dump to plane map
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write a special double pattern (Stored in d0) to the VDP's map planes
; ---------------------------------------------------------------------------

MapScreenSpecialPattern:				; Offset: 0000F904
		btst	#$07,d3					; has the V-Ram reached an even tile line? (every 80 is 1 horizontal tile line)
		beq.s	MSSP_UseTile1				; if not, branch
		swap	d0					; swap tiles over (tile 2 then tile 1)

MSSP_UseTile1:						; Offset: 0000F90C
		lsl.l	#$02,d3					; send settings left
		lsr.w	#$02,d3					; send rest back
		ori.w	#$4000,d3				; set "V-Ram write mode" bit setting
		swap	d3					; send left
		andi.w	#$0003,d3				; set V-Ram map plane address area
		lea	($C00000).l,a1				; load VDP data port address
		move.w	#$8F80,($C00004).l			; set auto increment mode to 80 (a whole line)
		move.w	#$8F80,($FFFFC9D6).w			; store in VDP's register 0F storage
		move.l	d3,$04(a1)				; set V-Ram address to write special pattern
		lsr.l	#$01,d1					; divide the count by 2

MSSP_DumpTile:						; Offset: 0000F934
		move.l	d0,(a1)					; dump to V-Ram
		dbf	d1,MSSP_DumpTile			; repeat til done
		move.w	#$8F02,($C00004).l			; set auto increment mode to 2
		move.w	#$8F02,($FFFFC9D6).w			; store in VDP's register 0F storage
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; 
; ---------------------------------------------------------------------------

	; Subroutine to do something with animated tiles (resetting a counter?)

sub_F94A:						; Offset: 0000F94A
		move.w	#$FFFF,($FFFFF9C0).w			
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Return routine
; ---------------------------------------------------------------------------
		rts						; return
; ---------------------------------------------------------------------------
; ===========================================================================

; =============== S U B	R O U T	I N E =======================================


sub_F954:				; CODE XREF: ROM:00008A26p
		move.w	($FFFFD834).w,d0
		add.w	d0,d0
		lea	loc_F964(pc),a0
		adda.w	(a0,d0.w),a0
		jmp	(a0)
; End of function sub_F954

; ---------------------------------------------------------------------------
loc_F964:	dc.w	loc_FA0A-loc_F964
		dc.w	loc_FA0C-loc_F964
		dc.w	loc_FA0A-loc_F964
		dc.w	loc_FA0A-loc_F964
		dc.w	loc_FA0A-loc_F964
		dc.w	loc_FA0A-loc_F964
		dc.w	loc_FA0A-loc_F964
		dc.w	loc_FA0A-loc_F964
; ---------------------------------------------------------------------------

loc_F974:				; CODE XREF: ROM:0000FA10j
		lea	($FFFFF9C0).w,a6
		move.w	(a6),d7
		bpl.w	loc_F9BC
		lea	2(a6),a5

loc_F982:				; CODE XREF: ROM:0000F9BAj
		move.w	(a0)+,d0
		beq.s	locret_FA04
		lea	-2(a0,d0.w),a1
		lea	(a5),a4
		clr.w	(a4)+
		move.l	a1,(a4)+
		move.b	(a1)+,(a4)+
		move.b	(a1)+,(a4)+
		move.w	(a1)+,(a4)+
		move.w	(a0)+,d0
		moveq	#0,d1
		move.b	(a0)+,d1
		add.w	d1,d1
		movea.w	loc_FA06(pc,d1.w),a2
		move.w	(a2),d1
		lsl.w	#5,d1
		add.w	d1,d0
		move.w	d0,(a4)+
		move.l	(a1)+,(a4)+
		move.b	(a0)+,d0
		add.b	6(a5),d0
		move.b	d0,(a5)
		lea	$10(a5),a5
		addq.w	#1,(a6)
		bra.s	loc_F982
; ---------------------------------------------------------------------------

loc_F9BC:				; CODE XREF: ROM:0000F97Aj
		move.w	(a6)+,d7

loc_F9BE:				; CODE XREF: ROM:0000FA00j
		subq.b	#1,(a6)
		bne.s	loc_F9FC
		move.b	6(a6),(a6)
		moveq	#1,d0
		add.b	1(a6),d0
		cmp.b	7(a6),d0
		bcs.s	loc_F9D4
		moveq	#0,d0

loc_F9D4:				; CODE XREF: ROM:0000F9D0j
		move.b	d0,1(a6)
		add.w	d0,d0
		add.w	d0,d0
		movea.l	2(a6),a0
		move.l	4(a0,d0.w),d0
		move.w	$A(a6),d1
		move.w	8(a6),d2
		move.l	d0,$C(a6)
		movem.l	d7/a6,-(sp)
		jsr	DMA_WriteCueEntry
		movem.l	(sp)+,d7/a6

loc_F9FC:				; CODE XREF: ROM:0000F9C0j
		lea	$10(a6),a6
		dbf	d7,loc_F9BE

locret_FA04:				; CODE XREF: ROM:0000F984j
		rts
; ---------------------------------------------------------------------------
loc_FA06:	dc.w	$C9FA,$CA3A
; ---------------------------------------------------------------------------
loc_FA0A:	rts
; ---------------------------------------------------------------------------
loc_FA0C:	lea	TTZ_AniTileLocs(pc),a0
		bra.w	loc_F974
; ---------------------------------------------------------------------------
TTZ_AniTileLocs:dc.l	$001023E0
		dc.l	$00000016
		dc.l	$29600101
		dc.l	$00000000
		dc.l	$04020100
		dc.l	ARTUNC_TTZAnimatedFanFG1
		dc.l	ARTUNC_TTZAnimatedFanFG2
		dc.l	$02040200
		dc.l	ARTUNC_TTZAnimatedTurbineBG1
		dc.l	ARTUNC_TTZAnimatedTurbineBG2
		dc.l	ARTUNC_TTZAnimatedTurbineBG3
		dc.l	ARTUNC_TTZAnimatedTurbineBG4
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load and DMA transfer the HUD patterns to V-Ram
; ---------------------------------------------------------------------------

DMA_LoadHudArt:						; Offset: 0000FA44
		move.w	DLHA_Repeats(pc),d7			; load number of repeat times (22) to d7
		lea	DLHA_Data(pc),a0			; load data location to a0

DLHA_Repeat:						; Offset: 0000FA4C
		move.w	(a0)+,d1				; load VRam location
		add.w	($FFFFD81E).w,d1			; add V-Ram window location
		move.l	(a0)+,d0				; load art location to d0
		move.w	(a0)+,d2				; load size of art to d2
		movem.l	d7-a0,-(sp)				; store all register data to the stack pointer
		jsr	DMA_WriteData				; DMA transfer the art to V-Ram
		movem.l	(sp)+,d7-a0				; reload data from stack
		dbf	d7,DLHA_Repeat				; repeat til all uncompressed art is loaded to their respected locations
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Uncompressed Animated PLC Table
; ---------------------------------------------------------------------------

DLHA_Repeats:						; Offset: 0000FA68
		dc.w	$0022					; number of uncompressed art files to read

DLHA_Data:						; Offset: 0000FA6A
		dc.w	$0000							; VRam location
		dc.l	AniArt_Hud1to9_Sym			; "0" Hud	; location of Art
		dc.w	$0020							; size of Art
		dc.w	$0080
		dc.l	AniArt_Hud1to9_Sym+$40			; "1" Hud
		dc.w	$0020
		dc.w	$0100
		dc.l	AniArt_Hud1to9_Sym+$80			; "2" Hud
		dc.w	$0020
		dc.w	$0180
		dc.l	AniArt_Hud1to9_Sym+$C0			; "3" Hud
		dc.w	$0020
		dc.w	$0200
		dc.l	AniArt_Hud1to9_Sym+$100			; "4" Hud
		dc.w	$0020
		dc.w	$0280
		dc.l	AniArt_Hud1to9_Sym+$140			; "5" Hud
		dc.w	$0020
		dc.w	$0300
		dc.l	AniArt_Hud1to9_Sym+$180			; "6" Hud
		dc.w	$0020
		dc.w	$0380
		dc.l	AniArt_Hud1to9_Sym+$1C0			; "7" Hud
		dc.w	$0020
		dc.w	$0400
		dc.l	AniArt_Hud1to9_Sym+$200			; "8" Hud
		dc.w	$0020
		dc.w	$0480
		dc.l	AniArt_Hud1to9_Sym+$240			; "9" Hud
		dc.w	$0020
		dc.w	$0500
		dc.l	AniArt_Hud1to9_Sym+$280			; "!" Hud (Unused)
		dc.w	$0020
		dc.w	$0580
		dc.l	AniArt_Hud1to9_Sym+$2C0			; "'" (Minute/Second Symbol)
		dc.w	$0020
		dc.w	$0600
		dc.l	AniArt_MiliSymbol			; "''" (Second/Mili-Second Symbol)
		dc.w	$0020
		dc.w	$0680
		dc.l	AniArt_RingSprites+$1C0			; Ring Sprite (Frame 3)
		dc.w	$0020
		dc.w	$0700
		dc.l	AniArt_SLTime				; "/TIME" (Unused)
		dc.w	$0020
		dc.w	$0780
		dc.l	ARTUNC_TTZAnimatedTurbineBG5		; animated turbine (Frame 8)
		dc.w	$0020
		dc.w	$0800
		dc.l	ARTUNC_TTZAnimatedTurbineBG7		; animated turbine (Frame 7)
		dc.w	$0020
		dc.w	$0880
		dc.l	ARTUNC_TTZAnimatedTurbineBG6		; animated turbine (Frame 6)
		dc.w	$0020
		dc.w	$0900
		dc.l	AniArt_RingSprites+$80			; 5 Point Stars (Unused)
		dc.w	$0020
		dc.w	$0840
		dc.l	AniArt_Tether				; Tether (Frame 1)
		dc.w	$0010
		dc.w	$08C0
		dc.l	AniArt_Tether+$20			; Tether (Frame 2)
		dc.w	$0010
		dc.w	$0940
		dc.l	AniArt_Tether+$40			; Tether (Frame 3)
		dc.w	$0010
		dc.w	$09C0
		dc.l	AniArt_Tether+$60			; Tether (Frame 4)
		dc.w	$0010
		dc.w	$0980
		dc.l	AniArt_MultiStars			; Vertical Star (Frame 1) (Unused)
		dc.w	$0020
		dc.w	$0A00
		dc.l	AniArt_MultiStars+$40			; Horizontal Star (Frame 1) Vertical Star (Frame 2) (Unused)
		dc.w	$0020
		dc.w	$0A80
		dc.l	AniArt_MultiStars+$C0			; Horizontal Star (Frame 2) (Unused) Chain? (Unused)
		dc.w	$0040
		dc.w	$0B00
		dc.l	AniArt_MultiStars+$140			; Vertical and Horizontal White Star (Unused)
		dc.w	$0040
		dc.w	$0B80
		dc.l	AniArt_MultiStars+$1C0			; More Chain Pieces? (Unused)
		dc.w	$0040
		dc.w	$0C00
		dc.l	AniArt_MultiStars+$240			; Vertical and Horizontal White Star (Exact same design as the one before) (Unused)
		dc.w	$0040
		dc.w	$0C80
		dc.l	AniArt_MultiStars+$2C0			; Vertical and Horizontal White Star (More Sparkly) (Unused)
		dc.w	$0040
		dc.w	$0D00
		dc.l	AniArt_MultiStars+$340			; Centre of Night Sky Styled Star (Unused)
		dc.w	$0040
		dc.w	$0D80
		dc.l	AniArt_MultiStars+$3C0			; Edges of Night Sky Styled Star (Unused)
		dc.w	$0040
		dc.w	$0E00
		dc.l	AniArt_RingSprites+$C0			; Ring Sprite (Frame 1)
		dc.w	$0040
		dc.w	$0E80
		dc.l	AniArt_RingSprites+$140			; Ring Sprite (Frame 2)
		dc.w	$0040
		dc.w	$0F00
		dc.l	AniArt_RingSprites			; Stars (Ring Collect)
		dc.w	$0040
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Unknown Data
; ---------------------------------------------------------------------------
; Data Location (0000FB82 - 0000FDAF)
; Striped out
; UnkData_0000FB82:
	;	incbin	"UnknownCodes\UnknownData_0000FB82.bin"	; DXI
		even						; DXI
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Unknown Data
; ---------------------------------------------------------------------------
; Data Location (0000FDB0 - 0000FFFF)
; Striped out
; UnkData_0000FDB0:
	;	incbin	"UnknownCodes\UnknownData_0000FDB0.bin"	; DXI
		even						; DXI
; ===========================================================================
; ---------------------------------------------------------------------------
; Music Data (Z80 aligned to $00010000)
; ---------------------------------------------------------------------------
AlignValue =	$00 ;*-$00010000+*%2				; calculate the correct alignment (current position to be assambled - $00010000 (original position) and add 1 if result isn't even)
; ---------------------------------------------------------------------------
AL01:		dcb.b ($00010000+AlignValue)-AL01,$FF		; Aligned for Z80
; ---------------------------------------------------------------------------
Music8:	incbin	"Music\Music.bin" 			
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Unknown PCM Voice Data
; ---------------------------------------------------------------------------
; The data of this sample looks similar to the other samples, it also has a similar
; bank of unknown data after it.
; ---------------------------------------------------------------------------
PCM_00_Unknown:	incbin	Music\PCMUN.bin				; Unknown tapping sample

; ---------------------------------------------------------------------------

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Align to $00018000, Sound Data (Unused by Z80)
; ---------------------------------------------------------------------------
AL03:        dcb.b ($00018000+AlignValue)-AL03,$FF        ; Aligned    ; DXI
        dcb.b $4000,$FF
; ---------------------------------------------------------------------------
SoundA0:	incbin	Music\SoundA0.bin			; Jump SFX (Same as Sonic CD FM NO.02)
SoundA1:	incbin	Music\SoundA1.bin			; Cash Machine SFX (Same as Sonic 1 SFX C5)
SoundA2:	incbin	Music\SoundA2.bin			; strange noise (it has modulation of "01 01 28 00") (this MAY be a "get hit by spikes" SFX)
SoundA3:	incbin	Music\SoundA3.bin			; Bomb explode SFX (Same as Sonic 1 SFX C4)
SoundA4:	incbin	Music\SoundA4.bin			; Skidding SFX (Same as Sonic 1 SFX A4)
SoundA5:	incbin	Music\SoundA5.bin			; Ring Loss SFX (Same as Sonic 1 SFX C6)
SoundA6:	incbin	Music\SoundA6.bin			; Ring Collect SFX (Same as Sonic 1 SFX B5) (Plays on Right Speaker, may very well be the "right to left to right" speaker thing)
SoundA7:	incbin	Music\SoundA7.bin			; Destroy Badnik/Monitor SFX (Same a Sonic 3 SFX 3D)
SoundA8:	incbin	Music\SoundA8.bin			; Spring SFX (Same as Sonic 3 SFX B1)
SoundA9:	incbin	Music\SoundA9.bin			; Check Point SFX (Same as Sonic 1 SFX A1)
; ---------------------------------------------------------------------------
; Null SFX
; ---------------------------------------------------------------------------
SoundAA:	incbin	Music\SoundAA.bin
SoundAB:	incbin	Music\SoundAB.bin
SoundAC:	incbin	Music\SoundAC.bin
SoundAD:	incbin	Music\SoundAD.bin
SoundAE:	incbin	Music\SoundAE.bin
SoundAF:	incbin	Music\SoundAF.bin
; ---------------------------------------------------------------------------

; ---------------------------------------------------------------------------
; Align to $00020000, PCM Voice Data
; ---------------------------------------------------------------------------
AL04:		dcb.b ($00020000+AlignValue)-AL04,$FF		; Aligned
; ---------------------------------------------------------------------------
PCM_01_Beat:	incbin	Music\PCM01.bin				; DAC 81 (Beat Sample)
		even
PCM_02_Snare:	incbin	Music\PCM02.bin				; DAC 82 (Snare Sample)
		even
PCM_03_Tim_Tom:	incbin	Music\PCM03.bin				; DAC 83-85 [Hi to Low pitches] (Timpani/Tom-beat Sample)
		even
; ---------------------------------------------------------------------------
; these two samples are read in the Z80 table and can be heard when note 86
; and 87 are triggered in the SMPS music (however they are not used in any of
; the SMPS music)
; ---------------------------------------------------------------------------
PCM_04_Letsgo:	incbin	Music\PCM04.bin				; DAC 86 (Unknown voice "Let's Go" or "Ley'k Go" in Japanese accent)
		even
PCM_05_Hey:	incbin	Music\PCM05.bin				; DAC 87 (Unknown voice "Hey!" or "Hez!" in Japanese accent)
		even
; ---------------------------------------------------------------------------


; ===========================================================================
; ---------------------------------------------------------------------------
; Align to $00030000, Used Multiple Data
; ---------------------------------------------------------------------------
AL06:		dcb.b ($00030000+AlignValue)-AL06,$FF		; Aligned
; ---------------------------------------------------------------------------
ARTUNC_HUD:
	incbin	Uncompressed\ArtuncHud.bin			; Hud Patterns
	even
; ---------------------------------------------------------------------------
ARTNEM_RingTetherStarsUnused:
	incbin  NemesisComp\ArtnemRingTetherStarsUnused.bin	; unused Ring tether stars
	even
; ---------------------------------------------------------------------------
ARTNEM_SSZ8x8_FG:
	incbin	 NemesisComp\ArtnemSSZ8x8FG.bin			; 8x8 tiles for SSZ FG
	even
; ---------------------------------------------------------------------------
MAPENI_SSZ16x16_FG:
	incbin  EnigmaComp\MapeniSSZ16x16FG.bin			; 16x16 blocks for SSZ FG
	even
; ---------------------------------------------------------------------------
MAPENI_SSZ128x128_FG:
	incbin  EnigmaComp\MapeniSSZ128x128FG.bin		; 128x128 chunks for SSZ FG
	even
; ---------------------------------------------------------------------------
MAPENI_SSZLayout_FG:
	incbin  EnigmaComp\MapeniSSZLayoutFG.bin		; Layout for SSZ FG
	even
; ---------------------------------------------------------------------------
COL_SSZPrimary:	
	incbin	Collision\ColSSZPrimary.bin			; Primary Collisions for SSZ
	even
; ---------------------------------------------------------------------------
COL_SSZSecondary:
	incbin	 Collision\ColSSZSecondary.bin			; Secondary Collisions for SSZ
	even
; ---------------------------------------------------------------------------
ARTNEM_SSZ8x8_BG:
	incbin	 NemesisComp\ArtnemSSZ8x8BG.bin			; 8x8 tiles for SSZ BG
	even
; ---------------------------------------------------------------------------
MAPENI_SSZ16x16_BG:
	incbin  EnigmaComp\MapeniSSZ16x16BG.bin			; 16x16 blocks for SSZ BG
	even
; ---------------------------------------------------------------------------
MAPENI_SSZ128x128_BG:
	incbin  EnigmaComp\MapeniSSZ128x128BG.bin		; 128x128 chunks for SSZ BG
	even
; ---------------------------------------------------------------------------
MAPENI_SSZLayout_BG:
	incbin  EnigmaComp\MapeniSSZLayoutBG.bin		; Layout for SSZ BG
	even
; ---------------------------------------------------------------------------
ARTNEM_TTZ8x8_FG:
	incbin	 NemesisComp\ArtnemTTZ8x8FG.bin			; 8x8 tiles for TTZ FG
	even
; ---------------------------------------------------------------------------
MAPENI_TTZ16x16_FG:
	incbin  EnigmaComp\MapeniTTZ16x16FG.bin			; 16x16 blocks for TTZ FG
	even
; ---------------------------------------------------------------------------
MAPENI_TTZ128x128_FG:
	incbin  EnigmaComp\MapeniTTZ128x128FG.bin		; 128x128 chunks for TTZ FG
	even
; ---------------------------------------------------------------------------
MAPENI_TTZLayout_FG:
	incbin  EnigmaComp\MapeniTTZLayoutFG.eni		; Layout for TTZ FG
	even
; ---------------------------------------------------------------------------
COL_TTZPrimary:	
	incbin	Collision\ColTTZPrimary.bin			; Primary Collisions for TTZ
	even
; ---------------------------------------------------------------------------
COL_TTZSecondary:
	incbin	 Collision\ColTTZSecondary.bin			; Secondary Collisions for TTZ
	even
; ---------------------------------------------------------------------------
ARTNEM_TTZ8x8_BG:
	incbin	 NemesisComp\ArtnemTTZ8x8BG.bin			; 8x8 tiles for TTZ BG
	even
; ---------------------------------------------------------------------------
MAPENI_TTZ16x16_BG:
	incbin  EnigmaComp\MapeniTTZ16x16BG.bin			; 16x16 blocks for TTZ BG
	even
; ---------------------------------------------------------------------------
MAPENI_TTZ128x128_BG:
	incbin  EnigmaComp\MapeniTTZ128x128BG.bin		; 128x128 chunks for TTZ BG
	even
; ---------------------------------------------------------------------------
MAPENI_TTZLayout_BG:
	incbin  EnigmaComp\MapeniTTZLayoutBG.bin		; Layout for TTZ BG
	even
; ---------------------------------------------------------------------------
ARTNEM_IIZ8x8_FG:
	incbin	 NemesisComp\ArtnemIIZ8x8FG.bin			; 8x8 tiles for TTZ FG
	even
; ---------------------------------------------------------------------------
ARTNEM_IIZ8x8_BG:
	incbin	 NemesisComp\ArtnemIIZ8x8BG.bin			; 8x8 tiles for TTZ FG
	even
; ---------------------------------------------------------------------------
COL_IIZPrimary:	
	incbin	Collision\ColIIZPrimary.bin			; Primary Collisions for TTZ
	even
; ---------------------------------------------------------------------------
COL_IIZSecondary:
	incbin	 Collision\ColIIZSecondary.bin			; Secondary Collisions for TTZ
	even
; ---------------------------------------------------------------------------
MAPENI_IIZLayout_FG:
	incbin  EnigmaComp\MapeniIIZLayoutFG.eni		; Layout for TTZ FG
	even
; ---------------------------------------------------------------------------
MAPENI_IIZ16x16_FG:
	incbin  EnigmaComp\MapeniIIZ16x16FG.bin			; 16x16 blocks for TTZ BG
	even
; ---------------------------------------------------------------------------
MAPENI_IIZ128x128_FG:
	incbin  EnigmaComp\MapeniIIZ128x128FG.bin		; 128x128 chunks for TTZ FG
	even
; ===========================================================================
; ---------------------------------------------------------------------------
; Title Card and Pause Bar Patterns
; ---------------------------------------------------------------------------
; Note for DMA transfer:
;
; the "0020" is the number of bytes long the current art tile(s) are
; the "00000006" is the source location of art
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
ARTUNC_TitleCardBGAndPause:
		dc.w	$0020					; 20 Bytes (1 tile)
		dc.l	$00000006				; jump forward 6 bytes to art
		incbin  Uncompressed\Artunc_TCBG1.bin		; Yellow Pause Bar
; ---------------------------------------------------------------------------
TCBG_Tile2:
		dc.w	$0020					; 20 Bytes (1 tile)
		dc.l	$00000006				; jump forward 6 bytes to art
		incbin  Uncompressed\Artunc_TCBG2.bin		; Title Card - Black tiles that appear to hide the level design before the title card appears
; ---------------------------------------------------------------------------
TCBG_Tile3:
		dc.w	$0020					; 20 Bytes (1 tile)
		dc.l	$00000006				; jump forward 6 bytes to art
		incbin  Uncompressed\Artunc_TCBG3.bin		; Title Card - Dark Gray/Blue Bar that comes down first
; ---------------------------------------------------------------------------
TCBG_Tile4:
		dc.w	$0020					; 20 Bytes (1 tile)
		dc.l	$00000006				; jump forward 6 bytes to art
		incbin  Uncompressed\Artunc_TCBG4.bin		; Title Card - Light Gray/Blue Bar that appears from top right
; ---------------------------------------------------------------------------
TCBG_Tile5:
		dc.w	$0020					; 20 Bytes (1 tile)
		dc.l	$00000006				; jump forward 6 bytes to art
		incbin  Uncompressed\Artunc_TCBG5.bin		; Title Card - Pure White tiles that appear from the left
; ---------------------------------------------------------------------------
TCBG_Tile6:
		dc.w	$0020					; 20 Bytes (1 tile)
		dc.l	$00000006				; jump forward 6 bytes to art
		incbin  Uncompressed\Artunc_TCBG6.bin		; Title Card - Faded Blue tiles that appear from the bottom that move over the Pure White tiles
; ---------------------------------------------------------------------------
TCBG_Tile7:
		dc.w	$0020					; 20 Bytes (1 tile)
		dc.l	$00000006				; jump forward 6 bytes to art
		incbin  Uncompressed\Artunc_TCBG7.bin		; ??? (Unused)
; ---------------------------------------------------------------------------
TCBG_Tile8:
		dc.w	$0020					; 20 Bytes (1 tile)
		dc.l	$00000006				; jump forward 6 bytes to art
		incbin  Uncompressed\Artunc_TCBG8.bin		; Title Card - Dark Blue tiles on bottom right
; ---------------------------------------------------------------------------
TCBG_Tile9:
		dc.w	$0020					; 20 Bytes (1 tile)
		dc.l	$00000006				; jump forward 6 bytes to art
		incbin  Uncompressed\Artunc_TCBG9.bin		; Title Card - Light blue tiles that appear on the bottom and right
; ---------------------------------------------------------------------------
TCBG_TileA:
		dc.w	$0020					; 20 Bytes (1 tile)
		dc.l	$00000006				; jump forward 6 bytes to art
		incbin  Uncompressed\Artunc_TCBGA.bin		; Title Card - Red thin bar that appears from the right
; ---------------------------------------------------------------------------
TCBG_TileB:
		dc.w	$0040					; 40 Bytes (2 tiles)
		dc.l	$00000006				; jump forward 6 bytes to art
		incbin  Uncompressed\Artunc_TCBGB.bin		; Title Card - White Zig-Zag tiles that appear overlapping the light Gray/Blue Bar that appears from top right
; ---------------------------------------------------------------------------
TCBG_TileC:
		dc.w	$0040					; 40 Bytes (2 tiles)
		dc.l	$00000006				; jump forward 6 bytes to art
		incbin  Uncompressed\Artunc_TCBGC.bin		; Title Card - White Zig-Zag tiles that appear overlapping middle section
; ---------------------------------------------------------------------------
TCBG_TileD:
		dc.w	$0040					; 40 Bytes (2 tiles)
		dc.l	$00000006				; jump forward 6 bytes to art
		incbin  Uncompressed\Artunc_TCBGD.bin		; Title Card - Light blue Zig-Zag tiles (The Light blue tiles overlapping the white Zig-Zag tiles basically)
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Nemesis Compressed Object Patterns
; ---------------------------------------------------------------------------
ARTNEM_Springs:
	incbin	NemesisComp\ArtnemSprings.bin			; Red and Yellow Springs
	even
; ---------------------------------------------------------------------------
ARTNEM_SpikesHoz:
	incbin	NemesisComp\ArtnemSpikesHorizontal.bin		; Horizontal Spikes
	even
; ---------------------------------------------------------------------------
ARTNEM_SpikesVer:
	incbin	NemesisComp\ArtnemSpikesVertical.bin		; Vertical Spikes
	even
; ---------------------------------------------------------------------------
ARTNEM_Goal:
	incbin	NemesisComp\ArtnemGoal.bin		; Vertical Spikes
	even
; ---------------------------------------------------------------------------
ARTNEM_Monitor:
	incbin	NemesisComp\ArtnemMonitors.bin		; Vertical Spikes
	even
; ---------------------------------------------------------------------------
ArtnemRHZ_TitleCard:
	incbin	NemesisComp\ArtnemRHZ_TitleCard.bin		; Vertical Spikes
	even
; ---------------------------------------------------------------------------
ArtnemAPZ_TitleCard:
	incbin	NemesisComp\ArtnemAPZ_TitleCard.bin		; Vertical Spikes
	even
; ---------------------------------------------------------------------------
ArtnemIIZ_TitleCard:
	incbin	NemesisComp\ArtnemIIZ_TitleCard.bin		; Vertical Spikes
	even
; ---------------------------------------------------------------------------
ArtnemFLRA_TitleCard:
	incbin	NemesisComp\ArtnemFLRA_TitleCard.bin		; Vertical Spikes
	even
; ===========================================================================
; ---------------------------------------------------------------------------
; Sprite Mappings - "Sprngs" and "Spikes" Objects
; ---------------------------------------------------------------------------
	include	"PLCMAPANI\MAP_Springs.asm"			; Spring Mappings
	include	"PLCMAPANI\MAP_Spikes.asm"			; Spikes Mappings
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Animation for Springs
; ---------------------------------------------------------------------------

unk_42358:		dc.b $FF,$64,$FF,$70,$FF,$7C		; LR Red spring
unk_4235E:		dc.b $FF,$82,$FF,$8E,$FF,$9A
unk_42364:		dc.b $FF,$A0,$FF,$AC,$FF,$B8

; ===========================================================================
; ---------------------------------------------------------------------------
; Object Positioning
; ---------------------------------------------------------------------------
;
; Format:	dc.w	$XXXX,$YYYY,$AAAA,$FFFF
;
; XXXX 	=	Object's X Position (If FFFF is placed in X position then it's the end of the Object position file)
; YYYY	=	Object's Y Position
; AAAA	=	Object's ID
; FFFF	=	End of Object's position code (Unless the object is a pathswapper)
;
; ---------------------------------------------------------------------------
; List of Valid and Invalid Object ID's
;
; AAAA = changes exactly what object is being placed (This cannot be an odd value or the engine will crash)
;
SpringRed_Right		=	$00
SpringRed_Left		=	$04
SpringRed_Up		=	$08
SpringRed_Down		=	$0C
Goal				=	$10
DiagRedSprngRU		=	$14
DiagRedSprngLU		=	$18
DiagRedSprngRD		=	$1C
DiagRedSprngLD		=	$20
Monitor				=	$24
LostRing			=	$28
;					=	$2C
;					=	$30
SpringYel_Right		=	$34
SpringYel_Left		=	$38
SpringYel_Up		=	$3C
SpringYel_Down		=	$40
DiagYelSprngRU		=	$44
DiagYelSprngLU		=	$48
DiagYelSprngRD		=	$4C
DiagYelSprngLD		=	$50
Spikes_Up			=	$54
Spikes_Down			=	$58
Spikes_Right		=	$5C
Spikes_Left			=	$60
DiagSpik_RU			=	$64
DiagSpik_LU			=	$68
DiagSpik_RD			=	$6C
DiagSpik_LD			=	$70
Swapper1			=	$74
Swapper2			=	$78
;
; AAAA -> 72 or Higher=	These are either pathswappers, blank, invalid, gliches of previous objects, lag the engine, or crash (as far as I've seen)
;			note: some pathswappers crash on TTZ (Not sure why though)
; ---------------------------------------------------------------------------
; ===========================================================================
ObjLayout:	macro	x,	y,	o,	s
		dc.w	x,	y
		dc.b	$00,	o
		dc.w	s
		endm
ObjLayout_End:	macro	
		dc.w	$FFFF
		endm
; --------------------------------------------------------------------------
Objpos_SSZ:
	incbin	Uncompressed\Objpos_SSZ.bin			; Speed Slider Zone's Object Position
	even
; ---------------------------------------------------------------------------
Objpos_TTZ:
	;dc.w	$0100,$0E00,$0000,$FFFF
	
	ObjLayout	$03F0,	$0298,	SpringRed_Up,    $FFFF
	ObjLayout	$0410,	$0298,	SpringRed_Up,    $FFFF
	ObjLayout	$0488,	$0850,	SpringRed_Right, $FFFF
	ObjLayout	$0513,	$070D,	DiagRedSprngRU,  $FFFF
	ObjLayout	$0513,	$060D,	DiagRedSprngRU,  $FFFF
	ObjLayout	$07CD,	$076D,	DiagRedSprngLU,  $FFFF
	ObjLayout	$07CD,	$068D,	DiagRedSprngLU,  $FFFF
	ObjLayout	$07CD,	$058D,	DiagRedSprngLU,  $FFFF
	ObjLayout	$0610,	$09F0,	Spikes_Up,       $FFFF
	ObjLayout	$0450,	$0810,	Spikes_Up,       $FFFF
	ObjLayout	$0190,	$0170,	Spikes_Up,       $FFFF
	ObjLayout	$0670,	$0170,	Spikes_Up,       $FFFF
	ObjLayout	$07D0,	$01F0,	Spikes_Up,       $FFFF
	ObjLayout	$0330,	$0770,	Spikes_Down,     $FFFF
	ObjLayout	$0350,	$0770,	Spikes_Down,     $FFFF
	ObjLayout	$0370,	$0770,	Spikes_Down,     $FFFF
	ObjLayout	$0038,	$0280,	DiagSpik_RU,     $FFFF
	ObjLayout	$07B0,	$0C98,	SpringRed_Up,    $FFFF
	ObjLayout	$0030,	$0B70,	DiagRedSprngRU,  $FFFF
	ObjLayout	$0370,	$0738,	SpringRed_Up,    $FFFF
	ObjLayout	$07D0,	$0C98,	SpringRed_Up,    $FFFF
	ObjLayout	$0790,	$0C98,	SpringRed_Up,    $FFFF
	ObjLayout	$00B0,	$0B78,	SpringYel_Up,    $FFFF
	ObjLayout	$0034,	$06ED,	DiagRedSprngRU,  $FFFF
	ObjLayout	$0400,	$0060,	Goal,			 $FFFF
	ObjLayout	$0140, 	$0E50,	Monitor,		 $FFFF
	ObjLayout	$0160, 	$0E50,	Monitor,		 $FFFF
	ObjLayout	$0180, 	$0E50,	Monitor,		 $FFFF
	ObjLayout	$01A0, 	$0E50,	Monitor,		 $FFFF
	ObjLayout_End
	even
	
Objpos_IIZ:
	incbin	Uncompressed\Objpos_IIZ.bin			; Speed Slider Zone's Object Position
	even	
Objpos_FLRA:
	incbin	Uncompressed\Objpos_FLRA.bin			; Speed Slider Zone's Object Position
	even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Multiple Uncompressed Data
; ---------------------------------------------------------------------------
; uncompressed Art (Used for Animating)
; ---------------------------------------------------------------------------
ARTUNC_TTZAnimatedFanFG1:
	incbin	 Uncompressed\ArtuncTTZAnimatedFanFG1.bin	; Fan tiles 1
	even
; ---------------------------------------------------------------------------
ARTUNC_TTZAnimatedFanFG2:
	incbin	 Uncompressed\ArtuncTTZAnimatedFanFG2.bin	; Fan tiles 2
	even
; ---------------------------------------------------------------------------
ARTUNC_TTZAnimatedTurbineBG1:
	incbin  Uncompressed\ArtuncTTZAnimatedTurbineBG1.bin	; Turbine tiles 1
	even
; ---------------------------------------------------------------------------
ARTUNC_TTZAnimatedTurbineBG2:
	incbin  Uncompressed\ArtuncTTZAnimatedTurbineBG2.bin	; Turbine tiles 2
	even
; ---------------------------------------------------------------------------
ARTUNC_TTZAnimatedTurbineBG3:
	incbin  Uncompressed\ArtuncTTZAnimatedTurbineBG3.bin	; Turbine tiles 3
	even
; ---------------------------------------------------------------------------
ARTUNC_TTZAnimatedTurbineBG4:
	incbin  Uncompressed\ArtuncTTZAnimatedTurbineBG4.bin	; Turbine tiles 4
	even
; ---------------------------------------------------------------------------
ARTUNC_TTZAnimatedTurbineBG5:
	incbin  Uncompressed\ArtuncTTZAnimatedTurbineBG5.bin	; Turbine tiles 5
	even
; ---------------------------------------------------------------------------
ARTUNC_TTZAnimatedTurbineBG6:
	incbin  Uncompressed\ArtuncTTZAnimatedTurbineBG6.bin	; Turbine tiles 6
	even
; ---------------------------------------------------------------------------
ARTUNC_TTZAnimatedTurbineBG7:
	incbin  Uncompressed\ArtuncTTZAnimatedTurbineBG7.bin	; Turbine tiles 7
	even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Multiple Uncompressed Art (some of these are unused)
; ---------------------------------------------------------------------------
AniArt_Combi:							; "COMBI" (Unused)
	incbin	Uncompressed\Artunc_Combi_Un.bin
AniArt_Limits:							; "LIMITS" (Unused)
	incbin	Uncompressed\Artunc_Limits_Un.bin
AniArt_StripBlock:						; Striped Block (Unused)
	incbin	Uncompressed\Artunc_StripBlock_Un.bin
AniArt_Score:							; "SCORE" (Unused)
	incbin	Uncompressed\Artunc_Score_Un.bin
AniArt_Rings:							; "RINGS" (Unused)
	incbin	Uncompressed\Artunc_Rings_Un.bin
AniArt_SLTime:							; "/TIME" (Unused)
	incbin	Uncompressed\Artunc_SLTime_Un.bin
AniArt_Hud1to9_Sym:						; "0" to "9" Hud (Exclaimation Mark, and Minute/Second Symbol)
	incbin	Uncompressed\Artunc_Hud0to9_Sym.bin
AniArt_RingSprites:						; Ring Sprites
	incbin	Uncompressed\Artunc_Spark_Ring.bin
AniArt_Tether:							; Tether Star Sprites
	incbin	Uncompressed\Artunc_Tether.bin
AniArt_MultiStars:						; Multiple Stars (Unused)
	incbin	Uncompressed\Artunc_MultipleStars_Un.bin
AniArt_MiliSymbol:						; "''" (Second/Mili-Second Symbol)
	incbin	Uncompressed\Artunc_Hud_Sym2.bin
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Field Data (Palettes, Art, Mappings)
; ---------------------------------------------------------------------------
; Rainbow Field
; ---------------------------------------------------------------------------

PAL_RainbowField:
	incbin	 Palettes\PalRainbowField.bin			; Palettes for Rainbow Field
	even

; ===========================================================================
; ---------------------------------------------------------------------------
ARTCRA_RainbowField8x8:
	dc.w	$0001						; Number of entries
	dc.w	$2000						; V-Ram location to dump the art
	dc.w	($4060/$20)					; size divided by 20
	incbin  CrackersComp\ArtcraRainbowField_01.bin		; 8x8 tiles for Rainbow Field (Entry 00)
	even
	dc.w	$6100						; V-Ram location to dump the art
	dc.w	($38E0/$20)					; size divided by 20
	incbin  CrackersComp\ArtcraRainbowField_02.bin		; 8x8 tiles for Rainbow Field (Entry 01)
	even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
MAPUNC_RainbowFieldFG:
	dc.w	$0003						; number of entries
	dc.w	$0000						; V-Ram location to dump the mappings
	dc.w	$C100						; priority/colour/flip/mirror settings to add
	dc.w	$001F						; number of X tiles to dump
	dc.w	$001F						; number of Y lines to dump
	incbin  Uncompressed\MapuncRainbowFieldFG_01.bin	; Screen Map Codes for Rainbow Field FG (Entry 00)
	even
	dc.w	$0040						; V-Ram location to dump the mappings
	dc.w	$C100						; priority/colour/flip/mirror settings to add
	dc.w	$001F						; number of X tiles to dump
	dc.w	$001F						; number of Y lines to dump
	incbin  Uncompressed\MapuncRainbowFieldFG_02.bin	; Screen Map Codes for Rainbow Field FG (Entry 01)
	even
	dc.w	$1000						; V-Ram location to dump the mappings
	dc.w	$C100						; priority/colour/flip/mirror settings to add
	dc.w	$001F						; number of X tiles to dump
	dc.w	$001F						; number of Y lines to dump
	incbin  Uncompressed\MapuncRainbowFieldFG_03.bin	; Screen Map Codes for Rainbow Field FG (Entry 02)
	even
	dc.w	$1040						; V-Ram location to dump the mappings
	dc.w	$C100						; priority/colour/flip/mirror settings to add
	dc.w	$001F						; number of X tiles to dump
	dc.w	$001F						; number of Y lines to dump
	incbin  Uncompressed\MapuncRainbowFieldFG_04.bin	; Screen Map Codes for Rainbow Field FG (Entry 03)
	even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
MAPUNC_RainbowFieldBG:
	dc.w	$0001						; number of entries
	dc.w	$0000						; V-Ram location to dump the mappings
	dc.w	$6308						; priority/colour/flip/mirror settings to add
	dc.w	$001F						; number of X tiles to dump
	dc.w	$001F						; number of Y lines to dump
	incbin  Uncompressed\MapuncRainbowFieldBG_01.bin	; Screen Map Codes for Rainbow Field BG (Entry 00)
	even
	dc.w	$0040						; V-Ram location to dump the mappings
	dc.w	$6308						; priority/colour/flip/mirror settings to add
	dc.w	$001F						; number of X tiles to dump
	dc.w	$001F						; number of Y lines to dump
	incbin  Uncompressed\MapuncRainbowFieldBG_02.bin	; Screen Map Codes for Rainbow Field BG (Entry 01)
	even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Electric Field
; ---------------------------------------------------------------------------

PAL_ElectricField:
	incbin  Palettes\PalElectricField.bin			; Palettes for Electric Field
	even

; ===========================================================================
; ---------------------------------------------------------------------------
ARTCRA_ElectricField8x8:
	dc.w	$0001						; Number of entries
	dc.w	$0900						; V-Ram location to dump the art
	dc.w	($4E60/$20)					; size divided by 20
	incbin	CrackersComp\ArtcraElectricField_01.bin		; 8x8 tiles for Electric Field (Entry 00)
	even
	dc.w	$5B00						; V-Ram location to dump the art
	dc.w	($2DC0/$20)					; size divided by 20
	incbin	CrackersComp\ArtcraElectricField_02.bin		; 8x8 tiles for Electric Field (Entry 01)
	even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
MAPUNC_ElectricFieldFG:
	dc.w	$0003						; number of entries
	dc.w	$0000						; V-Ram location to dump the mappings
	dc.w	$C048						; priority/colour/flip/mirror settings to add
	dc.w	$001F						; number of X tiles to dump
	dc.w	$001F						; number of Y lines to dump
	incbin  Uncompressed\MapuncElectricFieldFG_01.bin	; Screen Map Codes for Electric Field FG (Entry 00)
	even
	dc.w	$0040						; V-Ram location to dump the mappings
	dc.w	$C048						; priority/colour/flip/mirror settings to add
	dc.w	$001F						; number of X tiles to dump
	dc.w	$001F						; number of Y lines to dump
	incbin  Uncompressed\MapuncElectricFieldFG_02.bin	; Screen Map Codes for Electric Field FG (Entry 01)
	even
	dc.w	$1000						; V-Ram location to dump the mappings
	dc.w	$C048						; priority/colour/flip/mirror settings to add
	dc.w	$001F						; number of X tiles to dump
	dc.w	$001F						; number of Y lines to dump
	incbin  Uncompressed\MapuncElectricFieldFG_03.bin	; Screen Map Codes for Electric Field FG (Entry 02)
	even
	dc.w	$1040						; V-Ram location to dump the mappings
	dc.w	$C048						; priority/colour/flip/mirror settings to add
	dc.w	$001F						; number of X tiles to dump
	dc.w	$001F						; number of Y lines to dump
	incbin  Uncompressed\MapuncElectricFieldFG_04.bin	; Screen Map Codes for Electric Field FG (Entry 03)
	even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
MAPUNC_ElectricFieldBG:
	dc.w	$0002						; number of entries
	dc.w	$1000						; V-Ram location to dump the mappings
	dc.w	$62D8						; priority/colour/flip/mirror settings to add
	dc.w	$0033						; number of X tiles to dump
	dc.w	$000F						; number of Y lines to dump
	incbin  Uncompressed\MapuncElectricFieldBG_01.bin	; Screen Map Codes for Electric Field BG (Entry 00)
	even
	dc.w	$0800						; V-Ram location to dump the mappings
	dc.w	$62D8						; priority/colour/flip/mirror settings to add
	dc.w	$0033						; number of X tiles to dump
	dc.w	$000F						; number of Y lines to dump
	incbin  Uncompressed\MapuncElectricFieldBG_02.bin	; Screen Map Codes for Electric Field BG (Entry 01)
	even
	dc.w	$0000						; V-Ram location to dump the mappings
	dc.w	$62D8						; priority/colour/flip/mirror settings to add
	dc.w	$0033						; number of X tiles to dump
	dc.w	$000F						; number of Y lines to dump
	incbin  Uncompressed\MapuncElectricFieldBG_03.bin	; Screen Map Codes for Electric Field BG (Entry 02)
	even
; ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Align to $00060000, Sonic's Arms
; ---------------------------------------------------------------------------
AL07:		dcb.b ($00060000+AlignValue)-AL07,$FF	; Aligned
; ---------------------------------------------------------------------------
ARTUNC_SonicArms:
	incbin	 Uncompressed\ArtuncSonicArms.bin	; Sonic's Arms
	even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Align to $00064000, Tails' Arms
; ---------------------------------------------------------------------------
AL08:		dcb.b ($00064000+AlignValue)-AL08,$FF	; Aligned
; ---------------------------------------------------------------------------
ARTUNC_TailsArms:
	incbin	 Uncompressed\ArtuncTailsArms.bin	; Tails' Arms
	even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; PLC, Mappings & Main Index Block - Sonic's Arm
; ---------------------------------------------------------------------------
PLCMAP_SonArm_MainIndex:
	include	"PLCMAPANI\PLCMAP_IndxBlck_SonicArm.asm"
; ---------------------------------------------------------------------------
PLC_SonicArm:
	include	"PLCMAPANI\PLC_SonicArm.asm"
; ---------------------------------------------------------------------------
Map_SonicArm:
	include	"PLCMAPANI\MAP_SonicArm.asm"
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Animation, PLC, Mappings & Main Index Block - Sonic
; ---------------------------------------------------------------------------
ANI_Sonic:
	include	"PLCMAPANI\ANI_Sonic.asm"
; ---------------------------------------------------------------------------
PLCMAP_Sonic_MainIndex:
	include	"PLCMAPANI\PLCMAP_IndxBlck_Sonic.asm"
; ---------------------------------------------------------------------------
PLCMAP_Sonic2_MainIndex:
	include	"PLCMAPANI\PLCMAP_IndxBlck_Sonic2.asm"
; ---------------------------------------------------------------------------
PLC_Sonic:
	include	"PLCMAPANI\PLC_Sonic.asm"
; ---------------------------------------------------------------------------
MAP_Sonic:
	include	"PLCMAPANI\MAP_Sonic.asm"
; ---------------------------------------------------------------------------
MAP_Sonic2:
	include	"PLCMAPANI\MAP_Sonic2.asm"
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; PLC, Mappings & Main Index Block - Tails' Arm
; ---------------------------------------------------------------------------
PLCMAP_TalArm_MainIndex:
	include	"PLCMAPANI\PLCMAP_IndxBlck_TailsArm.asm"
; ---------------------------------------------------------------------------
PLC_TailsArm:
	include	"PLCMAPANI\PLC_TailsArm.asm"
; ---------------------------------------------------------------------------
MAP_TailsArm:
	include	"PLCMAPANI\MAP_TailsArm.asm"
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Animation, PLC, Mappings & Main Index Block - Tails
; ---------------------------------------------------------------------------
ANI_Tails:
	include	"PLCMAPANI\ANI_Tails.asm"
; ---------------------------------------------------------------------------
PLCMAP_Tails_MainIndex:
	include	"PLCMAPANI\PLCMAP_IndxBlck_Tails.asm"
; ---------------------------------------------------------------------------
PLC_Tails:
	include	"PLCMAPANI\PLC_Tails.asm"
; ---------------------------------------------------------------------------
MAP_Tails:
	include	"PLCMAPANI\MAP_Tails.asm"
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Animation, PLC, Mappings & Main Index Block - Sonic Fields
; ---------------------------------------------------------------------------
ANI_SonicFields:
	include	"PLCMAPANI\ANI_SonicFields.asm"
; ---------------------------------------------------------------------------
PLCMAP_SonicFields_MainIndex:
	include	"PLCMAPANI\PLCMAP_IndxBlck_SonicFields.asm"
; ---------------------------------------------------------------------------
PLC_SonicFields:
	include	"PLCMAPANI\PLC_SonicFields.asm"
; ---------------------------------------------------------------------------
Map_SonicFields:
	include	"PLCMAPANI\MAP_SonicFields.asm"
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Animation, PLC, Mappings & Main Index Block - Tails Fields
; ---------------------------------------------------------------------------
ANI_TailsFields:
	include	"PLCMAPANI\ANI_TailsFields.asm"
; ---------------------------------------------------------------------------
PLCMAP_TailsFields_MainIndex:
	include	"PLCMAPANI\PLCMAP_IndxBlck_TailsFields.asm"
; ---------------------------------------------------------------------------
PLC_TailsFields:
	include	"PLCMAPANI\PLC_TailsFields.asm"
; ---------------------------------------------------------------------------
Map_TailsFields:
	include	"PLCMAPANI\MAP_TailsFields.asm"
; ---------------------------------------------------------------------------
; ===========================================================================

; ---------------------------------------------------------------------------
; Uncompressed Art - Sonic
; ---------------------------------------------------------------------------
AU06:		dcb.b ($00080000+AlignValue)-AU06,$FF		; Aligned
; ---------------------------------------------------------------------------
ARTUNC_Sonic:	incbin	Uncompressed\ArtuncSonic.bin
		even

; ===========================================================================

; ===========================================================================
; ---------------------------------------------------------------------------
; Uncompressed Art - Sonic Fields
; ---------------------------------------------------------------------------
AU06_B:		dcb.b ($00090000+AlignValue)-AU06_B,$FF		; Aligned
; ---------------------------------------------------------------------------
ARTUNC_SonicField:
		incbin  Uncompressed\ArtuncSonicField.bin
		even


; ---------------------------------------------------------------------------
; Aligned to $000A0000, Uncompressed Art - Tails
; ---------------------------------------------------------------------------
AU08_B:		dcb.b ($000A0000+AlignValue)-AU08_B,$FF		; Aligned
; ---------------------------------------------------------------------------
ARTUNC_Tails:	incbin	Uncompressed\ArtuncTails.bin
		even


; ---------------------------------------------------------------------------
; Aligned to $000B0000, Uncompressed Art - Tails Field
; ---------------------------------------------------------------------------
AU0A:		dcb.b ($000B0000+AlignValue)-AU0A,$FF		; Aligned
; ---------------------------------------------------------------------------
ARTUNC_TailsField:
		incbin  Uncompressed\ArtuncTailsField.bin
		even
; ---------------------------------------------------------------------------
MAPENI_FLRA128x128_FG:
	incbin  EnigmaComp\MapeniFLRA128x128FG.bin		; 128x128 chunks for TTZ FG
	even
; ---------------------------------------------------------------------------
MAPENI_FLRA16x16_FG:
	incbin  EnigmaComp\MapeniFLRA16x16FG.bin		; 128x128 chunks for TTZ FG
	even
; ---------------------------------------------------------------------------
MAPENI_FLRALayout_FG:
	incbin  EnigmaComp\MapeniFLRALayoutFG.bin		; Layout for TTZ FG
	even
; ---------------------------------------------------------------------------
ARTNEM_FLRA8x8_FG:
	incbin	 NemesisComp\ArtnemFLRA8x8FG.bin			; 8x8 tiles for TTZ FG
	even
; ---------------------------------------------------------------------------
COL_FLRAPrimary:	
	incbin	Collision\ColFLRAPrimary.bin			; Primary Collisions for TTZ
	even
; ---------------------------------------------------------------------------
COL_FLRASecondary:
	incbin	 Collision\ColFLRASecondary.bin			; Secondary Collisions for TTZ
	even
	
; ==============================================================
; --------------------------------------------------------------
; Debugging modules
; --------------------------------------------------------------

   include   "ErrorHandler.asm"

; --------------------------------------------------------------
; WARNING!
;	DO NOT put any data from now on! DO NOT use ROM padding!
;	Symbol data should be appended here after ROM is compiled
;	by ConvSym utility, otherwise debugger modules won't be able
;	to resolve symbol names.
; --------------------------------------------------------------