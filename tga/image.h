#ifndef imageH
#define imageH

//---------------------------------------------------------------------------
typedef struct _Image
{
  void*       image;        // изображение
  unsigned*   palette;      // палитра
  int         colorsCount;  // число цветов палитры
  __int8      bpp;          // бит на пиксел изображения
  __int16     width;        // высота
  __int16     height;       // ширина
} Image;

//---------------------------------------------------------------------------
int bitPerPixel2Byte(int bpp);
unsigned unpackColor(int bpp, unsigned __int8* ptr);
void convertTo32Bit(Image* image);
Image* minimazeImage(Image* src, int w, int h, bool savePalette);
void createPalette(Image* image, int maxColors);

#endif

