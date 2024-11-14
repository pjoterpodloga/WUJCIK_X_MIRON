----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2024 21:26:24
-- Design Name: 
-- Module Name: pwm_controller - Behavioral
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
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm_controller is
    Generic (
        BIT_RES :   natural :=  8);
        
    Port ( 
        clk_i       :   in  std_logic;
        rst_i       :   in  std_logic;
        read_strobe :   in  std_logic;
        reset_value :   in  std_logic_vector(BIT_RES-1 downto 0);
        pwm_o       :   out std_logic);
end pwm_controller;

architecture Behavioral of pwm_controller is

component divider is
    Generic (
        SIZE    :   natural :=  16);
    Port ( 
        clk_i   :   in  std_logic;
        rst_i   :   in  std_logic;
        q_out   :   out std_logic_vector(SIZE - 1 downto 0));
end component divider;

constant    FREQ_IN     :   real    :=  100.0e6;
constant    MOD_FREQ    :   real    :=  10.0e3;
constant    NDIV        :   natural :=  natural(CEIL(LOG2(FREQ_IN/(MOD_FREQ*(2**real(BIT_RES))))));

signal  last_read   :   std_logic   := '0';

signal  counter         :   unsigned(BIT_RES-1 downto 0)    :=  (others=>'0');
signal  reset_value_int :   unsigned(BIT_RES-1 downto 0)    :=  (others=>'0');
signal  div_out         :   std_logic_vector(NDIV downto 0);

signal pwm_output       :   std_logic   :=  '0';

begin

FREG_DIV:   divider
    GENERIC MAP(
        SIZE    =>  NDIV+1)
    PORT MAP(
        clk_i   =>  clk_i,
        rst_i   =>  rst_i,
        q_out   =>  div_out);

PWM:    process(clk_i, rst_i)
begin

    if (rst_i = '1') then
        counter <= (others=>'0');
        reset_value_int <= (others=>'0');
        pwm_output  <=  '0';
    elsif (rising_edge(clk_i)) then
        if (div_out(NDIV-1 downto 0) = '0'&(NDIV-2 downto 0 => '1')) then
            counter <= counter + 1;
            
            if (counter = reset_value_int) then
                pwm_output   <= '0';
            elsif (counter = (BIT_RES-1 downto 0 => '0')) then
                pwm_output   <= '1';
            elsif (counter = (BIT_RES-1 downto 0 => '1')) then
                counter <= (BIT_RES-1 downto 0 => '0');
            end if;
            
        end if;
        
        if (read_strobe = '0') then
            last_read <= '0';
        elsif (last_read /= read_strobe) then
            last_read <= '1';
            reset_value_int <= unsigned(reset_value);
        end if; 
    end if;

end process;

pwm_o   <=  pwm_output;

end Behavioral;
