library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           F : in  STD_LOGIC_VECTOR (2 downto 0);
           Y : out  STD_LOGIC_VECTOR (3 downto 0);
           C_B : out  STD_LOGIC);
end alu;

architecture Behavioral of alu is
signal result : STD_LOGIC_VECTOR(4 downto 0) := "00000";
begin
	process(A,B,F)
	begin
		case F is
			when "000" => result <= '0' & (A AND B);
			when "001" => result <= '0' & (A NAND B);
			when "010" => result <= '0' & (A OR B);
			when "011" => result <= '0' & (A XOR B);
			when "100" => result <= '0' & (A XNOR B);
			when "101" => result <= '0' & (A NOR B);
			when "110" => result <= ('0' & A) + ('0' & B);
			when others => result <= ('0' & A) - ('0' & B);
		end case;
	end process;
	Y <= result (3 downto 0);
	C_B <= result(4);

end Behavioral;
