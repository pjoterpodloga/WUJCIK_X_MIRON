----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2024 10:25:41 AM
-- Design Name: 
-- Module Name: shift_register - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shift_register is
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
end shift_register;

architecture Behavioral of shift_register is

signal  q_int   :   std_logic_vector(SIZE-1 downto 0) := (others=>'0');

begin

SHIFT:  process(clk_i, rst_i)
begin

    if (rst_i = '1') then
        q_int <= (others=>'0');
    elsif (rising_edge(clk_i)) then
        if (en_i = '1' and load_i = '1') then
            q_int <= prll_i;
        elsif (en_i = '1' and load_i = '0') then
            q_int(SIZE-1 downto 1) <= q_int(SIZE-2 downto 0);
            q_int(0) <= serial_i;
        end if;
    end if;

end process;

prll_o      <=  q_int;
serial_o    <=  q_int(SIZE-1);

end Behavioral;
