----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:19:53 12/29/2020 
-- Design Name: 
-- Module Name:    input_selector - Behavioral 
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

entity controlo_input_2 is
    Port ( clk : in  STD_LOGIC;
           b_1 : in  STD_LOGIC;
           b_2 : in  STD_LOGIC;
           b_3 : in  STD_LOGIC;
           sw : in std_logic_vector(7 downto 0);
			  acertar : out STD_LOGIC;
			  alt_ab : out STD_LOGIC;
			  alt_fec : out STD_LOGIC;
			  inc_h : out STD_LOGIC;
			  inc_m : out STD_LOGIC;
			  PRES1_IN_1 : out STD_LOGIC;
			  TICKET_IN_1 : out STD_LOGIC;
			  PRES2_IN_1 : out STD_LOGIC;
			  
			  PRES1_OUT_1 : out STD_LOGIC;
			  PRES2_OUT_1 : out STD_LOGIC;
			  TICKET_OUT_1 : out STD_LOGIC;
			  
			  PRES1_IN_2 : out STD_LOGIC;
			  PRES2_IN_2 : out STD_LOGIC;
			  TICKET_IN_2 : out STD_LOGIC;
			  
			  PRES1_OUT_2 : out STD_LOGIC;
			  PRES2_OUT_2 : out STD_LOGIC;
			  TICKET_OUT_2 : out STD_LOGIC;
			  
			  AND_12A : out STD_LOGIC;
			  AND_12B : out STD_LOGIC;
			  
			  AND_21A : out STD_LOGIC;
			  AND_21B : out STD_LOGIC;
			  invalid : out STD_LOGIC;
			  
			  piso_1 : out STD_LOGIC;
			  piso_2 : out STD_LOGIC;
			  vazios : out STD_LOGIC;
			  preenchidos : out STD_LOGIC);
end controlo_input_2;

architecture Behavioral of controlo_input_2 is
signal acertar_aux, inc_h_aux, inc_m_aux, alt_ab_aux, alt_fec_aux : std_logic := '0';
signal PRES1_IN_1_aux, TICKET_IN_1_aux, PRES2_IN_1_aux : std_logic := '0';
signal PRES1_OUT_1_aux, PRES2_OUT_1_aux, TICKET_OUT_1_aux : std_logic := '0';
signal PRES1_IN_2_aux, PRES2_IN_2_aux, TICKET_IN_2_aux : std_logic := '0';
signal PRES1_OUT_2_aux, PRES2_OUT_2_aux, TICKET_OUT_2_aux : std_logic := '0';
signal AND_12A_aux, AND_12B_aux, AND_21A_aux, AND_21B_aux, invalid_aux : std_logic := '0';
signal piso1_aux, piso2_aux, vazios_aux, preenchidos_aux : STD_LOGIC := '0';

begin

