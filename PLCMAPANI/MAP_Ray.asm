; ===========================================================================
; ---------------------------------------------------------------------------
; Mappings - Sonic
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
MAPSon2_Stand:		dc.b	$0A,$EA,$26,$9C,$F9,$00
					dc.b	$09,$02,$26,$A5,$F9,$00
					dc.b	$02,$F2,$26,$AB,$F1,$FF