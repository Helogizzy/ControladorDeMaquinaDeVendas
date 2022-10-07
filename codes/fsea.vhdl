-- Fun��o de Sa�da do Estado Atual --

library ieee;
use ieee.std_logic_1164.all;

entity fsea is
    port(
        ea : in std_logic_vector (2 downto 0);
        troco, cofre, bloqueio, comida : out std_logic
    );
end entity;

architecture calc of fsea is
    
begin
    --(EA2.EA1)
    troco <= ea(2) and ea(1);

    --EA2 + (EA1.EA0)
    cofre <= ea(2) or (ea(1) and ea(0));

    --EA2 + (EA1.EA0)
    bloqueio <= ea(2) or (ea(1) and ea(0));
    
    --EA2 . (EA1 + EA0)
    comida <= ea(2) and (ea(1) or ea(0));
end architecture;