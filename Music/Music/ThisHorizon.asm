ThisHorizon_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     ThisHorizon_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $03

	smpsHeaderDAC       ThisHorizon_PWM2
	smpsHeaderFM        ThisHorizon_FM1,	$0C, $0C
	smpsHeaderFM        ThisHorizon_FM2,	$0C, $0C
	smpsHeaderFM        ThisHorizon_FM3,	$00, $10
	smpsHeaderFM        ThisHorizon_FM4,	$00, $0C
	smpsHeaderFM        ThisHorizon_FM5,	$00, $10
;	smpsHeaderFM        ThisHorizon_FM6,	$00, $10
	smpsHeaderPSG       ThisHorizon_PSG1,	$F4, $03, $00, sTone_0C
	smpsHeaderPSG       ThisHorizon_PSG2,	$F4, $03, $00, sTone_0C
	smpsHeaderPSG       ThisHorizon_PSG3,	$23, $01, $00, sTone_02
;	smpsHeaderPWM       ThisHorizon_PWM1,	$00, $99
;	smpsHeaderPWM       ThisHorizon_PWM2,	$00, $11
;	smpsHeaderPWM       ThisHorizon_PWM3,	$00, $99
;	smpsHeaderPWM       ThisHorizon_PWM4,	$00, $33

; Dummy DAC data
ThisHorizon_DAC:
	smpsStop


; FM1 Data
ThisHorizon_FM1:
	smpsSetvoice        $02
	dc.b	nRst, $60

horizon_Loop05:
	smpsCall            horizon_Call03
	dc.b	smpsNoAttack, $0C, nD4, $18, nC4, $0C, smpsNoAttack, $0C
	smpsSetvoice        $03
	smpsPan             panRight, $00
	dc.b	nF3, $0C
	smpsFMAlterVol      $0A
	dc.b	$06
	smpsFMAlterVol      $F6
	dc.b	nE3, $0C
	smpsFMAlterVol      $0A
	dc.b	$06
	smpsFMAlterVol      $F6
	dc.b	nA2, $0C
	smpsFMAlterVol      $0A
	dc.b	$06
	smpsFMAlterVol      $F6
	dc.b	nC3, $12
	smpsFMAlterVol      $0A
	dc.b	$06
	smpsFMAlterVol      $F6
	dc.b	nRst
	smpsSetvoice        $02
	smpsPan             panCenter, $00
	smpsCall            horizon_Call03
	dc.b	smpsNoAttack, $0C, nD3, $18, nF3, $0C, smpsNoAttack, $0C, nG3, $24, nF3, $18
	dc.b	nE3, $12, nD3, $06, smpsNoAttack, $60
	smpsStop

horizon_Call03:
	dc.b	nRst, $18, nA3, nG3, nC4, $06, nRst, nC4, $0C, smpsNoAttack, $0C, nD4
	dc.b	nA3, $24, nG3, $0C, nA3, nBb3, smpsNoAttack, $0C, nA3, nG3, nF3
	smpsReturn

; FM2 Data
ThisHorizon_FM2:
	smpsSetvoice        $02
	smpsFMAlterVol      $05
	smpsModSet          $02, $01, $02, $05
	smpsPan             panLeft, $00
	dc.b	nRst, $60

horizon_Loop04:
	dc.b	nRst, $0C
	smpsCall            horizon_Call03
	dc.b	smpsNoAttack, $0C, nD4, $18, nC4, $0C
	smpsSetvoice        $03
	smpsFMAlterVol      $FB
	smpsModSet          $00, $00, $00, $00
	dc.b	nA2, $0C
	smpsFMAlterVol      $0A
	dc.b	$06
	smpsFMAlterVol      $F6
	dc.b	nG2, $0C
	smpsFMAlterVol      $0A
	dc.b	$06
	smpsFMAlterVol      $F6
	dc.b	nC2, $0C
	smpsFMAlterVol      $0A
	dc.b	$06
	smpsFMAlterVol      $F6
	dc.b	nF2, $12
	smpsFMAlterVol      $0A
	dc.b	$06
	smpsFMAlterVol      $F6
	dc.b	nRst
	smpsSetvoice        $02
	smpsFMAlterVol      $05
	smpsModSet          $02, $01, $02, $05
	dc.b	nRst, $0C
	smpsCall            horizon_Call03
	dc.b	smpsNoAttack, $0C, nD3, $18, nF3, $0C, smpsNoAttack, $0C, nG3, $24, nF3, $18
	dc.b	nE3, $12, nD3, $06, smpsNoAttack, $60
	smpsStop

