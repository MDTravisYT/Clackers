TestSong_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     TestSong_Voices
	smpsHeaderChan      $03, $02
	smpsHeaderTempo     $02, $33

	smpsHeaderDAC       TestSong_DAC
	smpsHeaderFM        TestSong_FM1,	$00, $0B
	smpsHeaderFM        TestSong_FM2,	$00, $17
	smpsHeaderPSG       TestSong_PSG1,	$0C, $00, $00, sTone_05
	smpsHeaderPSG       TestSong_PSG2,	$0C, $00, $00, $00

; FM1 Data
TestSong_FM1:
	smpsPan             panCenter, $00
	smpsSetvoice        $03
	smpsAlterVol        $05
	dc.b	nG5, $09, nFs5, $14, nRst, $07, nF5, $09, nE5, $16, nRst, $05
	dc.b	nEb5, $09, nD5, $0A, nRst, $02
	smpsAlterVol        $FD
	dc.b	nG5, $06, nRst, $7F, $29
	smpsAlterVol        $FC
	dc.b	nG5, $03, nF5, $03, nD5, $03, nC5, $03, nBb4, $03, nG4, $03
	smpsAlterVol        $01
	dc.b	nF4, $09, nG4, $03, nRst, $09, nB4, $0C, nG4, $03, nRst, $0C
	dc.b	nF4, $09, nE4, $03, nRst, $03, nF4, $03, nA4, $03, nRst, $03
	dc.b	nG4, $0F, nRst, $03, nF4, $03, nG4, $03, nB4, $09, nG4, $03
	dc.b	nRst, $42, nG5, $03, nF5, $03, nD5, $03, nC5, $03, nBb4, $03
	dc.b	nG4, $03, nF4, $09, nG4, $03, nRst, $09, nB4, $0C, nC5, $03
	dc.b	nRst, $0C, nD5, $09, nG4, $03, nRst, $03, nG4, $03, nF4, $03
	dc.b	nRst, $03, nG4, $12, nA4, $03, nBb4, $03, nB4, $1B, nRst, $36
	dc.b	nG4, $03, nRst, $03, nF4, $06, nG4, $06, nC5, $09, nA4, $08
	dc.b	nRst, $01, nC5, $06, nC5, $01
	smpsAlterNote       $0F
	dc.b	smpsNoAttack, nCs5, $01
	smpsAlterNote       $00
	dc.b	smpsNoAttack, nD5, $07, nG4, $05, nRst, $04, nD5, $03, nE5, $03, nF5
	dc.b	$09, nD5, $09, nF5, $05, nRst, $01, nG5, $01
	smpsAlterNote       $17
	dc.b	smpsNoAttack, $01
	smpsAlterNote       $00
	dc.b	smpsNoAttack, nA5, $07, nG5, $09, nC5, $09, nRst, $03, nG4, $03, nRst
	dc.b	$03, nA4, $03, nC5, $03, nRst, $03, nC5, $01
	smpsAlterNote       $0F
	dc.b	smpsNoAttack, $01
	smpsAlterNote       $00
	dc.b	smpsNoAttack, nD5, $0F, nRst, $04, nC5, $03, nD5, $03, nF5, $08, nRst
	dc.b	$01, nD5, $08, nRst, $01, nF5, $06, nA5, $06, nRst, $06, nBb5
	dc.b	$01
	smpsAlterNote       $1C
	dc.b	smpsNoAttack, $01
	smpsAlterNote       $00
	dc.b	smpsNoAttack, nC6, $04, nG4, $06, nC5, $09, nA4, $08, nRst, $01, nC5
	dc.b	$06, nC5, $01
	smpsAlterNote       $0F
	dc.b	smpsNoAttack, nCs5, $01
	smpsAlterNote       $00
	dc.b	smpsNoAttack, nD5, $07, nG4, $05, nRst, $04, nD5, $03, nE5, $03, nF5
	dc.b	$09, nD5, $09, nF5, $05, nRst, $01, nA5, $09, nG5, $09, nC5
	dc.b	$14, nRst, $01, nB4, $03, nC5, $03, nD5, $11, nRst, $01, nC5
	dc.b	$03, nD5, $03, nG5, $01
	smpsAlterNote       $17
	dc.b	smpsNoAttack, nAb5, $01
	smpsAlterNote       $00
	dc.b	smpsNoAttack, nA5, $04, nG5, $1F, nRst, $05, nC5, $03, nD5, $03, nG5
	dc.b	$03, nRst, $03, nF5, $03, nRst, $06, nE5, $03, nRst, $06, nD5
	dc.b	$0E, nRst, $01, nG5, $09, nBb4, $02, smpsNoAttack, nB4, $01, smpsNoAttack, nC5
	dc.b	$17, nRst, $04, nG4, $03, nRst, $03, nA4, $03, nRst, $03, nC5
	dc.b	$03, nA5, $03, nG5, $03, nRst, $03, nF5, $03, nRst, $06, nE5
	dc.b	$03, nRst, $06, nD5, $0E, nRst, $01, nG5, $09, nG5, $01
	smpsAlterNote       $17
	dc.b	smpsNoAttack, $01
	smpsAlterNote       $00
	dc.b	smpsNoAttack, nA5, $0F, nRst, $01, nD5, $03, nA5, $03, nG5, $0D, nRst
	dc.b	$05, nC5, $03, nD5, $03, nG5, $03, nRst, $03, nF5, $03, nRst
	dc.b	$06, nE5, $03, nRst, $06, nD5, $0E, nRst, $01, nG5, $09, nC5
	dc.b	$06, nG4, $03, nA4, $03, nC5, $03, nG4, $02, nAb4, $02, nA4
	dc.b	$02, nC5, $03, nD5, $06, nBb4, $03, nC5, $03, nD5, $03, nE5
	dc.b	$03, nC5, $03, nD5, $03, nE5, $03, nRst, $03, nF5, $03, nRst
	dc.b	$06, nE5, $03, nRst, $06, nD5, $03, nRst, $06, nC5, $03, nRst
	dc.b	$06, nA5, $04, nRst, $02, nF5, $02, smpsNoAttack, nFs5, $01, smpsNoAttack, nG5
	dc.b	$0B, nRst, $01, nA5, $0B, nRst, $01, nBb5, $09, nC6, $03, nRst
	dc.b	$06, nG5, $0B, nRst, $01, nE5, $08, nD5, $02, nCs5, $02, nC5
	dc.b	$16
	smpsAlterVol        $FF
	dc.b	smpsNoAttack, $05, nG5, $03
	smpsPan             panCenter, $00
	smpsSetvoice        $03
	dc.b	nRst, $0E
	smpsPan             panCenter, $00
	smpsSetvoice        $03
	smpsStop