--------------- controlo dos botoes de pressao em funcao de sw_6 e sw_7---------------------------
process (clk)
begin
	if clk'event and clk = '1' then 
	---------------------modo controlo do parque-------------------------------
		if sw(7) = '0' and sw(6) = '0' and sw(5) = '0' and sw(4) = '0'   then 
			acertar_aux <= '0';
			alt_ab_aux <= '0';
			alt_fec_aux <= '0';
			piso1_aux <= '0';
			piso2_aux <= '0';
			vazios_aux <= '0';
			preenchidos_aux <= '0';
			case sw(2 downto 0) is
				when "000" =>	if b_1 = '1' then
										PRES1_IN_1_aux <= '1';
									else PRES1_IN_1_aux <= '0';
									end if;
									if b_2 = '1' then
										TICKET_IN_1_aux <= '1';
									else TICKET_IN_1_aux <= '0';
									end if;
									if b_3 = '1' then
										PRES2_IN_1_aux <= '1';
									else PRES2_IN_1_aux <= '0';
									end if;	
				when "001" => if b_1 = '1' then
										PRES1_OUT_1_aux <= '1';
									else PRES1_OUT_1_aux <= '0';
									end if;
									if b_2 = '1' then
										TICKET_OUT_1_aux <= '1';
									else TICKET_OUT_1_aux <= '0';
									end if;
									if b_3 = '1' then
										PRES2_OUT_1_aux <= '1';
									else PRES2_OUT_1_aux <= '0';
									end if;	
				when "010" => if b_1 = '1' then
										PRES1_IN_2_aux <= '1';
									else PRES1_IN_2_aux <= '0';
									end if;
									if b_2 = '1' then
										TICKET_IN_2_aux <= '1';
									else TICKET_IN_2_aux <= '0';
									end if;
									if b_3 = '1' then
										PRES2_IN_2_aux <= '1';
									else PRES2_IN_2_aux <= '0';
									end if;	
				when "011" => if b_1 = '1' then
										PRES1_OUT_2_aux <= '1';
									else PRES1_OUT_2_aux <= '0';
									end if;
									if b_2 = '1' then
										TICKET_OUT_2_aux <= '1';
									else TICKET_OUT_2_aux <= '0';
									end if;
									if b_3 = '1' then
										PRES2_OUT_2_aux <= '1';
									else PRES2_OUT_2_aux <= '0';
									end if;	
				when "100" => if b_1 = '1' then
										AND_12A_aux <= '1';
									else AND_12A_aux <= '0';
									end if;
									if b_2 = '1' then
										AND_12B_aux <= '1';
									else AND_12B_aux <= '0';
									end if;
				when "101" => if b_1 = '1' then
										AND_21A_aux <= '1';
									else AND_21A_aux <= '0';
									end if;
									if b_2 = '1' then
										AND_21B_aux <= '1';
									else AND_21B_aux <= '0';
									end if;
				when others => invalid_aux <= '1';
			end case;
				
		end if;
		
		---------------- Modo acertar relogio-----------------------------------
		if sw(7) = '0' and sw(6) = '0' and sw(5) = '0' and sw(4) = '1' then 
			alt_ab_aux <= '0';
			alt_fec_aux <= '0';			
			acertar_aux <= '1';
			piso1_aux <= '0';
			piso2_aux <= '0';
			vazios_aux <= '0';
			preenchidos_aux <= '0';
			if b_1 = '1' then
				inc_h_aux <= '1';
			else inc_h_aux <= '0';
			end if;
			if b_2 = '1' then
				inc_m_aux <= '1';
			else inc_m_aux <= '0';
			end if;
		end if;
		
		------------------- Modo alterar hora de abertura--------------------------------
		if sw(7) = '0' and sw(6) = '0' and sw(5) = '1' and sw(4) = '0' then 
			alt_ab_aux <= '1';
			alt_fec_aux <= '0';			
			acertar_aux <= '0';
			piso1_aux <= '0';
			piso2_aux <= '0';
			vazios_aux <= '0';
			preenchidos_aux <= '0';			
			if b_1 = '1' then
				inc_h_aux <= '1';
			else inc_h_aux <= '0';
			end if;
			if b_2 = '1' then
				inc_m_aux <= '1';
			else inc_m_aux <= '0';
			end if;
		end if;		
		----------------------- Modo alterar hora de fecho-----------------------------------------
		if sw(7) = '0' and sw(6) = '0' and sw(5) = '1' and sw(4) = '1' then  
			alt_fec_aux <= '1';
			acertar_aux <= '0';
			alt_ab_aux <= '0';
			piso1_aux <= '0';
			piso2_aux <= '0';
			vazios_aux <= '0';
			preenchidos_aux <= '0';
			if b_1 = '1' then
				inc_h_aux <= '1';
			else inc_h_aux <= '0';
			end if;
			if b_2 = '1' then
				inc_m_aux <= '1';
			else inc_m_aux <= '0';
			end if;
		end if;	
	----------------------------Modo mostar lugares vazios parque------------------------------------------------
		if sw(7) = '0' and sw(6) = '1' and sw(5) = '0' and sw(4) = '0' then
				alt_fec_aux <= '0';
				acertar_aux <= '0';
				alt_ab_aux <= '0';
				piso1_aux <= '0';
				piso2_aux <= '0';
				vazios_aux <= '1';
				preenchidos_aux <= '0';		
				case sw(2 downto 0) is
					when "000" =>	if b_1 = '1' then
											PRES1_IN_1_aux <= '1';
										else PRES1_IN_1_aux <= '0';
										end if;
										if b_2 = '1' then
											TICKET_IN_1_aux <= '1';
										else TICKET_IN_1_aux <= '0';
										end if;
										if b_3 = '1' then
											PRES2_IN_1_aux <= '1';
										else PRES2_IN_1_aux <= '0';
										end if;	
					when "001" => if b_1 = '1' then
											PRES1_OUT_1_aux <= '1';
										else PRES1_OUT_1_aux <= '0';
										end if;
										if b_2 = '1' then
											TICKET_OUT_1_aux <= '1';
										else TICKET_OUT_1_aux <= '0';
										end if;
										if b_3 = '1' then
											PRES2_OUT_1_aux <= '1';
										else PRES2_OUT_1_aux <= '0';
										end if;	
					when "010" => if b_1 = '1' then
											PRES1_IN_2_aux <= '1';
										else PRES1_IN_2_aux <= '0';
										end if;
										if b_2 = '1' then
											TICKET_IN_2_aux <= '1';
										else TICKET_IN_2_aux <= '0';
										end if;
										if b_3 = '1' then
											PRES2_IN_2_aux <= '1';
										else PRES2_IN_2_aux <= '0';
										end if;	
					when "011" => if b_1 = '1' then
											PRES1_OUT_2_aux <= '1';
										else PRES1_OUT_2_aux <= '0';
										end if;
										if b_2 = '1' then
											TICKET_OUT_2_aux <= '1';
										else TICKET_OUT_2_aux <= '0';
										end if;
										if b_3 = '1' then
											PRES2_OUT_2_aux <= '1';
										else PRES2_OUT_2_aux <= '0';
										end if;	
					when "100" => if b_1 = '1' then
											AND_12A_aux <= '1';
										else AND_12A_aux <= '0';
										end if;
										if b_2 = '1' then
											AND_12B_aux <= '1';
										else AND_12B_aux <= '0';
										end if;
					when "101" => if b_1 = '1' then
											AND_21A_aux <= '1';
										else AND_21A_aux <= '0';
										end if;
										if b_2 = '1' then
											AND_21B_aux <= '1';
										else AND_21B_aux <= '0';
										end if;
					when others => invalid_aux <= '1';
				end case;		
		end if;		
		
