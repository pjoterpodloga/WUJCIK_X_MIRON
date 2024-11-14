
//------------------------------------------------------------------------------
// (c) Copyright 2014 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//------------------------------------------------------------------------------ 
//
// C Model configuration for the "fir_compiler_HP" instance.
//
//------------------------------------------------------------------------------
//
// coefficients: -1324,1320,635,180,-92,-226,-260,-229,-161,-78,2,68,114,135,133,112,76,33,-11,-50,-80,-96,-98,-86,-63,-31,4,37,65,83,90,83,65,38,6,-28,-58,-79,-90,-88,-73,-48,-16,20,53,79,94,96,84,60,26,-12,-49,-80,-100,-106,-97,-74,-39,3,45,82,108,119,113,90,53,7,-41,-85,-118,-135,-132,-110,-71,-20,36,88,129,152,156,133,95,36,-28,-90,-143,-176,-184,-165,-122,-59,17,94,159,204,222,207,161,88,-2,-96,-180,-243,-274,-265,-216,-132,-22,98,211,300,350,353,301,201,62,-99,-259,-395,-484,-507,-456,-330,-137,100,355,591,771,861,830,661,347,-101,-662,-1298,-1962,-2604,-3171,-3615,-3898,28773,-3898,-3615,-3171,-2604,-1962,-1298,-662,-101,347,661,830,861,771,591,355,100,-137,-330,-456,-507,-484,-395,-259,-99,62,201,301,353,350,300,211,98,-22,-132,-216,-265,-274,-243,-180,-96,-2,88,161,207,222,204,159,94,17,-59,-122,-165,-184,-176,-143,-90,-28,36,95,133,156,152,129,88,36,-20,-71,-110,-132,-135,-118,-85,-41,7,53,90,113,119,108,82,45,3,-39,-74,-97,-106,-100,-80,-49,-12,26,60,84,96,94,79,53,20,-16,-48,-73,-88,-90,-79,-58,-28,6,38,65,83,90,83,65,37,4,-31,-63,-86,-98,-96,-80,-50,-11,33,76,112,133,135,114,68,2,-78,-161,-229,-260,-226,-92,180,635,1320,-1324
// chanpats: 173
// name: fir_compiler_HP
// filter_type: 0
// rate_change: 0
// interp_rate: 1
// decim_rate: 1
// zero_pack_factor: 1
// coeff_padding: 0
// num_coeffs: 283
// coeff_sets: 1
// reloadable: 0
// is_halfband: 0
// quantization: 1
// coeff_width: 16
// coeff_fract_width: 0
// chan_seq: 0
// num_channels: 1
// num_paths: 1
// data_width: 24
// data_fract_width: 0
// output_rounding_mode: 1
// output_width: 24
// output_fract_width: 0
// config_method: 0

const double fir_compiler_HP_coefficients[283] = {-1324,1320,635,180,-92,-226,-260,-229,-161,-78,2,68,114,135,133,112,76,33,-11,-50,-80,-96,-98,-86,-63,-31,4,37,65,83,90,83,65,38,6,-28,-58,-79,-90,-88,-73,-48,-16,20,53,79,94,96,84,60,26,-12,-49,-80,-100,-106,-97,-74,-39,3,45,82,108,119,113,90,53,7,-41,-85,-118,-135,-132,-110,-71,-20,36,88,129,152,156,133,95,36,-28,-90,-143,-176,-184,-165,-122,-59,17,94,159,204,222,207,161,88,-2,-96,-180,-243,-274,-265,-216,-132,-22,98,211,300,350,353,301,201,62,-99,-259,-395,-484,-507,-456,-330,-137,100,355,591,771,861,830,661,347,-101,-662,-1298,-1962,-2604,-3171,-3615,-3898,28773,-3898,-3615,-3171,-2604,-1962,-1298,-662,-101,347,661,830,861,771,591,355,100,-137,-330,-456,-507,-484,-395,-259,-99,62,201,301,353,350,300,211,98,-22,-132,-216,-265,-274,-243,-180,-96,-2,88,161,207,222,204,159,94,17,-59,-122,-165,-184,-176,-143,-90,-28,36,95,133,156,152,129,88,36,-20,-71,-110,-132,-135,-118,-85,-41,7,53,90,113,119,108,82,45,3,-39,-74,-97,-106,-100,-80,-49,-12,26,60,84,96,94,79,53,20,-16,-48,-73,-88,-90,-79,-58,-28,6,38,65,83,90,83,65,37,4,-31,-63,-86,-98,-96,-80,-50,-11,33,76,112,133,135,114,68,2,-78,-161,-229,-260,-226,-92,180,635,1320,-1324};

const xip_fir_v7_2_pattern fir_compiler_HP_chanpats[1] = {P_BASIC};

static xip_fir_v7_2_config gen_fir_compiler_HP_config() {
  xip_fir_v7_2_config config;
  config.name                = "fir_compiler_HP";
  config.filter_type         = 0;
  config.rate_change         = XIP_FIR_INTEGER_RATE;
  config.interp_rate         = 1;
  config.decim_rate          = 1;
  config.zero_pack_factor    = 1;
  config.coeff               = &fir_compiler_HP_coefficients[0];
  config.coeff_padding       = 0;
  config.num_coeffs          = 283;
  config.coeff_sets          = 1;
  config.reloadable          = 0;
  config.is_halfband         = 0;
  config.quantization        = XIP_FIR_QUANTIZED_ONLY;
  config.coeff_width         = 16;
  config.coeff_fract_width   = 0;
  config.chan_seq            = XIP_FIR_BASIC_CHAN_SEQ;
  config.num_channels        = 1;
  config.init_pattern        = fir_compiler_HP_chanpats[0];
  config.num_paths           = 1;
  config.data_width          = 24;
  config.data_fract_width    = 0;
  config.output_rounding_mode= XIP_FIR_TRUNCATE_LSBS;
  config.output_width        = 24;
  config.output_fract_width  = 0,
  config.config_method       = XIP_FIR_CONFIG_SINGLE;
  return config;
}

const xip_fir_v7_2_config fir_compiler_HP_config = gen_fir_compiler_HP_config();

