; ===========================================================================
; ---------------------------------------------------------------------------
; Mappings - Tails Fields
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
MapTalFld_StandForward:	dc.b	$0F,$F2,$05,$20,$EC,$FF
MapTalFld_StandLftRht:	dc.b	$0B,$F2,$05,$20,$F4,$FF
MapTalFld_StandBckward:	dc.b	$0F,$F2,$05,$20,$F4,$FF
; ---------------------------------------------------------------------------
MapTalFld_WalkDwn_1:	dc.b	$0B,$F2,$05,$20,$F4,$FF
MapTalFld_WalkDwn_2:	dc.b	$0F,$F2,$05,$20,$EC,$FF
MapTalFld_WalkDwn_3:	dc.b	$0E,$F2,$05,$20,$EC,$FF
MapTalFld_WalkDwn_4:	dc.b	$0E,$F2,$05,$20,$EC,$FF
MapTalFld_WalkDwn_5:	dc.b	$0F,$F2,$05,$20,$EC,$FF
MapTalFld_WalkDwn_6:	dc.b	$0F,$F2,$05,$20,$EC,$FF
MapTalFld_WalkDwn_7:	dc.b	$0E,$F2,$05,$20,$EC,$FF
MapTalFld_WalkDwn_8:	dc.b	$0E,$F3,$05,$20,$EC,$FF
; ---------------------------------------------------------------------------
MapTalFld_WalkLR_1:	dc.b	$0F,$F2,$05,$20,$F0,$00
			dc.b	$02,$FA,$05,$30,$10,$FF
MapTalFld_WalkLR_2:	dc.b	$0F,$F2,$05,$20,$F0,$00
			dc.b	$01,$FD,$05,$30,$10,$FF
MapTalFld_WalkLR_3:	dc.b	$0F,$F2,$05,$20,$F0,$00
			dc.b	$01,$FE,$05,$30,$10,$FF
MapTalFld_WalkLR_4:	dc.b	$0F,$F2,$05,$20,$F0,$00
			dc.b	$01,$FB,$05,$30,$10,$FF
MapTalFld_WalkLR_5:	dc.b	$0F,$F2,$05,$20,$F0,$00
			dc.b	$02,$FA,$05,$30,$10,$FF
MapTalFld_WalkLR_6:	dc.b	$0F,$F2,$05,$20,$F0,$00
			dc.b	$01,$FD,$05,$30,$10,$FF
MapTalFld_WalkLR_7:	dc.b	$0F,$F2,$05,$20,$F0,$00
			dc.b	$01,$FC,$05,$30,$10,$FF
MapTalFld_WalkLR_8:	dc.b	$0F,$F2,$05,$20,$F0,$00
			dc.b	$01,$FB,$05,$30,$10,$FF
; ---------------------------------------------------------------------------
MapTalFld_WalkUp_1:	dc.b	$0B,$F0,$05,$20,$F4,$FF
MapTalFld_WalkUp_2:	dc.b	$0F,$F2,$05,$20,$F4,$FF
MapTalFld_WalkUp_3:	dc.b	$0F,$F4,$05,$20,$F4,$FF
MapTalFld_WalkUp_4:	dc.b	$0F,$F2,$05,$20,$F4,$FF
MapTalFld_WalkUp_5:	dc.b	$0F,$F0,$05,$20,$F4,$FF
MapTalFld_WalkUp_6:	dc.b	$0F,$F2,$05,$20,$F4,$FF
MapTalFld_WalkUp_7:	dc.b	$0F,$F4,$05,$20,$F4,$FF
MapTalFld_WalkUp_8:	dc.b	$0F,$F2,$05,$20,$F4,$FF
; ---------------------------------------------------------------------------
MapTalFld_UncBall_1:	dc.b	$0A,$F4,$05,$20,$F4,$FF
MapTalFld_UncBall_2:	dc.b	$0A,$F4,$05,$20,$F4,$FF
MapTalFld_UncBall_3:	dc.b	$0A,$F4,$05,$20,$F4,$FF
			even
; ---------------------------------------------------------------------------
; ===========================================================================