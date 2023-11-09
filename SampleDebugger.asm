SampleDebugger:
	Console.WriteLine ""
	Console.WriteLine ""
	Console.BreakLine
	
	Console.WriteLine ""
	Console.Write ""       ; format slots table nicely ...

	lea 	v_objspace, a0
	move.w 	#$2000/$40-1, d0
	
	.DisplayObjSlot:
	    Console.Write ""
	    lea       $40(a0), a0
	    dbf       d0, .DisplayObjSlot

	rts