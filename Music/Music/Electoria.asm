Electoria_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Electoria_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $19

	smpsHeaderDAC       Electoria_DAC
	smpsHeaderFM        Electoria_FM1,	$00, $0E
	smpsHeaderFM        Electoria_FM2,	$00, $18
	smpsHeaderFM        Electoria_FM3,	$00, $18
	smpsHeaderFM        Electoria_FM4,	$00, $18
	smpsHeaderFM        Electoria_FM5,	$00, $18
	smpsHeaderPSG       Electoria_PSG1,	$00, $04, $00, sTone_0C
	smpsHeaderPSG       Electoria_PSG2,	$F4, $04, $00, sTone_0C
	smpsHeaderPSG       Electoria_PSG3,	$23, $01, $00, sTone_02

; FM1 Data
Electoria_FM1:
	smpsSetvoice        $00
	dc.b	nD1, $06, nD2, nD2, nE1, nE2, nE2, nE1, nE2, nE2, nG1, nG2
	dc.b	nG2, nA1, nA2, nD1, $0C

Electoria_Loop16:
	smpsCall            Electoria_Call0B
	smpsLoop            $00, $08, Electoria_Loop16

Electoria_Loop17:
	smpsCall            Electoria_Call0B
	smpsLoop            $00, $08, Electoria_Loop17
	smpsAlterPitch      $FC

Electoria_Loop18:
	smpsCall            Electoria_Call0B
	smpsLoop            $00, $07, Electoria_Loop18
	smpsAlterPitch      $04
	dc.b	nEb1, $0C, nEb2, $06, nRst, nEb1, nRst, nEb2, nEb1, nRst, nRst, nEb2
	dc.b	nRst
	smpsModSet          $01, $08, $EC, $00
	dc.b	nEb1, $18
	smpsModSet          $00, $00, $00, $00

Electoria_Loop19:
	smpsCall            Electoria_Call0B
	smpsLoop            $00, $07, Electoria_Loop19
	dc.b	nD1, $0C, nD2, nE1, nE2, nF1, $06, nF2, nF1, nRst, nD1, nD2
	dc.b	nD1, nRst

Electoria_Loop1A:
	smpsCall            Electoria_Call0B
	smpsLoop            $00, $08, Electoria_Loop1A

Electoria_Loop1B:
	smpsCall            Electoria_Call0B
	smpsLoop            $00, $08, Electoria_Loop1B
	smpsJump            Electoria_Loop17

Electoria_Call0B:
	dc.b	nG1, $0C, nG2, $06, nRst, nG1, $0C, nRst, $06, nG1, nRst, nG1
	dc.b	nG1, $0C, nF1, nFs1
	smpsReturn

; FM2 Data
Electoria_FM2:
	smpsSetvoice        $03
	dc.b	nRst, $60

Electoria_Loop14:
	smpsCall            Electoria_Call04
	smpsAlterPitch      $01
	smpsCall            Electoria_Call04
	smpsAlterPitch      $FF
	smpsLoop            $00, $04, Electoria_Loop14
	smpsFMAlterVol      $FA

Electoria_Jump01:
	smpsSetvoice        $01
	smpsAlterPitch      $0C
	smpsFMAlterVol      $FB
	dc.b	nBb3, $12, nG3, $06, nRst, $3C, nF3, $06, nG3, nC4, nRst, nC4
	dc.b	nRst, nC4, $0C, nD4, $06, nG3, smpsNoAttack, $0C, nF3, nG3, $06, nRst
	dc.b	nG3, $0C, nRst, $60
	smpsPan             panLeft, $00
	smpsAlterPitch      $F4
	smpsSetvoice        $02
	smpsFMAlterVol      $0A
	smpsCall            Electoria_Call06
	smpsPan             panCenter, $00
	smpsSetvoice        $01
	smpsAlterPitch      $0C
	smpsFMAlterVol      $F6
	dc.b	nBb3, $0C, smpsNoAttack, $0C, nG3, $06, nRst, nRst, $3C, nF4, $0C, smpsNoAttack
	dc.b	$06, nRst, nE4, nRst, nD4, nE4, nRst, nD4, smpsNoAttack, nD4, nRst, nC4
	dc.b	nRst, nBb3, nC4, nRst, nB3, smpsNoAttack, $60
	smpsPan             panLeft, $00
	smpsAlterPitch      $F4
	smpsSetvoice        $02
	smpsFMAlterVol      $0A
	smpsCall            Electoria_Call07
	smpsPan             panCenter, $00
	smpsSetvoice        $01
	smpsFMAlterVol      $F6
	smpsCall            Electoria_Call08
	dc.b	nRst, $30
	smpsSetvoice        $02
	smpsFMAlterVol      $0B
	smpsCall            Electoria_Call09
	dc.b	nB3, $12, nD4, $4E, nRst, $60
	smpsCall            Electoria_Call0A
	dc.b	nD4, $12, nG4, $4E, nC5, $18, nB4, $06
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nB4
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nA4, $12
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nB4, $12
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nG4, $0C, smpsNoAttack, $60
	smpsSetvoice        $03
	dc.b	nG2, $60, $60, $30, nRst

