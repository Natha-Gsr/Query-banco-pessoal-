--Custos
--Média das categorias que compraram acima da média geral
 WITH VendasPorCategoria AS (
    SELECT 
        SUM(ValorTotal) AS valor_total,
        NomeCategoria AS [Nome das categorias]
    FROM Compras
    INNER JOIN Produtos
        ON Compras.ProdutoKey = Produtos.ProdutoKey
    INNER JOIN Categorias
        ON Produtos.CategoriaKey = Categorias.CategoriaKey
    WHERE DataCompra >= DATEADD(MONTH, -6, GETDATE()) 
      AND StatusCompra = 'Entregue'
    GROUP BY NomeCategoria
),
MediaGeral AS (
    SELECT AVG(valor_total) AS media_total_geral FROM VendasPorCategoria
)

SELECT 
    v.[Nome das categorias],
    v.valor_total,
    m.media_total_geral
FROM VendasPorCategoria v
CROSS JOIN MediaGeral m
WHERE v.valor_total > m.media_total_geral
ORDER BY v.valor_total DESC;