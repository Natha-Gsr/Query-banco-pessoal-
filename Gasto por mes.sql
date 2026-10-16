-- Gasto total por mês, do mais antigo ao mais recente.
 SELECT 
 SUM (ValorTotal) AS 'Valor total gasto',
 FORMAT( DataCompra, 'MM/yyyy') AS 'Por Mês'
  FROM Compras
  WHERE YEAR(DataCompra) = 2026
 GROUP BY  FORMAT( DataCompra, 'MM/yyyy')
 ORDER BY FORMAT( DataCompra, 'MM/yyyy')  ASC


 SELECT 
 SUM (ValorTotal) AS 'Valor total gasto',
 FORMAT( DataCompra, 'MM/yyyy') AS 'Por Mês'
  FROM Compras
  WHERE YEAR(DataCompra) = 2025
 GROUP BY  FORMAT( DataCompra, 'MM/yyyy')
 ORDER BY FORMAT( DataCompra, 'MM/yyyy')  ASC

 