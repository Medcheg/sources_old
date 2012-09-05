#pragma hdrstop

#include "image.h"
#include "palette.h"

#include <stdlib.h>
#include <memory.h>

//----------------------------------------------------------------------------
static unsigned getPixel(int x, int y, Image* image);
static unsigned evaluateColor(float x0, float y0, float x1, float y1, Image* image);

//----------------------------------------------------------------------------
static unsigned getPixel(int x, int y, Image* image)
{
  if(image == NULL) return 0;
  if((x < 0) || (x >= image->width)) return 0;
  if((y < 0) || (y >= image->height)) return 0;

  int entrySize = bitPerPixel2Byte(image->bpp);
  void* ptr = (void *)((unsigned)image->image + entrySize*(y*image->width + x));
  if(entrySize != 1) return unpackColor(entrySize, (unsigned __int8 *)ptr);

  if(image->palette == NULL) return 0;
  int index = ((unsigned __int8 *)ptr)[0];
  if(index > image->colorsCount) return 0;

  return image->palette[index];
}

//----------------------------------------------------------------------------
static unsigned evaluateColor(float x0, float y0, float x1, float y1, Image* image)
{
  if(image == NULL) return 0;
  if(x0 < 0.0f)          x0 = 0.0f;
  if(y0 < 0.0f)          y0 = 0.0f;
  if(x1 < 0.0f)          x1 = 0.0f;
  if(y1 < 0.0f)          y1 = 0.0f;
  if(x0 > image->width)  x0 = image->width;
  if(y0 > image->height) y0 = image->height;
  if(x1 > image->width)  x1 = image->width;
  if(y1 > image->height) y1 = image->height;

  unsigned alpha = 0, red = 0, green = 0, blue = 0;
  int count = 0;
  float dx, dy;

  dx = (x1 - x0) / ((int)(x1 - x0) + 1);
  dy = (y1 - y0) / ((int)(y1 - y0) + 1);

  for(float y = y0; y < y1; y += dy)
    for(float x = x0; x < x1; x += dx)
    {
      float u, v;
      int i, j;
      unsigned c[2][2];
      unsigned a[2][2], r[2][2], g[2][2], b[2][2];
      i = (int)x; u = x - i;
      j = (int)y; v = y - j;

      c[0][0] = getPixel(i,   j,   image);
      c[0][1] = getPixel(i+1, j,   image);
      c[1][0] = getPixel(i,   j+1, image);
      c[1][1] = getPixel(i+1, j+1, image);

      color2argb(a[0][0], r[0][0], g[0][0], b[0][0], c[0][0]);
      color2argb(a[0][1], r[0][1], g[0][1], b[0][1], c[0][1]);
      color2argb(a[1][0], r[1][0], g[1][0], b[1][0], c[1][0]);
      color2argb(a[1][1], r[1][1], g[1][1], b[1][1], c[1][1]);

      red   += r[0][0]*(1-u)*(1-v) + r[0][1]*u*(1-v) + r[1][0]*(1-u)*v + r[1][1]*u*v;
      green += g[0][0]*(1-u)*(1-v) + g[0][1]*u*(1-v) + g[1][0]*(1-u)*v + g[1][1]*u*v;
      blue  += b[0][0]*(1-u)*(1-v) + b[0][1]*u*(1-v) + b[1][0]*(1-u)*v + b[1][1]*u*v;
      alpha += a[0][0]*(1-u)*(1-v) + a[0][1]*u*(1-v) + a[1][0]*(1-u)*v + a[1][1]*u*v;
      count++;
    }

  if(count == 0) return 0;
  unsigned color;
  red   /= count;
  green /= count;
  blue  /= count;
  alpha /= count;

  argb2color(color, alpha, red, green, blue);
  return color;
}

//----------------------------------------------------------------------------
int bitPerPixel2Byte(int bpp)
{
  if(bpp <= 8) return 1;
  if(bpp <= 16) return 2;
  if(bpp <= 24) return 3;
  return 4;
}

//----------------------------------------------------------------------------
unsigned unpackColor(int bpp, unsigned __int8* ptr)
{
  unsigned r, g, b, a = 0xFF;
  switch(bpp)
  {
    case 1:       // grayscale packed or palette index
      return ptr[0];

    case 2:
      r = (ptr[1] & 0x7C) << 1;
      g = ((ptr[1] & 0x03) << 6) | ((ptr[0] & 0xE0) >> 2);
      b = (ptr[0] & 0x1F) << 3;
      a = (ptr[1] & 0x80) ? 0xFF : 0;
      r |= r >> 5;
      g |= g >> 5;
      b |= b >> 5;
      break;

    case 3:
      r = ptr[2];
      g = ptr[1];
      b = ptr[0];

      break;

    case 4:
      r = ptr[2];
      g = ptr[1];
      b = ptr[0];
      a = ptr[3];
      break;
  }

  return ((a << 24) | (b << 16) | (g << 8) | r);
}

