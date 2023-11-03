Walkin_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Walkin_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $35

	smpsHeaderDAC       Walkin_DAC
	smpsHeaderFM        Walkin_FM1,	$00, $10
	smpsHeaderFM        Walkin_FM2,	$00, $10
	smpsHeaderFM        Walkin_FM3,	$0C, $15
	smpsHeaderFM        Walkin_FM4,	$0C, $15
	smpsHeaderFM        Walkin_FM5,	$00, $12
	smpsHeaderPSG       Walkin_PSG1,	$F4, $04, $00, $00
	smpsHeaderPSG       Walkin_PSG2,	$E8, $04, $00, $00
	smpsHeaderPSG       Walkin_PSG3,	$23, $01, $00, $00

; FM1 Data
Walkin_FM1:
	smpsSetvoice        $00
	dc.b	nRst, $18
	smpsModSet          $03, $01, $F6, $00
	dc.b	nG1
	smpsModSet          $00, $00, $00, $00

Walkin_Jump02:
	smpsCall            Walkin_Call05
	smpsCall            Walkin_Call05
	smpsAlterPitch      $FE
	smpsCall            Walkin_Call05
	smpsAlterPitch      $02
	smpsCall            Walkin_Call05
	smpsJump            Walkin_Jump02

Walkin_Call05:
	dc.b	nG1, $0C, nRst, nG1, nRst, $08, nG1, $0C, nF1, $04, nG1, $0C
	dc.b	nBb1, nF1, nG1, $0C, nG2, $06, nRst, nG1, $0C, nRst, $08, nG1
	dc.b	$0C, nF1, $04, nG1, $0C, nBb1, nF1
	smpsReturn

; FM2 Data
Walkin_FM2:
	smpsSetvoice        $01
	dc.b	nRst, $30

Walkin_Jump01:
	smpsCall            Walkin_Call04
	dc.b	nRst, $0C
	smpsJump            Walkin_Jump01

Walkin_Call07:
	dc.b	nF3, $0C, nRst, nG3, nRst, nBb3, $03, smpsNoAttack, nB3, $11, nG3, $04
	dc.b	nRst, $0C
	smpsReturn

Walkin_Call04:
	smpsCall            Walkin_Call07
	dc.b	nC4, $0C, smpsNoAttack, $08, nRst, $04, nC4, $08, nRst, $04, nC4, $08
	dc.b	nRst, $04, nD4, $08, nRst, $04, nC4, $08, nB3, $04, nRst, $08
	dc.b	nG3, $18, nRst, $04
	smpsCall            Walkin_Call07
	dc.b	nF4, $0C, smpsNoAttack, $08, nRst, $04, nG4, $08, nRst, $04, nF4, $08
	dc.b	nE4, $04, nRst, $08, nD4, $34, nRst, $0C, nBb3, $03, smpsNoAttack, nC4
	dc.b	$15, nA3, $08, nRst, $04, nBb3, $03, smpsNoAttack, nC4, $11, nD4, $04
	dc.b	nRst, $0C, nEb4, $0C, smpsNoAttack, $08, nRst, $04, nD4, $08, nRst, $04
	dc.b	nEb4, $08, nD4, $04, nRst, $08, nC4, $0C, nRst, $04, nA3, $08
	dc.b	nRst, $04, nBb3, $0C, nB3, $08, nRst, $04, nC4, $0C, nRst, nG3
	dc.b	nRst, nA3, $03, smpsNoAttack, nBb3, $11, nG3, $04, nRst, $0C, nF3, smpsNoAttack
	dc.b	$08, nRst, $04, nG3, $48
	smpsReturn

; FM3 Data
Walkin_FM3:
	smpsSetvoice        $02
	smpsPan             panLeft, $00
	dc.b	nRst, $30

