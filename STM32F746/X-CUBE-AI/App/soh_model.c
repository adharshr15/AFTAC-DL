/**
  ******************************************************************************
  * @file    soh_model.c
  * @author  AST Embedded Analytics Research Platform
  * @date    2025-12-04T13:34:51-0600
  * @brief   AI Tool Automatic Code Generator for Embedded NN computing
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2025 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  ******************************************************************************
  */


#include "soh_model.h"
#include "soh_model_data.h"

#include "ai_platform.h"
#include "ai_platform_interface.h"
#include "ai_math_helpers.h"

#include "core_common.h"
#include "core_convert.h"

#include "layers.h"



#undef AI_NET_OBJ_INSTANCE
#define AI_NET_OBJ_INSTANCE g_soh_model
 
#undef AI_SOH_MODEL_MODEL_SIGNATURE
#define AI_SOH_MODEL_MODEL_SIGNATURE     "0xd4562242fc6e795b21870df1cacae56f"

#ifndef AI_TOOLS_REVISION_ID
#define AI_TOOLS_REVISION_ID     ""
#endif

#undef AI_TOOLS_DATE_TIME
#define AI_TOOLS_DATE_TIME   "2025-12-04T13:34:51-0600"

#undef AI_TOOLS_COMPILE_TIME
#define AI_TOOLS_COMPILE_TIME    __DATE__ " " __TIME__

#undef AI_SOH_MODEL_N_BATCHES
#define AI_SOH_MODEL_N_BATCHES         (1)

static ai_ptr g_soh_model_activations_map[1] = AI_C_ARRAY_INIT;
static ai_ptr g_soh_model_weights_map[1] = AI_C_ARRAY_INIT;



/**  Array declarations section  **********************************************/
/* Array#0 */
AI_ARRAY_OBJ_DECLARE(
  serving_default_keras_tensor_160_output_array, AI_ARRAY_FORMAT_FLOAT|AI_FMT_FLAG_IS_IO,
  NULL, NULL, 48, AI_STATIC)

/* Array#1 */
AI_ARRAY_OBJ_DECLARE(
  conversion_0_output_array, AI_ARRAY_FORMAT_S8,
  NULL, NULL, 48, AI_STATIC)

/* Array#2 */
AI_ARRAY_OBJ_DECLARE(
  conv2d_2_output_array, AI_ARRAY_FORMAT_S8,
  NULL, NULL, 1408, AI_STATIC)

/* Array#3 */
AI_ARRAY_OBJ_DECLARE(
  pool_5_output_array, AI_ARRAY_FORMAT_S8,
  NULL, NULL, 704, AI_STATIC)

/* Array#4 */
AI_ARRAY_OBJ_DECLARE(
  gemm_11_output_array, AI_ARRAY_FORMAT_S8,
  NULL, NULL, 25, AI_STATIC)

/* Array#5 */
AI_ARRAY_OBJ_DECLARE(
  gemm_12_output_array, AI_ARRAY_FORMAT_S8,
  NULL, NULL, 1, AI_STATIC)

/* Array#6 */
AI_ARRAY_OBJ_DECLARE(
  conversion_13_output_array, AI_ARRAY_FORMAT_FLOAT|AI_FMT_FLAG_IS_IO,
  NULL, NULL, 1, AI_STATIC)

/* Array#7 */
AI_ARRAY_OBJ_DECLARE(
  conv2d_2_weights_array, AI_ARRAY_FORMAT_S8,
  NULL, NULL, 160, AI_STATIC)

/* Array#8 */
AI_ARRAY_OBJ_DECLARE(
  conv2d_2_bias_array, AI_ARRAY_FORMAT_S32,
  NULL, NULL, 32, AI_STATIC)

/* Array#9 */
AI_ARRAY_OBJ_DECLARE(
  gemm_11_weights_array, AI_ARRAY_FORMAT_S8,
  NULL, NULL, 17600, AI_STATIC)

/* Array#10 */
AI_ARRAY_OBJ_DECLARE(
  gemm_11_bias_array, AI_ARRAY_FORMAT_S32,
  NULL, NULL, 25, AI_STATIC)

/* Array#11 */
AI_ARRAY_OBJ_DECLARE(
  gemm_12_weights_array, AI_ARRAY_FORMAT_S8,
  NULL, NULL, 25, AI_STATIC)

/* Array#12 */
AI_ARRAY_OBJ_DECLARE(
  gemm_12_bias_array, AI_ARRAY_FORMAT_S32,
  NULL, NULL, 1, AI_STATIC)

