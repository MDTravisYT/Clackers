; ---------------------------------------------------------------------------
; Object 00 - Red Springs (Facing right)
; ---------------------------------------------------------------------------

Obj_RedSpring_Right:
		moveq	#$07,d0
		bclr	d0,$28(a6)
		beq.s	Obj00_SonicChk
		move.l	#Map_SpringLR,$10(a6)			; set mappings to use
		move.w	#$0407,$20(a6)				; set VRam location
		move.w	#$8080,$04(a6)
		move.b	#$08,$22(a6)				; set Width of solid object
		move.b	#$10,$23(a6)				; set height of solid object
		move.w	#$0000,$2A(a6)				; clear object flags
; ---------------------------------------------------------------------------

Obj00_SonicChk:
		movea.w	($FFFFD862).w,a0			; load sonic's object ram to a0
		move.w	#$000F,d0
		jsr	(SolidObject).l				; get & set the solidiness
		beq.s	Obj00_TailsChk				; if d0 returned Null, branch to skip & check tails
		move.w	$08(a6),d0				; load object's X position to d0
		move.w	$0C(a6),d1				; load object's Y position to d1
		move.w	$08(a0),d2				; load character's X position to d2
		move.w	$0C(a0),d3				; load character's Y position to d3
		bsr.w	Distance_GetSet				; get distance flags
		cmpi.w	#$00,d4					; is object on left side, above and closer to character on X?
		beq.s	Obj00_SonSetAni				; if so, branch
		cmpi.w	#$02,d4					; is object on left side, below and closer to character on X?
		beq.s	Obj00_SonSetAni				; if so, branch
		bra.s	Obj00_TailsChk				; continue to check tails

Obj00_SonSetAni:
		move.b	#$A8,d0						; set SFX ID
		jsr		Play_Sound					; play SFX
		ori.w	#$01,$2A(a6)				; set flag to animate spring
		move.l	#$000F0000,d0				; set the power of the spring
		moveq	#$00,d1					; clear d1
		jsr	(SpeedToPos).l
; ---------------------------------------------------------------------------

Obj00_TailsChk:
		movea.w	($FFFFD864).w,a0			; load tails's object ram to a0
		move.w	#$000F,d0
		jsr	(SolidObject).l				; get & set the solidiness
		beq.s	Obj00_ChkAni				; if d0 returned Null, branch to skip & check animation
		move.w	$08(a6),d0				; load object's X position to d0
		move.w	$0C(a6),d1				; load object's Y position to d1
		move.w	$08(a0),d2				; load character's X position to d2
		move.w	$0C(a0),d3				; load character's Y position to d3
		bsr.w	Distance_GetSet				; get distance flags
		cmpi.w	#$00,d4					; is object on left side, above and closer to character on X?
		beq.s	Obj00_TalSetAni				; if so, branch
		cmpi.w	#$02,d4					; is object on left side, below and closer to character on X?
		beq.s	Obj00_TalSetAni				; if so, branch
		bra.s	Obj00_ChkAni				; continue to check animation

Obj00_TalSetAni:
		move.b	#$A8,d0							;	set SFX ID
		jsr		Play_Sound						;	play SFX
		ori.w	#$01,$2A(a6)				; set flag to animate spring
		move.l	#$000F0000,d0				; set the power of the spring
		moveq	#$00,d1					; clear d1
		jsr	(SpeedToPos).l
; ---------------------------------------------------------------------------

Obj00_ChkAni:
		move.w	$2A(a6),d0				; load flags to d0
		btst	#$00,d0					; was the animation flag set?
		beq.s	Obj00_ChkSprite				; if not, branch
		lea	(unk_42358).l,a0
		lea	(Ani_SpringLR).l,a1			; load spring's Animation script
		bsr.w	AnimateSprite				; animate the spring
		cmpi.b	#$FF,d0					; has the spring finished animating it's script?
		bne.s	Obj00_ChkSprite				; if not, branch
		andi.w	#$FFFE,$2A(a6)				; deset animate spring flag

Obj00_ChkSprite:
		bsr.w	SpriteScreenCheck			; check if sprite is within the screen areas
		bcc.s	Obj00_SpriteOK				; if so, branch
		bsr.w	DeleteSprite				; remove sprite from table (I think)

Obj00_SpriteOK:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
