library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ControlUnit is
  port (
       opcode : in STD_LOGIC_VECTOR(3 downto 0);
       controlOut : out STD_LOGIC_VECTOR(8 downto 0)
   );
end ControlUnit;

architecture Behavioral of ControlUnit is

begin
    with opcode select
    
        -- bits: branch regWrite MemRead MemWrite MemToReg ALUop
        --            x        x       x        x        x    xxxx
        controlOut <= "000000000" when "0000", --halt
                      "010000001" when "0001", --add
                      "010000010" when "0010", --sub
                      "011010000" when "0011", -- ld
                      "000110000" when "0100", -- st
                      "010000011" when "0101", -- and
                      "010000100" when "0110", -- or
                      "010000101" when "0111", -- xor
                      "100000110" when "1000", -- beq
                      "100000111" when "1001", -- bne
                      "100001000" when "1010", -- bgt 
                      "100001001" when "1011", -- blt
                      "011011010" when "1100", -- addi
                      "010001011" when "1101", -- slr
                      "010001100" when "1110", -- sll
                      "100000000" when "1111", -- jmp       
                      "000000000" when others;                                                                    

end Behavioral;
