-- M:N (Many-to-Many) – Student & Course
-- 1. Jadval yaratish
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE student_courses (
    student_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
    course_id INTEGER REFERENCES courses(id) ON DELETE CASCADE,
    PRIMARY KEY (student_id, course_id)
);

-- 2. 3 ta student va 3 ta course qo'shish
INSERT INTO students (name) VALUES ('Ali'), ('Vali'), ('Gulnoza');
INSERT INTO courses (name) VALUES ('Matematika'), ('Fizika'), ('Ingliz tili');

-- 3. Studentlarni kurslarga yozdir (kamida 2 ta kurs)
INSERT INTO student_courses (student_id, course_id) VALUES
    (1, 1), (1, 2),
    (2, 2), (2, 3),
    (3, 1), (3, 3);

-- 4. JOIN orqali har bir studentning kurslarini chiqar
SELECT s.name AS student, c.name AS course
FROM students s
JOIN student_courses sc ON s.id = sc.student_id
JOIN courses c ON c.id = sc.course_id;

-- 5. JOIN orqali har bir kursda nechta student borligini hisobla
SELECT c.name, COUNT(sc.student_id) AS student_count
FROM courses c
LEFT JOIN student_courses sc ON c.id = sc.course_id
GROUP BY c.id;

-- 6. Studentning qatnashmagan kurslarini top
SELECT c.name
FROM courses c
WHERE c.id NOT IN (
    SELECT sc.course_id FROM student_courses sc WHERE sc.student_id = 1
);

-- 7. Kursda qatnashmagan studentlarni top
SELECT s.name
FROM students s
WHERE s.id NOT IN (
    SELECT sc.student_id FROM student_courses sc WHERE sc.course_id = 1
);

-- 8. Biror kursni o'chirib, ON DELETE CASCADE ishlashini test qil
DELETE FROM courses WHERE id = 1;
-- SELECT * FROM student_courses; -- course_id=1 bo'lganlar o'chadi

-- 9. Har bir studentning nechta kursi borligini hisobla
SELECT s.name, COUNT(sc.course_id) AS course_count
FROM students s
LEFT JOIN student_courses sc ON s.id = sc.student_id
GROUP BY s.id;

-- 10. Eng ko'p kursda qatnashayotgan studentni top
SELECT s.name, COUNT(sc.course_id) AS course_count
FROM students s
LEFT JOIN student_courses sc ON s.id = sc.student_id
GROUP BY s.id
ORDER BY course_count DESC
LIMIT 1;
