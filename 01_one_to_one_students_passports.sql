-- 1:1 (One-to-One) – Talaba & Passport
-- 1. Jadval yaratish
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE passports (
    id SERIAL PRIMARY KEY,
    student_id INTEGER UNIQUE REFERENCES students(id) ON DELETE CASCADE,
    passport_number VARCHAR(20) UNIQUE NOT NULL
);

-- 2. 3 ta student va passport qo'shish
INSERT INTO students (name) VALUES ('Ali'), ('Vali'), ('Gulnoza');
INSERT INTO passports (student_id, passport_number) VALUES
    (1, 'AA123456'),
    (2, 'BB654321'),
    (3, 'CC987654');

-- 3. INNER JOIN orqali student + passport ro'yxati
SELECT s.id, s.name, p.passport_number
FROM students s
INNER JOIN passports p ON s.id = p.student_id;

-- 4. Passport raqami bo'yicha studentni top
SELECT s.*
FROM students s
JOIN passports p ON s.id = p.student_id
WHERE p.passport_number = 'AA123456';

-- 5. Passport jadvalida UNIQUE constraint (already added above)
-- 6. Student o'chirilsa passport ham o'chadi (ON DELETE CASCADE)
DELETE FROM students WHERE id = 1;
-- SELECT * FROM passports; -- AA123456 passport o'chgan bo'ladi

-- 7. Passporti yo'q studentlarni chiqar
SELECT * FROM students s
LEFT JOIN passports p ON s.id = p.student_id
WHERE p.id IS NULL;

-- 8. Student va passportni birgalikda qo'shish (transaction)
BEGIN;
INSERT INTO students (name) VALUES ('Diyor');
INSERT INTO passports (student_id, passport_number) VALUES (currval('students_id_seq'), 'DD111222');
COMMIT;

-- 9. Student ID'si orqali passport ma'lumotini chiqar
SELECT p.* FROM passports p WHERE p.student_id = 2;

-- 10. Passport ID'si orqali egasini top
SELECT s.* FROM students s JOIN passports p ON s.id = p.student_id WHERE p.id = 2;
