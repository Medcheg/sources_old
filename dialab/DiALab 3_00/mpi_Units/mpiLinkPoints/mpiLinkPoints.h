//---------------------------------------------------------------------------
#ifndef mpiLinkPointsH
#define mpiLinkPointsH
//---------------------------------------------------------------------------
class TLinkPoint{
private:
    int       fOffsetX;
    int       fOffsetY;
    int       fx, fy, fsx, fsy;

    void __fastcall Set_X      (int aX      );
    void __fastcall Set_Y      (int aY      );
    void __fastcall Set_OffsetX(int aOffsetX);
    void __fastcall Set_OffsetY(int aOffsetY);
public:
      TLinkPoint(int ax, int ay, int aOffsetX, int aOffsetY);

    __property int  x     = { read  = fx,  write = Set_X};
    __property int  y     = { read  = fy,  write = Set_Y};
    __property int sx     = { read  = fsx};
    __property int sy     = { read  = fsy};

    __property int OffsetX = { write = Set_OffsetX};
    __property int OffsetY = { write = Set_OffsetY};
};
//---------------------------------------------------------------------------
#endif
