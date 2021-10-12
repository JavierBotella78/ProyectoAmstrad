#include "hudp.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2017
// Tile spr_hud_0: 40x56 pixels, 20x56 bytes.
const u8 spr_hud_0[20 * 56] = {
	0xff, 0xff, 0xfb, 0xf3, 0xf3, 0xf7, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfb, 0xf3,
	0xe3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3,
	0xe3, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x05, 0x0a, 0x00, 0x00, 0xcc, 0xcc, 0xcc, 0x88, 0x00, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0xaa,
	0xeb, 0x88, 0x00, 0x00, 0x0f, 0x30, 0x20, 0x88, 0xd9, 0xf3, 0xf3, 0xcc, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x10, 0x30, 0x0f, 0x44, 0x41, 0xe3, 0xc3, 0xc3, 0xf3, 0xc6, 0x00, 0x00, 0xaa, 0x15, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x05, 0x0a, 0x00, 0x82, 0xc6, 0xcc, 0xcc, 0xc3, 0xe3, 0x00, 0x00, 0x00, 0x2a, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x00, 0x44, 0x41, 0xcc, 0x00, 0x00, 0xd9, 0xc6, 0x00, 0x00, 0x15, 0x15, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x88, 0xf3, 0xcc, 0xcc, 0xe3, 0x61, 0x00, 0xaa, 0xf3, 0x2a, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x55, 0x44, 0x44, 0xc3, 0xf3, 0xf3, 0x92, 0xc6, 0x00, 0x00, 0xf3, 0x00, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x00, 0x41, 0x44, 0xc6, 0x30, 0x30, 0xcc, 0xc6, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x82, 0xc9, 0xc9, 0xc6, 0xcc, 0xc9, 0x00, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x00, 0x41, 0x41, 0xc6, 0xc6, 0xc6, 0xcc, 0xc6, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0xaa, 0x00, 0x82, 0xc9, 0xc9, 0xcc, 0xcc, 0xc9, 0x00, 0x00, 0x00, 0x00, 0x00, 0xaa, 0x00,
	0xeb, 0x88, 0x00, 0x44, 0x00, 0x00, 0x44, 0x41, 0xc3, 0xc3, 0xc6, 0xcc, 0xc6, 0x00, 0x00, 0x00, 0x88, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x88, 0x00, 0x88, 0x88, 0xcc, 0xcc, 0xc6, 0xcc, 0xc9, 0x88, 0x88, 0x88, 0xa2, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x44, 0x44, 0x44, 0x44, 0x44, 0xc3, 0xc3, 0xc6, 0xcc, 0xcc, 0xe6, 0x44, 0xd3, 0x82, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x88, 0x88, 0x88, 0x88, 0xcc, 0xc9, 0xc3, 0xcc, 0xcc, 0xd3, 0xc3, 0xe3, 0x20, 0x00, 0x00, 0x00,
	0xe3, 0x88, 0x00, 0x00, 0x44, 0x44, 0x44, 0x44, 0xc3, 0xc3, 0xcc, 0xc6, 0xcc, 0xc9, 0xf3, 0x92, 0x88, 0x00, 0x00, 0x01,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x88, 0x88, 0xc3, 0xf3, 0xf3, 0xf3, 0xe3, 0xcc, 0xd9, 0xc3, 0x64, 0x00, 0x00, 0x00, 0xff,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x44, 0xcc, 0xcc, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0x92, 0x88, 0x00, 0x00, 0x00, 0xff,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x20, 0x00, 0x10, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x10, 0x10, 0x40, 0x40, 0x60, 0x60, 0x80, 0x55, 0x00, 0x00, 0x55, 0xff,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x84, 0x24, 0x24, 0x84, 0x90, 0x90, 0x84, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff,
	0xeb, 0x88, 0x00, 0x00, 0xaa, 0x00, 0x40, 0x10, 0x30, 0x30, 0x48, 0x18, 0x30, 0x60, 0x80, 0x00, 0x00, 0x00, 0x55, 0xff,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc1, 0x61, 0x61, 0x84, 0x90, 0x92, 0x86, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x00, 0x40, 0x10, 0x92, 0x92, 0x48, 0x49, 0x61, 0x60, 0x80, 0x00, 0xaa, 0x00, 0x00, 0x57,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x88, 0x80, 0xc1, 0xe3, 0xe3, 0x84, 0xd1, 0xd3, 0x86, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03,
	0xe3, 0x88, 0x00, 0x00, 0x44, 0x00, 0x40, 0x51, 0xd3, 0xd3, 0x48, 0x49, 0xe3, 0xe2, 0x90, 0x00, 0x00, 0x00, 0x00, 0x01,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x98, 0x00, 0x84, 0xff, 0xae, 0x84, 0x2c, 0xff, 0x84, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x44, 0x20, 0x00, 0x80, 0x80, 0x1c, 0x1c, 0x08, 0x80, 0x64, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x88, 0x98, 0x40, 0x40, 0x40, 0x84, 0x2c, 0xc0, 0x40, 0x64, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x44, 0x44, 0x30, 0x30, 0x60, 0x84, 0x2c, 0x80, 0x80, 0xc9, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x88, 0x88, 0xcc, 0xcc, 0x20, 0x1c, 0x1c, 0x48, 0x64, 0xc6, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x44, 0x44, 0xc6, 0xc6, 0x60, 0x84, 0x2c, 0x80, 0x64, 0xc9, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x88, 0x88, 0xc9, 0xcc, 0x20, 0x1c, 0x1c, 0x48, 0x64, 0xc6, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x44, 0x44, 0xc6, 0xc6, 0x60, 0x84, 0x2c, 0x80, 0x64, 0xc9, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x88, 0x88, 0xc9, 0xcc, 0x98, 0x40, 0x48, 0x10, 0xcc, 0xc6, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x44, 0x44, 0xc6, 0xc6, 0x98, 0x84, 0x84, 0x90, 0xc9, 0xc9, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x88, 0x88, 0xc9, 0xc9, 0xcc, 0x60, 0x48, 0x10, 0xcc, 0xc6, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x44, 0x44, 0x64, 0xc6, 0xcc, 0x60, 0x80, 0xc4, 0xc9, 0xc9, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x00, 0x88, 0x98, 0xc9, 0xcc, 0x98, 0x40, 0x64, 0xc6, 0x92, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x64, 0xc6, 0x98, 0x80, 0x64, 0xc9, 0x64, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x10, 0xc9, 0x98, 0x00, 0x64, 0x98, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xe3, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x88, 0x64, 0x98, 0x00, 0x64, 0x64, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x10, 0x30, 0x00, 0x30, 0x88, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x88, 0x30, 0x00, 0x30, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xeb, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xff, 0xff, 0xfb, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf7, 0xff, 0xff,
	0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3
};

