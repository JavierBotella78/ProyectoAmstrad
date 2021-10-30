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


.include "difficulty.h.s"


.include "../sys/ai.h.s"
.include "../sys/generator.h.s"




difficultyLvl:
    .db #0

difficultyArray:
    .dw #manDifficultyLvl0  ;;0
    .dw #manDifficultyLvl1  ;;2
    .dw #manDifficultyLvl2  ;;4
    .dw #manDifficultyLvl3  ;;6
    .dw #manDifficultyLvl4  ;;8
    .dw #manDifficultyLvl5  ;;10


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manDifficultyInit
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
manDifficultyInit::
    ld a, #0
    ld (difficultyLvl), a
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manDifficultyUpdate
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
manDifficultyUpdate::

    ld a, (#difficultyLvl)
    ld hl, #difficultyArray

    ld c, l
    ld e, #0

    add c
    ld l, a
    
    ld a, h
    adc e
    ld h, a

    ld e, (hl)
    inc hl
    ld d, (hl)

    ex de, hl
    
    ld bc, #endDifficultyUpdate
    push bc
    
    jp (hl)

endDifficultyUpdate:
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manDifficultyIncrease
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
manDifficultyIncrease::

    ld a, (#difficultyLvl)
    inc a
    inc a

    ld b, #MAXDIFFICULTYLVL
    cp b
    
    ret nc

    ld (#difficultyLvl), a

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manDifficultyLvl0
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
manDifficultyLvl0:

    ld a, #1
    call sysAISetAICounter
    ld a, #-1
    call sysAISetSpeedAILeft

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manDifficultyLvl1
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
manDifficultyLvl1:

    ld a, #0
    call sysAISetAICounter

     ld hl, #initEnemy7
    call sysGeneratorSetEnemy3

    ld a, #1
    call sysGeneratorSetBoolEnemy3Full

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manDifficultyLvl2
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
manDifficultyLvl2:

    ld hl, #initEnemy6
    call sysGeneratorSetEnemy3

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manDifficultyLvl3
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
manDifficultyLvl3:

    ld hl, #initEnemy4
    call sysGeneratorSetEnemy1

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manDifficultyLvl4
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
manDifficultyLvl4:

    ld hl, #initEnemy5
    call sysGeneratorSetEnemy2

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manDifficultyLvl5
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
manDifficultyLvl5:

    ld hl, #initEnemy7
    call sysGeneratorSetEnemy3

    ld a, #1
    call sysGeneratorSetBoolEnemy3Full

ret