Electoria_Loop15:
	dc.b	nG2, $60
	smpsLoop            $00, $04, Electoria_Loop15
	smpsSetvoice        $01
	smpsFMAlterVol      $FA
	smpsJump            Electoria_Jump01

Electoria_Call04:
	dc.b	nRst, $0C, nB3, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	$0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	$0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	$0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	$0C
	smpsReturn

Electoria_Call06:
	dc.b	nC5, $12
	smpsFMAlterVol      $0A
	dc.b	$06
	smpsFMAlterVol      $F6
	dc.b	nB4, $12, nC5, $06, nA4, nG4
	smpsFMAlterVol      $0A
	dc.b	nG4
	smpsFMAlterVol      $F6
	dc.b	nG4, $12
	smpsReturn

Electoria_Call07:
	dc.b	nD4, $0C
	smpsFMAlterVol      $0A
	dc.b	$06
	smpsFMAlterVol      $F6
	dc.b	nCs4, $0C
	smpsFMAlterVol      $0A
	dc.b	$06
	smpsFMAlterVol      $F6
	dc.b	nC4, $0C
	smpsFMAlterVol      $0A
	dc.b	$06
	smpsFMAlterVol      $F6
	dc.b	nB3, $0C
	smpsFMAlterVol      $0A
	dc.b	$06
	smpsFMAlterVol      $F6
	dc.b	nBb3
	smpsFMAlterVol      $0A
	dc.b	nBb3
	smpsFMAlterVol      $F6
	dc.b	nA3
	smpsFMAlterVol      $0A
	dc.b	nA3
	smpsFMAlterVol      $F6
	dc.b	nG3, $0C
	smpsReturn

Electoria_Call08:
	smpsAlterPitch      $0C
	dc.b	nBb3, $06, nRst, nBb3, nRst, nBb3, nRst, nBb3, $0C, nG3, $06, nBb3
	dc.b	nRst, nC4, nRst, nD4, smpsNoAttack, $0C, nC4, $06, nRst, nBb3, nRst, nC4
	dc.b	nRst, nD4, $0C, nRst, $06, nF4, $12, nD4, $06, nRst, nC4, $0C
	dc.b	nRst, $06, nD4, nRst, $48, nRst, $0C, nF3, $06, nRst, nG3, nRst
	dc.b	nBb3, nRst, nC4, nRst, nD4, nRst, nF4, $0C, nD4, $06, nRst, nRst
	dc.b	$0C, nD4, $06, nRst, nF4, nRst, nD4, nRst, nF4, $0C, nG4, $06
	dc.b	nBb3, nRst, nC4, nRst, nD4, smpsNoAttack, $0C, nC4, $06, nRst, nBb3, nRst
	dc.b	nC4, nRst, nD4, $0C, nRst, $06, nC4, $12, nF4, $06, nRst, nF3
	dc.b	$60, nRst, $0C, nBb3, $12, nC4, $0C, nF4, $06
	smpsAlterPitch      $F4
	smpsReturn

