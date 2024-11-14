----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2024 21:44:40
-- Design Name: 
-- Module Name: pwm_tb - Behavioral
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

entity pwm_tb is
--  Port ( );
end pwm_tb;

architecture Behavioral of pwm_tb is

component pwm_controller is
    Generic (
        BIT_RES :   natural);
        
    Port ( 
        clk_i       :   in  std_logic;
        rst_i       :   in  std_logic;
        read_strobe :   in  std_logic;
        reset_value :   in  std_logic_vector(BIT_RES-1 downto 0);
        pwm_o       :   out std_logic);
end component pwm_controller;

signal clk_i        :   std_logic   :=  '0';
signal rst_i        :   std_logic   :=  '0';
signal read_strobe  :   std_logic   :=  '0';
signal reset_value  :   std_logic_vector(7 downto 0)   :=  (others=>'0');
signal pwm_o        :   std_logic;

begin

DUT: pwm_controller
    GENERIC MAP (
        BIT_RES =>  8)
        
    PORT MAP (
        clk_i   =>  clk_i,
        rst_i   =>  rst_i,
        read_strobe =>  read_strobe,
        reset_value =>  reset_value,
        pwm_o   =>  pwm_o);

clk_i   <=  not clk_i after 5ns;

STIM: process
begin
    
    wait for 10ns;
    rst_i   <=  '0';
    
    reset_value <=  "0100"&"0000";
    wait for 10ns;
    read_strobe <=  '1';
    wait for 10ns;
    read_strobe <=  '0'; 
    wait for 10us;
    rst_i   <=  '1';
    wait for 10us;
    rst_i   <=  '0';
    wait for 10ns;
    read_strobe <=  '1';
    wait for 10ns;
    read_strobe <=  '0';
    reset_value <=  "1000"&"0000";
    wait for 3000us;
    read_strobe <=  '1';
    wait for 10ns;
    read_strobe <=  '0';
    wait for 10000us;
    read_strobe <=  '0';
    reset_value <=  "1100"&"0000";
    wait for 3000us;
    read_strobe <=  '1';
    wait for 10ns;
    read_strobe <=  '0';
    wait for 10000us;

    finish;
end process;


end Behavioral;
