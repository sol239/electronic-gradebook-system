-- Parent table
DECLARE
  v_parent_id NUMBER;
BEGIN
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Zdeněk',
    p_last_name      => 'Veselý',
    p_email          => 'zdeněk.veselý22@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p1', 'saltp1'),
    p_salt           => 'saltp1'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Adam',
    p_last_name      => 'Kolář',
    p_email          => 'adam.kolář23@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p2', 'saltp2'),
    p_salt           => 'saltp2'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Stanislav',
    p_last_name      => 'Sedláček',
    p_email          => 'stanislav.sedláček24@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p3', 'saltp3'),
    p_salt           => 'saltp3'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Martin',
    p_last_name      => 'Procházka',
    p_email          => 'martin.procházka25@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p4', 'saltp4'),
    p_salt           => 'saltp4'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Richard',
    p_last_name      => 'Horák',
    p_email          => 'richard.horák26@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p5', 'saltp5'),
    p_salt           => 'saltp5'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Aleš',
    p_last_name      => 'Beneš',
    p_email          => 'aleš.beneš27@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p6', 'saltp6'),
    p_salt           => 'saltp6'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Karel',
    p_last_name      => 'Kříž',
    p_email          => 'karel.kříž28@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p7', 'saltp7'),
    p_salt           => 'saltp7'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Filip',
    p_last_name      => 'Beneš',
    p_email          => 'filip.beneš29@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p8', 'saltp8'),
    p_salt           => 'saltp8'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Ondřej',
    p_last_name      => 'Hájek',
    p_email          => 'ondřej.hájek30@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p9', 'saltp9'),
    p_salt           => 'saltp9'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Jiří',
    p_last_name      => 'Urban',
    p_email          => 'jiří.urban31@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p10', 'saltp10'),
    p_salt           => 'saltp10'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Štěpán',
    p_last_name      => 'Jelínek',
    p_email          => 'štěpán.jelínek32@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p11', 'saltp11'),
    p_salt           => 'saltp11'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Ondřej',
    p_last_name      => 'Zeman',
    p_email          => 'ondřej.zeman33@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p12', 'saltp12'),
    p_salt           => 'saltp12'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Tomáš',
    p_last_name      => 'Doležal',
    p_email          => 'tomáš.doležal34@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p13', 'saltp13'),
    p_salt           => 'saltp13'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Dominik',
    p_last_name      => 'Král',
    p_email          => 'dominik.král35@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p14', 'saltp14'),
    p_salt           => 'saltp14'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Adam',
    p_last_name      => 'Němec',
    p_email          => 'adam.němec36@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p15', 'saltp15'),
    p_salt           => 'saltp15'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Jakub',
    p_last_name      => 'Marek',
    p_email          => 'jakub.marek37@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p16', 'saltp16'),
    p_salt           => 'saltp16'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Petr',
    p_last_name      => 'Kolář',
    p_email          => 'petr.kolář38@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p17', 'saltp17'),
    p_salt           => 'saltp17'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Miroslav',
    p_last_name      => 'Horák',
    p_email          => 'miroslav.horák39@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p18', 'saltp18'),
    p_salt           => 'saltp18'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Tomáš',
    p_last_name      => 'Němec',
    p_email          => 'tomáš.němec40@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p19', 'saltp19'),
    p_salt           => 'saltp19'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Zdeněk',
    p_last_name      => 'Fiala',
    p_email          => 'zdeněk.fiala41@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p20', 'saltp20'),
    p_salt           => 'saltp20'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Marek',
    p_last_name      => 'Bartoš',
    p_email          => 'marek.bartoš42@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p21', 'saltp21'),
    p_salt           => 'saltp21'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Daniel',
    p_last_name      => 'Urban',
    p_email          => 'daniel.urban43@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p22', 'saltp22'),
    p_salt           => 'saltp22'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Tomáš',
    p_last_name      => 'Hájek',
    p_email          => 'tomáš.hájek44@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p23', 'saltp23'),
    p_salt           => 'saltp23'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Michal',
    p_last_name      => 'Procházka',
    p_email          => 'michal.procházka45@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p24', 'saltp24'),
    p_salt           => 'saltp24'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Štěpán',
    p_last_name      => 'Svoboda',
    p_email          => 'štěpán.svoboda46@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p25', 'saltp25'),
    p_salt           => 'saltp25'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Miroslav',
    p_last_name      => 'Beneš',
    p_email          => 'miroslav.beneš47@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p26', 'saltp26'),
    p_salt           => 'saltp26'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Pavla',
    p_last_name      => 'Růžičková',
    p_email          => 'pavla.růžičková48@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p27', 'saltp27'),
    p_salt           => 'saltp27'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Radka',
    p_last_name      => 'Benešová',
    p_email          => 'radka.benešová49@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p28', 'saltp28'),
    p_salt           => 'saltp28'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Zuzana',
    p_last_name      => 'Navrátilová',
    p_email          => 'zuzana.navrátilová50@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p29', 'saltp29'),
    p_salt           => 'saltp29'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Pavla',
    p_last_name      => 'Kučerová',
    p_email          => 'pavla.kučerová51@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p30', 'saltp30'),
    p_salt           => 'saltp30'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Lenka',
    p_last_name      => 'Křížová',
    p_email          => 'lenka.křížová52@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p31', 'saltp31'),
    p_salt           => 'saltp31'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Hana',
    p_last_name      => 'Šimková',
    p_email          => 'hana.šimková53@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p32', 'saltp32'),
    p_salt           => 'saltp32'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Karolína',
    p_last_name      => 'Pospíšilová',
    p_email          => 'karolína.pospíšilová54@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p33', 'saltp33'),
    p_salt           => 'saltp33'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Kristýna',
    p_last_name      => 'Marková',
    p_email          => 'kristýna.marková55@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p34', 'saltp34'),
    p_salt           => 'saltp34'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Barbora',
    p_last_name      => 'Vaňková',
    p_email          => 'barbora.vaňková56@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p35', 'saltp35'),
    p_salt           => 'saltp35'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Tereza',
    p_last_name      => 'Marková',
    p_email          => 'tereza.marková57@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p36', 'saltp36'),
    p_salt           => 'saltp36'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Anna',
    p_last_name      => 'Kučerová',
    p_email          => 'anna.kučerová58@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p37', 'saltp37'),
    p_salt           => 'saltp37'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Silvie',
    p_last_name      => 'Novotná',
    p_email          => 'silvie.novotná59@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p38', 'saltp38'),
    p_salt           => 'saltp38'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Ivana',
    p_last_name      => 'Křížová',
    p_email          => 'ivana.křížová60@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p39', 'saltp39'),
    p_salt           => 'saltp39'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Ivana',
    p_last_name      => 'Šimková',
    p_email          => 'ivana.šimková61@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p40', 'saltp40'),
    p_salt           => 'saltp40'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Gabriela',
    p_last_name      => 'Benešová',
    p_email          => 'gabriela.benešová62@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p41', 'saltp41'),
    p_salt           => 'saltp41'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Lenka',
    p_last_name      => 'Dvořáková',
    p_email          => 'lenka.dvořáková63@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p42', 'saltp42'),
    p_salt           => 'saltp42'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Adéla',
    p_last_name      => 'Nováková',
    p_email          => 'adéla.nováková64@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p43', 'saltp43'),
    p_salt           => 'saltp43'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Ivana',
    p_last_name      => 'Černá',
    p_email          => 'ivana.černá65@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p44', 'saltp44'),
    p_salt           => 'saltp44'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Radka',
    p_last_name      => 'Dvořáková',
    p_email          => 'radka.dvořáková66@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p45', 'saltp45'),
    p_salt           => 'saltp45'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Pavla',
    p_last_name      => 'Marková',
    p_email          => 'pavla.marková67@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p46', 'saltp46'),
    p_salt           => 'saltp46'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Zuzana',
    p_last_name      => 'Veselá',
    p_email          => 'zuzana.veselá68@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p47', 'saltp47'),
    p_salt           => 'saltp47'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Monika',
    p_last_name      => 'Fialová',
    p_email          => 'monika.fialová69@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p48', 'saltp48'),
    p_salt           => 'saltp48'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Alena',
    p_last_name      => 'Navrátilová',
    p_email          => 'alena.navrátilová70@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p49', 'saltp49'),
    p_salt           => 'saltp49'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Kristýna',
    p_last_name      => 'Marková',
    p_email          => 'kristýna.marková71@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p50', 'saltp50'),
    p_salt           => 'saltp50'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Adéla',
    p_last_name      => 'Pokorná',
    p_email          => 'adéla.pokorná72@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p51', 'saltp51'),
    p_salt           => 'saltp51'
  );
  v_parent_id := pkg_parent.add_parent(
    p_first_name     => 'Jitka',
    p_last_name      => 'Horáková',
    p_email          => 'jitka.horáková73@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_p52', 'saltp52'),
    p_salt           => 'saltp52'
  );
