################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CC_SRCS += \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/detection_responder.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/detection_responder_test.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/image_provider.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/image_provider_test.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/main.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/main_functions.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/model_settings.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/person_detection_test.cc 

CC_DEPS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/detection_responder.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/detection_responder_test.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/image_provider.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/image_provider_test.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/main.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/main_functions.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/model_settings.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/person_detection_test.d 

OBJS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/detection_responder.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/detection_responder_test.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/image_provider.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/image_provider_test.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/main.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/main_functions.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/model_settings.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/person_detection_test.o 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/%.o Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/%.su Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/%.cyclo: ../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/%.cc Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F746xx -c -I../Core/Inc -I../Middlewares/Third_Party/tensorflow/third_party -I../Middlewares/Third_Party/tensorflow/gemmlowp -I../Middlewares/Third_Party/tensorflow/third_party/flatbuffers/include -I../Middlewares/Third_Party/tensorflow -I../FATFS/Target -I../FATFS/App -I../USB_HOST/App -I../USB_HOST/Target -I../Drivers/STM32F7xx_HAL_Driver/Inc -I../Drivers/STM32F7xx_HAL_Driver/Inc/Legacy -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I../Middlewares/Third_Party/FatFs/src -I../Middlewares/ST/STM32_USB_Host_Library/Core/Inc -I../Middlewares/ST/STM32_USB_Host_Library/Class/CDC/Inc -I../Drivers/CMSIS/Device/ST/STM32F7xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-examples-2f-person_detection

clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-examples-2f-person_detection:
	-$(RM) ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/detection_responder.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/detection_responder.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/detection_responder.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/detection_responder.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/detection_responder_test.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/detection_responder_test.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/detection_responder_test.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/detection_responder_test.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/image_provider.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/image_provider.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/image_provider.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/image_provider.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/image_provider_test.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/image_provider_test.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/image_provider_test.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/image_provider_test.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/main.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/main.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/main.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/main.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/main_functions.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/main_functions.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/main_functions.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/main_functions.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/model_settings.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/model_settings.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/model_settings.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/model_settings.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/person_detection_test.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/person_detection_test.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/person_detection_test.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/examples/person_detection/person_detection_test.su

.PHONY: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-examples-2f-person_detection

