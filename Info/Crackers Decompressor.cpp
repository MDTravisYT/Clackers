#include <stdio.h>

main ()

{
	FILE *a0, *a1;
	if ((a0 = fopen ("Comp.bin", "rb")) == NULL)
	{
		printf ("Could not open 'Comp.bin'\n");
		goto Error;
	}
	a1 = fopen ("Uncomp.bin", "w+b");
	int d0, d1, d2, d3, d4, d5, d6, d7;
	d0 = 0x00;
	d1 = 0x00;
	d2 = 0x00;
	d3 = 0x00;
	d4 = 0x00;
	d5 = 0x00;
	d6 = 0x00;
	d7 = 0x00;
	unsigned int t0, t1, t2;
	t0 = 0x00;
	t1 = 0x00;
	t2 = 0x00;

	t0 = fgetc (a0);
	t0 = t0 << 0x08;
	d7 = fgetc (a0);
	d7 = d7 + t0;
	d2 = d7;
	d7 = d7 & 0x3FFF;
	d2 = d2 & 0xC000;
	d2 = d2 >> 0x0E;
	d1 = 0x00000004;
	d1 = d1 - d2;
	d2 = 0x00000001;
	d2 = d2 << d1;
	d2 = d2 - 0x01;

RoutineLoop:
	d5 = fgetc (a0);
	d6 = 0x07;

RoutLoop2:
	d5 = d5 & 0xFF;
	t0 = d5;
	d5 = d5 + d5;
	if (t0 <= 0x7F)
	{
		// Phase 1
		t0 = fgetc (a0);
		fputc (t0, a1);
		if (d6 != 0x00)
		{
			d6 = d6 - 0x01;
			goto RoutLoop2;
		}
		if (d7 != 0x00)
		{
			d7 = d7 - 0x01;
			goto RoutineLoop;
		}
		goto Finish;
	}
	// Phase 2
	d3 = fgetc (a0);
	d4 = d3;
	d3 = d3 >> d1;
	d4 = d4 & d2;
	t1 = ftell (a1);
	d3 = d3 + 0x01;
	fseek (a1, -d3, SEEK_CUR);
	d4 = d4 + 0x01;

Phase2_CopyByte:
	t0 = fgetc (a1);
	t2 = ftell (a1);
	fseek (a1, t1, SEEK_SET);
	fputc (t0, a1);
	t1 = ftell (a1);
	fseek (a1, t2, SEEK_SET);
	if (d4 != 0x00)
	{
		d4 = d4 - 0x01;
		goto Phase2_CopyByte;
	}
	fseek (a1, t1, SEEK_SET);
	if (d6 != 0x00)
	{
		d6 = d6 - 0x01;
		goto RoutLoop2;
	}
	if (d7 != 0x00)
	{
		d7 = d7 - 0x01;
		goto RoutineLoop;
	}
	goto Finish;









Finish:
	fclose (a0);
	fclose (a1);

Error:
	printf ("Press enter key to exit...\n");
	int EX;
	EX = getc (stdin);
}