END;
/
COMMIT;

-- Teacher table
DECLARE
  v_teacher_id NUMBER;
BEGIN
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Stanislav',
    p_last_name      => 'Urban',
    p_email          => 'stanislav.urban74@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t1', 'saltt1'),
    p_salt           => 'saltt1'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Václav',
    p_last_name      => 'Veselý',
    p_email          => 'václav.veselý75@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t2', 'saltt2'),
    p_salt           => 'saltt2'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Zdeněk',
    p_last_name      => 'Dvořák',
    p_email          => 'zdeněk.dvořák76@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t3', 'saltt3'),
    p_salt           => 'saltt3'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Miroslav',
    p_last_name      => 'Černý',
    p_email          => 'miroslav.černý77@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t4', 'saltt4'),
    p_salt           => 'saltt4'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Martin',
    p_last_name      => 'Kříž',
    p_email          => 'martin.kříž78@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t5', 'saltt5'),
    p_salt           => 'saltt5'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Matěj',
    p_last_name      => 'Němec',
    p_email          => 'matěj.němec79@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t6', 'saltt6'),
    p_salt           => 'saltt6'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Martin',
    p_last_name      => 'Král',
    p_email          => 'martin.král80@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t7', 'saltt7'),
    p_salt           => 'saltt7'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Adam',
    p_last_name      => 'Sedláček',
    p_email          => 'adam.sedláček81@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t8', 'saltt8'),
    p_salt           => 'saltt8'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Daniel',
    p_last_name      => 'Marek',
    p_email          => 'daniel.marek82@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t9', 'saltt9'),
    p_salt           => 'saltt9'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Lukáš',
    p_last_name      => 'Bartoš',
    p_email          => 'lukáš.bartoš83@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t10', 'saltt10'),
    p_salt           => 'saltt10'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Pavel',
    p_last_name      => 'Pospíšil',
    p_email          => 'pavel.pospíšil84@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t11', 'saltt11'),
    p_salt           => 'saltt11'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Matěj',
    p_last_name      => 'Horák',
    p_email          => 'matěj.horák85@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t12', 'saltt12'),
    p_salt           => 'saltt12'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Adam',
    p_last_name      => 'Marek',
    p_email          => 'adam.marek86@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t13', 'saltt13'),
    p_salt           => 'saltt13'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Michal',
    p_last_name      => 'Pospíšil',
    p_email          => 'michal.pospíšil87@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t14', 'saltt14'),
    p_salt           => 'saltt14'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Adam',
    p_last_name      => 'Kříž',
    p_email          => 'adam.kříž88@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t15', 'saltt15'),
    p_salt           => 'saltt15'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Marie',
    p_last_name      => 'Svobodová',
    p_email          => 'marie.svobodová89@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t16', 'saltt16'),
    p_salt           => 'saltt16'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Viktorie',
    p_last_name      => 'Pospíšilová',
    p_email          => 'viktorie.pospíšilová90@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t17', 'saltt17'),
    p_salt           => 'saltt17'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Monika',
    p_last_name      => 'Pospíšilová',
    p_email          => 'monika.pospíšilová91@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t18', 'saltt18'),
    p_salt           => 'saltt18'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Klára',
    p_last_name      => 'Nováková',
    p_email          => 'klára.nováková92@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t19', 'saltt19'),
    p_salt           => 'saltt19'
  );
  v_teacher_id := pkg_teacher.add_teacher(
    p_first_name     => 'Radka',
    p_last_name      => 'Nováková',
    p_email          => 'radka.nováková93@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_t20', 'saltt20'),
    p_salt           => 'saltt20'
  );

  -- no-op to end block cleanly
  NULL;