----------------------------------------------- Mostrar lugares preeenchidos------------------------------------------

		if sw(7) = '0' and sw(6) = '1' and sw(5) = '0' and sw(4) = '1' then
				alt_fec_aux <= '0';
				acertar_aux <= '0';
				alt_ab_aux <= '0';
				piso1_aux <= '0';
				piso2_aux <= '0';
				vazios_aux <= '0';
				preenchidos_aux <= '1';		
				case sw(2 downto 0) is
					when "000" =>	if b_1 = '1' then
											PRES1_IN_1_aux <= '1';
										else PRES1_IN_1_aux <= '0';
										end if;
										if b_2 = '1' then
											TICKET_IN_1_aux <= '1';
										else TICKET_IN_1_aux <= '0';
										end if;
										if b_3 = '1' then
											PRES2_IN_1_aux <= '1';
										else PRES2_IN_1_aux <= '0';
										end if;	
					when "001" => if b_1 = '1' then
											PRES1_OUT_1_aux <= '1';
										else PRES1_OUT_1_aux <= '0';
										end if;
										if b_2 = '1' then
											TICKET_OUT_1_aux <= '1';
										else TICKET_OUT_1_aux <= '0';
										end if;
										if b_3 = '1' then
											PRES2_OUT_1_aux <= '1';
										else PRES2_OUT_1_aux <= '0';
										end if;	
					when "010" => if b_1 = '1' then
											PRES1_IN_2_aux <= '1';
										else PRES1_IN_2_aux <= '0';
										end if;
										if b_2 = '1' then
											TICKET_IN_2_aux <= '1';
										else TICKET_IN_2_aux <= '0';
										end if;
										if b_3 = '1' then
											PRES2_IN_2_aux <= '1';
										else PRES2_IN_2_aux <= '0';
										end if;	
					when "011" => if b_1 = '1' then
											PRES1_OUT_2_aux <= '1';
										else PRES1_OUT_2_aux <= '0';
										end if;
										if b_2 = '1' then
											TICKET_OUT_2_aux <= '1';
										else TICKET_OUT_2_aux <= '0';
										end if;
										if b_3 = '1' then
											PRES2_OUT_2_aux <= '1';
										else PRES2_OUT_2_aux <= '0';
										end if;	
					when "100" => if b_1 = '1' then
											AND_12A_aux <= '1';
										else AND_12A_aux <= '0';
										end if;
										if b_2 = '1' then
											AND_12B_aux <= '1';
										else AND_12B_aux <= '0';
										end if;
					when "101" => if b_1 = '1' then
											AND_21A_aux <= '1';
										else AND_21A_aux <= '0';
										end if;
										if b_2 = '1' then
											AND_21B_aux <= '1';
										else AND_21B_aux <= '0';
										end if;
					when others => invalid_aux <= '1';
				end case;		
		end if;	
		