; FM2 Data
TestSong_FM2:
	smpsPan             panCenter, $00
	smpsSetvoice        $04
	dc.b	nRst, $60, nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02
	dc.b	nRst, $01, nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02
	dc.b	nRst, $01, nF3, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01
	smpsPan             panLeft, $00
	dc.b	nF3, $02, nRst, $01
	smpsAlterVol        $FC
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nD4, $02, nRst, $01
	smpsAlterVol        $04
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01
	smpsPan             panRight, $00
	dc.b	nD4, $02, nRst, $01
	smpsAlterVol        $FC
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nG3, $02, nRst, $01
	smpsAlterVol        $04
	dc.b	nD4, $02, nRst, $01, nF3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nD4, $02, nRst, $01, nF3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nB3, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nD4, $02, nRst, $01, nF3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nD4, $02, nRst, $01, nF3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nD4, $02, nRst, $01, nF3, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01
	smpsPan             panLeft, $00
	dc.b	nF3, $02, nRst, $01
	smpsAlterVol        $FC
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nD4, $02, nRst, $01
	smpsAlterVol        $04
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01
	smpsPan             panRight, $00
	dc.b	nD4, $02, nRst, $01
	smpsAlterVol        $FC
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nG3, $02, nRst, $01
	smpsAlterVol        $04
	dc.b	nD4, $02, nRst, $01, nF3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nD4, $02, nRst, $01, nF3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nB3, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nD4, $02, nRst, $01, nF3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nD4, $02, nRst, $01, nF3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nD4, $02, nRst, $01, nF3, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01
	smpsPan             panLeft, $00
	dc.b	nF3, $02, nRst, $01
	smpsAlterVol        $FC
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nD4, $02, nRst, $01
	smpsAlterVol        $04
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nD4, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01
	smpsPan             panRight, $00
	dc.b	nD4, $02, nRst, $01
	smpsAlterVol        $FC
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nG3, $02, nRst, $01
	smpsAlterVol        $04
	dc.b	nD4, $02, nRst, $01, nF3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nD4, $02, nRst, $01, nF3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nB3, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nD4, $02, nRst, $01, nC3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC4, $02, nRst, $01, nG3, $02, nRst, $01, nC3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC4, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC3, $02, nRst, $01, nG3, $02, nRst, $01, nC4, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC4, $02, nRst, $01, nG3, $02, nRst, $01, nC3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC4, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC3, $02, nRst, $01, nG3, $02, nRst, $01, nC4, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC4, $02, nRst, $01, nG3, $02, nRst, $01, nC3, $02, nRst, $01
	dc.b	nC4, $02, nRst, $01, nG3, $02, nRst, $01, nC3, $02, nRst, $01
	dc.b	nC3, $02, nRst, $01, nG3, $02, nRst, $01, nC4, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC4, $02, nRst, $01, nG3, $02, nRst, $01, nC3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC4, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC3, $02, nRst, $01, nG3, $02, nRst, $01, nC4, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC4, $02, nRst, $01, nG3, $02, nRst, $01, nC3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC4, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC3, $02, nRst, $01, nG3, $02, nRst, $01, nC4, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC3, $02, nRst, $01, nC4, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC3, $02, nRst, $01, nC3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC4, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC3, $02, nRst, $01, nG3, $02, nRst, $01, nC4, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC4, $02, nRst, $01, nG3, $02, nRst, $01, nC3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC4, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC3, $02, nRst, $01, nG3, $02, nRst, $01, nC4, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC4, $02, nRst, $01, nG3, $02, nRst, $01, nC3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC4, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC3, $02, nRst, $01, nC4, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC3, $02, nRst, $01, nC3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC4, $02, nRst, $01, nG3, $02, nRst, $01, nC3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC4, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC3, $02, nRst, $01, nG3, $02, nRst, $01, nC4, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC4, $02, nRst, $01, nG3, $02, nRst, $01, nC3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC4, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC3, $02, nRst, $01, nG3, $02, nRst, $01, nC4, $02, nRst, $01
	dc.b	nC3, $02, nRst, $46
	smpsPan             panCenter, $00
	dc.b	$03, nC3, $02, nRst, $01, nF3, $02, nRst, $01, nC4, $02, nRst
	dc.b	$01, nC3, $02, nRst, $01, nF3, $02, nRst, $01, nC4, $02, nRst
	dc.b	$01, nC3, $02, nRst, $01, nF3, $02, nRst, $01, nC4, $02, nRst
	dc.b	$01, nC3, $02, nRst, $01, nF3, $02, nRst, $01, nC4, $02, nRst
	dc.b	$01, nC3, $02, nRst, $01, nF3, $02, nRst, $01, nC4, $02, nRst
	dc.b	$01, nC3, $02, nRst, $2E
	smpsPan             panCenter, $00
	dc.b	$03, nC3, $02, nRst, $01, nF3, $02, nRst, $01, nC4, $02, nRst
	dc.b	$01, nC3, $02, nRst, $01, nF3, $02, nRst, $01, nC4, $02, nRst
	dc.b	$01, nC3, $02, nRst, $01, nF3, $02, nRst, $01, nC4, $02, nRst
	dc.b	$01, nC3, $02, nRst, $01, nF3, $02, nRst, $01, nC4, $02, nRst
	dc.b	$01, nC3, $02, nRst, $01, nF3, $02, nRst, $01, nC4, $02, nRst
	dc.b	$01, nC3, $02, nRst, $2E
	smpsPan             panCenter, $00
	dc.b	$03, nC3, $02, nRst, $01, nF3, $02, nRst, $01, nC4, $02, nRst
	dc.b	$01, nC3, $02, nRst, $01, nF3, $02, nRst, $01, nC4, $02, nRst
	dc.b	$01, nC3, $02, nRst, $01, nF3, $02, nRst, $01, nC4, $02, nRst
	dc.b	$01, nC3, $02, nRst, $01, nF3, $02, nRst, $01, nC4, $02, nRst
	dc.b	$01, nC3, $02, nRst, $01, nF3, $02, nRst, $01, nC4, $02, nRst
	dc.b	$01, nC3, $02, nRst, $2E
	smpsPan             panCenter, $00
	dc.b	$03, nF3, $02, nRst, $01, nG3, $02, nRst, $01, nBb3, $02, nRst
	dc.b	$01, nD4, $02, nRst, $01, nF3, $02, nRst, $01, nG3, $02, nRst
	dc.b	$01, nBb3, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst
	dc.b	$01, nG3, $02, nRst, $01, nBb3, $02, nRst, $01, nD4, $02, nRst
	dc.b	$01, nF3, $02, nRst, $01, nG3, $02, nRst, $01, nBb3, $02, nRst
	dc.b	$01
	smpsPan             panCenter, $00
	dc.b	nD4, $02, nRst, $01, nF3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nC4, $02, nRst, $01, nD4, $02, nRst, $01, nF3, $02, nRst, $01
	dc.b	nG3, $02, nRst, $01, nC4, $02, nRst, $01, nD4, $02, nRst, $01
	dc.b	nF3, $02, nRst, $01, nG3, $02, nRst, $01, nC4, $02, nRst, $01
	dc.b	nD4, $02, nRst, $01, nF3, $02, nRst, $01, nG3, $02, nRst, $01
	dc.b	nD4, $02, nRst, $01
	smpsPan             panCenter, $00
	dc.b	nG3, $02, nRst, $01
	smpsPan             panCenter, $00
	smpsSetvoice        $04
	dc.b	$0E
	smpsPan             panCenter, $00
	smpsSetvoice        $04
	smpsStop

