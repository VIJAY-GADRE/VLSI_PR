library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fifo is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rd_wr : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (1 downto 0) := "00";
           d_in : in  STD_LOGIC_VECTOR (7 downto 0);
           d_out : out  STD_LOGIC_VECTOR (7 downto 0) := "00000000";
           empty : out  STD_LOGIC := '1';
           full : out  STD_LOGIC := '0');
end fifo;

architecture Behavioral of fifo is
type mem is array(3 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
signal memory : mem := (others=>(others=>'0'));
begin
	process(rst, clk, rd_wr, addr, d_in)
	begin
		if rst = '1' then
			d_out <= "00000000";
			empty <= '1';
			full <= '0';
		
		elsif falling_edge(clk) then
			case rd_wr is
				when '0' =>
					d_out <= memory(conv_integer(addr));
					empty <= '0';
					full <= '1';
				
				when others =>
					memory(conv_integer(addr)) <= d_in;
					empty <= '0';
					if addr = "11" then
						full <= '1';
					else
						full <= '0';
					end if;
			end case;
		end if;
	end process;
end Behavioral;
