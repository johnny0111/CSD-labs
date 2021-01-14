
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity topmodule is
   port ( b_1          : in    std_logic; 
          b_2          : in    std_logic; 
          b_3          : in    std_logic; 
          clk          : in    std_logic; 
          reset        : in    std_logic; 
          sw           : in    std_logic_vector (7 downto 0); 
          algarismo    : out   std_logic_vector (7 downto 0); 
          an0          : out   std_logic; 
          an1          : out   std_logic; 
          an2          : out   std_logic; 
          an3          : out   std_logic; 
          canc_in_1    : out   std_logic; 
          canc_in_2    : out   std_logic; 
          canc_out_1   : out   std_logic; 
          canc_out_2   : out   std_logic; 
          entrada_ok   : out   std_logic; 
          parque_cheio : out   std_logic; 
          perigo       : out   std_logic; 
          saida_ok     : out   std_logic);
end topmodule;

architecture BEHAVIORAL of topmodule is
   attribute BOX_TYPE   : string ;
   signal XLXN_31          : std_logic_vector (0 to 3);
   signal XLXN_32          : std_logic_vector (0 to 2);
   signal XLXN_33          : std_logic_vector (0 to 3);
   signal XLXN_34          : std_logic_vector (0 to 1);
   signal XLXN_569         : std_logic;
   signal XLXN_892         : std_logic;
   signal XLXN_894         : std_logic;
   signal XLXN_896         : std_logic;
   signal XLXN_908         : std_logic;
   signal XLXN_913         : std_logic;
   signal XLXN_915         : std_logic;
   signal XLXN_920         : std_logic;
   signal XLXN_921         : std_logic;
   signal XLXN_927         : std_logic;
   signal XLXN_928         : std_logic;
   signal XLXN_929         : std_logic;
   signal XLXN_930         : std_logic;
   signal XLXN_940         : std_logic;
   signal XLXN_942         : std_logic;
   signal XLXN_944         : std_logic;
   signal XLXN_946         : std_logic;
   signal XLXN_947         : std_logic;
   signal XLXN_950         : std_logic;
   signal XLXN_952         : std_logic;
   signal XLXN_954         : std_logic;
   signal XLXN_955         : std_logic;
   signal XLXN_956         : std_logic;
   signal XLXN_957         : std_logic;
   signal XLXN_958         : std_logic;
   signal XLXN_959         : std_logic_vector (0 to 1);
   signal XLXN_961         : std_logic_vector (0 to 3);
   signal XLXN_962         : std_logic_vector (0 to 2);
   signal XLXN_963         : std_logic_vector (0 to 3);
   signal XLXN_974         : std_logic;
   signal XLXN_975         : std_logic;
   signal XLXN_976         : std_logic;
   signal XLXN_977         : std_logic;
   signal XLXN_978         : std_logic_vector (0 to 3);
   signal XLXN_979         : std_logic_vector (0 to 2);
   signal XLXN_980         : std_logic_vector (0 to 3);
   signal XLXN_981         : std_logic_vector (0 to 1);
   signal XLXN_982         : std_logic_vector (0 to 3);
   signal XLXN_984         : std_logic_vector (0 to 2);
   signal XLXN_986         : std_logic_vector (0 to 3);
   signal XLXN_988         : std_logic_vector (0 to 1);
   signal XLXN_990         : std_logic_vector (0 to 3);
   signal XLXN_991         : std_logic_vector (0 to 3);
   signal XLXN_993         : std_logic_vector (0 to 3);
   signal XLXN_995         : std_logic_vector (0 to 3);
   signal entrada_ok_DUMMY : std_logic;
   signal saida_ok_DUMMY   : std_logic;
   component relogio
      port ( clk      : in    std_logic; 
             reset    : in    std_logic; 
             acertar  : in    std_logic; 
             inc_hora : in    std_logic; 
             inc_min  : in    std_logic; 
             c_seg_u  : out   std_logic_vector (0 to 3); 
             c_seg_d  : out   std_logic_vector (0 to 2); 
             c_min_u  : out   std_logic_vector (0 to 3); 
             c_min_d  : out   std_logic_vector (0 to 2); 
             c_hor_u  : out   std_logic_vector (0 to 3); 
             c_hor_d  : out   std_logic_vector (0 to 1));
   end component;
   
   component conv_displays_2
      port ( clk       : in    std_logic; 
             reset     : in    std_logic; 
             c_min_u   : in    std_logic_vector (0 to 3); 
             c_min_d   : in    std_logic_vector (0 to 2); 
             c_hor_u   : in    std_logic_vector (0 to 3); 
             c_hor_d   : in    std_logic_vector (0 to 1); 
             an3       : out   std_logic; 
             an2       : out   std_logic; 
             an1       : out   std_logic; 
             an0       : out   std_logic; 
             algarismo : out   std_logic_vector (7 downto 0));
   end component;
   
   component control_hor_fech_entrada
      port ( clk          : in    std_logic; 
             reset        : in    std_logic; 
             modo_alt_ab  : in    std_logic; 
             modo_alt_fec : in    std_logic; 
             inc_min      : in    std_logic; 
             inc_hora     : in    std_logic; 
             c_min_u      : in    std_logic_vector (0 to 3); 
             c_min_d      : in    std_logic_vector (0 to 2); 
             c_hor_u      : in    std_logic_vector (0 to 3); 
             c_hor_d      : in    std_logic_vector (0 to 1); 
             entrada_ok   : out   std_logic; 
             saida_ok     : out   std_logic; 
             min_u_ab     : out   std_logic_vector (0 to 3); 
             min_d_ab     : out   std_logic_vector (0 to 2); 
             hora_u_ab    : out   std_logic_vector (0 to 3); 
             hora_d_ab    : out   std_logic_vector (0 to 1); 
             min_u_fec    : out   std_logic_vector (0 to 3); 
             min_d_fec    : out   std_logic_vector (0 to 2); 
             hora_u_fec   : out   std_logic_vector (0 to 3); 
             hora_d_fec   : out   std_logic_vector (0 to 1));
   end component;
   
   component VCC
      port ( P : out   std_logic);
   end component;
   attribute BOX_TYPE of VCC : component is "BLACK_BOX";
   
   component debouncer_2
      port ( clk   : in    std_logic; 
             reset : in    std_logic; 
             b_1   : in    std_logic; 
             b_2   : in    std_logic; 
             b_3   : in    std_logic; 
             b1_db : out   std_logic; 
             b2_db : out   std_logic; 
             b3_db : out   std_logic);
   end component;
   
   component controlo_input_2
      port ( clk          : in    std_logic; 
             b_1          : in    std_logic; 
             b_2          : in    std_logic; 
             b_3          : in    std_logic; 
             sw           : in    std_logic_vector (7 downto 0); 
             acertar      : out   std_logic; 
             alt_ab       : out   std_logic; 
             alt_fec      : out   std_logic; 
             inc_h        : out   std_logic; 
             inc_m        : out   std_logic; 
             PRES1_IN_1   : out   std_logic; 
             TICKET_IN_1  : out   std_logic; 
             PRES2_IN_1   : out   std_logic; 
             PRES1_OUT_1  : out   std_logic; 
             PRES2_OUT_1  : out   std_logic; 
             TICKET_OUT_1 : out   std_logic; 
             PRES1_IN_2   : out   std_logic; 
             PRES2_IN_2   : out   std_logic; 
             TICKET_IN_2  : out   std_logic; 
             PRES1_OUT_2  : out   std_logic; 
             PRES2_OUT_2  : out   std_logic; 
             TICKET_OUT_2 : out   std_logic; 
             AND_12A      : out   std_logic; 
             AND_12B      : out   std_logic; 
             AND_21A      : out   std_logic; 
             AND_21B      : out   std_logic; 
             invalid      : out   std_logic; 
             piso_1       : out   std_logic; 
             piso_2       : out   std_logic; 
             vazios       : out   std_logic; 
             preenchidos  : out   std_logic);
   end component;
   
   component display_selector_3
      port ( clk           : in    std_logic; 
             hora_abertura : in    std_logic; 
             hora_fecho    : in    std_logic; 
             vazios        : in    std_logic; 
             preenchidos   : in    std_logic; 
             piso_1        : in    std_logic; 
             piso_2        : in    std_logic; 
             min_u         : in    std_logic_vector (0 to 3); 
             min_d         : in    std_logic_vector (0 to 2); 
             hor_u         : in    std_logic_vector (0 to 3); 
             hor_d         : in    std_logic_vector (0 to 1); 
             min_u_ab      : in    std_logic_vector (0 to 3); 
             min_d_ab      : in    std_logic_vector (0 to 2); 
             hor_u_ab      : in    std_logic_vector (0 to 3); 
             hor_d_ab      : in    std_logic_vector (0 to 1); 
             min_u_fec     : in    std_logic_vector (0 to 3); 
             min_d_fec     : in    std_logic_vector (0 to 2); 
             hor_u_fec     : in    std_logic_vector (0 to 3); 
             hor_d_fec     : in    std_logic_vector (0 to 1); 
             n_vazios      : in    std_logic_vector (0 to 3); 
             n_preenchidos : in    std_logic_vector (0 to 3); 
             n_piso_1      : in    std_logic_vector (0 to 3); 
             n_piso_2      : in    std_logic_vector (0 to 3); 
             OUT_3         : out   std_logic_vector (0 to 3); 
             OUT_2         : out   std_logic_vector (0 to 2); 
             OUT_1         : out   std_logic_vector (0 to 3); 
             OUT_0         : out   std_logic_vector (0 to 1));
   end component;
   
   component Controller_final
      port ( Clk                 : in    std_logic; 
             PRES1_IN_1          : in    std_logic; 
             TICKET_IN_1         : in    std_logic; 
             PRES2_IN_1          : in    std_logic; 
             PRES1_OUT_1         : in    std_logic; 
             PRES2_OUT_1         : in    std_logic; 
             TICKET_OUT_1        : in    std_logic; 
             hora_entrada_OK     : in    std_logic; 
             hora_saida_OK       : in    std_logic; 
             PRES1_IN_2          : in    std_logic; 
             PRES2_IN_2          : in    std_logic; 
             TICKET_IN_2         : in    std_logic; 
             PRES1_OUT_2         : in    std_logic; 
             PRES2_OUT_2         : in    std_logic; 
             TICKET_OUT_2        : in    std_logic; 
             AND_12a             : in    std_logic; 
             AND_12b             : in    std_logic; 
             AND_21a             : in    std_logic; 
             AND_21b             : in    std_logic; 
             Enable              : in    std_logic; 
             Reset               : in    std_logic; 
             CANC_IN_1           : out   std_logic; 
             CANC_OUT_1          : out   std_logic; 
             CANC_IN_2           : out   std_logic; 
             CANC_OUT_2          : out   std_logic; 
             PERIGO              : out   std_logic; 
             parque_cheio        : out   std_logic; 
             rampa1_ocupada      : out   std_logic; 
             rampa2_ocupada      : out   std_logic; 
             lugares_livres      : out   std_logic_vector (0 to 3); 
             lugares_preenchidos : out   std_logic_vector (0 to 3); 
             piso1               : out   std_logic_vector (0 to 3); 
             piso2               : out   std_logic_vector (0 to 3));
   end component;
   
