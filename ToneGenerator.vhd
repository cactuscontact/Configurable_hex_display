LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

Entity ToneGenerator is
port(clear,clock :in std_logic;
	  freq : in unsigned(15 downto 0);
	  Waveout : out signed(15 downto 0));
end ToneGenerator;

Architecture LogicFunction of ToneGenerator is 

signal S0 : signed(21 downto 0) :=(others=>'0'); 

Begin

--S0(21 downto 16) <="000000";
--S0(15 downto 0) <= signed(freq(15 downto 0));
--S0<=signed("000000" & freq);
Waveout<=S0 (21 downto 6);

process(clock,clear)
begin 
if (rising_edge(clock)) then
	if (not clear='1') then
	S0 <=(others=>'0'); --"0000000000000000000000"
	
	else
	S0<=S0+signed("000000" & freq);
	end if;
	
end if;
end process; 

End LogicFunction;