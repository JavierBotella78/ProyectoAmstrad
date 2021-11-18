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

.include "generator.h.s"
.include "cpctelera.h.s"

.include "../man/entity.h.s"
.include "../man/game.h.s"
.include "../man/difficulty.h.s"
.include "assets/screens/controlspowers.h.s"
.include "assets/screens/youwin.h.s"

.include "ai.h.s"
.include "colisions.h.s"
.include "prerender.h.s"
.include "render.h.s"
.include "animations.h.s"

.globl cpct_memcpy_asm
.globl cpct_getRandom_mxor_u8_asm
.globl cpct_getScreenPtr_asm
.globl cpct_drawSolidBox_asm
.globl cpct_zx7b_decrunch_s_asm
.globl _controlspowers
.globl _youwin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  VARIABLES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

minTime2Generate:
    .db #InitMaxTime2Generate

time2Generate:
    .db #InitMaxTime2Generate

maxNumberEnemies:
    .db #InitMinNumberEnemies

numberEnemies:
    .db #InitMinNumberEnemies

speedUp:
   .db #SpeedUp1


enemy1:
   .dw #initEnemy1

enemy2:
   .dw #initEnemy2

enemy3:
   .dw #initEnemy3

boolEnemy3full:
   .db #0

enemy3full:
   .db #0

lastGenerated:
   .db #0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  TEMPLATES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

initPlayer: 
   .db #ETypeRenderable | #ETypeInput | #ETypeColider | #ETypeAnimated    ;; Type
   .db #10, #EFila1, #0, #0                                             ;; x, y, vx, vy
   .db #4, #16                                                          ;; width, height
   .dw #0                                                               ;; AI
   .dw #sysColisionsPlayer, #sysColisionsPlayer                         ;; Colision, Physics
   .dw #_spr_jetpack1, #0xc000                                              ;; Sprite, prevPos
   .db #0, #0                                         ;; score, subtype
   .dw #animationPlayerJetpack                                                 ;; Anim
   .db #5, #0                                                           ;; AnimCounter, AnimActual
   .dw #0xc000                                                          ;; actualPos
   .db #0                                                               ;; AICounter
   .db #4, #16                                                          ;; delWitdh, delHeight

initStar: 
   .db #ETypeRenderable | #ETypeMovable   ;; Type
   .db #63, #5, #-2, #0                                                                   ;; x, y, vx, vy
   .db #3, #1                                                                             ;; width, height
   .dw #0                                                                                 ;; AI
   .dw #0, #sysColisionsStar                                                              ;; Colision, Physics
   .dw #_spr_star, #0xc000                                                                ;; Sprite, prevPos
   .db #0, #RenderTypeStatic                                                              ;; score, subtype
   .dw #0                                                                                 ;; Anim
   .db #0, #0                                                                             ;; AnimCounter, AnimActual
   .dw #0xc000                                                          ;; actualPos
   .db #0                                                                                 ;; AICounter
   .db #3, #1                                                                             ;; delWitdh, delHeight

initStar2: 
   .db #ETypeRenderable | #ETypeMovable   ;; Type
   .db #63, #5, #-2, #0                                                                   ;; x, y, vx, vy
   .db #3, #1                                                                             ;; width, height
   .dw #0                                                                                 ;; AI
   .dw #0, #sysColisionsStar                                                              ;; Colision, Physics
   .dw #_spr_star2, #0xc000                                                                ;; Sprite, prevPos
   .db #0, #RenderTypeStatic                                                              ;; score, subtype
   .dw #0                                                                                 ;; Anim
   .db #0, #0                                                                             ;; AnimCounter, AnimActual
   .dw #0xc000                                                          ;; actualPos
   .db #0                                                                                 ;; AICounter
   .db #3, #1                                                                             ;; delWitdh, delHeight

initStar3: 
   .db #ETypeRenderable | #ETypeMovable   ;; Type
   .db #63, #5, #-1, #0                                                                   ;; x, y, vx, vy
   .db #2, #1                                                                             ;; width, height
   .dw #0                                                                                 ;; AI
   .dw #0, #sysColisionsStar                                                              ;; Colision, Physics
   .dw #_spr_star3, #0xc000                                                                ;; Sprite, prevPos
   .db #0, #RenderTypeStatic                                                              ;; score, subtype
   .dw #0                                                                                 ;; Anim
   .db #0, #0                                                                             ;; AnimCounter, AnimActual
   .dw #0xc000                                                          ;; actualPos
   .db #0                                                                                 ;; AICounter
   .db #2, #1                                                                             ;; delWitdh, delHeight

initEnemy1: 
   .db #ETypeRenderable | #ETypeAI | #ETypeMovable | #ETypeColisionable | #ETypeAnimated  ;; Type
   .db #63, #EFila1, #0, #0                                                               ;; x, y, vx, vy
   .db #6, #16                                                                            ;; width, height
   .dw #sysAIEnemy1                                                                       ;; AI
   .dw #sysColisionsEnemy1, #sysColisionsSubEnemy                                           ;; Colision, Physics
   .dw #_spr_drone, #0xc000                                                               ;; Sprite, prevPos
   .db #0x10, #AITypeEnemy | #RenderTypeStatic                                             ;; score, subtype
   .dw #animationEnemy1                                                                   ;; Anim
   .db #5, #0                                                                             ;; AnimCounter, AnimActual
   .dw #0xc000                                                          ;; actualPos
   .db #0                                                                                 ;; AICounter
   .db #6, #16                                                                            ;; delWitdh, delHeight

