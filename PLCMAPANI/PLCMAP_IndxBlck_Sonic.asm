; ===========================================================================
; ---------------------------------------------------------------------------
; PLC and Mapping Main Index Block - Sonic
; ---------------------------------------------------------------------------
; An Example of the setout:
;
;			vvMapping Pointersvv			vvPLC Pointersvv
;
;		dc.w	"Location"-Map_Sonic,			"Location"-PLC_Sonic
;		dc.w	"Location"-Map_Sonic,			"Location"-PLC_Sonic
;		dc.w	"Location"-Map_Sonic,			"Location"-PLC_Sonic
; etc, etc
; ---------------------------------------------------------------------------
; ===========================================================================
		dc.w	MAPSon_Stand-Map_Sonic,			PLCSon_Stand-PLC_Sonic
		dc.w	MAPSon_LookUp-Map_Sonic,		PLCSon_LookUp-PLC_Sonic
		dc.w	MAPSon_LookDown-Map_Sonic,		PLCSon_LookDown-PLC_Sonic
		dc.w	MAPSon_Hurt-Map_Sonic,			PLCSon_Hurt-PLC_Sonic
		dc.w	MAPSon_Wait1-Map_Sonic,			PLCSon_Wait1-PLC_Sonic
		dc.w	MAPSon_Wait2-Map_Sonic,			PLCSon_Wait2-PLC_Sonic
		dc.w	MAPSon_BlncIn1-Map_Sonic,		PLCSon_BlncIn1-PLC_Sonic
		dc.w	MAPSon_BlncIn1-Map_Sonic,		PLCSon_BlncIn1-PLC_Sonic
		dc.w	MAPSon_BlncIn1-Map_Sonic,		PLCSon_BlncIn1-PLC_Sonic
		dc.w	MAPSon_BlncIn1-Map_Sonic,		PLCSon_BlncIn1-PLC_Sonic
		dc.w	MAPSon_BlncIn2-Map_Sonic,		PLCSon_BlncIn2-PLC_Sonic
		dc.w	MAPSon_BlncIn3-Map_Sonic,		PLCSon_BlncIn3-PLC_Sonic
		dc.w	MAPSon_BlncOut1-Map_Sonic,		PLCSon_BlncOut1-PLC_Sonic
		dc.w	MAPSon_BlncOut2-Map_Sonic,		PLCSon_BlncOut2-PLC_Sonic
		dc.w	MAPSon_BlncOut3-Map_Sonic,		PLCSon_BlncOut3-PLC_Sonic
		dc.w	MAPSon_Walk5_000-Map_Sonic,		PLCSon_Walk5_000-PLC_Sonic
		dc.w	MAPSon_Walk6_000-Map_Sonic,		PLCSon_Walk6_000-PLC_Sonic
		dc.w	MAPSon_Walk1_000-Map_Sonic,		PLCSon_Walk1_000-PLC_Sonic
		dc.w	MAPSon_Walk2_000-Map_Sonic,		PLCSon_Walk2_000-PLC_Sonic
		dc.w	MAPSon_Walk3_000-Map_Sonic,		PLCSon_Walk3_000-PLC_Sonic
		dc.w	MAPSon_Walk4_000-Map_Sonic,		PLCSon_Walk4_000-PLC_Sonic
		dc.w	MAPSon_Walk5_045-Map_Sonic,		PLCSon_Walk5_045-PLC_Sonic
		dc.w	MAPSon_Walk6_045-Map_Sonic,		PLCSon_Walk6_045-PLC_Sonic
		dc.w	MAPSon_Walk1_045-Map_Sonic,		PLCSon_Walk1_045-PLC_Sonic
		dc.w	MAPSon_Walk2_045-Map_Sonic,		PLCSon_Walk2_045-PLC_Sonic
		dc.w	MAPSon_Walk3_045-Map_Sonic,		PLCSon_Walk3_045-PLC_Sonic
		dc.w	MAPSon_Walk4_045-Map_Sonic,		PLCSon_Walk4_045-PLC_Sonic
		dc.w	MAPSon_Walk5_090-Map_Sonic,		PLCSon_Walk5_090-PLC_Sonic
		dc.w	MAPSon_Walk6_090-Map_Sonic,		PLCSon_Walk6_090-PLC_Sonic
		dc.w	MAPSon_Walk1_090-Map_Sonic,		PLCSon_Walk1_090-PLC_Sonic
		dc.w	MAPSon_Walk2_090-Map_Sonic,		PLCSon_Walk2_090-PLC_Sonic
		dc.w	MAPSon_Walk3_090-Map_Sonic,		PLCSon_Walk3_090-PLC_Sonic
		dc.w	MAPSon_Walk4_090-Map_Sonic,		PLCSon_Walk4_090-PLC_Sonic
		dc.w	MAPSon_Walk5_135-Map_Sonic,		PLCSon_Walk5_135-PLC_Sonic
		dc.w	MAPSon_Walk6_135-Map_Sonic,		PLCSon_Walk6_135-PLC_Sonic
		dc.w	MAPSon_Walk1_135-Map_Sonic,		PLCSon_Walk1_135-PLC_Sonic
		dc.w	MAPSon_Walk2_135-Map_Sonic,		PLCSon_Walk2_135-PLC_Sonic
		dc.w	MAPSon_Walk3_135-Map_Sonic,		PLCSon_Walk3_135-PLC_Sonic
		dc.w	MAPSon_Walk4_135-Map_Sonic,		PLCSon_Walk4_135-PLC_Sonic
		dc.w	MAPSon_Run1_000-Map_Sonic,		PLCSon_Run1_000-PLC_Sonic
		dc.w	MAPSon_Run2_000-Map_Sonic,		PLCSon_Run1_045-PLC_Sonic
		dc.w	MAPSon_Run3_000-Map_Sonic,		PLCSon_Run1_090-PLC_Sonic
		dc.w	MAPSon_Run4_000-Map_Sonic,		PLCSon_Run1_135-PLC_Sonic
		dc.w	MAPSon_Run1_045-Map_Sonic,		PLCSon_Run2_000-PLC_Sonic
		dc.w	MAPSon_Run2_045-Map_Sonic,		PLCSon_Run2_045-PLC_Sonic
		dc.w	MAPSon_Run3_045-Map_Sonic,		PLCSon_Run2_090-PLC_Sonic
		dc.w	MAPSon_Run4_045-Map_Sonic,		PLCSon_Run2_135-PLC_Sonic
		dc.w	MAPSon_Run1_090-Map_Sonic,		PLCSon_Run3_000-PLC_Sonic
		dc.w	MAPSon_Run2_090-Map_Sonic,		PLCSon_Run3_045-PLC_Sonic
		dc.w	MAPSon_Run3_090-Map_Sonic,		PLCSon_Run3_090-PLC_Sonic
		dc.w	MAPSon_Run4_090-Map_Sonic,		PLCSon_Run3_135-PLC_Sonic
		dc.w	MAPSon_Run1_135-Map_Sonic,		PLCSon_Run4_000-PLC_Sonic
		dc.w	MAPSon_Run2_135-Map_Sonic,		PLCSon_Run4_045-PLC_Sonic
		dc.w	MAPSon_Run3_135-Map_Sonic,		PLCSon_Run4_090-PLC_Sonic
		dc.w	MAPSon_Run4_135-Map_Sonic,		PLCSon_Run4_135-PLC_Sonic
		dc.w	MAPSon_Skid1-Map_Sonic,			PLCSon_Skid1-PLC_Sonic
		dc.w	MAPSon_Skid2-Map_Sonic,			PLCSon_Skid2-PLC_Sonic
		dc.w	MAPSon_Skid3-Map_Sonic,			PLCSon_Skid3-PLC_Sonic
		dc.w	MAPSon_Pull1-Map_Sonic,			PLCSon_Pull1-PLC_Sonic
		dc.w	MAPSon_Pull2-Map_Sonic,			PLCSon_Pull2-PLC_Sonic
		dc.w	MAPSon_Roll1-Map_Sonic,			PLCSon_Roll1-PLC_Sonic
		dc.w	MAPSon_Roll2-Map_Sonic,			PLCSon_Roll2-PLC_Sonic
		dc.w	MAPSon_Roll3-Map_Sonic,			PLCSon_Roll3-PLC_Sonic
		dc.w	MAPSon_Roll4-Map_Sonic,			PLCSon_Roll4-PLC_Sonic
		dc.w	MAPSon_Roll5-Map_Sonic,			PLCSon_Roll5-PLC_Sonic
		dc.w	MAPSon_Dizzy1-Map_Sonic,		PLCSon_Dizzy1-PLC_Sonic
		dc.w	MAPSon_Dizzy2-Map_Sonic,		PLCSon_Dizzy2-PLC_Sonic
		dc.w	MAPSon_Dizzy3-Map_Sonic,		PLCSon_Dizzy3-PLC_Sonic
		dc.w	MAPSon_Dizzy4-Map_Sonic,		PLCSon_Dizzy4-PLC_Sonic
		dc.w	MAPSon_Dizzy5-Map_Sonic,		PLCSon_Dizzy5-PLC_Sonic
		dc.w	MAPSon_Dizzy6-Map_Sonic,		PLCSon_Dizzy6-PLC_Sonic
		dc.w	MAPSon_Climb1-Map_Sonic,		PLCSon_Climb1-PLC_Sonic
		dc.w	MAPSon_Climb2-Map_Sonic,		PLCSon_Climb2-PLC_Sonic
		dc.w	MAPSon_Climb3-Map_Sonic,		PLCSon_Climb3-PLC_Sonic
		dc.w	MAPSon_Climb4-Map_Sonic,		PLCSon_Climb4-PLC_Sonic
		dc.w	MAPSon_Climb5-Map_Sonic,		PLCSon_Climb5-PLC_Sonic
		dc.w	MAPSon_Throw1-Map_Sonic,		PLCSon_Throw1-PLC_Sonic
		dc.w	MAPSon_Throw2-Map_Sonic,		PLCSon_Throw2-PLC_Sonic
		dc.w	MAPSon_Throw3-Map_Sonic,		PLCSon_Throw3-PLC_Sonic
		dc.w	MAPSon_Throw4-Map_Sonic,		PLCSon_Throw4-PLC_Sonic
		dc.w	MAPSon_WallJump1-Map_Sonic,		PLCSon_WallJump1-PLC_Sonic
		dc.w	MAPSon_WallJump2-Map_Sonic,		PLCSon_WallJump2-PLC_Sonic
		dc.w	MAPSon_WallJump3-Map_Sonic,		PLCSon_WallJump3-PLC_Sonic
		dc.w	MAPSon_WallJump4-Map_Sonic,		PLCSon_WallJump4-PLC_Sonic
		dc.w	MAPSon_WallJump5-Map_Sonic,		PLCSon_WallJump5-PLC_Sonic
		dc.w	MAPSon_Spindash1-Map_Sonic,		PLCSon_Spindash1-PLC_Sonic
		dc.w	MAPSon_Spindash2-Map_Sonic,		PLCSon_Spindash2-PLC_Sonic
		dc.w	MAPSon_Spindash3-Map_Sonic,		PLCSon_Spindash3-PLC_Sonic
		dc.w	MAPSon_Spindash4-Map_Sonic,		PLCSon_Spindash4-PLC_Sonic
		dc.w	MAPSon_Spindash5-Map_Sonic,		PLCSon_Spindash5-PLC_Sonic
		dc.w	MAPSon_Spindash6-Map_Sonic,		PLCSon_Spindash6-PLC_Sonic
; ---------------------------------------------------------------------------
; ===========================================================================