END;
/
COMMIT;

-- Subject table
INSERT INTO Subject (subject_id, name) VALUES (1, 'Český jazyk');
INSERT INTO Subject (subject_id, name) VALUES (2, 'Anglický jazyk');
INSERT INTO Subject (subject_id, name) VALUES (3, 'Matematika');
INSERT INTO Subject (subject_id, name) VALUES (4, 'Fyzika');
INSERT INTO Subject (subject_id, name) VALUES (5, 'Chemie');
INSERT INTO Subject (subject_id, name) VALUES (6, 'Biologie');
INSERT INTO Subject (subject_id, name) VALUES (7, 'Informatika');
INSERT INTO Subject (subject_id, name) VALUES (8, 'Dějepis');
INSERT INTO Subject (subject_id, name) VALUES (9, 'Zeměpis');
INSERT INTO Subject (subject_id, name) VALUES (10, 'Hudební výchova');
INSERT INTO Subject (subject_id, name) VALUES (11, 'Výtvarná výchova');
INSERT INTO Subject (subject_id, name) VALUES (12, 'Tělesná výchova');
INSERT INTO Subject (subject_id, name) VALUES (13, 'Španělský jazyk');
INSERT INTO Subject (subject_id, name) VALUES (14, 'Německý jazyk');
INSERT INTO Subject (subject_id, name) VALUES (15, 'Deskriptivní geometrie');
INSERT INTO Subject (subject_id, name) VALUES (16, 'Ekonomie');
INSERT INTO Subject (subject_id, name) VALUES (17, 'Ruský jazyk');
INSERT INTO Subject (subject_id, name) VALUES (18, 'Analytická chemie');
INSERT INTO Subject (subject_id, name) VALUES (19, 'Základy práva');
INSERT INTO Subject (subject_id, name) VALUES (20, 'Volná hodina');
INSERT INTO Subject (subject_id, name) VALUES (21, 'Školní akce');
COMMIT;

