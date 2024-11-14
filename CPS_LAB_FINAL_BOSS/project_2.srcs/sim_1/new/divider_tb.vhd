----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.10.2024 15:15:47
-- Design Name: 
-- Module Name: divider_tb - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divider_tb is
--  Port ( );
end divider_tb;

architecture Behavioral of divider_tb is

component divider is
    Generic (
        SIZE    :   natural :=  16);
    Port ( 
        clk_i   :   in  std_logic;
        rst_i   :   in  std_logic;
        q_out   :   out std_logic_vector(SIZE - 1 downto 0));
end component divider;

constant    DIV_SIZE    :   natural :=  24;

signal  clk_i   :   std_logic   :=  '0';
signal  rst_i   :   std_logic   :=  '0';
signal  q_out   :   std_logic_vector(DIV_SIZE-1 downto 0);

begin

DUT:   divider
    GENERIC MAP(
        SIZE    =>  DIV_SIZE)
    PORT MAP(
        clk_i   =>  clk_i,
        rst_i   =>  rst_i,
        q_out   =>  q_out);

clk_i   <=  not clk_i after 5ns;

STIM:   process
begin

    rst_i   <=  '0';
    wait for 100ns;
    rst_i   <=  '1';
    wait for 100ns;
    rst_i   <= '0';
    wait for 500ns;
    
    finish;

end process;

end Behavioral;