initEnemy2: 
   .db #ETypeRenderable | #ETypeAI | #ETypeMovable | #ETypeColisionable | #ETypeAnimated  ;; Type
   .db #63, #EFila2, #0, #0                                                               ;; x, y, vx, vy
   .db #5, #16                                                                            ;; width, height
   .dw #sysAIEnemy2                                                                       ;; AI
   .dw #sysColisionsEnemy2, #sysColisionsSubEnemy                                           ;; Colision, Physics
   .dw #_spr_octo, #0xc000                                                                ;; Sprite, prevPos
   .db #0x10, #AITypeEnemy | #RenderTypeStatic                                             ;; score, subtype
   .dw #animationEnemy2                                                                   ;; Anim
   .db #5, #0                                                                             ;; AnimCounter, AnimActual
   .dw #0xc000                                                          ;; actualPos
   .db #0                                                                                 ;; AICounter
   .db #5, #13                                                                            ;; delWitdh, delHeight

initEnemy3: 
   .db #ETypeRenderable | #ETypeAI | #ETypeMovable | #ETypeColisionable | #ETypeAnimated  ;; Type
   .db #63, #EFila3, #0, #0                                                               ;; x, y, vx, vy
   .db #6, #16                                                                            ;; width, height
   .dw #sysAIEnemy3                                                                       ;; AI
   .dw #sysColisionsEnemy3, #sysColisionsSubEnemy                                           ;; Colision, Physics
   .dw #_spr_robo, #0xc000                                                                ;; Sprite, prevPos
   .db #0x10, #AITypeEnemy | #RenderTypeStatic                                              ;; score, subtype
   .dw #animationEnemy3                                                                   ;; Anim
   .db #5, #0                                                                             ;; AnimCounter, AnimActual
   .dw #0xc000                                                          ;; actualPos
   .db #0                                                                                 ;; AICounter
   .db #6, #13                                                                            ;; delWitdh, delHeight

initEnemy4: 
   .db #ETypeRenderable | #ETypeAI | #ETypeMovable | #ETypeColisionable | #ETypeAnimated  ;; Type
   .db #63, #EFila1, #0, #0                                                               ;; x, y, vx, vy
   .db #6, #16                                                                            ;; width, height
   .dw #sysAIEnemy1                                                                      ;; AI
   .dw #sysColisionsEnemy1, #sysColisionsSubEnemy                                           ;; Colision, Physics
   .dw #_spr_newdrone1, #0xc000                                                                ;; Sprite, prevPos
   .db #0x20, #AITypeEnemy | #RenderTypeStatic                                              ;; score, subtype
   .dw #animationEnemy4                                                                   ;; Anim
   .db #5, #0                                                                             ;; AnimCounter, AnimActual
   .dw #0xc000                                                          ;; actualPos
   .db #0                                                                                 ;; AICounter
   .db #6, #16 

initEnemy5: 
   .db #ETypeRenderable | #ETypeAI | #ETypeMovable | #ETypeColisionable | #ETypeAnimated  ;; Type
   .db #63, #EFila2, #0, #0                                                               ;; x, y, vx, vy
   .db #6, #16                                                                            ;; width, height
   .dw #sysAIEnemy5_1                                                                       ;; AI
   .dw #sysColisionsEnemy5, #sysColisionsSubEnemy                                         ;; Colision, Physics
   .dw #_spr_knight2, #0xc000                                                             ;; Sprite, prevPos
   .db #0x30, #AITypeEnemy | #RenderTypeStatic | #AITypeInmortal                                          ;; score, subtype
   .dw #animationEnemy5_1                                                                 ;; Anim
   .db #5, #0                                                                             ;; AnimCounter, AnimActual
   .dw #0xc000                                                                            ;; actualPos
   .db #20                                                                                 ;; AICounter
   .db #6, #13 

initEnemy6: 
   .db #ETypeRenderable | #ETypeAI | #ETypeMovable | #ETypeColisionable | #ETypeAnimated  ;; Type
   .db #63, #EFila3, #0, #0                                                               ;; x, y, vx, vy
   .db #6, #16                                                                            ;; width, height
   .dw #sysAIEnemy6_1                                                                     ;; AI
   .dw #sysColisionsEnemy3, #sysColisionsSubEnemy                                         ;; Colision, Physics
   .dw #_spr_newrobot1, #0xc000                                                           ;; Sprite, prevPos
   .db #0x30, #AITypeEnemy | #RenderTypeStatic                                            ;; score, subtype
   .dw #animationEnemy6_1                                                                 ;; Anim
   .db #5, #0                                                                             ;; AnimCounter, AnimActual
   .dw #0xc000                                                                            ;; actualPos
   .db #20                                                                                ;; AICounter
   .db #6, #13 


