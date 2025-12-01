################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CC_SRCS += \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/add.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/batch_matmul.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/conv.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/depthwise_conv.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/fully_connected.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/maximum_minimum.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/mul.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/pad.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/pooling.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/softmax.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/svdf.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/transpose.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/transpose_conv.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/unidirectional_sequence_lstm.cc 

CC_DEPS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/add.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/batch_matmul.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/conv.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/depthwise_conv.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/fully_connected.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/maximum_minimum.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/mul.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/pad.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/pooling.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/softmax.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/svdf.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/transpose.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/transpose_conv.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/unidirectional_sequence_lstm.d 

OBJS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/add.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/batch_matmul.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/conv.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/depthwise_conv.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/fully_connected.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/maximum_minimum.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/mul.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/pad.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/pooling.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/softmax.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/svdf.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/transpose.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/transpose_conv.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/unidirectional_sequence_lstm.o 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/%.o Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/%.su Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/%.cyclo: ../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/%.cc Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F746xx -c -I../Core/Inc -I../Middlewares/Third_Party/tensorflow -I../FATFS/Target -I../FATFS/App -I../USB_HOST/App -I../USB_HOST/Target -I../Drivers/STM32F7xx_HAL_Driver/Inc -I../Drivers/STM32F7xx_HAL_Driver/Inc/Legacy -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I../Middlewares/Third_Party/FatFs/src -I../Middlewares/ST/STM32_USB_Host_Library/Core/Inc -I../Middlewares/ST/STM32_USB_Host_Library/Class/CDC/Inc -I../Drivers/CMSIS/Device/ST/STM32F7xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-kernels-2f-cmsis_nn

clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-kernels-2f-cmsis_nn:
	-$(RM) ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/add.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/add.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/add.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/add.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/batch_matmul.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/batch_matmul.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/batch_matmul.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/batch_matmul.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/conv.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/conv.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/conv.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/conv.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/depthwise_conv.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/depthwise_conv.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/depthwise_conv.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/depthwise_conv.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/fully_connected.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/fully_connected.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/fully_connected.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/fully_connected.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/maximum_minimum.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/maximum_minimum.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/maximum_minimum.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/maximum_minimum.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/mul.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/mul.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/mul.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/mul.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/pad.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/pad.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/pad.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/pad.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/pooling.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/pooling.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/pooling.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/pooling.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/softmax.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/softmax.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/softmax.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/softmax.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/svdf.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/svdf.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/svdf.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/svdf.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/transpose.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/transpose.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/transpose.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/transpose.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/transpose_conv.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/transpose_conv.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/transpose_conv.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/transpose_conv.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/unidirectional_sequence_lstm.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/unidirectional_sequence_lstm.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/unidirectional_sequence_lstm.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/cmsis_nn/unidirectional_sequence_lstm.su

.PHONY: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-kernels-2f-cmsis_nn