; PSG1 Data
TestSong_PSG1:
	smpsPSGAlterVol     $01
	dc.b	nG2, $08, nRst, $01, nFs2, $18, nRst, $03, nF2, $08, nRst, $01
	dc.b	nE2, $17, nRst, $04, nEb2, $08, nRst, $01, nFs2, $0C, nRst, $7F
	dc.b	$7F, $49
	smpsPSGAlterVol     $02
	dc.b	nG2, $03, nF2, $03, nG2, $03, nB2, $09, nG2, $03, nRst, $7F
	dc.b	$23, nF2, $03, nRst, $06, nG2, $03, nA2, $03, nBb2, $03, nB2
	dc.b	$1B, nRst, $24, nC3, $06, nRst, $12, nC3, $06, nRst, $12, nC3
	dc.b	$06, nRst, $12, nC3, $06, nRst, $12, nC3, $06, nRst, $12, nC3
	dc.b	$06, nRst, $12, nC3, $06, nRst, $12, nC3, $06, nRst, $12, nC3
	dc.b	$06, nRst, $12, nC3, $06, nRst, $12, nC3, $06, nRst, $12, nC3
	dc.b	$06, nRst, $12, nC3, $06, nRst, $12, nC3, $06, nRst, $2D
	smpsPSGAlterVol     $FD
	dc.b	nC3, $03, nD3, $03, nG3, $03, nRst, $03, nF3, $03, nRst, $06
	dc.b	nE3, $04, nRst, $05, nD3, $0F, nG3, $09, nC3, $1B, nRst, $1B
	dc.b	nF3, $03, nRst, $06, nE3, $04, nRst, $05, nD3, $0F, nG3, $09
	dc.b	nA3, $1B, nRst, $0F, nC3, $03, nD3, $03, nG3, $03, nRst, $03
	dc.b	nF3, $03, nRst, $06, nE3, $04, nRst, $05, nD3, $0F, nG3, $09
	dc.b	nC3, $1B, nRst, $1B, nF3, $03, nRst, $06, nE3, $03, nRst, $06
	dc.b	nD3, $03, nRst, $06, nC3, $03, nRst, $06, nA3, $05, nRst, $01
	dc.b	nG3, $1B, nRst, $06, nC3, $03, nRst, $03, nD3, $03, nRst, $03
	dc.b	nG3, $03, nRst, $33
	smpsPSGvoice        sTone_05
	dc.b	$0E
	smpsPSGvoice        sTone_05
	smpsStop

