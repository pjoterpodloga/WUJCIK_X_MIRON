----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2024 11:21:22 AM
-- Design Name: 
-- Module Name: top_tb - Behavioral
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

entity top_tb is
--  Port ( );
end top_tb;

architecture Behavioral of top_tb is

component top is

    Port ( CLK100MHZ    :   in    STD_LOGIC;
           LED          :   out   STD_LOGIC_VECTOR (15 downto 0);
           AD_MCLK      :   out   STD_LOGIC;
           AD_LRCK      :   out   STD_LOGIC;
           AD_SCLK      :   out   STD_LOGIC;
           AD_SDOUT     :   in    STD_LOGIC;
           DA_MCLK      :   out   STD_LOGIC;
           DA_LRCK      :   out   STD_LOGIC;
           DA_SCLK      :   out   STD_LOGIC;
           DA_SDIN      :   out   STD_LOGIC);

end component top;

signal  CLK100MHZ   :   std_logic   :=  '0';
signal  LED         :   std_logic_vector(15 downto 0);
signal  AD_MCLK     :   std_logic;
signal  AD_LRCK     :   std_logic;
signal  AD_SCLK     :   std_logic;
signal  AD_SDOUT    :   std_logic   :=  '0';
signal  DA_MCLK     :   std_logic;
signal  DA_LRCK     :   std_logic;
signal  DA_SCLK     :   std_logic;
signal  DA_SDIN     :   std_logic;

constant    LEFT_CHANNEL    :   std_logic_vector(23 downto 0)   :=  "01010101"&"00110001"&"11110010";
constant    RIGHT_CHANNEL   :   std_logic_vector(23 downto 0)   :=  not "01010101"&"00110001"&"11110010";

begin

CLK100MHZ   <=  not CLK100MHZ after 5ns;

DUT:    top
    PORT MAP(
        CLK100MHZ   =>  CLK100MHZ,
        LED         =>  LED,
        AD_MCLK     =>  AD_MCLK,
        AD_LRCK     =>  AD_LRCK,
        AD_SCLK     =>  AD_SCLK,
        AD_SDOUT    =>  AD_SDOUT,
        DA_MCLK     =>  DA_MCLK,
        DA_LRCK     =>  DA_LRCK,
        DA_SCLK     =>  DA_SCLK,
        DA_SDIN     =>  DA_SDIN);

STIM:   process
begin

    for i in 23 downto 0 loop
        wait until falling_edge(AD_SCLK);
        AD_SDOUT    <=  LEFT_CHANNEL(i);
    end loop;
    
    wait until rising_edge(AD_LRCK);
    
    for i in 23 downto 0 loop
        wait until falling_edge(AD_SCLK);
        AD_SDOUT    <=  RIGHT_CHANNEL(i);
    end loop;
    
    wait for 100ns;
    
    wait for 100 us;

    finish;
end process;

end Behavioral;