/* Array#13 */
AI_ARRAY_OBJ_DECLARE(
  conv2d_2_scratch0_array, AI_ARRAY_FORMAT_S8,
  NULL, NULL, 788, AI_STATIC)

/* Array#14 */
AI_ARRAY_OBJ_DECLARE(
  gemm_11_scratch0_array, AI_ARRAY_FORMAT_S16,
  NULL, NULL, 829, AI_STATIC)

/* Array#15 */
AI_ARRAY_OBJ_DECLARE(
  gemm_12_scratch0_array, AI_ARRAY_FORMAT_S16,
  NULL, NULL, 25, AI_STATIC)

/**  Array metadata declarations section  *************************************/
/* Int quant #0 */
AI_INTQ_INFO_LIST_OBJ_DECLARE(conv2d_2_output_array_intq, AI_STATIC_CONST,
  AI_BUFFER_META_FLAG_SCALE_FLOAT|AI_BUFFER_META_FLAG_ZEROPOINT_S8, 1,
  AI_PACK_INTQ_INFO(
    AI_PACK_INTQ_SCALE(0.005416399333626032f),
    AI_PACK_INTQ_ZP(-128)))

/* Int quant #1 */
AI_INTQ_INFO_LIST_OBJ_DECLARE(conv2d_2_weights_array_intq, AI_STATIC_CONST,
  AI_BUFFER_META_FLAG_SCALE_FLOAT|AI_BUFFER_META_FLAG_ZEROPOINT_S8, 32,
  AI_PACK_INTQ_INFO(
    AI_PACK_INTQ_SCALE(0.0009034075774252415f, 0.000975200382526964f, 0.000879736733622849f, 0.001084312330931425f, 0.000864590925630182f, 0.0009322878904640675f, 0.0009818675462156534f, 0.0009120753384195268f, 0.0009638366173021495f, 0.0009181153727695346f, 0.0009258195059373975f, 0.0011057527735829353f, 0.0009973099222406745f, 0.000934974814299494f, 0.0008153497474268079f, 0.0007668121252208948f, 0.000902502506505698f, 0.0008867434225976467f, 0.0007063326775096357f, 0.0011925569269806147f, 0.0011480971006676555f, 0.0008681380422785878f, 0.0008103791624307632f, 0.0007931833970360458f, 0.0007344040204770863f, 0.0008896314539015293f, 0.0009589841356500983f, 0.001084027928300202f, 0.000999791780486703f, 0.0008984566084109247f, 0.0009865810861811042f, 0.0007244321750476956f),
    AI_PACK_INTQ_ZP(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)))

/* Int quant #2 */
AI_INTQ_INFO_LIST_OBJ_DECLARE(conversion_0_output_array_intq, AI_STATIC_CONST,
  AI_BUFFER_META_FLAG_SCALE_FLOAT|AI_BUFFER_META_FLAG_ZEROPOINT_S8, 1,
  AI_PACK_INTQ_INFO(
    AI_PACK_INTQ_SCALE(0.028902621939778328f),
    AI_PACK_INTQ_ZP(-47)))

/* Int quant #3 */
AI_INTQ_INFO_LIST_OBJ_DECLARE(gemm_11_output_array_intq, AI_STATIC_CONST,
  AI_BUFFER_META_FLAG_SCALE_FLOAT|AI_BUFFER_META_FLAG_ZEROPOINT_S8, 1,
  AI_PACK_INTQ_INFO(
    AI_PACK_INTQ_SCALE(0.014070602133870125f),
    AI_PACK_INTQ_ZP(-128)))

/* Int quant #4 */
AI_INTQ_INFO_LIST_OBJ_DECLARE(gemm_11_weights_array_intq, AI_STATIC_CONST,
  AI_BUFFER_META_FLAG_SCALE_FLOAT|AI_BUFFER_META_FLAG_ZEROPOINT_S8, 25,
  AI_PACK_INTQ_INFO(
    AI_PACK_INTQ_SCALE(0.0009264395339414477f, 0.0013725141761824489f, 0.0009444725001230836f, 0.0016475237207487226f, 0.0014834648463875055f, 0.0013142339885234833f, 0.0015917351702228189f, 0.001125770853832364f, 0.0013121935771778226f, 0.0016969511052593589f, 0.0012889800127595663f, 0.0012264673132449389f, 0.001271151821129024f, 0.0010553813772276044f, 0.0012850596103817225f, 0.001222426537424326f, 0.001089349389076233f, 0.0012504062615334988f, 0.0009415932581759989f, 0.0011713146232068539f, 0.0007747737690806389f, 0.001085827243514359f, 0.001577524235472083f, 0.0011026323772966862f, 0.001227581757120788f),
    AI_PACK_INTQ_ZP(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)))