initEnemy7: 
   .db #ETypeRenderable | #ETypeAI | #ETypeMovable | #ETypeColisionable | #ETypeAnimated  ;; Type
   .db #63, #EFila3, #0, #0                                                               ;; x, y, vx, vy
   .db #6, #16                                                                            ;; width, height
   .dw #sysAIEnemy7_1                                                                     ;; AI
   .dw #sysColisionsEnemy7, #sysColisionsSubEnemy                                         ;; Colision, Physics
   .dw #_spr_ffirehs, #0xc000                                                             ;; Sprite, prevPos
   .db #0x45, #AITypeEnemy | #RenderTypeStatic                                            ;; score, subtype
   .dw #animationEnemy7                                                                   ;; Anim
   .db #5, #0                                                                             ;; AnimCounter, AnimActual
   .dw #0xc000                                                                            ;; actualPos
   .db #6                                                                                 ;; AICounter
   .db #6, #13 

initExp1: 
   .db #ETypeRenderable | #ETypeAI | #ETypeAnimated                     ;; Type 
   .db #0, #0, #0, #0                                                   ;; x, y, vx, vy
   .db #4, #16                                                          ;; width, height
   .dw #sysAIExplosion                                                  ;; AI
   .dw #0, #0                                                           ;; Colision, Physics
   .dw #_spr_explosion10, #0xc000                                        ;; Sprite, prevPos
   .db #0, #RenderTypeStatic                                            ;; score, subtype
   .dw #animationExplosion1                                             ;; Anim
   .db #2, #0                                                           ;; AnimCounter, AnimActual
   .dw #0xc000                                                          ;; actualPos
   .db #10                                                              ;; AICounter
   .db #4, #16                                                          ;; delWitdh, delHeight

initExp2: 
   .db #ETypeRenderable | #ETypeAI | #ETypeAnimated                     ;; Type 
   .db #0, #0, #0, #0                                                   ;; x, y, vx, vy
   .db #4, #16                                                          ;; width, height
   .dw #sysAIExplosion                                                  ;; AI
   .dw #0, #0                                                           ;; Colision, Physics
   .dw #_spr_explosion20, #0xc000                                        ;; Sprite, prevPos
   .db #0, #RenderTypeStatic                                            ;; score, subtype
   .dw #animationExplosion2                                              ;; Anim
   .db #2, #0                                                           ;; AnimCounter, AnimActual
   .dw #0xc000                                                          ;; actualPos
   .db #10                                                              ;; AICounter
   .db #4, #13                                                          ;; delWitdh, delHeight

initExp3: 
   .db #ETypeRenderable | #ETypeAI | #ETypeAnimated                     ;; Type 
   .db #0, #0, #0, #0                                                   ;; x, y, vx, vy
   .db #4, #16                                                          ;; width, height
   .dw #sysAIExplosion                                                  ;; AI
   .dw #0, #0                                                           ;; Colision, Physics
   .dw #_spr_explosion30, #0xc000                                        ;; Sprite, prevPos
   .db #0, #RenderTypeStatic                                            ;; score, subtype
   .dw #animationExplosion3                                              ;; Anim
   .db #2, #0                                                           ;; AnimCounter, AnimActual
   .dw #0xc000                                                          ;; actualPos
   .db #10                                                              ;; AICounter
   .db #4, #13                                                          ;; delWitdh, delHeight

initExp4: 
   .db #ETypeRenderable | #ETypeAI | #ETypeAnimated                     ;; Type 
   .db #0, #0, #0, #0                                                   ;; x, y, vx, vy
   .db #2, #8                                                          ;; width, height
   .dw #sysAIExplosion2                                                ;; AI
   .dw #0, #0                                                           ;; Colision, Physics
   .dw #_spr_explosion40, #0xc000                                        ;; Sprite, prevPos
   .db #0, #RenderTypeStatic                                            ;; score, subtype
   .dw #animationExplosion4                                              ;; Anim
   .db #2, #0                                                           ;; AnimCounter, AnimActual
   .dw #0xc000                                                          ;; actualPos
   .db #10                                                              ;; AICounter
   .db #2, #5                                                          ;; delWitdh, delHeight

initBullet: 
   .db #ETypeRenderable | #ETypeColider | #ETypeMovable                 ;; Type 
   .db #13, #0, #2, #0                                                  ;; x, y, vx, vy
   .db #6, #4                                                           ;; width, height
   .dw #0                                                               ;; AI
   .dw #sysColisionsBullet, #sysColisionsDestroy                        ;; Colision, Physics
   .dw #_spr_rainbow, #0xc000                                           ;; Sprite, prevPos
   .db #0, #AITypeBullet | #RenderTypeStatic                            ;; score, subtype
   .dw #0                                                               ;; Anim
   .db #0, #0                                                           ;; AnimCounter, AnimActual
   .dw #0xc000                                                          ;; actualPos
   .db #0                                                               ;; AICounter
   .db #6, #4                                                           ;; delWitdh, delHeight

