library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity mux1 is
	port(A,B : in STD_LOGIC;
		Sel: in STD_LOGIC;
		C: out STD_LOGIC);
	end mux1;
 
architecture Behavioral of mux1 is
    signal temp : STD_LOGIC;
begin
 
process (A,B,Sel) is
begin
	if (Sel = '0') then
		temp <= A;
	else
		temp <= B;
	end if;
end process;

C <= temp;
 
end Behavioral;
