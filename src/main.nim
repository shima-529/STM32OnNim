import stm32
import volatile

proc ms_wait[T: SomeInteger](ms: T) =
  SysTick.LOAD.st 1000 - 1
  SysTick.VAL.st 0
  SysTick.CTRL.st SysTick.CTRL.ld or 1
  for _ in 1.T..ms:
    while (SysTick.CTRL.ld and (1 shl 16)) == 0: discard
  SysTick.CTRL.st SysTick.CTRL.ld and (not (1.word shl 0))

proc mainProc1() {.used.} =
  RCC.AHBENR.st RCC.AHBENR.ld or (1 shl 17)
  GPIOA.MODER.st GPIOA.MODER.ld or (1 shl 0)
  while true:
    for i in 0..20:
      GPIOA.ODR.st 1
      i.ms_wait
      GPIOA.ODR.st 0
      (20-i).ms_wait
    for i in 0..20:
      GPIOA.ODR.st 1
      (20-i).ms_wait
      GPIOA.ODR.st 0
      i.ms_wait

proc mainProc2() {.used.} =
  RCC.AHBENR.st RCC.AHBENR.ld or (1 shl 17)
  GPIOA.MODER.st GPIOA.MODER.ld or (1 shl 0)
  RCC.APB1ENR.st RCC.APB1ENR.ld or 1
  TIM2.CR1.st (1 shl 0) or (1 shl 7) # counter enable
  TIM2.DIER.st (1 shl 0) or (1 shl 1) # interrupt on CC1 & Update
  TIM2.PSC.st 8000
  TIM2.ARR.st 1000
  TIM2.CCR1.st 500
  TIM2.EGR.st 1
  NVIC.ISER[28 shr 5].st (1 shl (28 and 0x1F))
  while true:
    discard


proc TIM2_IRQHandler {.exportc.} =
  if (TIM2.SR.ld and (1 shl 1)) != 0:
    GPIOA.ODR.st 1
    TIM2.SR.st TIM2.SR.ld and (not (1.word shl 1))
  if (TIM2.SR.ld and (1 shl 0)) != 0:
    GPIOA.ODR.st 0
    TIM2.SR.st TIM2.SR.ld and (not (1.word shl 0))

mainProc2()
