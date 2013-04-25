insert into Teachers values (854695842, "Jeff", "Milkwater", 1234567894, 'm', "1977-12-24", "1843 South Room Drive, Gainesville, FL 32677", 54000);
insert into Teachers values (875658587, "Anne", "Wrightmill", 2586965855, 'f', "1981-07-22", "343 Bloom Street, Gainesville, FL 32677", 44400);
insert into Teachers values (374633374, "Michael", "Hint", 2586965855, 'm', "1941-07-22", "344 Southgarden Road, Gainesville, FL 32672", 76400);
insert into Teachers values (109284639, "Lauren", "Busch", 2586965855, 'f', "1961-03-11", "99 5th Avenue, Gainesville, FL 32677", 55100);

insert into Students values (444927373, "Andrew", "Raindeer", 'm', "1999-12-18", "33 South Oak Road, Gainesville, FL 32603", "5", null);
insert into Students values (423445655, "Gutam", "Foxathol", 'm', "1998-03-22", "19 Fifth Street Way, Gainesville, FL 32603", "5", null);
insert into Students values (998987676, "Napier", "Gordon", 'm', "2002-10-03", "17 Spider Maple Circle, Gainesville, FL 32603", "K", null);
insert into Students values (123442424, "Lisa", "Busrover", 'f', "2000-01-01", "2 Bordeaux Triagnle, Gainesville, FL 32603", "2", null);

insert into Administrators values (412378456, "Smith", "Smithoson", 1314647788, 'm', "1957-04-13", "Lol Stable End, Gainesville, FL 32677", 77600, "Dungeon Officer");
insert into Administrators values (788563259, "Reece", "Joy", 7785585521, 'm', "1969-02-03", "Little Cavern Road, Gainesville, FL 32677", 99600, "Principal");

insert into Staff values (887554599, "Matt", "Zeffow", 8785452218, 'm', "1984-09-11", "777 Lucky Road", 77777, "Vice-Principal");

insert into Courses values (null, 'Art', '2');
insert into Courses values (null, 'History', '5');
insert into Courses values (null, 'Sculpture', '4');
insert into Courses values (null, 'Dining', '1');
insert into Courses values (null, 'Recess', 'K');

insert into Teaches values (null, 875658587, (select courseId from Courses where name = 'Art' and level = '2'), "Fall", 2013);
insert into Teaches values (null, 875658587, (select courseId from Courses where name = 'Art' and level = '2'), "Spring", 2013);
insert into Teaches values (null, 109284639, (select courseId from Courses where name = 'Recess' and level = 'K'), "Fall", 2013);
insert into Teaches values (null, 374633374, (select courseId from Courses where name = 'Dining' and level = '1'), "Summer", 2013);
insert into Teaches values (null, 374633374, (select courseId from Courses where name = 'History' and level = '5'), "Fall", 2013);

insert into Enrollments values (444927373, 1, null);
insert into Enrollments values (444927373, 2, 4);
insert into Enrollments values (998987676, 3, null);
insert into Enrollments values (998987676, 4, 2);
insert into Enrollments values (123442424, 5, null);
insert into Enrollments values (123442424, 1, null);