-- Class table
INSERT INTO Class (class_id, name, teacher_id) VALUES (1, 'Prima', 1);
INSERT INTO Class (class_id, name, teacher_id) VALUES (2, 'Sekunda', 2);
INSERT INTO Class (class_id, name, teacher_id) VALUES (3, 'Tercie', 3);
INSERT INTO Class (class_id, name, teacher_id) VALUES (4, 'Kvarta', 4);
INSERT INTO Class (class_id, name, teacher_id) VALUES (5, 'Kvinta', 5);
INSERT INTO Class (class_id, name, teacher_id) VALUES (6, 'Sexta', 6);
INSERT INTO Class (class_id, name, teacher_id) VALUES (7, 'Septima', 7);
INSERT INTO Class (class_id, name, teacher_id) VALUES (8, 'Oktava', 8);
COMMIT;

-- Student table
DECLARE
  v_student_id NUMBER;
BEGIN
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Lukáš',
    p_last_name      => 'Bartoš',
    p_email          => 'lukáš.bartoš1@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s1', 'salts1'),
    p_salt           => 'salts1',
    p_class_id       => 1
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Jan',
    p_last_name      => 'Pospíšil',
    p_email          => 'jan.pospíšil2@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s2', 'salts2'),
    p_salt           => 'salts2',
    p_class_id       => 1
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Miroslav',
    p_last_name      => 'Horák',
    p_email          => 'miroslav.horák3@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s3', 'salts3'),
    p_salt           => 'salts3',
    p_class_id       => 1
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Daniel',
    p_last_name      => 'Beneš',
    p_email          => 'daniel.beneš4@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s4', 'salts4'),
    p_salt           => 'salts4',
    p_class_id       => 1
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Štěpán',
    p_last_name      => 'Navrátil',
    p_email          => 'štěpán.navrátil5@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s5', 'salts5'),
    p_salt           => 'salts5',
    p_class_id       => 1
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Richard',
    p_last_name      => 'Jelínek',
    p_email          => 'richard.jelínek6@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s6', 'salts6'),
    p_salt           => 'salts6',
    p_class_id       => 2
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Zdeněk',
    p_last_name      => 'Veselý',
    p_email          => 'zdeněk.veselý7@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s7', 'salts7'),
    p_salt           => 'salts7',
    p_class_id       => 2
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Michal',
    p_last_name      => 'Bartoš',
    p_email          => 'michal.bartoš8@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s8', 'salts8'),
    p_salt           => 'salts8',
    p_class_id       => 2
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Marek',
    p_last_name      => 'Šimek',
    p_email          => 'marek.šimek9@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s9', 'salts9'),
    p_salt           => 'salts9',
    p_class_id       => 2
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Filip',
    p_last_name      => 'Pospíšil',
    p_email          => 'filip.pospíšil10@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s10', 'salts10'),
    p_salt           => 'salts10',
    p_class_id       => 2
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Sára',
    p_last_name      => 'Veselá',
    p_email          => 'sára.veselá12@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s11', 'salts11'),
    p_salt           => 'salts11',
    p_class_id       => 1
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Sabina',
    p_last_name      => 'Šimková',
    p_email          => 'sabina.šimková13@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s12', 'salts12'),
    p_salt           => 'salts12',
    p_class_id       => 1
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Jana',
    p_last_name      => 'Procházková',
    p_email          => 'jana.procházková14@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s13', 'salts13'),
    p_salt           => 'salts13',
    p_class_id       => 1
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Ivana',
    p_last_name      => 'Jelínková',
    p_email          => 'ivana.jelínková15@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s14', 'salts14'),
    p_salt           => 'salts14',
    p_class_id       => 1
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Klára',
    p_last_name      => 'Sedláčková',
    p_email          => 'klára.sedláčková16@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s15', 'salts15'),
    p_salt           => 'salts15',
    p_class_id       => 1
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Tereza',
    p_last_name      => 'Hájková',
    p_email          => 'tereza.hájková17@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s16', 'salts16'),
    p_salt           => 'salts16',
    p_class_id       => 2
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Silvie',
    p_last_name      => 'Procházková',
    p_email          => 'silvie.procházková18@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s17', 'salts17'),
    p_salt           => 'salts17',
    p_class_id       => 2
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Petra',
    p_last_name      => 'Horáková',
    p_email          => 'petra.horáková19@seznam.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s18', 'salts18'),
    p_salt           => 'salts18',
    p_class_id       => 2
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Natálie',
    p_last_name      => 'Doležalová',
    p_email          => 'natálie.doležalová20@gmail.com',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s19', 'salts19'),
    p_salt           => 'salts19',
    p_class_id       => 2
  );
  v_student_id := pkg_student.add_student(
    p_first_name     => 'Radka',
    p_last_name      => 'Kovářová',
    p_email          => 'radka.kovářová21@centrum.cz',
    p_password_hash  => pkg_utils.hash_password('hashed_password_s20', 'salts20'),
    p_salt           => 'salts20',
    p_class_id       => 2
  );
