; ===========================================================================
; ---------------------------------------------------------------------------
; Animation scripts - Sonic
; ---------------------------------------------------------------------------
;
; Each animation script starts with 3 bytes of data
;
;		dc.b	$XX,$YY,$ZZ
;
;	$XX   = Speed to run animation at (00 Slow/3F Fast)
;		(Note: if it is 40, then it's a special animation speed that
;		is controled by routines somewhere)
;	$YY   = Number of frames within script
;	$ZZ   = (unknown)
;
; Then each byte in the line under, is each frame to use in that specific script
; (Basically the same as S1 and S2)
;
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
		dc.w	AniSon_Normal-ANI_Sonic		; Stand, Look up, Look down
		dc.w	AniSon_Walk000-ANI_Sonic	; Walking (000* 180*)
		dc.w	AniSon_Walk045-ANI_Sonic	; Walking (045* 225*)
		dc.w	AniSon_Walk090-ANI_Sonic	; Walking (090* 270*)
		dc.w	AniSon_Walk135-ANI_Sonic	; Walking (135* 315*)
		dc.w	AniSon_Run000-ANI_Sonic		; Running (000* 180*)
		dc.w	AniSon_Run045-ANI_Sonic		; Running (045* 225*)
		dc.w	AniSon_Run090-ANI_Sonic		; Running (090* 270*)
		dc.w	AniSon_Run135-ANI_Sonic		; Running (135* 315*)
		dc.w	AniSon_Roll-ANI_Sonic		; Rolling (Somersault)
		dc.w	AniSon_Wait-ANI_Sonic		; Waiting
		dc.w	AniSon_Balnce1-ANI_Sonic	; Balancing (Facing inwards)
		dc.w	AniSon_Balnce2-ANI_Sonic	; Balancing (Facing outwards)
		dc.w	AniSon_Skid-ANI_Sonic		; Skiddings
		dc.w	AniSon_Normal-ANI_Sonic		; Stand, Look up, Look down
		dc.w	AniSon_Walk000-ANI_Sonic	; Walking (000* 180*)
		dc.w	AniSon_Walk045-ANI_Sonic	; Walking (045* 225*)
		dc.w	AniSon_Walk090-ANI_Sonic	; Walking (090* 270*)
		dc.w	AniSon_Walk135-ANI_Sonic	; Walking (135* 315*)
		dc.w	AniSon_Run000-ANI_Sonic		; Running (000* 180*)
		dc.w	AniSon_Run045-ANI_Sonic		; Running (045* 225*)
		dc.w	AniSon_Run090-ANI_Sonic		; Running (090* 270*)
		dc.w	AniSon_Run135-ANI_Sonic		; Running (135* 315*)
		dc.w	AniSon_Spindsh-ANI_Sonic	; Spindashing
		dc.w	AniSon_Hurt-ANI_Sonic		; Hurt
		dc.w	AniSon_Dizzy-ANI_Sonic		; fast spinning where sonic looks dizzy
; ---------------------------------------------------------------------------
AniSon_Normal:	dc.b	$01,$02,$00
		dc.b	$00,$01,$02
AniSon_Walk000:	dc.b	$00,$05,$00
		dc.b	$11,$12,$13,$14,$0F,$10,$00
AniSon_Walk045:	dc.b	$00,$05,$00
		dc.b	$17,$18,$19,$1A,$15,$16,$00
AniSon_Walk090:	dc.b	$00,$05,$00
		dc.b	$1D,$1E,$1F,$20,$1B,$1C,$00
AniSon_Walk135:	dc.b	$00,$05,$00
		dc.b	$23,$24,$25,$26,$21,$22,$00
AniSon_Run000:	dc.b	$40,$03,$00
		dc.b	$27,$28,$29,$2A,$00
AniSon_Run045:	dc.b	$40,$03,$00
		dc.b	$2B,$2C,$2D,$2E,$00
AniSon_Run090:	dc.b	$40,$03,$00
		dc.b	$2F,$30,$31,$32,$00
AniSon_Run135:	dc.b	$40,$03,$00
		dc.b	$33,$34,$35,$36,$00
AniSon_Roll:	dc.b	$40,$07,$00
		dc.b	$40,$3C,$40,$3D,$40,$3E,$40,$3F,$00
AniSon_Wait:	dc.b	$20,$03,$00
		dc.b	$04,$05,$04,$05,$00
AniSon_Balnce1:	dc.b	$20,$03,$00
		dc.b	$09,$0A,$0B,$0A,$00
AniSon_Balnce2:	dc.b	$20,$03,$00
		dc.b	$0C,$0D,$0E,$0D,$00
AniSon_Skid:	dc.b	$20,$03,$00
		dc.b	$37,$38,$39,$39,$00
AniSon_Spindsh:	dc.b	$00,$09,$00
		dc.b	$55,$56,$55,$57,$55,$58,$55,$59,$55,$5A,$00
AniSon_Hurt:	dc.b	$00,$00,$00
		dc.b	$03
AniSon_Dizzy:	dc.b	$10,$05,$00
		dc.b	$41,$42,$43,$44,$45,$46,$00
		even
; ---------------------------------------------------------------------------
; ===========================================================================