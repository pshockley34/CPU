library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ProgramCounter is
    port ( CLK : in STD_LOGIC;
           Sel : in STD_LOGIC;
           branch : in STD_LOGIC_VECTOR(63 downto 0);
           instructionOut : out STD_LOGIC_VECTOR(63 downto 0));
            
end ProgramCounter;

architecture Behavioral of ProgramCounter is

signal currentAddress : STD_LOGIC_VECTOR(63 downto 0);

begin
process(CLK)
begin
    if rising_edge(CLK) then
        if Sel = '0' then
            currentAddress <= STD_LOGIC_VECTOR(unsigned(currentAddress) + 1);
        elsif Sel = '1' then
            currentAddress <= branch
        end if;
    end if;
end process;

instructionOut <= currentAddress;

end Behavioral;