/* Int quant #5 */
AI_INTQ_INFO_LIST_OBJ_DECLARE(gemm_12_output_array_intq, AI_STATIC_CONST,
  AI_BUFFER_META_FLAG_SCALE_FLOAT|AI_BUFFER_META_FLAG_ZEROPOINT_S8, 1,
  AI_PACK_INTQ_INFO(
    AI_PACK_INTQ_SCALE(0.006678686011582613f),
    AI_PACK_INTQ_ZP(-44)))

/* Int quant #6 */
AI_INTQ_INFO_LIST_OBJ_DECLARE(gemm_12_weights_array_intq, AI_STATIC_CONST,
  AI_BUFFER_META_FLAG_SCALE_FLOAT|AI_BUFFER_META_FLAG_ZEROPOINT_S8, 1,
  AI_PACK_INTQ_INFO(
    AI_PACK_INTQ_SCALE(0.001826459658332169f),
    AI_PACK_INTQ_ZP(0)))

/* Int quant #7 */
AI_INTQ_INFO_LIST_OBJ_DECLARE(pool_5_output_array_intq, AI_STATIC_CONST,
  AI_BUFFER_META_FLAG_SCALE_FLOAT|AI_BUFFER_META_FLAG_ZEROPOINT_S8, 1,
  AI_PACK_INTQ_INFO(
    AI_PACK_INTQ_SCALE(0.005416399333626032f),
    AI_PACK_INTQ_ZP(-128)))

/**  Tensor declarations section  *********************************************/
/* Tensor #0 */
AI_TENSOR_OBJ_DECLARE(
  conv2d_2_bias, AI_STATIC,
  0, 0x0,
  AI_SHAPE_INIT(4, 1, 32, 1, 1), AI_STRIDE_INIT(4, 4, 4, 128, 128),
  1, &conv2d_2_bias_array, NULL)

/* Tensor #1 */
AI_TENSOR_OBJ_DECLARE(
  conv2d_2_output, AI_STATIC,
  1, 0x1,
  AI_SHAPE_INIT(4, 1, 32, 44, 1), AI_STRIDE_INIT(4, 1, 1, 32, 1408),
  1, &conv2d_2_output_array, &conv2d_2_output_array_intq)

/* Tensor #2 */
AI_TENSOR_OBJ_DECLARE(
  conv2d_2_scratch0, AI_STATIC,
  2, 0x0,
  AI_SHAPE_INIT(4, 1, 788, 1, 1), AI_STRIDE_INIT(4, 1, 1, 788, 788),
  1, &conv2d_2_scratch0_array, NULL)

/* Tensor #3 */
AI_TENSOR_OBJ_DECLARE(
  conv2d_2_weights, AI_STATIC,
  3, 0x1,
  AI_SHAPE_INIT(4, 1, 5, 1, 32), AI_STRIDE_INIT(4, 1, 1, 32, 160),
  1, &conv2d_2_weights_array, &conv2d_2_weights_array_intq)

/* Tensor #4 */
AI_TENSOR_OBJ_DECLARE(
  conversion_0_output, AI_STATIC,
  4, 0x1,
  AI_SHAPE_INIT(4, 1, 1, 1, 48), AI_STRIDE_INIT(4, 1, 1, 1, 1),
  1, &conversion_0_output_array, &conversion_0_output_array_intq)

/* Tensor #5 */
AI_TENSOR_OBJ_DECLARE(
  conversion_0_output0, AI_STATIC,
  5, 0x1,
  AI_SHAPE_INIT(4, 1, 1, 48, 1), AI_STRIDE_INIT(4, 1, 1, 1, 48),
  1, &conversion_0_output_array, &conversion_0_output_array_intq)

/* Tensor #6 */
AI_TENSOR_OBJ_DECLARE(
  conversion_13_output, AI_STATIC,
  6, 0x0,
  AI_SHAPE_INIT(4, 1, 1, 1, 1), AI_STRIDE_INIT(4, 4, 4, 4, 4),
  1, &conversion_13_output_array, NULL)

/* Tensor #7 */
AI_TENSOR_OBJ_DECLARE(
  gemm_11_bias, AI_STATIC,
  7, 0x0,
  AI_SHAPE_INIT(4, 1, 25, 1, 1), AI_STRIDE_INIT(4, 4, 4, 100, 100),
  1, &gemm_11_bias_array, NULL)

