----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:04:27 01/02/2021 
-- Design Name: 
-- Module Name:    debouncer - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debouncer_2 is
	Port(clk : in std_logic;
			reset : in std_logic;
			b_1 : in std_logic;
			b_2 : in std_logic;
			b_3 : in std_logic;
			b1_db : out std_logic;
			b2_db : out std_logic;
			b3_db : out std_logic
	);
end debouncer_2;

architecture Behavioral of debouncer_2 is
	constant MAXCOUNT : integer := 2000000;
	signal b1_count, b2_count, b3_count : integer range 0 to MAXCOUNT := 0;
	signal count_maxb1,count_maxb2,count_maxb3 : std_logic := '0';
	signal count_maxb1_aux, count_maxb2_aux, count_maxb3_aux : std_logic := '0';
	signal Stateb1, Stateb2, Stateb3 : integer range 0 to 2 := 0;
	signal Stateb1_aux, Stateb2_aux, Stateb3_aux : integer range 0 to 2 := 0;
	signal b1_db_aux, b2_db_aux,b3_db_aux : std_logic := '0';

begin
--------------------------------- Botao b_1---------------------------------
process(clk, reset)
begin	
		if reset = '1' then
			Stateb1_aux <= 0;
		elsif clk'event and clk = '1' then
			if Stateb1_aux = 0 and b_1 = '1' then
				Stateb1_aux <= 1;
				b1_db_aux <= '1';
			end if;
			if Stateb1_aux = 1 and count_maxb1 = '1' then
				Stateb1_aux <= 2;
				b1_db_aux <= '1';
			end if;
			if Stateb1_aux = 2 and b_1 = '1' then
				Stateb1_aux <= 1;
				b1_db_aux <= '1';
			elsif Stateb1_aux = 2 and b_1 = '0' then
				Stateb1_aux <= 0;
				b1_db_aux <= '0';
			end if;
		end if;
end process;

Stateb1 <= Stateb1_aux;
b1_db <= '1' when b1_db_aux = '1' else '0';

process (clk, reset)
begin
	if reset = '1' then
	elsif clk'event and clk = '1' then
		if Stateb1 = 1 then
			if b1_count = MAXCOUNT - 1 then
				count_maxb1_aux <= '1';
				b1_count <= 0;
			else 
				count_maxb1_aux <= '0';
				b1_count <= b1_count + 1;
			end if;
		end if;
	end if;
end process;
 count_maxb1 <= '1' when count_maxb1_aux = '1' else '0';
 
---------------------------------------Botao 2------------------------------------------------
process(clk, reset)
begin	
		if reset = '1' then
			Stateb2_aux <= 0;
		elsif clk'event and clk = '1' then
			if Stateb2_aux = 0 and b_2 = '1' then
				Stateb2_aux <= 1;
				b2_db_aux <= '1';
			end if;
			if Stateb2_aux = 1 and count_maxb2 = '1' then
				Stateb2_aux <= 2;
				b2_db_aux <= '1';
			end if;
			if Stateb2_aux = 2 and b_2 = '1' then
				Stateb2_aux <= 1;
				b2_db_aux <= '1';
			elsif Stateb2_aux = 2 and b_2 = '0' then
				Stateb2_aux <= 0;
				b2_db_aux <= '0';
			end if;
		end if;
end process;

Stateb2 <= Stateb2_aux;
b2_db <= '1' when b2_db_aux = '1' else '0';

process (clk, reset)
begin
	if reset = '1' then
	elsif clk'event and clk = '1' then
		if Stateb2 = 1 then
			if b2_count = MAXCOUNT - 1 then
				count_maxb2_aux <= '1';
				b2_count <= 0;
			else 
				count_maxb2_aux <= '0';
				b2_count <= b2_count + 1;
			end if;
		end if;
	end if;
end process;
 count_maxb2 <= '1' when count_maxb2_aux = '1' else '0';
 

-----------------------------------------------Botao 3--------------------------------------------------

process(clk, reset)
begin	
		if reset = '1' then
			Stateb3_aux <= 0;
		elsif clk'event and clk = '1' then
			if Stateb3_aux = 0 and b_3 = '1' then
				Stateb3_aux <= 1;
				b3_db_aux <= '1';
			end if;
			if Stateb3_aux = 1 and count_maxb3 = '1' then
				Stateb3_aux <= 2;
				b3_db_aux <= '1';
			end if;
			if Stateb3_aux = 2 and b_3 = '1' then
				Stateb3_aux <= 1;
				b3_db_aux <= '1';
			elsif Stateb3_aux = 2 and b_3 = '0' then
				Stateb3_aux <= 0;
				b3_db_aux <= '0';
			end if;
		end if;
end process;

Stateb3 <= Stateb3_aux;
b3_db <= '1' when b3_db_aux = '1' else '0';

process (clk, reset)
begin
	if reset = '1' then
	elsif clk'event and clk = '1' then
		if Stateb3 = 1 then
			if b3_count = MAXCOUNT - 1 then
				count_maxb3_aux <= '1';
				b3_count <= 0;
			else 
				count_maxb3_aux <= '0';
				b3_count <= b3_count + 1;
			end if;
		end if;
	end if;
end process;
 count_maxb3 <= '1' when count_maxb3_aux = '1' else '0';


end Behavioral;

