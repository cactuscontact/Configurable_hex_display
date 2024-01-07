LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.definitions_package.all;

ENTITY IO_controller IS

Port ( To_Seg : in ToSeg;		 
	    To_Hex : out ToHex);

End IO_Controller;

Architecture logicfunction of IO_controller is
	
	BEGIN
	
	U1 : SegDec
			port map(D=>To_seg(0),Y=>To_Hex(0));
	
	U2 : SegDec
			port map(D=>To_seg(1),Y=>To_Hex(1));
	
	U3 : SegDec
			port map(D=>To_seg(2),Y=>To_Hex(2));
	
	U4 : SegDec
			port map(D=>To_seg(3),Y=>To_Hex(3));
	
	U5 : SegDec
			port map(D=>To_seg(4),Y=>To_Hex(4));
	
	U6 : SegDec
			port map(D=>To_seg(5),Y=>To_Hex(5));
	
	U7 : SegDec
			port map(D=>To_seg(6),Y=>To_Hex(6));
	
	U8 : SegDec
			port map(D=>To_seg(7),Y=>To_Hex(7));
	
	
	End logicfunction;
	
	
	