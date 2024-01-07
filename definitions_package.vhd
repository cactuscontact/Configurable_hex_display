LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

	package definitions_package is
		-- Package Declaration Section (examples below)

	CONSTANT N : INTEGER := 8;
	
	TYPE ToSeg IS ARRAY (7 downto 0) OF std_logic_vector(4 DOWNTO 0);
	TYPE ToHex IS ARRAY (7 downto 0) OF std_logic_vector(N-1 DOWNTO 0);
	TYPE prog IS ARRAY (integer range <>) OF std_logic_vector(5 DOWNTO 0); 
	--------------------Custom7SegDecoder----------------------
	Component SegDec
	
		Port ( D : in std_logic_vector(4 downto 0);
	   Y : out std_logic_vector(7 downto 0));
	
	End Component; 
	
	
	
	end package definitions_package;
	
	
package body definitions_package is
	--blank, include any implementations here, if necessary
	
	
	
end package body definitions_package;

