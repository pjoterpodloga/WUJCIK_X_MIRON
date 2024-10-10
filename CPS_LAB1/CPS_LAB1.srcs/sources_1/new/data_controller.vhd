----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2024 10:49:05 AM
-- Design Name: 
-- Module Name: data_controller - Behavioral
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

entity data_controller is
    Port (
        clk_i           :   in  std_logic;
        rst_i           :   in  std_logic;
        div_clk_i       :   in  std_logic_vector(11 downto 0);
        shift_in_en_o   :   out std_logic;
        shift_out_en_o  :   out std_logic;
        load_out_o      :   out std_logic);
end data_controller;

architecture Behavioral of data_controller is

signal  shift_in_en :   std_logic   :=  '0';
signal  shift_out_en:   std_logic   :=  '0';
signal  load_out    :   std_logic   :=  '0';

begin

CONTROL:    process(clk_i, rst_i)
begin

    if (rst_i = '1') then
        shift_in_en     <=  '0';
        shift_out_en    <=  '0';
        load_out        <=  '0';
    elsif (rising_edge(clk_i)) then
        if (div_clk_i(4 downto 0) = "01111") then
            shift_in_en <= '1';
            shift_out_en<= '1';
        else
            shift_in_en <= '0';
            shift_out_en<= '0';
        end if;
        
        if ((div_clk_i(10 downto 0) = '0'&(9 downto 0=>'1')) or (div_clk_i(11 downto 0) = '0'&(10 downto 0=>'1'))) then
            load_out    <=  '1';
            shift_out_en<=  '1';
        else
            load_out    <=  '0';
        end if;
    end if;

end process;
shift_in_en_o   <=  shift_in_en;
shift_out_en_o  <=  shift_out_en;
load_out_o      <=  load_out;

end Behavioral;
