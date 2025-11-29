-- Self-Referencing (Recursive) – Xodim & Boshliq
-- 1. Jadval yaratish
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    manager_id INTEGER REFERENCES employees(id) ON DELETE SET NULL
);

-- 2. 1 ta direktor, 2 ta team lead va 3 ta developer qo'shish
INSERT INTO employees (name, manager_id) VALUES
    ('Aziz', NULL),         -- direktor
    ('Bobur', 1),           -- team lead (Aziz)
    ('Malika', 2),          -- team lead (Bobur)
    ('Dilshod', 3),         -- developer (Malika)
    ('Sardor', 3),          -- developer (Malika)
    ('Gulnoza', 2);         -- developer (Bobur)

-- 3. Har bir xodimning boshlig'ini chiqar
SELECT e.name AS employee, m.name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;

-- 4. Boshlig'i yo'q xodimlarni top (direktor)
SELECT * FROM employees WHERE manager_id IS NULL;

-- 5. Har bir boshliq nechta odam boshqarayotganini hisobla
SELECT m.name AS manager, COUNT(e.id) AS team_size
FROM employees m
LEFT JOIN employees e ON m.id = e.manager_id
GROUP BY m.id;

-- 6. Malikaning jamoasidagi xodimlarni chiqar
SELECT e.name
FROM employees e
WHERE e.manager_id = (SELECT id FROM employees WHERE name = 'Malika');

-- 7. Har bir xodimni boshlig'i bilan birga chiqar (JOIN)
SELECT e.name AS employee, m.name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;

-- 8. Boshliqni o'chirib, ON DELETE SET NULL ishlashini test qil
DELETE FROM employees WHERE name = 'Bobur';
-- SELECT * FROM employees WHERE manager_id IS NULL;

-- 9. Eng katta jamoaga ega boshliqni top
SELECT m.name AS manager, COUNT(e.id) AS team_size
FROM employees m
LEFT JOIN employees e ON m.id = e.manager_id
GROUP BY m.id
ORDER BY team_size DESC
LIMIT 1;

-- 10. Recursive CTE yordamida boshliq zanjirini chiqar
WITH RECURSIVE chain AS (
    SELECT id, name, manager_id, name AS path
    FROM employees
    WHERE name = 'Aziz'
    UNION ALL
    SELECT e.id, e.name, e.manager_id, chain.path || ' → ' || e.name
    FROM employees e
    INNER JOIN chain ON e.manager_id = chain.id
)
SELECT path FROM chain;
