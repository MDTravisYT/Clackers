; ===========================================================================
; ---------------------------------------------------------------------------
; PLC and PLCping Main Index Block - Tails
; ---------------------------------------------------------------------------
; An Example of the setout:
;
;			vvMapping Pointersvv			vvPLC Pointersvv
;
;		dc.w	"Location"-MAP_Tails,			"Location"-PLC_Tails
;		dc.w	"Location"-MAP_Tails,			"Location"-PLC_Tails
;		dc.w	"Location"-MAP_Tails,			"Location"-PLC_Tails
; etc, etc
; ---------------------------------------------------------------------------
; ===========================================================================
		dc.w	MAPTal_Stand-MAP_Tails,			PLCTal_Stand-PLC_Tails
		dc.w	MAPTal_LookUp-MAP_Tails,		PLCTal_LookUp-PLC_Tails
		dc.w	MAPTal_LookDown-MAP_Tails,		PLCTal_LookDown-PLC_Tails
		dc.w	MAPTal_WaitBlink2-MAP_Tails,		PLCTal_WaitBlink2-PLC_Tails
		dc.w	MAPTal_WaitBlink1-MAP_Tails,		PLCTal_WaitBlink1-PLC_Tails
		dc.w	MAPTal_WaitStare-MAP_Tails,		PLCTal_WaitStare-PLC_Tails
		dc.w	MAPTal_WaitYawn1-MAP_Tails,		PLCTal_WaitYawn1-PLC_Tails
		dc.w	MAPTal_WaitYawn2-MAP_Tails,		PLCTal_WaitYawn2-PLC_Tails
		dc.w	MAPTal_WaitYawn3-MAP_Tails,		PLCTal_WaitYawn3-PLC_Tails
		dc.w	MAPTal_Walk7_000-MAP_Tails,		PLCTal_Walk7_000-PLC_Tails
		dc.w	MAPTal_Walk8_000-MAP_Tails,		PLCTal_Walk8_000-PLC_Tails
		dc.w	MAPTal_Walk1_000-MAP_Tails,		PLCTal_Walk1_000-PLC_Tails
		dc.w	MAPTal_Walk2_000-MAP_Tails,		PLCTal_Walk2_000-PLC_Tails
		dc.w	MAPTal_Walk3_000-MAP_Tails,		PLCTal_Walk3_000-PLC_Tails
		dc.w	MAPTal_Walk4_000-MAP_Tails,		PLCTal_Walk4_000-PLC_Tails
		dc.w	MAPTal_Walk5_000-MAP_Tails,		PLCTal_Walk5_000-PLC_Tails
		dc.w	MAPTal_Walk6_000-MAP_Tails,		PLCTal_Walk6_000-PLC_Tails
		dc.w	MAPTal_Walk7_045-MAP_Tails,		PLCTal_Walk7_045-PLC_Tails
		dc.w	MAPTal_Walk8_045-MAP_Tails,		PLCTal_Walk8_045-PLC_Tails
		dc.w	MAPTal_Walk1_045-MAP_Tails,		PLCTal_Walk1_045-PLC_Tails
		dc.w	MAPTal_Walk2_045-MAP_Tails,		PLCTal_Walk2_045-PLC_Tails
		dc.w	MAPTal_Walk3_045-MAP_Tails,		PLCTal_Walk3_045-PLC_Tails
		dc.w	MAPTal_Walk4_045-MAP_Tails,		PLCTal_Walk4_045-PLC_Tails
		dc.w	MAPTal_Walk5_045-MAP_Tails,		PLCTal_Walk5_045-PLC_Tails
		dc.w	MAPTal_Walk6_045-MAP_Tails,		PLCTal_Walk6_045-PLC_Tails
		dc.w	MAPTal_Walk7_090-MAP_Tails,		PLCTal_Walk7_090-PLC_Tails
		dc.w	MAPTal_Walk8_090-MAP_Tails,		PLCTal_Walk8_090-PLC_Tails
		dc.w	MAPTal_Walk1_090-MAP_Tails,		PLCTal_Walk1_090-PLC_Tails
		dc.w	MAPTal_Walk2_090-MAP_Tails,		PLCTal_Walk2_090-PLC_Tails
		dc.w	MAPTal_Walk3_090-MAP_Tails,		PLCTal_Walk3_090-PLC_Tails
		dc.w	MAPTal_Walk4_090-MAP_Tails,		PLCTal_Walk4_090-PLC_Tails
		dc.w	MAPTal_Walk5_090-MAP_Tails,		PLCTal_Walk5_090-PLC_Tails
		dc.w	MAPTal_Walk6_090-MAP_Tails,		PLCTal_Walk6_090-PLC_Tails
		dc.w	MAPTal_Walk7_135-MAP_Tails,		PLCTal_Walk7_135-PLC_Tails
		dc.w	MAPTal_Walk8_135-MAP_Tails,		PLCTal_Walk8_135-PLC_Tails
		dc.w	MAPTal_Walk1_135-MAP_Tails,		PLCTal_Walk1_135-PLC_Tails
		dc.w	MAPTal_Walk2_135-MAP_Tails,		PLCTal_Walk2_135-PLC_Tails
		dc.w	MAPTal_Walk3_135-MAP_Tails,		PLCTal_Walk3_135-PLC_Tails
		dc.w	MAPTal_Walk4_135-MAP_Tails,		PLCTal_Walk4_135-PLC_Tails
		dc.w	MAPTal_Walk5_135-MAP_Tails,		PLCTal_Walk5_135-PLC_Tails
		dc.w	MAPTal_Walk6_135-MAP_Tails,		PLCTal_Walk6_135-PLC_Tails
		dc.w	MAPTal_Run1_000-MAP_Tails,		PLCTal_Run1_000-PLC_Tails
		dc.w	MAPTal_Run2_000-MAP_Tails,		PLCTal_Run2_000-PLC_Tails
		dc.w	MAPTal_Run1_045-MAP_Tails,		PLCTal_Run1_045-PLC_Tails
		dc.w	MAPTal_Run2_045-MAP_Tails,		PLCTal_Run2_045-PLC_Tails
		dc.w	MAPTal_Run1_090-MAP_Tails,		PLCTal_Run1_090-PLC_Tails
		dc.w	MAPTal_Run2_090-MAP_Tails,		PLCTal_Run2_090-PLC_Tails
		dc.w	MAPTal_Run1_135-MAP_Tails,		PLCTal_Run1_135-PLC_Tails
		dc.w	MAPTal_Run2_135-MAP_Tails,		PLCTal_Run2_135-PLC_Tails
		dc.w	MAPTal_Roll1-MAP_Tails,			PLCTal_Roll1-PLC_Tails
		dc.w	MAPTal_Roll2-MAP_Tails,			PLCTal_Roll2-PLC_Tails
		dc.w	MAPTal_Roll3-MAP_Tails,			PLCTal_Roll3-PLC_Tails
		dc.w	MAPTal_Spindsh1-MAP_Tails,		PLCTal_Spindsh1-PLC_Tails
		dc.w	MAPTal_Spindsh2-MAP_Tails,		PLCTal_Spindsh2-PLC_Tails
		dc.w	MAPTal_Spindsh3-MAP_Tails,		PLCTal_Spindsh3-PLC_Tails
		dc.w	MAPTal_Hurt-MAP_Tails,			PLCTal_Hurt-PLC_Tails
		dc.w	MAPTal_Fly-MAP_Tails,			PLCTal_Fly-PLC_Tails
		dc.w	MAPTal_FlyTired1-MAP_Tails,		PLCTal_FlyTired1-PLC_Tails
		dc.w	MAPTal_FlyTired2-MAP_Tails,		PLCTal_FlyTired2-PLC_Tails
		dc.w	MAPTal_FlyHeliTails-MAP_Tails,		PLCTal_FlyHeliTails-PLC_Tails
		dc.w	MAPTal_Skid1-MAP_Tails,			PLCTal_Skid1-PLC_Tails
		dc.w	MAPTal_Skid2-MAP_Tails,			PLCTal_Skid2-PLC_Tails
		dc.w	MAPTal_Skid3-MAP_Tails,			PLCTal_Skid3-PLC_Tails
		dc.w	MAPTal_UnkSkid1-MAP_Tails,		PLCTal_UnkSkid1-PLC_Tails
		dc.w	MAPTal_UnkSkid2-MAP_Tails,		PLCTal_UnkSkid2-PLC_Tails
		dc.w	MAPTal_BlncOut1-MAP_Tails,		PLCTal_BlncOut1-PLC_Tails
		dc.w	MAPTal_BlncOut2-MAP_Tails,		PLCTal_BlncOut2-PLC_Tails
		dc.w	MAPTal_BlncOut3-MAP_Tails,		PLCTal_BlncOut3-PLC_Tails
		dc.w	MAPTal_BlncIn1-MAP_Tails,		PLCTal_BlncIn1-PLC_Tails
		dc.w	MAPTal_BlncIn2-MAP_Tails,		PLCTal_BlncIn2-PLC_Tails
		dc.w	MAPTal_BlncIn3-MAP_Tails,		PLCTal_BlncIn3-PLC_Tails
		dc.w	MAPTal_Throw1-MAP_Tails,		PLCTal_Throw1-PLC_Tails
		dc.w	MAPTal_Throw2-MAP_Tails,		PLCTal_Throw2-PLC_Tails
		dc.w	MAPTal_Throw3-MAP_Tails,		PLCTal_Throw3-PLC_Tails
		dc.w	MAPTal_Throw4-MAP_Tails,		PLCTal_Throw4-PLC_Tails
		dc.w	MAPTal_Hang2-MAP_Tails,			PLCTal_Hang2-PLC_Tails
		dc.w	MAPTal_Dizzy1-MAP_Tails,		PLCTal_Dizzy1-PLC_Tails
		dc.w	MAPTal_Dizzy2-MAP_Tails,		PLCTal_Dizzy2-PLC_Tails
		dc.w	MAPTal_Dizzy3-MAP_Tails,		PLCTal_Dizzy3-PLC_Tails
		dc.w	MAPTal_Dizzy4-MAP_Tails,		PLCTal_Dizzy4-PLC_Tails
		dc.w	MAPTal_Dizzy5-MAP_Tails,		PLCTal_Dizzy5-PLC_Tails
		dc.w	MAPTal_Dizzy6-MAP_Tails,		PLCTal_Dizzy6-PLC_Tails
		dc.w	MAPTal_Dizzy7-MAP_Tails,		PLCTal_Dizzy7-PLC_Tails
		dc.w	MAPTal_Dizzy8-MAP_Tails,		PLCTal_Dizzy8-PLC_Tails
		dc.w	MAPTal_TalJmp01_000-MAP_Tails,		PLCTal_TalJmp01_000-PLC_Tails
		dc.w	MAPTal_TalJmp02_000-MAP_Tails,		PLCTal_TalJmp02_000-PLC_Tails
		dc.w	MAPTal_TalJmp03_000-MAP_Tails,		PLCTal_TalJmp03_000-PLC_Tails
		dc.w	MAPTal_TalJmp04_000-MAP_Tails,		PLCTal_TalJmp04_000-PLC_Tails
		dc.w	MAPTal_TalJmp01_045-MAP_Tails,		PLCTal_TalJmp01_045-PLC_Tails
		dc.w	MAPTal_TalJmp02_045-MAP_Tails,		PLCTal_TalJmp02_045-PLC_Tails
		dc.w	MAPTal_TalJmp03_045-MAP_Tails,		PLCTal_TalJmp03_045-PLC_Tails
		dc.w	MAPTal_TalJmp04_045-MAP_Tails,		PLCTal_TalJmp04_045-PLC_Tails
		dc.w	MAPTal_TalJmp01_090-MAP_Tails,		PLCTal_TalJmp01_090-PLC_Tails
		dc.w	MAPTal_TalJmp02_090-MAP_Tails,		PLCTal_TalJmp02_090-PLC_Tails
		dc.w	MAPTal_TalJmp03_090-MAP_Tails,		PLCTal_TalJmp03_090-PLC_Tails
		dc.w	MAPTal_TalJmp04_090-MAP_Tails,		PLCTal_TalJmp04_090-PLC_Tails
		dc.w	MAPTal_TalJmp01_135-MAP_Tails,		PLCTal_TalJmp01_135-PLC_Tails
		dc.w	MAPTal_TalJmp02_135-MAP_Tails,		PLCTal_TalJmp02_135-PLC_Tails
		dc.w	MAPTal_TalJmp03_135-MAP_Tails,		PLCTal_TalJmp03_135-PLC_Tails
		dc.w	MAPTal_TalJmp04_135-MAP_Tails,		PLCTal_TalJmp04_135-PLC_Tails
		dc.w	MAPTal_RunNorm01_000-MAP_Tails,		PLCTal_RunNorm01_000-PLC_Tails
		dc.w	MAPTal_RunNorm02_000-MAP_Tails,		PLCTal_RunNorm02_000-PLC_Tails
		dc.w	MAPTal_RunFast01_000-MAP_Tails,		PLCTal_RunFast01_000-PLC_Tails
		dc.w	MAPTal_RunFast02_000-MAP_Tails,		PLCTal_RunFast02_000-PLC_Tails
		dc.w	MAPTal_RunNorm01_045-MAP_Tails,		PLCTal_RunNorm01_045-PLC_Tails
		dc.w	MAPTal_RunNorm02_045-MAP_Tails,		PLCTal_RunNorm02_045-PLC_Tails
		dc.w	MAPTal_RunFast01_045-MAP_Tails,		PLCTal_RunFast01_045-PLC_Tails
		dc.w	MAPTal_RunFast02_045-MAP_Tails,		PLCTal_RunFast02_045-PLC_Tails
		dc.w	MAPTal_RunNorm01_090-MAP_Tails,		PLCTal_RunNorm01_090-PLC_Tails
		dc.w	MAPTal_RunNorm02_090-MAP_Tails,		PLCTal_RunNorm02_090-PLC_Tails
		dc.w	MAPTal_RunFast01_090-MAP_Tails,		PLCTal_RunFast01_090-PLC_Tails
		dc.w	MAPTal_RunFast02_090-MAP_Tails,		PLCTal_RunFast02_090-PLC_Tails
		dc.w	MAPTal_RunNorm01_135-MAP_Tails,		PLCTal_RunNorm01_135-PLC_Tails
		dc.w	MAPTal_RunNorm02_135-MAP_Tails,		PLCTal_RunNorm02_135-PLC_Tails
		dc.w	MAPTal_RunFast01_135-MAP_Tails,		PLCTal_RunFast01_135-PLC_Tails
		dc.w	MAPTal_RunFast02_135-MAP_Tails,		PLCTal_RunFast02_135-PLC_Tails
		dc.w	MAPTal_UnkTails1-MAP_Tails,		PLCTal_UnkTails1-PLC_Tails
		dc.w	MAPTal_UnkTails2-MAP_Tails,		PLCTal_UnkTails2-PLC_Tails
		dc.w	MAPTal_Wait01-MAP_Tails,		PLCTal_Wait01-PLC_Tails
		dc.w	MAPTal_Wait02-MAP_Tails,		PLCTal_Wait02-PLC_Tails
		dc.w	MAPTal_Wait03-MAP_Tails,		PLCTal_Wait03-PLC_Tails
		dc.w	MAPTal_Wait04-MAP_Tails,		PLCTal_Wait04-PLC_Tails
		dc.w	MAPTal_Wait05-MAP_Tails,		PLCTal_Wait05-PLC_Tails
; ---------------------------------------------------------------------------
; ===========================================================================