; PSG2 Data
TestSong_PSG2:
	smpsPSGAlterVol     $03
	dc.b	nB1, $08, nRst, $01, nA1, $19, nRst, $02, nA1, $08, nRst, $01
	dc.b	nG1, $18, nRst, $03, nG1, $08, nRst, $01, nA1, $0C, nRst, $7F
	dc.b	$7F, $49
	smpsPSGAlterVol     $01
	dc.b	nG1, $03, nF1, $03, nG1, $03, nB1, $09, nG1, $03, nRst, $7F
	dc.b	$23, nF1, $03, nRst, $06, nG1, $03, nA1, $03, nBb1, $03, nB1
	dc.b	$1B, nRst, $1E, nC2, $03, nRst, $09, nC2, $03, nRst, $06, nC2
	dc.b	$02, nRst, $01, nC2, $02, nRst, $0A, nC2, $03, nRst, $09, nC2
	dc.b	$03, nRst, $09, nC2, $03, nRst, $06, nC2, $02, nRst, $01, nC2
	dc.b	$02, nRst, $0A, nC2, $03, nRst, $09, nC2, $03, nRst, $09, nC2
	dc.b	$03, nRst, $06, nC2, $02, nRst, $01, nC2, $02, nRst, $0A, nC2
	dc.b	$03, nRst, $09, nC2, $03, nRst, $09, nC2, $03, nRst, $06, nC2
	dc.b	$02, nRst, $01, nC2, $02, nRst, $0A, nC2, $03, nRst, $09, nC2
	dc.b	$03, nRst, $09, nC2, $03, nRst, $06, nC2, $02, nRst, $01, nC2
	dc.b	$02, nRst, $0A, nC2, $03, nRst, $09, nC2, $03, nRst, $09, nC2
	dc.b	$03, nRst, $06, nC2, $02, nRst, $01, nC2, $02, nRst, $0A, nC2
	dc.b	$03, nRst, $09, nC2, $03, nRst, $09, nC2, $03, nRst, $06, nC2
	dc.b	$02, nRst, $01, nC2, $02, nRst, $0A, nC2, $03, nRst, $2A
	smpsPSGAlterVol     $FE
	dc.b	nC2, $03, nD2, $03, nG2, $03, nRst, $03, nF2, $03, nRst, $06
	dc.b	nE2, $04, nRst, $05, nD2, $0F, nG2, $09, nC2, $1B, nRst, $1B
	dc.b	nF2, $03, nRst, $06, nE2, $04, nRst, $05, nD2, $0F, nG2, $09
	dc.b	nA2, $1B, nRst, $0F, nC2, $03, nD2, $03, nG2, $03, nRst, $03
	dc.b	nF2, $03, nRst, $06, nE2, $04, nRst, $05, nD2, $0F, nG2, $09
	dc.b	nC2, $1B, nRst, $1B, nF2, $03, nRst, $06, nE2, $03, nRst, $06
	dc.b	nD2, $03, nRst, $06, nC2, $03, nRst, $06, nA2, $05, nRst, $01
	dc.b	nG2, $1B, nRst, $06, nC2, $03, nRst, $03, nD2, $03, nRst, $03
	dc.b	nG2, $03, nRst, $33
	smpsPSGvoice        $00
	dc.b	$0E
	smpsPSGvoice        $00
	smpsStop

