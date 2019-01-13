type word* = uint32

type st_systick = object
  CTRL*: word
  LOAD*: word
  VAL*: word
  CALIB*: word

type st_rcc = object
  CR*: word
  CFGR*: word
  CIR*: word
  APB2RSTR*: word
  APB1RSTR*: word
  AHBENR*: word
  APB2ENR*: word
  APB1ENR*: word
  BDCR*: word
  CSR*: word
  AHBRSTR*: word
  CFGR2*: word
  CFGR3*: word

type st_gpio = object
  MODER*: word
  OTYPER*: word
  OSPEEDR*: word
  PUPDR*: word
  IDR*: word
  ODR*: word
  BSRR*: word
  LCKR*: word
  AFRL*: word
  AFRH*: word
  BRR*: word

type st_usart = object
  CR1*: word
  CR2*: word
  CR3*: word
  BRR*: word
  GTPR*: word
  RTOR*: word
  RQR*: word
  ISR*: word
  ICR*: word
  RDR*: word
  TDR*: word

type st_tim2_3_4 = object
  CR1*: word
  CR2*: word
  SMCR*: word
  DIER*: word
  SR*: word
  EGR*: word
  CCMR1*: word
  CCMR2*: word
  CCER*: word
  CNT*: word
  PSC*: word
  ARR*: word
  RSV1*: word
  CCR1*: word
  CCR2*: word
  CCR3*: word
  CCR4*: word
  RSV2: word
  DCR*: word
  DMAR*: word

type st_nvic = object
  ISER*: array[8, word]
  RSV1: array[24, word]
  ISCR*: array[8, word]
  RSV2: array[24, word]
  ISPR*: array[8, word]
  RSV3: array[24, word]
  ICPR*: array[8, word]
  RSV4: array[24, word]
  IABR*: array[8, word]
  RSV5: array[56, word]
  IP*: array[240, uint8]
  RSV6: array[644, word]
  STIR*: word

const pRCC = cast[pointer](0x4002_1000)
const pGPIOA = cast[pointer](0x4800_0000)
const pGPIOB = cast[pointer](0x4800_0400)
const pGPIOC = cast[pointer](0x4800_0800)
const pGPIOD = cast[pointer](0x4800_0C00)
const pGPIOF = cast[pointer](0x4800_1400)
const pUSART1 = cast[pointer](0x4001_3800)
const pNVIC = cast[pointer](0xE000_E100)
const pSysTick = cast[pointer](0xE000_E010)
const pTIM2 = cast[pointer](0x4000_0000)

const RCC* = cast[ptr st_rcc](pRCC)
const GPIOA* = cast[ptr st_gpio](pGPIOA)
const GPIOB* = cast[ptr st_gpio](pGPIOB)
const GPIOC* = cast[ptr st_gpio](pGPIOC)
const GPIOD* = cast[ptr st_gpio](pGPIOD)
const GPIOF* = cast[ptr st_gpio](pGPIOF)
const USART1* = cast[ptr st_usart](pUSART1)
const NVIC* = cast[ptr st_nvic](pNVIC)
const SysTick* = cast[ptr st_systick](pSysTick)
const TIM2* = cast[ptr st_tim2_3_4](pTIM2)

type IRQn* {.hint[XDeclaredButNotUsed]: off.} = enum
#*****  Cortex-M4 Processor Exceptions Numbers ***************************************************************
  NonMaskableInt_IRQn         = -14,    #!< 2 Non Maskable Interrupt
  HardFault_IRQn              = -13,    #!< 3 Cortex-M4 Hard Fault Interrupt
  MemoryManagement_IRQn       = -12,    #!< 4 Cortex-M4 Memory Management Interrupt
  BusFault_IRQn               = -11,    #!< 5 Cortex-M4 Bus Fault Interrupt
  UsageFault_IRQn             = -10,    #!< 6 Cortex-M4 Usage Fault Interrupt
  SVCall_IRQn                 = -5,     #!< 11 Cortex-M4 SV Call Interrupt
  DebugMonitor_IRQn           = -4,     #!< 12 Cortex-M4 Debug Monitor Interrupt
  PendSV_IRQn                 = -2,     #!< 14 Cortex-M4 Pend SV Interrupt
  SysTick_IRQn                = -1,     #!< 15 Cortex-M4 System Tick Interrupt