; FM3 Data
ThisHorizon_FM3:
	smpsSetvoice        $01
	dc.b	nRst, $60

horizon_Loop03:
	smpsCall            horizon_Call02
	dc.b	nRst, $0C, nA3
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nA3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nG3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nG3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nG3, $0C, nRst, $0C, nG3
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nG3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nG3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nG3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nA3, $0C
	smpsCall            horizon_Call02
	dc.b	nRst, $0C, nA3
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nA3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nA3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nA3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nA3, $0C, nRst, $0C, nG3
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nG3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nG3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nRst, nG3, $12, nA3, $06, smpsNoAttack, $60
	smpsStop
	smpsStop

horizon_Call02:
	dc.b	nRst, $0C, nA3
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nA3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nG3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nG3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nG3, $0C, nRst, $0C, nG3
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nG3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nA3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nA3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nA3, $0C
	smpsReturn

; FM4 Data
ThisHorizon_FM4:
	smpsSetvoice        $00
	dc.b	nRst, $30, nG1, $06, nG2, nG1, $0C, nA1, $06, nA2, nA1, $0C

horizon_Loop00:
	smpsCall            horizon_Call00
	dc.b	nG1, $12, nG2, $06, nRst, $0C, nG1, nC2, $18, nC3, $0C, nC2
	dc.b	nF1, $12, nF2, $06, nRst, $0C, nF1, $0C, $12, $06, nF2, $0C
	dc.b	nF1
	smpsCall            horizon_Call00
	dc.b	nG1, $12, nG2, $06, nRst, $0C, nG1, nEb2, $18, nEb3, $0C, nEb2
	dc.b	nD2, $12, nD3, $06, nRst, $0C, nD2, nRst, $06, nD3, nRst, nD3
	dc.b	nD2, nC2, $0C, nBb1, $06, smpsNoAttack, $60
	smpsStop

horizon_Call00:
	dc.b	nBb1, $12, nBb2, $06, nRst, $0C, nBb1, $0C, $18, nBb2, $0C, nBb1
	dc.b	nA1, $12, nA2, $06, nRst, $0C, nA1, nD2, $12, $06, nD3, $0C
	dc.b	nD2
	smpsReturn

; FM5 Data
ThisHorizon_FM5:
	smpsSetvoice        $01
	dc.b	nRst, $60

horizon_Loop01:
	dc.b	nRst, $0C, nD3
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nD3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nC3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nC3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nC3, $0C, nRst, $0C, nC3
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nC3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nC3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nC3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nC3, $0C
	smpsLoop            $00, $03, horizon_Loop01
	dc.b	nRst, $0C, nD3
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nD3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nD3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nD3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nD3, $0C, nRst, $0C, nC3
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nC3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nC3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nRst, $06, nC3, $12, nD3, $06, smpsNoAttack, $60
	smpsStop

; FM6 Data
ThisHorizon_FM6:
	smpsStop


ThisHorizon_Call06:
	dc.b	nRst, $18, nA3, nG3, nC4, $06, nRst, nC4, $0C, smpsNoAttack, $0C, nD4
	dc.b	nA3, $24, nG3, $0C, nA3, nBb3, smpsNoAttack, $0C, nA3, nG3, nF3
	smpsReturn

; PSG1 Data
ThisHorizon_PSG1:
	smpsPSGvoice        sTone_03
	smpsPSGAlterVol     $02
	dc.b	nRst, $30, nC4, $06, nG3, nC3, nC4, nG3, nC3, nC4, nG3
	smpsPSGAlterVol     $FE

