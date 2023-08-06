		SELECT
			SUM(CASE WHEN sub.BlueLineTotal > sub.RedLineTotal THEN 1 ELSE 0 END) AS outcome 
		FROM 
			(SELECT
				soh.CustomerID,
				SUM(CASE WHEN p.Color = 'Blue' THEN sod.LineTotal
					ELSE 0 END) AS BlueLineTotal,
				SUM(CASE WHEN p.Color = 'Red' THEN sod.LineTotal
					ELSE 0 END) AS RedLineTotal
			FROM SalesOrderDetail as sod
				LEFT JOIN bikeshop.SalesOrderHeader as soh ON sod.SalesOrderID = soh.SalesOrderID
				LEFT JOIN bikeshop.Product as p ON sod.ProductID = p.ProductID
			WHERE soh.CustomerID IS NOT NULL
			AND sod.LineTotal IS NOT NULL
			AND p.Color IS NOT NULL
			GROUP BY CustomerID) AS sub