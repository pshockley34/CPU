library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

 
entity Adder1 is
    Port ( A, B : in STD_LOGIC_VECTOR(3 downto 0);
           Sum : out STD_LOGIC_VECTOR(3 downto 0);
           Clk : in STD_LOGIC;
           Cout : out STD_LOGIC);
 
end Adder1;
 
architecture Behavioral of Adder1 is
    signal temp : STD_LOGIC_VECTOR(3 downto 0);
begin
    process(Clk)
    begin
        if rising_edge(Clk) then
           temp <= A + B;
        end if;
    end process;
    
    Sum <= temp;
end Behavioral;
