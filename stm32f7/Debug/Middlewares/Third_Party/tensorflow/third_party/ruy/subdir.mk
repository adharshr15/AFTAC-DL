################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CC_SRCS += \
../Middlewares/Third_Party/tensorflow/third_party/ruy/allocator.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/apply_multiplier.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/block_map.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/cpuinfo.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/denormal.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/kernel_arm32.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/kernel_arm64.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/pack_arm.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/pmu.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/prepacked_cache.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/prepare_packed_matrices.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/system_aligned_alloc.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/tune.cc 

CC_DEPS += \
./Middlewares/Third_Party/tensorflow/third_party/ruy/allocator.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/apply_multiplier.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/block_map.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/cpuinfo.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/denormal.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/kernel_arm32.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/kernel_arm64.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/pack_arm.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/pmu.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/prepacked_cache.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/prepare_packed_matrices.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/system_aligned_alloc.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/tune.d 

OBJS += \
./Middlewares/Third_Party/tensorflow/third_party/ruy/allocator.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/apply_multiplier.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/block_map.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/cpuinfo.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/denormal.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/kernel_arm32.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/kernel_arm64.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/pack_arm.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/pmu.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/prepacked_cache.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/prepare_packed_matrices.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/system_aligned_alloc.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/tune.o 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/Third_Party/tensorflow/third_party/ruy/%.o Middlewares/Third_Party/tensorflow/third_party/ruy/%.su Middlewares/Third_Party/tensorflow/third_party/ruy/%.cyclo: ../Middlewares/Third_Party/tensorflow/third_party/ruy/%.cc Middlewares/Third_Party/tensorflow/third_party/ruy/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F746xx '-DCMSIS_DEVICE_ARM_CORTEX_M_XX_HEADER_FILE="stm32f7xx.h"' -c -I../Core/Inc -I../Middlewares/Third_Party/tensorflow/third_party -I../Middlewares/Third_Party/tensorflow/gemmlowp -I../Middlewares/Third_Party/tensorflow/third_party/flatbuffers/include -I../Middlewares/Third_Party/tensorflow -I../FATFS/Target -I../FATFS/App -I../USB_HOST/App -I../USB_HOST/Target -I../Drivers/STM32F7xx_HAL_Driver/Inc -I../Drivers/STM32F7xx_HAL_Driver/Inc/Legacy -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I../Middlewares/Third_Party/FatFs/src -I../Middlewares/ST/STM32_USB_Host_Library/Core/Inc -I../Middlewares/ST/STM32_USB_Host_Library/Class/CDC/Inc -I../Drivers/CMSIS/Device/ST/STM32F7xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-third_party-2f-ruy

clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-third_party-2f-ruy:
	-$(RM) ./Middlewares/Third_Party/tensorflow/third_party/ruy/allocator.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/allocator.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/allocator.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/allocator.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/apply_multiplier.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/apply_multiplier.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/apply_multiplier.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/apply_multiplier.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/block_map.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/block_map.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/block_map.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/block_map.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/cpuinfo.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/cpuinfo.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/cpuinfo.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/cpuinfo.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/denormal.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/denormal.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/denormal.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/denormal.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/kernel_arm32.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/kernel_arm32.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/kernel_arm32.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/kernel_arm32.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/kernel_arm64.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/kernel_arm64.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/kernel_arm64.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/kernel_arm64.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/pack_arm.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/pack_arm.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/pack_arm.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/pack_arm.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/pmu.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/pmu.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/pmu.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/pmu.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/prepacked_cache.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/prepacked_cache.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/prepacked_cache.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/prepacked_cache.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/prepare_packed_matrices.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/prepare_packed_matrices.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/prepare_packed_matrices.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/prepare_packed_matrices.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/system_aligned_alloc.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/system_aligned_alloc.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/system_aligned_alloc.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/system_aligned_alloc.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/tune.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/tune.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/tune.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/tune.su

.PHONY: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-third_party-2f-ruy

