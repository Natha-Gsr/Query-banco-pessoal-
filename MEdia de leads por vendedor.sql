--Média de leads por vendedor
WITH LeadsPorVendedor AS (
    SELECT 
        d.equipe,
        d.vendedor,
        COUNT(b.id_lead) AS total_leads_vendedor
    FROM base_leads b
    INNER JOIN desempenho_vendedores d
        ON b.vendedor = d.vendedor
    GROUP BY d.equipe, d.vendedor
)
SELECT 
    equipe,
    COUNT(vendedor) AS qtd_vendedores,
    SUM(total_leads_vendedor) AS total_leads_equipe,
    ROUND(AVG(total_leads_vendedor), 1) AS media_leads_por_vendedor
FROM LeadsPorVendedor
GROUP BY equipe;



--Taxa de conversão
WITH Conver AS (
SELECT
vendedor,
COUNT(*) AS 'contagem_de_vendas'
FROM base_leads
WHERE status_venda = 'Fechado'
GROUP BY vendedor

),
C2 AS( 
    SELECT
  d.equipe AS 'Eqp',
  d.vendedor AS 'Vendedo',
  COUNT(b.id_lead) AS total_leads_vendedor
    FROM base_leads b
    INNER JOIN desempenho_vendedores d
        ON b.vendedor = d.vendedor
    GROUP BY d.equipe, d.vendedor
)
SELECT 
ROUND(CAST(contagem_de_vendas AS float) /CAST(total_leads_vendedor AS float ),2) AS 'Conversão',
Vendedo,
Eqp
FROM C2
LEFT JOIN Conver
ON Conver.vendedor = C2.Vendedo



--CONVERSÃO


WITH Conver AS (
   
    SELECT 
        vendedor,
        COUNT(*) AS contagem_de_vendas
    FROM base_leads
    WHERE status_venda = 'Fechado'
    GROUP BY vendedor
),
C2 AS (

    SELECT 
        d.equipe AS Eqp,
        d.vendedor AS Vendedo,
        COUNT(b.id_lead) AS total_leads_vendedor
    FROM base_leads b
    INNER JOIN desempenho_vendedores d
        ON b.vendedor = d.vendedor
    GROUP BY d.equipe, d.vendedor
)

SELECT 
    C2.Eqp,
    C2.Vendedo AS Vendedor,
    C2.total_leads_vendedor AS Total_Leads,
    ISNULL(Conver.contagem_de_vendas, 0) AS Total_Vendas,
    ROUND(
        (CAST(ISNULL(Conver.contagem_de_vendas, 0) AS FLOAT) / 
         CAST(C2.total_leads_vendedor AS FLOAT)) * 100, 
    2) AS [Conversão (%)]
FROM C2
LEFT JOIN Conver
    ON Conver.vendedor = C2.Vendedo
ORDER BY [Conversão (%)] DESC;