Electoria_Call09:
	smpsCall            Electoria_Call13
	dc.b	nD4, $0C, smpsNoAttack, $06
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nD4
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nD4, $18, nB3, $06
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nB3
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nD4, $12, nE4, $0C
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nF4, $0C, smpsNoAttack, $06
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nF4
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nE4
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nE4
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nF4, nE4
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nE4
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nD4, $0C
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nC4
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nC4
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nC4, $0C, nD4, $06
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nD4
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	smpsReturn

Electoria_Call0A:
	smpsCall            Electoria_Call13
	dc.b	nF4, $0C, smpsNoAttack, $06
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nF4
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nF4, $18, nD4, $06
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nD4
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nF4, $12, nG4, $0C
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nB4, $0C, smpsNoAttack, $06
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nB4
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nC5
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nC5
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nB4, nA4
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nA4
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nD5, $0C
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nF4
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nF4
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nF4, $0C, nG4, $06
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nG4
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	smpsReturn

Electoria_Call13:
	dc.b	nRst, $0C, nF4, nG4, $06, nRst, $06
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nG4, nRst
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nB4, $12, nG4, $06
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	$06, nRst
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nC5, $0C, smpsNoAttack, $0C, nB4, $06
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nB4
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nC5, nD5
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nD5
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nC5, $0C
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nB4, $0C
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nA4, $12
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	$0C
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nF4, nG4, $06, nRst, $06
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nG4, nRst
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nB4, $12, nG4, $06
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	$0C
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nF4, smpsNoAttack, $06
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nF4
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nG4
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nG4
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nF4, nE4
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nE4
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nD4, $1E
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	$0C
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	smpsReturn

; FM3 Data
Electoria_FM3:
	smpsSetvoice        $03
	dc.b	nRst, $60
	smpsAlterPitch      $FA

Electoria_Loop11:
	smpsCall            Electoria_Call04
	smpsLoop            $00, $08, Electoria_Loop11
	smpsAlterPitch      $06
	smpsFMAlterVol      $FC

Electoria_Jump00:
	smpsSetvoice        $01
	smpsPan             panLeft, $00
	smpsModSet          $01, $01, $02, $03
	smpsAlterPitch      $0C
	dc.b	nRst, $06, nBb3, $12, nG3, $06, nRst, $3C, nF3, $06, nG3, nC4
	dc.b	nRst, nC4, nRst, nC4, $0C, nD4, $06, nG3, smpsNoAttack, $0C, nF3, nG3
	dc.b	$06, nRst, nG3, $0C, nRst, $5A
	smpsSetvoice        $02
	smpsFMAlterVol      $03
	smpsModSet          $00, $00, $00, $00
	smpsPan             panRight, $00
	smpsAlterPitch      $E8
	smpsCall            Electoria_Call06
	smpsModSet          $01, $01, $01, $05
	smpsPan             panLeft, $00
	smpsAlterPitch      $18
	smpsSetvoice        $01
	smpsFMAlterVol      $FD
	dc.b	nRst, $06, nBb3, $0C, smpsNoAttack, $0C, nG3, $06, nRst, nRst, $3C, nF4
	dc.b	$0C, smpsNoAttack, $06, nRst, nE4, nRst, nD4, nE4, nRst, nD4, smpsNoAttack, nD4
	dc.b	nRst, nC4, nRst, nBb3, nC4, nRst, nB3, smpsNoAttack, $5A
	smpsModSet          $00, $00, $00, $00
	smpsPan             panRight, $00
	smpsAlterPitch      $E8
	smpsSetvoice        $02
	smpsFMAlterVol      $03
	smpsCall            Electoria_Call07
	smpsPan             panLeft, $00
	smpsSetvoice        $01
	smpsFMAlterVol      $FD
	smpsAlterPitch      $0C
	smpsModSet          $01, $01, $02, $03
	dc.b	nRst, $06
	smpsCall            Electoria_Call08
	dc.b	nRst, $2A
	smpsModSet          $00, $00, $00, $00
	smpsAlterPitch      $F4
	smpsSetvoice        $02
	smpsFMAlterVol      $04
	smpsPan             panCenter, $00
	smpsAlterPitch      $F4
	smpsCall            Electoria_Call09
	smpsAlterPitch      $0C
	dc.b	nB2, $12, nG3, $4E, nRst, $60
	smpsAlterPitch      $F4
	smpsCall            Electoria_Call0A
	smpsAlterPitch      $0C
	dc.b	nB3, $12, nD4, $4E, nC4, $18, nB3, $06
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	nB3
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nA3, $12
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nB3, $12
	smpsFMAlterVol      $0A
	smpsPan             panRight, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	nD4, $0C, smpsNoAttack, $60
	smpsSetvoice        $03
	smpsAlterPitch      $03

