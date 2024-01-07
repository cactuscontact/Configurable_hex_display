Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
USE work.definitions_package.all; 

entity Datapath is

port(clk, rst, hard_rst, stop_prog :in std_logic;
		program : in std_logic_vector(13 downto 0);
		inst :out std_logic_vector(5 downto 0);
		pce_leds: out std_logic_vector(3 downto 0);
		buzz: out std_logic);
		
end Datapath;


Architecture logic_function of Datapath is 


Signal count_sig, clk_sig, hard_rst_sig, rst_sig, stop_sig: std_logic;
Signal prog_sig : std_logic_vector(13 downto 0);
Signal inst_sig : std_logic_vector(5 downto 0);
Signal err_tone : std_logic;


component scheduler is
port(clk, rst, hard_rst, stop_prog :in std_logic;
      program :in std_logic_vector(13 downto 0); 
      inst_out :out std_logic_vector(5 downto 0);
		pce :out std_logic;
		buzz: out std_logic);
end component;

component PEC is
port(input,clk,hard_rst :in std_logic;
		LEDout :out std_logic_vector(3 downto 0));
End component;

begin


rst_sig <= rst;
hard_rst_sig <= hard_rst;
prog_sig <= program;
stop_sig <= stop_prog;
inst <= inst_sig;
clk_sig <= clk;
buzz <= err_tone;

U1: scheduler
port map(clk => clk_sig, rst => rst_sig, hard_rst => hard_rst_sig, stop_prog => stop_sig, program => prog_sig, inst_out => inst_sig, pce => count_sig, buzz => err_tone);
		
U2: PEC
port map(input => count_sig, clk => clk_sig, hard_rst => hard_rst_sig, LEDout => pce_leds);

end logic_function; 
