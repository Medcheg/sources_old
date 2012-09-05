#pragma hdrstop

#include "tga_parser.h"
#include "image.h"

#include <stdlib.h>
#include <stdio.h>
#include <memory.h>


//***************************************************************************
#define UNKOMPRESSED_INDEX    1
#define UNKOMPRESSED_RGB      2
#define UNKOMPRESSED_GRAY     3
#define KOMPRESSED_INDEX      9
#define KOMPRESSED_RGB        10
#define KOMPRESSED_GRAY       11

//***************************************************************************
typedef struct _TgaHeader
{
  __int8  idLen;
  __int8  colorMapType;
  __int8  dataType;
  __int16 colorMapOrigin;
  __int16 colorMapLen;
  __int8  colorMapDepth;
  __int16 xOrigin;
  __int16 yOrigin;
  __int16 width;
  __int16 height;
  __int8  bitsPerPixel;
  __int8  imageDescriptor;
} TgaHeader;


//***************************************************************************
//---------------------------------------------------------------------------
static void     readPalette(FILE* file, Image* image, TgaHeader* header);
static void     createGrayscalePalette(Image* image);

//***************************************************************************
//---------------------------------------------------------------------------
static void readPalette(FILE* file, Image* image, TgaHeader* header)
{
  int colorMapEntrySize = bitPerPixel2Byte(header->colorMapDepth);
  unsigned __int8* colorMap = (unsigned __int8 *)malloc(colorMapEntrySize*header->colorMapLen);
  unsigned __int8* ptr = colorMap;

  fread(colorMap, colorMapEntrySize*header->colorMapLen, 1, file);
  image->palette = (unsigned *)malloc(sizeof(unsigned)*header->colorMapLen);

  for(int i = 0; i < header->colorMapLen; i++, ptr += colorMapEntrySize)
    image->palette[i] = unpackColor(colorMapEntrySize, ptr);

  image->colorsCount = 256;
}

//---------------------------------------------------------------------------
static void createGrayscalePalette(Image* image)
{
  image->palette = (unsigned *)malloc(sizeof(unsigned)*256);
  for(int i = 0; i < 256; i++)
  {
    unsigned a, r, g, b;
    a = 0xFF;
    r = g = b = i;
    image->palette[i] = (a << 24) | (r << 16) | (g << 8) | b;
  }

  image->colorsCount = 256;
}

//***************************************************************************
//---------------------------------------------------------------------------
Image* loadTGA(const char* fileName)
{
  FILE* file = fopen(fileName, "rb");
  if(file == NULL) return NULL;

  TgaHeader header;

  // read tga header
  fread(&header.idLen,           1, 1, file);
  fread(&header.colorMapType,    1, 1, file);
  fread(&header.dataType,        1, 1, file);
  fread(&header.colorMapOrigin,  2, 1, file);
  fread(&header.colorMapLen,     2, 1, file);
  fread(&header.colorMapDepth,   1, 1, file);
  fread(&header.xOrigin,         2, 1, file);
  fread(&header.yOrigin,         2, 1, file);
  fread(&header.width,           2, 1, file);
  fread(&header.height,          2, 1, file);
  fread(&header.bitsPerPixel,    1, 1, file);
  fread(&header.imageDescriptor, 1, 1, file);

  Image* image = (Image *)malloc(sizeof(Image));
  memset(image, 0, sizeof(Image));

  image->width = header.width;
  image->height = header.height;

  image->bpp = header.bitsPerPixel;

  bool palettePresent = false;
  bool isGrayscale = false;
  switch(header.dataType)
  {
    case UNKOMPRESSED_INDEX: palettePresent = true; break;
    case UNKOMPRESSED_GRAY: isGrayscale = true; break;
    case UNKOMPRESSED_RGB: break;
    default:
      free(image);
      fclose(file);
      return NULL;
  }

  if(palettePresent) readPalette(file, image, &header);
  if(isGrayscale) createGrayscalePalette(image);

  int imageEntrySize = bitPerPixel2Byte(header.bitsPerPixel);
  image->image = malloc(imageEntrySize * image->width * image->height);

  image->image = malloc(imageEntrySize * image->width * image->height);
  fread(image->image, imageEntrySize * image->width * image->height, 1, file);

  if((image->bpp == 32) || (image->bpp == 24))
  {
    unsigned* picture = (unsigned *)malloc(sizeof(unsigned)*image->width*image->height);
    unsigned* ptr = picture;
    unsigned __int8* entries = (unsigned __int8 *)image->image;
    int entrySize = bitPerPixel2Byte(image->bpp);

    for(int i = image->width*image->height; i > 0; i--, ptr++, entries += entrySize) *ptr = unpackColor(entrySize, entries);

    free(image->image);
    image->image = picture;
    image->bpp = 32;
  }

  int entrySize = bitPerPixel2Byte(image->bpp);
  int rowSize = entrySize*image->width;
  unsigned __int8* entries = (unsigned __int8 *)image->image;
  unsigned __int8* flip = (unsigned __int8 *)malloc(rowSize*image->height);
  unsigned __int8* ptr = flip + rowSize*(image->height-1);
  for(int i = image->height; i > 0; i--, ptr -= rowSize, entries += rowSize) memcpy(ptr, entries, rowSize);

  free(image->image);
  image->image = flip;

  fclose(file);
  return image;
}

//---------------------------------------------------------------------------
void saveTGA(const char* fileName, Image* image)
{
  FILE* file = fopen(fileName, "wb");
  if(file == NULL) return;

  TgaHeader header;

  header.idLen           = 0;
  header.colorMapType    = image->palette == NULL ? 0 : 1;
  header.dataType        = image->palette == NULL ? UNKOMPRESSED_RGB : UNKOMPRESSED_INDEX;
  header.colorMapOrigin  = 0;
  header.colorMapLen     = image->palette == NULL ? 0 : 256;
  header.colorMapDepth   = image->palette == NULL ? 0 : 24;
  header.xOrigin         = 0;
  header.yOrigin         = 0;
  header.width           = image->width;
  header.height          = image->height;
  header.bitsPerPixel    = image->bpp;
  header.imageDescriptor = 8;

  fwrite(&header.idLen,           1, 1, file);
  fwrite(&header.colorMapType,    1, 1, file);
  fwrite(&header.dataType,        1, 1, file);
  fwrite(&header.colorMapOrigin,  2, 1, file);
  fwrite(&header.colorMapLen,     2, 1, file);
  fwrite(&header.colorMapDepth,   1, 1, file);
  fwrite(&header.xOrigin,         2, 1, file);
  fwrite(&header.yOrigin,         2, 1, file);
  fwrite(&header.width,           2, 1, file);
  fwrite(&header.height,          2, 1, file);
  fwrite(&header.bitsPerPixel,    1, 1, file);
  fwrite(&header.imageDescriptor, 1, 1, file);

  if(image->palette != NULL)
  {
    for(int i = 0; i < image->colorsCount; i++)
    {
      unsigned __int8 r, g, b;
      r = (image->palette[i] >> 16) & 0xFF;
      g = (image->palette[i] >>  8) & 0xFF;
      b =  image->palette[i]        & 0xFF;

      fwrite(&b, 1, 1, file);
      fwrite(&g, 1, 1, file);
      fwrite(&r, 1, 1, file);
    }
  }

  int entrySize = bitPerPixel2Byte(image->bpp);
  fwrite(image->image, image->width*image->height*entrySize, 1, file);
  fclose(file);
}

