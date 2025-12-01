################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CC_SRCS += \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/ceva_common.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/conv.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/depthwise_conv.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/fully_connected.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/logistic.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/quantize.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/softmax.cc 

CC_DEPS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/ceva_common.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/conv.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/depthwise_conv.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/fully_connected.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/logistic.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/quantize.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/softmax.d 

OBJS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/ceva_common.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/conv.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/depthwise_conv.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/fully_connected.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/logistic.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/quantize.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/softmax.o 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/%.o Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/%.su Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/%.cyclo: ../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/%.cc Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F746xx -c -I../Core/Inc -I../Middlewares/Third_Party/tensorflow -I../FATFS/Target -I../FATFS/App -I../USB_HOST/App -I../USB_HOST/Target -I../Drivers/STM32F7xx_HAL_Driver/Inc -I../Drivers/STM32F7xx_HAL_Driver/Inc/Legacy -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I../Middlewares/Third_Party/FatFs/src -I../Middlewares/ST/STM32_USB_Host_Library/Core/Inc -I../Middlewares/ST/STM32_USB_Host_Library/Class/CDC/Inc -I../Drivers/CMSIS/Device/ST/STM32F7xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-kernels-2f-ceva

clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-kernels-2f-ceva:
	-$(RM) ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/ceva_common.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/ceva_common.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/ceva_common.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/ceva_common.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/conv.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/conv.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/conv.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/conv.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/depthwise_conv.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/depthwise_conv.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/depthwise_conv.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/depthwise_conv.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/fully_connected.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/fully_connected.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/fully_connected.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/fully_connected.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/logistic.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/logistic.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/logistic.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/logistic.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/quantize.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/quantize.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/quantize.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/quantize.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/softmax.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/softmax.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/softmax.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/ceva/softmax.su

.PHONY: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-kernels-2f-ceva

