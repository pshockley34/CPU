library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity ALU is
     generic (
         constant MOVE : integer := 1 -- number of bits shifted
     );     
    Port ( ALUOp : in std_logic_vector (3 downto 0); -- select operation w/ opcode
		   A   : in std_logic_vector (3 downto 0); -- input A
		   B   : in std_logic_vector (3 downto 0); -- input B
           O   : out std_logic_vector (3 downto 0)); 
           
end ALU;

architecture Behavioral of ALU is
signal result : std_logic_vector (3 downto 0);

begin process(A, B, ALUOp)

begin
	case ALUOp is
		when  "0001" => result <= A + B;
		when  "0010" => result <= A - B;
		when  "0011" => result <= A and B;
		when  "0100" => result <= A or B;
		when  "0101" => result <= A xor B;
		when  "0110" => result <= A - B;
	        when  "0111" => result <= A - B;
		when  "1000" => result <= A - B;
		when  "1001" => result <= A - B;
		when  "1011" => result <= std_logic_vector(unsigned(A) srl MOVE);
                when  "1100" => result <= std_logic_vector(unsigned(A) sll MOVE);
		when  "1101" => result <= "0000";
		when  "1110" => result <= "0000";
		when  "1111" => result <= "0000";
		when  others => result <= "0000"
	end case	
end process;

O <= result;	

end Behavioral;
