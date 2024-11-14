
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
// C Model configuration for the "fir_compiler_BP" instance.
//
//------------------------------------------------------------------------------
//
// coefficients: -193,-77,-86,-92,-94,-92,-87,-81,-74,-68,-63,-62,-64,-68,-74,-79,-82,-80,-72,-55,-29,5,46,92,139,183,220,246,258,255,235,202,157,105,52,2,-39,-66,-77,-71,-49,-13,31,80,126,165,192,204,200,182,151,113,72,34,4,-14,-18,-9,12,42,76,107,132,146,147,133,107,70,29,-12,-46,-70,-79,-73,-52,-20,19,58,91,112,117,104,72,26,-31,-91,-146,-191,-218,-225,-210,-176,-128,-73,-20,23,47,49,25,-24,-92,-172,-255,-329,-386,-417,-418,-388,-332,-257,-174,-96,-35,-3,-6,-47,-124,-229,-349,-471,-577,-653,-685,-669,-603,-493,-354,-203,-61,48,106,99,19,-130,-336,-578,-827,-1048,-1208,-1275,-1223,-1038,-715,-267,284,902,1542,2157,2697,3119,3387,3479,3387,3119,2697,2157,1542,902,284,-267,-715,-1038,-1223,-1275,-1208,-1048,-827,-578,-336,-130,19,99,106,48,-61,-203,-354,-493,-603,-669,-685,-653,-577,-471,-349,-229,-124,-47,-6,-3,-35,-96,-174,-257,-332,-388,-418,-417,-386,-329,-255,-172,-92,-24,25,49,47,23,-20,-73,-128,-176,-210,-225,-218,-191,-146,-91,-31,26,72,104,117,112,91,58,19,-20,-52,-73,-79,-70,-46,-12,29,70,107,133,147,146,132,107,76,42,12,-9,-18,-14,4,34,72,113,151,182,200,204,192,165,126,80,31,-13,-49,-71,-77,-66,-39,2,52,105,157,202,235,255,258,246,220,183,139,92,46,5,-29,-55,-72,-80,-82,-79,-74,-68,-64,-62,-63,-68,-74,-81,-87,-92,-94,-92,-86,-77,-193
// chanpats: 173
// name: fir_compiler_BP
// filter_type: 0
// rate_change: 0
// interp_rate: 1
// decim_rate: 1
// zero_pack_factor: 1
// coeff_padding: 0
// num_coeffs: 303
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

const double fir_compiler_BP_coefficients[303] = {-193,-77,-86,-92,-94,-92,-87,-81,-74,-68,-63,-62,-64,-68,-74,-79,-82,-80,-72,-55,-29,5,46,92,139,183,220,246,258,255,235,202,157,105,52,2,-39,-66,-77,-71,-49,-13,31,80,126,165,192,204,200,182,151,113,72,34,4,-14,-18,-9,12,42,76,107,132,146,147,133,107,70,29,-12,-46,-70,-79,-73,-52,-20,19,58,91,112,117,104,72,26,-31,-91,-146,-191,-218,-225,-210,-176,-128,-73,-20,23,47,49,25,-24,-92,-172,-255,-329,-386,-417,-418,-388,-332,-257,-174,-96,-35,-3,-6,-47,-124,-229,-349,-471,-577,-653,-685,-669,-603,-493,-354,-203,-61,48,106,99,19,-130,-336,-578,-827,-1048,-1208,-1275,-1223,-1038,-715,-267,284,902,1542,2157,2697,3119,3387,3479,3387,3119,2697,2157,1542,902,284,-267,-715,-1038,-1223,-1275,-1208,-1048,-827,-578,-336,-130,19,99,106,48,-61,-203,-354,-493,-603,-669,-685,-653,-577,-471,-349,-229,-124,-47,-6,-3,-35,-96,-174,-257,-332,-388,-418,-417,-386,-329,-255,-172,-92,-24,25,49,47,23,-20,-73,-128,-176,-210,-225,-218,-191,-146,-91,-31,26,72,104,117,112,91,58,19,-20,-52,-73,-79,-70,-46,-12,29,70,107,133,147,146,132,107,76,42,12,-9,-18,-14,4,34,72,113,151,182,200,204,192,165,126,80,31,-13,-49,-71,-77,-66,-39,2,52,105,157,202,235,255,258,246,220,183,139,92,46,5,-29,-55,-72,-80,-82,-79,-74,-68,-64,-62,-63,-68,-74,-81,-87,-92,-94,-92,-86,-77,-193};

const xip_fir_v7_2_pattern fir_compiler_BP_chanpats[1] = {P_BASIC};

static xip_fir_v7_2_config gen_fir_compiler_BP_config() {
  xip_fir_v7_2_config config;
  config.name                = "fir_compiler_BP";
  config.filter_type         = 0;
  config.rate_change         = XIP_FIR_INTEGER_RATE;
  config.interp_rate         = 1;
  config.decim_rate          = 1;
  config.zero_pack_factor    = 1;
  config.coeff               = &fir_compiler_BP_coefficients[0];
  config.coeff_padding       = 0;
  config.num_coeffs          = 303;
  config.coeff_sets          = 1;
  config.reloadable          = 0;
  config.is_halfband         = 0;
  config.quantization        = XIP_FIR_INTEGER_COEFF;
  config.coeff_width         = 16;
  config.coeff_fract_width   = 0;
  config.chan_seq            = XIP_FIR_BASIC_CHAN_SEQ;
  config.num_channels        = 1;
  config.init_pattern        = fir_compiler_BP_chanpats[0];
  config.num_paths           = 1;
  config.data_width          = 24;
  config.data_fract_width    = 0;
  config.output_rounding_mode= XIP_FIR_TRUNCATE_LSBS;
  config.output_width        = 24;
  config.output_fract_width  = 0,
  config.config_method       = XIP_FIR_CONFIG_SINGLE;
  return config;
}

const xip_fir_v7_2_config fir_compiler_BP_config = gen_fir_compiler_BP_config();

