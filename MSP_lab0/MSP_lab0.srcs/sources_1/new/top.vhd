----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/09/2024 11:34:44 AM
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port (
    clk_i       :   in std_logic;
    rst_i       :   in std_logic;
    led_clk_o   :   out std_logic;
    led_o       :   out std_logic_vector(7 downto 0));
end top;

architecture Behavioral of top is

component kcpsm6 is
    generic(                 hwbuild : std_logic_vector(7 downto 0) := X"00";
                    interrupt_vector : std_logic_vector(11 downto 0) := X"3FF";
             scratch_pad_memory_size : integer := 64);
             
    port (                   address : out std_logic_vector(11 downto 0);
                         instruction : in std_logic_vector(17 downto 0);
                         bram_enable : out std_logic;
                             in_port : in std_logic_vector(7 downto 0);
                            out_port : out std_logic_vector(7 downto 0);
                             port_id : out std_logic_vector(7 downto 0);
                        write_strobe : out std_logic;
                      k_write_strobe : out std_logic;
                         read_strobe : out std_logic;
                           interrupt : in std_logic;
                       interrupt_ack : out std_logic;
                               sleep : in std_logic;
                               reset : in std_logic;
                                 clk : in std_logic);
end component kcpsm6;

component ROM_picoblaze is
    generic(             C_FAMILY : string := "V6"; 
                C_RAM_SIZE_KWORDS : integer := 1;
             C_JTAG_LOADER_ENABLE : integer := 0);
             
    Port (                address : in std_logic_vector(11 downto 0);
                      instruction : out std_logic_vector(17 downto 0);
                           enable : in std_logic;
                              rdl : out std_logic;                    
                              clk : in std_logic);
end component ROM_picoblaze;

component divider is
    Generic (
        NDIV    :   natural :=  100);
    Port (
        clk_i   :   in  std_logic;
        rst_i   :   in  std_logic;
        clk_o   :   out std_logic);
        
end component divider;

component display_controller is
    Port (
        clk_i       :   in  std_Logic;
        rst_i       :   in  std_logic;
        digit_i     :   in  std_logic_vector(19 downto 0);
        led7_an_o   :   out std_logic_vector(3  downto 0);
        led7_seg_o  :   out std_logic_vector(7  downto 0));
end component display_controller;

signal  addr    :   std_logic_vector(11 downto 0);
signal  inst    :   std_logic_vector(17 downto 0);
signal  rdl     :   std_logic;
signal  reset   :   std_logic;
signal  bram    :   std_logic;

signal  clk_div_in  :   std_logic;
signal  clk_div_out :   std_logic;

signal  digit_int   :   std_logic_vector(15 downto 0);

signal  out_port    :   std_logic_vector(7 downto 0);

begin

PROC: kcpsm6
  generic map(             hwbuild => X"00",
                  interrupt_vector => X"3FF",
           scratch_pad_memory_size => 64)
           
  port map (               address =>   addr,
                       instruction =>   inst,
                       bram_enable =>   bram,
                           in_port =>   (others=>'0'),
                          out_port =>   out_port,
                           port_id =>   open,
                      write_strobe =>   open,
                    k_write_strobe =>   open,
                       read_strobe =>   open,
                         interrupt =>   '0',
                     interrupt_ack =>   open,
                             sleep =>   '0',
                             reset =>   reset,
                               clk =>   clk_div_out);
                               
ROM: ROM_picoblaze
  generic map(             C_FAMILY => "V6", 
                  C_RAM_SIZE_KWORDS => 1,
               C_JTAG_LOADER_ENABLE => 0)
               
  Port map(                 address => addr,
                        instruction => inst,
                             enable => bram,
                                rdl => rdl,                    
                                clk => clk_div_out);

DIV:    divider
    GENERIC MAP(
        NDIV    =>  100_000_000)
    
    PORT MAP(
        clk_i   =>  clk_div_in,
        rst_i   =>  '0',
        clk_o   =>  clk_div_out);

DISPLAY:    display_controller
    PORT MAP(
        clk_i   =>  clk_i,
        rst_i   =>  rst_i,
        digit_i =>  digit_int,
        led7_an_o   =>  open,
        led7_seg_o  =>  open);

digit_int   <=  (19 downto 5=>'0')&'1'&out_port(3 downto 0);

clk_div_in  <=  clk_i;
reset       <=  rdl or rst_i;

led_clk_o   <=  clk_div_out;
led_o   <=  out_port;

end Behavioral;