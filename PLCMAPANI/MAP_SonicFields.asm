; ===========================================================================
; ---------------------------------------------------------------------------
; Mappings - Sonic Fields
; ---------------------------------------------------------------------------
; Guide as Documented by Hivebrain
;
;	Each mappings block consists of six bytes:
;
;		dc.b	$SS,$YY,$TT,$TT,$XX,$ZZ
;
;	$SS   = Shape and size of sprite piece
;	$YY   = Y position of sprite piece
;	$TTTT = Tile to read in VRam
;	$XX   = X position of sprite piece
;	$ZZ   = whether it's the last map to use in the sprite or not (00 Include next map in sprite/FF End of sprite)
;
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
MapSonFld_StandForward:	dc.b	$0A,$F0,$05,$00,$F4,$00			; standing (Facing forwards)
			dc.b	$0D,$08,$05,$09,$EC,$FF
MapSonFld_StandLftRht:	dc.b	$09,$F0,$05,$00,$F6,$00			; standing (Facing left or right)
			dc.b	$0A,$00,$05,$06,$F4,$FF
MapSonFld_StandBckward:	dc.b	$0A,$F0,$05,$00,$F4,$00			; standing (facing backwards)
			dc.b	$0D,$08,$05,$09,$F4,$FF
; ---------------------------------------------------------------------------
MapSonFld_WalkDwn_1:	dc.b	$0A,$F0,$05,$00,$F4,$00			; Walk Down 1
			dc.b	$05,$08,$05,$09,$F7,$FF
MapSonFld_WalkDwn_2:	dc.b	$0A,$F0,$05,$00,$F4,$00			; Walk Down 2
			dc.b	$09,$08,$05,$09,$F0,$FF
MapSonFld_WalkDwn_3:	dc.b	$0F,$F4,$05,$00,$EC,$FF			; Walk Down 3
MapSonFld_WalkDwn_4:	dc.b	$0F,$F0,$05,$00,$EC,$FF			; Walk Down 4
MapSonFld_WalkDwn_5:	dc.b	$0E,$F0,$05,$00,$EC,$00			; Walk Down 5
			dc.b	$05,$08,$05,$0C,$F9,$FF
MapSonFld_WalkDwn_6:	dc.b	$09,$F0,$05,$00,$F4,$00			; Walk Down 6
			dc.b	$0E,$00,$05,$06,$EC,$FF
MapSonFld_WalkDwn_7:	dc.b	$0F,$F4,$05,$00,$EC,$FF			; Walk Down 7
MapSonFld_WalkDwn_8:	dc.b	$0B,$F1,$05,$00,$F3,$FF			; Walk Down 8
; ---------------------------------------------------------------------------
MapSonFld_WalkLR_1:	dc.b	$0F,$F0,$05,$00,$F0,$00			; Walk Left or Right 1
			dc.b	$00,$FF,$05,$10,$10,$FF
MapSonFld_WalkLR_2:	dc.b	$0F,$F3,$05,$00,$F0,$00			; Walk Left or Right 2
			dc.b	$04,$13,$05,$10,$FA,$FF
MapSonFld_WalkLR_3:	dc.b	$0F,$F0,$05,$00,$F0,$00			; Walk Left or Right 3
			dc.b	$00,$10,$05,$10,$00,$FF
MapSonFld_WalkLR_4:	dc.b	$0F,$F0,$05,$00,$F0,$00			; Walk Left or Right 4
			dc.b	$00,$10,$05,$10,$04,$FF
MapSonFld_WalkLR_5:	dc.b	$0F,$F0,$05,$00,$F0,$FF			; Walk Left or Right 5
MapSonFld_WalkLR_6:	dc.b	$0F,$F0,$05,$00,$F0,$FF			; Walk Left or Right 6
MapSonFld_WalkLR_7:	dc.b	$0F,$F0,$05,$00,$F0,$FF			; Walk Left or Right 7
MapSonFld_WalkLR_8:	dc.b	$0F,$F0,$05,$00,$F0,$00			; Walk Left or Right 8
			dc.b	$00,$FE,$05,$10,$10,$FF
; ---------------------------------------------------------------------------
MapSonFld_WalkUp_1:	dc.b	$0B,$F0,$05,%00,$F4,$00			; Walk Up 1
			dc.b	$00,$10,$05,$0C,$00,$FF
MapSonFld_WalkUp_2:	dc.b	$0B,$F1,$05,$00,$F4,$FF			; Walk Up 2
MapSonFld_WalkUp_3:	dc.b	$0F,$F4,$05,$00,$F4,$FF			; Walk Up 3
MapSonFld_WalkUp_4:	dc.b	$0F,$F0,$05,$00,$F4,$00			; Walk Up 4
			dc.b	$00,$10,$05,$10,$F9,$FF
MapSonFld_WalkUp_5:	dc.b	$0F,$F0,$05,$00,$F4,$00			; Walk Up 5
			dc.b	$00,$10,$05,$10,$F9,$FF
MapSonFld_WalkUp_6:	dc.b	$0F,$F1,$05,$00,$F4,$FF			; Walk Up 6
MapSonFld_WalkUp_7:	dc.b	$0F,$F4,$05,$00,$F4,$FF			; Walk Up 7
MapSonFld_WalkUp_8:	dc.b	$0B,$F0,$05,$00,$F4,$00			; Walk Up 8
			dc.b	$00,$10,$05,$0C,$00,$FF
; ---------------------------------------------------------------------------
MapSonFld_UncBall_1:	dc.b	$0F,$F0,$05,$00,$F0,$FF			; Ball frame 1 (Rolling/jumping) (Unused)
MapSonFld_UncBall_2:	dc.b	$0F,$00,$05,$00,$00,$FF			; Ball frame 2 (Rolling/jumping) (Unused)
MapSonFld_UncBall_3:	dc.b	$0F,$00,$05,$00,$00,$FF			; Ball frame 3 (Rolling/jumping) (Unused)
			even
; ---------------------------------------------------------------------------
; ===========================================================================