// Tile spr_hud_1: 40x56 pixels, 20x56 bytes.
const u8 spr_hud_1[20 * 56] = {
	0xff, 0xfb, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3,
	0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x55, 0x00, 0x00, 0x00, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0x55, 0xaa, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00, 0x55, 0xff, 0xaa, 0xff, 0xaa, 0xff,
	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xaa, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x00, 0xff, 0xff, 0xff, 0xff, 0xaa, 0xff,
	0x00, 0x00, 0x00, 0x15, 0x3f, 0x00, 0x3f, 0x2a, 0x15, 0x3f, 0x00, 0x3f, 0x2a, 0x15, 0x3f, 0x2a, 0x00, 0x3f, 0x2a, 0x00,
	0x00, 0x00, 0x00, 0xf3, 0xf3, 0x00, 0x51, 0xa2, 0xf3, 0xa2, 0x00, 0x51, 0xf3, 0x51, 0xf3, 0xa2, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0xf3, 0xa2, 0x00, 0x00, 0xa2, 0xf3, 0xa2, 0x00, 0x51, 0xf3, 0x51, 0xf3, 0xf3, 0xf3, 0xa2, 0x00, 0x00,
	0x00, 0x00, 0x00, 0xc3, 0x82, 0x00, 0x00, 0x00, 0xc3, 0x82, 0x00, 0x41, 0xc3, 0x00, 0xc3, 0xc3, 0xc3, 0xc3, 0x00, 0x00,
	0x00, 0x00, 0x00, 0xc3, 0x82, 0x00, 0x00, 0x82, 0xc3, 0x82, 0x00, 0x41, 0xc3, 0x00, 0xc3, 0xc3, 0xc3, 0xc3, 0x82, 0x00,
	0x00, 0x00, 0x00, 0x30, 0x30, 0x00, 0x10, 0x20, 0x30, 0x20, 0x00, 0x10, 0x30, 0x00, 0x00, 0x10, 0x30, 0x30, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x30, 0x00, 0x10, 0x20, 0x10, 0x30, 0x00, 0x30, 0x20, 0x10, 0x30, 0x00, 0x00, 0x30, 0x20, 0x00,
	0x00, 0x55, 0x00, 0x10, 0x30, 0x30, 0x30, 0x00, 0x10, 0x30, 0x30, 0x30, 0x00, 0x10, 0x30, 0x30, 0x30, 0x30, 0x00, 0x30,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x30, 0x20, 0x00, 0x00, 0x30, 0x30, 0x30, 0x00, 0x10, 0x30, 0x10, 0x30, 0x20, 0x00, 0x30,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x03, 0x03, 0x03, 0x03, 0x02, 0x00, 0x00, 0x00, 0x03, 0x03, 0x00, 0x00, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03,
	0xab, 0xab, 0xab, 0xab, 0xaa, 0x00, 0x00, 0x00, 0x57, 0x57, 0x02, 0x00, 0x57, 0x57, 0x57, 0x57, 0x57, 0x57, 0x57, 0x57,
	0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x00, 0xff, 0xff, 0xaa, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xff, 0x00, 0x00, 0xff, 0xaa, 0x00, 0x00, 0x00, 0xff, 0xff, 0xaa, 0x00, 0xff, 0x00, 0x55, 0xff, 0xaa, 0x55, 0xff, 0x00,
	0xaa, 0x00, 0x00, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xaa, 0xff, 0xff, 0x00, 0xff, 0x00, 0x55, 0xff, 0xaa, 0x55, 0xff, 0x00,
	0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa, 0xff, 0xff, 0x00, 0xff, 0x00, 0x55, 0xff, 0xaa, 0x55, 0xff, 0x00,
	0xaa, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x55, 0x00, 0x55, 0xff, 0x00, 0x00, 0x00, 0x55, 0xff, 0xaa, 0x00, 0x00, 0x00,
	0xaa, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x00, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xaa, 0x00, 0x00, 0x00,
	0xaa, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x00, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xaa, 0x00, 0x00, 0x00,
	0xaa, 0x00, 0x55, 0xff, 0xaa, 0x00, 0x00, 0xff, 0x00, 0x55, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xaa, 0x00, 0x00, 0x00,
	0x57, 0x00, 0x01, 0xab, 0xaa, 0x00, 0x01, 0xab, 0x00, 0x01, 0xab, 0xab, 0x00, 0x00, 0x01, 0xab, 0xaa, 0x00, 0x00, 0x00,
	0x03, 0x03, 0x03, 0x03, 0x02, 0x01, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x02, 0x03, 0x03, 0x03, 0x03, 0x02, 0x00, 0x03,
	0x03, 0x03, 0x03, 0x03, 0x02, 0x01, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x02, 0x03, 0x03, 0x03, 0x03, 0x02, 0x00, 0x03,
	0x01, 0x03, 0x02, 0x01, 0x02, 0x01, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x02, 0x03, 0x03, 0x03, 0x03, 0x02, 0x00, 0x03,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x55, 0xff, 0xaa, 0xff, 0xff, 0x55, 0xff, 0xaa, 0xff, 0xff, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa2, 0x00, 0x51, 0x00, 0x00, 0xa2, 0x51, 0x51, 0x00, 0xa2, 0xa2, 0x00, 0x51,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xf3, 0xf3, 0x51, 0x00, 0x00, 0xa2, 0x51, 0x51, 0xf3, 0xa2, 0xf3, 0xf3, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x41, 0x41, 0x00, 0x00, 0x82, 0x41, 0x41, 0x41, 0x00, 0x82, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x30, 0x10, 0x30, 0x20, 0x30, 0x30, 0x10, 0x00, 0x20, 0x30, 0x30, 0x10,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xf3, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfb, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3
};

