################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CC_SRCS += \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/common.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/portable_tensor_utils.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/quantization_util.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/runtime_shape.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/tensor_ctypes.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/tensor_utils.cc 

CC_DEPS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/common.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/portable_tensor_utils.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/quantization_util.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/runtime_shape.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/tensor_ctypes.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/tensor_utils.d 

OBJS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/common.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/portable_tensor_utils.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/quantization_util.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/runtime_shape.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/tensor_ctypes.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/tensor_utils.o 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/%.o Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/%.su Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/%.cyclo: ../Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/%.cc Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F746xx '-DCMSIS_DEVICE_ARM_CORTEX_M_XX_HEADER_FILE="stm32f7xx.h"' -c -I../Core/Inc -I../Middlewares/Third_Party/tensorflow/third_party -I../Middlewares/Third_Party/tensorflow/gemmlowp -I../Middlewares/Third_Party/tensorflow/third_party/flatbuffers/include -I../Middlewares/Third_Party/tensorflow -I../FATFS/Target -I../FATFS/App -I../USB_HOST/App -I../USB_HOST/Target -I../Drivers/STM32F7xx_HAL_Driver/Inc -I../Drivers/STM32F7xx_HAL_Driver/Inc/Legacy -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I../Middlewares/Third_Party/FatFs/src -I../Middlewares/ST/STM32_USB_Host_Library/Core/Inc -I../Middlewares/ST/STM32_USB_Host_Library/Class/CDC/Inc -I../Drivers/CMSIS/Device/ST/STM32F7xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-kernels-2f-internal

clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-kernels-2f-internal:
	-$(RM) ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/common.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/common.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/common.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/common.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/portable_tensor_utils.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/portable_tensor_utils.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/portable_tensor_utils.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/portable_tensor_utils.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/quantization_util.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/quantization_util.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/quantization_util.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/quantization_util.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/runtime_shape.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/runtime_shape.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/runtime_shape.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/runtime_shape.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/tensor_ctypes.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/tensor_ctypes.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/tensor_ctypes.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/tensor_ctypes.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/tensor_utils.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/tensor_utils.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/tensor_utils.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/kernels/internal/tensor_utils.su

.PHONY: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-kernels-2f-internal

