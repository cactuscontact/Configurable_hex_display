LIBRARY ieee;
use ieee.std_logic_1164.all;


ENTITY SegDec IS

Port ( D : in std_logic_vector(4 downto 0);
	   Y : out std_logic_vector(7 downto 0));
		
	END SegDec;
	
	Architecture logicfunction of SegDec is
	
	BEGIN
	
	with D select 
		Y <= "11111111" when "00000", --nothing
		"11111000" when "00001", --snake head left
		"11001000" when "00010", --snake body
		"11000111" when "00011", --snake tail left
		
		"11001110" when "00100", --snake head right
	   "11110001" when "00101", --snake tail right
		
	   "10111111" when "00110", --fly in middle
		"11011111" when "00111", --fly top left
		"11111110" when "01000", --fly top
	   "11111101" when "01001", --fly top right
		"11101111" when "01010", --fly bottem left
		"11110111" when "01011", --fly bottem
		"11111011" when "01100", --fly bottem right
		
		"11111001" when "01101", --I
		"10111001" when "01110", --T
		"10010010" when "01111", --S
		
		"10010001" when "10000", --Y
		"10000110" when "10001", --E
		"10001000" when "10010", --A
		"10001001" when "10011", --H
		
		"10000000" when "10100", --B
		"11000000" when "10101", --O
		
		"10100100" when "10110", --z
		
		"10101111" when "10111",  --r
		
		"10101100" when others;--is a ? but shouldn't ever appear
		
		End logicfunction;
		
		
	