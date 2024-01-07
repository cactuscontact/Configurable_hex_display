Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
USE work.definitions_package.all; 

ENTITY scheduler is

port( clk, rst, hard_rst, stop_prog :in std_logic;
      program :in std_logic_vector(13 downto 0); 
      inst_out :out std_logic_vector(5 downto 0);
		pce :out std_logic;
		buzz: out std_logic);
end scheduler;

Architecture Logic_function of scheduler is

Type state_type_idler is (running, not_running);
Signal current_state : state_type_idler := not_running;
Signal next_state : state_type_idler;
Type state_type is (idle, snake_left, snake_right, fly, msg, err);
signal PS : state_type := idle;
signal NS : state_type;
signal stop_sig: std_logic;
signal SL_count:  unsigned(3 downto 0) :="0000";
signal SR_count:  unsigned(3 downto 0) :="0000";
signal msg_count:  unsigned(4 downto 0) :="00000";
signal fly_count:  unsigned(4 downto 0) :="00000";
signal start_flag, done_flag: std_logic:='0';
signal err_tone : std_logic := '0';

constant Program_SL :
prog(0 to 10) := ("000001", "000010", "000011", "000100", "000101", "000110", "000111", "001000", "001001", "001010", "001011");

constant Program_SR :
prog(0 to 10) := ("001100", "001101", "001110", "001111", "010000", "010001", "010010", "010011", "010100", "010101", "010110");

constant Program_msg :
prog(0 to 17) := ("101001", "101010", "101011", "101100", "101101", "101110", "101111", "110000", "110001", "110010", "110011", "110100", "110101", "110110", "110111", "111000", "111001", "111010");

constant Program_fly :
prog(0 to 17) := ("010111", "011000", "011001", "011010", "010111", "011100", "011101", "011110", "010111", "100000", "100001", "100010", "100011", "100000", "100101", "100110", "100111", "100000");

begin

 stop_sig <= stop_prog;
 buzz <= err_tone;
 
process(clk)
begin

	if(rising_edge(clk))then
		current_state <= next_state;
		
	case current_state is
	
		
		WHEN not_running =>
			if(program(13 downto 0) = "00000000000000") then
				next_state <= not_running;
			else
				next_state <= running;
				start_flag <= '1';
			end if;
		WHEN running =>
			if(done_flag <= '1') then
				next_state <= not_running;
				start_flag <= '0';
				done_flag <='0';
			else
				next_state <= running;
			end if;
		
	end case;
	
	
	end if;


end process;

process(clk)
begin

		
		
		
	if(rising_edge(clk))then
	  
		PS <= NS;
	
		if(rst = '1' OR hard_rst = '1' OR SL_count = "1010" OR SR_count = "1010" OR msg_count = "10001" OR fly_count = "10001") then
			
			if(PS = fly AND rst = '0' AND hard_rst ='0') then
				NS <= fly;
			else
				PS <= idle;
			end if;
			
			SL_count <= "0000";
			SR_count <= "0000";
			msg_count <= "00000";
			fly_count <= "00000";
			
		else	
		
			if(PS = idle) then
			
				SL_count <= "0000";
				SR_count <= "0000";
				msg_count <= "00000";
				fly_count <= "00000";
				
			else
				if(PS = snake_left) then
					SL_count <= SL_count + 1;
				elsif(PS = snake_right) then
					SR_count <= SR_count + 1;
				elsif(PS = msg) then
					msg_count <= msg_count + 1;
				elsif(PS = fly) then
					fly_count <= fly_count + 1;
				end if;
			
			end if;
			
			   
		end if;
		
	end if;
	
	if(SL_count = "1010" OR SR_count = "1010" OR msg_count = "10001" OR fly_count = "10001") then
		pce <= '1';
		done_flag <= '1';
	else
		pce <= '0';
		done_flag <= '0';
	end if;

	
		CASE PS IS
		
	
			WHEN idle => 
				err_tone <= '1';
				inst_out <= "000000";
				if(start_flag ='0') then
				NS <= idle;	
				elsif(program(0) = '1' AND program(13 downto 1) = "0000000000000") then
				NS <= snake_left;
				elsif(program(1) = '1' AND program(13 downto 2) = "000000000000" AND program(0) = '0') then
				NS <= snake_right;
				elsif(program(2) = '1' AND program(13 downto 3) = "00000000000" AND program(1 downto 0) = "00") then
				NS <= fly;
				elsif(program(3) = '1' AND program(13 downto 4) = "0000000000" AND program(2 downto 0) = "000") then
				NS <= msg;
				else
				NS <= err;
				end if;
				
				

			WHEN snake_left =>
			   
				inst_out <= Program_SL(To_integer(SL_count));
				NS <= snake_left;
				
			WHEN snake_right =>
			
				inst_out <= Program_SR(To_integer(SR_count));
				NS <= snake_right;
			
			WHEN fly =>
				if(stop_sig = '0') then
					NS <= idle;
				else
					inst_out <= Program_fly(To_integer(fly_count));
					NS <= fly;
				end if;
			
			WHEN msg =>
				inst_out <= Program_msg(To_integer(msg_count));
				NS <= msg;
				
			WHEN err =>
				err_tone <= '0';
				inst_out <= "111011";
				NS <= idle;
					
			
				
		end case;

end process;

			

end Logic_function;