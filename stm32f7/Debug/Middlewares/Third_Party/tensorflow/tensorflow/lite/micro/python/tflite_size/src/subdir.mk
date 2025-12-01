################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CC_SRCS += \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size_wrapper.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size_wrapper_pybind.cc 

CC_DEPS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size_wrapper.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size_wrapper_pybind.d 

OBJS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size_wrapper.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size_wrapper_pybind.o 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/%.o Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/%.su Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/%.cyclo: ../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/%.cc Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F746xx -c -I../Core/Inc -I../FATFS/Target -I../FATFS/App -I../USB_HOST/App -I../USB_HOST/Target -I../Drivers/STM32F7xx_HAL_Driver/Inc -I../Drivers/STM32F7xx_HAL_Driver/Inc/Legacy -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I../Middlewares/Third_Party/FatFs/src -I../Middlewares/ST/STM32_USB_Host_Library/Core/Inc -I../Middlewares/ST/STM32_USB_Host_Library/Class/CDC/Inc -I../Drivers/CMSIS/Device/ST/STM32F7xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-python-2f-tflite_size-2f-src

clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-python-2f-tflite_size-2f-src:
	-$(RM) ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size_wrapper.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size_wrapper.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size_wrapper.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size_wrapper.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size_wrapper_pybind.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size_wrapper_pybind.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size_wrapper_pybind.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size_wrapper_pybind.su

.PHONY: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-python-2f-tflite_size-2f-src