/* Tensor #8 */
AI_TENSOR_OBJ_DECLARE(
  gemm_11_output, AI_STATIC,
  8, 0x1,
  AI_SHAPE_INIT(4, 1, 25, 1, 1), AI_STRIDE_INIT(4, 1, 1, 25, 25),
  1, &gemm_11_output_array, &gemm_11_output_array_intq)

/* Tensor #9 */
AI_TENSOR_OBJ_DECLARE(
  gemm_11_scratch0, AI_STATIC,
  9, 0x0,
  AI_SHAPE_INIT(4, 1, 829, 1, 1), AI_STRIDE_INIT(4, 2, 2, 1658, 1658),
  1, &gemm_11_scratch0_array, NULL)

/* Tensor #10 */
AI_TENSOR_OBJ_DECLARE(
  gemm_11_weights, AI_STATIC,
  10, 0x1,
  AI_SHAPE_INIT(4, 704, 25, 1, 1), AI_STRIDE_INIT(4, 1, 704, 17600, 17600),
  1, &gemm_11_weights_array, &gemm_11_weights_array_intq)

/* Tensor #11 */
AI_TENSOR_OBJ_DECLARE(
  gemm_12_bias, AI_STATIC,
  11, 0x0,
  AI_SHAPE_INIT(4, 1, 1, 1, 1), AI_STRIDE_INIT(4, 4, 4, 4, 4),
  1, &gemm_12_bias_array, NULL)

/* Tensor #12 */
AI_TENSOR_OBJ_DECLARE(
  gemm_12_output, AI_STATIC,
  12, 0x1,
  AI_SHAPE_INIT(4, 1, 1, 1, 1), AI_STRIDE_INIT(4, 1, 1, 1, 1),
  1, &gemm_12_output_array, &gemm_12_output_array_intq)

/* Tensor #13 */
AI_TENSOR_OBJ_DECLARE(
  gemm_12_scratch0, AI_STATIC,
  13, 0x0,
  AI_SHAPE_INIT(4, 1, 25, 1, 1), AI_STRIDE_INIT(4, 2, 2, 50, 50),
  1, &gemm_12_scratch0_array, NULL)

/* Tensor #14 */
AI_TENSOR_OBJ_DECLARE(
  gemm_12_weights, AI_STATIC,
  14, 0x1,
  AI_SHAPE_INIT(4, 25, 1, 1, 1), AI_STRIDE_INIT(4, 1, 25, 25, 25),
  1, &gemm_12_weights_array, &gemm_12_weights_array_intq)

/* Tensor #15 */
AI_TENSOR_OBJ_DECLARE(
  pool_5_output, AI_STATIC,
  15, 0x1,
  AI_SHAPE_INIT(4, 1, 32, 22, 1), AI_STRIDE_INIT(4, 1, 1, 32, 704),
  1, &pool_5_output_array, &pool_5_output_array_intq)

/* Tensor #16 */
AI_TENSOR_OBJ_DECLARE(
  pool_5_output0, AI_STATIC,
  16, 0x1,
  AI_SHAPE_INIT(4, 1, 704, 1, 1), AI_STRIDE_INIT(4, 1, 1, 704, 704),
  1, &pool_5_output_array, &pool_5_output_array_intq)

/* Tensor #17 */
AI_TENSOR_OBJ_DECLARE(
  serving_default_keras_tensor_160_output, AI_STATIC,
  17, 0x0,
  AI_SHAPE_INIT(4, 1, 1, 1, 48), AI_STRIDE_INIT(4, 4, 4, 4, 4),
  1, &serving_default_keras_tensor_160_output_array, NULL)



/**  Layer declarations section  **********************************************/


AI_TENSOR_CHAIN_OBJ_DECLARE(
  conversion_13_chain, AI_STATIC_CONST, 4,
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 1, &gemm_12_output),
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 1, &conversion_13_output),
  AI_TENSOR_LIST_OBJ_EMPTY,
  AI_TENSOR_LIST_OBJ_EMPTY
)

AI_LAYER_OBJ_DECLARE(
  conversion_13_layer, 13,
  NL_TYPE, 0x0, NULL,
  nl, node_convert,
  &conversion_13_chain,
  NULL, &conversion_13_layer, AI_STATIC, 
)

AI_TENSOR_CHAIN_OBJ_DECLARE(
  gemm_12_chain, AI_STATIC_CONST, 4,
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 1, &gemm_11_output),
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 1, &gemm_12_output),
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 2, &gemm_12_weights, &gemm_12_bias),
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 1, &gemm_12_scratch0)
)

AI_LAYER_OBJ_DECLARE(
  gemm_12_layer, 12,
  DENSE_TYPE, 0x0, NULL,
  dense, forward_dense_integer_SSSA,
  &gemm_12_chain,
  NULL, &conversion_13_layer, AI_STATIC, 
)