//---------------------------------------------------------------------------
void convertTo32Bit(Image* image)
{
  if(image->bpp == 32) return;

  unsigned* picture = (unsigned *)malloc(sizeof(unsigned)*image->width*image->height);
  unsigned* ptr = picture;
  unsigned __int8* data = (unsigned __int8 *)image->image;
  int entrySize = bitPerPixel2Byte(image->bpp);

  if(image->palette == NULL)
  {
    for(int i = image->width*image->height; i > 0; i--, ptr++, data += entrySize) *ptr = unpackColor(entrySize, data);
    free(image->image);
    image->image = picture;
  }
  else
  {
    for(int i = image->width*image->height; i > 0; i--, ptr++, data += entrySize) *ptr = image->palette[*data];
    free(image->image);
    free(image->palette);
    image->image = picture;
    image->palette = NULL;
    image->colorsCount = 0;
  }

  image->bpp = 32;
}

//---------------------------------------------------------------------------
void createPalette(Image* image, int maxColors)
{
  if((image->colorsCount != 0) && (image->colorsCount <= maxColors)) return;

  convertTo32Bit(image);
  image->palette = createPalette((unsigned *)image->image, image->width*image->height, maxColors);
  image->colorsCount = maxColors;

  unsigned char* picture = (unsigned char *)malloc(image->width*image->height);
  
  unsigned* ptr = (unsigned *)image->image;
  unsigned char* index = picture;
  for(int i = image->width*image->height; i > 0; i--, ptr++, index++) *index = (unsigned char)*ptr;
  free(image->image);
  image->image = picture;
  image->bpp = 8;
}

//---------------------------------------------------------------------------
Image* minimazeImage(Image* src, int w, int h, bool savePalette)
{
  if(w > src->width) return NULL;
  if(h > src->height) return NULL;

  Image* dst = (Image *)malloc(sizeof(Image));
  memset(dst, 0, sizeof(Image));
  dst->bpp = 32;
  dst->image = malloc(sizeof(unsigned)*w*h);
  memset(dst->image, 0, sizeof(unsigned)*w*h);
  dst->width = w;
  dst->height = h;

  float startX, startY;
  float deltaX, deltaY;

  deltaX = (float)src->width/(float)w;
  deltaY = (float)src->height/(float)h;
  startX = deltaX * 0.5f;
  startY = deltaY * 0.5f;

  float x, y = startY;
  unsigned* ptr = (unsigned *)dst->image;
  for(int i = h; i > 0; i--, y+= deltaY)
  {
    x = startX;
    for(int j = w; j > 0; j--, x+= deltaX, ptr++) *ptr = evaluateColor(x-deltaX/2.0f, y-deltaY/2.0f, x+deltaX/2.0f, y+deltaY/2.0f, src);
  }

  if(!savePalette) return dst;
  if(src->palette == NULL) return dst;
  
  dst->palette = (unsigned *)malloc(sizeof(unsigned)*src->colorsCount);
  dst->colorsCount  = src->colorsCount;
  memcpy(dst->palette, src->palette, sizeof(unsigned)*src->colorsCount);
  unsigned __int8* image = (unsigned __int8 *)malloc(src->width*src->height);
  ptr = (unsigned *)dst->image;
  unsigned __int8* index = image;
  for(int i = dst->width*dst->height; i > 0; i--, ptr++, index++)
  {
    unsigned* clr = dst->palette;

    int min = 255;
    unsigned a0, r0, g0, b0;
    color2argb(a0, r0, g0, b0, *ptr);

    for(int j = dst->colorsCount; j > 0; j--, clr++)
    {
      unsigned a, r, g, b;
      color2argb(a, r, g, b, *clr);
      unsigned dr = abs((int)r - (int)r0);
      unsigned dg = abs((int)g - (int)g0);
      unsigned db = abs((int)b - (int)b0);
      unsigned da = abs((int)a - (int)a0);

      int max = dr > dg ? (dr > db ? (dr > da ? dr : da) : (db > da ? db : da)) : (dg > db ? (dg > da ? dg : da) : (db > da ? db : da));
      if(max > min) continue;
      min = max;
      *index = clr - dst->palette;
    }
  }

  free(dst->image);
  dst->image = image;
  dst->bpp = 8;
  return dst;
}
