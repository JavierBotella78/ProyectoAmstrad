;;-----------------------------LICENSE NOTICE------------------------------------
;;  This file is part of Cosmic Gatlin: An Amstrad CPC Game 
;;  Authors: 
;;      Javier Botella Martínez (@javierbotella)
;;      Francesc Martinez Torregrosa (@mellamofrancesc)
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Lesser General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU Lesser General Public License for more details.
;;
;;  You should have received a copy of the GNU Lesser General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;------------------------------------------------------------------------------

.include "cpctelera.h.s"
.include "man/game.h.s"
.include "man/menu.h.s"
.include "man/interruptions.h.s"
.include "man/gameOver.h.s"
.include "banger.h.s"
.include "banger2.h.s"
.area _DATA
.area _CODE


.globl cpct_disableFirmware_asm

.globl cpct_akp_musicInit_asm


_main::

   call cpct_disableFirmware_asm

   call setManIr

   ld de, #_cancion2
   call cpct_akp_musicInit_asm

hardReset:
   call manMenuInit
   call manMenuLoop

softReset:
   call manGameInit
   call manGamePlay

   ld hl, #softReset
   call manGameOverInit
   call manGameOverLoop

jp hardReset

   


