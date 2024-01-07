Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
USE work.definitions_package.all; 

entity ASIP is

port(clk, rst, hard_rst, stop_prog :in std_logic;
	  program :in std_logic_vector(13 downto 0);
	  pce : out std_logic_vector(3 downto 0);
	  to_hex: out ToHex;
	  buzz: out std_logic);
	 
end ASIP;

Architecture logic_function of ASIP is

Signal clk_sig, hard_rst_sig, rst_sig, stop_sig: std_logic;
Signal prog_sig : std_logic_vector(13 downto 0);
Signal inst_sig : std_logic_vector(5 downto 0);
Signal pce_sig : std_logic_vector(3 downto 0);
Signal hex_sig : ToHex;
Signal seg_sig : ToSeg;
Signal buzz_sig: std_logic;


component Datapath is
port(clk, rst, hard_rst, stop_prog :in std_logic;
		program : in std_logic_vector(13 downto 0);
		inst :out std_logic_vector(5 downto 0);
		--pce: out std_logic;
		pce_leds: out std_logic_vector(3 downto 0);
		buzz: out std_logic);
end component;
	  
component Control_Unit is
port(inst:in std_logic_vector(5 downto 0);
	  clk, rst, hard_rst: in std_logic;
	  To_Seg:out ToSeg);
end component;

component IO_controller IS
Port ( To_Seg : in ToSeg;		 
	    To_Hex : out ToHex);
End component;


begin


U1: Datapath
port map(clk => clk_sig, rst => rst_sig, hard_rst => hard_rst_sig, stop_prog => stop_sig, program => prog_sig, inst => inst_sig, pce_leds => pce_sig, buzz => buzz_sig); 

U2: Control_Unit
port map(inst => inst_sig, clk => clk_sig, rst => rst_sig, hard_rst => hard_rst_sig, To_Seg => seg_sig);

U3: IO_controller 
port map(To_Seg => seg_sig, To_Hex => hex_sig);

prog_sig <= program;
rst_sig <= rst;
hard_rst_sig <= hard_rst;
stop_sig <= stop_prog;
clk_sig <= clk;

buzz <= buzz_sig;
pce <= pce_sig;
to_hex <= hex_sig;

end logic_function;