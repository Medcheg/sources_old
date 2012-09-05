//---------------------------------------------------------------------------
#include "mpiLinkPoints.h"

//---------------------------------------------------------------------------
TLinkPoint::TLinkPoint(int ax, int ay, int aOffsetX, int aOffsetY)
{
    x       = ax;
    y       = ay;
    OffsetX = aOffsetX;
    OffsetY = aOffsetY;
}

//---------------------------------------------------------------------------
void __fastcall TLinkPoint::Set_X(int aX)
{
   fx = aX;
   fsx = fx - fOffsetX;
}

//---------------------------------------------------------------------------
void __fastcall TLinkPoint::Set_Y(int aY)
{
   fy = aY;
   fsy = fy - fOffsetY;
}

//---------------------------------------------------------------------------
void __fastcall TLinkPoint::Set_OffsetX(int aOffsetX)
{
   fOffsetX = aOffsetX;
   fsx = fx - aOffsetX;
}

//---------------------------------------------------------------------------
void __fastcall TLinkPoint::Set_OffsetY(int aOffsetY)
{
   fOffsetY = aOffsetY;
   fsy = fy - aOffsetY;
}

