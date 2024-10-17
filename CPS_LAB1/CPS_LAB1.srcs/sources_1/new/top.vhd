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

signal  div_out :   std_logic_vector(DIV_SIZE-1 downto 0);

signal  AD_CS_INT   :   std_logic;
signal  AD_SCLK_INT :   std_logic;
signal  AD_MCLK_INT :   std_logic;

signal  DA_CS_INT   :   std_logic;
signal  DA_SCLK_INT :   std_logic;
signal  DA_MCLK_INT :   std_logic;

signal  DATA_INT    :   std_logic_vector(REG_SIZE-1 downto 0);

signal  LED_INT     :   std_logic_vector(30 downto  0)  :=  (others=>'0');

signal  load_int        :   std_logic;
signal  shift_out_int   :   std_logic;
signal  shift_in_int    :   std_logic;

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
        prll_o      =>  DATA_INT);

SHIFT_OUT:  shift_register
    GENERIC MAP(
        SIZE    =>  REG_SIZE)
    
    PORT MAP(
        clk_i       =>  CLK100MHZ,
        rst_i       =>  '0',
        en_i        =>  shift_out_int,
        load_i      =>  load_int,
        serial_i    =>  '0',
        prll_i      =>  DATA_INT,
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

LED_LOAD: process(load_int)
begin

    if (rising_edge(load_int)) then
        LED_INT <=  std_logic_vector(abs(signed(DATA_INT(30 downto 0))));
    end if;

end process;

LED     <=  LED_INT(30 downto 15);

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
