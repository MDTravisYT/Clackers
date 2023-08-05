#include <stdio.h>

main ( )

{
	FILE *a0, *a1, *a2;
	int d0, d1, d2, d3, d4, d5, d6, d7;
	int t0, t1, t2, t3, t4, t5, t6, t7;


	int PrivSet, FinishFlag, C0, C1, C2, C3;
	FinishFlag = 0x00;
	PrivSet = 0x00;
	printf ("Privilege 00 = ");
	goto CompressCrackers;

EndComp:
	if (FinishFlag == 0x01)
	{
		printf ("Complete\n\n");
		goto Finish;
	}
	fseek (a2, 0x00, SEEK_END);
	d0 = ftell (a2);
	printf ("%X\n", d0);
	if (PrivSet == 0x00)
	{
		C0 = d0;
		PrivSet = PrivSet + 0x01;
		printf ("Privilege 01 = ");
		fclose (a0);
		fclose (a2);
		goto CompressCrackers;
	}
	if (PrivSet == 0x01)
	{
		C1 = d0;
		PrivSet = PrivSet + 0x01;
		printf ("Privilege 10 = ");
		fclose (a0);
		fclose (a2);
		goto CompressCrackers;
	}
	if (PrivSet == 0x02)
	{
		C2 = d0;
		PrivSet = PrivSet + 0x01;
		printf ("Privilege 11 = ");
		fclose (a0);
		fclose (a2);
		goto CompressCrackers;
	}
	fclose (a0);
	fclose (a2);
	FinishFlag = 0x01;
	C3 = d0;
	if (C0 <= C1)
	{
		if (C0 <= C2)
		{
			if (C0 <= C3)
			{
				printf ("\nCompressing in privilege 00...  ");
				PrivSet = 0x00;
				goto CompressCrackers;
			}
			printf ("\nCompressing in privilege 11...  ");
			PrivSet = 0x03;
			goto CompressCrackers;
		}
		if (C2 <= C3)
		{
			printf ("\nCompressing in privilege 10...  ");
			PrivSet = 0x02;
			goto CompressCrackers;
		}
		printf ("\nCompressing in privilege 11...  ");
		PrivSet = 0x03;
		goto CompressCrackers;
	}
	if (C1 <= C2)
	{
		if (C1 <= C3)
		{
			printf ("\nCompressing in privilege 01...  ");
			PrivSet = 0x01;
			goto CompressCrackers;
		}
		printf ("\nCompressing in privilege 11...  ");
		PrivSet = 0x03;
		goto CompressCrackers;
	}
	if (C2 <= C3)
	{
		printf ("\nCompressing in privilege 10...  ");
		PrivSet = 0x02;
		goto CompressCrackers;
	}
	printf ("\nCompressing in privilege 11...  ");
	PrivSet = 0x03;
	goto CompressCrackers;




// =============================================================================
CompressCrackers:
	int PrivCopy, PrivRetr, dZ;
	PrivCopy = 0x0F;
	PrivRetr = 0x0F;
	PrivCopy = PrivCopy >> PrivSet;
	PrivRetr = PrivRetr << PrivSet;
	dZ = PrivSet;
	if (dZ == 0x03)
	{
		dZ = 0x07;
	}
	if (dZ == 0x02)
	{
		dZ = 0x03;
	}
	PrivRetr = PrivRetr + dZ;
	PrivRetr = PrivRetr + 0x01;
	PrivCopy = PrivCopy + 0x01;


	if ((a0 = fopen ("Uncomp.bin", "rb")) == NULL)
	{
		printf ("Could not open 'Uncomp.bin'\n");
		goto Error;
	}
	a1 = fopen ("Uncomp.bin", "rb");
	a2 = fopen ("Comp.bin", "wb");
	int PhaseSwitch, PhaseCounter, SectionCounter;
// =============================================================================
// -----------------------------------------------------------------------------
// d0 = current byte
// d1 = previous byte
// d2 = current location
// d3 = previous location
// d4 = curren copy counter
// d5 = best copy counter
// d6 = current retrace location
// d7 = best retrace location
// -----------------------------------------------------------------------------
	fseek (a2, 0x03, SEEK_CUR);
	SectionCounter = 0x00;
	fseek (a0, 0x00, SEEK_END);
	t7 = ftell (a0);
	fseek (a0, 0x00, SEEK_SET);

Comp_NextPhase:
	PhaseSwitch = 0x00;
	PhaseCounter = 0x08;
	SectionCounter = SectionCounter + 0x01;

Comp_CheckFile:
	if (PhaseCounter == 0x00)
	{
		fseek (a2, -0x09, SEEK_CUR);
		fputc (PhaseSwitch, a2);
		fseek (a2, 0x09, SEEK_CUR);
		goto Comp_NextPhase;
	}
	PhaseCounter = PhaseCounter - 0x01;
// -----------------------------------------------------------------------------
Comp_Phase02:
	PhaseSwitch = PhaseSwitch << 0x01;
	PhaseSwitch = PhaseSwitch + 0x01;
	t2 = 0x00;
	t3 = 0x00;
	d5 = 0x00;
	d7 = 0x00;
	d2 = ftell (a0);
// ---------------------
	if (SectionCounter >= 0x4000)
	{
		goto Comp_MaxSections;
	}
	if (d2 >= t7)
	{

Comp_MaxSections:
		PhaseSwitch = PhaseSwitch - 0x01;
		t7 = PhaseCounter;
		if (t7 == 0x07)
		{
			SectionCounter = SectionCounter - 0x01;
			goto Comp_SkipFinalSection;
		}

Comp_FinalSection:
		fputc (0x00, a2);
		if (PhaseCounter == 0x00)
		{
			fseek (a2, -0x09, SEEK_CUR);
			fputc (PhaseSwitch, a2);

Comp_SkipFinalSection:
			fseek (a2, 0x00, SEEK_SET);
			SectionCounter = SectionCounter - 0x01;
			dZ = PrivSet;
			dZ = dZ << 0x0E;
			SectionCounter = SectionCounter + dZ;
			d0 = SectionCounter;
			SectionCounter = SectionCounter >> 0x08;
			fputc (SectionCounter, a2);
			fputc (d0, a2);
			goto EndComp;
		}
		PhaseCounter = PhaseCounter - 0x01;
		PhaseSwitch = PhaseSwitch << 0x01;
		goto Comp_FinalSection;
	}
// ---------------------
	if (d2 <= PrivRetr-0x01)
	{
		fseek (a1, 0x00, SEEK_SET);
		goto CP02_Check;
	}
//	PrivRetr;
	fseek (a1, d2-PrivRetr, SEEK_SET);

CP02_Check:
	d3 = ftell (a1);
	if (d2 == d3)
	{
		goto Phase_01;
	}
	d0 = fgetc (a0);
	fseek (a0, -0x01, SEEK_CUR);
	d6 = ftell (a1);
	d1 = fgetc (a1);
	if (d0 != d1)
	{
		goto CP02_Check;
	}
// ++++++
CP02_RecheckDistance:
	d4 = 0x00;
	fseek (a0, 0x01, SEEK_CUR);

CP02_CheckDistance:
	d0 = fgetc (a0);
	fseek (a0, -0x01, SEEK_CUR);
	d1 = fgetc (a1);
	if (d0 == d1)
	{
		d4 = d4 + 0x01;
// --------------------
		if (d4 >= PrivCopy)
// --------------------
		{
			d5 = d4;
			d7 = d6;
			fseek (a0, 0x01, SEEK_CUR);
			t2 = ftell (a0);
			t3 = ftell (a1);
			goto CP02_SaveLZDirect;
		}
		fseek (a0, 0x01, SEEK_CUR);
		goto CP02_CheckDistance;
	}
// ++++++
	t5 = d5;
	t5 = t5 + 0x01;
	if (d4 >= t5)
	{
		d5 = d4;
		d7 = d6;
		t2 = ftell (a0);
		t3 = ftell (a1);
	}
	fseek (a0, d2, SEEK_SET);
	fseek (a1, d6+0x01, SEEK_SET);

CP02_CheckNext:
	d3 = ftell (a1);
	if (d3 >= d2)
	{
		goto CP02_SaveLZ;
	}
	d0 = fgetc (a0);
	fseek (a0, -0x01, SEEK_CUR);
	d6 = ftell (a1);
	d1 = fgetc (a1);
	if (d0 != d1)
	{
		goto CP02_CheckNext;
	}
	goto CP02_RecheckDistance;
// ++++++
CP02_SaveLZ:
	if (d5 == 0x00)
	{
		goto Phase_01;
	}

CP02_SaveLZDirect:
	d5 = d5 - 0x01;
	d7 = d2 - d7;
	d7 = d7 - 0x01;

// --------------------
	// d5 = copy
	// d7 = retrace

	dZ = 0x04;
	dZ = dZ - PrivSet;
	d7 = d7 << dZ;

	dZ = 0x0F;
	dZ = dZ >> PrivSet;
	d5 = d5 & dZ;

//	d7 = d7 << 0x04;
//	d5 = d5 & 0x0F;

	d7 = d7 + d5;
	fputc (d7, a2);
// --------------------

	if (t2 >= t3)
	{
		fseek (a0, t2, SEEK_SET);
		goto Comp_CheckFile;
	}
	fseek (a0, 0x01, SEEK_CUR);
	goto Comp_CheckFile;
// =============================================================================
// -----------------------------------------------------------------------------
Phase_01:
	PhaseSwitch = PhaseSwitch - 0x01;
	d0 = fgetc (a0);
	fputc (d0, a2);
	goto Comp_CheckFile;
// =============================================================================












Finish:
	fclose (a0);
	fclose (a2);

Error:
	printf ("Press enter key to exit...\n");
	int EX;
	EX = getc (stdin);
}
