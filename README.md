# STM32 on Nim
This repository aims at the working of STM32 on Nim language. Moreover, the startup routine leaves to be written on Nim without assembly.

# What is implemented
- I/O registers
	- `RCC`
	- `USART1`
	- `GPIOA` .. `GPIOE`
	- `TIM2`
	- `SysTick`
	- `NVIC`
- `volatile` function templates
	- `ld()` for volatile load
		- e.g.) `GPIOA.ODR.ld` for getting the value
	- `st()` for volatile store
		- e.g.) `GPIOA.ODR.st 1` for loading 1 to GPIOA.ODR

# Complile
```bash
$ nim cc -c --cpu=arm --d:release --gc:none --os:standalone --deadCodeElim:on src/main.nim
$ make
$ make flash
```

If you want to use UART for programming, don't type `make flash` and use flash programmers you like.
