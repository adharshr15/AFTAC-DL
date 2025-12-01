################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CC_SRCS += \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/add.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/add_vision.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_common_xtensa.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_hifi.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int16_reference.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int8_int16.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int8_reference.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_vision.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/decode_state.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/decompress.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv_hifi.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv_vision.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/dequantize.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_common_xtensa.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_hifimini.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_int8.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_vision.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/leaky_relu.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/logistic.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/lstm_eval.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/lstm_eval_hifi.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pad.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pad_vision.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling_int8.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling_vision.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/quantize.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reduce.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reduce_vision.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reshape.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reshape_vision.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax_int8_int16.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax_vision.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/strided_slice.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/sub.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/svdf.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/svdf_hifimini.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/transpose_conv.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/unidirectional_sequence_lstm.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_huffman.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_lut.cc \
../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_prune.cc 

CC_DEPS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/add.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/add_vision.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_common_xtensa.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_hifi.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int16_reference.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int8_int16.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int8_reference.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_vision.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/decode_state.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/decompress.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv_hifi.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv_vision.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/dequantize.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_common_xtensa.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_hifimini.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_int8.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_vision.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/leaky_relu.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/logistic.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/lstm_eval.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/lstm_eval_hifi.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pad.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pad_vision.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling_int8.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling_vision.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/quantize.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reduce.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reduce_vision.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reshape.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reshape_vision.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax_int8_int16.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax_vision.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/strided_slice.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/sub.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/svdf.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/svdf_hifimini.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/transpose_conv.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/unidirectional_sequence_lstm.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_huffman.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_lut.d \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_prune.d 

OBJS += \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/add.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/add_vision.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_common_xtensa.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_hifi.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int16_reference.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int8_int16.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int8_reference.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_vision.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/decode_state.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/decompress.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv_hifi.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv_vision.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/dequantize.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_common_xtensa.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_hifimini.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_int8.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_vision.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/leaky_relu.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/logistic.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/lstm_eval.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/lstm_eval_hifi.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pad.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pad_vision.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling_int8.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling_vision.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/quantize.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reduce.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reduce_vision.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reshape.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reshape_vision.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax_int8_int16.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax_vision.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/strided_slice.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/sub.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/svdf.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/svdf_hifimini.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/transpose_conv.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/unidirectional_sequence_lstm.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_huffman.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_lut.o \
./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_prune.o 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/%.o Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/%.su Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/%.cyclo: ../Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/%.cc Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F746xx -c -I../Core/Inc -I../FATFS/Target -I../FATFS/App -I../USB_HOST/App -I../USB_HOST/Target -I../Drivers/STM32F7xx_HAL_Driver/Inc -I../Drivers/STM32F7xx_HAL_Driver/Inc/Legacy -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I../Middlewares/Third_Party/FatFs/src -I../Middlewares/ST/STM32_USB_Host_Library/Core/Inc -I../Middlewares/ST/STM32_USB_Host_Library/Class/CDC/Inc -I../Drivers/CMSIS/Device/ST/STM32F7xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-kernels-2f-xtensa

clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-kernels-2f-xtensa:
	-$(RM) ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/add.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/add.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/add.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/add.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/add_vision.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/add_vision.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/add_vision.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/add_vision.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_common_xtensa.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_common_xtensa.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_common_xtensa.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_common_xtensa.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_hifi.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_hifi.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_hifi.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_hifi.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int16_reference.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int16_reference.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int16_reference.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int16_reference.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int8_int16.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int8_int16.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int8_int16.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int8_int16.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int8_reference.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int8_reference.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int8_reference.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_int8_reference.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_vision.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_vision.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_vision.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/conv_vision.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/decode_state.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/decode_state.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/decode_state.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/decode_state.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/decompress.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/decompress.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/decompress.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/decompress.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv_hifi.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv_hifi.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv_hifi.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv_hifi.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv_vision.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv_vision.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv_vision.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/depthwise_conv_vision.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/dequantize.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/dequantize.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/dequantize.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/dequantize.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_common_xtensa.cyclo
	-$(RM) ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_common_xtensa.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_common_xtensa.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_common_xtensa.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_hifimini.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_hifimini.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_hifimini.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_hifimini.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_int8.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_int8.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_int8.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_int8.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_vision.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_vision.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_vision.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/fully_connected_vision.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/leaky_relu.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/leaky_relu.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/leaky_relu.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/leaky_relu.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/logistic.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/logistic.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/logistic.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/logistic.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/lstm_eval.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/lstm_eval.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/lstm_eval.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/lstm_eval.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/lstm_eval_hifi.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/lstm_eval_hifi.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/lstm_eval_hifi.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/lstm_eval_hifi.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pad.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pad.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pad.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pad.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pad_vision.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pad_vision.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pad_vision.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pad_vision.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling_int8.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling_int8.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling_int8.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling_int8.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling_vision.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling_vision.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling_vision.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/pooling_vision.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/quantize.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/quantize.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/quantize.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/quantize.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reduce.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reduce.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reduce.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reduce.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reduce_vision.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reduce_vision.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reduce_vision.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reduce_vision.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reshape.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reshape.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reshape.o
	-$(RM) ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reshape.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reshape_vision.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reshape_vision.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reshape_vision.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/reshape_vision.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax_int8_int16.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax_int8_int16.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax_int8_int16.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax_int8_int16.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax_vision.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax_vision.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax_vision.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/softmax_vision.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/strided_slice.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/strided_slice.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/strided_slice.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/strided_slice.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/sub.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/sub.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/sub.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/sub.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/svdf.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/svdf.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/svdf.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/svdf.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/svdf_hifimini.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/svdf_hifimini.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/svdf_hifimini.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/svdf_hifimini.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/transpose_conv.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/transpose_conv.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/transpose_conv.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/transpose_conv.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/unidirectional_sequence_lstm.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/unidirectional_sequence_lstm.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/unidirectional_sequence_lstm.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/unidirectional_sequence_lstm.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_huffman.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_huffman.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_huffman.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_huffman.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_lut.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_lut.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_lut.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_lut.su ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_prune.cyclo ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_prune.d ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_prune.o ./Middlewares/Third_Party/tensorflow/tensorflow/lite/micro/kernels/xtensa/xtensa_decode_state_prune.su

.PHONY: clean-Middlewares-2f-Third_Party-2f-tensorflow-2f-tensorflow-2f-lite-2f-micro-2f-kernels-2f-xtensa

