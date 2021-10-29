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

    ret nc ;; No hay carry-> x de la bala < x del colisionable  

    inc a
    ld c, indWidth(iy)
    add a, c

    ld b, indX(ix)      ;; x de la bala
    cp b

    ret c ;; No hay carry-> x + width de colisionable < x de la bala


    ;; y dentro de rango?

    ld a, indY(iy)      ;; y del colisionable
    dec a
    ld b, indY(ix)      ;; y de la bala
    cp b

    ret nc ;; No hay carry-> y de la bala < y del colisionable  

    inc a
    ld c, indHeight(iy)
    add a, c

    cp b

    ret c ;; No hay carry-> x + width de colisionable < x de la bala

        ;;TODO: Hacer una beheaviour como en la ia, al colisionar pues pasan cosas

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


sysColisionsBehaviour:

    ld h, indColision1(ix)
    ld l, indColision2(ix)

    ld bc, #salirColision
    push bc

    jp (hl)

    salirColision:

ret

sysColisionsDestroy:

    call manEntityMarkToDestroy

ret

sysColisionsStar:

    call sysPreRenderUpdateOne

    ld b, #63
    ld indX(ix), b

    call sysPreRenderUpdateOne
    call sysRenderBorrado

ret

sysColisionsEnemy1:

    call sysGeneratorExp1
    call sysColisionsEnemy

ret

sysColisionsEnemy2:

    call sysGeneratorExp2
    call sysColisionsEnemy

ret

sysColisionsEnemy5:

    ld a, indSubType(ix)
    ld b, #AITypeInmortal
    and b

    ret z

    call sysColisionsEnemy2

ret

sysColisionsEnemy3:

    call sysGeneratorExp3
    call sysColisionsEnemy

ret

sysColisionsEnemy:

    call manEntityMarkToDestroy
    call manGameScore

ret

sysColisionsSubEnemy:

    call manEntityMarkToDestroy
    call manGameSubScore

ret

sysColisionsPlayer:

    ld b, #AITypeEnemy
    and b

    ret z           ;; Si es un enemigo, llama a la funcion

    call manGamePlayerColision

ret

sysColisionsBullet:

    ld b, #AITypePU
    and b

    ret nz       ;; Si es un power-up, NO llama a la funcion

    call sysColisionsDestroy

ret

sysColisionPUScore:

    ld b, #AITypeBullet
    and b

    ret nz       ;; Si es una bala, NO llama a la funcion

    call manGamePUScoreColision
    call manEntityMarkToDestroy

ret

sysColisionPUBullet:

    ld b, #AITypeBullet
    and b

    ret nz       ;; Si es una bala, NO llama a la funcion

    call manGamePUBulletColision
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