----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.10.2024 22:07:49
-- Design Name: 
-- Module Name: display_controller - Behavioral
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

entity display_controller is
    Port (
        clk_i       :   in  std_Logic;
        rst_i       :   in  std_logic;
        digit_i     :   in  std_logic_vector(15 downto 0);
        digit_en_i  :   in  std_logic_vector(3  downto 0);
        led7_an_o   :   out std_logic_vector(3  downto 0);
        led7_seg_o  :   out std_logic_vector(7  downto 0));
end display_controller;

architecture Behavioral of display_controller is

    constant    DISPLAY_REFRESH_RATE    :   NATURAL :=  1_000;
    constant    CLOCK_FREQUENCY         :   NATURAL :=  100_000_000;
    constant    MUX_NDIV                :   NATURAL :=  100_000;
    
    component divider is
        Generic (
            NDIV    :   natural :=  100);
        Port (
            clk_i   :   in  std_logic;
            rst_i   :   in  std_logic;
            clk_o   :   out std_logic);
            
    end component divider;
    
    function hex_2_seg (hex_in : in std_logic_vector(3 downto 0)) 
    return std_logic_vector is variable seg_out : std_logic_vector(7 downto 0);
    begin
    
        if  (hex_in = "XXXX") then
            seg_out := "00000000";  -- blank
        elsif (hex_in = "0000") then
            seg_out := "11111100";  -- 0
        elsif (hex_in = "0001") then
            seg_out := "01100000";  -- 1
        elsif (hex_in = "0010") then
            seg_out := "11011010";  -- 2
        elsif (hex_in = "0011") then
            seg_out := "11110010";  -- 3
        elsif (hex_in = "0100") then
            seg_out := "01100110";  -- 4
        elsif (hex_in = "0101") then
            seg_out := "10110110";  -- 5
        elsif (hex_in = "0110") then
            seg_out := "10111110";  -- 6
        elsif (hex_in = "0111") then
            seg_out := "11100000";  -- 7
        elsif (hex_in = "1000") then
            seg_out := "11111110";  -- 8
        elsif (hex_in = "1001") then
            seg_out := "11110110";  -- 9
        elsif (hex_in = "1010") then
            seg_out := "11101110";  -- A
        elsif (hex_in = "1011") then
            seg_out := "00111110";  -- B
        elsif (hex_in = "1100") then
            seg_out := "00011010";  -- C
        elsif (hex_in = "1101") then
            seg_out := "01111010";  -- D
        elsif (hex_in = "1110") then
            seg_out := "10011110";  -- E
        elsif (hex_in = "1111") then
            seg_out := "10001110";  -- F
        else
            seg_out := "00000000";  -- blank
        end if;
        
        return seg_out;
    end;
    
    type    display_state_type   is  (display_blank, display_seg0, display_seg1, display_seg2, display_seg3, display_all_on);
    
    alias   digit_0 :   std_logic_vector(3 downto 0) is  digit_i(3  downto   0);
    alias   digit_1 :   std_logic_vector(3 downto 0) is  digit_i(7  downto   4);
    alias   digit_2 :   std_logic_vector(3 downto 0) is  digit_i(11 downto   8);
    alias   digit_3 :   std_logic_vector(3 downto 0) is  digit_i(15 downto  12);
    
    signal  led7_an_o_int   :   std_logic_vector(3 downto 0);
    signal  led7_seg_o_int  :   std_logic_vector(7 downto 0);
    
    signal  current_display_state   :   display_state_type  :=  display_blank;
    signal  next_display_state      :   display_state_type  :=  display_blank;
    
    signal  clk_mux         :   std_logic;
    
    signal digit_en_internal    :   std_logic_vector(3 downto 0)    :=  "1111";
    
    signal  counter :   natural range 1001 downto 0 :=  0;
    
begin

    DIV: divider
        GENERIC MAP(
            NDIV    =>  MUX_NDIV)
        PORT MAP(
            clk_i   =>  clk_i,
            rst_i   =>  rst_i,
            clk_o   =>  clk_mux);

    NEXT_STATE: process(current_display_state)
    begin
    
        case    current_display_state   is
            when    display_blank   =>  next_display_state  <=  display_seg0;
            when    display_all_on  =>  next_display_state  <=  display_seg0;
            when    display_seg0    =>  next_display_state  <=  display_seg1;
            when    display_seg1    =>  next_display_state  <=  display_seg2;
            when    display_seg2    =>  next_display_state  <=  display_seg3;
            when    display_seg3    =>  next_display_state  <=  display_seg0;
            when    others          =>  next_display_state  <=  display_blank;
        end case;
    
    end process;

    MULTIPLEX: process(clk_mux, rst_i)
    begin
    
        if (rst_i = '1') then
            current_display_state   <=  display_blank;
        elsif rising_edge(clk_mux) then
            current_display_state   <=  next_display_state;
            
            counter <= counter + 1;
            
            if (counter = 1000) then
                counter <=  0;
                digit_en_internal <= digit_en_internal xor (not digit_en_i);
            end if;
            
        end if;
    
    end process;
    
    led7_an_o_int   <=  "0000"  when current_display_state = display_blank  else
                        "1111"  when current_display_state = display_all_on else
                        "0001"  when current_display_state = display_seg0   else
                        "0010"  when current_display_state = display_seg1   else
                        "0100"  when current_display_state = display_seg2   else
                        "1000"  when current_display_state = display_seg3   else "1111";
                    
    led7_seg_o_int  <=  x"00"               when current_display_state = display_blank  else
                        x"FF"               when current_display_state = display_all_on else
                        hex_2_seg(digit_0)  when current_display_state = display_seg0   else
                        hex_2_seg(digit_1)  when current_display_state = display_seg1   else
                        hex_2_seg(digit_2)  when current_display_state = display_seg2   else
                        hex_2_seg(digit_3)  when current_display_state = display_seg3   else x"00";
                    
    led7_an_o   <=  not (led7_an_o_int and digit_en_internal);
    led7_seg_o  <=  not led7_seg_o_int;
    
end Behavioral;