END;
/
COMMIT;

INSERT INTO Grade_Group (subject_id, teacher_id, name, description ) VALUES (1, 1, 'Diktát 1', 'Diktát na malá/velká písmena');
INSERT INTO Grade_Group (subject_id, teacher_id, name, description ) VALUES (1, 4, 'Slohová práce', 'Slohová práce na téma „Můj nejlepší přítel“');
INSERT INTO Grade_Group (subject_id, teacher_id, name, description ) VALUES (2, 2, 'Essay', 'Essay on "My Favorite Hobby"');

-- Class 1
-- Český jazyk
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (1, 1, 1);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (2, 1, 2);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (1, 2, 2);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (2, 2, 3);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (1, 3, 3);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (1, 4, 4);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (1, 5, 2);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (1, 11, 4);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (1, 12, 4);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (1, 13, 4);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (1, 14, 4);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (1, 15, 2);


-- Anglický jazyk
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (3, 1, 1);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (3, 2, 2);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (3, 3, 3);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (3, 4, 2);
COMMIT;

-- Class 2
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (2, 6, 3);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (2, 7, 2);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (2, 8, 3);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (2, 9, 1);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (2, 10, 4);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (2, 16, 3);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (2, 17, 2);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (2, 18, 3);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (2, 19, 1);
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (2, 20, 4);

COMMIT;

