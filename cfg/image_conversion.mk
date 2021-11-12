##-----------------------------LICENSE NOTICE------------------------------------
##  This file is part of CPCtelera: An Amstrad CPC Game Engine 
##  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
##
##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU Lesser General Public License as published by
##  the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU Lesser General Public License for more details.
##
##  You should have received a copy of the GNU Lesser General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
##------------------------------------------------------------------------------
############################################################################
##                        CPCTELERA ENGINE                                ##
##                 Automatic image conversion file                        ##
##------------------------------------------------------------------------##
## This file is intended for users to automate image conversion from JPG, ##
## PNG, GIF, etc. into C-arrays.                                          ##
############################################################################

##
## NEW MACROS
##

## 16 colours palette
PALETTE=0 1 2 3 6 9 11 12 13 15 16 18 20 24 25 26

## Default values
$(eval $(call IMG2SP, SET_MODE, 0 ))  #{ 0, 1, 2 }
#$(eval $(call IMG2SP, SET_MASK        , none               ))  { interlaced, none }
$(eval $(call IMG2SP, SET_FOLDER, src/sprites/  ))
#$(eval $(call IMG2SP, SET_EXTRAPAR    ,                    ))
#$(eval $(call IMG2SP, SET_IMG_FORMAT  , sprites            ))	{ sprites, zgtiles, screen }
$(eval $(call IMG2SP, SET_OUTPUT, c ))  #{ bin, c }
$(eval $(call IMG2SP, SET_PALETTE_FW, $(PALETTE)))
$(eval $(call IMG2SP, CONVERT_PALETTE , $(PALETTE), main_palette ))

$(eval $(call IMG2SP, CONVERT , assets/sheriff2.png , 8, 16, spr_idle))
$(eval $(call IMG2SP, CONVERT , assets/sheriff.png , 8, 16, spr_idle2))
$(eval $(call IMG2SP, CONVERT , assets/move/sheriff-downCPC.png , 8, 16, spr_down1))
$(eval $(call IMG2SP, CONVERT , assets/move/sheriff-downCPC2.png , 8, 16, spr_down2))
$(eval $(call IMG2SP, CONVERT , assets/move/sheriff-upCPC.png , 8, 16, spr_up1))
$(eval $(call IMG2SP, CONVERT , assets/move/sheriff-upCPC2.png , 8, 16, spr_up2))

$(eval $(call IMG2SP, CONVERT , assets/move/sheriffjetpack1.png , 8, 16, spr_jetpack1))
$(eval $(call IMG2SP, CONVERT , assets/move/sheriffjetpack2.png , 8, 16, spr_jetpack2))
$(eval $(call IMG2SP, CONVERT , assets/move/sheriffjetpack3.png , 8, 16, spr_jetpack3))

$(eval $(call IMG2SP, CONVERT , assets/enemies/drone1.png , 12, 16, spr_drone))
$(eval $(call IMG2SP, CONVERT , assets/enemies/drone2.png , 12, 16, spr_drone2))

$(eval $(call IMG2SP, CONVERT , assets/enemies/octo1.png , 10, 16, spr_octo))
$(eval $(call IMG2SP, CONVERT , assets/enemies/octo2.png , 10, 16, spr_octo2))

$(eval $(call IMG2SP, CONVERT , assets/enemies/robot1.png , 12, 16, spr_robo))
$(eval $(call IMG2SP, CONVERT , assets/enemies/robot2.png , 12, 16, spr_robo2))
$(eval $(call IMG2SP, CONVERT , assets/enemies/robot3.png , 12, 16, spr_robo3))

$(eval $(call IMG2SP, CONVERT , assets/doblescore1.png , 10, 12, spr_doblescore1))
$(eval $(call IMG2SP, CONVERT , assets/doblescore2.png , 10, 12, spr_doblescore2))

$(eval $(call IMG2SP, CONVERT , assets/powerup1.png , 10, 12, spr_powerup1))
$(eval $(call IMG2SP, CONVERT , assets/powerup2.png , 10, 12, spr_powerup2))
$(eval $(call IMG2SP, CONVERT , assets/powerup3.png , 10, 12, spr_powerup3))
$(eval $(call IMG2SP, CONVERT , assets/powerup4.png , 10, 12, spr_powerup4))
$(eval $(call IMG2SP, CONVERT , assets/powerup5.png , 10, 12, spr_powerup5))
$(eval $(call IMG2SP, CONVERT , assets/powerup6.png , 10, 12, spr_powerup6))
$(eval $(call IMG2SP, CONVERT , assets/powerup7.png , 10, 12, spr_powerup7))
$(eval $(call IMG2SP, CONVERT , assets/powerup8.png , 10, 12, spr_powerup8))

$(eval $(call IMG2SP, CONVERT , assets/rainbow.png , 12, 4, spr_rainbow))
$(eval $(call IMG2SP, CONVERT , assets/rainbow2.png , 12, 4, spr_wobniar))

