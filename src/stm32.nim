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
const pGPIOB = cast[pointer](0x4800_4000)
const pGPIOC = cast[pointer](0x4800_8000)
const pGPIOD = cast[pointer](0x4800_C000)
const pGPIOF = cast[pointer](0x4801_4000)
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

template st*[T: SomeInteger, U: SomeInteger](reg: T, val: U) =
  volatileStore(reg.addr, val)

template ld*[T: SomeInteger](reg: T): T =
  volatileLoad(reg.addr)

template bit*[T: SomeInteger](n: T): T =
  1 shl n

template shift*[T, U: SomeInteger](reg: T, n: U): T =
  reg shl n

template bset*[T, U: SomeInteger](reg: T, n :U) =
  reg.st reg.ld or cast[T](bit(n))

template bclr*[T, U: SomeInteger](reg: T, n :U) =
  reg.st reg.ld and not cast[T](bit(n))

when isMainModule:
  {.fatal: "This module must be imported for use, cannot run as a main module!"}