initEnemyBullet: 
   .db #ETypeRenderable | #ETypeColisionable | #ETypeMovable | #ETypeAI ;; Type 
   .db #50, #EFila3+8, #0, #0                                           ;; x, y, vx, vy
   .db #6, #4                                                           ;; width, height
   .dw #sysAIEnemyBullet                                                ;; AI
   .dw #sysColisionsEnemyBullet, #sysColisionsSubEnemy                  ;; Colision, Physics
   .dw #_spr_wobniar, #0xc000                                           ;; Sprite, prevPos
   .db #0x25, #AITypeEnemy | #RenderTypeStatic                             ;; score, subtype
   .dw #0                                                               ;; Anim
   .db #0, #0                                                           ;; AnimCounter, AnimActual
   .dw #0xc000                                                          ;; actualPos
   .db #0                                                               ;; AICounter
   .db #6, #4                                                           ;; delWitdh, delHeight

initPUBullet: 
   .db #ETypeRenderable | #ETypeColisionable | #ETypeMovable | #ETypeAnimated ;; Type     
   .db #0, #0, #-1, #0                                                        ;; x, y, vx, vy
   .db #5, #12                                                                ;; width, height
   .dw #0                                                                     ;; AI
   .dw #sysColisionPUBullet, #sysColisionsDestroy                             ;; Colision, Physics
   .dw #_spr_powerup1, #0xc000                                                ;; Sprite, prevPos
   .db #0, #AITypePU | #RenderTypeStatic                                      ;; score, subtype
   .dw #animationPUBullet                                                     ;; Anim
   .db #5, #0                                                                 ;; AnimCounter, AnimActual
   .dw #0xc000                                                          ;; actualPos
   .db #0                                                                     ;; AICounter
   .db #5, #12                                                                ;; delWitdh, delHeight

initPUScore: 
   .db #ETypeRenderable | #ETypeColisionable | #ETypeMovable | #ETypeAnimated ;; Type    
   .db #0, #0, #-1, #0                                                        ;; x, y, vx, vy
   .db #5, #12                                                                ;; width, height
   .dw #0                                                                     ;; AI
   .dw #sysColisionPUScore, #sysColisionsDestroy                              ;; Colision, Physics
   .dw #_spr_doblescore1, #0xc000                                             ;; Sprite, prevPos
   .db #0, #AITypePU | #RenderTypeStatic                                      ;; score, subtype
   .dw #animationPUScore                                                      ;; Anim
   .db #5, #0                                                                 ;; AnimCounter, AnimActual
   .dw #0xc000                                                          ;; actualPos
   .db #0                                                                     ;; AICounter
   .db #5, #12                                                                ;; delWitdh, delHeight

initPULife: 
   .db #ETypeRenderable | #ETypeColisionable | #ETypeMovable | #ETypeAnimated ;; Type    
   .db #0, #0, #-1, #0                                                        ;; x, y, vx, vy
   .db #5, #13                                                                ;; width, height
   .dw #0                                                                     ;; AI
   .dw #sysColisionPULife, #sysColisionsDestroy                               ;; Colision, Physics
   .dw #_spr_life1, #0xc000                                             ;; Sprite, prevPos
   .db #0, #AITypePU | #RenderTypeStatic                                      ;; score, subtype
   .dw #animationPULife                                                   ;; Anim
   .db #5, #0                                                                 ;; AnimCounter, AnimActual
   .dw #0xc000                                                          ;; actualPos
   .db #0                                                                     ;; AICounter
   .db #5, #13                                                                ;; delWitdh, delHeight

initInterf: 
   .db #ETypeRenderable       ;; Type  
   .db #0, #144, #0, #0       ;; x, y, vx, vy
   .db #20, #56               ;; width, height
   .dw #0                     ;; AI
   .dw #0, #0                 ;; Colision, Physics
   .dw #_spr_hud_0, #0xc000   ;; Sprite, prevPos

initInterf2: 
   .db #ETypeRenderable       ;; Type  
   .db #20, #144, #0, #0      ;; x, y, vx, vy
   .db #20, #56               ;; width, height
   .dw #0                     ;; AI
   .dw #0, #0                 ;; Colision, Physics
   .dw #_spr_hud_1, #0xc000   ;; Sprite, prevPos

initInterf3: 
   .db #ETypeRenderable       ;; Type  
   .db #40, #144, #0, #0      ;; x, y, vx, vy
   .db #20, #56               ;; width, height
   .dw #0                     ;; AI
   .dw #0, #0                 ;; Colision, Physics
   .dw #_spr_hud_2, #0xc000   ;; Sprite, prevPos

initInterf4: 
   .db #ETypeRenderable       ;; Type  
   .db #60, #144, #0, #0      ;; x, y, vx, vy
   .db #20, #56               ;; width, height
   .dw #0                     ;; AI
   .dw #0, #0                 ;; Colision, Physics
   .dw #_spr_hud_3, #0xc000   ;; Sprite, prevPos

initFloor1: 
   .db #ETypeRenderable | #ETypeAnimated  ;; Type
   .db #0, #Fila3, #0, #0                 ;; x, y, vx, vy
   .db #40, #11                           ;; width, height
   .dw #0                                 ;; AI
   .dw #0, #0                             ;; Colision, Physics
   .dw #_spr_floor1, #0xc000              ;; Sprite, prevPos
   .db #0, #RenderTypeStatic              ;; score, subtype
   .dw #animationFloor1                   ;; Anim
   .db #5, #0                             ;; AnimCounter, AnimActual

