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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  CONSTANTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; ENTITY INFO
EntitySize=28 
EntityArraySize=40
EntityArrayBytesSize=EntitySize*EntityArraySize

Fila1=40
Fila2=Fila1+40
Fila3=Fila2+40

Offset=12+1

EFila1=Fila1-Offset
EFila2=Fila2-Offset
EFila3=Fila3-Offset

    ;; INDEX FOR IX/IY
indType=0
indX=1
indY=2
indVx=3
indVy=4
indWidth=5
indHeight=6
indAI2=7
indAI1=8
indColision2=9
indColision1=10
indPhysics2=11
indPhysics1=12
indSprite2=13
indSprite1=14
indPrevPos2=15
indPrevPos1=16
indScore=17
indSubType=18
indAnim2=19
indAnim1=20
indAnimCounter=21
indAnimActual=22
indActualPos2=23
indActualPos1=24
indAICounter=25
indDelWitdh=26
indDelHeight=27

    ;; ENTITY TYPES
ETypeInvalid=0x00
ETypeRenderable=0x01
ETypeMovable=0x02
ETypeInput=0x04
ETypeAI=0x08
ETypeColisionable=0x10
ETypeColider=0x20
ETypeAnimated=0x40
ETypeDead=0x80
ETypeDefault=0x7f

AITypeEnemy=0x01
AITypePU=0x02
AITypeBullet=0x04
AITypeInmortal=0x08

RenderTypeStatic=0x08


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  PUBLIC FUNCTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.globl manEntityInit
.globl manEntityCreate
.globl manEntityDestroy
.globl manEntityMarkToDestroy
.globl manEntityDestroyDead
.globl manEntityForAll
.globl manEntityForAllMatching
.globl getFreeSpace
.globl getNextFreeEntity