--------------------------------------------------------------- Mostrar lugares do piso_1-------------------------------------------------
		if sw(7) = '0' and sw(6) = '1' and sw(5) = '1' and sw(4) = '0' then
				alt_fec_aux <= '0';
				acertar_aux <= '0';
				alt_ab_aux <= '0';
				piso1_aux <= '1';
				piso2_aux <= '0';
				vazios_aux <= '0';
				preenchidos_aux <= '0';		
				case sw(2 downto 0) is
					when "000" =>	if b_1 = '1' then
											PRES1_IN_1_aux <= '1';
										else PRES1_IN_1_aux <= '0';
										end if;
										if b_2 = '1' then
											TICKET_IN_1_aux <= '1';
										else TICKET_IN_1_aux <= '0';
										end if;
										if b_3 = '1' then
											PRES2_IN_1_aux <= '1';
										else PRES2_IN_1_aux <= '0';
										end if;	
					when "001" => if b_1 = '1' then
											PRES1_OUT_1_aux <= '1';
										else PRES1_OUT_1_aux <= '0';
										end if;
										if b_2 = '1' then
											TICKET_OUT_1_aux <= '1';
										else TICKET_OUT_1_aux <= '0';
										end if;
										if b_3 = '1' then
											PRES2_OUT_1_aux <= '1';
										else PRES2_OUT_1_aux <= '0';
										end if;	
					when "010" => if b_1 = '1' then
											PRES1_IN_2_aux <= '1';
										else PRES1_IN_2_aux <= '0';
										end if;
										if b_2 = '1' then
											TICKET_IN_2_aux <= '1';
										else TICKET_IN_2_aux <= '0';
										end if;
										if b_3 = '1' then
											PRES2_IN_2_aux <= '1';
										else PRES2_IN_2_aux <= '0';
										end if;	
					when "011" => if b_1 = '1' then
											PRES1_OUT_2_aux <= '1';
										else PRES1_OUT_2_aux <= '0';
										end if;
										if b_2 = '1' then
											TICKET_OUT_2_aux <= '1';
										else TICKET_OUT_2_aux <= '0';
										end if;
										if b_3 = '1' then
											PRES2_OUT_2_aux <= '1';
										else PRES2_OUT_2_aux <= '0';
										end if;	
					when "100" => if b_1 = '1' then
											AND_12A_aux <= '1';
										else AND_12A_aux <= '0';
										end if;
										if b_2 = '1' then
											AND_12B_aux <= '1';
										else AND_12B_aux <= '0';
										end if;
					when "101" => if b_1 = '1' then
											AND_21A_aux <= '1';
										else AND_21A_aux <= '0';
										end if;
										if b_2 = '1' then
											AND_21B_aux <= '1';
										else AND_21B_aux <= '0';
										end if;
					when others => invalid_aux <= '1';
				end case;		
		end if;
