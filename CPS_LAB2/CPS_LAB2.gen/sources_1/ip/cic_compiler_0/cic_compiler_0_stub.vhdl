-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
-- Date        : Thu Oct 24 14:34:58 2024
-- Host        : DESKTOP-SM94CAU running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               p:/VHDL/WUJCIK_X_MIRON/CPS_LAB2/CPS_LAB2.gen/sources_1/ip/cic_compiler_0/cic_compiler_0_stub.vhdl
-- Design      : cic_compiler_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cic_compiler_0 is
  Port ( 
    aclk : in STD_LOGIC;
    s_axis_data_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    s_axis_data_tvalid : in STD_LOGIC;
    s_axis_data_tready : out STD_LOGIC;
    m_axis_data_tdata : out STD_LOGIC_VECTOR ( 23 downto 0 );
    m_axis_data_tvalid : out STD_LOGIC
  );

end cic_compiler_0;

architecture stub of cic_compiler_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "aclk,s_axis_data_tdata[23:0],s_axis_data_tvalid,s_axis_data_tready,m_axis_data_tdata[23:0],m_axis_data_tvalid";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "cic_compiler_v4_0_16,Vivado 2022.2";
begin
end;
