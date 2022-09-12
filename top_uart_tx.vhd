----------------------------------------------------------------------------------
-- Engineer: 
-- Create Date: 09.09.2022 14:21:47
-- Design Name: 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


-------------------------top module in / out port define----------------------
entity top_new is

    Port (top_i_rst               :    in       std_logic                         ;
          top_i_start_byte        :    in       std_logic                         ;
          top_o_tx                :    out      std_logic                         ;
          top_clk                 :    in       std_logic)                        ;
         
end top_new;
------------------------------------------------------------------------------


architecture Behavioral of top_new is


----------------------------------signal assignment---------------------------
signal clk_slow                          :       std_logic                                       ;
signal clk_fast                          :       std_logic                                       ;
signal s_top_i_tx_data                   :       std_logic_vector(7 downto 0)                    ;
signal wea                               :       std_logic                          :='1'        ;
signal ena                               :       std_logic                          :='1'        ;
signal address                           :       std_logic_vector (3 downto 0)     := "1111"     ;
signal top_o_tx_reg                      :       std_logic_vector (7 downto 0)                   ;
signal top_o_tx_reg_block_out            :       std_logic_vector (7 downto 0)                   ;
signal memory_out                        :       std_logic_vector (7 downto 0)                   ;
--signal s_top_o_tx                        :       std_logic                                       ;
------------------------------------------------------------------------------


--------------------------------------uart tx---------------------------------
component uart_tx is

    Port (i_clk             :               in std_logic                            ;
          i_tx_data         :               in std_logic_vector (7 downto 0)        ;
          i_rst             :               in std_logic                            ;
          i_start_byte      :               in std_logic                            ;
          o_tx_reg          :               out std_logic_vector (7 downto 0)       ;
          o_tx              :               out std_logic)                          ;
          
end component;
-------------------------------------------------------------------------------


---------------------------------vio-------------------------------------------
COMPONENT vio_0
  PORT (
    clk                     :               IN STD_LOGIC                            ;
    probe_out0              :               OUT STD_LOGIC_VECTOR(7 DOWNTO 0))       ;
END COMPONENT;
-------------------------------------------------------------------------------


---------------------------------clk wizard------------------------------------
component clk_wiz_1
port
 (-- Clock in ports
  -- Clock out ports
  clk_out1_8MHz             :               out    std_logic                        ;
  clk_out2_40MHz            :               out    std_logic                        ;
  clk_in1                   :               in     std_logic)                       ;
end component;
-------------------------------------------------------------------------------


----------------------------------memory---------------------------------------
COMPONENT blk_mem_gen_0
  PORT (
    clka                    :               IN STD_LOGIC                            ;
    ena                     :               IN STD_LOGIC                            ;
    wea                     :               IN STD_LOGIC_VECTOR(0 DOWNTO 0)         ;
    addra                   :               IN STD_LOGIC_VECTOR(3 DOWNTO 0)         ;
    dina                    :               IN STD_LOGIC_VECTOR(7 DOWNTO 0)         ;
    douta                   :               OUT STD_LOGIC_VECTOR(7 DOWNTO 0))       ;
END COMPONENT;
-------------------------------------------------------------------------------


-----------------------------------ila-----------------------------------------
COMPONENT ila_0
PORT (
	clk                    :                IN STD_LOGIC                            ;
	probe0                 :                IN STD_LOGIC_VECTOR(7 DOWNTO 0))        ;
END COMPONENT  ;
-------------------------------------------------------------------------------


begin


-------------------------------uart tx port map--------------------------------
tx : uart_tx port map (

i_clk                   =>          clk_slow                        ,
i_tx_data               =>          s_top_i_tx_data                 ,
i_rst                   =>          top_i_rst                       ,
i_start_byte            =>          top_i_start_byte                ,
o_tx_reg                =>          top_o_tx_reg                    ,
o_tx                    =>          top_o_tx)                       ;
------------------------------------------------------------------------------


---------------------------------clk wizard port map--------------------------
clk : clk_wiz_1
   port map ( 
  -- Clock out ports  
   clk_out1_8MHz        =>          clk_slow                        ,
   clk_out2_40MHz       =>          clk_fast                        ,
   -- Clock in port
   clk_in1              =>          top_clk)                        ;
-------------------------------------------------------------------------------


-------------------------------vio por map-------------------------------------
VIO : vio_0
  PORT MAP (
    clk                 =>          clk_fast                        ,
    probe_out0          =>          s_top_i_tx_data)                ;
---------------------------------------------------------------------------------


-------------------------------ila port map--------------------------------------
ila : ila_0
PORT MAP (
	clk                 =>          clk_fast                        ,
	probe0              =>          memory_out)                     ;
----------------------------------------------------------------------------------


--------------------------------memory port map-----------------------------------
memory : blk_mem_gen_0
  PORT MAP (
    clka                =>          clk_slow                        ,
    ena                 =>          ena                             ,
    wea(0)              =>          wea                             ,
    addra               =>          address                         ,
    dina                =>          top_o_tx_reg                    ,
    douta               =>          memory_out)                     ;
-----------------------------------------------------------------------------------


end Behavioral;
