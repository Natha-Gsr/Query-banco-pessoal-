-- gasto total com porcentagem de quanto cada setor gastou
WITH gasto AS (
    SELECT 
        Setores.SetorKey,
        Setores.NomeSetor,
        SUM(Compras.ValorTotal) AS 'GastoPorSetor'
    FROM Compras
    INNER JOIN Setores ON Compras.SetorKey = Setores.SetorKey
    GROUP BY Setores.SetorKey, Setores.NomeSetor
),
TotalGeral AS (
    SELECT SUM(GastoPorSetor) AS 'Total' FROM gasto
)
SELECT 
    g.NomeSetor,
    g.GastoPorSetor,
    t.Total,
   
    ROUND((g.GastoPorSetor * 100.0) / t.Total,2) AS 'PorcentagemDoTotal'
FROM gasto g
CROSS JOIN TotalGeral t
ORDER BY g.GastoPorSetor DESC;
