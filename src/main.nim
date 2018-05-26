import stm32
import volatile

proc ms_wait[T: SomeInteger](ms: T) =
  SysTick.LOAD.st 1000 - 1
  SysTick.VAL.st 0
  SysTick.CTRL.bset 0
  for _ in 1.T..ms:
    while SysTick.CTRL.bitIsClr(16): discard
  SysTick.CTRL.bclr 0

proc mainProc1() {.used.} =
  RCC.AHBENR.bset 17
  GPIOA.MODER.bset 0
  while true:
    for i in 0..20:
      GPIOA.ODR.bset 0
      i.ms_wait
      GPIOA.ODR.bclr 0
      (20-i).ms_wait
    for i in 0..20:
      GPIOA.ODR.bset 0
      (20-i).ms_wait
      GPIOA.ODR.bclr 0
      i.ms_wait

proc mainProc2() {.used.} =
  RCC.AHBENR.bset(17)
  GPIOA.MODER.bset(0)
  RCC.APB1ENR.bset(0)
  TIM2.CR1.bset(0, 7) # counter enable
  TIM2.DIER.bset(0, 1) # interrupt on CC1 & Update
  TIM2.PSC.st 8000
  TIM2.ARR.st 1000
  TIM2.CCR1.st 500
  TIM2.EGR.bset(0)
  NVIC.ISER[28 shr 5].bset(28 and 0x1F)
  while true:
    discard


proc TIM2_IRQHandler {.exportc.} =
  if TIM2.SR.bitIsSet(1):
    GPIOA.ODR.bclr(0)
    TIM2.SR.bclr(1)
  if TIM2.SR.bitIsSet(0):
    GPIOA.ODR.bset(0)
    TIM2.SR.bclr(0)

mainProc1()
