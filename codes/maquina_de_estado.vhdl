library ieee;
use ieee.std_logic_1164.all;

entity me is
    port(
        rst, clk : in std_logic;
        m100, m50, botao: in std_logic;
        troco, cofre, bloqueio, comida : out std_logic
    );
end entity;

architecture doit of me is
    -- Fun��o de Pr�ximo Estado
    component fpe is
        port(
            ea  : in  std_logic_vector(2 downto 0); -- Estado atual
            m100, m50, botao : in  std_logic;       -- Moedas e botão (1 real / 50 centavos)
            pe  : out std_logic_vector(2 downto 0)  -- Próximo estado
            );
    end component;

    -- Banco de Registradores
    component bancoReg3b is
        port(
            din : in std_logic_vector(2 downto 0);
            cl, clk : in std_logic;
            dout : out std_logic_vector(2 downto 0)
        );
    end component;

    -- Fun��o de Sa�da do Estado Atual
    component fsea is
        port(
            ea : in std_logic_vector (2 downto 0);
            troco, cofre, bloqueio, comida : out std_logic
        );
    end component;

    -- Sinais internos
        signal spe_reg, sreg_ea: std_logic_vector(2 downto 0);

        --signal sm100, sm50, sbotao, scofre, sbloqueio, scomida: std_logic;
        
    -- helper
    signal ea, pe : string(1 to 2);

begin

    -- f(ea)
    u_fpe : fpe port map(sreg_ea, m100, m50, botao, spe_reg);

    -- registradores
    u_reg : bancoReg3b port map(spe_reg, rst, clk, sreg_ea);

    -- s(ea)
    u_sea : fsea port map (sreg_ea, troco, cofre, bloqueio, comida);

    --helper
    ea <= "e0" when sreg_ea="000" else
          "e1" when sreg_ea="001" else
          "e2" when sreg_ea="010" else
          "e3" when sreg_ea="011" else
          "e4" when sreg_ea="100" else
          "e5" when sreg_ea="101" else
          "e6" when sreg_ea="110" else
          "e7" when sreg_ea="111" else "ZZ";

    pe <= "e0" when sreg_ea="000" else
          "e1" when sreg_ea="001" else
          "e2" when sreg_ea="010" else
          "e3" when sreg_ea="011" else
          "e4" when sreg_ea="100" else
          "e5" when sreg_ea="101" else
          "e6" when sreg_ea="110" else
          "e7" when sreg_ea="111" else "ZZ";
end architecture;