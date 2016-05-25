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

entity Zed_audio_interface_in is
   port(
     line_in_l_in               : in    STD_LOGIC_VECTOR(23 downto 0); 
     line_in_l_out              : out   STD_LOGIC_VECTOR(23 downto 0);        
     line_in_r_in               : in    STD_LOGIC_VECTOR(23 downto 0);
     line_in_r_out              : out   STD_LOGIC_VECTOR(23 downto 0);
     irq_in                     : in    STD_LOGIC;
     irq_out                     : out    STD_LOGIC;          
     
     clk                        : in    std_logic
 );
end Zed_audio_interface_in;

architecture RTL of Zed_audio_interface_in is

begin

    line_in: process(clk)
    begin
     
        if rising_edge(clk) then
            line_in_l_out <= line_in_l_in;
            line_in_r_out <= line_in_r_in;
        end if;

    end process line_in;
        
    irq: process(clk)
    begin
        if rising_edge(clk) then
            irq_out     <= irq_in;
        end if;
    end process irq;
    

end RTL;