Electoria_Loop12:
	smpsCall            Electoria_Call04
	smpsLoop            $00, $02, Electoria_Loop12
	smpsAlterPitch      $FF
	smpsCall            Electoria_Call05
	smpsAlterPitch      $01

Electoria_Loop13:
	smpsCall            Electoria_Call04
	smpsLoop            $00, $04, Electoria_Loop13
	smpsAlterPitch      $09
	smpsFMAlterVol      $FF
	smpsJump            Electoria_Jump00

; FM4 Data
Electoria_FM4:
	smpsSetvoice        $03
	dc.b	nRst, $60
	smpsAlterPitch      $F7

Electoria_Loop0B:
	smpsCall            Electoria_Call04
	smpsLoop            $00, $08, Electoria_Loop0B
	smpsAlterPitch      $09

Electoria_Loop0C:
	smpsCall            Electoria_Call04
	smpsAlterPitch      $01
	smpsCall            Electoria_Call04
	smpsAlterPitch      $FF
	smpsLoop            $00, $04, Electoria_Loop0C

Electoria_Loop0D:
	smpsAlterPitch      $FF
	smpsCall            Electoria_Call04
	smpsAlterPitch      $02
	smpsCall            Electoria_Call04
	smpsAlterPitch      $FF
	smpsLoop            $00, $03, Electoria_Loop0D
	smpsAlterPitch      $FF
	smpsCall            Electoria_Call04
	smpsAlterPitch      $01
	smpsCall            Electoria_Call05

Electoria_Loop0E:
	smpsCall            Electoria_Call04
	smpsAlterPitch      $01
	smpsCall            Electoria_Call04
	smpsAlterPitch      $FF
	smpsLoop            $00, $03, Electoria_Loop0E
	smpsCall            Electoria_Call04
	dc.b	nRst, $60

Electoria_Loop0F:
	smpsCall            Electoria_Call04
	smpsAlterPitch      $01
	smpsCall            Electoria_Call04
	smpsAlterPitch      $FF
	smpsLoop            $00, $05, Electoria_Loop0F
	smpsCall            Electoria_Call04
	smpsCall            Electoria_Call05

Electoria_Loop10:
	smpsCall            Electoria_Call04
	smpsAlterPitch      $01
	smpsCall            Electoria_Call04
	smpsAlterPitch      $FF
	smpsLoop            $00, $02, Electoria_Loop10
	smpsJump            Electoria_Loop0C

Electoria_Call05:
	dc.b	nRst, $0C, nC4, $0C
	smpsFMAlterVol      $0A
	smpsPan             panLeft, $00
	dc.b	$06
	smpsFMAlterVol      $F6
	smpsPan             panCenter, $00
	dc.b	$0C, $06, nRst, $30
	smpsReturn

; FM5 Data
Electoria_FM5:
	smpsSetvoice        $03
	dc.b	nRst, $60

Electoria_Loop05:
	dc.b	nG2, $60
	smpsLoop            $00, $08, Electoria_Loop05
	smpsAlterPitch      $FA

Electoria_Loop06:
	smpsCall            Electoria_Call04
	smpsLoop            $00, $08, Electoria_Loop06
	smpsAlterPitch      $06

Electoria_Loop07:
	smpsAlterPitch      $FC
	smpsCall            Electoria_Call04
	smpsAlterPitch      $02
	smpsCall            Electoria_Call04
	smpsAlterPitch      $02
	smpsLoop            $00, $03, Electoria_Loop07
	smpsAlterPitch      $FC
	smpsCall            Electoria_Call04
	smpsAlterPitch      $01
	smpsCall            Electoria_Call05
	smpsAlterPitch      $03
	smpsAlterPitch      $FA

Electoria_Loop08:
	smpsCall            Electoria_Call04
	smpsLoop            $00, $07, Electoria_Loop08
	dc.b	nRst, $60

