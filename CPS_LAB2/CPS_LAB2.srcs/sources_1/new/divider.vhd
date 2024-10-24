----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2024 10:19:42 AM
-- Design Name: 
-- Module Name: divider - Behavioral
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

entity divider is
    Generic (
        SIZE    :   natural :=  16);
    Port ( 
        clk_i   :   in  std_logic;
        rst_i   :   in  std_logic;
        q_out   :   out std_logic_vector(SIZE - 1 downto 0));
end divider;

architecture Behavioral of divider is

signal  q_int   :   unsigned(SIZE-1 downto 0)   :=  (others=>'0');

begin

COUNTING:   process(clk_i, rst_i)
begin

    if(rst_i = '1') then
        q_int <= (others=>'0');
    elsif (rising_edge(clk_i)) then
    
        q_int <= q_int + 1;
    
    end if;

end process;

q_out   <=  std_logic_vector(q_int);

end Behavioral;
