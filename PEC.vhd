Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
USE work.definitions_package.all; 

Entity PEC is

port(input,clk,hard_rst :in std_logic;
		LEDout :out std_logic_vector(3 downto 0));

End PEC;

Architecture logicfunction of PEC is
	
	signal counter : unsigned(3 downto 0):="0000";
	
	BEGIN
	
	process(clk,hard_rst)
	
	Begin
	
	if(hard_rst='1') then
	counter<="0000";
	
	elsif(rising_edge(clk)) then
	---------------
	if (input='1') then
	counter<=counter + 1;
	
	else
	counter<=counter;
	
	end if;
	---------------
	end if;
	end process;
	
	LEDout<=std_logic_vector(counter);
	
	
	
	
	End LogicFunction;