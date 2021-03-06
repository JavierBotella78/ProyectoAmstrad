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
.include "input.h.s"
.include "render.h.s"
.include "prerender.h.s"
.include "physics.h.s"
.include "animations.h.s"
.include "generator.h.s"

.include "../man/game.h.s"
.include "../man/entity.h.s"

.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  VARIABLES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

changeRenderable::
    .db #0

playerY:
    .db #0

playerYTimer:
    .db #0

playerYSpeed:
    .db #0

playerOnAir:
    .db #0

boolPlayerOnAir:
    .db #0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysInputInit
;; Requisitos:
;;    ix -> Posicion inicial de memoria de la entidad
;; Return:
;;    -
;; Descripcion:
;;    Modifica la vx y/o vy de las entidades si se ha pulsado un boton 
;;
sysInputInit::

    ld a, #0
    ld (playerY), a

    ld a, #0
    ld (playerYTimer), a

    ld a, #0
    ld (playerYSpeed), a

    ld a, #0
    ld (playerOnAir), a

    ld a, #0
    ld (boolPlayerOnAir), a

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      UpdateOne
;; Requisitos:
;;    ix -> Posicion inicial de memoria de la entidad
;; Return:
;;    -
;; Descripcion:
;;    Modifica la vx y/o vy de las entidades si se ha pulsado un boton 
;;
sysInputUpdateOne:

    call sysInputChangeRenderable
    call sysInputChangeAnimation
    

    ld indVy(ix), #0

    ld a, (#playerYTimer)
    or a

    jr z, comprobarTeclas

    dec a
    ld (playerYTimer), a

    jp nz, noChangeOnAir
    
    ld a, #0
    ld (playerOnAir), a

    ld a, #1
    ld (boolPlayerOnAir), a

noChangeOnAir:
    call sysInputUpdatePlayerSpeed

    ret

comprobarTeclas:
    call cpct_scanKeyboard_asm

    ld hl, #Key_A
    call cpct_isKeyPressed_asm

    jr nz, sPulsada
    
    ld hl, #Key_Q
    call cpct_isKeyPressed_asm

    jr nz, wPulsada

    ld hl, #Joy0_Down
    call cpct_isKeyPressed_asm

    jr nz, sPulsada
    
    ld hl, #Joy0_Up
    call cpct_isKeyPressed_asm

    jr nz, wPulsada

    jp seguirComprobando

wPulsada:
    
    ld a, (#playerY)
    or a
    
    jp z, seguirComprobando

    dec a
    ld (playerY), a

    call sysInputGoUp

    jp seguirComprobando

sPulsada:

    ld a, (#playerY)
    ld b, #2
    cp b
    
    jp z, seguirComprobando

    inc a
    ld (playerY), a

    call sysInputGoDown

    jp seguirComprobando

kPulsada:

    call manGameBulletCreator

    ret

seguirComprobando:

    ld hl, #Key_P
    call cpct_isKeyPressed_asm

    jr nz, kPulsada

    ld hl, #Joy0_Fire1
    call cpct_isKeyPressed_asm

    jr nz, kPulsada

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysInputGoDown
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    - 
;;
sysInputGoDown:
    ld a, #inputSpeed
    ld (playerYSpeed), a

    call sysInputResetTimer

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysInputGoUp
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    - 
;;
sysInputGoUp:

    ld a, #-inputSpeed
    ld (playerYSpeed), a

    call sysInputResetTimer

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysInputUpdatePlayerSpeed
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    - 
;;
sysInputUpdatePlayerSpeed:

    ld a, (#playerYSpeed)
    ld indVy(ix), a

    call sysInputPostCheck

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysInputResetTimer
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    - 
;;
sysInputResetTimer:

    ld a, #4
    ld (playerYTimer), a

    ld a, #1        
    ld (playerOnAir), a

    ld a, #1        
    ld (boolPlayerOnAir), a

    call sysInputChangeAnimation
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysInputPostCheck
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    - 
;;
sysInputPostCheck:

    call sysPhysicsUpdateOne
    call sysPreRenderUpdateOne

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysInputChangeRenderable
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    - 
;;
sysInputChangeRenderable:

    ld a, (#changeRenderable)
    or a
    
    ret z

    ld a, #0
    ld (changeRenderable), a

    ld a, indType(ix)
    ld b, #ETypeRenderable
    xor b
    ld indType(ix), a

    call sysRenderBorrado

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysInputChangeAnimation
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    - 
;;
sysInputChangeAnimation:

    ld a, (#boolPlayerOnAir)
    or a
    
    ret z

    dec a
    ld (boolPlayerOnAir), a
    
    ld a, #1
    ld indAnimCounter(ix), a
    ld a, #0
    ld indAnimActual(ix), a
    ld a, #0
    ld indSubType(ix), a

    ld a, (#playerOnAir)
    or a
    
    jp nz, changeAnimationFly

    ld a, (#playerY)
    or a
    
    jp z, changeAnimationUpperFloor

    ;; Animation Floor
    ld a, #13
    ld indDelHeight(ix), a

    ld hl, #animationPlayer
    ld indAnim1(ix), h
    ld indAnim2(ix), l
    ld hl, #_spr_idle
    ld indSprite1(ix), h
    ld indSprite2(ix), l
    ld a, #RenderTypeStatic
    ld indSubType(ix), a


    ret 

    ;; Animation Upper Floor
changeAnimationUpperFloor:

    ld a, #16
    ld indDelHeight(ix), a

    ;; Animacion jetpack
    ld hl, #animationPlayerJetpack
    ld indAnim1(ix), h
    ld indAnim2(ix), l
    ld hl, #_spr_jetpack1
    ld indSprite1(ix), h
    ld indSprite2(ix), l
    ld a, #RenderTypeStatic
    ld indSubType(ix), a

ret
    ;; Animation Fly
changeAnimationFly:

    ld a, #16
    ld indDelHeight(ix), a

    ld b, #inputSpeed
    ld a, (#playerYSpeed)
    cp b

    jp z, animacionBajada
    ;;Animacion subida

    ld hl, #animationPlayerUp
    ld indAnim1(ix), h
    ld indAnim2(ix), l
    ld hl, #_spr_up1
    ld indSprite1(ix), h
    ld indSprite2(ix), l

    ret

animacionBajada:
    ;;Animacion bajada

    ld hl, #animationPlayerDown
    ld indAnim1(ix), h
    ld indAnim2(ix), l
    ld hl, #_spr_down1
    ld indSprite2(ix), h
    ld indSprite2(ix), l

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      Update
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inversion de control para la modificacion de posicion de todas las entidades.
sysInputUpdate::

    ld hl, #sysInputUpdateOne
    ld a, #ETypeInput
    call manEntityForAll

ret