-- Classroom table
INSERT INTO Classroom (classroom_id, name, capacity) VALUES (1, 'Učebna 101', 30);
INSERT INTO Classroom (classroom_id, name, capacity) VALUES (2, 'Učebna 102', 15);
INSERT INTO Classroom (classroom_id, name, capacity) VALUES (3, 'Učebna 103', 30);
INSERT INTO Classroom (classroom_id, name, capacity) VALUES (4, 'Učebna 104', 30);
INSERT INTO Classroom (classroom_id, name, capacity) VALUES (5, 'Učebna 105', 30);
INSERT INTO Classroom (classroom_id, name, capacity) VALUES (6, 'Učebna 201', 30);
INSERT INTO Classroom (classroom_id, name, capacity) VALUES (7, 'Učebna 202', 15);
INSERT INTO Classroom (classroom_id, name, capacity) VALUES (8, 'Učebna 203', 30);
INSERT INTO Classroom (classroom_id, name, capacity) VALUES (9, 'Tělocvična', 120);
INSERT INTO Classroom (classroom_id, name, capacity) VALUES (10, 'Neuvedeno', 1000);
COMMIT;

-- Subject-Teacher table
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (1, 1);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (14, 1);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (5, 2);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (3, 2);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (3, 3);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (10, 3);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (15, 4);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (1, 4);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (5, 4);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (3, 5);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (11, 5);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (16, 6);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (5, 6);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (17, 7);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (6, 7);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (11, 8);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (12, 8);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (8, 8);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (3, 9);
COMMIT;
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (4, 9);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (7, 10);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (4, 10);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (12, 11);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (2, 11);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (17, 12);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (19, 12);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (3, 13);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (1, 13);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (13, 13);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (15, 14);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (13, 14);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (12, 14);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (4, 15);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (9, 15);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (13, 15);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (16, 16);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (3, 16);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (16, 17);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (9, 17);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (15, 17);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (18, 18);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (13, 18);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (1, 19);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (15, 19);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (3, 19);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (10, 20);
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES (17, 20);
COMMIT;

-- Student-Parent table (id: 1-26 = male parents, id: 27-52 = female parents) (id: 1-10 = male students, id: 11-20 = female students)
INSERT INTO Student_Parent (student_id, parent_id) VALUES (1, 1);
INSERT INTO Student_Parent (student_id, parent_id) VALUES (1, 27);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (2, 1);
INSERT INTO Student_Parent (student_id, parent_id) VALUES (2, 27);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (3, 2);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (4, 3);
INSERT INTO Student_Parent (student_id, parent_id) VALUES (4, 28);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (5, 3);
INSERT INTO Student_Parent (student_id, parent_id) VALUES (5, 28);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (6, 3);
INSERT INTO Student_Parent (student_id, parent_id) VALUES (6, 28);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (7, 3);
INSERT INTO Student_Parent (student_id, parent_id) VALUES (7, 28);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (8, 4);
INSERT INTO Student_Parent (student_id, parent_id) VALUES (8, 29);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (9, 4);
INSERT INTO Student_Parent (student_id, parent_id) VALUES (9, 29);
COMMIT;

INSERT INTO Student_Parent (student_id, parent_id) VALUES (10, 5);
INSERT INTO Student_Parent (student_id, parent_id) VALUES (10, 30);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (11, 5);
INSERT INTO Student_Parent (student_id, parent_id) VALUES (11, 30);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (12, 6);
INSERT INTO Student_Parent (student_id, parent_id) VALUES (12, 31);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (13, 6);
INSERT INTO Student_Parent (student_id, parent_id) VALUES (13, 31);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (14, 32);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (15, 7);
INSERT INTO Student_Parent (student_id, parent_id) VALUES (15, 33);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (16, 7);
INSERT INTO Student_Parent (student_id, parent_id) VALUES (16, 33);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (17, 8);
INSERT INTO Student_Parent (student_id, parent_id) VALUES (17, 34);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (18, 9);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (19, 35);

INSERT INTO Student_Parent (student_id, parent_id) VALUES (20, 10);
INSERT INTO Student_Parent (student_id, parent_id) VALUES (20, 36);
COMMIT;

