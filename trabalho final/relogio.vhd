library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity relogio is
     Port ( clk : in std_logic;
            reset : in std_logic;
				acertar : in std_logic;
				inc_hora : in std_logic;
				inc_min : in std_logic;
            c_seg_u : out integer range 0 to 9;
            c_seg_d : out integer range 0 to 5;
            c_min_u : out integer range 0 to 9;
            c_min_d : out integer range 0 to 5;
				c_hor_u : out integer range 0 to 9;
				c_hor_d : out integer range 0 to 2);
 end relogio;

architecture Behavioral of relogio is

signal cont_subseg : integer range 0 to 50000000;
signal cont_seg_u, cont_min_u, cont_hor_u : integer range 0 to 9;
signal cont_seg_d, cont_min_d : integer range 0 to 5;
signal cont_hor_d: integer range 0 to 2;
signal subseg, seg_u, seg_d, min_u, min_d, horas_u,horas_d: std_logic; 
signal inc_min_aux, inc_hora_aux, inc_min_aux2, inc_hora_aux2, check_h, check_h_aux, check_m, check_m_aux : std_logic := '0'; 
signal largou_h, largou_m, largou_h_aux, largou_m_aux : std_logic := '1';

begin

process (clk, reset)
begin
 if reset = '1' then 
   cont_subseg <= 0;
 elsif clk'event and clk = '1' then 
   if cont_subseg = 49999999 then
    cont_subseg <= 0; 
   else cont_subseg <= cont_subseg + 1; 
   end if; 
 end if; 
end process;

seg_u <= '1' when cont_subseg = 49999999 else '0'; 

process (clk, reset)
begin
  if reset = '1' then
    cont_seg_u <= 0; 
  elsif clk'event and clk = '1' then 
    if seg_u = '1' then
     if cont_seg_u = 9 then 
      cont_seg_u <= 0;
		else cont_seg_u <= cont_seg_u + 1;
     end if;
    end if;
   end if;
 end process;

seg_d <= '1' when cont_seg_u = 9 and seg_u = '1' else '0';
c_seg_u <= cont_seg_u; 

process (clk, reset)
begin   
 if reset = '1' then
     cont_seg_d <= 0;
   elsif clk'event and clk = '1' then
     if seg_d = '1' then
       if cont_seg_d = 5 then
         cont_seg_d <= 0;
       else cont_seg_d <= cont_seg_d + 1;
       end if;
     end if;
   end if;
 end process; 

min_u <= '1' when cont_seg_d = 5 and seg_d = '1' else '0';
c_seg_d <= cont_seg_d; 

process (clk, reset)
begin 
  if reset = '1' then
     cont_min_u <= 0;
  elsif clk'event and clk = '1' then
     if min_u = '1' then
       if cont_min_u = 9 then
         cont_min_u <= 0;
       else cont_min_u <= cont_min_u + 1;
       end if;
     end if;
	end if;
 end process;

min_d <= '1' when (cont_min_u = 9 and min_u = '1')  else '0';
c_min_u <= cont_min_u;

process (clk, reset) 
begin
   if reset = '1' then
     cont_min_d <= 0;
   elsif clk'event and clk = '1' then
	  if check_m_aux = '1' then
		check_m_aux <= '0';
	  end if;
     if min_d = '1' or inc_min_aux2 = '1' then
       if cont_min_d = 5 then
         cont_min_d <= 0;
       else 
			cont_min_d <= cont_min_d + 1;
			check_m_aux <= '1';
       end if;
     end if;
   end if;
 end process;
 check_m <= '1' when check_m_aux = '1' else '0';
 horas_u <= '1' when (cont_min_d = 5 and min_d = '1' )  else '0';
 c_min_d <= cont_min_d;
 
process (clk, reset)
begin
	if reset = '1' then
		cont_hor_u <= 0;
	elsif clk'event and clk = '1' then
		if	check_h_aux = '1' then
			check_h_aux <= '0';
		end if;
		if horas_u = '1' or inc_hora_aux2 = '1' then
			if cont_hor_d = 2 and cont_hor_u = 3 then
				cont_hor_u <= 0;
			elsif cont_hor_u = 9 then
				cont_hor_u <= 0;
			else 
				cont_hor_u <= cont_hor_u + 1;
				check_h_aux <= '1';
			end if;
		end if;
	end if;
end process;

horas_d <= '1' when (cont_hor_u = 9 and (horas_u = '1' or inc_hora_aux2 = '1')) or (cont_hor_u = 3 and cont_hor_d = 2 and (horas_u = '1' or inc_hora_aux2 = '1')) else '0';
c_hor_u <= cont_hor_u;
check_h <= '1' when check_h_aux = '1' else '0';


process (clk, reset)
begin
	if reset = '1' then
		cont_hor_d <= 0;
	elsif clk'event and clk = '1' then
		if horas_d = '1' then
			if cont_hor_d = 2 then
				cont_hor_d <= 0;
			else
				cont_hor_d <= cont_hor_d + 1;
			end if;
		end if;
	end if;
end process;


c_hor_d <= cont_hor_d;

process (clk)
begin
	if clk'event and clk = '1' then
		if largou_h = '1' and inc_hora = '1' and acertar = '1' then
			inc_hora_aux <= '1';
			largou_h <= '0';
		end if;
		if largou_h = '0' and inc_hora = '0' then
			largou_h <= '1';
		end if;
	end if;
	if check_h = '1' then
		inc_hora_aux <= '0';
	end if;
end process; 

inc_hora_aux2 <= '1' when inc_hora_aux = '1' else '0';

process (clk)
begin
	if clk'event and clk = '1' then
		if largou_m = '1' and inc_min = '1' and acertar = '1' then
			inc_min_aux <= '1';
			largou_m <= '0';
		end if;
		if largou_m = '0' and inc_min = '0' then
			largou_m <= '1';
		end if;
	end if;
	if check_m = '1' then
		inc_min_aux <= '0';
	end if;
end process; 
inc_min_aux2 <= '1' when inc_min_aux = '1' else '0';

 
 end Behavioral;