// Tile spr_hud_2: 40x56 pixels, 20x56 bytes.
const u8 spr_hud_2[20 * 56] = {
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3,
	0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x00, 0x55, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xff, 0xff, 0xaa, 0xff, 0xff, 0xff, 0x55, 0xff, 0xff, 0x00, 0x55, 0xff, 0xaa, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xff, 0xff, 0xaa, 0xff, 0xff, 0xff, 0x55, 0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x3f, 0x3f, 0x3f, 0x3f, 0x3f, 0x00, 0x00, 0x3f, 0x2a, 0x15, 0x3f, 0x2a, 0x15, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xa2, 0xf3, 0xf3, 0xa2, 0xf3, 0x00, 0x00, 0xf3, 0xa2, 0xf3, 0xf3, 0xa2, 0x00, 0xf3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xa2, 0xf3, 0xf3, 0xa2, 0xf3, 0x00, 0x00, 0xf3, 0xa2, 0xf3, 0xf3, 0x00, 0x00, 0x51, 0x00, 0x00, 0x55, 0x00, 0x00, 0xaa,
	0x82, 0xc3, 0xc3, 0x82, 0xc3, 0x55, 0x00, 0xc3, 0x82, 0xc3, 0xc3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x82, 0x41, 0xc3, 0x00, 0xc3, 0x00, 0x00, 0xc3, 0x82, 0xc3, 0xc3, 0x00, 0x00, 0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x20, 0x10, 0x30, 0x00, 0x30, 0x00, 0x00, 0x30, 0x20, 0x30, 0x30, 0x20, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x20, 0x00, 0x20, 0x00, 0x30, 0x00, 0x00, 0x30, 0x20, 0x10, 0x30, 0x20, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x30, 0x00, 0x20, 0x30, 0x30, 0x30, 0x10, 0x30, 0x30, 0x10, 0x30, 0x30, 0x30, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x30, 0x20, 0x20, 0x30, 0x30, 0x30, 0x10, 0x30, 0x30, 0x00, 0x10, 0x30, 0x30, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x03, 0x03, 0x03, 0x00, 0x00, 0x00, 0x01, 0x03, 0x03, 0x03, 0x02, 0x03, 0x03, 0x03, 0x02, 0x01, 0x03, 0x03, 0x02, 0x01,
	0x57, 0x57, 0x57, 0x00, 0x00, 0x00, 0x01, 0xab, 0xab, 0xab, 0xaa, 0xab, 0xab, 0xab, 0xab, 0x01, 0xab, 0xab, 0xaa, 0x01,
	0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xaa, 0xff, 0xff, 0xff, 0xff, 0x55, 0xff, 0xff, 0xaa, 0x55,
	0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0xaa, 0x00, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x55, 0xaa, 0x00, 0x55,
	0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0xaa, 0x00, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x55, 0xaa, 0x00, 0x55,
	0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0xaa, 0x00, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x55, 0xaa, 0x00, 0x55,
	0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0xaa, 0x00, 0x55, 0xaa, 0xff, 0xff, 0xff, 0x55, 0xaa, 0x00, 0x00,
	0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0xaa, 0x00, 0x55, 0xaa, 0x55, 0xff, 0xff, 0x55, 0xaa, 0x00, 0x00,
	0xff, 0xff, 0x00, 0x00, 0xff, 0xff, 0x00, 0x55, 0xff, 0xaa, 0x00, 0x55, 0xaa, 0x55, 0xff, 0xff, 0xff, 0xaa, 0xaa, 0x00,
	0xff, 0xff, 0x00, 0x00, 0xff, 0xff, 0x00, 0x55, 0xff, 0xaa, 0x00, 0x55, 0xaa, 0x00, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00,
	0x57, 0x57, 0x00, 0x00, 0x57, 0x57, 0x00, 0x01, 0xab, 0xaa, 0x00, 0x01, 0xaa, 0x00, 0xab, 0xab, 0xab, 0xaa, 0x00, 0x00,
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x01, 0x03, 0x03, 0x03, 0x02, 0x03, 0x03, 0x02, 0x01, 0x03, 0x03, 0x02, 0x00, 0x00,
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x01, 0x03, 0x03, 0x03, 0x02, 0x03, 0x03, 0x02, 0x00, 0x03, 0x03, 0x02, 0x00, 0x00,
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x01, 0x03, 0x03, 0x03, 0x02, 0x03, 0x03, 0x02, 0x00, 0x03, 0x03, 0x02, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3
};

