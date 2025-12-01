################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CC_SRCS += \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/add.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/conv.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/depthwise_conv.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/fully_connected.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_interface.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_interface_mli_20.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_slicers.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/pooling.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/scratch_buf_mgr.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/scratch_buffers.cc 

CC_DEPS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/add.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/conv.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/depthwise_conv.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/fully_connected.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_interface.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_interface_mli_20.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_slicers.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/pooling.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/scratch_buf_mgr.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/scratch_buffers.d 

OBJS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/add.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/conv.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/depthwise_conv.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/fully_connected.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_interface.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_interface_mli_20.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_slicers.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/pooling.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/scratch_buf_mgr.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/scratch_buffers.o 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/%.o Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/%.su Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/%.cyclo: ../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/%.cc Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F746xx -c -I../Core/Inc -I../Middlewares/Third_Party/tensorflow -I../FATFS/Target -I../FATFS/App -I../USB_HOST/App -I../USB_HOST/Target -I../Drivers/STM32F7xx_HAL_Driver/Inc -I../Drivers/STM32F7xx_HAL_Driver/Inc/Legacy -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I../Middlewares/Third_Party/FatFs/src -I../Middlewares/ST/STM32_USB_Host_Library/Core/Inc -I../Middlewares/ST/STM32_USB_Host_Library/Class/CDC/Inc -I../Drivers/CMSIS/Device/ST/STM32F7xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-kernels-2f-arc_mli

clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-kernels-2f-arc_mli:
	-$(RM) ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/add.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/add.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/add.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/add.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/conv.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/conv.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/conv.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/conv.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/depthwise_conv.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/depthwise_conv.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/depthwise_conv.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/depthwise_conv.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/fully_connected.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/fully_connected.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/fully_connected.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/fully_connected.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_interface.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_interface.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_interface.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_interface.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_interface_mli_20.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_interface_mli_20.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_interface_mli_20.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_interface_mli_20.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_slicers.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_slicers.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_slicers.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/mli_slicers.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/pooling.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/pooling.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/pooling.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/pooling.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/scratch_buf_mgr.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/scratch_buf_mgr.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/scratch_buf_mgr.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/scratch_buf_mgr.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/scratch_buffers.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/scratch_buffers.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/scratch_buffers.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/arc_mli/scratch_buffers.su

.PHONY: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-kernels-2f-arc_mli

