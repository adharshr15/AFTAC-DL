################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CC_SRCS += \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/all_ops_resolver.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/debug_log.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/flatbuffer_utils.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/memory_helpers.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_allocation_info.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_allocator.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_context.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_error_reporter.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_graph.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_interpreter.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_log.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_profiler.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_resource_variable.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_string.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_time.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_utils.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/recording_micro_allocator.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/system_setup.cc 

CC_DEPS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/all_ops_resolver.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/debug_log.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/flatbuffer_utils.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/memory_helpers.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_allocation_info.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_allocator.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_context.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_error_reporter.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_graph.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_interpreter.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_log.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_profiler.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_resource_variable.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_string.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_time.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_utils.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/recording_micro_allocator.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/system_setup.d 

OBJS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/all_ops_resolver.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/debug_log.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/flatbuffer_utils.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/memory_helpers.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_allocation_info.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_allocator.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_context.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_error_reporter.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_graph.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_interpreter.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_log.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_profiler.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_resource_variable.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_string.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_time.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_utils.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/recording_micro_allocator.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/system_setup.o 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/%.o Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/%.su Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/%.cyclo: ../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/%.cc Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F746xx '-DCMSIS_DEVICE_ARM_CORTEX_M_XX_HEADER_FILE="stm32f7xx.h"' -c -I../Core/Inc -I../Middlewares/Third_Party/tensorflow/third_party -I../Middlewares/Third_Party/tensorflow/gemmlowp -I../Middlewares/Third_Party/tensorflow/third_party/flatbuffers/include -I../Middlewares/Third_Party/tensorflow -I../FATFS/Target -I../FATFS/App -I../USB_HOST/App -I../USB_HOST/Target -I../Drivers/STM32F7xx_HAL_Driver/Inc -I../Drivers/STM32F7xx_HAL_Driver/Inc/Legacy -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I../Middlewares/Third_Party/FatFs/src -I../Middlewares/ST/STM32_USB_Host_Library/Core/Inc -I../Middlewares/ST/STM32_USB_Host_Library/Class/CDC/Inc -I../Drivers/CMSIS/Device/ST/STM32F7xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro

clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro:
	-$(RM) ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/all_ops_resolver.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/all_ops_resolver.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/all_ops_resolver.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/all_ops_resolver.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/debug_log.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/debug_log.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/debug_log.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/debug_log.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/flatbuffer_utils.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/flatbuffer_utils.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/flatbuffer_utils.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/flatbuffer_utils.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/memory_helpers.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/memory_helpers.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/memory_helpers.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/memory_helpers.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_allocation_info.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_allocation_info.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_allocation_info.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_allocation_info.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_allocator.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_allocator.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_allocator.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_allocator.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_context.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_context.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_context.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_context.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_error_reporter.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_error_reporter.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_error_reporter.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_error_reporter.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_graph.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_graph.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_graph.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_graph.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_interpreter.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_interpreter.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_interpreter.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_interpreter.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_log.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_log.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_log.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_log.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_profiler.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_profiler.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_profiler.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_profiler.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_resource_variable.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_resource_variable.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_resource_variable.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_resource_variable.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_string.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_string.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_string.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_string.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_time.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_time.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_time.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_time.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_utils.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_utils.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_utils.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/micro_utils.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/recording_micro_allocator.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/recording_micro_allocator.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/recording_micro_allocator.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/recording_micro_allocator.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/system_setup.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/system_setup.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/system_setup.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/system_setup.su

.PHONY: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro

