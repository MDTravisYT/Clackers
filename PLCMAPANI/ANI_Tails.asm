; ===========================================================================
; ---------------------------------------------------------------------------
; Animation scripts - Tails
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
		dc.w	AniTal_Normal-ANI_Tails		; Stand, Look up, Look down
		dc.w	AniTal_Walk000-ANI_Tails	; Walking (000* 180*)
		dc.w	AniTal_Walk045-ANI_Tails	; Walking (045* 225*)
		dc.w	AniTal_Walk090-ANI_Tails	; Walking (090* 270*)
		dc.w	AniTal_Walk135-ANI_Tails	; Walking (135* 315*)
		dc.w	AniTal_Run000-ANI_Tails		; Running (000* 180*)
		dc.w	AniTal_Run045-ANI_Tails		; Running (045* 225*)
		dc.w	AniTal_Run090-ANI_Tails		; Running (090* 270*)
		dc.w	AniTal_Run135-ANI_Tails		; Running (135* 315*)
		dc.w	AniTal_Roll-ANI_Tails		; Rolling (Somersault)
		dc.w	AniTal_Wait-ANI_Tails		; Waiting
		dc.w	AniTal_Balnce1-ANI_Tails	; Balancing (Facing inwards)
		dc.w	AniTal_Balnce2-ANI_Tails	; Balancing (Facing outwards)
		dc.w	AniTal_Skid-ANI_Tails		; Skiddings
		dc.w	AniTal_Normal-ANI_Tails		; Stand, Look up, Look down
		dc.w	AniTal_Walk000-ANI_Tails	; Walking (000* 180*)
		dc.w	AniTal_Walk045-ANI_Tails	; Walking (045* 225*)
		dc.w	AniTal_Walk090-ANI_Tails	; Walking (090* 270*)
		dc.w	AniTal_Walk135-ANI_Tails	; Walking (135* 315*)
		dc.w	AniTal_Run000-ANI_Tails		; Running (000* 180*)
		dc.w	AniTal_Run045-ANI_Tails		; Running (045* 225*)
		dc.w	AniTal_Run090-ANI_Tails		; Running (090* 270*)
		dc.w	AniTal_Run135-ANI_Tails		; Running (135* 315*)
		dc.w	AniTal_Spindsh-ANI_Tails	; Spindashing
		dc.w	AniTal_Hurt-ANI_Tails		; Hurt
		dc.w	AniTal_Dizzy-ANI_Tails		; fast spinning where Tails looks dizzy
; ---------------------------------------------------------------------------
AniTal_Normal:	dc.b	$01,$02,$00
		dc.b	$00,$01,$02
AniTal_Walk000:	dc.b	$00,$07,$00
		dc.b	$0B,$0C,$0D,$0E,$0F,$10,$09,$0A,$00
AniTal_Walk045:	dc.b	$00,$07,$00
		dc.b	$13,$14,$15,$16,$17,$18,$11,$12,$00
AniTal_Walk090:	dc.b	$00,$07,$00
		dc.b	$1B,$1C,$1D,$1E,$1F,$20,$19,$1A,$00
AniTal_Walk135:	dc.b	$00,$07,$00
		dc.b	$23,$24,$25,$26,$27,$28,$21,$22,$00
AniTal_Run000:	dc.b	$40,$01,$00
		dc.b	$29,$2A,$00
AniTal_Run045:	dc.b	$40,$01,$00
		dc.b	$2B,$2C,$00
AniTal_Run090:	dc.b	$40,$01,$00
		dc.b	$2D,$2E,$00
AniTal_Run135:	dc.b	$40,$01,$00
		dc.b	$2F,$30,$00
AniTal_Roll:	dc.b	$80,$17,$00
		dc.b	$33,$32,$31,$33,$32,$31,$33,$32,$31,$33,$32,$31,$33,$32,$31,$33,$32,$31,$33,$32,$31,$33,$32,$31,$00
AniTal_Wait:	dc.b	$20,$25,$14
		dc.b	$04,$03,$00,$00,$00,$00,$00,$00,$00,$00,$04,$03,$00,$00,$00,$00,$00,$00,$00,$00,$05,$05,$05,$05,$05,$05
		dc.b	$06,$07,$08,$07,$08,$07,$08,$07,$08,$07,$08,$06,$00
AniTal_Balnce1:	dc.b	$20,$03,$00
		dc.b	$41,$42,$43,$42,$00
AniTal_Balnce2:	dc.b	$20,$03,$00
		dc.b	$44,$45,$46,$45,$00
AniTal_Skid:	dc.b	$20,$03,$00
		dc.b	$3C,$3D,$3E,$3E,$00
AniTal_Spindsh:	dc.b	$00,$0B,$00
		dc.b	$34,$35,$36,$34,$35,$36,$34,$35,$36,$34,$35,$36,$00
AniTal_Hurt:	dc.b	$00,$00,$00
		dc.b	$37
AniTal_Dizzy:	dc.b	$10,$07,$00
		dc.b	$4C,$4D,$4E,$4F,$50,$51,$52,$53,$00
		even
; ---------------------------------------------------------------------------
; ===========================================================================