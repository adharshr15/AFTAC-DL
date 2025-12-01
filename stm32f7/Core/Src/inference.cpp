#include "main.h"
#include "model_data.h"

#include "tensorflow/lite/micro/micro_mutable_op_resolver.h"
#include "tensorflow/lite/micro/micro_interpreter.h"
#include "tensorflow/lite/schema/schema_generated.h"
#include "tensorflow/lite/micro/micro_error_reporter.h"
#include "tensorflow/lite/micro/micro_interpreter.h"


#include <stdio.h>
#include <string.h>

// For DWT cycle counter (usually pulled in via CMSIS)
#include "core_cm7.h"

// UART from main.c
extern UART_HandleTypeDef huart1;

constexpr int kTensorArenaSize = 128 * 1024;

#if defined(__GNUC__)
__attribute__((aligned(16)))
#endif
static uint8_t tensor_arena[kTensorArenaSize];


// CPU frequency in Hz (change if your clock is different)
constexpr uint32_t kCpuFreqHz = 216000000UL; // 216 MHz

// Enable and reset the DWT cycle counter
static void InitCycleCounter()
{
    // Enable tracing
    CoreDebug->DEMCR |= CoreDebug_DEMCR_TRCENA_Msk;
    // Reset counter
    DWT->CYCCNT = 0;
    // Enable cycle counter
    DWT->CTRL |= DWT_CTRL_CYCCNTENA_Msk;
}

extern "C" void RunModelOnce(void)
{
    // Make sure cycle counter is enabled
    InitCycleCounter();

    const char *banner = "STM32F7 Inference Test\r\n";
    HAL_UART_Transmit(&huart1, (uint8_t*)banner, strlen(banner), HAL_MAX_DELAY);

    const tflite::Model* model = tflite::GetModel(model_tflite);
    if (model->version() != TFLITE_SCHEMA_VERSION) {
        const char *msg = "Model schema version mismatch\r\n";
        HAL_UART_Transmit(&huart1, (uint8_t*)msg, strlen(msg), HAL_MAX_DELAY);
        return;
    }

    // We have 10 distinct ops: QUANTIZE, EXPAND_DIMS, CONV_2D, RESHAPE,
    // MAX_POOL_2D, SHAPE, STRIDED_SLICE, PACK, FULLY_CONNECTED, DEQUANTIZE
    static tflite::MicroMutableOpResolver<10> resolver;

    resolver.AddQuantize();        // QUANTIZE
    resolver.AddExpandDims();      // EXPAND_DIMS
    resolver.AddConv2D();          // CONV_2D
    resolver.AddReshape();         // RESHAPE
    resolver.AddMaxPool2D();       // MAX_POOL_2D
    resolver.AddShape();           // SHAPE
    resolver.AddStridedSlice();    // STRIDED_SLICE
    resolver.AddPack();            // PACK
    resolver.AddFullyConnected();  // FULLY_CONNECTED
    resolver.AddDequantize();      // DEQUANTIZE

    static tflite::MicroInterpreter interpreter(
        model, resolver, tensor_arena, kTensorArenaSize);

    if (interpreter.AllocateTensors() != kTfLiteOk) {
        const char *msg = "AllocateTensors failed\r\n";
        HAL_UART_Transmit(&huart1, (uint8_t*)msg, strlen(msg), HAL_MAX_DELAY);
        return;
    }

    // 5. Get input tensor
    TfLiteTensor* input = interpreter.input(0);

    // For now, fill with zeros; replace with real test data
    memset(input->data.raw, 0, input->bytes);

    const char *run_msg = "Running inference...\r\n";
    HAL_UART_Transmit(&huart1, (uint8_t*)run_msg, strlen(run_msg), HAL_MAX_DELAY);

    // ---- 6. Measure Invoke() cycles + time ----
    uint32_t start_cycles = DWT->CYCCNT;
    uint32_t start_ms     = HAL_GetTick();

    TfLiteStatus invoke_status = interpreter.Invoke();

    uint32_t end_ms     = HAL_GetTick();
    uint32_t end_cycles = DWT->CYCCNT;
    // ------------------------------------------

    if (invoke_status != kTfLiteOk)
    {
        const char *msg = "Invoke failed\r\n";
        HAL_UART_Transmit(&huart1, (uint8_t*)msg, strlen(msg), HAL_MAX_DELAY);
        return;
    }

    // Compute metrics
    uint32_t cycles      = end_cycles - start_cycles;
    uint32_t elapsed_ms  = end_ms - start_ms;

    // cycles / freq = seconds -> convert to microseconds with 64-bit math
    uint64_t latency_us  = ((uint64_t)cycles * 1000000ULL) / kCpuFreqHz;
    uint32_t latency_ms_i = (uint32_t)(latency_us / 1000ULL);
    uint32_t latency_ms_frac = (uint32_t)(latency_us % 1000ULL); // fractional ms

    char buf[128];
    int n = snprintf(buf, sizeof(buf),
                     "Inference cycles: %lu, HAL ms: %lu, latency ~ %lu.%03lu ms\r\n",
                     (unsigned long)cycles,
                     (unsigned long)elapsed_ms,
                     (unsigned long)latency_ms_i,
                     (unsigned long)latency_ms_frac);
    HAL_UART_Transmit(&huart1, (uint8_t*)buf, n, HAL_MAX_DELAY);

    // 7. Output tensor
    TfLiteTensor* output = interpreter.output(0);

    if (output->type == kTfLiteFloat32)
    {
        float y0 = output->data.f[0];
        int scaled = (int)(y0 * 1000.0f); // scaled by 1e3
        n = snprintf(buf, sizeof(buf),
                     "Inference done, output0=%d (x1e-3)\r\n", scaled);
    }
    else
    {
        long y0_int = 0;
        switch (output->type)
        {
        case kTfLiteInt8:
            y0_int = output->data.int8[0];
            break;
        case kTfLiteUInt8:
            y0_int = output->data.uint8[0];
            break;
        case kTfLiteInt16:
            y0_int = output->data.i16[0];
            break;
        case kTfLiteInt32:
            y0_int = output->data.i32[0];
            break;
        default:
            y0_int = 0;
            break;
        }
        n = snprintf(buf, sizeof(buf),
                     "Inference done, output0=%ld\r\n", y0_int);
    }

    HAL_UART_Transmit(&huart1, (uint8_t*)buf, n, HAL_MAX_DELAY);
}
