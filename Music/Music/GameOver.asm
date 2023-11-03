GameOver_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     GameOver_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $04

	smpsHeaderDAC       GameOver_DAC
	smpsHeaderFM        GameOver_FM1,	$E8, $0A
	smpsHeaderFM        GameOver_FM2,	$F4, $0F
	smpsHeaderFM        GameOver_FM3,	$F4, $0F
	smpsHeaderFM        GameOver_FM4,	$F4, $0D
	smpsHeaderFM        GameOver_FM5,	$DC, $16
	smpsHeaderPSG       GameOver_PSG1,	$D0, $03, $03, $00
	smpsHeaderPSG       GameOver_PSG2,	$DC, $06, $03, $00
	smpsHeaderPSG       GameOver_PSG3,	$DC, $00, $00, sTone_03

; FM1 Data
GameOver_FM1:
	smpsSetvoice        $00
	smpsModSet          $20, $01, $04, $05
	dc.b	nRst, $18, nCs6, $24, nRst, $0C, nCs6, nRst, nD6, $24, nB5, $3C
	dc.b	nCs6, $0C, nRst, nCs6, nRst, nCs6, nRst, nA5, nRst, nG5, $24, nB5
	dc.b	$18, nRst, $24, nC6, $08, nRst, nC6, nB5, $0C, nRst, nBb5, nRst
	dc.b	nA5, nRst
	smpsModSet          $28, $01, $18, $05
	dc.b	nAb5, $60, smpsNoAttack, $60
	smpsStop

; FM2 Data
GameOver_FM2:
	smpsSetvoice        $01
	dc.b	nRst, $01, nE7, $0C, nRst, nE7, nRst, nCs7, nRst, nCs7, nRst, nD7
	dc.b	$2A, nD7, $36, nE7, $0C, nRst, nE7, nRst, nCs7, nRst, nCs7, nRst
	dc.b	nG7, $2A, nG7, $36
	smpsStop

; FM3 Data
GameOver_FM3:
	smpsSetvoice        $01
	dc.b	nCs7, $18, nCs7, nA6, nA6, nB6, $2A, nB6, $36, nCs7, $18, nCs7
	dc.b	nA6, nA6, nD7, $2A, nD7, $36
	smpsStop

; FM4 Data
GameOver_FM4:
	smpsSetvoice        $02
	smpsFade            $01
	dc.b	nA3, $0C, nRst, nA3, nRst, nE3, nRst, nE3, nRst, nG3, $2A, nFs3
	dc.b	$18, nG3, $06, nFs3, $18, nA3, $0C, nRst, nA3, nRst, nE3, nRst
	dc.b	nE3, nRst, nD4, $2A, nCs4, $18, nD4, $06, nCs4, $18, nA3, $08
	dc.b	nRst, nA3, nAb3, $0C, nRst, nG3, nRst, nFs3, nRst, nFs3, $60, smpsNoAttack
	dc.b	$60
	smpsStop

; FM5 Data
GameOver_FM5:
	smpsSetvoice        $03
	dc.b	nRst, $60, nD7, $24, nRst, $06, nD7, $36, nRst, $60, nG7, $24
	dc.b	nRst, $06, nG7, $36
	smpsStop

; PSG1 Data
GameOver_PSG1:
	smpsStop

; PSG2 Data
GameOver_PSG2:
	smpsStop

; PSG3 Data
GameOver_PSG3:
	smpsStop

; DAC Data
GameOver_DAC:
	dc.b	nRst, $30, dCrackerKick
	smpsLoop            $00, $04, GameOver_DAC
	smpsStop

GameOver_Voices:
;	Voice $00
;	$3A
;	$51, $08, $51, $02, 	$1E, $1E, $1E, $10, 	$1F, $1F, $1F, $0F
;	$00, $00, $00, $02, 	$0F, $0F, $0F, $1F, 	$18, $24, $22, $81
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $05, $00, $05
	smpsVcCoarseFreq    $02, $01, $08, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $10, $1E, $1E, $1E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0F, $1F, $1F, $1F
	smpsVcDecayRate2    $02, $00, $00, $00
	smpsVcDecayLevel    $01, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $22, $24, $18

;	Voice $01
;	$3C
;	$33, $30, $73, $70, 	$94, $9F, $96, $9F, 	$12, $00, $14, $0F
;	$04, $0A, $04, $0D, 	$2F, $0F, $4F, $2F, 	$33, $80, $1A, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $03, $03
	smpsVcCoarseFreq    $00, $03, $00, $03
	smpsVcRateScale     $02, $02, $02, $02
	smpsVcAttackRate    $1F, $16, $1F, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0F, $14, $00, $12
	smpsVcDecayRate2    $0D, $04, $0A, $04
	smpsVcDecayLevel    $02, $04, $00, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1A, $00, $33

;	Voice $02
;	$3A
;	$01, $07, $01, $01, 	$8E, $8E, $8D, $53, 	$0E, $0E, $0E, $03
;	$00, $00, $00, $07, 	$1F, $FF, $1F, $0F, 	$1C, $28, $27, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $07, $01
	smpsVcRateScale     $01, $02, $02, $02
	smpsVcAttackRate    $13, $0D, $0E, $0E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $0E, $0E
	smpsVcDecayRate2    $07, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $0F, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $27, $28, $1C

;	Voice $03
;	$1F
;	$66, $31, $53, $22, 	$1C, $98, $1F, $1F, 	$12, $0F, $0F, $0F
;	$00, $00, $00, $00, 	$FF, $0F, $0F, $0F, 	$8C, $8D, $8A, $8B
	smpsVcAlgorithm     $07
	smpsVcFeedback      $03
	smpsVcUnusedBits    $00
	smpsVcDetune        $02, $05, $03, $06
	smpsVcCoarseFreq    $02, $03, $01, $06
	smpsVcRateScale     $00, $00, $02, $00
	smpsVcAttackRate    $1F, $1F, $18, $1C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0F, $0F, $0F, $12
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0B, $0A, $0D, $0C

