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
           DA_SDIN      :   out   STD_LOGIC;
           LED16_R      :   out   STD_LOGIC;
           LED16_G      :   out   STD_LOGIC;
           LED16_B      :   out   STD_LOGIC;
           LED17_R      :   out   STD_LOGIC;
           LED17_G      :   out   STD_LOGIC;
           LED17_B      :   out   STD_LOGIC);

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

component fir_compiler_LP IS
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
end component fir_compiler_LP;

component fir_compiler_BP IS
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
end component fir_compiler_BP;

component fir_compiler_HP IS
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
end component fir_compiler_HP;

component pwm_controller is
    Generic (
        BIT_RES :   natural :=  8);
        
    Port ( 
        clk_i       :   in  std_logic;
        rst_i       :   in  std_logic;
        read_strobe :   in  std_logic;
        reset_value :   in  std_logic_vector(BIT_RES-1 downto 0);
        pwm_o       :   out std_logic);
end component pwm_controller;

signal  div_out     :   std_logic_vector(DIV_SIZE-1 downto 0);

signal  AD_CS_INT   :   std_logic;
signal  AD_SCLK_INT :   std_logic;
signal  AD_MCLK_INT :   std_logic;

signal  DA_CS_INT   :   std_logic;
signal  DA_SCLK_INT :   std_logic;
signal  DA_MCLK_INT :   std_logic;

signal  DATA_IN_INT :   std_logic_vector(REG_SIZE-1 downto 0);
signal  DATA_OUT_INT:   std_logic_vector(REG_SIZE-1 downto 0);

signal  LED_INT     :   std_logic_vector(30 downto  0)  :=  (others=>'0');

signal  load_int            :   std_logic;
signal  shift_out_int       :   std_logic;
signal  shift_in_int        :   std_logic;

signal  filter_in_LEFT      :   std_logic_vector(23 downto 0)   :=  (others=>'0');
signal  filter_in_RIGHT     :   std_logic_vector(23 downto 0)   :=  (others=>'0');

signal  filter_out_LEFT_LP  :   std_logic_vector(23 downto 0)   :=  (others=>'0');
signal  filter_out_LEFT_BP  :   std_logic_vector(23 downto 0)   :=  (others=>'0');
signal  filter_out_LEFT_HP  :   std_logic_vector(23 downto 0)   :=  (others=>'0');

signal  filter_out_RIGHT_LP :   std_logic_vector(23 downto 0)   :=  (others=>'0');
signal  filter_out_RIGHT_BP :   std_logic_vector(23 downto 0)   :=  (others=>'0');
signal  filter_out_RIGHT_HP :   std_logic_vector(23 downto 0)   :=  (others=>'0');

signal  data_valid_LEFT     :   std_logic;
signal  data_valid_RIGHT    :   std_logic;

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

LEFT_LP: fir_compiler_LP
    PORT MAP(
    aclk                =>  CLK100MHZ,
    s_axis_data_tvalid  =>  data_valid_LEFT,
    s_axis_data_tready  =>  open,
    s_axis_data_tdata   =>  filter_in_LEFT,
    m_axis_data_tvalid  =>  open,
    m_axis_data_tdata   =>  filter_out_LEFT_LP);

PWM_LEFT_R: pwm_controller
    Generic MAP(
        BIT_RES =>  8)
        
    Port MAP( 
        clk_i       =>  CLK100MHZ,
        rst_i       =>  '0',
        read_strobe =>  load_int,
        reset_value =>  filter_out_LEFT_LP(23 downto 16),
        pwm_o       =>  LED16_R);

LEFT_BP: fir_compiler_BP
    PORT MAP(
    aclk                =>  CLK100MHZ,
    s_axis_data_tvalid  =>  data_valid_LEFT,
    s_axis_data_tready  =>  open,
    s_axis_data_tdata   =>  filter_in_LEFT,
    m_axis_data_tvalid  =>  open,
    m_axis_data_tdata   =>  filter_out_LEFT_BP);

PWM_LEFT_G: pwm_controller
    Generic MAP(
        BIT_RES =>  8)
        
    Port MAP( 
        clk_i       =>  CLK100MHZ,
        rst_i       =>  '0',
        read_strobe =>  load_int,
        reset_value =>  filter_out_LEFT_BP(23 downto 16),
        pwm_o       =>  LED16_G);
       