$(eval $(call IMG2SP, CONVERT , assets/hudd.png , 40, 56, spr_hud))

$(eval $(call IMG2SP, CONVERT , assets/floor/floor1.png , 80, 11, spr_floor1))
$(eval $(call IMG2SP, CONVERT , assets/floor/floor2.png , 80, 11, spr_floor2))
$(eval $(call IMG2SP, CONVERT , assets/floor/floor3.png , 80, 11, spr_floor3))

$(eval $(call IMG2SP, CONVERT , assets/floor/floor11.png , 80, 11, spr_floor11))
$(eval $(call IMG2SP, CONVERT , assets/floor/floor22.png , 80, 11, spr_floor22))
$(eval $(call IMG2SP, CONVERT , assets/floor/floor33.png , 80, 11, spr_floor33))

$(eval $(call IMG2SP, CONVERT , assets/hud/0stars.png , 40, 56, spr_stars0))
$(eval $(call IMG2SP, CONVERT , assets/hud/1star.png , 40, 56, spr_stars1))
$(eval $(call IMG2SP, CONVERT , assets/hud/2stars.png , 40, 56, spr_stars2))
$(eval $(call IMG2SP, CONVERT , assets/hud/3stars.png , 40, 56, spr_stars3))
$(eval $(call IMG2SP, CONVERT , assets/hud/4stars.png , 40, 56, spr_stars4))

$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl10.png , 8, 16, spr_explosion10))
$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl11.png , 8, 16, spr_explosion11))
$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl12.png , 8, 16, spr_explosion12))
$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl13.png , 8, 16, spr_explosion13))
$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl14.png , 8, 16, spr_explosion14))

$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl20.png , 8, 16, spr_explosion20))
$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl21.png , 8, 16, spr_explosion21))
$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl22.png , 8, 16, spr_explosion22))
$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl23.png , 8, 16, spr_explosion23))
$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl24.png , 8, 16, spr_explosion24))

$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl30.png , 8, 16, spr_explosion30))
$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl31.png , 8, 16, spr_explosion31))
$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl32.png , 8, 16, spr_explosion32))
$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl33.png , 8, 16, spr_explosion33))
$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl34.png , 8, 16, spr_explosion34))

$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl40.png , 4, 8, spr_explosion40))
$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl41.png , 4, 8, spr_explosion41))
$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl42.png , 4, 8, spr_explosion42))
$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl43.png , 4, 8, spr_explosion43))
$(eval $(call IMG2SP, CONVERT , assets/explosion/rainbowexpl44.png , 4, 8, spr_explosion44))

$(eval $(call IMG2SP, CONVERT , assets/menu-parts/marcobot.png , 74, 12, spr_marcobot))
$(eval $(call IMG2SP, CONVERT , assets/menu-parts/marcotop.png , 74, 12, spr_marcotop))
$(eval $(call IMG2SP, CONVERT , assets/menu-parts/marcoleft.png , 6, 200, spr_marcoleft))
$(eval $(call IMG2SP, CONVERT , assets/menu-parts/marcoright.png , 6, 200, spr_marcoright))

$(eval $(call IMG2SP, CONVERT , assets/menu-parts/cosmic1.png , 62, 11, spr_cosmic1))
$(eval $(call IMG2SP, CONVERT , assets/menu-parts/gatlin.png , 84, 14, spr_gatlin))
$(eval $(call IMG2SP, CONVERT , assets/menu-parts/hashtag.png , 68, 8, spr_hashtag))
$(eval $(call IMG2SP, CONVERT , assets/menu-parts/hiscore.png , 82, 8, spr_highscore))
$(eval $(call IMG2SP, CONVERT , assets/menu-parts/francesc.png , 124, 8, spr_francesc))
$(eval $(call IMG2SP, CONVERT , assets/menu-parts/javier.png , 122, 8, spr_javier))

$(eval $(call IMG2SP, CONVERT , assets/menu-parts/pressspace.png , 116, 12, spr_space))

$(eval $(call IMG2SP, CONVERT , assets/menu-parts/insertcoin.png , 90, 12, spr_insert))
$(eval $(call IMG2SP, CONVERT , assets/menu-parts/credit0.png , 46, 12, spr_credit0))
$(eval $(call IMG2SP, CONVERT , assets/menu-parts/credit1.png , 46, 12, spr_credit1))

$(eval $(call IMG2SP, CONVERT , assets/menu-parts/continue.png , 82, 16, spr_continue))
$(eval $(call IMG2SP, CONVERT , assets/menu-parts/gameover.png , 110, 21, spr_gameover))

$(eval $(call IMG2SP, CONVERT , assets/star.png , 6, 1, spr_star))
$(eval $(call IMG2SP, CONVERT , assets/star2.png , 6, 1, spr_star2))
$(eval $(call IMG2SP, CONVERT , assets/star3.png , 4, 1, spr_star3))


