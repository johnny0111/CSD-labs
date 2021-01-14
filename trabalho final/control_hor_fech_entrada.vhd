----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:17:13 12/27/2020 
-- Design Name: 
-- Module Name:    control_hor_fech_entrada - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_hor_fech_entrada is
	Port(
		clk: in std_logic;
		reset: in std_logic;
		modo_alt_ab: in std_logic;
		modo_alt_fec: in std_logic; 
		inc_min: in std_logic;
		inc_hora: in std_logic;
		c_min_u : in integer range 0 to 9;
      c_min_d : in integer range 0 to 5;
		c_hor_u : in integer range 0 to 9;
		c_hor_d : in integer range 0 to 2;
		min_u_ab : out integer range 0 to 9;
		min_d_ab : out integer range 0 to 5;
		hora_u_ab : out integer range 0 to 9;
		hora_d_ab : out integer range 0 to 2;
		min_u_fec : out integer range 0 to 9;
		min_d_fec : out integer range 0 to 5;
		hora_u_fec : out integer range 0 to 9;
		hora_d_fec : out integer range 0 to 2;
		entrada_ok: out std_logic;
		saida_ok: out std_logic
	);
end control_hor_fech_entrada;

architecture Behavioral of control_hor_fech_entrada is

signal min_u_ab_aux, min_u_fec_aux, hora_u_ab_aux, hora_u_fec_aux : integer range 0 to 9;
signal min_d_ab_aux, min_d_fec_aux : integer range 0 to 5;
signal hora_d_ab_aux, hora_d_fec_aux : integer range 0 to 2;
signal total_minutos, total_minutos_ab, total_minutos_fec: integer range 0 to 1500 := 0;


signal entrada_aux, saida_aux, h_d_ab_signal, h_d_fec_signal: std_logic := '0';

signal inc_hora_ab_aux, inc_min_ab_aux, inc_hora_ab_aux2, inc_min_ab_aux2, check_ab_m, check_ab_h, check_ab_m_aux, check_ab_h_aux: std_logic := '0';
signal largou_ab_m, largou_ab_h : std_logic := '1';

signal inc_hora_fec_aux, inc_min_fec_aux, inc_hora_fec_aux2, inc_min_fec_aux2, check_fec_m, check_fec_h, check_fec_m_aux, check_fec_h_aux: std_logic := '0';
signal largou_fec_m, largou_fec_h : std_logic := '1';

begin

--------------------------------------------------ABERTURA------------------------------------------------------------
process (clk, reset) 
	begin
   if reset = '1' then
     min_d_ab_aux <= 0;
	  min_d_fec_aux <= 0;
   elsif clk'event and clk = '1' then
		if check_ab_m_aux = '1' then
			check_ab_m_aux <= '0';
		end if;
		if modo_alt_ab = '1' then
		  if  inc_min_ab_aux2 = '1' then
			 if min_d_ab_aux = 5 then
				check_ab_m_aux <= '1';
				min_d_ab_aux <= 0;
			 else 
				min_d_ab_aux <= min_d_ab_aux + 1;
				check_ab_m_aux <= '1';
			 end if;
		  end if;
		  elsif modo_alt_fec = '1' then
			  if  inc_min_ab_aux2 = '1' then
				 if min_d_fec_aux = 5 then
					check_ab_m_aux <= '1';
					min_d_fec_aux <= 0;
				 else 
					min_d_fec_aux <= min_d_fec_aux + 1;
					check_ab_m_aux <= '1';
				 end if;	
				end if;
		 end if;
   end if;
end process;

min_d_ab <= min_d_ab_aux;
min_d_fec <= min_d_fec_aux;

process (clk, reset)
begin
	if reset = '1' then
		hora_u_ab_aux <= 0;
		hora_u_fec_aux <= 0;
	elsif clk'event and clk = '1' then
		if	check_ab_h_aux = '1' then
			check_ab_h_aux <= '0';
		end if;
		if modo_alt_ab = '1' then
			if inc_hora_ab_aux2 = '1' then
				if hora_d_ab_aux = 2 and hora_u_ab_aux = 3 then
					hora_u_ab_aux <= 0;
					check_ab_h_aux <= '1';
				elsif hora_u_ab_aux = 9 then
					hora_u_ab_aux <= 0;
					check_ab_h_aux <= '1';
				else 
					hora_u_ab_aux <= hora_u_ab_aux + 1;
					check_ab_h_aux <= '1';
				end if;
			end if;
		elsif modo_alt_fec = '1' then
			if inc_hora_ab_aux2 = '1' then
				if hora_d_fec_aux = 2 and hora_u_fec_aux = 3 then
					hora_u_fec_aux <= 0;
					check_ab_h_aux <= '1';
				elsif hora_u_fec_aux = 9 then
					hora_u_fec_aux <= 0;
					check_ab_h_aux <= '1';
				else 
					hora_u_fec_aux <= hora_u_fec_aux + 1;
					check_ab_h_aux <= '1';
				end if;
			end if;			
		end if;
	end if;
