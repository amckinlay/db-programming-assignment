drop table if exists Teachers;
drop table if exists Students;
drop table if exists Courses;
drop table if exists Administrators;
drop table if exists Staff;
drop table if exists Teaches;
drop table if exists Enrollments;

create table Teachers (
	ssn integer primary key check (ssn >= 0 and length(ssn) = 9),
	firstName text,
	lastName text,
	phone integer check (phone >= 0 and length(phone) = 10),
	gender text check (gender = 'm' or gender = 'f'),
	dob date,
	address text,
	salary integer check (salary >= 0 and length(salary) < 6)
);

create table Students (
	ssn integer primary key check (ssn >= 0 and length(ssn) = 9),
	firstName text,
	lastName text,
	gender text check (gender = 'm' or gender = 'f'),
	dob date,
	address text,
	level text check (level = 'K' or level = '1' or level = '2' or level = '3' or level = '4' or level = '5'),
	gpa real check (gpa >= 0 and gpa < 4)
);

create table Courses (
	courseId integer primary key autoincrement check (courseId >= 0),
	name text,
	level text check (level = 'K' or level = '1' or level = '2' or level = '3' or level = '4' or level = '5')
);

create table Administrators (
	ssn integer primary key check (ssn >= 0 and length(ssn) = 9),
	firstName text,
	lastName text,
	phone integer check (phone >= 0 and length(phone) = 10),
	gender text check (gender = 'm' or gender = 'f'),
	dob date,
	address text,
	salary integer check (salary >= 0 and length(salary) < 6),
	role text
);

create table Staff (
	ssn integer primary key check (ssn >= 0 and length(ssn) = 9),
	firstName text,
	lastName text,
	phone integer check (phone >= 0 and length(phone) = 10),
	gender text check (gender = 'm' or gender = 'f'),
	dob date,
	address text,
	salary integer check (salary >= 0 and length(salary) < 6),
	role text
);

create table Teaches (
	teachesId integer primary key autoincrement, -- Added this
	ssn integer references Teachers (ssn),
	courseId integer references Courses (courseId),
	semester text check (semester = "Fall" or semester = "Spring" or semester = "Summer"),
	year integer check (length(year) = 4 and year > 2012),
	unique (ssn, courseId, semester, year)
);

create table Enrollments ( -- Changed majorly
	ssn integer references Students (ssn),
	teachesId integer references Teaches(teachesId),
	grade text check (grade = "A" or grade = "B" or grade = "C" or grade = "D" or grade = "E"),
	primary key (ssn, teachesId, grade)
);