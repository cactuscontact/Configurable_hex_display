Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
USE work.definitions_package.all; 

Entity Control_Unit is

port(inst:in std_logic_vector(5 downto 0);
	  clk, rst, hard_rst: in std_logic;
	  To_Seg:out ToSeg);
	

end Control_Unit; 

Architecture behaviour of Control_Unit is

--type ToSeg is array (4 downto 0, 7 downto 0) of std_logic;
--signal HexString: ToSeg;
constant O :
       std_logic_vector(4 downto 0):= "00000";
constant B :
       std_logic_vector(4 downto 0):= "00010";

Begin

process(clk, inst)
begin

IF(hard_rst='1') then
	
	To_Seg<=(O, O, O, O, O, O, O, O);

elsif(rst='1')	then
	To_Seg<=(O, O, O, O, O, O, O, O);
	
  ELSIF(rising_edge(clk)) then
  
	CASE inst IS
		-------------------Snake Left---------------------
		WHEN "000000" => 
			  To_Seg <= (O, O, O, O, O, O, O, O);
			
		WHEN "000001" =>
			  To_Seg <= (O, O, O, O, O, O, O, "00001");
			
		WHEN "000010" =>
			  To_Seg <= (O, O, O, O, O, O,"00001", B);
			   
		WHEN "000011" =>
			  To_Seg <= (O, O, O, O, O, "00001", B, B);
			  
		WHEN "000100" =>
			  To_Seg <= (O, O, O, O, "00001", B, B, "00011");
			  
		WHEN "000101" =>
			  To_Seg <= (O, O, O, "00001", B, B, "00011", O);
			  
		WHEN "000110" =>
			  To_Seg <= (O, O, "00001", B, B, "00011", O, O);
			  
	   WHEN "000111" =>
			  To_Seg <= (O, "00001", B, B, "00011", O, O, O);
			  
		WHEN "001000" =>
			  To_Seg <= ("00001", B, B, "00011", O, O, O, O);
			  
		WHEN "001001" =>
			  To_Seg <= (B, B, "00011", O, O, O, O, O);
			  
		WHEN "001010" =>
			  To_Seg <= (B, "00011", O, O, O, O, O, O);
			  
		WHEN "001011" =>
			  To_Seg <= ("00011", O, O, O, O, O, O, O);
			  ------------------Snake Right-----------------
		WHEN "001100" =>
			  To_Seg <= ("00100",O, O, O, O, O, O, O);
			  
		WHEN "001101" =>
			  To_Seg <= (B,"00100", O, O, O, O, O,  O);
			  
		WHEN "001110" =>
			  To_Seg <= (B, B, "00100", O, O, O,  O, O);
			  
	   WHEN "001111" =>
			  To_Seg <= ("00101", B, B, "00100", O, O, O, O);
			  
	   WHEN "010000" =>
			  To_Seg <= (O,"00101", B, B, "00100", O, O, O);			  
			  
	   WHEN "010001" =>
			  To_Seg <= (O, O,"00101", B, B, "00100", O, O);	

	   WHEN "010010" =>
			  To_Seg <= (O, O, O, "00101", B, B, "00100", O);	 
			  
	   WHEN "010011" =>
			  To_Seg <= ( O, O, O, O, "00101", B, B,"00100");	
			
		WHEN "010100" =>
			  To_Seg <= (O, O, O, O, O, "00101", B, B);		
			  
		WHEN "010101" =>
			  To_Seg <= (O, O, O, O, O, O, "00101", B);
			  
		WHEN "010110" =>
			  To_Seg <= (O, O, O, O, O, O, O, "00101"); 
			 
			-------------------Fly--------------------- 
	   when "010111" => To_seg <=(O,O,O,O,O,O,O,"00110");
		
      when "011000" => To_seg <=(O,O,O,O,O,O,O,"00111");
		
      when "011001" => To_seg <=(O,O,O,O,O,O,O,"01000");
		
      when "011010" => To_seg <=(O,O,O,O,O,O,O,"01001");
		
    --when "011011" => To_seg <=("01010",O,O,O,O,O,O,O);
	 
      when "011100" => To_seg <=(O,O,O,O,O,O,O,"01010");
		
      when "011101" => To_seg <=(O,O,O,O,O,O,O,"01011");
		
      when "011110" => To_seg <=(O,O,O,O,O,O,O,"01100");

    --when "011111" => To_seg <=("00110",O,O,O,O,O,O,O);
	 
      when "100000" => To_seg <=(O,O,O,O,O,O,"00110", "00000");
		
      when "100001" => To_seg <=(O,O,O,O,O,O,"00111",O);
		
      when "100010" => To_seg <=(O,O,O,O,O,O,"01000",O);
		
      when "100011" => To_seg <=(O,O,O,O,O,O,"01001",O);
		
    --when "100100" => To_seg <=("01010";
	 
      when "100101" => To_seg <=(O,O,O,O,O,O,"01010",O);
		
      when "100110" => To_seg <=(O,O,O,O,O,O,"01011",O);
		
      when "100111" => To_seg <=(O,O,O,O,O,O,"01100",O);
			  
		----------------------MSG----------------------	  
		WHEN "101001" =>
			  To_Seg <= (O, O, O, O, O, O, O, "01101");
			  
		WHEN "101010" =>
			  To_Seg <= (O, O, O, O, O, O, "01101", "01110");
			  
		WHEN "101011" =>
			  To_Seg <= (O, O, O, O, O, "01101", "01110", "01111");
			  
		WHEN "101100" =>
			  To_Seg <= (O, O, O, O, "01101", "01110", "01111", O);
			  
		WHEN "101101" =>
			  To_Seg <= (O, O, O, "01101", "01110", "01111", O, "10000");
			  
		WHEN "101110" =>
			  To_Seg <= (O, O, "01101", "01110", "01111", O, "10000", "10010");
			  
		WHEN "101111" =>
			  To_Seg <= (O, "01101", "01110", "01111", O, "10000", "10010", O);
			  
		WHEN "110000" =>
			  To_Seg <= ("01101", "01110", "01111", O, "10000", "10010", O, "10100");
			  
		WHEN "110001" =>
			  To_Seg <= ("01110", "01111", O, "10000", "10010", O, "10100", "10101");
			  
		WHEN "110010" =>
			  To_Seg <= ("01111", O, "10000", "10010", O, "10100", "10101", "10000");
			  
		WHEN "110011" =>
			  To_Seg <= (O, "10000", "10010", O, "10100", "10101", "10000", "10110"); 
			  
		WHEN "110100" =>
			  To_Seg <= ("10000", "10010", O, "10100", "10101", "10000", "10110", O);
			
		WHEN "110101" =>
			  To_Seg <= ("10010", O, "10100", "10101", "10000", "10110", O, O);
			  
		WHEN "110110" =>
			  To_Seg <= (O, "10100", "10101", "10000", "10110", O, O, O);
			  
		WHEN "110111" =>
			  To_Seg <= ("10100", "10101", "10000", "10110", O, O, O, O);
			  
		WHEN "111000" =>
			  To_Seg <= ("10101", "10000", "10110", O, O, O, O, O);
			  
		WHEN "111001" =>
			  To_Seg <= ("10000", "10110", O, O, O, O, O, O);
			  
		WHEN "111010" =>
			  To_Seg <= ("10110", O, O, O, O, O, O, O);
		-------------------Err--------------------------------	  
		when "111011" => 
			  To_seg(2 downto 0) <=("10001","10111","10111");
     
	   
      when others => To_seg <=(O, O, O, O, O, O, O, O);
			  
			 
	
	end case;
 end IF;
end process; 
end behaviour;