Electoria_Loop09:
	smpsCall            Electoria_Call04
	smpsLoop            $00, $0B, Electoria_Loop09
	smpsAlterPitch      $FF
	smpsCall            Electoria_Call05
	smpsAlterPitch      $01

Electoria_Loop0A:
	smpsCall            Electoria_Call04
	smpsLoop            $00, $04, Electoria_Loop0A
	smpsJump            Electoria_Loop06

; PSG1 Data
Electoria_PSG1:
	smpsPSGvoice        sTone_0C
	dc.b	nRst, $60

Electoria_Loop26:
	smpsCall            Electoria_Call12
	smpsLoop            $00, $08, Electoria_Loop26

Electoria_Loop27:
	smpsCall            Electoria_Call12
	smpsLoop            $00, $08, Electoria_Loop27

Electoria_Loop28:
	smpsAlterPitch      $FC
	smpsCall            Electoria_Call12
	smpsAlterPitch      $04
	dc.b	nEb2, $06, nEb2, nEb3, nA2, nEb2, nEb3, nA2, nEb2, nEb3, nA2, nEb2
	dc.b	nEb3, nA2, nEb2, nEb3, nA2
	smpsLoop            $00, $03, Electoria_Loop28
	smpsAlterPitch      $FC
	smpsCall            Electoria_Call12
	smpsAlterPitch      $04
	dc.b	nEb2, $06, nEb2, nEb3, nA2, nEb2, nEb3, nA2, nEb2, nRst, $30

Electoria_Loop29:
	smpsCall            Electoria_Call12
	smpsLoop            $00, $07, Electoria_Loop29
	dc.b	nRst, $60

Electoria_Loop2A:
	smpsCall            Electoria_Call12
	smpsLoop            $00, $08, Electoria_Loop2A

Electoria_Loop2B:
	smpsCall            Electoria_Call12
	smpsLoop            $00, $03, Electoria_Loop2B
	dc.b	nG2, $06, nG2, nG3, nD3, nG2, nG3, nD3, nG2, nRst, $30

Electoria_Loop2C:
	smpsCall            Electoria_Call12
	smpsLoop            $00, $04, Electoria_Loop2C
	smpsJump            Electoria_Loop27

Electoria_Call12:
	dc.b	nG2, $06, nG2, nG3, nD3, nG2, nG3, nD3, nG2, nG3, nD3, nG2
	dc.b	nG3, nD3, nG2, nG3, nD3
	smpsReturn

; PSG2 Data
Electoria_PSG2:
	smpsPSGvoice        sTone_0C
	dc.b	nRst, $60
	smpsAlterPitch      $0C

Electoria_Loop20:
	smpsCall            Electoria_Call0E
	smpsCall            Electoria_Call0F
	smpsLoop            $00, $04, Electoria_Loop20
	smpsAlterPitch      $F4
	smpsPSGAlterVol     $FF

Electoria_Loop21:
	smpsPSGvoice        sTone_03
	smpsCall            Electoria_Call10
	smpsLoop            $00, $08, Electoria_Loop21
	smpsAlterPitch      $03

Electoria_Loop22:
	smpsCall            Electoria_Call10
	smpsLoop            $00, $07, Electoria_Loop22
	smpsAlterPitch      $FD
	smpsCall            Electoria_Call11

Electoria_Loop23:
	smpsCall            Electoria_Call10
	smpsLoop            $00, $07, Electoria_Loop23
	dc.b	nRst, $60

Electoria_Loop24:
	smpsCall            Electoria_Call10
	smpsLoop            $00, $08, Electoria_Loop24
	smpsPSGvoice        sTone_0C
	smpsAlterPitch      $0C
	smpsPSGAlterVol     $01
	smpsCall            Electoria_Call0E
	smpsCall            Electoria_Call0F
	smpsCall            Electoria_Call0E
	dc.b	nF3, $06, nG3, nRst, nC4, nRst, nRst, nF3, nG3, nRst, $30

Electoria_Loop25:
	smpsCall            Electoria_Call0E
	smpsCall            Electoria_Call0F
	smpsLoop            $00, $02, Electoria_Loop25
	smpsAlterPitch      $F4
	smpsPSGAlterVol     $FF
	smpsJump            Electoria_Loop21

