----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:14:25 07/10/2013 
-- Design Name: 
-- Module Name:    seven_seg_disp - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.NUMERIC_BIT.ALL;

entity seven_seg_disp is
	Port(
		switches: in STD_LOGIC_VECTOR(7 downto 0);
		anodes: out STD_LOGIC_VECTOR(3 downto 0);
		segments: out STD_LOGIC_VECTOR(6 downto 0);		
		dp : out STD_LOGIC;
		clk: in STD_LOGIC
		);
end seven_seg_disp;

architecture Behavioral of seven_seg_disp is
	signal counter: std_logic_vector(1 downto 0) := (others =>'0');
	type divrange is range 0 to 250000;
	type digitrange is range 0 to 9;	
	type secrange is range 0 to 50000000;
	
	signal digit0: integer range 0 to 9:= 0;
	signal digit1: integer range 0 to 9:= 0;
	signal digit2: integer range 0 to 9:= 0;
	signal digit3: integer range 0 to 9:= 0;
	
	type seven_seg_map is array (0 to 9) of std_logic_vector(6 downto 0);	
	constant seven_seg_data:seven_seg_map := (
		0 => "1000000",
		1 => "1111001",
		2 => "0100100",
		3 => "0110000",
		4 => "0011001",
		5 => "0010010",
		6 => "0000010",
		7 => "1111000",
		8 => "0000000",
		9 => "0010000"
	);
	
begin
	
	sectimer: process(clk,switches(0),switches(1)) is
		variable secdiv:secrange := 0;		
		begin
			if(rising_edge(clk)) then
				if(switches(0) = '1') then
					secdiv := 0;
					digit0 <= 0;
					digit1 <= 0;
					digit2 <= 0;
					digit3 <= 0;
				else
					if(secdiv = 50000000) then
						secdiv := 0;
						if(digit0 = 9) then
							digit0 <= 0;
							if(digit1 = 5) then
								digit1 <= 0;
								if(digit2 = 9) then
									digit2 <= 0;						
									if(digit3 = 5) then
										digit3 <= 0;
									else
										digit3 <= digit3 + 1;
									end if;
								else
									digit2 <= digit2 + 1;
								end if;
							else
								digit1 <= digit1 + 1;
							end if;
						else
							digit0 <= digit0 + 1;
						end if;
					else
						secdiv := secdiv + 1;
					end if;
				end if;
			end if;
	end process;
	
	--Default clock speed is 50Mhz when the jumper is not loaded.
	seven_seg_proc: process(clk) is
		variable div: divrange := 0;		
		begin		
			dp <= '1';		
			if (rising_edge(clk)) then --TODO: Understand why I cannot compare a clk signal and some other value.				
				if(div=62500) then
					case(counter) is
						when "00" =>
							anodes <= "1110";
							segments <= seven_seg_data(digit0);	--Note that the array index has to be type integer.							
						when "01" =>
							anodes <= "1101";
							segments <= seven_seg_data(digit1);
						when "10" =>
							anodes <= "1011";
							segments <= seven_seg_data(digit2);
						when "11" =>
							anodes <= "0111";
							segments <= seven_seg_data(digit3);
						when others =>
							anodes <= "1111";
							segments <= "1111111";
							div := 0;
					end case;
					counter <= std_logic_vector(unsigned(counter) + 1);
					div := 0;
				else
					div := div + 1;
				end if;	--div
				
			end if; --rising_edge
		
end process;

end Behavioral;


--entity sectimer is
--
--end sectimer;
--
--architecture sectimer_behavioural of sectimer is
--
--begin
--
--end sectimer_behavioural;

--	signal digit0: integer range 0 to 9:= 0;
--	signal digit1: integer range 0 to 9:= 0;
--	signal digit2: integer range 0 to 9:= 0;
--	signal digit3: integer range 0 to 9:= 0;
--	
--	type secrange is range 0 to 50000000;

--			if(secdiv=1) then
--				if(digit0 = 9) then
--					digit0 <= 0;
--					if(digit1 = 6) then
--						digit1 <= 0;
--						if(digit2 = 9) then
--							digit2 <= 0;						
--							if(digit3 = 6) then
--								digit3 <= 0;
--							else
--								digit3 <= digit3 + 1;
--							end if;
--						else
--							digit2 <= digit2 + 1;
--						end if;
--					else
--						digit1 <= digit1 + 1;
--					end if;
--				else
--					digit0 <= digit0 + 1;
--				end if;			
--			end if;