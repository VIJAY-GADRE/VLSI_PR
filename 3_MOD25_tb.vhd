LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY mod25_tb IS
END mod25_tb;
 
ARCHITECTURE behavior OF mod25_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mod25
    PORT(
         rst : IN  std_logic;
         pr : IN  std_logic;
         clk : IN  std_logic;
         dir : IN  std_logic;
         Q : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal pr : std_logic := '0';
   signal clk : std_logic := '0';
   signal dir : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mod25 PORT MAP (
          rst => rst,
          pr => pr,
          clk => clk,
          dir => dir,
          Q => Q
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
   stim_proc_dir: process
   begin		
      dir <= not(dir);
      wait for 100 ns;	
   end process;
	
	stim_proc_rst: process
   begin		
      rst <= not(rst);
      wait for 100 ns;	
   end process;
	
	stim_proc_pr: process
   begin		
      pr <= not(pr);
      wait for 100 ns;	
   end process;

END;