initFloor2: 
   .db #ETypeRenderable | #ETypeAnimated  ;; Type
   .db #0, #Fila2, #0, #0                 ;; x, y, vx, vy
   .db #40, #11                           ;; width, height
   .dw #0                                 ;; AI
   .dw #0, #0                             ;; Colision, Physics
   .dw #_spr_floor11, #0xc000             ;; Sprite, prevPos
   .db #0, #RenderTypeStatic              ;; score, subtype
   .dw #animationFloor11                  ;; Anim
   .db #5, #0                             ;; AnimCounter, AnimActual

initStars:
   .db #ETypeRenderable       ;; Type  
   .db #60, #144, #0, #0      ;; x, y, vx, vy
   .db #20, #56               ;; width, height
   .dw #0                     ;; AI
   .dw #0, #0                 ;; Colision, Physics
   .dw #_spr_stars0, #0xc000   ;; Sprite, prevPos

initMenuBorderVertical: 
   .db #ETypeRenderable          ;; Type  
   .db #0, #0, #0, #0            ;; x, y, vx, vy
   .db #3, #200                 ;; width, height
   .dw #0                        ;; AI
   .dw #0, #0                    ;; Colision, Physics
   .dw #_spr_marcoleft, #0xc000  ;; Sprite, prevPos

initMenuBorderHorizontal: 
   .db #ETypeRenderable          ;; Type  
   .db #0, #0, #0, #0            ;; x, y, vx, vy
   .db #37, #12                  ;; width, height
   .dw #0                        ;; AI
   .dw #0, #0                    ;; Colision, Physics
   .dw #_spr_marcotop_0, #0xc000   ;; Sprite, prevPos

initMenuCosmic: 
   .db #ETypeRenderable          ;; Type  
   .db #0, #0, #0, #0            ;; x, y, vx, vy
   .db #31, #11                  ;; width, height
   .dw #0                        ;; AI
   .dw #0, #0                    ;; Colision, Physics
   .dw #_spr_cosmic1, #0xc000   ;; Sprite, prevPos


initMenuGatlin: 
   .db #ETypeRenderable          ;; Type  
   .db #0, #0, #0, #0            ;; x, y, vx, vy
   .db #42, #14                  ;; width, height
   .dw #0                        ;; AI
   .dw #0, #0                    ;; Colision, Physics
   .dw #_spr_gatlin, #0xc000   ;; Sprite, prevPos

initMenuHashtag: 
   .db #ETypeRenderable          ;; Type  
   .db #0, #0, #0, #0            ;; x, y, vx, vy
   .db #34, #8                  ;; width, height
   .dw #0                        ;; AI
   .dw #0, #0                    ;; Colision, Physics
   .dw #_spr_hashtag, #0xc000   ;; Sprite, prevPos

initMenuHighscore: 
   .db #ETypeRenderable          ;; Type  
   .db #0, #0, #0, #0            ;; x, y, vx, vy
   .db #41, #8                  ;; width, height
   .dw #0                        ;; AI
   .dw #0, #0                    ;; Colision, Physics
   .dw #_spr_highscore, #0xc000   ;; Sprite, prevPos

initMenuFrancesc: 
   .db #ETypeRenderable          ;; Type  
   .db #0, #0, #0, #0            ;; x, y, vx, vy
   .db #62, #8                  ;; width, height
   .dw #0                        ;; AI
   .dw #0, #0                    ;; Colision, Physics
   .dw #_spr_francesc, #0xc000   ;; Sprite, prevPos

initMenuJavier: 
   .db #ETypeRenderable          ;; Type  
   .db #0, #0, #0, #0            ;; x, y, vx, vy
   .db #61, #8                  ;; width, height
   .dw #0                        ;; AI
   .dw #0, #0                    ;; Colision, Physics
   .dw #_spr_javier, #0xc000   ;; Sprite, prevPos

initInsertCoin: 
   .db #ETypeRenderable          ;; Type  
   .db #0, #0, #0, #0            ;; x, y, vx, vy
   .db #45, #12                 ;; width, height
   .dw #0                        ;; AI
   .dw #0, #0                    ;; Colision, Physics
   .dw #_spr_insert, #0xc000   ;; Sprite, prevPos

initCredit0: 
   .db #ETypeRenderable          ;; Type  
   .db #0, #0, #0, #0            ;; x, y, vx, vy
   .db #23, #12                 ;; width, height
   .dw #0                        ;; AI
   .dw #0, #0                    ;; Colision, Physics
   .dw #_spr_credit0, #0xc000   ;; Sprite, prevPos

initCredit1: 
   .db #ETypeRenderable          ;; Type  
   .db #0, #0, #0, #0            ;; x, y, vx, vy
   .db #23, #12                 ;; width, height
   .dw #0                        ;; AI
   .dw #0, #0                    ;; Colision, Physics
   .dw #_spr_credit1, #0xc000   ;; Sprite, prevPos

initContinue: 
   .db #ETypeRenderable          ;; Type  
   .db #0, #0, #0, #0            ;; x, y, vx, vy
   .db #41, #16                ;; width, height
   .dw #0                        ;; AI
   .dw #0, #0                    ;; Colision, Physics
   .dw #_spr_continue, #0xc000   ;; Sprite, prevPos

