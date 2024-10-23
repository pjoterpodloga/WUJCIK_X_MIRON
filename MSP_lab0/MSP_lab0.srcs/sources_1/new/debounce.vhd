----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.10.2024 20:18:44
-- Design Name: 
-- Module Name: debounce - Behavioral
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

entity debounce is
    Generic (
        WAIT_MS     :   natural :=  100);
    Port (
        clk_i       :   in  std_logic;
        rst_i       :   in  std_logic;
        button_i    :   in  std_logic_vector;
        button_o    :   out std_logic_vector);
end debounce;

architecture Behavioral of debounce is

component divider is
    Generic (
        NDIV    :   natural :=  100_000);
    Port (
        clk_i   :   in  std_logic;
        rst_i   :   in  std_logic;
        clk_o   :   out std_logic);
            
end component divider;

constant NDIV   :   natural :=  100_000;

type    narray is array(button_i'range) of natural range WAIT_MS+1 downto 0;

signal  sw_int_1        :   std_logic_vector(button_i'range)    :=  (others=>'0');
signal  sw_int_2        :   std_logic_vector(button_i'range)    :=  (others=>'0');
signal  button_debounce :   std_logic_vector(button_i'range)    :=  (others=>'0');

signal  counter :   narray  :=  (others=>0);

signal  clk_last_state  :   std_logic   :=  '0';

signal  div_out :   std_logic;

begin

DIV: divider
    GENERIC MAP(
        NDIV    =>  NDIV)
    PORT MAP(
        clk_i   =>  clk_i,
        rst_i   =>  rst_i,
        clk_o   =>  div_out);

COUNT:  process(clk_i, rst_i)
begin

    if (rst_i = '1') then
        sw_int_1    <=  (others=>'0');
        sw_int_2    <=  (others=>'0');
        counter     <=  (others=> 0 );
        button_debounce <=  (others=>'0');
    elsif (rising_edge(clk_i)) then
            
        sw_int_1 <= button_i;
        sw_int_2 <= sw_int_1;
        
        
        if (div_out = '0') then
            clk_last_state <= '0';
        
        elsif (clk_last_state /= div_out) then
        
            clk_last_state <= '1';
        
            for i in button_i'range loop
            
                if (sw_int_2(i) = '1' and counter(i) /= WAIT_MS) then
                    counter(i) <= counter(i) + 1;
                elsif (counter(i) = WAIT_MS) then
                    button_debounce(i) <= '1';
                elsif (sw_int_2(i) = '0')  then
                    counter(i) <= 0;
                    button_debounce(i) <= '0';
                end if;

            end loop;
            
        end if;
    
    end if;

end process;

button_o <= button_debounce;

end Behavioral;
