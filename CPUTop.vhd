library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CPUTop is
  Port ( 
        inrTop : in std_logic_vector(3 downto 0);
        outValTop : out std_logic_vector(15 downto 0);
        memOut : in std_logic_vector(15 downto 0);
        clk    : in std_logic);
end CPUTop;

architecture Behavioral of CPUTop is

component Mux1 
    port(a, b, sel : in std_logic;
          c : out std_logic);
end component;

component Adder1
    port(a, b : in std_logic_vector(3 downto 0);
          clk, cout : in std_logic;
          sum : out std_logic_vector(3 downto 0));       
end component; 

component RegisterFile
    generic (
      constant Bits : integer := 16
    );
    port(dataIn      : in std_logic_vector(Bits-1 downto 0);
         writeEnable : in std_logic;
         readAddrA   : in std_logic_vector(3 downto 0);
         readAddrB   : in std_logic_vector(3 downto 0);
         writeAddr   : in std_logic_vector(3 downto 0);
         inr         : in std_logic_vector(3 downto 0);
         outputValue : out std_logic_vector(Bits-1 downto 0);
         outRegA     : out std_logic_vector(Bits-1 downto 0);
         outRegB     : out std_logic_vector(Bits-1 downto 0);
         Clk         : in std_logic);  
end component;

component ControlUnit
    port (
        opcode: in std_logic_vector(3 downto 0);
        controlOut : out std_logic_vector(8 downto 0)
    );
end component;

component ALU
    generic (
        constant MOVE : integer := 1
    );
    port (
        ALUOp : in std_logic_vector(3 downto 0);
        A     : in std_logic_vector(3 downto 0);
        B     : in std_logic_vector(3 downto 0);
        O     : out std_logic_vector(3 downto 0)
    );
end component;

component ProgramCounter
    port (
        clk : in std_logic;
        sel : in std_logic;
        signExtend : in STD_LOGIC_VECTOR(63 downto 0);       
        Q : out STD_LOGIC_VECTOR(63 downto 0)
    );             
end component;

subtype data is std_logic_vector(15 downto 0);
signal opcode : data;
signal pcOut: data;
signal carryFlag: std_logic;

signal regOutzero : data;
signal regOutOne : data;

signal controlOut: std_logic_vector(8 downto 0);
signal halt : data;

signal mux1out : data;
signal mux2out : data;
signal mux3out : data;

signal aluOut : data;
signal aluFlag : std_logic_vector(3 downto 0);

signal muxOutLogic : std_logic;

signal addResult : data;
signal add2Result : data;
signal branchFlag : std_logic;

signal instruction : std_logic_vector(15 downto 0);
signal we : std_logic;

signal memory_out      : DATA:="0000000000000000"; --output of external memory
signal sCLK          : STD_LOGIC :='0';
signal writeAddress       : DATA:="0000000000000000";
signal dataIn         : DATA:="0000000000000000";     

begin

    PCAdder: Adder1
        port map(
            a => pcOut,
            b => halt,
            Clk => Clk,
            Cout => carryFlag,
            Sum => addResult);
            
     Adder2: Adder1
        port map(
            a => pcOut,
            b => addResult,
            Clk => Clk,
            Cout => carryFlag,
            Sum => add2Result);  
      
     Control: ControlUnit
         port map(opcode => opcode(15 downto 12),
                  controlOut => controlOut);   
                  
     ALUComponent: ALU    
        generic map(16)
        port map(
            ALUOp => controlOut(3 downto 0),
            A => regOutzero,
            B => mux1out,
            O => aluOut); 
     Mux: mux1
     port map(
        a => opcode(7),
        b => opcode(11), 
        sel => controlOut(6),
        c => muxOutLogic);
                       
    RegistersFile: RegisterFile
        port map(
             dataIn => mux3out,
             writeEnable => we,
             readAddrA => instruction(11 downto 8),
             readAddrB => instruction(7 downto 4),
             writeAddr => instruction(3 downto 0),   
             inr => instruction(3 downto 0),
             outputValue => instruction,
             clk => Clk,
             outRegA => mux3out,
             outRegB => mux3out); 
             
   process 
   begin
     we <= '0'; 
     for i in 0 to (4) loop
        if (i = 0) then 
             writeAddress <= STD_LOGIC_VECTOR(to_unsigned(i,16));
             dataIn <= "0001010101100111"; -- add
             wait for 2ns;
             we <= '1';
             wait for 2ns;
             we <= '0';
         end if;
         if (i = 1) then
             writeAddress <= STD_LOGIC_VECTOR(to_unsigned(i,16));
             dataIn <= "001001010110011"; -- sub
             wait for 2ns;
             we <= '1';
             wait for 2ns;
             we <= '0'; 
          end if;
          if (i = 2) then
              writeAddress <= STD_LOGIC_VECTOR(to_unsigned(i,16));
              dataIn <= "010101010110011"; -- and
              wait for 2ns;
              we <= '1';
              wait for 2ns;
              we <= '0'; 
           end if;
           if (i = 3) then
               writeAddress <= STD_LOGIC_VECTOR(to_unsigned(i,16));
               dataIn <= "011001010110011"; -- or
               wait for 2ns;
               we <= '1';
               wait for 2ns;
               we <= '0'; 
           end if;
           if (i = 4) then
                writeAddress <= STD_LOGIC_VECTOR(to_unsigned(i,16));
                dataIn <= "011101010110011"; -- xor
                wait for 2ns;
                we <= '1';
                wait for 2ns;
                we <= '0'; 
             end if;            
          wait for 2ns;
          end loop;
          wait for 2ns;       
      end process;     
end Behavioral;