initGameOver: 
   .db #ETypeRenderable          ;; Type  
   .db #0, #0, #0, #0            ;; x, y, vx, vy
   .db #55, #21                  ;; width, height
   .dw #0                        ;; AI
   .dw #0, #0                    ;; Colision, Physics
   .dw #_spr_gameover, #0xc000   ;; Sprite, prevPos

initSpace: 
   .db #ETypeRenderable          ;; Type  
   .db #0, #0, #0, #0            ;; x, y, vx, vy
   .db #58, #12                  ;; width, height
   .dw #0                        ;; AI
   .dw #0, #0                    ;; Colision, Physics
   .dw #_spr_space, #0xc000   ;; Sprite, prevPos


sysGeneratorInit::

   ld a, #InitMaxTime2Generate
   ld (minTime2Generate), a

   ld a, #InitMaxTime2Generate
   ld (time2Generate), a

   ld a, #InitMinNumberEnemies
   ld (maxNumberEnemies), a

   ld a, #InitMinNumberEnemies
   ld (numberEnemies), a

   ld a, #SpeedUp1
   ld (speedUp), a

   ld hl, #initEnemy1
   ld (enemy1), hl

   ld hl, #initEnemy2
   ld (enemy2), hl

   ld hl, #initEnemy3
   ld (enemy3), hl

   ld a, #0
   ld (enemy3full), a

   ld a, #0
   ld (boolEnemy3full), a

ret

sysGeneratorStar::

   ld ix, #initStar
   ld indY(ix), a
   ld indX(ix), b
   ld hl, #initStar 
   call sysGeneratorTmpl

ret

sysGeneratorStar2::

   ld ix, #initStar2
   ld indY(ix), a
   ld indX(ix), b
   ld hl, #initStar2 
   call sysGeneratorTmpl

ret

sysGeneratorStar3::

   ld ix, #initStar3
   ld indY(ix), a
   ld indX(ix), b
   ld hl, #initStar3
   call sysGeneratorTmpl

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysGeneratorInitGame
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;
;;
sysGeneratorInitGame::

   ld a, #5
   ld b, #40
   call sysGeneratorStar3

   ld a, #10
   ld b, #15
   call sysGeneratorStar3

   ld a, #15
   ld b, #60
   call sysGeneratorStar

   ld a, #20
   ld b, #5
   call sysGeneratorStar3
   
   ld a, #30
   ld b, #50
   call sysGeneratorStar

   ld a, #35
   ld b, #20
   call sysGeneratorStar2

   ld a, #40
   ld b, #40
   call sysGeneratorStar

   ld a, #45
   ld b, #30
   call sysGeneratorStar3

     ld a, #50
   ld b, #70
   call sysGeneratorStar

   ld a, #55
   ld b, #10
   call sysGeneratorStar
   
   

   ld ix, #initFloor1
   ld a, #0
   ld indX(ix), a
   ld hl, #initFloor1 
   call sysGeneratorTmpl

   ld ix, #initFloor2
   ld a, #0
   ld indX(ix), a
   ld hl, #initFloor2 
   call sysGeneratorTmpl

   ld ix, #initFloor1
   ld a, #40
   ld indX(ix), a
   ld hl, #initFloor1 
   call sysGeneratorTmpl

   ld ix, #initFloor2
   ld a, #40
   ld indX(ix), a
   ld hl, #initFloor2 
   call sysGeneratorTmpl

   ld hl, #initPlayer
   call sysGeneratorTmpl

   ;;DIBUJADO INICIAL DE LA INTERFAZ
   ld ix, #initInterf
   call sysRenderDrawOnce

   ld ix, #initInterf2
   call sysRenderDrawOnce

   ld ix, #initInterf3
   call sysRenderDrawOnce

   ld ix, #initInterf4
   call sysRenderDrawOnce

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysGeneratorInitGameOver
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;
;;
sysGeneratorInitGameOver::

   cpctm_clearScreen_asm 0

   call sysGeneratorDrawBorder

   ld ix, #initContinue
   ld indX(ix), #20
   ld indY(ix), #55
   call sysRenderDrawOnce

   ld ix, #initInsertCoin
   ld indX(ix), #17
   ld indY(ix), #125
   call sysRenderDrawOnce

   ld ix, #initCredit0
   ld indX(ix), #28
   ld indY(ix), #145
   call sysRenderDrawOnce


ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysGeneratorInitGameOver2
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;
;;
sysGeneratorInitGameOver2::

   cpctm_clearScreen_asm 0

   call sysGeneratorDrawBorder

   ld ix, #initGameOver
   ld indX(ix), #12
   ld indY(ix), #90
   call sysRenderDrawOnce

