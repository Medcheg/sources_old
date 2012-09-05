#pragma hdrstop

#include "palette.h"

//---------------------------------------------------------------------------

#include <stdlib.h>
#include <memory.h>

//----------------------------------------------------------------------------
typedef struct _Leaf
{
  int         colorsCount;
  unsigned*   color;
  int*        counts;

  unsigned    minColor;
  unsigned    maxColor;

  int         totalColors;
} Leaf;


//----------------------------------------------------------------------------
static void     addColor(unsigned* palette, int* counts, int& size, unsigned color);
static unsigned getLeafSize(Leaf* leaf);
static Leaf*    splitLeaf(Leaf* leaf);
static bool     isColorInLeaf(Leaf* leaf, unsigned color);
static unsigned getColorOfLeaf(Leaf* leaf);


//---------------------------------------------------------------------------
static bool isColorInLeaf(Leaf* leaf, unsigned color)
{
  unsigned minR, minG, minB, minA;
  unsigned maxR, maxG, maxB, maxA;
  unsigned a, r, g, b;

  color2argb(minA, minR, minG, minB, leaf->minColor);
  color2argb(maxA, maxR, maxG, maxB, leaf->maxColor);
  color2argb(a, r, g, b, color);

  return ((r >= minR) && (r <= maxR) && (g >= minG) && (g <= maxG) && (b >= minB) && (b <= maxB) && (a >= minA) && (a <= maxA));
}

//---------------------------------------------------------------------------
static unsigned getColorOfLeaf(Leaf* leaf)
{
  unsigned red = 0, green = 0, blue = 0, alpha = 0;
  int total = 0;
  unsigned a, r, g, b;
  unsigned color;

  int* counts = leaf->counts;
  unsigned* ptr = leaf->color;
  for(int i = leaf->colorsCount; i > 0; i--, ptr++, counts++)
  {
    color2argb(a, r, g, b, *ptr);
    red   += *counts*r;
    green += *counts*g;
    blue  += *counts*b;
    alpha += *counts*a;
    total += *counts;
  }

  argb2color(color, alpha/total, red/total, green/total, blue/total);
  return color;
}

//---------------------------------------------------------------------------
static Leaf* splitLeaf(Leaf* leaf)
{
  if(leaf == NULL) return NULL;

  unsigned minR, minG, minB, minA;
  unsigned maxR, maxG, maxB, maxA;
  unsigned deltaR, deltaG, deltaB, deltaA;

  Leaf* added = (Leaf *)malloc(sizeof(Leaf)*2);
  memset(added, 0, sizeof(Leaf)*2);

  color2argb(minA, minR, minG, minB, leaf->minColor);
  color2argb(maxA, maxR, maxG, maxB, leaf->maxColor);
  deltaR = maxR - minR + 1;
  deltaG = maxG - minG + 1;
  deltaB = maxB - minB + 1;
  deltaA = maxA - minA + 1;

  unsigned delta[4] = {deltaA, deltaR, deltaG, deltaB};
  int chanel = 0;
  for(int i = 1; i < 4; i++) if(delta[i] > delta[chanel]) chanel = i;

  unsigned tweak[2][4] = {{deltaA-1, deltaR-1, deltaG-1, deltaB-1}, {deltaA-1, deltaR-1, deltaG-1, deltaB-1}};
  tweak[0][chanel] = (tweak[0][chanel] + 1) >> 1;
  tweak[1][chanel] = tweak[0][chanel] + 1;

  argb2color(added[0].minColor, minA, minR, minG, minB);
  argb2color(added[0].maxColor, minA+tweak[0][0], minR+tweak[0][1], minG+tweak[0][2], minB+tweak[0][3]);

  argb2color(added[1].maxColor, minA+tweak[1][0], minR+tweak[1][1], minG+tweak[1][2], minB+tweak[1][3]);
  argb2color(added[1].maxColor, maxA, maxR, maxG, maxB);

  unsigned* ptr = leaf->color;
  int* counts = leaf->counts;
  for(int i = leaf->colorsCount; i > 0; i--, ptr++, counts++)
  {
    unsigned a, r, g, b;
    color2argb(a, r, g, b, *ptr);

    for(int j = 0; j < 2; j++)
    {
      color2argb(minA, minR, minG, minB, added[j].minColor);
      color2argb(maxA, maxR, maxG, maxB, added[j].maxColor);

      if((r < minR) || (r > maxR)) continue;
      if((g < minG) || (g > maxG)) continue;
      if((b < minB) || (b > maxB)) continue;
      if((a < minA) || (a > maxA)) continue;

      added[j].colorsCount++;
      added[j].color = (unsigned *)realloc(added[j].color, sizeof(unsigned)*added[j].colorsCount);
      added[j].counts = (int *)realloc(added[j].counts, sizeof(unsigned)*added[j].colorsCount);
      added[j].color[added[j].colorsCount-1] = *ptr;
      added[j].counts[added[j].colorsCount-1] = *counts;
      break;
    }
  }

  for(int i = 0; i < 2; i++)
  {
    unsigned a, r, g, b;

    color2argb(minA, minR, minG, minB, added[i].maxColor);
    color2argb(maxA, maxR, maxG, maxB, added[i].minColor);

    added[i].totalColors = 0;

    unsigned* ptr = added[i].color;
    int* counts = added[i].counts;
    for(int j = added[i].colorsCount; j > 0; j--, ptr++, counts++)
    {
      color2argb(a, r, g, b, *ptr);

      if(r < minR) minR = r;
      if(r > maxR) maxR = r;
      if(g < minG) minG = g;
      if(g > maxG) maxG = g;
      if(b < minB) minB = b;
      if(b > maxB) maxB = b;
      if(a < minA) minA = a;
      if(a > maxA) maxA = a;

      added[i].totalColors += *counts;
    }

    argb2color(added[i].minColor, minA, minR, minG, minB);
    argb2color(added[i].maxColor, maxA, maxR, maxG, maxB);
  }

  free(leaf->color);
  free(leaf->counts);
  leaf->color = NULL;
  leaf->counts = NULL;
  return added;
}

