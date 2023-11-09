; ---------------------------------------------------------------------------
; Object 04 - Red Springs (Facing up)
; ---------------------------------------------------------------------------

Obj_RedSpring_Up:				
		moveq	#$07,d0
		bclr	d0,$28(a6)
		beq.s	Obj04_SonicChk
		move.l	#Map_SpringUp,$10(a6)			; 	set mappings to use
		move.w	#$0407,$20(a6)					;	set VRAM location
		move.w	#$8080,4(a6)					
		move.b	#$10,$22(a6)					;	set width of solid object (16)
		move.b	#$08,$23(a6)					;	set height of solid object (8)
		move.w	#$0000,$2A(a6)					;	clear object flags
; ---------------------------------------------------------------------------

Obj04_SonicChk:				
		movea.w	($FFFFD862).w,a0				;	load Sonic's object RAM to a0
		move.w	#$000F,d0
		jsr	(SolidObject).l						;	get and set the solidiness
		beq.s	Obj04_TailsChk					;	if d0 returned null, branch to skip and check Tails
		move.w	$08(a6),d0						;	load object's X position to d0
		move.w	$0C(a6),d1						;	load object's Y position to d1
		move.w	$08(a0),d2						;	load character's X position to d2
		move.w	$0C(a0),d3						;	load character's Y position to d3
		bsr.w	Distance_GetSet					;	get distance flags
		cmpi.w	#$07,d4							;	is object on top side, above and closer to character on X?
		beq.s	Obj04_SonSetAni					;	if so, branch
		cmpi.w	#$06,d4							;	is object on top side, below and closer to character on X?
		beq.s	Obj04_SonSetAni					;	if so, branch
		bra.s	Obj04_TailsChk					;	continue to check Tails

Obj04_SonSetAni:
		move.b	#$A8,d0							;	set SFX ID
		jsr		Play_Sound						;	play SFX
		ori.w	#$01,$2A(a6)					;	set flag to animate spring
		move.l	#$000F0000,d1					;	set the power of the spring
		neg.l	d1								;	clear d1
		moveq	#$00,d0
		jsr	(loc_CB1C).l
; ---------------------------------------------------------------------------

Obj04_TailsChk:				
		movea.w	($FFFFD864).w,a0				;	load Tails's object RAM to a0
		move.w	#$000F,d0						;	
		jsr	(SolidObject).l						;	set and get the solidiness
		beq.s	Obj04_ChkAni					;	if d0 returned null, branch to skip and check animation
		move.w	$08(a6),d0						;	load object's X position to d0
		move.w	$0C(a6),d1						;	load object's Y position to d1
		move.w	$08(a0),d2						;	load character's X position to d2
		move.w	$0C(a0),d3						;	load character's Y position to d3
		bsr.w	Distance_GetSet					;	get distance flags
		cmpi.w	#$07,d4							;	is object on top side, above and closer to character on X?
		beq.s	Obj04_TalSetAni					;	if so, branch
		cmpi.w	#$06,d4							;	is object on top side, below and closer to character on X?
		beq.s	Obj04_TalSetAni					;	if so, branch
		bra.s	Obj04_ChkAni					;	continue to check animation

Obj04_TalSetAni:
		ori.w	#$01,$2A(a6)					;	set flags to animate spring
		move.l	#$000F0000,d1					;	set the power of the spring
		neg.l	d1								;	clear d1
		moveq	#$00,d0
		jsr	(loc_CB1C).l
; ---------------------------------------------------------------------------

Obj04_ChkAni:				
		move.w	$2A(a6),d0                      ; load flags to d0
		btst	#0,d0                           ; was the animation flag set?
		beq.s	Obj04_ChkSprite                 ; if not, branch
		lea	(unk_4235E).l,a0                    
		lea	(word_E2A4).l,a1                    ; load spring's Animation script
		bsr.w	AnimateSprite                   ; animate the spring
		cmpi.b	#$FF,d0                         ; has the spring finished animating it's script?
		bne.s	Obj04_ChkSprite                 ; if not, branch
		andi.w	#$FFFE,$2A(a6)                  ; deset animate spring flag
                                                
Obj04_ChkSprite:				                
		bsr.w	SpriteScreenCheck               ; check if sprite is within the screen areas
		bcc.s	Obj04_SpriteOK                  ; if so, branch
		bsr.w	DeleteObject                    ; remove sprite from table (I think)

Obj04_SpriteOK:			
		rts
; ---------------------------------------------------------------------------
