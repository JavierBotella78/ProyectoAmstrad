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

InitMaxTime2Generate=25
MinTime2Generate=20

InitMinNumberEnemies=10
MaxNumberEnemies=30

SubTime2Generate=1
AddNumberEnemies=5

SpeedUp1=20
SpeedUp2=40

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  PUBLIC FUNCTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.globl sysGeneratorInit
.globl sysGeneratorInitGame
.globl sysGeneratorInitGameOver
.globl sysGeneratorInitGameOver2
.globl sysGeneratorInitMenu2
.globl sysGeneratorInitMenu
.globl sysGeneratorInitMenuCredit
.globl sysGeneratorMenuErase
.globl sysGeneratorMenuSpace
.globl sysGeneratorMenuInsertCoin
.globl sysGeneratorUpdate
.globl sysGeneratorBulletCreator
.globl sysGeneratorPU
.globl sysGeneratorExp1
.globl sysGeneratorExp2
.globl sysGeneratorExp3
.globl sysGeneratorExp4
.globl sysGeneratorStar

.globl sysGeneratorSetEnemy1
.globl sysGeneratorSetEnemy2
.globl sysGeneratorSetEnemy3
.globl sysGeneratorSetEnemy3Full
.globl sysGeneratorSetBoolEnemy3Full

.globl _spr_idle
.globl _spr_idle2
.globl _spr_down1
.globl _spr_down2
.globl _spr_up1
.globl _spr_up2

.globl _spr_jetpack1
.globl _spr_jetpack2
.globl _spr_jetpack3

.globl _spr_robo
.globl _spr_robo2
.globl _spr_robo3

.globl _spr_octo
.globl _spr_octo2

.globl _spr_drone
.globl _spr_drone2

.globl _spr_newdrone1
.globl _spr_newdrone2
.globl _spr_newdrone3

.globl _spr_knight1
.globl _spr_knight2
.globl _spr_knight3

.globl _spr_newrobot1
.globl _spr_newrobot2
.globl _spr_newrobot3
.globl _spr_newrobot4

.globl _spr_ffirehs
.globl _spr_ffirehs2

.globl _spr_doblescore1
.globl _spr_doblescore2

.globl _spr_powerup1
.globl _spr_powerup2
.globl _spr_powerup3
.globl _spr_powerup4
.globl _spr_powerup5
.globl _spr_powerup6
.globl _spr_powerup7
.globl _spr_powerup8

.globl _spr_floor1
.globl _spr_floor2
.globl _spr_floor3

.globl _spr_floor11
.globl _spr_floor22
.globl _spr_floor33

.globl _spr_rainbow
.globl _spr_wobniar

.globl _spr_hud_0
.globl _spr_hud_1
.globl _spr_hud_2
.globl _spr_hud_3

.globl _spr_stars0
.globl _spr_stars1
.globl _spr_stars2
.globl _spr_stars3
.globl _spr_stars4

.globl _spr_explosion10
.globl _spr_explosion11
.globl _spr_explosion12
.globl _spr_explosion13
.globl _spr_explosion14

.globl _spr_explosion20
.globl _spr_explosion21
.globl _spr_explosion22
.globl _spr_explosion23
.globl _spr_explosion24

.globl _spr_explosion30
.globl _spr_explosion31
.globl _spr_explosion32
.globl _spr_explosion33
.globl _spr_explosion34

.globl _spr_explosion40
.globl _spr_explosion41
.globl _spr_explosion42
.globl _spr_explosion43
.globl _spr_explosion44

.globl _spr_marcoleft
.globl _spr_marcoright 
.globl _spr_marcobot_0
.globl _spr_marcotop_0
.globl _spr_marcobot_1
.globl _spr_marcotop_1

.globl _spr_cosmic1
.globl _spr_gatlin
.globl _spr_hashtag
.globl _spr_highscore
.globl _spr_francesc
.globl _spr_javier
.globl _spr_insert
.globl _spr_credit0
.globl _spr_credit1

.globl _spr_continue
.globl _spr_gameover
.globl _spr_space
.globl _spr_star
.globl _spr_star2
.globl _spr_star3



.globl initStars
.globl initEnemy1
.globl initEnemy2
.globl initEnemy3
.globl initEnemy4
.globl initEnemy5
.globl initEnemy6
.globl initEnemy7