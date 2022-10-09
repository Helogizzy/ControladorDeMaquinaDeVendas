-- ghdl -a *.vhdl ; ghdl -e me_tb ; ghdl -r me_tb --vcd=tb.vcd --stop-time=400ns ; gtkwave tb.vcd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity me_tb is
end entity;

architecture search4coffe of me_tb is
    constant cicloClock : time := 20 ns;

    component me is
    port(
        rst, clk                        : in std_logic;
        m100, m50, botao                : in std_logic;
        troco, cofre, bloqueio, comida  : out std_logic
    );
    end component;

    -- sinais controle
    signal srst : std_logic := '1';
    signal sclk : std_logic := '0';

    -- sinal de observacao
    signal m100, m50, botao : std_logic := '0';
    signal troco, cofre, bloqueio, comida : std_logic := '0';

    -- Estimulo
    signal sstring : std_logic_vector(2 downto 0):="000";

begin
    sclk <= not(sclk) after cicloClock / 2;

    -- A Maquina de Estado:
    u_me : me port map(srst, sclk, m100, m50, botao, troco, cofre, bloqueio, comida);

    tb : process
    begin
        -- reset inicial
        srst <= '0';
        wait for cicloClock;
        srst <= '1';

        -- 150 (50 + 100)
        m50 <= '1';
        m100 <= '0';
        botao <= '0';  
        wait for cicloClock;
        m50 <= '0';
        m100 <= '1'; 
        botao <= '0';
        wait for cicloClock;
        m100 <= '0';
        botao <= '1';
        wait for cicloClock;
        botao <= '0';
        wait for cicloClock;

        -- 150 (100 + 50)
        m100 <= '1'; 
        wait for cicloClock; 
        m100 <= '0'; 
        m50 <= '1'; 
        wait for cicloClock;
        m50 <= '0'; 
        botao <=  '1'; 
        wait for cicloClock;
        botao <=  '0'; 
        wait for cicloClock;

        -- 200 (100 + 100)
        m100 <= '1'; 
        wait for cicloClock; 
        m100 <= '0'; 
        m100 <= '1'; 
        wait for cicloClock;
        m100 <= '0'; 
        botao <=  '1'; 
        wait for cicloClock;
        botao <=  '0'; 
        wait for cicloClock;
        
        -- 200 (50 + 50 + 100)
        m50 <= '1'; 
        wait for cicloClock; 
        m50 <= '0'; 
        m50 <= '1'; 
        wait for cicloClock;
        m50 <= '0'; 
        m100 <= '1'; 
        wait for cicloClock;
        m100 <= '0'; 
        botao <=  '1'; 
        wait for cicloClock;
        botao <=  '0'; 
        wait for cicloClock;

        wait; 
    end process;
end architecture;
