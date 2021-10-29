.include "generator.h.s"
.include "animations.h.s"
.include "../man/entity.h.s"
.include "../man/game.h.s"


animationPlayer:
    .db #5                  ;;actual=0
    .dw #_spr_idle
    .db #5                  ;;actual=3
    .dw #_spr_idle2
    .db #0
    .dw #animationPlayer

animationPlayerJetpack:
    .db #5                  ;;actual=0
    .dw #_spr_jetpack1
    .db #5                  ;;actual=3
    .dw #_spr_jetpack2
    .db #5                  ;;actual=6
    .dw #_spr_jetpack3
    .db #0
    .dw #animationPlayer

animationPlayerDown:
    .db #10                  ;;actual=3
    .dw #_spr_down2
    .db #0
    .dw #animationPlayerDown

animationPlayerUp:
    .db #10                  ;;actual=3
    .dw #_spr_up2
    .db #0
    .dw #animationPlayerUp

animationEnemy1:
    .db #5                  ;;actual=0
    .dw #_spr_drone
    .db #5                  ;;actual=3
    .dw #_spr_drone2
    .db #0
    .dw #animationEnemy1

animationEnemy2:
    .db #5                 
    .dw #_spr_octo
    .db #5                 
    .dw #_spr_octo2
    .db #0
    .dw #animationEnemy2

animationEnemy3:
    .db #5               
    .dw #_spr_robo
    .db #5                  
    .dw #_spr_robo2
    .db #5                 
    .dw #_spr_robo3
    .db #0
    .dw #animationEnemy3

animationPUScore:
    .db #5                 
    .dw #_spr_doblescore1
    .db #5                 
    .dw #_spr_doblescore2
    .db #0
    .dw #animationPUScore

animationPUBullet:
    .db #5                 
    .dw #_spr_powerup1
    .db #5                 
    .dw #_spr_powerup2
    .db #5                 
    .dw #_spr_powerup3
    .db #5                 
    .dw #_spr_powerup4
    .db #5                 
    .dw #_spr_powerup5
    .db #5                 
    .dw #_spr_powerup6
    .db #5                 
    .dw #_spr_powerup7
    .db #5                 
    .dw #_spr_powerup8
    .db #0
    .dw #animationPUBullet

animationFloor1:
    .db #SpeedFloor1              
    .dw #_spr_floor1
    .db #SpeedFloor1                  
    .dw #_spr_floor2
    .db #SpeedFloor1                 
    .dw #_spr_floor3
    .db #0
    .dw #animationFloor1

animationFloor11:
    .db #SpeedFloor11               
    .dw #_spr_floor11
    .db #SpeedFloor11                  
    .dw #_spr_floor22
    .db #SpeedFloor11                 
    .dw #_spr_floor33
    .db #0
    .dw #animationFloor11

animationExplosion1:
    .db #SpeedExp                  
    .dw #_spr_explosion11
    .db #SpeedExp          
    .dw #_spr_explosion12
    .db #SpeedExp          
    .dw #_spr_explosion13
    .db #SpeedExp          
    .dw #_spr_explosion14

animationExplosion2:
    .db #SpeedExp                  
    .dw #_spr_explosion21
    .db #SpeedExp          
    .dw #_spr_explosion22
    .db #SpeedExp          
    .dw #_spr_explosion23
    .db #SpeedExp          
    .dw #_spr_explosion24

animationExplosion3:
    .db #SpeedExp                  
    .dw #_spr_explosion31
    .db #SpeedExp          
    .dw #_spr_explosion32
    .db #SpeedExp          
    .dw #_spr_explosion33
    .db #SpeedExp          
    .dw #_spr_explosion34


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAnimationsUpdateOne
;; Requisitos:
;;      ix -> Posicion inicial de memoria de la entidad colisionable
;; Return:
;;    -
;; Descripcion:
;;    Comprueba si dos entidades han colisionado o no
;;
sysAnimationsUpdateOne:

    dec indAnimCounter(ix)
    
    ret nz 

    ld a, indAnimActual(ix)
    ld b, #AnimSize
    add a, b
    ld indAnimActual(ix), a

loadAnim:

    ld h, indAnim1(ix)
    ld l, indAnim2(ix)
    ld b, #0
    ld c, indAnimActual(ix)

    add hl, bc      ;; hl=nextSprite

    ld a, (hl)
    or a
    
    jp z, resetAnim

    ld indAnimCounter(ix), a

    inc hl
    ld a, (hl)
    ld indSprite2(ix), a
    inc hl
    ld a, (hl)
    ld indSprite1(ix), a

    ret

resetAnim:

    ld indAnimActual(ix), #0
    jp loadAnim


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysAnimationsUpdate
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inversion de control para la colision de todas las entidades.
;;
sysAnimationsUpdate::

    ld hl, #sysAnimationsUpdateOne
    ld a, #ETypeAnimated
    call manEntityForAll

ret