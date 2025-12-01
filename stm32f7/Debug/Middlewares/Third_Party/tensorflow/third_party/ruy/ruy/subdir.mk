################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CC_SRCS += \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/allocator.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/allocator_test.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/apply_multiplier.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/apply_multiplier_test.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/benchmark.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/block_map.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/block_map_test.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/blocking_counter.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/check_macros_test.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context_get_ctx.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context_test.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/cpuinfo.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/ctx.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/ctx_test.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/denormal.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/frontend.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx2_fma.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx512.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_arm32.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_arm64.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx2_fma.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx512.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/matrix_test.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/mul_params_test.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_arm.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx2_fma.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx512.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/perchannel_buffers_reallocation_test.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pmu.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepacked_cache.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepacked_cache_test.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepare_packed_matrices.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/size_util_test.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/system_aligned_alloc.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_fast.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_overflow_dst_zero_point.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_slow.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/thread_pool.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/trmul.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/tune.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/tune_test.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/wait.cc \
../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/wait_test.cc 

CC_DEPS += \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/allocator.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/allocator_test.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/apply_multiplier.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/apply_multiplier_test.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/benchmark.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/block_map.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/block_map_test.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/blocking_counter.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/check_macros_test.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context_get_ctx.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context_test.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/cpuinfo.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/ctx.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/ctx_test.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/denormal.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/frontend.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx2_fma.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx512.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_arm32.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_arm64.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx2_fma.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx512.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/matrix_test.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/mul_params_test.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_arm.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx2_fma.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx512.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/perchannel_buffers_reallocation_test.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pmu.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepacked_cache.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepacked_cache_test.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepare_packed_matrices.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/size_util_test.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/system_aligned_alloc.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_fast.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_overflow_dst_zero_point.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_slow.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/thread_pool.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/trmul.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/tune.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/tune_test.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/wait.d \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/wait_test.d 

OBJS += \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/allocator.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/allocator_test.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/apply_multiplier.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/apply_multiplier_test.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/benchmark.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/block_map.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/block_map_test.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/blocking_counter.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/check_macros_test.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context_get_ctx.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context_test.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/cpuinfo.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/ctx.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/ctx_test.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/denormal.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/frontend.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx2_fma.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx512.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_arm32.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_arm64.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx2_fma.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx512.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/matrix_test.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/mul_params_test.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_arm.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx2_fma.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx512.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/perchannel_buffers_reallocation_test.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pmu.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepacked_cache.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepacked_cache_test.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepare_packed_matrices.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/size_util_test.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/system_aligned_alloc.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_fast.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_overflow_dst_zero_point.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_slow.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/thread_pool.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/trmul.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/tune.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/tune_test.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/wait.o \
./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/wait_test.o 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/%.o Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/%.su Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/%.cyclo: ../Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/%.cc Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F746xx -c -I../Core/Inc -I../Middlewares/Third_Party/tensorflow/third_party -I../Middlewares/Third_Party/tensorflow/gemmlowp -I../Middlewares/Third_Party/tensorflow/third_party/flatbuffers/include -I../Middlewares/Third_Party/tensorflow -I../FATFS/Target -I../FATFS/App -I../USB_HOST/App -I../USB_HOST/Target -I../Drivers/STM32F7xx_HAL_Driver/Inc -I../Drivers/STM32F7xx_HAL_Driver/Inc/Legacy -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I../Middlewares/Third_Party/FatFs/src -I../Middlewares/ST/STM32_USB_Host_Library/Core/Inc -I../Middlewares/ST/STM32_USB_Host_Library/Class/CDC/Inc -I../Drivers/CMSIS/Device/ST/STM32F7xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-third_party-2f-ruy-2f-ruy

clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-third_party-2f-ruy-2f-ruy:
	-$(RM) ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/allocator.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/allocator.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/allocator.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/allocator.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/allocator_test.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/allocator_test.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/allocator_test.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/allocator_test.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/apply_multiplier.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/apply_multiplier.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/apply_multiplier.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/apply_multiplier.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/apply_multiplier_test.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/apply_multiplier_test.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/apply_multiplier_test.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/apply_multiplier_test.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/benchmark.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/benchmark.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/benchmark.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/benchmark.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/block_map.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/block_map.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/block_map.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/block_map.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/block_map_test.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/block_map_test.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/block_map_test.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/block_map_test.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/blocking_counter.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/blocking_counter.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/blocking_counter.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/blocking_counter.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/check_macros_test.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/check_macros_test.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/check_macros_test.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/check_macros_test.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context_get_ctx.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context_get_ctx.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context_get_ctx.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context_get_ctx.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context_test.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context_test.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context_test.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/context_test.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/cpuinfo.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/cpuinfo.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/cpuinfo.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/cpuinfo.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/ctx.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/ctx.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/ctx.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/ctx.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/ctx_test.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/ctx_test.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/ctx_test.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/ctx_test.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/denormal.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/denormal.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/denormal.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/denormal.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/frontend.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/frontend.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/frontend.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/frontend.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx2_fma.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx2_fma.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx2_fma.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx2_fma.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx512.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx512.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx512.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/have_built_path_for_avx512.su
	-$(RM) ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_arm32.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_arm32.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_arm32.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_arm32.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_arm64.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_arm64.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_arm64.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_arm64.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx2_fma.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx2_fma.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx2_fma.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx2_fma.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx512.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx512.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx512.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/kernel_avx512.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/matrix_test.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/matrix_test.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/matrix_test.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/matrix_test.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/mul_params_test.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/mul_params_test.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/mul_params_test.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/mul_params_test.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_arm.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_arm.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_arm.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_arm.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx2_fma.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx2_fma.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx2_fma.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx2_fma.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx512.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx512.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx512.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pack_avx512.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/perchannel_buffers_reallocation_test.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/perchannel_buffers_reallocation_test.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/perchannel_buffers_reallocation_test.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/perchannel_buffers_reallocation_test.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pmu.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pmu.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pmu.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/pmu.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepacked_cache.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepacked_cache.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepacked_cache.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepacked_cache.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepacked_cache_test.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepacked_cache_test.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepacked_cache_test.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepacked_cache_test.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepare_packed_matrices.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepare_packed_matrices.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepare_packed_matrices.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/prepare_packed_matrices.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/size_util_test.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/size_util_test.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/size_util_test.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/size_util_test.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/system_aligned_alloc.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/system_aligned_alloc.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/system_aligned_alloc.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/system_aligned_alloc.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_fast.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_fast.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_fast.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_fast.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_overflow_dst_zero_point.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_overflow_dst_zero_point.d
	-$(RM) ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_overflow_dst_zero_point.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_overflow_dst_zero_point.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_slow.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_slow.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_slow.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/test_slow.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/thread_pool.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/thread_pool.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/thread_pool.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/thread_pool.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/trmul.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/trmul.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/trmul.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/trmul.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/tune.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/tune.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/tune.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/tune.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/tune_test.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/tune_test.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/tune_test.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/tune_test.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/wait.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/wait.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/wait.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/wait.su ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/wait_test.cyclo ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/wait_test.d ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/wait_test.o ./Middlewares/Third_Party/tensorflow/third_party/ruy/ruy/wait_test.su

.PHONY: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-third_party-2f-ruy-2f-ruy