Electoria_Call0E:
	dc.b	nF3, $06, nG3, nRst, nB3, nRst, nRst, nF3, nG3, nRst, nB3, nRst
	dc.b	nF3, nG3, nRst, nB3, nRst
	smpsReturn

Electoria_Call0F:
	dc.b	nF3, $06, nG3, nRst, nC4, nRst, nRst, nF3, nG3, nRst, nC4, nRst
	dc.b	nF3, nG3, nRst, nC4, nRst
	smpsReturn

Electoria_Call10:
	dc.b	nRst, $0C, nD3, nRst, $06, nD3, $0C, nRst, $06, nD3, $0C, nRst
	dc.b	$06, nD3, $0C, nRst, $06, nD3, $0C
	smpsReturn

Electoria_Call11:
	dc.b	nRst, $0C, nF3, nRst, $06, nF3, $0C, $06, nRst, $30
	smpsReturn

; PSG3 Data
Electoria_PSG3:
	smpsPSGform         $E7

Electoria_Loop1C:
	smpsCall            Electoria_Call0C
	smpsLoop            $01, $09, Electoria_Loop1C

Electoria_Loop1D:
	smpsCall            Electoria_Call0C
	smpsLoop            $01, $0F, Electoria_Loop1D
	smpsCall            Electoria_Call0D

Electoria_Loop1E:
	smpsCall            Electoria_Call0C
	smpsLoop            $01, $13, Electoria_Loop1E
	smpsCall            Electoria_Call0D

Electoria_Loop1F:
	smpsCall            Electoria_Call0C
	smpsLoop            $01, $04, Electoria_Loop1F
	smpsJump            Electoria_Loop1D

Electoria_Call0C:
	smpsPSGvoice        sTone_02
	dc.b	(nMaxPSG2-$23)&$FF, $0C
	smpsPSGvoice        sTone_05
	dc.b	(nMaxPSG2-$23)&$FF
	smpsLoop            $00, $04, Electoria_Call0C
	smpsReturn

Electoria_Call0D:
	smpsPSGvoice        sTone_02
	dc.b	(nMaxPSG2-$23)&$FF, $0C
	smpsPSGvoice        sTone_05
	dc.b	$0C
	smpsPSGvoice        sTone_02
	dc.b	$0C
	smpsPSGvoice        sTone_05
	dc.b	$06
	smpsPSGvoice        sTone_02
	dc.b	$06, nRst, $30
	smpsReturn

; DAC Data
Electoria_DAC:
	dc.b	dCrackerSnare, $06, nRst, dCrackerSnare, dCrackerSnare, nRst, dCrackerSnare, dCrackerSnare, dCrackerKick, dCrackerSnare, dCrackerTimpaniHi, dCrackerTimpaniMid
	dc.b	dCrackerSnare, dCrackerSnare, dCrackerTimpaniMid, dCrackerTimpaniLow, dCrackerSnare

Electoria_Loop00:
	smpsCall            Electoria_Call00
	smpsCall            Electoria_Call01
	smpsLoop            $00, $03, Electoria_Loop00
	smpsCall            Electoria_Call00
	smpsCall            Electoria_Call02

Electoria_Loop01:
	smpsCall            Electoria_Call00
	smpsCall            Electoria_Call01
	smpsLoop            $00, $03, Electoria_Loop01
	smpsCall            Electoria_Call00
	smpsCall            Electoria_Call03

Electoria_Loop02:
	smpsCall            Electoria_Call00
	smpsCall            Electoria_Call01
	smpsLoop            $00, $03, Electoria_Loop02
	smpsCall            Electoria_Call00
	dc.b	dCrackerSnare, $04, dCrackerSnare, dCrackerSnare, dCrackerSnare, $06, dCrackerSnare, dCrackerSnare, dCrackerSnare, dCrackerSnare, dCrackerSnare, nRst
	dc.b	$30

Electoria_Loop03:
	smpsCall            Electoria_Call00
	smpsCall            Electoria_Call01
	smpsLoop            $00, $03, Electoria_Loop03
	smpsCall            Electoria_Call00
	smpsCall            Electoria_Call02

