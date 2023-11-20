LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY fifo_tb IS
END fifo_tb;
 
ARCHITECTURE behavior OF fifo_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fifo
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         rd_wr : IN  std_logic;
         addr : IN  std_logic_vector(1 downto 0);
         d_in : IN  std_logic_vector(7 downto 0);
         d_out : OUT  std_logic_vector(7 downto 0);
         empty : OUT  std_logic;
         full : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '1';
   signal rd_wr : std_logic := '0';
   signal addr : std_logic_vector(1 downto 0) := (others => '0');
   signal d_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal d_out : std_logic_vector(7 downto 0);
   signal empty : std_logic;
   signal full : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fifo PORT MAP (
          rst => rst,
          clk => clk,
          rd_wr => rd_wr,
          addr => addr,
          d_in => d_in,
          d_out => d_out,
          empty => empty,
          full => full
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	
		rd_wr <= '1';
		for address in 0 to 3 loop
			addr <= std_logic_vector(to_unsigned(address, 2));
			d_in <= std_logic_vector(to_unsigned(63*(address+1), 8));
			wait for clk_period*2;
		end loop;
		
		d_in <= std_logic_vector(to_unsigned(0,8));
		rd_wr <= '0';
		for address in 0 to 3 loop
			addr <= std_logic_vector(to_unsigned(address, 2));
			wait for clk_period*2;
		end loop;
   end process;
	
	stim_proc_rst :process
   begin
		rst <= '0';
		wait for clk_period*2;
		rst <= '1';
		wait for clk_period*2;
   end process;

END;
