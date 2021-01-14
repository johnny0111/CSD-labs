----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:51:40 12/29/2020 
-- Design Name: 
-- Module Name:    display_selector - Behavioral 
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

entity display_selector_3 is
    Port ( clk : in  STD_LOGIC;
			  hora_abertura : in STD_LOGIC;
			  hora_fecho : in STD_LOGIC;
			  vazios : in STD_LOGIC;
			  preenchidos : in STD_LOGIC;
			  piso_1 : in STD_LOGIC;
			  piso_2 : in STD_LOGIC;
           min_u : in integer range 0 to 9;
           min_d : in integer range 0 to 5;
			  hor_u: in integer range 0 to 9;
			  hor_d: in integer range 0 to 2;  
           min_u_ab : in integer range 0 to 9;
           min_d_ab : in integer range 0 to 5;
			  hor_u_ab: in integer range 0 to 9;
			  hor_d_ab: in integer range 0 to 2;
           min_u_fec : in integer range 0 to 9;
           min_d_fec : in integer range 0 to 5;
			  hor_u_fec: in integer range 0 to 9;
			  hor_d_fec: in integer range 0 to 2;
			  n_vazios : in integer range 0 to 9;
			  n_preenchidos : in integer range 0 to 9;
			  n_piso_1 : integer range 0 to 9;
			  n_piso_2 : integer range 0 to 9;
           OUT_3 : out  integer range 0 to 9;
           OUT_2 : out  integer range 0 to 5;
           OUT_1 : out  integer range 0 to 9;
           OUT_0 : out  integer range 0 to 2);
end display_selector_3;

architecture Behavioral of display_selector_3 is

begin
process(clk)
begin
	if clk'event and clk = '1' then
		if hora_abertura = '1' then
			OUT_3 <= min_u_ab;
			OUT_2 <= min_d_ab;
			OUT_1 <= hor_u_ab;
			OUT_0 <= hor_d_ab;
		else 
			if hora_fecho = '1' then
				OUT_3 <= min_u_fec;
				OUT_2 <= min_d_fec;
				OUT_1 <= hor_u_fec;
				OUT_0 <= hor_d_fec;	
			else 
				if vazios = '1' then
					OUT_3 <= n_vazios;
					OUT_2 <= 0;
					OUT_1 <= 0;
					OUT_0 <= 0;
				else
					if preenchidos = '1' then
						OUT_3 <= n_preenchidos;
						OUT_2 <= 0;
						OUT_1 <= 0;
						OUT_0 <= 0;	
					else 
						if piso_1 = '1' then
							OUT_3 <= n_piso_1;
							OUT_2 <= 0;
							OUT_1 <= 0;
							OUT_0 <= 0;
						else 
							if piso_2 = '1' then
								OUT_3 <= n_piso_2;
								OUT_2 <= 0;
								OUT_1 <= 0;
								OUT_0 <= 0;	
							else
								OUT_3 <= min_u;
								OUT_2 <= min_d;
								OUT_1 <= hor_u;
								OUT_0 <= hor_d;								
							end if;
						end if;
					end if;
				end if;				
			end if;			
		end if;	
	end if;
end process;



end Behavioral;
