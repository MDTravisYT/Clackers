; ===========================================================================
; ---------------------------------------------------------------------------
; PLC and Mapping Main Index Block - Sonic
; ---------------------------------------------------------------------------
; An Example of the setout:
;
;			vvMapping Pointersvv			vvPLC Pointersvv
;
;		dc.w	"Location"-Map_Sonic2,			"Location"-PLC_Sonic
;		dc.w	"Location"-Map_Sonic2,			"Location"-PLC_Sonic
;		dc.w	"Location"-Map_Sonic2,			"Location"-PLC_Sonic
; etc, etc
; ---------------------------------------------------------------------------
; ===========================================================================
		dc.w	MAPSon2_Stand-Map_Sonic2,			PLCSon_Stand-PLC_Sonic
		dc.w	MAPSon2_LookUp-Map_Sonic2,		PLCSon_LookUp-PLC_Sonic
		dc.w	MAPSon2_LookDown-Map_Sonic2,		PLCSon_LookDown-PLC_Sonic
		dc.w	MAPSon2_Hurt-Map_Sonic2,			PLCSon_Hurt-PLC_Sonic
		dc.w	MAPSon2_Wait1-Map_Sonic2,			PLCSon_Wait1-PLC_Sonic
		dc.w	MAPSon2_Wait2-Map_Sonic2,			PLCSon_Wait2-PLC_Sonic
		dc.w	MAPSon2_BlncIn1-Map_Sonic2,		PLCSon_BlncIn1-PLC_Sonic
		dc.w	MAPSon2_BlncIn1-Map_Sonic2,		PLCSon_BlncIn1-PLC_Sonic
		dc.w	MAPSon2_BlncIn1-Map_Sonic2,		PLCSon_BlncIn1-PLC_Sonic
		dc.w	MAPSon2_BlncIn1-Map_Sonic2,		PLCSon_BlncIn1-PLC_Sonic
		dc.w	MAPSon2_BlncIn2-Map_Sonic2,		PLCSon_BlncIn2-PLC_Sonic
		dc.w	MAPSon2_BlncIn3-Map_Sonic2,		PLCSon_BlncIn3-PLC_Sonic
		dc.w	MAPSon2_BlncOut1-Map_Sonic2,		PLCSon_BlncOut1-PLC_Sonic
		dc.w	MAPSon2_BlncOut2-Map_Sonic2,		PLCSon_BlncOut2-PLC_Sonic
		dc.w	MAPSon2_BlncOut3-Map_Sonic2,		PLCSon_BlncOut3-PLC_Sonic
		dc.w	MAPSon2_Walk5_000-Map_Sonic2,		PLCSon_Walk5_000-PLC_Sonic
		dc.w	MAPSon2_Walk6_000-Map_Sonic2,		PLCSon_Walk6_000-PLC_Sonic
		dc.w	MAPSon2_Walk1_000-Map_Sonic2,		PLCSon_Walk1_000-PLC_Sonic
		dc.w	MAPSon2_Walk2_000-Map_Sonic2,		PLCSon_Walk2_000-PLC_Sonic
		dc.w	MAPSon2_Walk3_000-Map_Sonic2,		PLCSon_Walk3_000-PLC_Sonic
		dc.w	MAPSon2_Walk4_000-Map_Sonic2,		PLCSon_Walk4_000-PLC_Sonic
		dc.w	MAPSon2_Walk5_045-Map_Sonic2,		PLCSon_Walk5_045-PLC_Sonic
		dc.w	MAPSon2_Walk6_045-Map_Sonic2,		PLCSon_Walk6_045-PLC_Sonic
		dc.w	MAPSon2_Walk1_045-Map_Sonic2,		PLCSon_Walk1_045-PLC_Sonic
		dc.w	MAPSon2_Walk2_045-Map_Sonic2,		PLCSon_Walk2_045-PLC_Sonic
		dc.w	MAPSon2_Walk3_045-Map_Sonic2,		PLCSon_Walk3_045-PLC_Sonic
		dc.w	MAPSon2_Walk4_045-Map_Sonic2,		PLCSon_Walk4_045-PLC_Sonic
		dc.w	MAPSon2_Walk5_090-Map_Sonic2,		PLCSon_Walk5_090-PLC_Sonic
		dc.w	MAPSon2_Walk6_090-Map_Sonic2,		PLCSon_Walk6_090-PLC_Sonic
		dc.w	MAPSon2_Walk1_090-Map_Sonic2,		PLCSon_Walk1_090-PLC_Sonic
		dc.w	MAPSon2_Walk2_090-Map_Sonic2,		PLCSon_Walk2_090-PLC_Sonic
		dc.w	MAPSon2_Walk3_090-Map_Sonic2,		PLCSon_Walk3_090-PLC_Sonic
		dc.w	MAPSon2_Walk4_090-Map_Sonic2,		PLCSon_Walk4_090-PLC_Sonic
		dc.w	MAPSon2_Walk5_135-Map_Sonic2,		PLCSon_Walk5_135-PLC_Sonic
		dc.w	MAPSon2_Walk6_135-Map_Sonic2,		PLCSon_Walk6_135-PLC_Sonic
		dc.w	MAPSon2_Walk1_135-Map_Sonic2,		PLCSon_Walk1_135-PLC_Sonic
		dc.w	MAPSon2_Walk2_135-Map_Sonic2,		PLCSon_Walk2_135-PLC_Sonic
		dc.w	MAPSon2_Walk3_135-Map_Sonic2,		PLCSon_Walk3_135-PLC_Sonic
		dc.w	MAPSon2_Walk4_135-Map_Sonic2,		PLCSon_Walk4_135-PLC_Sonic
		dc.w	MAPSon2_Run1_000-Map_Sonic2,		PLCSon_Run1_000-PLC_Sonic
		dc.w	MAPSon2_Run2_000-Map_Sonic2,		PLCSon_Run1_045-PLC_Sonic
		dc.w	MAPSon2_Run3_000-Map_Sonic2,		PLCSon_Run1_090-PLC_Sonic
		dc.w	MAPSon2_Run4_000-Map_Sonic2,		PLCSon_Run1_135-PLC_Sonic
		dc.w	MAPSon2_Run1_045-Map_Sonic2,		PLCSon_Run2_000-PLC_Sonic
		dc.w	MAPSon2_Run2_045-Map_Sonic2,		PLCSon_Run2_045-PLC_Sonic
		dc.w	MAPSon2_Run3_045-Map_Sonic2,		PLCSon_Run2_090-PLC_Sonic
		dc.w	MAPSon2_Run4_045-Map_Sonic2,		PLCSon_Run2_135-PLC_Sonic
		dc.w	MAPSon2_Run1_090-Map_Sonic2,		PLCSon_Run3_000-PLC_Sonic
		dc.w	MAPSon2_Run2_090-Map_Sonic2,		PLCSon_Run3_045-PLC_Sonic
		dc.w	MAPSon2_Run3_090-Map_Sonic2,		PLCSon_Run3_090-PLC_Sonic
		dc.w	MAPSon2_Run4_090-Map_Sonic2,		PLCSon_Run3_135-PLC_Sonic
		dc.w	MAPSon2_Run1_135-Map_Sonic2,		PLCSon_Run4_000-PLC_Sonic
		dc.w	MAPSon2_Run2_135-Map_Sonic2,		PLCSon_Run4_045-PLC_Sonic
		dc.w	MAPSon2_Run3_135-Map_Sonic2,		PLCSon_Run4_090-PLC_Sonic
		dc.w	MAPSon2_Run4_135-Map_Sonic2,		PLCSon_Run4_135-PLC_Sonic
		dc.w	MAPSon2_Skid1-Map_Sonic2,			PLCSon_Skid1-PLC_Sonic
		dc.w	MAPSon2_Skid2-Map_Sonic2,			PLCSon_Skid2-PLC_Sonic
		dc.w	MAPSon2_Skid3-Map_Sonic2,			PLCSon_Skid3-PLC_Sonic
		dc.w	MAPSon2_Pull1-Map_Sonic2,			PLCSon_Pull1-PLC_Sonic
		dc.w	MAPSon2_Pull2-Map_Sonic2,			PLCSon_Pull2-PLC_Sonic
		dc.w	MAPSon2_Roll1-Map_Sonic2,			PLCSon_Roll1-PLC_Sonic
		dc.w	MAPSon2_Roll2-Map_Sonic2,			PLCSon_Roll2-PLC_Sonic
		dc.w	MAPSon2_Roll3-Map_Sonic2,			PLCSon_Roll3-PLC_Sonic
		dc.w	MAPSon2_Roll4-Map_Sonic2,			PLCSon_Roll4-PLC_Sonic
		dc.w	MAPSon2_Roll5-Map_Sonic2,			PLCSon_Roll5-PLC_Sonic
		dc.w	MAPSon2_Dizzy1-Map_Sonic2,		PLCSon_Dizzy1-PLC_Sonic
		dc.w	MAPSon2_Dizzy2-Map_Sonic2,		PLCSon_Dizzy2-PLC_Sonic
		dc.w	MAPSon2_Dizzy3-Map_Sonic2,		PLCSon_Dizzy3-PLC_Sonic
		dc.w	MAPSon2_Dizzy4-Map_Sonic2,		PLCSon_Dizzy4-PLC_Sonic
		dc.w	MAPSon2_Dizzy5-Map_Sonic2,		PLCSon_Dizzy5-PLC_Sonic
		dc.w	MAPSon2_Dizzy6-Map_Sonic2,		PLCSon_Dizzy6-PLC_Sonic
		dc.w	MAPSon2_Climb1-Map_Sonic2,		PLCSon_Climb1-PLC_Sonic
		dc.w	MAPSon2_Climb2-Map_Sonic2,		PLCSon_Climb2-PLC_Sonic
		dc.w	MAPSon2_Climb3-Map_Sonic2,		PLCSon_Climb3-PLC_Sonic
		dc.w	MAPSon2_Climb4-Map_Sonic2,		PLCSon_Climb4-PLC_Sonic
		dc.w	MAPSon2_Climb5-Map_Sonic2,		PLCSon_Climb5-PLC_Sonic
		dc.w	MAPSon2_Throw1-Map_Sonic2,		PLCSon_Throw1-PLC_Sonic
		dc.w	MAPSon2_Throw2-Map_Sonic2,		PLCSon_Throw2-PLC_Sonic
		dc.w	MAPSon2_Throw3-Map_Sonic2,		PLCSon_Throw3-PLC_Sonic
		dc.w	MAPSon2_Throw4-Map_Sonic2,		PLCSon_Throw4-PLC_Sonic
		dc.w	MAPSon2_WallJump1-Map_Sonic2,		PLCSon_WallJump1-PLC_Sonic
		dc.w	MAPSon2_WallJump2-Map_Sonic2,		PLCSon_WallJump2-PLC_Sonic
		dc.w	MAPSon2_WallJump3-Map_Sonic2,		PLCSon_WallJump3-PLC_Sonic
		dc.w	MAPSon2_WallJump4-Map_Sonic2,		PLCSon_WallJump4-PLC_Sonic
		dc.w	MAPSon2_WallJump5-Map_Sonic2,		PLCSon_WallJump5-PLC_Sonic
		dc.w	MAPSon2_Spindash1-Map_Sonic2,		PLCSon_Spindash1-PLC_Sonic
		dc.w	MAPSon2_Spindash2-Map_Sonic2,		PLCSon_Spindash2-PLC_Sonic
		dc.w	MAPSon2_Spindash3-Map_Sonic2,		PLCSon_Spindash3-PLC_Sonic
		dc.w	MAPSon2_Spindash4-Map_Sonic2,		PLCSon_Spindash4-PLC_Sonic
		dc.w	MAPSon2_Spindash5-Map_Sonic2,		PLCSon_Spindash5-PLC_Sonic
		dc.w	MAPSon2_Spindash6-Map_Sonic2,		PLCSon_Spindash6-PLC_Sonic
		dc.w	MAPSon2_Spring-Map_Sonic2,		PLCSon_Spring-PLC_Sonic
; ---------------------------------------------------------------------------
; ===========================================================================