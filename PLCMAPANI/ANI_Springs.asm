; Animation scripts for Springs
; ---------------------------------------------------------------------------
; Format:
;	DDNN =	one frame in the animation script.
;
;	DD =	frame duration (The amount of frames to wait before running
;		the next frame)
;	NN =	frame number (The animation frame number to present)
;
;	if NN or DD equals 80, the animation script appears to repeat constantly
;	if NN equals FF, the animation script stops showing the frame after it
; ---------------------------------------------------------------------------

Ani_SpringLR:	dc.w	$0601,$0602,$0600,$82FF,$0100,$8080
word_E2A4:	dc.w	$0601,$0602,$0600,$82FF,$0100,$8080
word_E2B0:	dc.w	$0601,$0802,$0600,$82FF,$0100,$8080
		even
; ---------------------------------------------------------------------------
; ===========================================================================