AI_TENSOR_CHAIN_OBJ_DECLARE(
  gemm_11_chain, AI_STATIC_CONST, 4,
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 1, &pool_5_output0),
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 1, &gemm_11_output),
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 2, &gemm_11_weights, &gemm_11_bias),
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 1, &gemm_11_scratch0)
)

AI_LAYER_OBJ_DECLARE(
  gemm_11_layer, 11,
  DENSE_TYPE, 0x0, NULL,
  dense, forward_dense_integer_SSSA_ch,
  &gemm_11_chain,
  NULL, &gemm_12_layer, AI_STATIC, 
)

AI_TENSOR_CHAIN_OBJ_DECLARE(
  pool_5_chain, AI_STATIC_CONST, 4,
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 1, &conv2d_2_output),
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 1, &pool_5_output),
  AI_TENSOR_LIST_OBJ_EMPTY,
  AI_TENSOR_LIST_OBJ_EMPTY
)

AI_LAYER_OBJ_DECLARE(
  pool_5_layer, 5,
  POOL_TYPE, 0x0, NULL,
  pool, forward_mp_integer_INT8,
  &pool_5_chain,
  NULL, &gemm_11_layer, AI_STATIC, 
  .pool_size = AI_SHAPE_2D_INIT(2, 1), 
  .pool_stride = AI_SHAPE_2D_INIT(2, 1), 
  .pool_pad = AI_SHAPE_INIT(4, 0, 0, 0, 0), 
)

AI_TENSOR_CHAIN_OBJ_DECLARE(
  conv2d_2_chain, AI_STATIC_CONST, 4,
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 1, &conversion_0_output0),
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 1, &conv2d_2_output),
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 3, &conv2d_2_weights, &conv2d_2_bias, NULL),
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 1, &conv2d_2_scratch0)
)

AI_LAYER_OBJ_DECLARE(
  conv2d_2_layer, 2,
  CONV2D_TYPE, 0x0, NULL,
  conv2d, forward_conv2d_sssa8_ch,
  &conv2d_2_chain,
  NULL, &pool_5_layer, AI_STATIC, 
  .groups = 1, 
  .filter_stride = AI_SHAPE_2D_INIT(1, 1), 
  .dilation = AI_SHAPE_2D_INIT(1, 1), 
  .filter_pad = AI_SHAPE_INIT(4, 0, 0, 0, 0), 
  .in_ch_format = AI_LAYER_FORMAT_CHANNEL_LAST_VALID, 
  .out_ch_format = AI_LAYER_FORMAT_CHANNEL_LAST_VALID, 
)

AI_TENSOR_CHAIN_OBJ_DECLARE(
  conversion_0_chain, AI_STATIC_CONST, 4,
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 1, &serving_default_keras_tensor_160_output),
  AI_TENSOR_LIST_OBJ_INIT(AI_FLAG_NONE, 1, &conversion_0_output),
  AI_TENSOR_LIST_OBJ_EMPTY,
  AI_TENSOR_LIST_OBJ_EMPTY
)

AI_LAYER_OBJ_DECLARE(
  conversion_0_layer, 0,
  NL_TYPE, 0x0, NULL,
  nl, node_convert,
  &conversion_0_chain,
  NULL, &conv2d_2_layer, AI_STATIC, 
)


#if (AI_TOOLS_API_VERSION < AI_TOOLS_API_VERSION_1_5)

AI_NETWORK_OBJ_DECLARE(
  AI_NET_OBJ_INSTANCE, AI_STATIC,
  AI_BUFFER_INIT(AI_FLAG_NONE,  AI_BUFFER_FORMAT_U8,
    AI_BUFFER_SHAPE_INIT(AI_SHAPE_BCWH, 4, 1, 18020, 1, 1),
    18020, NULL, NULL),
  AI_BUFFER_INIT(AI_FLAG_NONE,  AI_BUFFER_FORMAT_U8,
    AI_BUFFER_SHAPE_INIT(AI_SHAPE_BCWH, 4, 1, 2392, 1, 1),
    2392, NULL, NULL),
  AI_TENSOR_LIST_IO_OBJ_INIT(AI_FLAG_NONE, AI_SOH_MODEL_IN_NUM, &serving_default_keras_tensor_160_output),
  AI_TENSOR_LIST_IO_OBJ_INIT(AI_FLAG_NONE, AI_SOH_MODEL_OUT_NUM, &conversion_13_output),
  &conversion_0_layer, 0x5187bd8f, NULL)

#else