$(eval $(call IMG2SP, CONVERT , assets/new-enemies/newdrone1.png , 12, 16, spr_newdrone1))
$(eval $(call IMG2SP, CONVERT , assets/new-enemies/newdrone2.png , 12, 16, spr_newdrone2))
$(eval $(call IMG2SP, CONVERT , assets/new-enemies/newdrone3.png , 12, 16, spr_newdrone3))

$(eval $(call IMG2SP, CONVERT , assets/new-enemies/knight1.png , 12, 16, spr_knight1))
$(eval $(call IMG2SP, CONVERT , assets/new-enemies/knight2.png , 12, 16, spr_knight2))
$(eval $(call IMG2SP, CONVERT , assets/new-enemies/knight3.png , 12, 16, spr_knight3))

$(eval $(call IMG2SP, CONVERT , assets/new-enemies/newrobot1.png , 12, 16, spr_newrobot1))
$(eval $(call IMG2SP, CONVERT , assets/new-enemies/newrobot2.png , 12, 16, spr_newrobot2))
$(eval $(call IMG2SP, CONVERT , assets/new-enemies/newrobot3.png , 12, 16, spr_newrobot3))

$(eval $(call IMG2SP, CONVERT , assets/new-enemies/newrobot2abierto.png , 12, 16, spr_newrobot4))

$(eval $(call IMG2SP, CONVERT , assets/new-enemies/ffirehs.png , 12, 16, spr_ffirehs))
$(eval $(call IMG2SP, CONVERT , assets/new-enemies/ffirehs_2.png , 12, 16, spr_ffirehs2))

$(eval $(call IMG2SP, SET_FOLDER, assets/screens/  ))
$(eval $(call IMG2SP, SET_IMG_FORMAT,screen))
$(eval $(call IMG2SP, SET_OUTPUT, bin ))  #{ bin, c }
$(eval $(call IMG2SP, CONVERT , assets/CONTROLSPOWERS2.png , 160, 200, controlspowers))	





##
## OLD MACROS (For compatibility)
##

## Example firmware palette definition as variable in cpct_img2tileset format

# PALETTE={0 1 3 4 7 9 10 12 13 16 19 20 21 24 25 26}

## AUTOMATED IMAGE CONVERSION EXAMPLE (Uncomment EVAL line to use)
##
##    This example would convert img/example.png into src/example.{c|h} files.
##    A C-array called pre_example[24*12*2] would be generated with the definition
##    of the image example.png in mode 0 screen pixel format, with interlaced mask.
##    The palette used for conversion is given through the PALETTE variable and
##    a pre_palette[16] array will be generated with the 16 palette colours as 
##	  hardware colour values.

#$(eval $(call IMG2SPRITES,img/example.png,0,pre,24,12,$(PALETTE),mask,src/,hwpalette))



############################################################################
##              DETAILED INSTRUCTIONS AND PARAMETERS                      ##
##------------------------------------------------------------------------##
##                                                                        ##
## Macro used for conversion is IMG2SPRITES, which has up to 9 parameters:##
##  (1): Image file to be converted into C sprite (PNG, JPG, GIF, etc)    ##
##  (2): Graphics mode (0,1,2) for the generated C sprite                 ##
##  (3): Prefix to add to all C-identifiers generated                     ##
##  (4): Width in pixels of each sprite/tile/etc that will be generated   ##
##  (5): Height in pixels of each sprite/tile/etc that will be generated  ##
##  (6): Firmware palette used to convert the image file into C values    ##
##  (7): (mask / tileset / zgtiles)                                       ##
##     - "mask":    generate interlaced mask for all sprites converted    ##
##     - "tileset": generate a tileset array with pointers to all sprites ##
##     - "zgtiles": generate tiles/sprites in Zig-Zag pixel order and     ##
##                  Gray Code row order                                   ##
##  (8): Output subfolder for generated .C/.H files (in project folder)   ##
##  (9): (hwpalette)                                                      ##
##     - "hwpalette": output palette array with hardware colour values    ##
## (10): Aditional options (you can use this to pass aditional modifiers  ##
##       to cpct_img2tileset)                                             ##
##                                                                        ##
## Macro is used in this way (one line for each image to be converted):   ##
##  $(eval $(call IMG2SPRITES,(1),(2),(3),(4),(5),(6),(7),(8),(9), (10))) ##
##                                                                        ##
## Important:                                                             ##
##  * Do NOT separate macro parameters with spaces, blanks or other chars.##
##    ANY character you put into a macro parameter will be passed to the  ##
##    macro. Therefore ...,src/sprites,... will represent "src/sprites"   ##
##    folder, whereas ...,  src/sprites,... means "  src/sprites" folder. ##
##                                                                        ##
##  * You can omit parameters but leaving them empty. Therefore, if you   ##
##  wanted to specify an output folder but do not want your sprites to    ##
##  have mask and/or tileset, you may omit parameter (7) leaving it empty ##
##     $(eval $(call IMG2SPRITES,imgs/1.png,0,g,4,8,$(PAL),,src/))        ##
############################################################################
