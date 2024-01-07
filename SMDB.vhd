Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
USE work.definitions_package.all; 
Use Work.Codec.all;

entity SMDB is

port(
      SW : in std_logic_vector(17 downto 0);
		KEY : in std_logic_vector(3 downto 0);
      CLOCK_50: in std_logic;
		
		-----------------------------------------------------------------------------------
		
		I2C_SDAT : inout std_logic;
		I2C_SCLK, AUD_XCK : out std_logic;
		AUD_ADCDAT : in std_logic;
		AUD_DACDAT : out std_logic;
		AUD_ADCLRCK, AUD_DACLRCK, AUD_BCLK : in std_logic;
		
		-----------------------------------------------------------------------------------
		
		LEDR : out std_logic_vector(17 downto 0);
		LEDG : out std_logic_vector(7 downto 0);
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: out std_logic_vector(7 downto 0)
	  );

end SMDB;

Architecture logic_function of SMDB is


constant time_key: positive:= 200000;
constant time_sw: positive:= 500000;
Signal clk_sig, hard_rst_sig, rst_sig, stop_sig, pause_sig: std_logic;
Signal mode_sig: std_logic_vector (1 downto 0);
Signal hex_sig: ToHex;
Signal prog_sig: std_logic_vector(13 downto 0);


----------------------------------------------------------------

SIGNAL	AudioIn, AudioOut : signed(15 downto 0);
	SIGNAL	SamClk : std_logic;
	
	Signal	Slowsig: std_logic;------------------
	
	Signal	tone_sig: std_logic;
	
	Component ToneGenerator is 
	port(clear,clock :in std_logic;
	  freq : in unsigned(15 downto 0);
	  Waveout : out signed(15 downto 0));
End Component;
	
	
	COMPONENT AudioInterface is
	Generic ( SID : integer := 100 ); 
	Port (CLOCK_50 : in std_logic;
		init : in std_logic;

		I2C_SDAT : inout std_logic;
		I2C_SCLK, AudMclk : out std_logic;
		AUD_ADCDAT : in std_logic;
		AUD_DACDAT : out std_logic;
		AUD_ADCLRCK, AUD_DACLRCK, AUD_BCLK : in std_logic;
		
		SamClk : out std_logic;
		AudioIn : out signed(15 downto 0);
		AudioOut : in signed(15 downto 0));
	END COMPONENT;

--------------------------------------------------------------------


component ASIP is
port(clk, rst, hard_rst, stop_prog :in std_logic;
	  program :in std_logic_vector(13 downto 0);
	  pce : out std_logic_vector(3 downto 0);
	  to_hex: out ToHex;
	  buzz: out std_logic);
end component;

component debouncer is
 generic (
    timeout_cycles : positive
    );
  port (
    clk : in std_logic;
    rst : in std_logic;
    switch : in std_logic;
    switch_debounced : out std_logic);
end component;

component prescale is
port (clk_in,pause :in std_logic;
		mode :in std_logic_vector (1 downto 0);
		clk_out : out std_logic);
end component;


begin

U1: prescale
port map(clk_in => CLOCK_50, pause => pause_sig, mode => mode_sig, clk_out => clk_sig);

U2: ASIP
port map(clk => clk_sig, rst => rst_sig, hard_rst => hard_rst_sig, stop_prog => stop_sig, program => prog_sig, pce => LEDG(3 downto 0), to_Hex => hex_sig, buzz => tone_sig); 

U3:debouncer
generic map(timeout_cycles => time_key)
port map(clk => CLOCK_50, rst => rst_sig, switch => Key(3), switch_debounced => stop_sig);

U4:debouncer
generic map(timeout_cycles => time_key)
port map(clk => CLOCK_50, rst => rst_sig, switch => Key(0), switch_debounced => pause_sig);

U5:debouncer
generic map(timeout_cycles => time_sw)
port map(clk => CLOCK_50, rst => rst_sig, switch => SW(17), switch_debounced => mode_sig(1));

U6:debouncer
generic map(timeout_cycles => time_sw)
port map(clk => CLOCK_50, rst => rst_sig, switch => SW(16), switch_debounced => mode_sig(0));

U7:debouncer
generic map(timeout_cycles => time_sw)
port map(clk => CLOCK_50, rst => rst_sig, switch => SW(15), switch_debounced => rst_sig);

U8:debouncer
generic map(timeout_cycles => time_sw)
port map(clk => CLOCK_50, rst => rst_sig, switch => SW(14), switch_debounced => hard_rst_sig);

U9:debouncer
generic map(timeout_cycles => time_sw)
port map(clk => CLOCK_50, rst => rst_sig, switch => SW(0), switch_debounced => prog_sig(0));

U10:debouncer
generic map(timeout_cycles => time_sw)
port map(clk => CLOCK_50, rst => rst_sig, switch => SW(1), switch_debounced => prog_sig(1));

U11:debouncer
generic map(timeout_cycles => time_sw)
port map(clk => CLOCK_50, rst => rst_sig, switch => SW(2), switch_debounced => prog_sig(2));

U12:debouncer
generic map(timeout_cycles => time_sw)
port map(clk => CLOCK_50, rst => rst_sig, switch => SW(3), switch_debounced => prog_sig(3));

------------------------------------------------------------------------------------------------------

U13 : ToneGenerator
			Port Map (freq=>(unsigned(sw(15 downto 0))),Waveout=>Audioout, clear=>tone_sig, clock=>Samclk); 
			
			
			
			assm: AudioInterface	generic map ( SID => 62782 )
			PORT MAP( Clock_50 => CLOCK_50, AudMclk => AUD_XCK,	-- period is 80 ns ( 12.5 Mhz )
						init => KEY(0), 									-- +ve edge initiates I2C data
						I2C_Sclk => I2C_SCLK,
						I2C_Sdat => I2C_SDAT,
						AUD_BCLK => AUD_BCLK, AUD_ADCLRCK => AUD_ADCLRCK, AUD_DACLRCK => AUD_DACLRCK,
						AUD_ADCDAT => AUD_ADCDAT, AUD_DACDAT => AUD_DACDAT,
						AudioOut => AudioOut, AudioIn => AudioIn, SamClk => SamClk );

----------------------------------------------------------------------------------------------------------

HEX0 <= hex_sig(0);
HEX1 <= hex_sig(1);
HEX2 <= hex_sig(2);
HEX3 <= hex_sig(3);
HEX4 <= hex_sig(4);
HEX5 <= hex_sig(5);
HEX6 <= hex_sig(6);
HEX7 <= hex_sig(7);

prog_sig(13 downto 4) <= SW(13 downto 4);


end logic_function; 