----------------------------------------- Mostrar lugares piso_2------------------------
		if sw(7) = '0' and sw(6) = '1' and sw(5) = '1' and sw(4) = '1' then
				alt_fec_aux <= '0';
				acertar_aux <= '0';
				alt_ab_aux <= '0';
				piso1_aux <= '0';
				piso2_aux <= '1';
				vazios_aux <= '0';
				preenchidos_aux <= '0';		
				case sw(2 downto 0) is
					when "000" =>	if b_1 = '1' then
											PRES1_IN_1_aux <= '1';
										else PRES1_IN_1_aux <= '0';
										end if;
										if b_2 = '1' then
											TICKET_IN_1_aux <= '1';
										else TICKET_IN_1_aux <= '0';
										end if;
										if b_3 = '1' then
											PRES2_IN_1_aux <= '1';
										else PRES2_IN_1_aux <= '0';
										end if;	
					when "001" => if b_1 = '1' then
											PRES1_OUT_1_aux <= '1';
										else PRES1_OUT_1_aux <= '0';
										end if;
										if b_2 = '1' then
											TICKET_OUT_1_aux <= '1';
										else TICKET_OUT_1_aux <= '0';
										end if;
										if b_3 = '1' then
											PRES2_OUT_1_aux <= '1';
										else PRES2_OUT_1_aux <= '0';
										end if;	
					when "010" => if b_1 = '1' then
											PRES1_IN_2_aux <= '1';
										else PRES1_IN_2_aux <= '0';
										end if;
										if b_2 = '1' then
											TICKET_IN_2_aux <= '1';
										else TICKET_IN_2_aux <= '0';
										end if;
										if b_3 = '1' then
											PRES2_IN_2_aux <= '1';
										else PRES2_IN_2_aux <= '0';
										end if;	
					when "011" => if b_1 = '1' then
											PRES1_OUT_2_aux <= '1';
										else PRES1_OUT_2_aux <= '0';
										end if;
										if b_2 = '1' then
											TICKET_OUT_2_aux <= '1';
										else TICKET_OUT_2_aux <= '0';
										end if;
										if b_3 = '1' then
											PRES2_OUT_2_aux <= '1';
										else PRES2_OUT_2_aux <= '0';
										end if;	
					when "100" => if b_1 = '1' then
											AND_12A_aux <= '1';
										else AND_12A_aux <= '0';
										end if;
										if b_2 = '1' then
											AND_12B_aux <= '1';
										else AND_12B_aux <= '0';
										end if;
					when "101" => if b_1 = '1' then
											AND_21A_aux <= '1';
										else AND_21A_aux <= '0';
										end if;
										if b_2 = '1' then
											AND_21B_aux <= '1';
										else AND_21B_aux <= '0';
										end if;
					when others => invalid_aux <= '1';
				end case;		
		end if;	
	end if; 
end process;




acertar <= '1' when acertar_aux = '1' else '0';
alt_ab <= '1' when alt_ab_aux = '1' else '0';
alt_fec <= '1' when alt_fec_aux = '1' else '0';
vazios <= '1' when vazios_aux = '1' else '0';
piso_1 <= '1' when piso1_aux = '1' else '0';
piso_2 <= '1' when piso2_aux = '1' else '0';
preenchidos <= '1' when preenchidos_aux = '1' else '0';
inc_h <= '1' when inc_h_aux = '1' else '0';
inc_m <= '1' when inc_m_aux = '1' else '0';
PRES1_IN_1 <= '1' when PRES1_IN_1_aux = '1' else '0';
TICKET_IN_1 <= '1' when TICKET_IN_1_aux = '1' else '0';
PRES2_IN_1 <= '1' when PRES2_IN_1_aux = '1' else '0';
PRES1_OUT_1 <= '1' when PRES1_OUT_1_aux = '1' else '0';
PRES2_OUT_1 <= '1' when PRES2_OUT_1_aux = '1' else '0';
TICKET_OUT_1 <= '1' when TICKET_OUT_1_aux = '1' else '0';
PRES1_IN_2 <= '1' when PRES1_IN_2_aux = '1' else '0';
PRES2_IN_2 <= '1' when PRES2_IN_2_aux = '1' else '0';
TICKET_IN_2 <= '1' when TICKET_IN_2_aux = '1' else '0';
PRES1_OUT_2 <= '1' when PRES1_OUT_2_aux = '1' else '0';
PRES2_OUT_2 <= '1' when PRES2_OUT_2_aux = '1' else '0';
TICKET_OUT_2 <= '1' when TICKET_OUT_2_aux = '1' else '0';
AND_12A <= '1' when AND_12A_aux = '1' else '0';
AND_12B <= '1' when AND_12B_aux = '1' else '0';
AND_21A <= '1' when AND_21A_aux = '1' else '0';
AND_21B <= '1' when AND_21B_aux = '1' else '0';
invalid <= '1' when invalid_aux = '1' else '0';

end Behavioral;
