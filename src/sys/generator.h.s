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
.globl sysGeneratorUpdate
.globl sysGeneratorBulletCreator
.globl sysGeneratorPU

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

.globl initStars