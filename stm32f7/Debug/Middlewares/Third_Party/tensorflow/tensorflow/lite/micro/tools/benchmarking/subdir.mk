################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CC_SRCS += \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/generic_model_benchmark.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/metrics.cc 

CC_DEPS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/generic_model_benchmark.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/metrics.d 

OBJS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/generic_model_benchmark.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/metrics.o 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/%.o Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/%.su Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/%.cyclo: ../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/%.cc Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F746xx -c -I../Core/Inc -I../FATFS/Target -I../FATFS/App -I../USB_HOST/App -I../USB_HOST/Target -I../Drivers/STM32F7xx_HAL_Driver/Inc -I../Drivers/STM32F7xx_HAL_Driver/Inc/Legacy -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I../Middlewares/Third_Party/FatFs/src -I../Middlewares/ST/STM32_USB_Host_Library/Core/Inc -I../Middlewares/ST/STM32_USB_Host_Library/Class/CDC/Inc -I../Drivers/CMSIS/Device/ST/STM32F7xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-tools-2f-benchmarking

clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-tools-2f-benchmarking:
	-$(RM) ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/generic_model_benchmark.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/generic_model_benchmark.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/generic_model_benchmark.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/generic_model_benchmark.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/metrics.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/metrics.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/metrics.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tools/benchmarking/metrics.su

.PHONY: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-tools-2f-benchmarking

