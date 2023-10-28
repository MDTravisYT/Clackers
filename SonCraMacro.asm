; ===========================================================================
; ---------------------------------------------------------------------------
; Macro Instructions
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; The PLC Macro - Ensures the art offset in the PLC entry is pointing to the correct art location
; ---------------------------------------------------------------------------

PLC		macro	Size,Location,VRam,EndFlag
		dc.w	((((Size)/$02)&$00FF)<<$08)+((((Size)/$02)&$FF00)>>$08)
		dc.l	(((Location)/$02)+$97000000)
		dc.w	VRam
		dc.w	EndFlag
		even
                endm

; ===========================================================================