; ===========================================================================
; ---------------------------------------------------------------------------
; PLC and Mapping Main Index Block - Tails Arm
; ---------------------------------------------------------------------------
; An Example of the setout:
;
;			vvMapping Pointersvv			vvPLC Pointersvv
;
;		dc.w	"Location"-Map_TailsArm,		"Location"-PLC_TailsArm
;		dc.w	"Location"-Map_TailsArm,		"Location"-PLC_TailsArm
;		dc.w	"Location"-Map_TailsArm,		"Location"-PLC_TailsArm
; etc, etc
; ---------------------------------------------------------------------------
; ===========================================================================
		dc.w	MAPTArm_Pul_Lft_000-MAP_TailsArm,	PLCTArm_Pul_Lft_000-PLC_TailsArm
		dc.w	MAPTArm_Pul_LftDwn_020-MAP_TailsArm,	PLCTArm_Pul_LftDwn_020-PLC_TailsArm
		dc.w	MAPTArm_Pul_LftDwn_045-MAP_TailsArm,	PLCTArm_Pul_LftDwn_045-PLC_TailsArm
		dc.w	MAPTArm_Pul_LftDwn_060-MAP_TailsArm,	PLCTArm_Pul_LftDwn_060-PLC_TailsArm
		dc.w	MAPTArm_Pul_Dwn_000-MAP_TailsArm,	PLCTArm_Pul_Dwn_000-PLC_TailsArm
		dc.w	MAPTArm_Pul_DwnRht_020-MAP_TailsArm,	PLCTArm_Pul_DwnRht_020-PLC_TailsArm
		dc.w	MAPTArm_Pul_DwnRht_045-MAP_TailsArm,	PLCTArm_Pul_DwnRht_045-PLC_TailsArm
		dc.w	MAPTArm_Pul_DwnRht_060-MAP_TailsArm,	PLCTArm_Pul_DwnRht_060-PLC_TailsArm
		dc.w	MAPTArm_Pul_Rht_000-MAP_TailsArm,	PLCTArm_Pul_Rht_000-PLC_TailsArm
		dc.w	MAPTArm_Pul_RhtUp_020-MAP_TailsArm,	PLCTArm_Pul_RhtUp_020-PLC_TailsArm
		dc.w	MAPTArm_Pul_RhtUp_045-MAP_TailsArm,	PLCTArm_Pul_RhtUp_045-PLC_TailsArm
		dc.w	MAPTArm_Pul_RhtUp_060-MAP_TailsArm,	PLCTArm_Pul_RhtUp_060-PLC_TailsArm
		dc.w	MAPTArm_Pul_Up_000-MAP_TailsArm,	PLCTArm_Pul_Up_000-PLC_TailsArm
		dc.w	MAPTArm_Pul_UpDwn_020-MAP_TailsArm,	PLCTArm_Pul_UpDwn_020-PLC_TailsArm
		dc.w	MAPTArm_Pul_UpDwn_045-MAP_TailsArm,	PLCTArm_Pul_UpDwn_045-PLC_TailsArm
		dc.w	MAPTArm_Pul_UpDwn_060-MAP_TailsArm,	PLCTArm_Pul_UpDwn_060-PLC_TailsArm
		dc.w	MAPTArm_BlncOut1-MAP_TailsArm,		PLCTArm_BlncOut1-PLC_TailsArm
		dc.w	MAPTArm_BlncOut2-MAP_TailsArm,		PLCTArm_BlncOut2-PLC_TailsArm
		dc.w	MAPTArm_BlncOut3-MAP_TailsArm,		PLCTArm_BlncOut3-PLC_TailsArm
		dc.w	MAPTArm_BlncIn1-MAP_TailsArm,		PLCTArm_BlncIn1-PLC_TailsArm
		dc.w	MAPTArm_BlncIn2-MAP_TailsArm,		PLCTArm_BlncIn2-PLC_TailsArm
		dc.w	MAPTArm_BlncIn3-MAP_TailsArm,		PLCTArm_BlncIn3-PLC_TailsArm
		dc.w	MAPTArm_Walk4_000-MAP_TailsArm,		PLCTArm_Walk4_000-PLC_TailsArm
		dc.w	MAPTArm_Walk1_000-MAP_TailsArm,		PLCTArm_Walk1_000-PLC_TailsArm
		dc.w	MAPTArm_Walk2_000-MAP_TailsArm,		PLCTArm_Walk2_000-PLC_TailsArm
		dc.w	MAPTArm_Walk3_000-MAP_TailsArm,		PLCTArm_Walk3_000-PLC_TailsArm
		dc.w	MAPTArm_Walk4_045-MAP_TailsArm,		PLCTArm_Walk4_045-PLC_TailsArm
		dc.w	MAPTArm_Walk1_045-MAP_TailsArm,		PLCTArm_Walk1_045-PLC_TailsArm
		dc.w	MAPTArm_Walk2_045-MAP_TailsArm,		PLCTArm_Walk2_045-PLC_TailsArm
		dc.w	MAPTArm_Walk3_045-MAP_TailsArm,		PLCTArm_Walk3_045-PLC_TailsArm
		dc.w	MAPTArm_Walk4_090-MAP_TailsArm,		PLCTArm_Walk4_090-PLC_TailsArm
		dc.w	MAPTArm_Walk1_090-MAP_TailsArm,		PLCTArm_Walk1_090-PLC_TailsArm
		dc.w	MAPTArm_Walk2_090-MAP_TailsArm,		PLCTArm_Walk2_090-PLC_TailsArm
		dc.w	MAPTArm_Walk3_090-MAP_TailsArm,		PLCTArm_Walk3_090-PLC_TailsArm
		dc.w	MAPTArm_Walk4_135-MAP_TailsArm,		PLCTArm_Walk4_135-PLC_TailsArm
		dc.w	MAPTArm_Walk1_135-MAP_TailsArm,		PLCTArm_Walk1_135-PLC_TailsArm
		dc.w	MAPTArm_Walk2_135-MAP_TailsArm,		PLCTArm_Walk2_135-PLC_TailsArm
		dc.w	MAPTArm_Walk3_135-MAP_TailsArm,		PLCTArm_Walk3_135-PLC_TailsArm
		dc.w	MAPTArm_Unused_00-MAP_TailsArm,		PLCTArm_Unused_00-PLC_TailsArm
		dc.w	MAPTArm_Unused_01-MAP_TailsArm,		PLCTArm_Unused_01-PLC_TailsArm
		dc.w	MAPTArm_Unused_02-MAP_TailsArm,		PLCTArm_Unused_02-PLC_TailsArm
		dc.w	MAPTArm_Run_000-MAP_TailsArm,		PLCTArm_Run_000-PLC_TailsArm
		dc.w	MAPTArm_Run_045-MAP_TailsArm,		PLCTArm_Run_045-PLC_TailsArm
		dc.w	MAPTArm_Run_090-MAP_TailsArm,		PLCTArm_Run_090-PLC_TailsArm
		dc.w	MAPTArm_Run_135-MAP_TailsArm,		PLCTArm_Run_135-PLC_TailsArm
		dc.w	MAPTArm_Hold1_000-MAP_TailsArm,		PLCTArm_Hold1_000-PLC_TailsArm
		dc.w	MAPTArm_Hold2_000-MAP_TailsArm,		PLCTArm_Hold2_000-PLC_TailsArm
		dc.w	MAPTArm_Hold3_000-MAP_TailsArm,		PLCTArm_Hold3_000-PLC_TailsArm
		dc.w	MAPTArm_Hold1_045-MAP_TailsArm,		PLCTArm_Hold1_045-PLC_TailsArm
		dc.w	MAPTArm_Hold2_045-MAP_TailsArm,		PLCTArm_Hold2_045-PLC_TailsArm
		dc.w	MAPTArm_Hold3_045-MAP_TailsArm,		PLCTArm_Hold3_045-PLC_TailsArm
		dc.w	MAPTArm_Hold1_090-MAP_TailsArm,		PLCTArm_Hold1_090-PLC_TailsArm
		dc.w	MAPTArm_Hold2_090-MAP_TailsArm,		PLCTArm_Hold2_090-PLC_TailsArm
		dc.w	MAPTArm_Hold3_090-MAP_TailsArm,		PLCTArm_Hold3_090-PLC_TailsArm
		dc.w	MAPTArm_Hold1_135-MAP_TailsArm,		PLCTArm_Hold1_135-PLC_TailsArm
		dc.w	MAPTArm_Hold2_135-MAP_TailsArm,		PLCTArm_Hold2_135-PLC_TailsArm
		dc.w	MAPTArm_Hold3_135-MAP_TailsArm,		PLCTArm_Hold3_135-PLC_TailsArm
		dc.w	MAPTArm_Unused_03-MAP_TailsArm,		PLCTArm_Unused_03-PLC_TailsArm
		dc.w	MAPTArm_Unused_04-MAP_TailsArm,		PLCTArm_Unused_04-PLC_TailsArm
		dc.w	MAPTArm_Unused_05-MAP_TailsArm,		PLCTArm_Unused_05-PLC_TailsArm
		dc.w	MAPTArm_Unused_06-MAP_TailsArm,		PLCTArm_Unused_06-PLC_TailsArm
		dc.w	MAPTArm_Unused_07-MAP_TailsArm,		PLCTArm_Unused_07-PLC_TailsArm
		dc.w	MAPTArm_Unused_08-MAP_TailsArm,		PLCTArm_Unused_08-PLC_TailsArm
		dc.w	MAPTArm_Unused_09-MAP_TailsArm,		PLCTArm_Unused_09-PLC_TailsArm
		dc.w	MAPTArm_Unused_0A-MAP_TailsArm,		PLCTArm_Unused_0A-PLC_TailsArm
		dc.w	MAPTArm_Unused_0B-MAP_TailsArm,		PLCTArm_Unused_0B-PLC_TailsArm
		dc.w	MAPTArm_Unused_0C-MAP_TailsArm,		PLCTArm_Unused_0C-PLC_TailsArm
		dc.w	MAPTArm_Unused_0D-MAP_TailsArm,		PLCTArm_Unused_0D-PLC_TailsArm
; ---------------------------------------------------------------------------
; ===========================================================================