horizon_Loop08:
	dc.b	nC3, $06, nC3, nC4, nG3, nC3, nC4, nG3, nC3, nC4, nG3, nC3
	dc.b	nC4, nG3, nC3, nC4, nG3
	smpsLoop            $00, $08, horizon_Loop08
	smpsStop
	smpsJump            horizon_Loop08

; PSG2 Data
ThisHorizon_PSG2:
	smpsPSGvoice        sTone_04
	smpsPSGAlterVol     $05
	dc.b	nRst, $01
	smpsAlterNote       $02
	dc.b	nRst, $30, nC4, $06, nG3, nC3, nC4, nG3, nC3, nC4, nG3, $05
	smpsPSGvoice        sTone_08
	smpsPSGAlterVol     $FB
	smpsAlterNote       $FE
	smpsModSet          $08, $01, $01, $02

horizon_Loop07:
	smpsCall            horizon_Call03
	dc.b	smpsNoAttack, $0C, nD4, $18, nC4, $0C, smpsNoAttack, $60
	smpsCall            horizon_Call03
	dc.b	smpsNoAttack, $0C, nD3, $18, nF3, $0C, smpsNoAttack, $0C, nG3, $24, nF3, $18
	dc.b	nE3, $12, nD3, $06, smpsNoAttack, $60
	smpsStop

; PSG3 Data
ThisHorizon_PSG3:
	smpsPSGform         $E7
	dc.b	nRst, $60

horizon_Loop06:
	smpsCall            horizon_Call04
	smpsLoop            $00, $04, horizon_Loop06
	smpsPSGvoice        sTone_05
	dc.b	(nMaxPSG2-$23)&$FF, $60
;	smpsCall            horizon_Call04
;	smpsPSGvoice        sTone_05
;	dc.b	(nMaxPSG2-$23)&$FF, $0C
;	smpsPSGvoice        sTone_02
;	dc.b	$0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C
;	smpsPSGvoice        sTone_05
;	dc.b	$0C
;	smpsPSGvoice        sTone_02
;	dc.b	$06
;	smpsPSGvoice        sTone_05
;	dc.b	$0C
;	smpsPSGvoice        sTone_02
;	dc.b	$06
;	smpsPSGvoice        sTone_05
;	dc.b	$0C
;	smpsPSGvoice        sTone_02
;	dc.b	$06
;	smpsPSGvoice        sTone_05
;	dc.b	$12
;	smpsPSGvoice        sTone_02
;	dc.b	$0C
;	smpsCall            horizon_Call04
;	smpsCall            horizon_Call04
	smpsStop

horizon_Call04:
	smpsPSGvoice        sTone_05
	dc.b	(nMaxPSG2-$23)&$FF, $0C
	smpsPSGvoice        sTone_02
	dc.b	$0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C
	dc.b	$0C, $0C, $0C
	smpsReturn

; PWM1 Data
ThisHorizon_PWM1:
	dc.b	nRst, $60, nRst, $60

ThisHorizon_Loop03:
	dc.b	dCrackerKick, $24, $0C, $24, $0C, $24, $0C, $12, $12, $0C
	smpsLoop            $00, $08, ThisHorizon_Loop03
	smpsJump            ThisHorizon_Loop03

; PWM2 Data
ThisHorizon_PWM2:

ThisHorizon_Loop02:
	dc.b	nRst, $0C, dCrackerSnare, dCrackerSnare, dCrackerSnare, $06, dCrackerSnare, dCrackerSnare, dCrackerSnare, dCrackerTimpaniMid, nRst, dCrackerSnare
	dc.b	dCrackerSnare
	smpsFMAlterVol      $90
	dc.b	dCrackerTimpaniLow
	smpsFMAlterVol      $70
	dc.b	dCrackerSnare

ThisHorizon_Jump01:
	smpsCall            ThisHorizon_Call03
	smpsCall            ThisHorizon_Call03
