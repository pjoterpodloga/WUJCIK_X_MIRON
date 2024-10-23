----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.10.2024 21:31:04
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
        NDIV    :   natural :=  100);
    Port (
        clk_i   :   in  std_logic;
        rst_i   :   in  std_logic;
        clk_o   :   out std_logic);
        
end divider;

architecture Behavioral of divider is

signal  q_count :   natural range   0   to  (NDIV + 1) :=  0;
signal  clk_int :   std_logic   :=  '0';

begin

    COUNT:  process(clk_i, rst_i)
    begin
        
        if rst_i = '1' then
            q_count <= 0;
        elsif rising_edge(clk_i) then
            q_count <= q_count + 1;  

            if q_count = NDIV/2 then
                clk_int <=  '1';
            elsif q_count = NDIV then
                q_count <= 0;
                clk_int <= '0';
            end if;    
        end if;
        
    
    end process;

    clk_o   <=  clk_int;

end Behavioral;
