################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CC_SRCS += \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/flatbuffer_conversions_bridge.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/micro_error_reporter.cc 

CC_DEPS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/flatbuffer_conversions_bridge.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/micro_error_reporter.d 

OBJS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/flatbuffer_conversions_bridge.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/micro_error_reporter.o 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/%.o Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/%.su Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/%.cyclo: ../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/%.cc Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F746xx -c -I../Core/Inc -I../FATFS/Target -I../FATFS/App -I../USB_HOST/App -I../USB_HOST/Target -I../Drivers/STM32F7xx_HAL_Driver/Inc -I../Drivers/STM32F7xx_HAL_Driver/Inc/Legacy -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I../Middlewares/Third_Party/FatFs/src -I../Middlewares/ST/STM32_USB_Host_Library/Core/Inc -I../Middlewares/ST/STM32_USB_Host_Library/Class/CDC/Inc -I../Drivers/CMSIS/Device/ST/STM32F7xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-tflite_bridge

clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-tflite_bridge:
	-$(RM) ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/flatbuffer_conversions_bridge.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/flatbuffer_conversions_bridge.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/flatbuffer_conversions_bridge.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/flatbuffer_conversions_bridge.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/micro_error_reporter.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/micro_error_reporter.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/micro_error_reporter.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/tflite_bridge/micro_error_reporter.su

.PHONY: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-tflite_bridge

