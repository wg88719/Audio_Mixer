----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2016 22:17:45
-- Design Name: 
-- Module Name: Zed_audio_interface - RTL
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

entity Zed_audio_interface_out is
   port(
     hphone_l_in                : in    STD_LOGIC_VECTOR(23 downto 0);       
     hphone_r_in               : in   STD_LOGIC_VECTOR(23 downto 0);
     hphone_l_out                : out    STD_LOGIC_VECTOR(23 downto 0);       
     hphone_r_out               : out   STD_LOGIC_VECTOR(23 downto 0);
     irq_out                     : out    STD_LOGIC;          
     
     clk                        : in    std_logic
 );
end Zed_audio_interface_out;

architecture RTL of Zed_audio_interface_out is

begin

    
    headphone_out: process(clk)
    begin
     
        if rising_edge(clk) then
            hphone_l_out  <= hphone_l_in;
            hphone_r_out  <= hphone_r_in;
        end if;

    end process headphone_out;
        

end RTL;
