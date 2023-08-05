; ===========================================================================
; ---------------------------------------------------------------------------
; PLC and Mapping Main Index Block - Sonic's Arm
; ---------------------------------------------------------------------------
; An Example of the setout:
;
;			vvMapping Pointersvv			vvPLC Pointersvv
;
;		dc.w	"Location"-Map_SonicArm,		"Location"-PLC_SonicArm
;		dc.w	"Location"-Map_SonicArm,		"Location"-PLC_SonicArm
;		dc.w	"Location"-Map_SonicArm,		"Location"-PLC_SonicArm
; etc, etc
; ---------------------------------------------------------------------------
; ===========================================================================
		dc.w	MapSArm_Wait1-Map_SonicArm,		PLCSArm_Wait1-PLC_SonicArm
		dc.w	MapSArm_Wait2-Map_SonicArm,		PLCSArm_Wait2-PLC_SonicArm
		dc.w	MapSArm_Wait3-Map_SonicArm,		PLCSArm_Wait3-PLC_SonicArm
		dc.w	MapSArm_Walk5_000-Map_SonicArm,		PLCSArm_Walk5_000-PLC_SonicArm
		dc.w	MapSArm_Walk6_000-Map_SonicArm,		PLCSArm_Walk6_000-PLC_SonicArm
		dc.w	MapSArm_Walk1_000-Map_SonicArm,		PLCSArm_Walk1_000-PLC_SonicArm
		dc.w	MapSArm_Walk2_000-Map_SonicArm,		PLCSArm_Walk2_000-PLC_SonicArm
		dc.w	MapSArm_Walk3_000-Map_SonicArm,		PLCSArm_Walk3_000-PLC_SonicArm
		dc.w	MapSArm_Walk4_000-Map_SonicArm,		PLCSArm_Walk4_000-PLC_SonicArm
		dc.w	MapSArm_Walk5_045-Map_SonicArm,		PLCSArm_Walk5_045-PLC_SonicArm
		dc.w	MapSArm_Walk6_045-Map_SonicArm,		PLCSArm_Walk6_045-PLC_SonicArm
		dc.w	MapSArm_Walk1_045-Map_SonicArm,		PLCSArm_Walk1_045-PLC_SonicArm
		dc.w	MapSArm_Walk2_045-Map_SonicArm,		PLCSArm_Walk2_045-PLC_SonicArm
		dc.w	MapSArm_Walk3_045-Map_SonicArm,		PLCSArm_Walk3_045-PLC_SonicArm
		dc.w	MapSArm_Walk4_045-Map_SonicArm,		PLCSArm_Walk4_045-PLC_SonicArm
		dc.w	MapSArm_Walk5_090-Map_SonicArm,		PLCSArm_Walk5_090-PLC_SonicArm
		dc.w	MapSArm_Walk6_090-Map_SonicArm,		PLCSArm_Walk6_090-PLC_SonicArm
		dc.w	MapSArm_Walk1_090-Map_SonicArm,		PLCSArm_Walk1_090-PLC_SonicArm
		dc.w	MapSArm_Walk2_090-Map_SonicArm,		PLCSArm_Walk2_090-PLC_SonicArm
		dc.w	MapSArm_Walk3_090-Map_SonicArm,		PLCSArm_Walk3_090-PLC_SonicArm
		dc.w	MapSArm_Walk4_090-Map_SonicArm,		PLCSArm_Walk4_090-PLC_SonicArm
		dc.w	MapSArm_Walk5_135-Map_SonicArm,		PLCSArm_Walk5_135-PLC_SonicArm
		dc.w	MapSArm_Walk6_135-Map_SonicArm,		PLCSArm_Walk6_135-PLC_SonicArm
		dc.w	MapSArm_Walk1_135-Map_SonicArm,		PLCSArm_Walk1_135-PLC_SonicArm
		dc.w	MapSArm_Walk2_135-Map_SonicArm,		PLCSArm_Walk2_135-PLC_SonicArm
		dc.w	MapSArm_Walk3_135-Map_SonicArm,		PLCSArm_Walk3_135-PLC_SonicArm
		dc.w	MapSArm_Walk4_135-Map_SonicArm,		PLCSArm_Walk4_135-PLC_SonicArm
		dc.w	MapSArm_Run_000-Map_SonicArm,		PLCSArm_Run_000-PLC_SonicArm
		dc.w	MapSArm_Run_045-Map_SonicArm,		PLCSArm_Run_045-PLC_SonicArm
		dc.w	MapSArm_Run_090-Map_SonicArm,		PLCSArm_Run_090-PLC_SonicArm
		dc.w	MapSArm_Run_135-Map_SonicArm,		PLCSArm_Run_135-PLC_SonicArm
		dc.w	MapSArm_Pul_Lft_000-Map_SonicArm,	PLCSArm_Pul_Lft_000-PLC_SonicArm
		dc.w	MapSArm_Pul_LftDwn_020-Map_SonicArm,	PLCSArm_Pul_LftDwn_020-PLC_SonicArm
		dc.w	MapSArm_Pul_LftDwn_045-Map_SonicArm,	PLCSArm_Pul_LftDwn_045-PLC_SonicArm
		dc.w	MapSArm_Pul_LftDwn_060-Map_SonicArm,	PLCSArm_Pul_LftDwn_060-PLC_SonicArm
		dc.w	MapSArm_Pul_Dwn_000-Map_SonicArm,	PLCSArm_Pul_Dwn_000-PLC_SonicArm
		dc.w	MapSArm_Pul_DwnRht_020-Map_SonicArm,	PLCSArm_Pul_DwnRht_020-PLC_SonicArm
		dc.w	MapSArm_Pul_DwnRht_045-Map_SonicArm,	PLCSArm_Pul_DwnRht_045-PLC_SonicArm
		dc.w	MapSArm_Pul_DwnRht_060-Map_SonicArm,	PLCSArm_Pul_DwnRht_060-PLC_SonicArm
		dc.w	MapSArm_Pul_Rht_000-Map_SonicArm,	PLCSArm_Pul_Rht_000-PLC_SonicArm
		dc.w	MapSArm_Pul_RhtUp_020-Map_SonicArm,	PLCSArm_Pul_RhtUp_020-PLC_SonicArm
		dc.w	MapSArm_Pul_RhtUp_045-Map_SonicArm,	PLCSArm_Pul_RhtUp_045-PLC_SonicArm
		dc.w	MapSArm_Pul_RhtUp_060-Map_SonicArm,	PLCSArm_Pul_RhtUp_060-PLC_SonicArm
		dc.w	MapSArm_Pul_Up_000-Map_SonicArm,	PLCSArm_Pul_Up_000-PLC_SonicArm
		dc.w	MapSArm_Pul_UpDwn_020-Map_SonicArm,	PLCSArm_Pul_UpDwn_020-PLC_SonicArm
		dc.w	MapSArm_Pul_UpDwn_045-Map_SonicArm,	PLCSArm_Pul_UpDwn_045-PLC_SonicArm
		dc.w	MapSArm_Pul_UpDwn_060-Map_SonicArm,	PLCSArm_Pul_UpDwn_060-PLC_SonicArm
		dc.w	MapSArm_Hold1_000-Map_SonicArm,		PLCSArm_Hold1_000-PLC_SonicArm
		dc.w	MapSArm_Hold2_000-Map_SonicArm,		PLCSArm_Hold2_000-PLC_SonicArm
		dc.w	MapSArm_Hold3_000-Map_SonicArm,		PLCSArm_Hold3_000-PLC_SonicArm
		dc.w	MapSArm_Hold1_045-Map_SonicArm,		PLCSArm_Hold1_045-PLC_SonicArm
		dc.w	MapSArm_Hold2_045-Map_SonicArm,		PLCSArm_Hold2_045-PLC_SonicArm
		dc.w	MapSArm_Hold3_045-Map_SonicArm,		PLCSArm_Hold3_045-PLC_SonicArm
		dc.w	MapSArm_Hold1_090-Map_SonicArm,		PLCSArm_Hold1_090-PLC_SonicArm
		dc.w	MapSArm_Hold2_090-Map_SonicArm,		PLCSArm_Hold2_090-PLC_SonicArm
		dc.w	MapSArm_Hold3_090-Map_SonicArm,		PLCSArm_Hold3_090-PLC_SonicArm
		dc.w	MapSArm_Hold1_135-Map_SonicArm,		PLCSArm_Hold1_135-PLC_SonicArm
		dc.w	MapSArm_Hold2_135-Map_SonicArm,		PLCSArm_Hold2_135-PLC_SonicArm
		dc.w	MapSArm_Hold3_135-Map_SonicArm,		PLCSArm_Hold3_135-PLC_SonicArm
		dc.w	MapSArm_Unused_00-Map_SonicArm,		PLCSArm_Unused_00-PLC_SonicArm
		dc.w	MapSArm_Unused_01-Map_SonicArm,		PLCSArm_Unused_01-PLC_SonicArm
		dc.w	MapSArm_Unused_02-Map_SonicArm,		PLCSArm_Unused_02-PLC_SonicArm
		dc.w	MapSArm_Unused_03-Map_SonicArm,		PLCSArm_Unused_03-PLC_SonicArm
		dc.w	MapSArm_Unused_04-Map_SonicArm,		PLCSArm_Unused_04-PLC_SonicArm
		dc.w	MapSArm_Unused_05-Map_SonicArm,		PLCSArm_Unused_05-PLC_SonicArm
		dc.w	MapSArm_Unused_06-Map_SonicArm,		PLCSArm_Unused_06-PLC_SonicArm
		dc.w	MapSArm_Unused_07-Map_SonicArm,		PLCSArm_Unused_07-PLC_SonicArm
		dc.w	MapSArm_Unused_08-Map_SonicArm,		PLCSArm_Unused_08-PLC_SonicArm
		dc.w	MapSArm_Unused_09-Map_SonicArm,		PLCSArm_Unused_09-PLC_SonicArm
		dc.w	MapSArm_Unused_0A-Map_SonicArm,		PLCSArm_Unused_0A-PLC_SonicArm
		dc.w	MapSArm_Unused_0B-Map_SonicArm,		PLCSArm_Unused_0B-PLC_SonicArm
		dc.w	MapSArm_Unused_0C-Map_SonicArm,		PLCSArm_Unused_0C-PLC_SonicArm
		dc.w	MapSArm_Unused_0D-Map_SonicArm, 	PLCSArm_Unused_0D-PLC_SonicArm
		dc.w	MapSArm_Unused_0E-Map_SonicArm,		PLCSArm_Unused_0E-PLC_SonicArm
		dc.w	MapSArm_Unused_0F-Map_SonicArm,		PLCSArm_Unused_0F-PLC_SonicArm
		dc.w	MapSArm_Unused_10-Map_SonicArm,		PLCSArm_Unused_10-PLC_SonicArm
		dc.w	MapSArm_Unused_11-Map_SonicArm,		PLCSArm_Unused_11-PLC_SonicArm
		dc.w	MapSArm_Unused_12-Map_SonicArm,		PLCSArm_Unused_12-PLC_SonicArm
		dc.w	MapSArm_Unused_13-Map_SonicArm,		PLCSArm_Unused_13-PLC_SonicArm
		dc.w	MapSArm_Unused_14-Map_SonicArm,		PLCSArm_Unused_14-PLC_SonicArm
		dc.w	MapSArm_Unused_15-Map_SonicArm,		PLCSArm_Unused_15-PLC_SonicArm
		dc.w	MapSArm_Unused_16-Map_SonicArm,		PLCSArm_Unused_16-PLC_SonicArm
		dc.w	MapSArm_Unused_17-Map_SonicArm,		PLCSArm_Unused_17-PLC_SonicArm
		dc.w	MapSArm_Unused_18-Map_SonicArm,		PLCSArm_Unused_18-PLC_SonicArm
		dc.w	MapSArm_Unused_19-Map_SonicArm,		PLCSArm_Unused_19-PLC_SonicArm
		dc.w	MapSArm_Unused_1A-Map_SonicArm,		PLCSArm_Unused_1A-PLC_SonicArm
; ---------------------------------------------------------------------------
; ===========================================================================