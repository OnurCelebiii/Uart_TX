----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.08.2022 07:42:03
-- Design Name: 
-- Module Name: top_uart_tx_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.NUMERIC_STD.ALL;


entity top_uart_tx_tb is
end top_uart_tx_tb;

architecture Behavioral of top_uart_tx_tb is

component top_uart_tx is 

    Port (top_i_rst               :    in       std_logic                         ;
          top_i_start_byte        :    in       std_logic                         ;
          top_o_tx                :    out      std_logic                         ;
          top_clk_in1_p           :    in       std_logic                         ;
          top_clk_in1_n           :    in       std_logic)                        ;
          
             
end component ;                                                                    

signal tb_top_i_clk                  :              std_logic          := '0'                     ;
signal tb_top_i_tx_data              :              std_logic_vector (7 downto 0) := "01000101"   ;
signal tb_top_i_rst                  :              std_logic          := '0'                     ;
signal tb_top_i_start_byte           :              std_logic          := '1'                     ;
signal tb_top_o_tx                   :              std_logic          := '0'                     ;
signal tb_top_clk_out1               :              std_logic          := '0'                     ;
signal tb_top_clk_in1_p              :              std_logic          := '0'                     ;
signal tb_top_clk_in1_n              :              std_logic          := '0'                     ;

begin

DUT  :  top_uart_tx  port map (

top_i_rst                       =>                tb_top_i_rst              ,
top_i_start_byte                =>                tb_top_i_start_byte       ,
top_o_tx                        =>                tb_top_o_tx               ,
top_clk_in1_p                   =>                tb_top_clk_in1_p          ,
top_clk_in1_n                   =>                tb_top_clk_in1_n)         ;

process begin


    for a in 0 to 1 loop 

        tb_top_clk_in1_p <= not tb_top_clk_in1_p ;
        wait for 40 ns;
        tb_top_clk_in1_n <= not tb_top_clk_in1_n ;
        wait for 40 ns;

    end loop;

end process;


end Behavioral;