begin
   entrada_ok <= entrada_ok_DUMMY;
   saida_ok <= saida_ok_DUMMY;
   XLXI_1 : relogio
      port map (acertar=>XLXN_908,
                clk=>clk,
                inc_hora=>XLXN_920,
                inc_min=>XLXN_921,
                reset=>reset,
                c_hor_d(0 to 1)=>XLXN_34(0 to 1),
                c_hor_u(0 to 3)=>XLXN_33(0 to 3),
                c_min_d(0 to 2)=>XLXN_32(0 to 2),
                c_min_u(0 to 3)=>XLXN_31(0 to 3),
                c_seg_d=>open,
                c_seg_u=>open);
   
   XLXI_8 : conv_displays_2
      port map (clk=>clk,
                c_hor_d(0 to 1)=>XLXN_959(0 to 1),
                c_hor_u(0 to 3)=>XLXN_961(0 to 3),
                c_min_d(0 to 2)=>XLXN_962(0 to 2),
                c_min_u(0 to 3)=>XLXN_963(0 to 3),
                reset=>reset,
                algarismo(7 downto 0)=>algarismo(7 downto 0),
                an0=>an0,
                an1=>an1,
                an2=>an2,
                an3=>an3);
   
   XLXI_31 : control_hor_fech_entrada
      port map (clk=>clk,
                c_hor_d(0 to 1)=>XLXN_34(0 to 1),
                c_hor_u(0 to 3)=>XLXN_33(0 to 3),
                c_min_d(0 to 2)=>XLXN_32(0 to 2),
                c_min_u(0 to 3)=>XLXN_31(0 to 3),
                inc_hora=>XLXN_920,
                inc_min=>XLXN_921,
                modo_alt_ab=>XLXN_913,
                modo_alt_fec=>XLXN_915,
                reset=>reset,
                entrada_ok=>entrada_ok_DUMMY,
                hora_d_ab(0 to 1)=>XLXN_981(0 to 1),
                hora_d_fec(0 to 1)=>XLXN_988(0 to 1),
                hora_u_ab(0 to 3)=>XLXN_980(0 to 3),
                hora_u_fec(0 to 3)=>XLXN_986(0 to 3),
                min_d_ab(0 to 2)=>XLXN_979(0 to 2),
                min_d_fec(0 to 2)=>XLXN_984(0 to 2),
                min_u_ab(0 to 3)=>XLXN_978(0 to 3),
                min_u_fec(0 to 3)=>XLXN_982(0 to 3),
                saida_ok=>saida_ok_DUMMY);
   
   XLXI_58 : VCC
      port map (P=>XLXN_569);
   
   XLXI_92 : debouncer_2
      port map (b_1=>b_1,
                b_2=>b_2,
                b_3=>b_3,
                clk=>clk,
                reset=>reset,
                b1_db=>XLXN_892,
                b2_db=>XLXN_894,
                b3_db=>XLXN_896);
   
   XLXI_94 : controlo_input_2
      port map (b_1=>XLXN_892,
                b_2=>XLXN_894,
                b_3=>XLXN_896,
                clk=>clk,
                sw(7 downto 0)=>sw(7 downto 0),
                acertar=>XLXN_908,
                alt_ab=>XLXN_913,
                alt_fec=>XLXN_915,
                AND_12A=>XLXN_955,
                AND_12B=>XLXN_956,
                AND_21A=>XLXN_957,
                AND_21B=>XLXN_958,
                inc_h=>XLXN_920,
                inc_m=>XLXN_921,
                invalid=>open,
                piso_1=>XLXN_976,
                piso_2=>XLXN_977,
                preenchidos=>XLXN_975,
                PRES1_IN_1=>XLXN_927,
                PRES1_IN_2=>XLXN_944,
                PRES1_OUT_1=>XLXN_930,
                PRES1_OUT_2=>XLXN_950,
                PRES2_IN_1=>XLXN_929,
                PRES2_IN_2=>XLXN_946,
                PRES2_OUT_1=>XLXN_940,
                PRES2_OUT_2=>XLXN_952,
                TICKET_IN_1=>XLXN_928,
                TICKET_IN_2=>XLXN_947,
                TICKET_OUT_1=>XLXN_942,
                TICKET_OUT_2=>XLXN_954,
                vazios=>XLXN_974);
   
   XLXI_97 : display_selector_3
      port map (clk=>clk,
                hora_abertura=>XLXN_913,
                hora_fecho=>XLXN_915,
                hor_d(0 to 1)=>XLXN_34(0 to 1),
                hor_d_ab(0 to 1)=>XLXN_981(0 to 1),
                hor_d_fec(0 to 1)=>XLXN_988(0 to 1),
                hor_u(0 to 3)=>XLXN_33(0 to 3),
                hor_u_ab(0 to 3)=>XLXN_980(0 to 3),
                hor_u_fec(0 to 3)=>XLXN_986(0 to 3),
                min_d(0 to 2)=>XLXN_32(0 to 2),
                min_d_ab(0 to 2)=>XLXN_979(0 to 2),
                min_d_fec(0 to 2)=>XLXN_984(0 to 2),
                min_u(0 to 3)=>XLXN_31(0 to 3),
                min_u_ab(0 to 3)=>XLXN_978(0 to 3),
                min_u_fec(0 to 3)=>XLXN_982(0 to 3),
                n_piso_1(0 to 3)=>XLXN_991(0 to 3),
                n_piso_2(0 to 3)=>XLXN_990(0 to 3),
                n_preenchidos(0 to 3)=>XLXN_993(0 to 3),
                n_vazios(0 to 3)=>XLXN_995(0 to 3),
                piso_1=>XLXN_976,
                piso_2=>XLXN_977,
                preenchidos=>XLXN_975,
                vazios=>XLXN_974,
                OUT_0(0 to 1)=>XLXN_959(0 to 1),
                OUT_1(0 to 3)=>XLXN_961(0 to 3),
                OUT_2(0 to 2)=>XLXN_962(0 to 2),
                OUT_3(0 to 3)=>XLXN_963(0 to 3));
   
   XLXI_98 : Controller_final
      port map (AND_12a=>XLXN_955,
                AND_12b=>XLXN_956,
                AND_21a=>XLXN_957,
                AND_21b=>XLXN_958,
                Clk=>clk,
                Enable=>XLXN_569,
                hora_entrada_OK=>entrada_ok_DUMMY,
                hora_saida_OK=>saida_ok_DUMMY,
                PRES1_IN_1=>XLXN_927,
                PRES1_IN_2=>XLXN_944,
                PRES1_OUT_1=>XLXN_930,
                PRES1_OUT_2=>XLXN_950,
                PRES2_IN_1=>XLXN_929,
                PRES2_IN_2=>XLXN_946,
                PRES2_OUT_1=>XLXN_940,
                PRES2_OUT_2=>XLXN_952,
                Reset=>reset,
                TICKET_IN_1=>XLXN_928,
                TICKET_IN_2=>XLXN_947,
                TICKET_OUT_1=>XLXN_942,
                TICKET_OUT_2=>XLXN_954,
                CANC_IN_1=>canc_in_1,
                CANC_IN_2=>canc_in_2,
                CANC_OUT_1=>canc_out_1,
                CANC_OUT_2=>canc_out_2,
                lugares_livres(0 to 3)=>XLXN_995(0 to 3),
                lugares_preenchidos(0 to 3)=>XLXN_993(0 to 3),
                parque_cheio=>parque_cheio,
                PERIGO=>perigo,
                piso1(0 to 3)=>XLXN_991(0 to 3),
                piso2(0 to 3)=>XLXN_990(0 to 3),
                rampa1_ocupada=>open,
                rampa2_ocupada=>open);
   
end BEHAVIORAL;


