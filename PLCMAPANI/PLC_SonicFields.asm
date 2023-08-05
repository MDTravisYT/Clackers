; ===========================================================================
; ---------------------------------------------------------------------------
; Patter Load Cues - Sonic Fields
; ---------------------------------------------------------------------------
; Guide as half Documented by Hivebrain
; (See http://info.sonicretro.org/SCHG:Sonic_Crackers for more information)
;
;	Each load cue consists of ten bytes:
;
;			dc.w	$S2S1,$97L3,$L2L1,$DDDD,$FFF
;
;	$S2S1 = DMA Size
;	$97L3 and $L2L1 = DMA Location (Source)
;	$DDDD = DMA Destination (Added with hard coded data at offset: 0000CA2C)
;	$FFFF = End of list flag 
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
PLCSonFld_StandForward:	PLC	$0220,ARTUNC_Sonic+$10000,$A000,$FFFF		; standing (Facing forwards)
PLCSonFld_StandLftRht:	PLC	$01E0,ARTUNC_Sonic+$10220,$A000,$FFFF		; standing (Facing left or right)
PLCSonFld_StandBckward:	PLC	$0220,ARTUNC_Sonic+$10400,$A000,$FFFF		; standing (facing backwards)
; ---------------------------------------------------------------------------
PLCSonFld_WalkDwn_1:	dc.w	$D000,$9704,$8310,$A000,$FFFF			; Walk Down 1
PLCSonFld_WalkDwn_2:	dc.w	$F000,$9704,$83E0,$A000,$FFFF			; Walk Down 2
PLCSonFld_WalkDwn_3:	dc.w	$0001,$9704,$84D0,$A000,$FFFF			; Walk Down 3
PLCSonFld_WalkDwn_4:	dc.w	$0001,$9704,$85D0,$A000,$FFFF			; Walk Down 4
PLCSonFld_WalkDwn_5:	dc.w	$0001,$9704,$86D0,$A000,$FFFF			; Walk Down 5
PLCSonFld_WalkDwn_6:	dc.w	$2001,$9704,$87D0,$A000,$FFFF			; Walk Down 6
PLCSonFld_WalkDwn_7:	dc.w	$0001,$9704,$88F0,$A000,$FFFF			; Walk Down 7
PLCSonFld_WalkDwn_8:	dc.w	$C000,$9704,$89F0,$A000,$FFFF			; Walk Down 8
; ---------------------------------------------------------------------------
PLCSonFld_WalkLR_1:	dc.w	$1001,$9704,$8AB0,$A000,$FFFF			; Walk Left or Right 1
PLCSonFld_WalkLR_2:	dc.w	$2001,$9704,$8BC0,$A000,$FFFF			; Walk Left or Right 2
PLCSonFld_WalkLR_3:	dc.w	$1001,$9704,$8CE0,$A000,$FFFF			; Walk Left or Right 3
PLCSonFld_WalkLR_4:	dc.w	$1001,$9704,$8DF0,$A000,$FFFF			; Walk Left or Right 4
PLCSonFld_WalkLR_5:	dc.w	$0001,$9704,$8F00,$A000,$FFFF			; Walk Left or Right 5
PLCSonFld_WalkLR_6:	dc.w	$0001,$9704,$9000,$A000,$FFFF			; Walk Left or Right 6
PLCSonFld_WalkLR_7:	dc.w	$0001,$9704,$9100,$A000,$FFFF			; Walk Left or Right 7
PLCSonFld_WalkLR_8:	dc.w	$1001,$9704,$9200,$A000,$FFFF			; Walk Left or Right 8
; ---------------------------------------------------------------------------
PLCSonFld_WalkUp_1:	dc.w	$D000,$9704,$9310,$A000,$FFFF			; Walk Up 1
PLCSonFld_WalkUp_2:	dc.w	$C000,$9704,$93E0,$A000,$FFFF			; Walk Up 2
PLCSonFld_WalkUp_3:	dc.w	$0001,$9704,$94A0,$A000,$FFFF			; Walk Up 3
PLCSonFld_WalkUp_4:	dc.w	$1001,$9704,$95A0,$A000,$FFFF			; Walk Up 4
PLCSonFld_WalkUp_5:	dc.w	$1001,$9704,$96B0,$A000,$FFFF			; Walk Up 5
PLCSonFld_WalkUp_6:	dc.w	$0001,$9704,$97C0,$A000,$FFFF			; Walk Up 6
PLCSonFld_WalkUp_7:	dc.w	$0001,$9704,$98C0,$A000,$FFFF			; Walk Up 7
PLCSonFld_WalkUp_8:	dc.w	$D000,$9704,$99C0,$A000,$FFFF			; Walk Up 8
; ---------------------------------------------------------------------------
PLCSonFld_UncBall_1:	dc.w	$0001,$9704,$9A90,$A000,$FFFF			; Ball frame 1 (Rolling/jumping) (Unused)
PLCSonFld_UncBall_2:	dc.w	$0001,$9704,$9B90,$A000,$FFFF			; Ball frame 2 (Rolling/jumping) (Unused)
PLCSonFld_UncBall_3:	dc.w	$0001,$9704,$9C90,$A000,$FFFF			; Ball frame 3 (Rolling/jumping) (Unused)
			even
; ---------------------------------------------------------------------------
; ===========================================================================