AI_NETWORK_OBJ_DECLARE(
  AI_NET_OBJ_INSTANCE, AI_STATIC,
  AI_BUFFER_ARRAY_OBJ_INIT_STATIC(
  	AI_FLAG_NONE, 1,
    AI_BUFFER_INIT(AI_FLAG_NONE,  AI_BUFFER_FORMAT_U8,
      AI_BUFFER_SHAPE_INIT(AI_SHAPE_BCWH, 4, 1, 18020, 1, 1),
      18020, NULL, NULL)
  ),
  AI_BUFFER_ARRAY_OBJ_INIT_STATIC(
  	AI_FLAG_NONE, 1,
    AI_BUFFER_INIT(AI_FLAG_NONE,  AI_BUFFER_FORMAT_U8,
      AI_BUFFER_SHAPE_INIT(AI_SHAPE_BCWH, 4, 1, 2392, 1, 1),
      2392, NULL, NULL)
  ),
  AI_TENSOR_LIST_IO_OBJ_INIT(AI_FLAG_NONE, AI_SOH_MODEL_IN_NUM, &serving_default_keras_tensor_160_output),
  AI_TENSOR_LIST_IO_OBJ_INIT(AI_FLAG_NONE, AI_SOH_MODEL_OUT_NUM, &conversion_13_output),
  &conversion_0_layer, 0x5187bd8f, NULL)

#endif	/*(AI_TOOLS_API_VERSION < AI_TOOLS_API_VERSION_1_5)*/



/******************************************************************************/
AI_DECLARE_STATIC
ai_bool soh_model_configure_activations(
  ai_network* net_ctx, const ai_network_params* params)
{
  AI_ASSERT(net_ctx)

  if (ai_platform_get_activations_map(g_soh_model_activations_map, 1, params)) {
    /* Updating activations (byte) offsets */
    
    serving_default_keras_tensor_160_output_array.data = AI_PTR(g_soh_model_activations_map[0] + 0);
    serving_default_keras_tensor_160_output_array.data_start = AI_PTR(g_soh_model_activations_map[0] + 0);
    conversion_0_output_array.data = AI_PTR(g_soh_model_activations_map[0] + 0);
    conversion_0_output_array.data_start = AI_PTR(g_soh_model_activations_map[0] + 0);
    conv2d_2_scratch0_array.data = AI_PTR(g_soh_model_activations_map[0] + 48);
    conv2d_2_scratch0_array.data_start = AI_PTR(g_soh_model_activations_map[0] + 48);
    conv2d_2_output_array.data = AI_PTR(g_soh_model_activations_map[0] + 836);
    conv2d_2_output_array.data_start = AI_PTR(g_soh_model_activations_map[0] + 836);
    pool_5_output_array.data = AI_PTR(g_soh_model_activations_map[0] + 0);
    pool_5_output_array.data_start = AI_PTR(g_soh_model_activations_map[0] + 0);
    gemm_11_scratch0_array.data = AI_PTR(g_soh_model_activations_map[0] + 704);
    gemm_11_scratch0_array.data_start = AI_PTR(g_soh_model_activations_map[0] + 704);
    gemm_11_output_array.data = AI_PTR(g_soh_model_activations_map[0] + 2364);
    gemm_11_output_array.data_start = AI_PTR(g_soh_model_activations_map[0] + 2364);
    gemm_12_scratch0_array.data = AI_PTR(g_soh_model_activations_map[0] + 0);
    gemm_12_scratch0_array.data_start = AI_PTR(g_soh_model_activations_map[0] + 0);
    gemm_12_output_array.data = AI_PTR(g_soh_model_activations_map[0] + 52);
    gemm_12_output_array.data_start = AI_PTR(g_soh_model_activations_map[0] + 52);
    conversion_13_output_array.data = AI_PTR(g_soh_model_activations_map[0] + 0);
    conversion_13_output_array.data_start = AI_PTR(g_soh_model_activations_map[0] + 0);
    return true;
  }
  AI_ERROR_TRAP(net_ctx, INIT_FAILED, NETWORK_ACTIVATIONS);
  return false;
}




