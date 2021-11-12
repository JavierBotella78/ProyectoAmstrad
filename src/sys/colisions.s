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


.include "colisions.h.s"
.include "generator.h.s"
.include "prerender.h.s"

.include "../man/entity.h.s"
.include "../man/game.h.s"
.include "render.h.s"

.globl _pew

.globl cpct_akp_SFXInit_asm
.globl cpct_akp_SFXPlay_asm
.globl cpct_akp_SFXStop_asm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionsUpdateOne
;; Requisitos:
;;      ix -> Posicion inicial de memoria de la entidad colisionable
;;      iy -> Posicion inicial de memoria de la entidad bala
;; Return:
;;    -
;; Descripcion:
;;    Comprueba si dos entidades han colisionado o no
;;
sysColisionsUpdateOne:

    ;; x dentro de rango?

    ld a, indX(iy)      ;; x del colisionable
    dec a

    push af

    ld a, indX(ix)      ;; x de la bala
    ld b, indWidth(ix)
    add a, b

    ld b, a

    pop af
    cp b

    ret nc ;; No hay carry-> x + width de la bala < x del colisionable  

    inc a
    ld c, indWidth(iy)
    add a, c

    ld b, indX(ix)      ;; x de la bala
    cp b

    ret c ;; No hay carry-> x + width de colisionable < x de la bala


    ;; y dentro de rango?

    ld a, indY(iy)      ;; y del colisionable
    dec a

    push af

    ld a, indY(ix)      ;; y de la bala
    ld b, indHeight(ix)
    add a, b

    ld b, a

    pop af


    cp b

    ret nc ;; No hay carry-> y + height de la bala < y del colisionable  

    inc a
    ld c, indHeight(iy)
    add a, c

    ld b, indY(ix)      ;; y de la bala
    cp b

    ret c ;; No hay carry-> y + height de colisionable < y de la bala

    ld a, indSubType(iy)
    
    call sysColisionsBehaviour

    ld a, indSubType(ix)

    push ix         ;; Switch ix and iy
    push iy
    pop ix
    
    call sysColisionsBehaviour

    push ix         ;; Switch ix and iy again
    pop iy
    pop ix

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionsBehaviour
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysColisionsBehaviour:

    ld h, indColision1(ix)
    ld l, indColision2(ix)

    ld bc, #salirColision
    push bc

    jp (hl)

    salirColision:

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionsDestroy
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysColisionsDestroy:

    call manEntityMarkToDestroy

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionsStar
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysColisionsStar:

    call sysPreRenderUpdateOne

    ld b, #63
    ld indX(ix), b

    call sysPreRenderUpdateOne
    call sysRenderBorrado

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionsEnemy1
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysColisionsEnemy1:

    call sysGeneratorExp1
    call sysColisionsEnemy

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionsEnemy2
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysColisionsEnemy2:

    call sysGeneratorExp2
    call sysColisionsEnemy

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionsEnemy3
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysColisionsEnemy3:

    call sysGeneratorExp3
    call sysColisionsEnemy

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionsEnemy5
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysColisionsEnemy5:

    ld a, indSubType(ix)
    ld b, #AITypeInmortal
    and b

    ret z

    call sysColisionsEnemy2

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionsEnemy7
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysColisionsEnemy7:

    ld a, #0
    call sysGeneratorSetEnemy3Full

    call sysColisionsEnemy3

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionsEnemyBullet
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysColisionsEnemyBullet:

    call sysGeneratorExp4
    call sysColisionsEnemy

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionsEnemy
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysColisionsEnemy:

    call manEntityMarkToDestroy
    call manGameScore

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionsSubEnemy
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysColisionsSubEnemy:

    call manEntityMarkToDestroy
    call manGameSubScore
    call manGamePlayerColision

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionsPlayer
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysColisionsPlayer:

    ld b, #AITypeEnemy
    and b

    ret z           ;; Si es un enemigo, llama a la funcion

    call manGamePlayerColision

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionsBullet
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysColisionsBullet:

    ld b, #AITypePU
    and b

    ret nz       ;; Si es un power-up, NO llama a la funcion

    call sysColisionsDestroy

    ld de, #_pew
   call cpct_akp_SFXInit_asm

   ld l, #1
   ld h, #15
   ld e, #45
   ld d, #0
   ld bc,#0
   ld a, #10
   push ix 
   call cpct_akp_SFXPlay_asm
   pop ix 

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionPUScore
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysColisionPUScore:

    ld b, #AITypeBullet
    and b

    ret nz       ;; Si es una bala, NO llama a la funcion

    call manGamePUScoreColision
    call manEntityMarkToDestroy

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionPUBullet
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysColisionPUBullet:

    ld b, #AITypeBullet
    and b

    ret nz       ;; Si es una bala, NO llama a la funcion

    call manGamePUBulletColision
    call manEntityMarkToDestroy

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionPUScore
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysColisionPULife:

    ld b, #AITypeBullet
    and b

    ret nz       ;; Si es una bala, NO llama a la funcion

    call manGamePULifeColision
    call manEntityMarkToDestroy

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysColisionsUpdate
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inversion de control para la colision de todas las entidades.
;;
sysColisionsUpdate::

    ld hl, #sysColisionsUpdateOne
    ld a, #ETypeColider
    ld b, #ETypeColisionable
    call manEntityForAllMatching

ret