; DAC Data
TestSong_DAC:
	smpsStop

TestSong_Voices:
;	Voice $00
;	$3A
;	$71, $0C, $33, $01, 	$1C, $16, $1D, $1F, 	$04, $06, $04, $08
;	$00, $01, $03, $00, 	$16, $17, $16, $A6, 	$25, $2F, $25, $00
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $03, $00, $07
	smpsVcCoarseFreq    $01, $03, $0C, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1D, $16, $1C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $04, $06, $04
	smpsVcDecayRate2    $00, $03, $01, $00
	smpsVcDecayLevel    $0A, $01, $01, $01
	smpsVcReleaseRate   $06, $06, $07, $06
	smpsVcTotalLevel    $00, $25, $2F, $25

;	Voice $01
;	$3A
;	$71, $0C, $33, $01, 	$1C, $16, $1D, $1F, 	$04, $06, $04, $08
;	$00, $01, $03, $00, 	$16, $17, $16, $A6, 	$25, $2F, $25, $00
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $03, $00, $07
	smpsVcCoarseFreq    $01, $03, $0C, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1D, $16, $1C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $04, $06, $04
	smpsVcDecayRate2    $00, $03, $01, $00
	smpsVcDecayLevel    $0A, $01, $01, $01
	smpsVcReleaseRate   $06, $06, $07, $06
	smpsVcTotalLevel    $00, $25, $2F, $25

;	Voice $02
;	$04
;	$71, $41, $31, $31, 	$12, $12, $12, $12, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$23, $00, $23, $00
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $04, $07
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $12, $12, $12, $12
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $23, $00, $23

;	Voice $03
;	$04
;	$71, $41, $31, $31, 	$12, $12, $12, $12, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$23, $00, $23, $00
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $04, $07
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $12, $12, $12, $12
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $23, $00, $23

;	Voice $04
;	$3B
;	$3A, $31, $71, $74, 	$DF, $1F, $1F, $DF, 	$00, $0A, $0A, $05
;	$00, $05, $05, $03, 	$0F, $5F, $1F, $5F, 	$32, $1E, $0F, $00
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $03, $03
	smpsVcCoarseFreq    $04, $01, $01, $0A
	smpsVcRateScale     $03, $00, $00, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $0A, $0A, $00
	smpsVcDecayRate2    $03, $05, $05, $00
	smpsVcDecayLevel    $05, $01, $05, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $0F, $1E, $32

