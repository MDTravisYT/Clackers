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
		dc.w	AniRay_Normal-ANI_RAY		; 00 Stand, Look up, Look down
		dc.w	AniRay_Normal-ANI_RAY	; 02 Walking (000* 180*)
		dc.w	AniRay_Normal-ANI_RAY	; 04 Walking (045* 225*)
		dc.w	AniRay_Normal-ANI_RAY	; 06 Walking (090* 270*)
		dc.w	AniRay_Normal-ANI_RAY	; 08 Walking (135* 315*)
		dc.w	AniRay_Normal-ANI_RAY	; 0A Running (000* 180*)
		dc.w	AniRay_Normal-ANI_RAY	; 0C Running (045* 225*)
		dc.w	AniRay_Normal-ANI_RAY	; 0E Running (090* 270*)
		dc.w	AniRay_Normal-ANI_RAY	; 10 Running (135* 315*)
		dc.w	AniRay_Normal-ANI_RAY	; 12 Rolling (Somersault)
		dc.w	AniRay_Normal-ANI_RAY	; 14 Waiting
		dc.w	AniRay_Normal-ANI_RAY	; 16 Balancing (Facing inwards)
		dc.w	AniRay_Normal-ANI_RAY	; 18 Balancing (Facing outwards)
		dc.w	AniRay_Normal-ANI_RAY	; 1A Skiddings
		dc.w	AniRay_Normal-ANI_RAY	; 1C Stand, Look up, Look down
		dc.w	AniRay_Normal-ANI_RAY	; 1E Walking (000* 180*)
		dc.w	AniRay_Normal-ANI_RAY	; 20 Walking (045* 225*)
		dc.w	AniRay_Normal-ANI_RAY	; 22 Walking (090* 270*)
		dc.w	AniRay_Normal-ANI_RAY	; 24 Walking (135* 315*)
		dc.w	AniRay_Normal-ANI_RAY	; 26 Running (000* 180*)
		dc.w	AniRay_Normal-ANI_RAY	; 28 Running (045* 225*)
		dc.w	AniRay_Normal-ANI_RAY	; 2A Running (090* 270*)
		dc.w	AniRay_Normal-ANI_RAY	; 2C Running (135* 315*)
		dc.w	AniRay_Normal-ANI_RAY	; 2E Spindashing
		dc.w	AniRay_Normal-ANI_RAY	; 30 Hurt
		dc.w	AniRay_Normal-ANI_RAY	; 32 fast spinning where sonic looks dizzy
		dc.w	AniRay_Normal-ANI_RAY	; 34 Spring
; ---------------------------------------------------------------------------
AniRay_Normal:	dc.b	$01,$02,$00
		dc.b	$00,$00,$00
		even
; ---------------------------------------------------------------------------
; ===========================================================================