;	dc.b	nRst, $18, dCrackerSnare, nRst, dCrackerSnare, nRst, dCrackerSnare, nRst, dCrackerSnare, nRst, dCrackerSnare, nRst
;	dc.b	dCrackerSnare, nRst, $0C
;	smpsFMAlterVol      $F9
;	dc.b	dCrackerTimpaniHi, $06, dCrackerTimpaniHi, nRst, dCrackerTimpaniHi
;	smpsFMAlterVol      $07
;	dc.b	dCrackerTimpaniMid, nRst, dCrackerTimpaniMid, dCrackerTimpaniMid, nRst, dCrackerTimpaniMid
;	smpsFMAlterVol      $90
;	dc.b	dCrackerTimpaniLow, $0C
;	smpsFMAlterVol      $70
;	dc.b	dCrackerSnare
;	smpsCall            ThisHorizon_Call03
	smpsStop

ThisHorizon_Call03:
	dc.b	nRst, $18, dCrackerSnare
	smpsLoop            $00, $06, ThisHorizon_Call03
	dc.b	nRst, $0C, dCrackerSnare, dCrackerSnare, dCrackerSnare, $06, dCrackerSnare, nRst, dCrackerSnare, nRst, nRst, dCrackerSnare
	dc.b	dCrackerSnare
	smpsFMAlterVol      $90
	dc.b	dCrackerTimpaniLow
	smpsFMAlterVol      $70
	dc.b	nRst
	smpsReturn


ThisHorizon_Voices:
;	Voice $00
;	$3B
;	$53, $31, $02, $03, 	$DF, $9F, $5F, $9F, 	$14, $08, $0E, $07
;	$13, $0E, $0F, $07, 	$8F, $7F, $3F, $8F, 	$05, $18, $1E, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $03, $05
	smpsVcCoarseFreq    $03, $02, $01, $03
	smpsVcRateScale     $02, $01, $02, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $07, $0E, $08, $14
	smpsVcDecayRate2    $07, $0F, $0E, $13
	smpsVcDecayLevel    $08, $03, $07, $08
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1E, $18, $05

;	Voice $01
;	$3B
;	$08, $02, $02, $02, 	$5D, $5D, $5D, $5E, 	$07, $07, $06, $0B
;	$15, $15, $14, $18, 	$FF, $FF, $FF, $FF, 	$24, $26, $17, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $02, $02, $08
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $1E, $1D, $1D, $1D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0B, $06, $07, $07
	smpsVcDecayRate2    $18, $14, $15, $15
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $17, $26, $24

;	Voice $02
;	$2D
;	$77, $65, $05, $15, 	$1F, $9F, $9F, $9F, 	$00, $03, $03, $05
;	$00, $18, $16, $16, 	$0F, $5C, $5C, $5C, 	$22, $8B, $8B, $8A
	smpsVcAlgorithm     $05
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $00, $06, $07
	smpsVcCoarseFreq    $05, $05, $05, $07
	smpsVcRateScale     $02, $02, $02, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $03, $03, $00
	smpsVcDecayRate2    $16, $16, $18, $00
	smpsVcDecayLevel    $05, $05, $05, $00
	smpsVcReleaseRate   $0C, $0C, $0C, $0F
	smpsVcTotalLevel    $0A, $0B, $0B, $22

;	Voice $03
;	$3D
;	$02, $02, $01, $02, 	$94, $19, $19, $19, 	$0F, $0D, $0D, $0D
;	$07, $04, $04, $04, 	$25, $1A, $1A, $1A, 	$14, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $01, $02, $02
	smpsVcRateScale     $00, $00, $00, $02
	smpsVcAttackRate    $19, $19, $19, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $0D, $0D, $0F
	smpsVcDecayRate2    $04, $04, $04, $07
	smpsVcDecayLevel    $01, $01, $01, $02
	smpsVcReleaseRate   $0A, $0A, $0A, $05
	smpsVcTotalLevel    $00, $00, $00, $14

;	Voice $04
;	$28
;	$44, $47, $12, $71, 	$1F, $12, $1F, $1F, 	$04, $01, $04, $0C
;	$01, $01, $01, $00, 	$1F, $1F, $1F, $1F, 	$26, $17, $14, $85
	smpsVcAlgorithm     $00
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $01, $04, $04
	smpsVcCoarseFreq    $01, $02, $07, $04
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $12, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $04, $01, $04
	smpsVcDecayRate2    $00, $01, $01, $01
	smpsVcDecayLevel    $01, $01, $01, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $05, $14, $17, $26