/******************************************************************************/
AI_DECLARE_STATIC
ai_bool soh_model_configure_weights(
  ai_network* net_ctx, const ai_network_params* params)
{
  AI_ASSERT(net_ctx)

  if (ai_platform_get_weights_map(g_soh_model_weights_map, 1, params)) {
    /* Updating weights (byte) offsets */
    
    conv2d_2_weights_array.format |= AI_FMT_FLAG_CONST;
    conv2d_2_weights_array.data = AI_PTR(g_soh_model_weights_map[0] + 0);
    conv2d_2_weights_array.data_start = AI_PTR(g_soh_model_weights_map[0] + 0);
    conv2d_2_bias_array.format |= AI_FMT_FLAG_CONST;
    conv2d_2_bias_array.data = AI_PTR(g_soh_model_weights_map[0] + 160);
    conv2d_2_bias_array.data_start = AI_PTR(g_soh_model_weights_map[0] + 160);
    gemm_11_weights_array.format |= AI_FMT_FLAG_CONST;
    gemm_11_weights_array.data = AI_PTR(g_soh_model_weights_map[0] + 288);
    gemm_11_weights_array.data_start = AI_PTR(g_soh_model_weights_map[0] + 288);
    gemm_11_bias_array.format |= AI_FMT_FLAG_CONST;
    gemm_11_bias_array.data = AI_PTR(g_soh_model_weights_map[0] + 17888);
    gemm_11_bias_array.data_start = AI_PTR(g_soh_model_weights_map[0] + 17888);
    gemm_12_weights_array.format |= AI_FMT_FLAG_CONST;
    gemm_12_weights_array.data = AI_PTR(g_soh_model_weights_map[0] + 17988);
    gemm_12_weights_array.data_start = AI_PTR(g_soh_model_weights_map[0] + 17988);
    gemm_12_bias_array.format |= AI_FMT_FLAG_CONST;
    gemm_12_bias_array.data = AI_PTR(g_soh_model_weights_map[0] + 18016);
    gemm_12_bias_array.data_start = AI_PTR(g_soh_model_weights_map[0] + 18016);
    return true;
  }
  AI_ERROR_TRAP(net_ctx, INIT_FAILED, NETWORK_WEIGHTS);
  return false;
}


/**  PUBLIC APIs SECTION  *****************************************************/



AI_DEPRECATED
AI_API_ENTRY
ai_bool ai_soh_model_get_info(
  ai_handle network, ai_network_report* report)
{
  ai_network* net_ctx = AI_NETWORK_ACQUIRE_CTX(network);

  if (report && net_ctx)
  {
    ai_network_report r = {
      .model_name        = AI_SOH_MODEL_MODEL_NAME,
      .model_signature   = AI_SOH_MODEL_MODEL_SIGNATURE,
      .model_datetime    = AI_TOOLS_DATE_TIME,
      
      .compile_datetime  = AI_TOOLS_COMPILE_TIME,
      
      .runtime_revision  = ai_platform_runtime_get_revision(),
      .runtime_version   = ai_platform_runtime_get_version(),

      .tool_revision     = AI_TOOLS_REVISION_ID,
      .tool_version      = {AI_TOOLS_VERSION_MAJOR, AI_TOOLS_VERSION_MINOR,
                            AI_TOOLS_VERSION_MICRO, 0x0},
      .tool_api_version  = AI_STRUCT_INIT,

      .api_version            = ai_platform_api_get_version(),
      .interface_api_version  = ai_platform_interface_api_get_version(),
      
      .n_macc            = 26229,
      .n_inputs          = 0,
      .inputs            = NULL,
      .n_outputs         = 0,
      .outputs           = NULL,
      .params            = AI_STRUCT_INIT,
      .activations       = AI_STRUCT_INIT,
      .n_nodes           = 0,
      .signature         = 0x5187bd8f,
    };

    if (!ai_platform_api_get_network_report(network, &r)) return false;

    *report = r;
    return true;
  }
  return false;
}



AI_API_ENTRY
ai_bool ai_soh_model_get_report(
  ai_handle network, ai_network_report* report)
{
  ai_network* net_ctx = AI_NETWORK_ACQUIRE_CTX(network);

  if (report && net_ctx)
  {
    ai_network_report r = {
      .model_name        = AI_SOH_MODEL_MODEL_NAME,
      .model_signature   = AI_SOH_MODEL_MODEL_SIGNATURE,
      .model_datetime    = AI_TOOLS_DATE_TIME,
      
      .compile_datetime  = AI_TOOLS_COMPILE_TIME,
      
      .runtime_revision  = ai_platform_runtime_get_revision(),
      .runtime_version   = ai_platform_runtime_get_version(),

      .tool_revision     = AI_TOOLS_REVISION_ID,
      .tool_version      = {AI_TOOLS_VERSION_MAJOR, AI_TOOLS_VERSION_MINOR,
                            AI_TOOLS_VERSION_MICRO, 0x0},
      .tool_api_version  = AI_STRUCT_INIT,

      .api_version            = ai_platform_api_get_version(),
      .interface_api_version  = ai_platform_interface_api_get_version(),
      
      .n_macc            = 26229,
      .n_inputs          = 0,
      .inputs            = NULL,
      .n_outputs         = 0,
      .outputs           = NULL,
      .map_signature     = AI_MAGIC_SIGNATURE,
      .map_weights       = AI_STRUCT_INIT,
      .map_activations   = AI_STRUCT_INIT,
      .n_nodes           = 0,
      .signature         = 0x5187bd8f,
    };

    if (!ai_platform_api_get_network_report(network, &r)) return false;

    *report = r;
    return true;
  }
  return false;
}


