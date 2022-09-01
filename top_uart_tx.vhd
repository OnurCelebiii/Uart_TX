----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- Create Date: 22.08.2022 14:29:14
-- Design Name: Uart TX Top Module with clk_wizard 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_uart_tx is 

    Port (top_i_rst               :    in       std_logic                         ;
          top_i_start_byte        :    in       std_logic                         ;
          top_o_tx                :    out      std_logic                         ;
          --s_top_i_tx_data                   :     in  std_logic_vector(7 downto 0)               ;
          top_clk_in1_p           :    in       std_logic                         ;
          top_clk_in1_n           :    in       std_logic)                        ;


end top_uart_tx;

architecture Behavioral of top_uart_tx is

signal s_clk_wiz_out                     :       std_logic                                       ;
signal s_top_i_tx_data                   :       std_logic_vector(7 downto 0);

component uart_tx is    

    Port (i_clk                 :        in      std_logic                       ;
          i_tx_data             :        in      std_logic_vector (7 downto 0)   ;
          i_rst                 :        in      std_logic                       ;
          i_start_byte          :        in      std_logic                       ;
          o_tx                  :        out     std_logic)                      ;

end component;    

component clk_wiz_0

    port
     (clk_out1          :           out    std_logic       ;
      clk_in1_p         :           in     std_logic       ;
      clk_in1_n         :           in     std_logic)      ;

end component;
------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT vio_0
  PORT (
    clk : IN STD_LOGIC;
    probe_out0 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG

begin
your_instance_name : vio_0
  PORT MAP (
    clk => s_clk_wiz_out,
    probe_out0 => s_top_i_tx_data
  );

tx : uart_tx port map (

i_clk            =>     s_clk_wiz_out         ,
i_tx_data        =>     s_top_i_tx_data       ,
i_rst            =>     top_i_rst             ,
i_start_byte     =>     top_i_start_byte      ,
o_tx             =>     top_o_tx)             ;


clk_wizard : clk_wiz_0 port map ( 

   clk_out1       =>   s_clk_wiz_out        ,
   clk_in1_p      =>   top_clk_in1_p        ,
   clk_in1_n      =>   top_clk_in1_n)       ;




end Behavioral;