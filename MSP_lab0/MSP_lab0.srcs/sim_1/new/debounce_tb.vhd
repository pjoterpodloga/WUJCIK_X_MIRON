----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.10.2024 21:25:52
-- Design Name: 
-- Module Name: debounce_tb - Behavioral
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
use std.env.finish;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce_tb is
--  Port ( );
end debounce_tb;

architecture Behavioral of debounce_tb is

component debounce is
    Generic (
        WAIT_MS     :   natural :=  100);
    Port (
        clk_i       :   in  std_logic;
        rst_i       :   in  std_logic;
        button_i    :   in  std_logic_vector;
        button_o    :   out std_logic_vector);
end component debounce;

signal  clk_i       :   std_logic   :=  '0';
signal  rst_i       :   std_logic   :=  '0';
signal  button_i    :   std_logic_vector(1 downto 0)        :=  (others=>'0');
signal  button_o    :   std_logic_vector(button_i'range)    :=  (others=>'0');

begin

DUT: debounce
    GENERIC MAP(
        WAIT_MS =>  50)
    
    PORT MAP(
        clk_i       =>  clk_i,
        rst_i       =>  rst_i,
        button_i    =>  button_i,
        button_o    =>  button_o);

clk_i   <=  not clk_i after 5 ns;

STIM: process
begin

    wait for 100us;
    wait for 900us;
    button_i(0) <=  '1';
    wait for 10ms;
    button_i(0) <=  '0';
    wait for 2ms;
    button_i(0) <=  '0';
    wait for 8ms;
    button_i(0) <=  '1';
    wait for 200ms;
    rst_i   <=  '1';
    wait for 1ms;
    rst_i   <=  '0';
    wait for 9ms;
    wait for 190ms;

    finish;
end process;

end Behavioral;
