-- 1:N (One-to-Many) – Ustoz & Talaba
-- 1. Jadval yaratish
CREATE TABLE teachers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INTEGER,
    teacher_id INTEGER REFERENCES teachers(id) ON DELETE SET NULL
);

-- 2. 2 ta ustoz va 5 ta student qo'shish, studentlarni ustozlarga bog'lash
INSERT INTO teachers (name) VALUES ('Javlon'), ('Dilshod');
INSERT INTO students (name, age, teacher_id) VALUES
    ('Ali', 20, 1),
    ('Vali', 22, 1),
    ('Gulnoza', 21, 2),
    ('Diyor', 23, 2),
    ('Malika', 19, 1);

-- 3. Har bir studentning ustozini chiqar
SELECT s.name AS student, t.name AS teacher
FROM students s
LEFT JOIN teachers t ON s.teacher_id = t.id;

-- 4. Har bir ustoz nechta talaba o'qitayotganini chiqar
SELECT t.name, COUNT(s.id) AS student_count
FROM teachers t
LEFT JOIN students s ON t.id = s.teacher_id
GROUP BY t.id;

-- 5. Ustoz o'chsa, studentning teacher_id NULL bo'lishini test qil
DELETE FROM teachers WHERE id = 1;
-- SELECT * FROM students WHERE teacher_id IS NULL;

-- 6. Studentlarni ustoz ismi bo'yicha sarala
SELECT s.*, t.name AS teacher
FROM students s
LEFT JOIN teachers t ON s.teacher_id = t.id
ORDER BY t.name;

-- 7. Eng ko'p talaba o'qitayotgan ustozni top
SELECT t.name, COUNT(s.id) AS student_count
FROM teachers t
LEFT JOIN students s ON t.id = s.teacher_id
GROUP BY t.id
ORDER BY student_count DESC
LIMIT 1;

-- 8. Ustozisiz qolgan studentlarni chiqar
SELECT * FROM students WHERE teacher_id IS NULL;

-- 9. Studentlarni yoshi bo'yicha tartibla va ularning ustozini chiqar
SELECT s.name, s.age, t.name AS teacher
FROM students s
LEFT JOIN teachers t ON s.teacher_id = t.id
ORDER BY s.age;

-- 10. Har bir ustoz bo'yicha studentlarning o'rtacha yoshini hisobla
SELECT t.name, AVG(s.age) AS avg_age
FROM teachers t
LEFT JOIN students s ON t.id = s.teacher_id
GROUP BY t.id;
