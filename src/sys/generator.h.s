;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  CONSTANTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

InitMaxTime2Generate=20
MinTime2Generate=15

InitMinNumberEnemies=10
MaxNumberEnemies=50

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
.globl sysGeneratorInitMenu
.globl sysGeneratorUpdate
.globl sysGeneratorBulletCreator
.globl sysGeneratorPU
.globl sysGeneratorExp1
.globl sysGeneratorExp2
.globl sysGeneratorExp3

.globl _spr_idle

.globl _spr_robo
.globl _spr_robo2
.globl _spr_robo3

.globl _spr_octo
.globl _spr_octo2

.globl _spr_drone
.globl _spr_drone2

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

.globl _spr_hud_0
.globl _spr_hud_1
.globl _spr_hud_2
.globl _spr_hud_3

.globl _spr_stars0
.globl _spr_stars1
.globl _spr_stars2
.globl _spr_stars3

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

.globl _spr_marcoleft
.globl _spr_marcoright 
.globl _spr_marcobot_0
.globl _spr_marcotop_0
.globl _spr_marcobot_1
.globl _spr_marcotop_1

.globl _spr_cosmic1
.globl _spr_gatlin
.globl _spr_hashtag
.globl _spr_francesc
.globl _spr_javier

.globl initStars