//---------------------------------------------------------------------------
static unsigned getLeafSize(Leaf* leaf)
{
  unsigned minA, minR, minG, minB;
  unsigned maxA, maxR, maxG, maxB;

  if(leaf == NULL) return 0;
  if(leaf->colorsCount == 0) return 0;

  color2argb(minA, minR, minG, minB, leaf->minColor);
  color2argb(maxA, maxR, maxG, maxB, leaf->maxColor);

  return ((maxA-minA+1)*(maxR-minR+1)*(maxG-minG+1)*(maxB-minB+1));
}

//---------------------------------------------------------------------------
static void addColor(unsigned* palette, int* counts, int& size, unsigned color)
{
  unsigned* ptr = palette;

  for(int i = size; i > 0; i--, ptr++)
  {
    if(*ptr != color) continue;
    counts[size-i]++;
    return;
  }

  palette[size] = color;
  counts[size] = 1;
  size++;
}

//---------------------------------------------------------------------------
unsigned* createPalette(unsigned* pic, int picSize, int maxColors)
{
  unsigned* ptr;

  unsigned* palette = (unsigned *)malloc(sizeof(unsigned)*picSize);
  int*      counts  = (int *)malloc(sizeof(int)*picSize);
  memset(counts, 0, sizeof(int)*picSize);
  int size = 0;

  /*
  ptr = pic;
  for(int i = picSize; i > 0; i--, ptr++)
  {
    unsigned a, r, g, b;
    color2argb(a, r, g, b, *ptr);
    argb2color(*ptr, (a & 0xF8) == 0xF8 ? 0xFF : (a & 0xF8), (r & 0xF8), (g & 0xF8), (b & 0xF8));
  }
  */
  ptr = pic;
  for(int i = picSize; i > 0; i--, ptr++) addColor(palette, counts, size, *ptr);

  if(size < maxColors)
  {
    unsigned* result = (unsigned *)malloc(sizeof(unsigned)*maxColors);
    memset(result, 0, sizeof(unsigned)*maxColors);
    memcpy(result, palette, sizeof(unsigned)*size);
    free(palette);
    ptr = pic;
    for(int i = picSize; i > 0; i--, ptr++)
    {
      unsigned* clr = result;
      for(int j = maxColors; j > 0; j--, clr++)
      {
        if(*ptr != *clr) continue;
        *ptr = maxColors-j;
        break;
      }
    }
    return result;
  }

  unsigned minR = 256, minG = 256, minB = 256, minA = 256;
  unsigned maxR = 0, maxG = 0, maxB = 0, maxA = 0;

  Leaf* leaf = (Leaf *)malloc(sizeof(Leaf));
  leaf->color = palette;
  leaf->counts = counts;
  leaf->colorsCount = size;
  leaf->totalColors = 0;
  int leavesCount = 1;

  ptr = palette;
  for(int i = size; i > 0; i--, ptr++)
  {
    unsigned a, r, g, b;
    color2argb(a, r, g, b, *ptr);

    if(r < minR) minR = r;
    if(r > maxR) maxR = r;
    if(g < minG) minG = g;
    if(g > maxG) maxG = g;
    if(b < minB) minB = b;
    if(b > maxB) maxB = b;
    if(a < minA) minA = a;
    if(a > maxA) maxA = a;

    leaf->totalColors += leaf->counts[i];
  }

  argb2color(leaf->minColor, minA, minR, minG, minB);
  argb2color(leaf->maxColor, maxA, maxR, maxG, maxB);

  do
  {
    Leaf* max = leaf;
    unsigned leafSize = getLeafSize(max);

    Leaf* cur = leaf + 1;
    for(int i = leavesCount; i > 1; i--, cur++)
    {
      unsigned curSize = getLeafSize(cur);
      if(curSize < leafSize) continue;
      if(curSize == leafSize)
        if(cur->totalColors < max->totalColors) continue;
      if(leafSize == 1) continue;

      max = cur;
      leafSize = curSize;
    }

    if(leafSize < 2) break;

    int index = max - leaf;
    Leaf* added = splitLeaf(max);

    Leaf* buffer = (Leaf *)malloc(sizeof(Leaf)*(leavesCount+1));
    if(index != 0) memcpy(buffer, leaf, index*sizeof(Leaf));
    memcpy(&buffer[index], added, sizeof(Leaf)*2);
    if(index != (leavesCount-1)) memcpy(&buffer[index+2], &leaf[index+1], sizeof(Leaf)*(leavesCount-index-1));
    free(leaf);
    leaf = buffer;
    leavesCount++;
    free(added);
  } while(leavesCount < maxColors);

  ptr = pic;
  for(int i = picSize; i > 0; i--, ptr++)
  {
    Leaf* cur = leaf;
    for(int j = leavesCount; j > 0; j--, cur++)
    {
      if(!isColorInLeaf(cur, *ptr)) continue;
      *ptr = leavesCount-j;
      break;
    }
  }

  unsigned* result = (unsigned *)malloc(sizeof(unsigned)*maxColors);
  memset(result, 0, sizeof(unsigned)*maxColors);
  for(int i = 0; i < leavesCount;i++)
  {
    result[i] = getColorOfLeaf(&leaf[i]);
    free(leaf[i].color);
    free(leaf[i].counts);
  }
  free(leaf);

  return result;
}

