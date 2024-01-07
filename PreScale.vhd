Library ieee;
USE ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

Entity PreScale is 
port (clk_in,pause :in std_logic;
		mode :in std_logic_vector (1 downto 0);
		clk_out : out std_logic);
End PreScale;

Architecture LogicFunction of PreScale is

Signal S0 : unsigned(24 downto 0) :="0000000000000000000000000";
Signal pause_sig : std_logic;

Begin 

 clk_out <= S0(22) when mode="00" else -- normal
				S0(21) when mode="01" else -- fast
				S0(23) when mode="10" else -- slow
				S0(20) when mode="11"; -- very fast

	pause_sig<=pause;
				
process(Clk_in,pause_sig)
begin 



if (rising_edge(clk_in) and pause_sig='1') then 

S0 <= S0 + 1 ;

end if;


End Process;

End LogicFunction;