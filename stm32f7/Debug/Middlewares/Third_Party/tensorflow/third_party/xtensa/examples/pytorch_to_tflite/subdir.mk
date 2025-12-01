################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CC_SRCS += \
../Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_images_dog_jpg.cc \
../Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_op_resolver.cc \
../Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_to_tflite_test.cc 

CC_DEPS += \
./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_images_dog_jpg.d \
./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_op_resolver.d \
./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_to_tflite_test.d 

OBJS += \
./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_images_dog_jpg.o \
./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_op_resolver.o \
./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_to_tflite_test.o 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/%.o Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/%.su Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/%.cyclo: ../Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/%.cc Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F746xx -c -I../Core/Inc -I../Middlewares/Third_Party/tensorflow/gemmlowp -I../Middlewares/Third_Party/tensorflow/third_party/flatbuffers/include -I../Middlewares/Third_Party/tensorflow -I../FATFS/Target -I../FATFS/App -I../USB_HOST/App -I../USB_HOST/Target -I../Drivers/STM32F7xx_HAL_Driver/Inc -I../Drivers/STM32F7xx_HAL_Driver/Inc/Legacy -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I../Middlewares/Third_Party/FatFs/src -I../Middlewares/ST/STM32_USB_Host_Library/Core/Inc -I../Middlewares/ST/STM32_USB_Host_Library/Class/CDC/Inc -I../Drivers/CMSIS/Device/ST/STM32F7xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-third_party-2f-xtensa-2f-examples-2f-pytorch_to_tflite

clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-third_party-2f-xtensa-2f-examples-2f-pytorch_to_tflite:
	-$(RM) ./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_images_dog_jpg.cyclo ./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_images_dog_jpg.d ./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_images_dog_jpg.o ./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_images_dog_jpg.su ./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_op_resolver.cyclo ./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_op_resolver.d ./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_op_resolver.o ./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_op_resolver.su ./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_to_tflite_test.cyclo ./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_to_tflite_test.d ./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_to_tflite_test.o ./Middlewares/Third_Party/tensorflow/third_party/xtensa/examples/pytorch_to_tflite/pytorch_to_tflite_test.su

.PHONY: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-third_party-2f-xtensa-2f-examples-2f-pytorch_to_tflite

