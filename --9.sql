--9
--quais  meses tiveram gastos acima da média

WITH Total AS (
SELECT
SUM(ValorTotal) AS "Valor dos gastos" ,
  YEAR(DataCompra) AS 'Ano',
  MONTH(DataCompra) AS 'Mês'
FROM Compras
GROUP BY YEAR(DataCompra), MONTH(DataCompra)

),

  MEDIAS AS(
  SELECT
 ROUND( AVG(ValorTotal),2)AS "Médias"
  FROM Compras
  )

SELECT 
 Total.Mês,
 Total.Ano,
 [Valor dos gastos],
 Médias
FROM MEDIAS
CROSS JOIN total
WHERE [Valor dos gastos] > (Médias)
