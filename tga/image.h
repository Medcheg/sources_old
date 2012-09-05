#ifndef imageH
#define imageH

//---------------------------------------------------------------------------
typedef struct _Image
{
  void*       image;        // �����������
  unsigned*   palette;      // �������
  int         colorsCount;  // ����� ������ �������
  __int8      bpp;          // ��� �� ������ �����������
  __int16     width;        // ������
  __int16     height;       // ������
} Image;

//---------------------------------------------------------------------------
int bitPerPixel2Byte(int bpp);
unsigned unpackColor(int bpp, unsigned __int8* ptr);
void convertTo32Bit(Image* image);
Image* minimazeImage(Image* src, int w, int h, bool savePalette);
void createPalette(Image* image, int maxColors);

#endif

