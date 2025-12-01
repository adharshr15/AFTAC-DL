################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CC_SRCS += \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/keyword_benchmark.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/keyword_benchmark_8bit.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/person_detection_benchmark.cc 

CC_DEPS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/keyword_benchmark.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/keyword_benchmark_8bit.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/person_detection_benchmark.d 

OBJS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/keyword_benchmark.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/keyword_benchmark_8bit.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/person_detection_benchmark.o 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/%.o Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/%.su Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/%.cyclo: ../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/%.cc Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F746xx '-DCMSIS_DEVICE_ARM_CORTEX_M_XX_HEADER_FILE="stm32f7xx.h"' -c -I../Core/Inc -I../Middlewares/Third_Party/tensorflow/third_party -I../Middlewares/Third_Party/tensorflow/gemmlowp -I../Middlewares/Third_Party/tensorflow/third_party/flatbuffers/include -I../Middlewares/Third_Party/tensorflow -I../FATFS/Target -I../FATFS/App -I../USB_HOST/App -I../USB_HOST/Target -I../Drivers/STM32F7xx_HAL_Driver/Inc -I../Drivers/STM32F7xx_HAL_Driver/Inc/Legacy -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I../Middlewares/Third_Party/FatFs/src -I../Middlewares/ST/STM32_USB_Host_Library/Core/Inc -I../Middlewares/ST/STM32_USB_Host_Library/Class/CDC/Inc -I../Drivers/CMSIS/Device/ST/STM32F7xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-benchmarks

clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-benchmarks:
	-$(RM) ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/keyword_benchmark.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/keyword_benchmark.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/keyword_benchmark.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/keyword_benchmark.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/keyword_benchmark_8bit.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/keyword_benchmark_8bit.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/keyword_benchmark_8bit.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/keyword_benchmark_8bit.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/person_detection_benchmark.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/person_detection_benchmark.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/person_detection_benchmark.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/benchmarks/person_detection_benchmark.su

.PHONY: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-benchmarks