LEFT_HP: fir_compiler_HP
    PORT MAP(
    aclk                =>  CLK100MHZ,
    s_axis_data_tvalid  =>  data_valid_LEFT,
    s_axis_data_tready  =>  open,
    s_axis_data_tdata   =>  filter_in_LEFT,
    m_axis_data_tvalid  =>  open,
    m_axis_data_tdata   =>  filter_out_LEFT_HP);
        
PWM_LEFT_B: pwm_controller
    Generic MAP(
        BIT_RES =>  8)
        
    Port MAP( 
        clk_i       =>  CLK100MHZ,
        rst_i       =>  '0',
        read_strobe =>  load_int,
        reset_value =>  filter_out_LEFT_HP(23 downto 16),
        pwm_o       =>  LED16_B);
        
PWM_RIGHT_R: pwm_controller
    Generic MAP(
        BIT_RES =>  8)
        
    Port MAP( 
        clk_i       =>  CLK100MHZ,
        rst_i       =>  '0',
        read_strobe =>  load_int,
        reset_value =>  filter_out_RIGHT_LP(23 downto 16),
        pwm_o       =>  LED17_R);

RIGHT_LP: fir_compiler_HP
    PORT MAP(
    aclk                =>  CLK100MHZ,
    s_axis_data_tvalid  =>  data_valid_RIGHT,
    s_axis_data_tready  =>  open,
    s_axis_data_tdata   =>  filter_in_RIGHT,
    m_axis_data_tvalid  =>  open,
    m_axis_data_tdata   =>  filter_out_RIGHT_LP);

PWM_RIGHT_G: pwm_controller
    Generic MAP(
        BIT_RES =>  8)
        
    Port MAP( 
        clk_i       =>  CLK100MHZ,
        rst_i       =>  '0',
        read_strobe =>  load_int,
        reset_value =>  filter_out_RIGHT_BP(23 downto 16),
        pwm_o       =>  LED17_G);
   
RIGHT_BP: fir_compiler_HP
    PORT MAP(
    aclk                =>  CLK100MHZ,
    s_axis_data_tvalid  =>  data_valid_RIGHT,
    s_axis_data_tready  =>  open,
    s_axis_data_tdata   =>  filter_in_RIGHT,
    m_axis_data_tvalid  =>  open,
    m_axis_data_tdata   =>  filter_out_RIGHT_BP);
        
PWM_RIGHT_B: pwm_controller
    Generic MAP(
        BIT_RES =>  8)
        
    Port MAP( 
        clk_i       =>  CLK100MHZ,
        rst_i       =>  '0',
        read_strobe =>  load_int,
        reset_value =>  filter_out_RIGHT_HP(23 downto 16),
        pwm_o       =>  LED17_B);

RIGHT_HP: fir_compiler_HP
    PORT MAP(
    aclk                =>  CLK100MHZ,
    s_axis_data_tvalid  =>  data_valid_RIGHT,
    s_axis_data_tready  =>  open,
    s_axis_data_tdata   =>  filter_in_RIGHT,
    m_axis_data_tvalid  =>  open,
    m_axis_data_tdata   =>  filter_out_RIGHT_HP);
        
LED_LOAD: process(load_int)
begin

    if (rising_edge(load_int)) then
        LED_INT <=  std_logic_vector(abs(signed(DATA_OUT_INT(30 downto 0))));
        
        if (AD_CS_INT = '0') then
            filter_in_RIGHT <=  LED_INT(30 downto 7);
            
            DATA_OUT_INT(31)            <=  '0';
            DATA_OUT_INT(30 downto 7)   <=  filter_out_RIGHT_BP;
            DATA_OUT_INT(6 downto 0)    <=  (others=>'0');
        else
            filter_in_LEFT  <=  LED_INT(30 downto 7);
            
            DATA_OUT_INT(31)            <=  '0';
            DATA_OUT_INT(30 downto 7)   <=  filter_out_LEFT_BP;
            DATA_OUT_INT(6 downto 0)    <=  (others=>'0');
        end if;
        
    end if;

end process;

data_valid_LEFT     <=  load_int and AD_CS_INT;
data_valid_RIGHT    <=  load_int and not AD_CS_INT;

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
