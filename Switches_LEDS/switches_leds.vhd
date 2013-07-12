----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:10:58 07/06/2013 
-- Design Name: 
-- Module Name:    switches_leds - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity switches_leds is
    Port (switches: in STD_LOGIC_VECTOR(7 downto 0);
			LEDS: out STD_LOGIC_VECTOR(7 downto 0);			
			clk: in STD_LOGIC);
	 
end switches_leds;

architecture Behavioral of switches_leds is
		signal counter: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin	
	clk_proc: process(clk)
	variable div : integer := 0;
		begin
			if rising_edge(clk) then
				if (div = 50000000) then 
					div := 0;
					LEDS <= counter;
					counter <= counter + 1;
				else
					div := div + 1;
				end if;				
			end if;
	end process;
end Behavioral;


--architecture Behavioral of switches_leds is
--		signal x : STD_LOGIC_VECTOR(3 downto 0);
--		signal y : STD_LOGIC_VECTOR(3 downto 0);
--		signal carry : STD_LOGIC_VECTOR(3 downto 0);
--		signal result : STD_LOGIC_VECTOR(4 downto 0);
--begin
--	LEDS <= "000" & result;
--	x <= switches(3 downto 0);
--	y <= switches(7 downto 4);
--	
--	result(0) <= x(0) XOR y(0);
--	carry(0) <= x(0) AND y(0);
--	
--	result(1) <= x(1) XOR y(1) XOR carry(0);
--	carry(1) <= (x(1) AND y(1)) OR (x(1) AND carry(0)) OR (carry(0) AND y(1));
--	
--end Behavioral;
