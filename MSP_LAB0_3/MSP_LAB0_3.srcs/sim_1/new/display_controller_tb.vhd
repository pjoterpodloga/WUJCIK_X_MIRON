----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.10.2024 11:02:19
-- Design Name: 
-- Module Name: display_controller_tb - Behavioral
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

entity display_controller_tb is
--  Port ( );
end display_controller_tb;

architecture Behavioral of display_controller_tb is

component display_controller is
    Port (
        clk_i       :   in  std_Logic;
        rst_i       :   in  std_logic;
        digit_i     :   in  std_logic_vector(15 downto 0);
        digit_en_i  :   in  std_logic_vector(3  downto 0);
        led7_an_o   :   out std_logic_vector(3  downto 0);
        led7_seg_o  :   out std_logic_vector(7  downto 0));
end component display_controller;

signal  clk_i       :   std_logic   :=  '0';
signal  rst_i       :   std_logic   :=  '0';
signal  digit_i     :   std_logic_vector(15 downto 0);
signal  led7_an_o   :   std_logic_vector(3  downto 0);
signal  led7_seg_o  :   std_logic_vector(7  downto 0);

signal  digit_1 :   unsigned(3 downto 0)    :=  (others=>'0');
signal  digit_2 :   unsigned(3 downto 0)    :=  (others=>'0');
signal  digit_3 :   unsigned(3 downto 0)    :=  (others=>'0');
signal  digit_4 :   unsigned(3 downto 0)    :=  (others=>'0');

signal  digit_en_i  :   std_logic_vector(3 downto 0)    :=  (others=>'0');

begin

DUT:    display_controller
    PORT MAP(
        clk_i   =>  clk_i,
        rst_i   =>  rst_i,
        digit_i =>  digit_i,
        digit_en_i  =>  digit_en_i,
        led7_an_o   =>  led7_an_o,
        led7_seg_o  =>  led7_seg_o);

clk_i   <=  not clk_i after 5ns;

digit_i <=  std_logic_vector(digit_4&digit_3&digit_2&digit_1);

STIM:   process
begin

    rst_i   <=  '0';

    digit_en_i  <=  "0001";
    
    for i in 16 downto 0 loop
        digit_1 <=  digit_1 + 1;
        wait for 10 ms;
    end loop;
    
        digit_en_i  <=  "1111";
    
    for i in 14 downto 0 loop
        digit_2 <=  digit_2 + 1;
        wait for 10 ms;
    end loop;
    
    rst_i   <=  '1';
    wait for 10ms;
    rst_i   <=  '0';
    
    for i in 16 downto 0 loop
        digit_3 <=  digit_3 + 1;
        wait for 10 ms;
    end loop;
    
    for i in 14 downto 0 loop
        digit_4 <=  digit_4 + 1;
        wait for 10 ms;
    end loop;
    
    digit_en_i  <=  "1110";
    
    wait for 10ms;

    finish;
end process;

end Behavioral;