ret



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysGeneratorInitMenu
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;
;;
sysGeneratorInitMenu::

   call sysGeneratorDrawBorder



   ld ix, #initMenuHashtag
   ld indX(ix), #23
   ld indY(ix), #18
   call sysRenderDrawOnce



   ld ix, #initMenuCosmic
   ld indX(ix), #24
   ld indY(ix), #33
   call sysRenderDrawOnce

   ld ix, #initMenuGatlin
   ld indX(ix), #19
   ld indY(ix), #48
   call sysRenderDrawOnce



   ld ix, #initMenuHighscore
   ld indX(ix), #10
   ld indY(ix), #90
   call sysRenderDrawOnce
   
   call manGameGetHighscore
   call sysRenderScore



   ld ix, #initInsertCoin
   ld indX(ix), #17
   ld indY(ix), #125
   call sysRenderDrawOnce

   ld ix, #initCredit0
   ld indX(ix), #28
   ld indY(ix), #145
   call sysRenderDrawOnce



   ld ix, #initMenuJavier
   ld indX(ix), #10
   ld indY(ix), #165
   call sysRenderDrawOnce

   ld ix, #initMenuFrancesc
   ld indX(ix), #10
   ld indY(ix), #177
   call sysRenderDrawOnce


ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysGeneratorInitMenuCredit
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;
;;
sysGeneratorInitMenuCredit::

   ld ix, #initSpace
   ld indX(ix), #11
   ld indY(ix), #125
   call sysRenderDrawOnce

   ld ix, #initCredit1
   ld indX(ix), #28
   ld indY(ix), #145
   call sysRenderDrawOnce

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysGeneratorMenuSpace
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;
;;
sysGeneratorMenuSpace::

   ld ix, #initSpace
   ld indX(ix), #11
   ld indY(ix), #125
   call sysRenderDrawOnce

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysGeneratorMenuInsertCoin
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;
;;
sysGeneratorMenuInsertCoin::

   ld ix, #initInsertCoin
   ld indX(ix), #17
   ld indY(ix), #125
   call sysRenderDrawOnce

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysGeneratorMenuErase
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;
;;
sysGeneratorMenuErase::

   ld de, #0xC000
   ld c, #11
   ld b, #125

   call cpct_getScreenPtr_asm

   ex de, hl
   ld a, #0
   ld c, #58
   ld b, #12

   call cpct_drawSolidBox_asm

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysGeneratorInitMenu2
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;
;;

sysGeneratorInitMenu2::

   cpctm_clearScreen_asm 0
   ld    hl, #_controlspowers_end
   ld    de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysGeneratorInitMenu2
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;
;;
sysGeneratorInitYouWin::

   cpctm_clearScreen_asm 0
   ld    hl, #_youwin_end
   ld    de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm

ret