Electoria_Loop04:
	smpsCall            Electoria_Call00
	smpsCall            Electoria_Call01
	smpsLoop            $00, $03, Electoria_Loop04
	smpsCall            Electoria_Call00
	smpsCall            Electoria_Call03
	smpsCall            Electoria_Call00
	smpsCall            Electoria_Call01
	smpsCall            Electoria_Call00
	dc.b	dCrackerKick, $06, dCrackerSnare, $12, dCrackerSnare, dCrackerKick, $06, nRst, $30
	smpsCall            Electoria_Call00
	smpsCall            Electoria_Call01
	smpsCall            Electoria_Call00
	smpsCall            Electoria_Call02
	smpsJump            Electoria_Loop01

Electoria_Call00:
	dc.b	dCrackerKick, $0C, dCrackerKick, dCrackerSnare, nRst, $06, dCrackerSnare, nRst, dCrackerSnare, dCrackerKick, nRst, dCrackerSnare
	dc.b	$18
	smpsReturn

Electoria_Call01:
	dc.b	dCrackerKick, $06, dCrackerSnare, $12, dCrackerSnare, dCrackerKick, $06, nRst, dCrackerSnare, dCrackerKick, nRst, dCrackerSnare
	dc.b	$18
	smpsReturn

Electoria_Call02:
	dc.b	dCrackerTimpaniMid, $0C, $0C, $0C, $06, $06, nRst, dCrackerTimpaniMid, dCrackerTimpaniMid, $0C, dCrackerTimpaniMid, dCrackerTimpaniMid
	smpsReturn

Electoria_Call03:
	dc.b	nRst, $06, dCrackerSnare, $12, dCrackerSnare, $18, nRst, $06, dCrackerSnare, $12, dCrackerSnare, $18
	smpsReturn

Electoria_Voices:
;	Voice $00
;	$3B
;	$12, $11, $13, $01, 	$1F, $1F, $1F, $1E, 	$02, $0C, $13, $07
;	$12, $0A, $05, $07, 	$0F, $3F, $5F, $3F, 	$16, $10, $15, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $01, $01, $01
	smpsVcCoarseFreq    $01, $03, $01, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1E, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $07, $13, $0C, $02
	smpsVcDecayRate2    $07, $05, $0A, $12
	smpsVcDecayLevel    $03, $05, $03, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $15, $10, $16

;	Voice $01
;	$3C
;	$01, $02, $0F, $04, 	$8D, $52, $9F, $1F, 	$09, $00, $00, $0D
;	$00, $00, $00, $00, 	$2F, $0F, $0F, $FF, 	$17, $86, $1F, $86
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $04, $0F, $02, $01
	smpsVcRateScale     $00, $02, $01, $02
	smpsVcAttackRate    $1F, $1F, $12, $0D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $00, $00, $09
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $00, $00, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $06, $1F, $06, $17

;	Voice $02
;	$2C
;	$22, $04, $02, $14, 	$51, $52, $50, $52, 	$0D, $00, $06, $04
;	$03, $05, $02, $00, 	$16, $18, $26, $18, 	$0F, $80, $12, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $00, $00, $02
	smpsVcCoarseFreq    $04, $02, $04, $02
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $12, $10, $12, $11
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $04, $06, $00, $0D
	smpsVcDecayRate2    $00, $02, $05, $03
	smpsVcDecayLevel    $01, $02, $01, $01
	smpsVcReleaseRate   $08, $06, $08, $06
	smpsVcTotalLevel    $00, $12, $00, $0F

;	Voice $03
;	$41
;	$18, $12, $02, $12, 	$5F, $5F, $5F, $5F, 	$0C, $0B, $0B, $0B
;	$09, $08, $10, $0A, 	$AF, $FF, $FF, $FF, 	$1D, $23, $1B, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $00
	smpsVcUnusedBits    $01
	smpsVcDetune        $01, $00, $01, $01
	smpsVcCoarseFreq    $02, $02, $02, $08
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0B, $0B, $0B, $0C
	smpsVcDecayRate2    $0A, $10, $08, $09
	smpsVcDecayLevel    $0F, $0F, $0F, $0A
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1B, $23, $1D

