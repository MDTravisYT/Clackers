z80_ptr function x,(x)<<8&$FF00|(x)>>8&$7F|$80

zeroOffsetOptimization	= 0

	include "MacroSetup.asm"
	include "Macros.asm"

SonicDriverVer			= 3

use_s2_samples			= 1

use_s3d_samples			= 1

use_s3_samples			= 1

use_sk_samples			= 1
		include		"_smps2asm_inc.asm"

;		MUSIC STARTS HERE

	align	$8000

		include		"Music/Electoria.asm"
		include		"Music/Walkin.asm"
		include		"Music/HyperHyper.asm"
		include		"Music/EveningStar.asm"
		include		"Music/Moonrise.asm"
		include		"Music/GameOver.asm"
		include		"Music/SpeedOfSound.asm"
		include		"Music/DoorIntoSummer.asm"
		include		"Music/ThisHorizon.asm"