sysGeneratorDrawBorder:

   ld ix, #initMenuBorderVertical
   ld indX(ix), #0
   ld hl, #_spr_marcoleft
   ld indSprite1(ix), h
   ld indSprite2(ix), l
   call sysRenderDrawOnce

   ld ix, #initMenuBorderVertical
   ld indX(ix), #77
   ld hl, #_spr_marcoright
   ld indSprite1(ix), h
   ld indSprite2(ix), l
   call sysRenderDrawOnce

   ld ix, #initMenuBorderHorizontal
   ld indX(ix), #3
   ld indY(ix), #188
   ld hl, #_spr_marcobot_0
   ld indSprite1(ix), h
   ld indSprite2(ix), l
   call sysRenderDrawOnce

   ld ix, #initMenuBorderHorizontal
   ld indX(ix), #40
   ld hl, #_spr_marcobot_1
   ld indSprite1(ix), h
   ld indSprite2(ix), l
   call sysRenderDrawOnce

   ld ix, #initMenuBorderHorizontal
   ld indX(ix), #3
   ld indY(ix), #0
   ld hl, #_spr_marcotop_0
   ld indSprite1(ix), h
   ld indSprite2(ix), l
   call sysRenderDrawOnce

   ld ix, #initMenuBorderHorizontal
   ld indX(ix), #40
   ld hl, #_spr_marcotop_1
   ld indSprite1(ix), h
   ld indSprite2(ix), l
   call sysRenderDrawOnce

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysGeneratorUpdate
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;
;;
sysGeneratorUpdate::

   ld a, (#time2Generate)
   dec a
   ld (#time2Generate), a

   ret nz                     ;; Si no da 0, no genera enemigos

   ld a, (#minTime2Generate)
   ld (#time2Generate), a


   ld a, (#numberEnemies)
   or a
   
   jp nz, skipResetEnemies           ;; Si no quedan enemigos por generar, aumenta la dificultad

   ld a, (#maxNumberEnemies)
   ld c, #MaxNumberEnemies
   cp c

   jp z, skipToDifficultyIncrease

   ld b, #AddNumberEnemies
   add a, b

;; CAMBIO DE DIFICULTAD----------------------------------------------------------------------------------
skipToDifficultyIncrease:
   push af

   call manDifficultyIncrease
   call manDifficultyUpdate

   pop af
   
skipToTimer:
   ld (numberEnemies), a
   ld (maxNumberEnemies), a

   ld a, (#minTime2Generate)
   ld c, #MinTime2Generate
   cp c

   jp z, skipToEnemies

   ld b, #SubTime2Generate
   sub a, b

skipToEnemies:
   ld (minTime2Generate), a
   ld (time2Generate), a

skipResetEnemies:

   ld a, (#numberEnemies)
   dec a
   ld (#numberEnemies), a

   call sysGeneratorEnemy

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Tmpl
;; Parameters:
;;    hl -> Entity template
;; Return:
;;    -
;; Description:
;;    Creates an entity from a template
;;
sysGeneratorTmpl:

   push ix
   call getNextFreeEntity


   push hl
   call manEntityCreate  

   ex de, hl
   pop hl
   ld bc, #EntitySize

   call cpct_memcpy_asm

   call sysPreRenderUpdateOne

   pop ix

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Enemy
;; Parameters:
;;    hl -> Entity template
;; Return:
;;    -
;; Description:
;;    Creates an entity from a template
;;
sysGeneratorEnemy:

   call cpct_getRandom_mxor_u8_asm

   ld a, #3
   and l

   or a
   
   jp z, escero
   dec a

escero:
   push af

   ld a, (#lastGenerated)
   ld b, a
   
   pop af

   cp b

   jp nz, noGenerarOtro

   inc a
   and #3

   ld b, #3

   cp b
   
   jp nz, noGenerarOtro

   ld a, #0


noGenerarOtro:
   ld (#lastGenerated), a
   or a

   jp nz, generateEnemy2

   ld hl, (#enemy1)

   jp sysGeneratorEnemyCall

generateEnemy2:

   dec a
   
   jp nz, generateEnemy3

   ld hl, (#enemy2)

   jp sysGeneratorEnemyCall

generateEnemy3:

   ld a, (#enemy3full)
   or a

   jp nz, enemy3bullet

   ld hl, (#enemy3)

   ld a, (#boolEnemy3full)
   or a

   jp z, sysGeneratorEnemyCall

   ld a, #1
   ld (enemy3full), a

   jp sysGeneratorEnemyCall

enemy3bullet:

   ld hl, #initEnemyBullet

sysGeneratorEnemyCall:
   call sysGeneratorTmpl

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    PU
;; Parameters:
;;    ix -> Enemy that drops power-ups
;; Return:
;;    -
;; Description:
;;    Creates an entity power-up
;;
sysGeneratorPU::

   call cpct_getRandom_mxor_u8_asm

   ld a, #31
   and l

   or a

   jp nz, generatePU2

   ld hl, #initPUBullet
   ld iy, #initPUBullet

   jp sysGeneratorPUCall

generatePU2:

   dec a
   
   jp nz, generatePU3

   ld hl, #initPUBullet
   ld iy, #initPUBullet

   jp sysGeneratorPUCall


generatePU3:

   dec a
   
   jp nz, generatePU4

   ld hl, #initPUScore
   ld iy, #initPUScore

   jp sysGeneratorPUCall

generatePU4:

   dec a
   
   jp nz, generatePU5

   ld hl, #initPUScore
   ld iy, #initPUScore

   jp sysGeneratorPUCall

generatePU5:

   dec a
   
   ret nz

   ld hl, #initPULife
   ld iy, #initPULife

sysGeneratorPUCall:

   ld a, indX(ix)
   ld indX(iy), a

   ld a, indY(ix)
   ld indY(iy), a

   call sysGeneratorTmpl

ret

sysGeneratorExp1::

   ld iy, #initExp1

   ld a, indX(ix)
   ld indX(iy), a

   ld a, indY(ix)
   ld indY(iy), a

   ld hl, #initExp1
   call sysGeneratorTmpl

ret

sysGeneratorExp2::

   ld iy, #initExp2

   ld a, indX(ix)
   ld indX(iy), a

   ld a, indY(ix)
   ld indY(iy), a

   ld hl, #initExp2
   call sysGeneratorTmpl

ret

sysGeneratorExp3::

   ld iy, #initExp3

   ld a, indX(ix)
   ld indX(iy), a

   ld a, indY(ix)
   ld indY(iy), a

   ld hl, #initExp3
   call sysGeneratorTmpl

ret

sysGeneratorExp4::

   ld iy, #initExp4

   ld a, indX(ix)
   ld indX(iy), a

   ld a, indY(ix)
   ld indY(iy), a

   ld hl, #initExp4
   call sysGeneratorTmpl

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    BulletCreator
;; Parameters:
;;    ix -> Player entity
;; Return:
;;    -
;; Description:
;;    Creates a bullet-type entity at the player's vertical position
;;
sysGeneratorBulletCreator::

   ld iy, #initBullet

   ld a, indY(ix)
   ld b, #8
   add a, b
   ld indY(iy), a 

   ld hl, #initBullet

   call sysGeneratorTmpl

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    sysGeneratorSetEnemy1
;; Parameters:
;;    -
;; Return:
;;    -
;; Description:
;;    -
;;
sysGeneratorSetEnemy1::
   ld (enemy1), hl
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    sysGeneratorSetEnemy2
;; Parameters:
;;    -
;; Return:
;;    -
;; Description:
;;    -
;;
sysGeneratorSetEnemy2::
   ld (enemy2), hl
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    sysGeneratorSetEnemy3
;; Parameters:
;;    -
;; Return:
;;    -
;; Description:
;;    -
;;
sysGeneratorSetEnemy3::
   ld (enemy3), hl
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    sysGeneratorSetEnemy3Full
;; Parameters:
;;    -
;; Return:
;;    -
;; Description:
;;    -
;;
sysGeneratorSetEnemy3Full::

   ld (enemy3full), a

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    sysGeneratorSetEnemy3Full
;; Parameters:
;;    -
;; Return:
;;    -
;; Description:
;;    -
;;
sysGeneratorSetBoolEnemy3Full::

   ld (boolEnemy3full), a

ret