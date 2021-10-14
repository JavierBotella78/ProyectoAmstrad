;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  CONSTANTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; ENTITY INFO
EntitySize=25 
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