#*****  STM32 specific Interrupt Numbers *********************************************************************
  WWDG_IRQn                   = 0,      #!< Window WatchDog Interrupt
  PVD_IRQn                    = 1,      #!< PVD through EXTI Line detection Interrupt
  TAMP_STAMP_IRQn             = 2,      #!< Tamper and TimeStamp interrupts through the EXTI line 19
  RTC_WKUP_IRQn               = 3,      #!< RTC Wakeup interrupt through the EXTI line 20
  FLASH_IRQn                  = 4,      #!< FLASH global Interrupt
  RCC_IRQn                    = 5,      #!< RCC global Interrupt
  EXTI0_IRQn                  = 6,      #!< EXTI Line0 Interrupt
  EXTI1_IRQn                  = 7,      #!< EXTI Line1 Interrupt
  EXTI2_TSC_IRQn              = 8,      #!< EXTI Line2 Interrupt and Touch Sense Controller Interrupt
  EXTI3_IRQn                  = 9,      #!< EXTI Line3 Interrupt
  EXTI4_IRQn                  = 10,     #!< EXTI Line4 Interrupt
  DMA1_Channel1_IRQn          = 11,     #!< DMA1 Channel 1 Interrupt
  DMA1_Channel2_IRQn          = 12,     #!< DMA1 Channel 2 Interrupt
  DMA1_Channel3_IRQn          = 13,     #!< DMA1 Channel 3 Interrupt
  DMA1_Channel4_IRQn          = 14,     #!< DMA1 Channel 4 Interrupt
  DMA1_Channel5_IRQn          = 15,     #!< DMA1 Channel 5 Interrupt
  DMA1_Channel6_IRQn          = 16,     #!< DMA1 Channel 6 Interrupt
  DMA1_Channel7_IRQn          = 17,     #!< DMA1 Channel 7 Interrupt
  ADC1_2_IRQn                 = 18,     #!< ADC1 & ADC2 Interrupts
  CAN_TX_IRQn                 = 19,     #!< CAN TX Interrupt
  CAN_RX0_IRQn                = 20,     #!< CAN RX0 Interrupt
  CAN_RX1_IRQn                = 21,     #!< CAN RX1 Interrupt
  CAN_SCE_IRQn                = 22,     #!< CAN SCE Interrupt
  EXTI9_5_IRQn                = 23,     #!< External Line[9:5] Interrupts
  TIM1_BRK_TIM15_IRQn         = 24,     #!< TIM1 Break and TIM15 Interrupts
  TIM1_UP_TIM16_IRQn          = 25,     #!< TIM1 Update and TIM16 Interrupts
  TIM1_TRG_COM_TIM17_IRQn     = 26,     #!< TIM1 Trigger and Commutation and TIM17 Interrupt
  TIM1_CC_IRQn                = 27,     #!< TIM1 Capture Compare Interrupt
  TIM2_IRQn                   = 28,     #!< TIM2 global Interrupt
  TIM3_IRQn                   = 29,     #!< TIM3 global Interrupt
  I2C1_EV_IRQn                = 31,     #!< I2C1 Event Interrupt & EXTI Line23 Interrupt (I2C1 wakeup)
  I2C1_ER_IRQn                = 32,     #!< I2C1 Error Interrupt
  SPI1_IRQn                   = 35,     #!< SPI1 global Interrupt
  USART1_IRQn                 = 37,     #!< USART1 global Interrupt & EXTI Line25 Interrupt (USART1 wakeup)
  USART2_IRQn                 = 38,     #!< USART2 global Interrupt & EXTI Line26 Interrupt (USART2 wakeup)
  USART3_IRQn                 = 39,     #!< USART3 global Interrupt & EXTI Line28 Interrupt (USART3 wakeup)
  EXTI15_10_IRQn              = 40,     #!< External Line[15:10] Interrupts
  RTC_Alarm_IRQn              = 41,     #!< RTC Alarm (A and B) through EXTI Line 17 Interrupt
  TIM6_DAC1_IRQn              = 54,     #!< TIM6 global and DAC1 underrun error Interrupts
  TIM7_DAC2_IRQn              = 55,     #!< TIM7 global and DAC2 channel1 underrun error Interrupt
  COMP2_IRQn                  = 64,     #!< COMP2 global Interrupt via EXTI Line22
  COMP4_6_IRQn                = 65,     #!< COMP4 and COMP6 global Interrupt via EXTI Line30 and 32
  FPU_IRQn                    = 81,      #!< Floating point Interrupt

template st*[T: SomeInteger, U: SomeInteger](reg: T, val: U) =
  volatileStore(reg.addr, cast[T](val))

template ld*[T: SomeInteger](reg: T): T =
  volatileLoad(reg.addr)

template bit*[T: SomeInteger](n: varargs[T]): T =
  var ret: T = 0;
  for i in n:
    ret = ret or (1 shl i)
  ret

template shift*[T, U: SomeInteger](reg: T, n: U): T =
  reg shl n

template bset*[T, U: SomeInteger](reg: T, n :varargs[U]) =
  reg.st reg.ld or cast[T](bit(n))

template bclr*[T, U: SomeInteger](reg: T, n :varargs[U]) =
  reg.st reg.ld and not cast[T](bit(n))

template bitIsSet*[T, U: SomeInteger](reg: T, n: U): bool =
  (reg.ld and cast[T](bit(n))) != 0

template bitIsClr*[T, U: SomeInteger](reg: T, n: U): bool =
  not bitIsSet(reg, n)

template enableIRQ*(irq: IRQn) =
  NVIC.ISER[cast[int](irq) shr 5].st 1 shl (cast[int](irq) and 0x1F)

template disableIRQ*(irq: IRQn) =
  NVIC.ISCR[cast[int](irq) shr 5].st 1 shl (cast[int](irq) and 0x1F)

template setPriority*[T: SomeInteger](irq: IRQn, pri: T) =
  if cast[int](irq) >= 0: # TODO: implement for IRQn < 0
    NVIC.IP[cast[uint](irq)].st (cast[int](pri) shl 4) and 0xFF


when isMainModule:
  {.fatal: "This module must be imported for use, cannot run as a main module!".}