end process;	

h_d_ab_signal <= '1' when (hora_u_ab_aux = 9 and  inc_hora_ab_aux2 = '1') or (hora_u_ab_aux = 3 and hora_d_ab_aux = 2 and  inc_hora_ab_aux2 = '1') else '0';
h_d_fec_signal <= '1' when (hora_u_fec_aux = 9 and  inc_hora_ab_aux2 = '1') or (hora_u_fec_aux = 3 and hora_d_fec_aux = 2 and  inc_hora_ab_aux2 = '1') else '0';
hora_u_ab <= hora_u_ab_aux;
hora_u_fec <= hora_u_fec_aux;
check_ab_m <= '1' when check_ab_m_aux = '1' else '0';
check_ab_h <= '1' when check_ab_h_aux = '1' else '0';


process(clk, reset)
begin
	if reset = '1' then
		hora_d_ab_aux <= 0;
		hora_d_fec_aux <= 0;
	elsif clk'event and clk = '1' then
		if modo_alt_ab = '1' then
			if h_d_ab_signal = '1' then
				if hora_d_ab_aux = 2 then
					hora_d_ab_aux <= 0;
				else
					hora_d_ab_aux <= hora_d_ab_aux + 1;
				end if;
			end if;
		elsif modo_alt_fec = '1' then
			if h_d_fec_signal = '1' then
				if hora_d_fec_aux = 2 then
					hora_d_fec_aux <= 0;
				else
					hora_d_fec_aux <= hora_d_fec_aux + 1;
				end if;
			end if;		
		end if;
	end if;
end process;

hora_d_ab <= hora_d_ab_aux;
hora_d_fec <= hora_d_fec_aux;

---------------------------------------------------
process (clk)
begin
	if clk'event and clk = '1' then
		if largou_ab_h = '1' and inc_hora = '1' then
			inc_hora_ab_aux <= '1';
			largou_ab_h <= '0';
		end if;
		if largou_ab_h = '0' and inc_hora = '0' then
			largou_ab_h <= '1';
		end if;
	end if;
	if check_ab_h = '1' then
		inc_hora_ab_aux <= '0';
	end if;
end process; 

inc_hora_ab_aux2 <= '1' when inc_hora_ab_aux = '1' else '0';

process (clk)
begin
	if clk'event and clk = '1' then
		if largou_ab_m = '1' and inc_min = '1' then
			inc_min_ab_aux <= '1';
			largou_ab_m <= '0';
		end if;
		if largou_ab_m = '0' and inc_min = '0' then
			largou_ab_m <= '1';
		end if;
	end if;
	if check_ab_m = '1' then
		inc_min_ab_aux <= '0';
	end if;
end process; 
inc_min_ab_aux2 <= '1' when inc_min_ab_aux = '1' else '0';

-------------------------------------------------COMPARADOR-------------------------------
total_minutos <= (c_hor_d * 10 * 60) + (c_hor_u * 60) + (c_min_d * 10) + c_min_u;
total_minutos_ab <= (hora_d_ab_aux * 10 * 60) + (hora_u_ab_aux * 60) + (min_d_ab_aux * 10);
total_minutos_fec <= (hora_d_fec_aux * 10 * 60) + (hora_u_fec_aux * 60) + (min_d_fec_aux * 10);

process (clk)
begin
	if clk'event and clk = '1' then
		if total_minutos < total_minutos_ab then
			entrada_aux <= '0';
			saida_aux <= '0';
		elsif total_minutos > total_minutos_ab then
			if	total_minutos < total_minutos_fec then
				entrada_aux <= '1';
				saida_aux <= '1';
			elsif (total_minutos > total_minutos_fec) and (total_minutos < total_minutos_fec +60) then
				entrada_aux <= '0';
				saida_aux <= '1';	
			else 
				entrada_aux <= '0';
				saida_aux <= '0';
			end if;
		end if;
	end if;
end process;

entrada_ok <= entrada_aux;
saida_ok <= saida_aux;

end Behavioral;