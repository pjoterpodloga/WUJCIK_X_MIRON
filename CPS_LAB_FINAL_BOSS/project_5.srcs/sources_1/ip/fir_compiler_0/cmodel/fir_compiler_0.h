
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
// C Model configuration for the "fir_compiler_0" instance.
//
//------------------------------------------------------------------------------
//
// coefficients: -171,-18,-19,-19,-20,-21,-22,-23,-24,-25,-26,-27,-27,-28,-29,-30,-31,-32,-32,-33,-34,-35,-35,-36,-37,-37,-38,-38,-39,-39,-39,-40,-40,-40,-40,-40,-40,-40,-40,-40,-40,-39,-39,-38,-38,-37,-36,-36,-35,-34,-32,-31,-30,-28,-27,-25,-24,-22,-20,-18,-16,-13,-11,-9,-6,-3,-1,2,5,9,12,15,19,22,26,30,34,37,42,46,50,54,59,64,68,73,78,83,88,93,98,103,108,114,119,125,130,136,141,147,153,159,164,170,176,182,188,194,199,205,211,217,223,229,234,240,246,251,257,263,268,274,279,284,289,295,300,305,310,314,319,324,328,332,337,341,345,349,352,356,359,363,366,369,372,374,377,379,381,383,385,387,388,390,391,392,393,393,394,394,394,394,394,393,393,392,391,390,388,387,385,383,381,379,377,374,372,369,366,363,359,356,352,349,345,341,337,332,328,324,319,314,310,305,300,295,289,284,279,274,268,263,257,251,246,240,234,229,223,217,211,205,199,194,188,182,176,170,164,159,153,147,141,136,130,125,119,114,108,103,98,93,88,83,78,73,68,64,59,54,50,46,42,37,34,30,26,22,19,15,12,9,5,2,-1,-3,-6,-9,-11,-13,-16,-18,-20,-22,-24,-25,-27,-28,-30,-31,-32,-34,-35,-36,-36,-37,-38,-38,-39,-39,-40,-40,-40,-40,-40,-40,-40,-40,-40,-40,-39,-39,-39,-38,-38,-37,-37,-36,-35,-35,-34,-33,-32,-32,-31,-30,-29,-28,-27,-27,-26,-25,-24,-23,-22,-21,-20,-19,-19,-18,-171
// chanpats: 173
// name: fir_compiler_0
// filter_type: 0
// rate_change: 0
// interp_rate: 1
// decim_rate: 1
// zero_pack_factor: 1
// coeff_padding: 0
// num_coeffs: 321
// coeff_sets: 1
// reloadable: 0
// is_halfband: 0
// quantization: 0
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

const double fir_compiler_0_coefficients[321] = {-171,-18,-19,-19,-20,-21,-22,-23,-24,-25,-26,-27,-27,-28,-29,-30,-31,-32,-32,-33,-34,-35,-35,-36,-37,-37,-38,-38,-39,-39,-39,-40,-40,-40,-40,-40,-40,-40,-40,-40,-40,-39,-39,-38,-38,-37,-36,-36,-35,-34,-32,-31,-30,-28,-27,-25,-24,-22,-20,-18,-16,-13,-11,-9,-6,-3,-1,2,5,9,12,15,19,22,26,30,34,37,42,46,50,54,59,64,68,73,78,83,88,93,98,103,108,114,119,125,130,136,141,147,153,159,164,170,176,182,188,194,199,205,211,217,223,229,234,240,246,251,257,263,268,274,279,284,289,295,300,305,310,314,319,324,328,332,337,341,345,349,352,356,359,363,366,369,372,374,377,379,381,383,385,387,388,390,391,392,393,393,394,394,394,394,394,393,393,392,391,390,388,387,385,383,381,379,377,374,372,369,366,363,359,356,352,349,345,341,337,332,328,324,319,314,310,305,300,295,289,284,279,274,268,263,257,251,246,240,234,229,223,217,211,205,199,194,188,182,176,170,164,159,153,147,141,136,130,125,119,114,108,103,98,93,88,83,78,73,68,64,59,54,50,46,42,37,34,30,26,22,19,15,12,9,5,2,-1,-3,-6,-9,-11,-13,-16,-18,-20,-22,-24,-25,-27,-28,-30,-31,-32,-34,-35,-36,-36,-37,-38,-38,-39,-39,-40,-40,-40,-40,-40,-40,-40,-40,-40,-40,-39,-39,-39,-38,-38,-37,-37,-36,-35,-35,-34,-33,-32,-32,-31,-30,-29,-28,-27,-27,-26,-25,-24,-23,-22,-21,-20,-19,-19,-18,-171};

const xip_fir_v7_2_pattern fir_compiler_0_chanpats[1] = {P_BASIC};

static xip_fir_v7_2_config gen_fir_compiler_0_config() {
  xip_fir_v7_2_config config;
  config.name                = "fir_compiler_0";
  config.filter_type         = 0;
  config.rate_change         = XIP_FIR_INTEGER_RATE;
  config.interp_rate         = 1;
  config.decim_rate          = 1;
  config.zero_pack_factor    = 1;
  config.coeff               = &fir_compiler_0_coefficients[0];
  config.coeff_padding       = 0;
  config.num_coeffs          = 321;
  config.coeff_sets          = 1;
  config.reloadable          = 0;
  config.is_halfband         = 0;
  config.quantization        = XIP_FIR_INTEGER_COEFF;
  config.coeff_width         = 16;
  config.coeff_fract_width   = 0;
  config.chan_seq            = XIP_FIR_BASIC_CHAN_SEQ;
  config.num_channels        = 1;
  config.init_pattern        = fir_compiler_0_chanpats[0];
  config.num_paths           = 1;
  config.data_width          = 24;
  config.data_fract_width    = 0;
  config.output_rounding_mode= XIP_FIR_TRUNCATE_LSBS;
  config.output_width        = 24;
  config.output_fract_width  = 0,
  config.config_method       = XIP_FIR_CONFIG_SINGLE;
  return config;
}

const xip_fir_v7_2_config fir_compiler_0_config = gen_fir_compiler_0_config();