-- Student-Subject table
INSERT INTO Student_Subject (student_id, subject_id) VALUES (1, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (1, 18);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (1, 8);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (1, 2);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (1, 19);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (1, 15);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (1, 14);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (1, 17);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (1, 9);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (1, 12);
COMMIT;
INSERT INTO Student_Subject (student_id, subject_id) VALUES (2, 14);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (2, 8);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (2, 2);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (2, 17);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (2, 10);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (2, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (2, 19);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (2, 3);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (2, 16);
COMMIT;
INSERT INTO Student_Subject (student_id, subject_id) VALUES (3, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (3, 5);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (3, 16);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (3, 4);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (3, 7);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (3, 6);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (3, 8);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (3, 11);
COMMIT;

INSERT INTO Student_Subject (student_id, subject_id) VALUES (4, 4);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (4, 5);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (4, 2);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (4, 8);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (4, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (4, 13);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (4, 12);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (4, 3);
COMMIT;

INSERT INTO Student_Subject (student_id, subject_id) VALUES (5, 19);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (5, 11);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (5, 5);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (5, 7);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (5, 15);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (5, 6);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (5, 10);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (5, 1);
COMMIT;

INSERT INTO Student_Subject (student_id, subject_id) VALUES (6, 18);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (6, 6);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (6, 3);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (6, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (6, 13);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (6, 5);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (6, 12);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (6, 15);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (6, 9);
COMMIT;

INSERT INTO Student_Subject (student_id, subject_id) VALUES (7, 7);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (7, 5);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (7, 18);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (7, 10);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (7, 16);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (7, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (7, 12);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (7, 15);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (7, 4);
COMMIT;

INSERT INTO Student_Subject (student_id, subject_id) VALUES (8, 18);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (8, 14);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (8, 6);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (8, 8);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (8, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (8, 15);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (8, 3);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (8, 7);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (8, 13);
COMMIT;

INSERT INTO Student_Subject (student_id, subject_id) VALUES (9, 19);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (9, 3);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (9, 14);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (9, 8);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (9, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (9, 4);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (9, 6);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (9, 12);
COMMIT;

INSERT INTO Student_Subject (student_id, subject_id) VALUES (10, 2);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (10, 18);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (10, 19);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (10, 9);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (10, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (10, 12);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (10, 5);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (10, 14);
COMMIT;

INSERT INTO Student_Subject (student_id, subject_id) VALUES (11, 18);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (11, 2);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (11, 7);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (11, 19);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (11, 15);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (11, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (11, 3);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (11, 13);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (11, 5);
COMMIT;
INSERT INTO Student_Subject (student_id, subject_id) VALUES (12, 13);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (12, 17);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (12, 10);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (12, 15);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (12, 6);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (12, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (12, 18);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (12, 2);
COMMIT;
INSERT INTO Student_Subject (student_id, subject_id) VALUES (13, 16);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (13, 7);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (13, 3);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (13, 14);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (13, 2);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (13, 4);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (13, 6);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (13, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (13, 8);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (13, 10);
COMMIT;
INSERT INTO Student_Subject (student_id, subject_id) VALUES (14, 18);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (14, 15);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (14, 6);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (14, 19);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (14, 10);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (14, 5);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (14, 12);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (14, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (14, 4);
COMMIT;
INSERT INTO Student_Subject (student_id, subject_id) VALUES (15, 16);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (15, 6);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (15, 14);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (15, 15);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (15, 10);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (15, 12);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (15, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (15, 4);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (15, 7);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (15, 9);
COMMIT;
INSERT INTO Student_Subject (student_id, subject_id) VALUES (16, 9);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (16, 15);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (16, 13);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (16, 12);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (16, 11);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (16, 16);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (16, 7);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (16, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (16, 2);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (16, 3);
COMMIT;
INSERT INTO Student_Subject (student_id, subject_id) VALUES (17, 13);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (17, 14);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (17, 16);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (17, 5);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (17, 2);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (17, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (17, 3);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (17, 7);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (17, 9);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (17, 19);
COMMIT;
INSERT INTO Student_Subject (student_id, subject_id) VALUES (18, 13);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (18, 19);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (18, 18);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (18, 16);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (18, 4);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (18, 6);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (18, 2);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (18, 1);
COMMIT;
INSERT INTO Student_Subject (student_id, subject_id) VALUES (19, 13);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (19, 7);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (19, 9);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (19, 11);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (19, 18);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (19, 6);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (19, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (19, 4);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (19, 3);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (19, 5);
COMMIT;
INSERT INTO Student_Subject (student_id, subject_id) VALUES (20, 6);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (20, 14);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (20, 1);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (20, 13);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (20, 15);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (20, 12);
INSERT INTO Student_Subject (student_id, subject_id) VALUES (20, 11);
COMMIT;

BEGIN
	dbms_output.put_line('Demo data created successfully.');
END;
/