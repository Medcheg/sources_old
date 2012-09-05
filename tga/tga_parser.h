#ifndef tga_parserH
#define tga_parserH

#include "image.h"

Image* loadTGA(const char* fileName);
void saveTGA(const char* fileName, Image* image);

#endif