AI_API_ENTRY
ai_error ai_soh_model_get_error(ai_handle network)
{
  return ai_platform_network_get_error(network);
}


AI_API_ENTRY
ai_error ai_soh_model_create(
  ai_handle* network, const ai_buffer* network_config)
{
  return ai_platform_network_create(
    network, network_config, 
    AI_CONTEXT_OBJ(&AI_NET_OBJ_INSTANCE),
    AI_TOOLS_API_VERSION_MAJOR, AI_TOOLS_API_VERSION_MINOR, AI_TOOLS_API_VERSION_MICRO);
}


AI_API_ENTRY
ai_error ai_soh_model_create_and_init(
  ai_handle* network, const ai_handle activations[], const ai_handle weights[])
{
  ai_error err;
  ai_network_params params;

  err = ai_soh_model_create(network, AI_SOH_MODEL_DATA_CONFIG);
  if (err.type != AI_ERROR_NONE) {
    return err;
  }
  
  if (ai_soh_model_data_params_get(&params) != true) {
    err = ai_soh_model_get_error(*network);
    return err;
  }
#if defined(AI_SOH_MODEL_DATA_ACTIVATIONS_COUNT)
  /* set the addresses of the activations buffers */
  for (ai_u16 idx=0; activations && idx<params.map_activations.size; idx++) {
    AI_BUFFER_ARRAY_ITEM_SET_ADDRESS(&params.map_activations, idx, activations[idx]);
  }
#endif
#if defined(AI_SOH_MODEL_DATA_WEIGHTS_COUNT)
  /* set the addresses of the weight buffers */
  for (ai_u16 idx=0; weights && idx<params.map_weights.size; idx++) {
    AI_BUFFER_ARRAY_ITEM_SET_ADDRESS(&params.map_weights, idx, weights[idx]);
  }
#endif
  if (ai_soh_model_init(*network, &params) != true) {
    err = ai_soh_model_get_error(*network);
  }
  return err;
}


AI_API_ENTRY
ai_buffer* ai_soh_model_inputs_get(ai_handle network, ai_u16 *n_buffer)
{
  if (network == AI_HANDLE_NULL) {
    network = (ai_handle)&AI_NET_OBJ_INSTANCE;
    AI_NETWORK_OBJ(network)->magic = AI_MAGIC_CONTEXT_TOKEN;
  }
  return ai_platform_inputs_get(network, n_buffer);
}


AI_API_ENTRY
ai_buffer* ai_soh_model_outputs_get(ai_handle network, ai_u16 *n_buffer)
{
  if (network == AI_HANDLE_NULL) {
    network = (ai_handle)&AI_NET_OBJ_INSTANCE;
    AI_NETWORK_OBJ(network)->magic = AI_MAGIC_CONTEXT_TOKEN;
  }
  return ai_platform_outputs_get(network, n_buffer);
}


AI_API_ENTRY
ai_handle ai_soh_model_destroy(ai_handle network)
{
  return ai_platform_network_destroy(network);
}


AI_API_ENTRY
ai_bool ai_soh_model_init(
  ai_handle network, const ai_network_params* params)
{
  ai_network* net_ctx = AI_NETWORK_OBJ(ai_platform_network_init(network, params));
  ai_bool ok = true;

  if (!net_ctx) return false;
  ok &= soh_model_configure_weights(net_ctx, params);
  ok &= soh_model_configure_activations(net_ctx, params);

  ok &= ai_platform_network_post_init(network);

  return ok;
}


AI_API_ENTRY
ai_i32 ai_soh_model_run(
  ai_handle network, const ai_buffer* input, ai_buffer* output)
{
  return ai_platform_network_process(network, input, output);
}


AI_API_ENTRY
ai_i32 ai_soh_model_forward(ai_handle network, const ai_buffer* input)
{
  return ai_platform_network_process(network, input, NULL);
}



#undef AI_SOH_MODEL_MODEL_SIGNATURE
#undef AI_NET_OBJ_INSTANCE
#undef AI_TOOLS_DATE_TIME
#undef AI_TOOLS_COMPILE_TIME

