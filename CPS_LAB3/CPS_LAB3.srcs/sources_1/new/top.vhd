----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2024 10:33:44 AM
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is

    Port ( CLK100MHZ    :   in    STD_LOGIC;
           LED          :   out   STD_LOGIC_VECTOR (15 downto 0);
           AD_MCLK      :   out   STD_LOGIC;
           AD_LRCK      :   out   STD_LOGIC;
           AD_SCLK      :   out   STD_LOGIC;
           AD_SDOUT     :   in    STD_LOGIC;
           DA_MCLK      :   out   STD_LOGIC;
           DA_LRCK      :   out   STD_LOGIC;
           DA_SCLK      :   out   STD_LOGIC;
           DA_SDIN      :   out   STD_LOGIC);

end top;

architecture Behavioral of top is

constant    DIV_SIZE    :   natural := 12;
constant    REG_SIZE    :   natural := 32;

component divider is
    Generic (
        SIZE    :   natural :=  16);
    Port ( 
        clk_i   :   in  std_logic;
        rst_i   :   in  std_logic;
        q_out   :   out std_logic_vector(SIZE - 1 downto 0));
end component divider;

component shift_register is
    Generic (
        SIZE    :   natural :=  32);
    Port ( 
        clk_i       :   in  std_logic;
        rst_i       :   in  std_logic;
        en_i        :   in  std_logic;
        load_i      :   in  std_logic;
        serial_i    :   in  std_logic;
        prll_i      :   in  std_logic_vector(SIZE-1 downto 0);
        serial_o    :   out std_logic;
        prll_o      :   out std_logic_vector(SIZE-1 downto 0));
end component shift_register;

component data_controller is
    Port (
        clk_i           :   in  std_logic;
        rst_i           :   in  std_logic;
        div_clk_i       :   in  std_logic_vector(11 downto 0);
        shift_in_en_o   :   out std_logic;
        shift_out_en_o  :   out std_logic;
        load_out_o      :   out std_logic);
end component data_controller;

component cic_compiler_0 IS
  PORT (
    aclk                : IN    STD_LOGIC;
    s_axis_data_tdata   : IN    STD_LOGIC_VECTOR(23 DOWNTO 0);
    s_axis_data_tvalid  : IN    STD_LOGIC;
    s_axis_data_tready  : OUT   STD_LOGIC;
    m_axis_data_tdata   : OUT   STD_LOGIC_VECTOR(23 DOWNTO 0);
    m_axis_data_tvalid  : OUT   STD_LOGIC
  );
end component cic_compiler_0;

signal  div_out :   std_logic_vector(DIV_SIZE-1 downto 0);

signal  AD_CS_INT   :   std_logic;
signal  AD_SCLK_INT :   std_logic;
signal  AD_MCLK_INT :   std_logic;

signal  DA_CS_INT   :   std_logic;
signal  DA_SCLK_INT :   std_logic;
signal  DA_MCLK_INT :   std_logic;

signal  DATA_IN_INT :   std_logic_vector(REG_SIZE-1 downto 0);
signal  DATA_OUT_INT:   std_logic_vector(REG_SIZE-1 downto 0);

signal  LED_INT     :   std_logic_vector(30 downto  0)  :=  (others=>'0');

signal  FDATA_IN    :   std_logic_vector(23 downto 0)   :=  (others=>'0');
signal  FDATA_OUT   :   std_logic_vector(23 downto 0)   :=  (others=>'0');

signal  load_int        :   std_logic;
signal  shift_out_int   :   std_logic;
signal  shift_in_int    :   std_logic;

signal  counter :   natural range 9 downto 0    :=  0;
signal  fdata_valid :   std_logic   :=  '0';

begin

SHIFT_IN:   shift_register
    GENERIC MAP(
        SIZE    =>  REG_SIZE)
    
    PORT MAP(
        clk_i       =>  CLK100MHZ,
        rst_i       =>  '0',
        en_i        =>  shift_in_int,
        load_i      =>  '0',
        serial_i    =>  AD_SDOUT,
        prll_i      =>  (others=>'0'),
        serial_o    =>  open,
        prll_o      =>  DATA_IN_INT);

SHIFT_OUT:  shift_register
    GENERIC MAP(
        SIZE    =>  REG_SIZE)
    
    PORT MAP(
        clk_i       =>  CLK100MHZ,
        rst_i       =>  '0',
        en_i        =>  shift_out_int,
        load_i      =>  load_int,
        serial_i    =>  '0',
        prll_i      =>  DATA_OUT_INT,
        serial_o    =>  DA_SDIN,
        prll_o      =>  open);

FREG_DIV:   divider
    GENERIC MAP(
        SIZE    =>  DIV_SIZE)
    PORT MAP(
        clk_i   =>  CLK100MHZ,
        rst_i   =>  '0',
        q_out   =>  div_out);

CONTROLER:  data_controller
    PORT MAP(
        clk_i       =>  CLK100MHZ,
        rst_i       =>  '0',
        div_clk_i   =>  div_out,
        shift_in_en_o   =>  shift_in_int,
        shift_out_en_o  =>  shift_out_int,
        load_out_o      =>  load_int);

CIC: cic_compiler_0
  PORT MAP(
    aclk                =>  CLK100MHZ,
    s_axis_data_tdata   =>  FDATA_IN,
    s_axis_data_tvalid  =>  fdata_valid,
    s_axis_data_tready  =>  open,
    m_axis_data_tdata   =>  FDATA_OUT,
    m_axis_data_tvalid  =>  open);

LED_LOAD: process(load_int)
begin

    if (rising_edge(load_int)) then
        LED_INT <=  std_logic_vector(abs(signed(DATA_OUT_INT(30 downto 0))));
        
        if (AD_CS_INT = '1') then
        
            counter <= counter + 1;
        
            if(counter = 0) then
                FDATA_IN    <= DATA_IN_INT(30 downto 7);
            elsif (counter = 7) then
                counter <= 0;
            end if;
            
            DATA_OUT_INT(6  downto 0)   <=  (others=>'0');
            DATA_OUT_INT(30 downto 7)   <=  FDATA_OUT;
            DATA_OUT_INT(31)            <=  '0';
        else 
            DATA_OUT_INT<= (others=>'0');
        end if;
        
    end if;

end process;

LED     <=  LED_INT(30 downto 15);

fdata_valid <=  load_int and AD_CS_INT;

AD_CS_INT   <=  div_out(10);
AD_SCLK_INT <=  div_out(4);
AD_MCLK_INT <=  div_out(2);

DA_CS_INT   <=  not div_out(10);
DA_SCLK_INT <=  div_out(4);
DA_MCLK_INT <=  div_out(2);

AD_LRCK <=  AD_CS_INT;
AD_SCLK <=  AD_SCLK_INT;
AD_MCLK <=  AD_MCLK_INT;

DA_LRCK <=  DA_CS_INT;
DA_SCLK <=  DA_SCLK_INT;
DA_MCLK <=  DA_MCLK_INT;

end Behavioral;
