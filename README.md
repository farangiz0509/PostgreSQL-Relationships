🧑‍🏫 Relationships bo‘yicha 40 ta Practice Task
🔹 1:1 (One-to-One) – Talaba & Passport misolida
students va passports jadvalini yarat (har bir talabaning bitta passporti bo‘lsin).
3 ta student qo‘sh va ularga passport ber.
INNER JOIN orqali student + passport ro‘yxatini chiqar.
Passport raqami bo‘yicha studentni top.
Passport jadvalida UNIQUE constraint qo‘sh.
Student o‘chirilib ketganda passport ham o‘chib ketishini test qil.
Passporti yo‘q studentlarni chiqar.
Student va passportni birgalikda qo‘shadigan query yoz.
Student ID’si orqali uning passport ma’lumotlarini chiqar.
Passport ID’si orqali egasini top.
🔹 1:N (One-to-Many) – Ustoz & Talaba misolida
teachers va students jadvalini yarat.
2 ta ustoz va 5 ta student qo‘sh, studentlarni ustozlarga bog‘la.
Har bir studentning ustozini chiqar.
Har bir ustoz nechta talaba o‘qitayotganini chiqar.
Ustoz o‘chsa, studentning teacher_id NULL bo‘lishini test qil.
Studentlarni ustoz ismi bo‘yicha sarala.
Eng ko‘p talaba o‘qitayotgan ustozni top.
Ustozisiz qolgan studentlarni chiqar.
Studentlarni yoshi bo‘yicha tartibla va ularning ustozini chiqar.
Har bir ustoz bo‘yicha studentlarning o‘rtacha yoshini hisobla.
🔹 M:N (Many-to-Many) – Student & Course misolida
students, courses, student_courses jadvalini yarat.
3 ta student va 3 ta course qo‘sh.
Studentlarni kurslarga yozdir (kamida 2 ta kurs).
JOIN orqali har bir studentning kurslarini chiqar.
JOIN orqali har bir kursda nechta student borligini hisobla.
Studentning qatnashmagan kurslarini top.
Kursda qatnashmagan studentlarni top.
Biror kursni o‘chirib, ON DELETE CASCADE ishlashini test qil.
Har bir studentning nechta kursi borligini hisobla.
Eng ko‘p kursda qatnashayotgan studentni top.
🔹 Self-Referencing (Recursive) – Xodim & Boshliq misolida
employees jadvalini yarat (manager_id self-foreign key).
1 ta direktor, 2 ta team lead va 3 ta developer qo‘sh.
Har bir xodimning boshlig‘ini chiqar.
Boshlig‘i yo‘q xodimlarni top (direktor).
Har bir boshliq nechta odam boshqarayotganini hisobla.
Malikaning jamoasidagi xodimlarni chiqar.
Har bir xodimni boshlig‘i bilan birga chiqar (JOIN).
Boshliqni o‘chirib, ON DELETE SET NULL ishlashini test qil.
Eng katta jamoaga ega boshliqni top.
Recursive CTE yordamida “Aziz → Bobur → Malika → Dilshod” kabi boshliq zanjirini chiqar.