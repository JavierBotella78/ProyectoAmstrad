#include "insertcoin.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2017
// Tile spr_insert: 89x11 pixels, 44x11 bytes.
const u8 spr_insert[44 * 11] = {
	0xff, 0xff, 0x55, 0xaa, 0x55, 0xaa, 0x55, 0xff, 0x00, 0x55, 0xff, 0xff, 0x55, 0xff, 0xff, 0x55, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xaa, 0x55, 0xff, 0xaa, 0x55, 0xff, 0xaa, 0xff, 0x00, 0xff, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa, 0x55, 0xff, 0xaa, 0x55, 0xaa,
	0x55, 0xff, 0xff, 0x55, 0xaa, 0x55, 0xaa, 0xff, 0xff, 0xaa, 0x55, 0xff, 0xff, 0x55, 0xff, 0xff, 0x55, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xaa, 0xff, 0xff, 0xff, 0x55, 0xff, 0xaa, 0xff, 0x00, 0xff, 0x00, 0x00, 0x00, 0x00, 0xff, 0xaa, 0x55, 0xff, 0xaa, 0x55,
	0xff, 0x55, 0x55, 0xaa, 0x55, 0xaa, 0x55, 0xaa, 0xff, 0x55, 0xaa, 0x55, 0xaa, 0x00, 0x55, 0xaa, 0x55, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x00, 0x55, 0x00, 0xaa, 0xff, 0x00, 0xff, 0x00, 0xff, 0x00, 0xff, 0x00, 0xff, 0x00, 0x00, 0x00, 0x00, 0xff, 0x00, 0x55, 0x00, 0xaa,
	0x00, 0xff, 0x55, 0x55, 0xaa, 0x55, 0xff, 0x55, 0xaa, 0xff, 0x00, 0x00, 0x55, 0xaa, 0x00, 0x55, 0xaa, 0x55, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0xff, 0x00, 0xff, 0x00, 0xff, 0x00, 0xff, 0xaa, 0xff, 0x00, 0x00, 0x00, 0x55, 0xaa, 0x00, 0xff, 0x00,
	0x00, 0x00, 0x55, 0xff, 0x15, 0x2a, 0x15, 0x3f, 0x3f, 0x2a, 0x3f, 0x3f, 0x3f, 0x15, 0x3f, 0x3f, 0x15, 0x2a, 0x3f, 0x00, 0x15, 0x2a, 0x00, 0x00, 0x00, 0x3f, 0x00, 0x00, 0x3f, 0x00, 0x3f, 0x00, 0x3f, 0x00, 0x3f, 0x3f, 0x3f, 0x00, 0x00, 0x00, 0x15, 0x2a, 0x00, 0x3f,
	0x00, 0x00, 0x00, 0x15, 0x7f, 0x51, 0xa2, 0x51, 0xf3, 0xf3, 0xa2, 0x51, 0xf3, 0xf3, 0x51, 0xf3, 0xf3, 0x51, 0xa2, 0xf3, 0x00, 0x51, 0xa2, 0x00, 0x00, 0x00, 0xf3, 0x00, 0x00, 0xf3, 0x00, 0xf3, 0x00, 0xf3, 0x00, 0xf3, 0xf3, 0xf3, 0x00, 0x00, 0x00, 0x51, 0xa2, 0x00,
	0xf3, 0x00, 0x00, 0x00, 0x51, 0xf7, 0x41, 0x82, 0x41, 0xc3, 0xc3, 0x82, 0x00, 0x00, 0xc3, 0x41, 0x82, 0x00, 0x41, 0xc3, 0x82, 0x00, 0x41, 0x82, 0x00, 0x00, 0x00, 0xc3, 0x00, 0x00, 0xc3, 0x00, 0xc3, 0x00, 0xc3, 0x00, 0xc3, 0xc3, 0xc3, 0x00, 0x00, 0x00, 0x41, 0x82,
	0x00, 0xc3, 0x00, 0x00, 0x00, 0x41, 0xd7, 0x41, 0x82, 0x41, 0xc3, 0xc3, 0x82, 0xc3, 0x00, 0xc3, 0x41, 0x82, 0x00, 0x41, 0xc3, 0x82, 0x00, 0x41, 0x82, 0x00, 0x00, 0x00, 0xc3, 0x00, 0x82, 0xc3, 0x00, 0xc3, 0x00, 0xc3, 0x00, 0xc3, 0xc3, 0xc3, 0x00, 0x00, 0x00, 0x41,
	0xc3, 0x00, 0xc3, 0x00, 0x82, 0x00, 0xc3, 0xd7, 0x10, 0x20, 0x10, 0x20, 0x30, 0x20, 0x30, 0x00, 0x30, 0x10, 0x20, 0x00, 0x10, 0x30, 0x30, 0x00, 0x10, 0x20, 0x00, 0x00, 0x00, 0x10, 0x00, 0x20, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x10, 0x30, 0x00, 0x00, 0x00,
	0x00, 0x30, 0x00, 0x10, 0x00, 0x20, 0x00, 0x30, 0x55, 0x30, 0x30, 0x10, 0x20, 0x10, 0x20, 0x10, 0x30, 0x20, 0x10, 0x30, 0x30, 0x10, 0x20, 0x30, 0x00, 0x10, 0x20, 0x00, 0x00, 0x00, 0x10, 0x30, 0x20, 0x10, 0x30, 0x20, 0x10, 0x30, 0x20, 0x30, 0x00, 0x30, 0x00, 0x00,
	0x00, 0x00, 0x10, 0x20, 0x10, 0x30, 0x20, 0x10, 0x20, 0x55, 0x30, 0x30, 0x10, 0x20, 0x10, 0x20, 0x10, 0x30, 0x20, 0x10, 0x30, 0x30, 0x10, 0x20, 0x30, 0x00, 0x10, 0x20, 0x00, 0x00, 0x00, 0x10, 0x30, 0x20, 0x10, 0x30, 0x20, 0x10, 0x30, 0x20, 0x30, 0x00, 0x30, 0x00,
};

