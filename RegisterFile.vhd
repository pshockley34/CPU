LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
  generic (
    constant Bits : integer := 16 -- size of Reg
  );  
  port(
    dataIn      : IN  STD_LOGIC_VECTOR(Bits-1 downto 0);
    writeEnable : IN  STD_LOGIC;
    readAddrA   : IN  STD_LOGIC_VECTOR(3 downto 0);
    readAddrB   : IN  STD_LOGIC_VECTOR(3 downto 0);
    writeAddr   : IN  STD_LOGIC_VECTOR(3 downto 0);
    Clk         : IN  STD_LOGIC;
    inr         : IN  STD_LOGIC_VECTOR(3 downto 0);
    outputValue : OUT STD_LOGIC_VECTOR(15 downto 0);
    outRegA     : OUT STD_LOGIC_VECTOR(Bits-1 downto 0);
    outRegB     : OUT STD_LOGIC_VECTOR(Bits-1 downto 0)
    );
    
end RegisterFile;

architecture Behavioral of RegisterFile is
  type registerFile is array(0 to 15) of std_logic_vector(Bits-1 downto 0);
  signal registers : registerFile;
begin
  regFile : process(Clk) is
  begin
    if rising_edge(Clk) then
      outRegA <= registers(to_integer(unsigned(readAddrA)));
      outRegB <= registers(to_integer(unsigned(readAddrB)));

      if writeEnable = '1' then
        registers(to_integer(unsigned(writeAddr))) <= dataIn;  -- Write
        
        if readAddrA = writeAddr then 
          outRegA <= dataIn;
        end if;
        
        if readAddrB = writeAddr then  
          outRegB <= dataIn;
        end if;
        
      end if;
      
    end if;
    
  end process;
end Behavioral;
