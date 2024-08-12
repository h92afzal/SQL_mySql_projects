SELECT E.ID, 
    E.firstname, 
    E.lastname, 
    E.country, 
    T.rank
FROM Employee E
  INNER JOIN
(
 SELECT *, 
        RANK() OVER(PARTITION BY firstname, 
                                 lastname, 
                                 country
        ORDER BY id) rank
 FROM Employee
) T ON E.ID = t.ID;


DELETE E
    FROM Employee E
         INNER JOIN
    (
        SELECT *, 
               RANK() OVER(PARTITION BY firstname, 
                                        lastname, 
                                        country
               ORDER BY id) rank
        FROM Employee
    ) T ON E.ID = t.ID
    WHERE rank > 1;