// Tile spr_hud_3: 40x56 pixels, 20x56 bytes.
const u8 spr_hud_3[20 * 56] = {
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xd7,
	0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xd7,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd7,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd7,
	0x00, 0x00, 0x00, 0x55, 0x00, 0x00, 0x55, 0x00, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd7,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd7,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x00, 0x00, 0x00, 0x44, 0xd7,
	0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd7,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x41, 0x6b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd7,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xf7, 0x00, 0x00, 0x00, 0x00, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd7,
	0x00, 0x00, 0x00, 0x00, 0x00, 0xfb, 0xf3, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd7,
	0x00, 0x55, 0x00, 0xbf, 0x7f, 0xfb, 0xf3, 0xf7, 0x3f, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd7,
	0x00, 0x00, 0x00, 0xd7, 0xf7, 0xf7, 0xf3, 0xf3, 0xf7, 0x82, 0x00, 0x00, 0x15, 0x00, 0x00, 0x00, 0xaa, 0x00, 0x44, 0xd7,
	0x00, 0x00, 0x00, 0x15, 0xf3, 0xfb, 0xfb, 0xf3, 0xb7, 0x00, 0x00, 0x00, 0x97, 0x82, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x41, 0xf7, 0xff, 0xf7, 0xf3, 0x6b, 0x00, 0x00, 0x00, 0xfb, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0xd3, 0xff, 0xfb, 0xfb, 0x82, 0x00, 0x00, 0x55, 0xf3, 0xf7, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0xd7, 0xf7, 0xff, 0xf7, 0x82, 0x55, 0x3f, 0xff, 0xf3, 0xf3, 0xbf, 0x7f, 0x00, 0x00, 0x44, 0xd7,
	0x00, 0x00, 0x00, 0x41, 0x7b, 0xfb, 0xff, 0xfb, 0xeb, 0x41, 0xfb, 0xfb, 0xfb, 0xf3, 0xf3, 0xeb, 0x00, 0x00, 0x44, 0xd7,
	0x00, 0x00, 0xaa, 0x15, 0xf3, 0xf7, 0xf7, 0xff, 0xf7, 0x00, 0x7b, 0xf7, 0xf7, 0xf3, 0xf3, 0x2a, 0x00, 0x00, 0x44, 0xd7,
	0x03, 0x00, 0x00, 0xd7, 0xf3, 0xf3, 0xfb, 0xff, 0xff, 0x82, 0xd3, 0xff, 0xfb, 0xfb, 0xb7, 0x82, 0x00, 0x00, 0x44, 0xd7,
	0xab, 0x00, 0x00, 0xbf, 0x7f, 0xf3, 0x7f, 0xf7, 0x3f, 0xaa, 0x41, 0xf7, 0xff, 0xf7, 0xe3, 0x00, 0x00, 0x00, 0x44, 0xd7,
	0xaa, 0x00, 0x00, 0x00, 0x00, 0xfb, 0xf3, 0xaa, 0x00, 0x00, 0x41, 0xfb, 0xff, 0xfb, 0xeb, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0xaa, 0x00, 0x00, 0x00, 0x00, 0x55, 0x7f, 0x00, 0x00, 0x00, 0x97, 0xf7, 0xf7, 0xff, 0xf7, 0x82, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x41, 0x6b, 0x00, 0x00, 0x00, 0x7b, 0xf3, 0xfb, 0xff, 0xfb, 0xaa, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0xaa, 0x00, 0x00, 0x2a, 0x00, 0x00, 0x41, 0xfb, 0xf3, 0xf7, 0xf7, 0xff, 0xeb, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x00, 0x00, 0x00, 0xfb, 0xb7, 0xfb, 0xbf, 0x7f, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x97, 0x82, 0x00, 0x00, 0x55, 0xf3, 0xf7, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfb, 0xaa, 0x00, 0x00, 0x00, 0xbf, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xf3, 0xf7, 0x00, 0x00, 0x00, 0x97, 0x82, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x55, 0x3f, 0xff, 0xf3, 0xf3, 0xbf, 0x7f, 0x00, 0x15, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x41, 0xfb, 0xfb, 0xfb, 0xf3, 0xf3, 0xeb, 0x00, 0x00, 0x00, 0x2a, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x7b, 0xf7, 0xf7, 0xf3, 0xf3, 0x2a, 0x00, 0x00, 0x41, 0x6b, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0xd3, 0xff, 0xfb, 0xfb, 0xb7, 0x82, 0x00, 0x00, 0x55, 0xf7, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x41, 0xf7, 0xff, 0xf7, 0xe3, 0x00, 0x00, 0x00, 0xfb, 0xf3, 0xaa, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x41, 0xfb, 0xff, 0xfb, 0xeb, 0x00, 0xbf, 0x7f, 0xfb, 0xf3, 0xf7, 0x3f, 0xaa, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x97, 0xf7, 0xf7, 0xff, 0xf7, 0x82, 0xd7, 0xf7, 0xf7, 0xf3, 0xf3, 0xf7, 0x82, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x7b, 0xf3, 0xfb, 0xff, 0xfb, 0xaa, 0x15, 0xf3, 0xfb, 0xfb, 0xf3, 0xb7, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x41, 0xfb, 0xf3, 0xf7, 0xf7, 0xff, 0xeb, 0x41, 0xf7, 0xff, 0xf7, 0xf3, 0x6b, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x55, 0x3f, 0xfb, 0xb7, 0xfb, 0xbf, 0x7f, 0x00, 0xd3, 0xff, 0xfb, 0xfb, 0x82, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xf3, 0xf7, 0x00, 0x00, 0x00, 0xd7, 0xf7, 0xff, 0xf7, 0x82, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xbf, 0xaa, 0x00, 0x00, 0x41, 0x7b, 0xfb, 0xff, 0xfb, 0xeb, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x97, 0x82, 0x00, 0x00, 0x15, 0xf3, 0xf7, 0xf7, 0xff, 0xf7, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x00, 0x00, 0x00, 0xd7, 0xf3, 0xf3, 0xfb, 0xff, 0xff, 0x82, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xbf, 0x7f, 0xf3, 0x7f, 0xf7, 0x3f, 0xaa, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfb, 0xf3, 0xaa, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x7f, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x41, 0x6b, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2a, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0xd3,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xf3, 0xf7, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3, 0xc3
};