Walkin_Jump00:
	smpsCall            Walkin_Call03
	dc.b	nRst, $18
	smpsCall            Walkin_Call03
	dc.b	nRst, $08, nF3, $04, nFs3, $08, nG3, $04, nRst, $18, nEb3, $08
	dc.b	nF3, $04, nRst, $08, nC3, $04, nRst, $2C, nF3, $04, smpsNoAttack, $08
	dc.b	nEb3, $04, nF3, $08, nRst, $04, nF3, $08, nRst, $04, nEb3, $08
	dc.b	nRst, $04, nD3, $08, nEb3, $04, nRst, $08, nC3, $04, nRst, $08
	dc.b	nF3, $04, nFs3, $08, nG3, $04, nRst, $18, nBb3, $08, nC4, $04
	dc.b	nRst, $08, nG3, $04, nRst, $0C, nD4, $08, nRst, $0C, nD4, $04
	dc.b	nRst, $0C, nRst, $08, nFs3, $04, nG3, $08, nRst, $04, nF3, $08
	dc.b	nRst, $04, nD3, $08, nRst, $04, nC3, $08, nRst, $0C, nG2, nF3
	dc.b	$04, nFs3, $08, nG3, $04
	smpsJump            Walkin_Jump00

Walkin_Call03:
	dc.b	nRst, $18, nBb3, $08, nC4, $04, nRst, $08, nG3, $04, nRst, $2C
	dc.b	nF3, $04, smpsNoAttack, $08, nRst, $04, nF3, $08, nRst, $04, nG3, $08
	dc.b	nRst, $04, nD3, $08, nRst, $04, nG3, $08, nFs3, $04, nF3, $08
	dc.b	nG3, $04
	smpsReturn

; FM4 Data
Walkin_FM4:
	smpsSetvoice        $02
	smpsPan             panRight, $00
	dc.b	nRst, $30

Walkin_Loop02:
	dc.b	nRst, $18, nF3, $08, nRst, $0C, nF3, $04, nRst, $2C, nD3, $04
	dc.b	smpsNoAttack, $08, nD3, $04, $08, nRst, $04, nBb2, $08, nRst, $04, nBb2
	dc.b	$08, nRst, $04, nD3, $08, nRst, $0C, nD3, $04, nRst, $18
	smpsLoop            $00, $02, Walkin_Loop02
	dc.b	nRst, $18, nA2, $08, nRst, $0C, nA2, $04, nRst, $2C, nA2, $04
	dc.b	smpsNoAttack, $08, nA2, $04, nRst, $0C, nA2, $08, nRst, $04, nA2, $08
	dc.b	nRst, $04, nA2, $08, $04, nRst, $08, nA2, $04, nRst, $18, nRst
	dc.b	$18, nF3, $08, nRst, $0C, nF3, $04, nRst, $0C, nF3, $08, nRst
	dc.b	$0C, nF3, $04, nRst, $0C, nRst, $08, nD3, $0C, nRst, $04, nBb2
	dc.b	$08, nRst, $04, nBb2, $08, nRst, $04, nF2, $08, $04, nRst, $08
	dc.b	nD2, $0C, nRst, $10
	smpsJump            Walkin_Loop02

; FM5 Data
Walkin_FM5:
	smpsSetvoice        $03
	dc.b	nRst, $30

Walkin_Loop01:
	smpsCall            Walkin_Call01
	smpsLoop            $00, $04, Walkin_Loop01
	smpsCall            Walkin_Call02
	smpsCall            Walkin_Call02
	smpsCall            Walkin_Call01
	smpsCall            Walkin_Call01
	smpsJump            Walkin_Loop01

Walkin_Call01:
	dc.b	nRst, $0C, nF3, nG3, nBb3, nF3, $08, nG3, $0C, nBb3, nF3, $04
	dc.b	nG3, $0C
	smpsReturn

Walkin_Call02:
	dc.b	nRst, $0C, nEb3, nF3, nA3, nEb3, $08, nF3, $0C, nA3, nEb3, $04
	dc.b	nF3, $0C
	smpsReturn

; PSG1 Data
Walkin_PSG1:
	smpsPSGvoice        sTone_03
	smpsModSet          $01, $01, $01, $03
	dc.b	nRst, $30

Walkin_Jump03:
	dc.b	nRst, $03
	smpsCall            Walkin_Call04
	dc.b	nRst, $09
	smpsJump            Walkin_Jump03

; PSG2 Data
Walkin_PSG2:
	smpsPSGvoice        sTone_0C
	dc.b	nRst, $30

