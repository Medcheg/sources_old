#ifndef paletteH
#define paletteH

//----------------------------------------------------------------------------
#define color2argb(a, r, g, b, c) a = ((c) >> 24) & 0xFF; \
                                  b = ((c) >> 16) & 0xFF; \
                                  g = ((c) >>  8) & 0xFF; \
                                  r = ((c) >>  0) & 0xFF

#define argb2color(c, a, r, g, b) c = ((a) << 24) | ((b) << 16) | ((g) <<  8) | (r)

//----------------------------------------------------------------------------
unsigned* createPalette(unsigned* pic, int picSize, int maxColors);

#endif
