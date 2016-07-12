MCU   =STM32F40xx
ARCH  =cortex-m4
PROJ_NAME = STM32F4

FPUFLAGS = -mthumb -mcpu=cortex-m4 -mfloat-abi=softfp -mfpu=fpv4-sp-d16

FLAGS   += $(FPUFLAGS) -Os -Wall -fno-strict-aliasing -fno-common
FLAGS	+= -ffunction-sections -fdata-sections -fno-builtin -Wimplicit-function-declaration
FLAGS	+= -D$(MCU)

MAKEFLAGS += -rR --include-dir=$(CURDIR)
MAKEFLAGS += --no-print-directory

CROSS_COMPILE_PATH	:= /work/STM32/gcc-arm-none-eabi-5_4-2016q2/bin/
export CROSS_COMPILE	?= $(CROSS_COMPILE_PATH)arm-none-eabi-
export AS		= $(CROSS_COMPILE)as
export LD		= $(CROSS_COMPILE)ld
export CC		= $(CROSS_COMPILE)gcc
export CPP		= $(CC) -E
export AR		= $(CROSS_COMPILE)ar
export NM		= $(CROSS_COMPILE)nm
export STRIP		= $(CROSS_COMPILE)strip
export OBJCOPY		= $(CROSS_COMPILE)objcopy
export OBJDUMP		= $(CROSS_COMPILE)objdump

export TOPDIR:= $(CURDIR)
export build := -f $(TOPDIR)/build.mk obj
export Q=@

cmsis-dir	= CMSIS/
driver-dir	= driver/
user-dir	= user/
freertos-dir= FreeRTOSv9.0.0/FreeRTOS/Source/

INCLUDE		= -I./CMSIS/Include -I./CMSIS/Device/ST/STM32F4xx/Include -I./driver/inc -I./user/inc	\
-I./$(freertos-dir)include -I./$(freertos-dir)portable/GCC/ARM_CM4F

export CFLAGS	:= $(FLAGS) $(INCLUDE)
export AFLAGS	:= $(FLAGS) $(INCLUDE)

LDFLAGS = $(ALLFLAGS) $(FPUFLAGS) --specs=nano.specs -lnosys -nostartfiles -u _printf_float -u _scanf_float 
LDFLAGS += -Wl,-TSTM32F407VGTx_FLASH.ld -Wl,--gc-sections
LDFLAGS += -Wl,-wrap=printf

cmsis-y		:=	$(patsubst %/, %/built-in.o, $(cmsis-dir))
driver-y	:=	$(patsubst %/, %/built-in.o, $(driver-dir))
user-y		:=	$(patsubst %/, %/built-in.o, $(user-dir))
freertos-y  :=  $(patsubst %/, %/built-in.o, $(freertos-dir))

all-target	:= $(cmsis-y) $(driver-y) $(user-y) $(freertos-y)

all: $(all-target)
	$(Q)$(CC) $(LDFLAGS) $^ -Wl,-Map=target.map -lm -o target
	@echo "Generate binary ..."
	$(OBJCOPY) -O binary target target.bin
	$(OBJCOPY) -O ihex target target.hex

$(all-target): FORCE
	$(Q)$(MAKE) $(build)=$(dir  $@)

clean:
	$(Q)find . -name "*.o" | xargs rm -rf
	$(Q)rm -rf target target.bin target.hex target.map

%:
	@echo $($@)
.PHONY: clean FORCE
