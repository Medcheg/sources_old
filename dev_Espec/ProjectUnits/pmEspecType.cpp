#include <vcl.h>
#pragma hdrstop

#include "pmEspecType.h"
#include "stdlib.h"
#include "stdio.h"

TEspec **EspecProfile[64];
int      EspecProfileCount = 18;

int    CountProfileStep = 0;
int    BeginRepeatPos = 0;
int    EndRepeatPos = 0;
int    ProfilRepeatCount = 0;

void CreateProfiles()
{
    for ( int k = 0; k < EspecProfileCount; k++)
    {
        EspecProfile[k] = (TEspec **) malloc(sizeof(TEspec*) * 9);
        for ( int i = 0; i < 9; i++)
        {
			EspecProfile[k][i]      = (TEspec *) malloc(sizeof(TEspec));
			EspecProfile[k][i]->Ramp   = false;
            EspecProfile[k][i]->hi     = 2;
            EspecProfile[k][i]->mi     = 0;
            EspecProfile[k][i]->temper = 25.0;

    		sprintf(EspecProfile[k][i]->Name, "hui");
        }
    }

    TEspec **ep;
    ep = EspecProfile[1];
    sprintf(ep[0]->Name, "Prof_0 (1gr/min  -40/+50)");
    ep[0]->Ramp = false;   ep[0]->hi = 3;    ep[0]->mi =  0;   ep[0]->temper = 25.0;
    ep[1]->Ramp = true;    ep[1]->hi = 1;    ep[1]->mi =  5;  ep[1]->temper = -40.0;
    ep[2]->Ramp = false;   ep[2]->hi = 3;    ep[2]->mi =  0;   ep[2]->temper = -40.0;
    ep[3]->Ramp = true;    ep[3]->hi = 1;    ep[3]->mi = 30;  ep[3]->temper = 50.0;
    ep[4]->Ramp = false;   ep[4]->hi = 3;    ep[4]->mi =  0;   ep[4]->temper = 50.0;
    ep[5]->Ramp = true;    ep[5]->hi = 0;    ep[5]->mi = 25;  ep[5]->temper = 25.0;
    ep[6]->Ramp = false;   ep[6]->hi = 3;    ep[6]->mi =  0;   ep[6]->temper = 25.0;
    ep[7]->Ramp = false;   ep[7]->hi = 0;    ep[7]->mi =  1;  ep[7]->temper = 25.0;
    ep[8]->Ramp = false;   ep[8]->hi = 0;    ep[8]->mi =  1;   ep[8]->temper = 25.0;

    ep = EspecProfile[2];
    sprintf(ep[0]->Name, "Prof_1 (1gr/min  -40/+75");
    ep[0]->Ramp = false;   ep[0]->hi = 2;    ep[0]->mi = 30;   ep[0]->temper = 25.0;
    ep[1]->Ramp = true;    ep[1]->hi = 1;    ep[1]->mi = 5;    ep[1]->temper = -40.0;
    ep[2]->Ramp = false;   ep[2]->hi = 2;    ep[2]->mi = 30;   ep[2]->temper = -40.0;
    ep[3]->Ramp = true;    ep[3]->hi = 1;    ep[3]->mi = 55;   ep[3]->temper = 75.0;
    ep[4]->Ramp = false;   ep[4]->hi = 2;    ep[4]->mi = 30;   ep[4]->temper = 75.0;
    ep[5]->Ramp = true;    ep[5]->hi = 0;    ep[5]->mi = 50;   ep[5]->temper = 25.0;
    ep[6]->Ramp = false;   ep[6]->hi = 2;    ep[6]->mi = 30;   ep[6]->temper = 25.0;
    ep[7]->Ramp = false;   ep[7]->hi =0;     ep[7]->mi = 1;    ep[7]->temper = 25.0;
    ep[8]->Ramp = false;   ep[8]->hi = 0;    ep[8]->mi = 1;    ep[8]->temper = 25.0;

    ep = EspecProfile[3];
    sprintf(ep[0]->Name, "Prof_1 (1gr/min  -40/+70");
    ep[0]->Ramp = false;   ep[0]->hi = 2;    ep[0]->mi = 40;   ep[0]->temper = 25.0;
    ep[1]->Ramp = true;    ep[1]->hi = 1;    ep[1]->mi = 5;    ep[1]->temper = -40.0;
    ep[2]->Ramp = false;   ep[2]->hi = 2;    ep[2]->mi = 40;   ep[2]->temper = -40.0;
    ep[3]->Ramp = true;    ep[3]->hi = 1;    ep[3]->mi = 50;   ep[3]->temper = 70.0;
    ep[4]->Ramp = false;   ep[4]->hi = 2;    ep[4]->mi = 40;   ep[4]->temper = 70.0;
    ep[5]->Ramp = true;    ep[5]->hi = 0;    ep[5]->mi = 45;   ep[5]->temper = 25.0;
    ep[6]->Ramp = false;   ep[6]->hi = 2;    ep[6]->mi = 40;   ep[6]->temper = 25.0;
    ep[7]->Ramp = false;   ep[7]->hi =0;     ep[7]->mi = 1;    ep[7]->temper = 25.0;
    ep[8]->Ramp = false;   ep[8]->hi = 0;    ep[8]->mi = 1;    ep[8]->temper = 25.0;

    ep = EspecProfile[4];
    sprintf(ep[0]->Name, "Prof_2 (1gr/min  -40/+85)");
    ep[0]->Ramp = false;   ep[0]->hi = 3;    ep[0]->mi = 0;   ep[0]->temper = 25.0;
    ep[1]->Ramp = true;    ep[1]->hi = 1;    ep[1]->mi = 5;   ep[1]->temper = -40.0;
    ep[2]->Ramp = false;   ep[2]->hi = 3;    ep[2]->mi = 0;   ep[2]->temper = -40.0;
    ep[3]->Ramp = true;    ep[3]->hi = 2;    ep[3]->mi = 5;   ep[3]->temper = 85.0;
    ep[4]->Ramp = false;   ep[4]->hi = 3;    ep[4]->mi = 0;   ep[4]->temper = 85.0;
    ep[5]->Ramp = true;    ep[5]->hi = 1;    ep[5]->mi = 0;   ep[5]->temper = 25.0;
    ep[6]->Ramp = false;   ep[6]->hi = 3;    ep[6]->mi = 0;   ep[6]->temper = 25.0;
    ep[7]->Ramp = false;   ep[7]->hi =0;     ep[7]->mi = 1;   ep[7]->temper = 25.0;
    ep[8]->Ramp = false;   ep[8]->hi = 0;    ep[8]->mi = 1;   ep[8]->temper = 25.0;

    ep = EspecProfile[5];
    sprintf(ep[0]->Name, "Prof_3 (1gr/min)");
    ep[0]->Ramp = false;   ep[0]->hi = 2;    ep[0]->mi = 0;   ep[0]->temper = 25.0;
    ep[1]->Ramp = true;    ep[1]->hi = 0;    ep[1]->mi = 25;  ep[1]->temper = 50.0;
    ep[2]->Ramp = false;   ep[2]->hi = 2;    ep[2]->mi = 0;   ep[2]->temper = 50.0;
    ep[3]->Ramp = true;    ep[3]->hi = 1;    ep[3]->mi = 30;  ep[3]->temper =-40.0;
    ep[4]->Ramp = false;   ep[4]->hi = 2;    ep[4]->mi = 0;   ep[4]->temper =-40.0;
    ep[5]->Ramp = true;    ep[5]->hi = 1;    ep[5]->mi = 30;  ep[5]->temper = 50.0;
    ep[6]->Ramp = false;   ep[6]->hi = 2;    ep[6]->mi = 0;   ep[6]->temper = 50.0;
    ep[7]->Ramp = true;    ep[7]->hi = 0;    ep[7]->mi = 25;  ep[7]->temper = 25.0;
    ep[8]->Ramp = false;   ep[8]->hi = 2;    ep[8]->mi = 0;   ep[8]->temper = 25.0;

  // ------------------------
    ep = EspecProfile[6];
    sprintf(ep[0]->Name, "Prof_4 (0.5gr/min)");
    ep[0]->Ramp = false;   ep[0]->hi = 1;    ep[0]->mi =  0;   ep[0]->temper = 25.0;
    ep[1]->Ramp = true;    ep[1]->hi = 0;    ep[1]->mi = 50;   ep[1]->temper = 50.0;
    ep[2]->Ramp = false;   ep[2]->hi = 1;    ep[2]->mi =  0;   ep[2]->temper = 50.0;
    ep[3]->Ramp = true;    ep[3]->hi = 3;    ep[3]->mi =  0;   ep[3]->temper =-40.0;
    ep[4]->Ramp = false;   ep[4]->hi = 2;    ep[4]->mi =  0;   ep[4]->temper =-40.0;
    ep[5]->Ramp = true;    ep[5]->hi = 3;    ep[5]->mi =  0;   ep[5]->temper = 50.0;
    ep[6]->Ramp = false;   ep[6]->hi = 1;    ep[6]->mi =  0;   ep[6]->temper = 50.0;
    ep[7]->Ramp = true;    ep[7]->hi = 0;    ep[7]->mi = 50;   ep[7]->temper = 25.0;
    ep[8]->Ramp = false;   ep[8]->hi = 1;    ep[8]->mi =  0;   ep[8]->temper = 25.0;

  // ------------------------
    ep = EspecProfile[7];
    sprintf(ep[0]->Name, "Prof_5 (1gr/min '5 hour')");
    ep[0]->Ramp = false;   ep[0]->hi = 0;    ep[0]->mi = 35;   ep[0]->temper = 25.0;
    ep[1]->Ramp = true;    ep[1]->hi = 1;    ep[1]->mi =  5;   ep[1]->temper =-40.0;
    ep[2]->Ramp = false;   ep[2]->hi = 0;    ep[2]->mi = 30;   ep[2]->temper =-40.0;
    ep[3]->Ramp = true;    ep[3]->hi = 1;    ep[3]->mi = 30;   ep[3]->temper = 50.0;
    ep[4]->Ramp = false;   ep[4]->hi = 0;    ep[4]->mi = 35;   ep[4]->temper = 50.0;
    ep[5]->Ramp = true;    ep[5]->hi = 0;    ep[5]->mi = 25;   ep[5]->temper = 25.0;
    ep[6]->Ramp = false;   ep[6]->hi = 0;    ep[6]->mi = 25;   ep[6]->temper = 25.0;
    ep[7]->Ramp = false;   ep[7]->hi = 0;    ep[7]->mi =  5;   ep[7]->temper = 25.0;
    ep[8]->Ramp = false;   ep[8]->hi = 0;    ep[8]->mi =  5;   ep[8]->temper = 25.0;

  // ------------------------
    ep = EspecProfile[8];
    sprintf(ep[0]->Name, "Prof_6 (1gr/min '6 hour')");
    ep[0]->Ramp = false;   ep[0]->hi = 0;    ep[0]->mi = 20;   ep[0]->temper = 50.0;
    ep[1]->Ramp = true;    ep[1]->hi = 1;    ep[1]->mi = 30;   ep[1]->temper =-40.0;
    ep[2]->Ramp = false;   ep[2]->hi = 0;    ep[2]->mi = 30;   ep[2]->temper =-40.0;
    ep[3]->Ramp = true;    ep[3]->hi = 1;    ep[3]->mi = 30;   ep[3]->temper = 50.0;
    ep[4]->Ramp = false;   ep[4]->hi = 0;    ep[4]->mi = 45;   ep[4]->temper = 50.0;
    ep[5]->Ramp = true;    ep[5]->hi = 0;    ep[5]->mi = 25;   ep[5]->temper = 25.0;
    ep[6]->Ramp = false;   ep[6]->hi = 0;    ep[6]->mi = 25;   ep[6]->temper = 25.0;
    ep[7]->Ramp = false;   ep[7]->hi = 0;    ep[7]->mi = 5;    ep[7]->temper = 25.0;
    ep[8]->Ramp = false;   ep[8]->hi = 0;    ep[8]->mi = 5;    ep[8]->temper = 25.0;


  // ------------------------
    ep = EspecProfile[9];
    sprintf(ep[0]->Name, "Prof_7 (6gr/min '3 hour')");
    ep[0]->Ramp = false;   ep[0]->hi = 0;    ep[0]->mi = 45;   ep[0]->temper = 50.0;
    ep[1]->Ramp = true;    ep[1]->hi = 0;    ep[1]->mi = 15;   ep[1]->temper =-40.0;
    ep[2]->Ramp = false;   ep[2]->hi = 0;    ep[2]->mi = 45;   ep[2]->temper =-40.0;
    ep[3]->Ramp = true;    ep[3]->hi = 0;    ep[3]->mi = 15;   ep[3]->temper = 50.0;
    ep[4]->Ramp = false;   ep[4]->hi = 0;    ep[4]->mi = 45;   ep[4]->temper = 50.0;
    ep[5]->Ramp = false;   ep[5]->hi = 0;    ep[5]->mi = 5;    ep[5]->temper = 50.0;
    ep[6]->Ramp = false;   ep[6]->hi = 0;    ep[6]->mi = 5;    ep[6]->temper = 50.0;
    ep[7]->Ramp = false;   ep[7]->hi = 0;    ep[7]->mi = 5;    ep[7]->temper = 50.0;
    ep[8]->Ramp = false;   ep[8]->hi = 0;    ep[8]->mi = 5;    ep[8]->temper = 50.0;

  // ------------------------
    ep = EspecProfile[10];
    sprintf(ep[0]->Name, "Prof_8 (2gr/min)");
    ep[0]->Ramp = false;   ep[0]->hi = 0;    ep[0]->mi = 20;   ep[0]->temper = 25.0;
    ep[1]->Ramp = true;    ep[1]->hi = 0;    ep[1]->mi = 32;   ep[1]->temper =-40.0;
    ep[2]->Ramp = false;   ep[2]->hi = 0;    ep[2]->mi = 40;   ep[2]->temper =-40.0;
    ep[3]->Ramp = true;    ep[3]->hi = 0;    ep[3]->mi = 45;   ep[3]->temper = 50.0;
    ep[4]->Ramp = false;   ep[4]->hi = 0;    ep[4]->mi = 40;   ep[4]->temper = 50.0;
    ep[5]->Ramp = true;    ep[5]->hi = 0;    ep[5]->mi = 12;   ep[5]->temper = 25.0;
    ep[6]->Ramp = false;   ep[6]->hi = 0;    ep[6]->mi = 40;   ep[6]->temper = 25.0;
    ep[7]->Ramp = false;   ep[7]->hi = 0;    ep[7]->mi = 1;    ep[7]->temper = 25.0;
    ep[8]->Ramp = false;   ep[8]->hi = 0;    ep[8]->mi = 1;    ep[8]->temper = 25.0;

  // ------------------------
    ep = EspecProfile[11];
    sprintf(ep[0]->Name, "термоциклирование");
    ep[0]->Ramp = false;   ep[0]->hi = 0;    ep[0]->mi = 30;   ep[0]->temper = 27.0;
    ep[1]->Ramp = true;    ep[1]->hi = 0;    ep[1]->mi = 30;   ep[1]->temper =-30.0;
    ep[2]->Ramp = false;   ep[2]->hi = 2;    ep[2]->mi = 00;   ep[2]->temper =-30.0;
    ep[3]->Ramp = true;    ep[3]->hi = 0;    ep[3]->mi = 45;   ep[3]->temper = 50.0;
    ep[4]->Ramp = false;   ep[4]->hi = 2;    ep[4]->mi = 00;   ep[4]->temper = 50.0;
    ep[5]->Ramp = true;    ep[5]->hi = 0;    ep[5]->mi = 50;   ep[5]->temper =-30.0;
    ep[6]->Ramp = false;   ep[6]->hi = 2;    ep[6]->mi = 00;   ep[6]->temper =-30.0;
    ep[7]->Ramp = true;    ep[7]->hi = 0;    ep[7]->mi = 40;   ep[7]->temper = 50.0;
    ep[8]->Ramp = false;   ep[8]->hi = 2;    ep[8]->mi = 00;   ep[8]->temper = 50.0;

  // ------------------------
    ep = EspecProfile[12];
    sprintf(ep[0]->Name, "Термоциклирование -40/50");
    ep[0]->Ramp = false;   ep[0]->hi = 1;    ep[0]->mi = 30;   ep[0]->temper =  50.0;
    ep[1]->Ramp = true;    ep[1]->hi = 0;    ep[1]->mi = 30;   ep[1]->temper = -40.0;
    ep[2]->Ramp = false;   ep[2]->hi = 1;    ep[2]->mi = 30;   ep[2]->temper = -40.0;
    ep[3]->Ramp = true;    ep[3]->hi = 0;    ep[3]->mi = 20;   ep[3]->temper =  50.0;
    ep[4]->Ramp = false;   ep[4]->hi = 1;    ep[4]->mi = 30;   ep[4]->temper =  50.0;
    ep[5]->Ramp = true;    ep[5]->hi = 0;    ep[5]->mi = 30;   ep[5]->temper = -40.0;
    ep[6]->Ramp = false;   ep[6]->hi = 1;    ep[6]->mi = 30;   ep[6]->temper = -40.0;
    ep[7]->Ramp = true;    ep[7]->hi = 0;    ep[7]->mi = 20;   ep[7]->temper =  50.0;
    ep[8]->Ramp = false;   ep[8]->hi = 0;    ep[8]->mi = 01;   ep[8]->temper =  50.0;


  // ------------------------
    ep = EspecProfile[13];
    sprintf(ep[0]->Name, "Термоциклирование -45/85");
    ep[0]->Ramp = false;   ep[0]->hi = 2;    ep[0]->mi = 00;   ep[0]->temper =  85.0;
    ep[1]->Ramp = true;    ep[1]->hi = 0;    ep[1]->mi = 50;   ep[1]->temper = -45.0;
    ep[2]->Ramp = false;   ep[2]->hi = 2;    ep[2]->mi = 00;   ep[2]->temper = -45.0;
    ep[3]->Ramp = true;    ep[3]->hi = 0;    ep[3]->mi = 30;   ep[3]->temper =  85.0;
    ep[4]->Ramp = false;   ep[4]->hi = 2;    ep[4]->mi = 00;   ep[4]->temper =  85.0;
    ep[5]->Ramp = true;    ep[5]->hi = 0;    ep[5]->mi = 50;   ep[5]->temper = -45.0;
    ep[6]->Ramp = false;   ep[6]->hi = 2;    ep[6]->mi = 00;   ep[6]->temper = -45.0;
    ep[7]->Ramp = true;    ep[7]->hi = 0;    ep[7]->mi = 30;   ep[7]->temper =  85.0;
    ep[8]->Ramp = false;   ep[8]->hi = 0;    ep[8]->mi = 01;   ep[8]->temper =  85.0;

  // ------------------------
    ep = EspecProfile[14];
    sprintf(ep[0]->Name, "Термоциклирование -50/85");
    ep[0]->Ramp = false;   ep[0]->hi = 2;    ep[0]->mi = 00;   ep[0]->temper =  85.0;
    ep[1]->Ramp = true;    ep[1]->hi = 0;    ep[1]->mi = 50;   ep[1]->temper = -50.0;
    ep[2]->Ramp = false;   ep[2]->hi = 2;    ep[2]->mi = 00;   ep[2]->temper = -50.0;
    ep[3]->Ramp = true;    ep[3]->hi = 0;    ep[3]->mi = 30;   ep[3]->temper =  85.0;
    ep[4]->Ramp = false;   ep[4]->hi = 2;    ep[4]->mi = 00;   ep[4]->temper =  85.0;
    ep[5]->Ramp = true;    ep[5]->hi = 0;    ep[5]->mi = 50;   ep[5]->temper = -50.0;
    ep[6]->Ramp = false;   ep[6]->hi = 2;    ep[6]->mi = 00;   ep[6]->temper = -50.0;
    ep[7]->Ramp = true;    ep[7]->hi = 0;    ep[7]->mi = 30;   ep[7]->temper =  85.0;
    ep[8]->Ramp = false;   ep[8]->hi = 0;    ep[8]->mi = 01;   ep[8]->temper =  85.0;

  // ------------------------
    ep = EspecProfile[15];
    sprintf(ep[0]->Name, "Термоциклирование -50/100");
    ep[0]->Ramp = false;   ep[0]->hi = 2;    ep[0]->mi = 00;   ep[0]->temper = 100.0;
    ep[1]->Ramp = true;    ep[1]->hi = 0;    ep[1]->mi = 50;   ep[1]->temper = -50.0;
    ep[2]->Ramp = false;   ep[2]->hi = 2;    ep[2]->mi = 00;   ep[2]->temper = -50.0;
    ep[3]->Ramp = true;    ep[3]->hi = 0;    ep[3]->mi = 30;   ep[3]->temper = 100.0;
    ep[4]->Ramp = false;   ep[4]->hi = 2;    ep[4]->mi = 00;   ep[4]->temper = 100.0;
    ep[5]->Ramp = true;    ep[5]->hi = 0;    ep[5]->mi = 50;   ep[5]->temper = -50.0;
    ep[6]->Ramp = false;   ep[6]->hi = 2;    ep[6]->mi = 00;   ep[6]->temper = -50.0;
    ep[7]->Ramp = true;    ep[7]->hi = 0;    ep[7]->mi = 30;   ep[7]->temper = 100.0;
    ep[8]->Ramp = false;   ep[8]->hi = 0;    ep[8]->mi = 01;   ep[8]->temper = 100.0;

  // ------------------------
    ep = EspecProfile[16];
    sprintf(ep[0]->Name, "Резонансная фаза -40/85");
    ep[0]->Ramp = true;   ep[0]->hi = 0;    ep[0]->mi = 10;   ep[0]->temper = -15.0;
    ep[1]->Ramp = false;  ep[1]->hi = 2;    ep[1]->mi = 45;   ep[1]->temper = -15.0;
    ep[2]->Ramp = true;   ep[2]->hi = 0;    ep[2]->mi = 10;   ep[2]->temper =  10.0;
    ep[3]->Ramp = false;  ep[3]->hi = 2;    ep[3]->mi = 45;   ep[3]->temper =  10.0;
    ep[4]->Ramp = true;   ep[4]->hi = 0;    ep[4]->mi = 10;   ep[4]->temper =  35.0;
    ep[5]->Ramp = false;  ep[5]->hi = 2;    ep[5]->mi = 45;   ep[5]->temper =  35.0;
    ep[6]->Ramp = true;   ep[6]->hi = 0;    ep[6]->mi = 10;   ep[6]->temper =  60.0;
    ep[7]->Ramp = false;  ep[7]->hi = 2;    ep[7]->mi = 45;   ep[7]->temper =  60.0;
    ep[8]->Ramp = true;   ep[8]->hi = 0;    ep[8]->mi = 10;   ep[8]->temper =  85.0;

  // ------------------------
    ep = EspecProfile[17];
    sprintf(ep[0]->Name, "MakProfile -40/70");
    ep[0]->Ramp = false;  ep[0]->hi = 1;    ep[0]->mi =  0;   ep[0]->temper =  27.0;
    ep[1]->Ramp = true;   ep[1]->hi = 1;    ep[1]->mi = 30;   ep[1]->temper = -40.0;
    ep[2]->Ramp = false;  ep[2]->hi = 0;    ep[2]->mi = 30;   ep[2]->temper = -40.0;
    ep[3]->Ramp = true;   ep[3]->hi = 1;    ep[3]->mi = 30;   ep[3]->temper =  70.0;
    ep[4]->Ramp = false;  ep[4]->hi = 0;    ep[4]->mi = 30;   ep[4]->temper =  70.0;
    ep[5]->Ramp = true;   ep[5]->hi = 0;    ep[5]->mi = 30;   ep[5]->temper =  27.0;
    ep[6]->Ramp = false;  ep[6]->hi = 0;    ep[6]->mi = 30;   ep[6]->temper =  27.0;
    ep[7]->Ramp = false;  ep[7]->hi = 0;    ep[7]->mi =  1;   ep[7]->temper =  27.0;
    ep[8]->Ramp = false;  ep[8]->hi = 0;    ep[8]->mi =  1;   ep[8]->temper =  27.0;
}

void DeleteProfiles()
{
    for ( int k = 0; k < EspecProfileCount; k++)
    {
        for ( int i = 0; i < 9; i ++ )
            free (EspecProfile[k][i]);

        free( EspecProfile[k] );
    }

}


