--uart tx module--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_tx is

    Port (i_clk         :        in std_logic                           ;
          i_tx_data     :        in std_logic_vector (7 downto 0)       ;
          i_rst         :        in std_logic                           ;
          i_start_byte  :        in std_logic                           ;
          o_tx_reg      :        out std_logic_vector (7 downto 0)      ;
          o_tx          :        out std_logic)                         ;
          
end uart_tx;

architecture Behavioral of uart_tx is

signal clk_counter      :       integer range 0 to 105                  ;
signal d_clk            :       std_logic := '0'                        ;
signal control          :       integer   := 104                        ;
signal clk_divider      :       integer range 0 to 3                    ;
signal s_i_tx_data      :       std_logic_vector (7 downto 0)           ;  
signal s_i_start_byte   :       std_logic                               ;
signal s_o_tx           :       std_logic:='0'                          ;
type state is (idle, start, data, stop)                                 ;
signal uart_txx         :       state                                   ;
signal i                :       integer :=  0                           ;
signal s_o_tx_reg       :       std_logic_vector (7 downto 0)           ;


begin

process (i_clk) begin

    if rising_edge(i_clk) then
        if clk_divider = 3 then 

            d_clk           <=      not d_clk        ;
            clk_divider     <=      0                ;

        else 

            clk_divider     <=      clk_divider + 1  ;

        end if;
    
    end if;

end process;


process (d_clk, i_rst, i_tx_data, i_start_byte, s_o_tx) begin

      

if rising_edge(d_clk) then 
    o_tx                    <=          s_o_tx                  ;                
    s_i_tx_data             <=          i_tx_data               ;      
    s_i_start_byte          <=          i_start_byte            ;
    o_tx_reg                <=          s_o_tx_reg              ;
    
    if i_rst = '1' then

        clk_counter         <=          0                       ;
        o_tx                <=          '0'                     ;
        s_i_start_byte      <=          '1'                     ;
        i                   <=          0                       ;
        uart_txx            <=          idle                    ;
        s_o_tx              <=          '0'                     ;
        
    else 

        case uart_txx is 

                when idle =>    if  s_i_start_byte      =      '1'              then 

                                    uart_txx            <=      start               ;
                                    clk_counter         <=      0                   ;
                                    s_o_tx              <=      '0'                 ;

                                else
                                    
                                    s_o_tx              <=      '1'                 ;
                                    uart_txx            <=      idle                ;

                                end if; 


                when start =>   if  clk_counter         >=      control  then

                                    s_o_tx              <=     '0'                   ;
                                    clk_counter         <=      0                    ;
                                    uart_txx            <=      data                 ;
                                    s_i_start_byte      <=      '0'                  ;
 
                                else

                                    clk_counter         <=      clk_counter + 1     ;
                                    s_o_tx              <=      '1'                 ;

                                end if; 


                when data =>    if  clk_counter      >=      control    then 

                                    if i             <       7           then

                                       i             <=      i   +   1              ;
                                       clk_counter   <=      0                      ;
                                       s_o_tx        <=      '0'                    ;

                                    else

                                        i            <=      0                      ;
                                        uart_txx     <=      stop                   ;
                                        clk_counter  <=      0                      ;

                                    end if;

                                else

                                    s_o_tx           <=      s_i_tx_data(i)         ;
                                    s_o_tx_reg (i)   <=      s_o_tx                 ;
                                    clk_counter      <=      clk_counter +1         ;

                                end if;


                when stop =>    if clk_counter       >=      control then 

                                    s_o_tx           <=      '1'                    ;
                                    clk_counter      <=      0                      ;
                                    uart_txx         <=      idle                   ;
                                    s_i_start_byte   <=      '0'                    ;

                                else

                                    clk_counter      <=      clk_counter + 1        ;
                                    s_i_start_byte   <=      '0'                    ;
                                    s_o_tx           <=      '1'                    ;

                                end if;


                when others =>

       end case;
    end if;
end if;

end process;

end Behavioral;