Walkin_Loop04:
	smpsCall            Walkin_Call06
	smpsLoop            $01, $04, Walkin_Loop04
	smpsAlterPitch      $FE
	smpsCall            Walkin_Call06
	smpsCall            Walkin_Call06
	smpsAlterPitch      $02
	smpsCall            Walkin_Call06
	smpsCall            Walkin_Call06
	smpsJump            Walkin_Loop04

Walkin_Call06:
	dc.b	nG3, $04, nRst, nD4
	smpsLoop            $00, $08, Walkin_Call06
	smpsReturn

; PSG3 Data
Walkin_PSG3:
	smpsPSGform         $E7
	dc.b	nRst, $30

Walkin_Loop03:
	smpsPSGvoice        sTone_02
	dc.b	(nMaxPSG2-$23)&$FF, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $08, $04, (nMaxPSG2-$23)&$FF, $0C
	dc.b	$0C, $0C, $0C, $0C, $0C, $08, $04
	smpsPSGvoice        sTone_05
	dc.b	$0C
	smpsLoop            $00, $04, Walkin_Loop03
	smpsJump            Walkin_Loop03

; DAC Data
Walkin_DAC:
	dc.b	dCrackerKick, $0C, dCrackerSnare, dCrackerSnare, dCrackerSnare, $08, $04

Walkin_Loop00:
	smpsCall            Walkin_Call00
	dc.b	dCrackerKick, $18, dCrackerSnare, dCrackerKick, dCrackerSnare, $14, $04
	smpsCall            Walkin_Call00
	dc.b	dCrackerKick, $18, dCrackerSnare, dCrackerKick, dCrackerSnare, $08, $04, $08, $04
	smpsLoop            $00, $02, Walkin_Loop00
	smpsJump            Walkin_Loop00

Walkin_Call00:
	dc.b	dCrackerKick, $18, dCrackerSnare, dCrackerKick, dCrackerSnare, $14, $04
	smpsReturn

Walkin_Voices:
;	Voice $00
;	$4B
;	$12, $11, $04, $03, 	$3F, $9F, $9F, $9F, 	$02, $0C, $13, $07
;	$12, $0A, $0B, $0A, 	$0F, $3F, $8F, $8F, 	$1B, $0F, $15, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $01
	smpsVcUnusedBits    $01
	smpsVcDetune        $00, $00, $01, $01
	smpsVcCoarseFreq    $03, $04, $01, $02
	smpsVcRateScale     $02, $02, $02, $00
	smpsVcAttackRate    $1F, $1F, $1F, $3F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $07, $13, $0C, $02
	smpsVcDecayRate2    $0A, $0B, $0A, $12
	smpsVcDecayLevel    $08, $08, $03, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $15, $0F, $1B

;	Voice $01
;	$38
;	$58, $54, $31, $31, 	$1A, $1A, $14, $13, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$1C, $26, $20, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $05, $05
	smpsVcCoarseFreq    $01, $01, $04, $08
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $13, $14, $1A, $1A
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $20, $26, $1C

;	Voice $02
;	$97
;	$66, $31, $50, $22, 	$1C, $98, $1F, $1F, 	$12, $0F, $06, $0C
;	$00, $1A, $10, $04, 	$0F, $FF, $FF, $FF, 	$80, $80, $80, $80
	smpsVcAlgorithm     $07
	smpsVcFeedback      $02
	smpsVcUnusedBits    $02
	smpsVcDetune        $02, $05, $03, $06
	smpsVcCoarseFreq    $02, $00, $01, $06
	smpsVcRateScale     $00, $00, $02, $00
	smpsVcAttackRate    $1F, $1F, $18, $1C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $06, $0F, $12
	smpsVcDecayRate2    $04, $10, $1A, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $00

;	Voice $03
;	$3B
;	$32, $36, $31, $04, 	$DF, $1F, $1F, $DF, 	$0D, $0D, $02, $09
;	$0E, $0A, $14, $F0, 	$FF, $0F, $4F, $FF, 	$28, $18, $0F, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $03, $03, $03
	smpsVcCoarseFreq    $04, $01, $06, $02
	smpsVcRateScale     $03, $00, $00, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $02, $0D, $0D
	smpsVcDecayRate2    $F0, $14, $0A, $0E
	smpsVcDecayLevel    $0F, $04, $00, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $0F, $18, $28

