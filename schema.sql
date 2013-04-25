drop table if exists Teachers;
drop table if exists Students;
drop table if exists Courses;
drop table if exists Administrators;
drop table if exists Staff;
drop table if exists Teaches;
drop table if exists Enrollments;

create table Teachers (
	ssn integer primary key check (ssn >= 0 and length(ssn) = 9),
	firstName text not null,
	lastName text not null,
	phone integer not null check (phone >= 0 and length(phone) = 10),
	gender text not null check (gender = 'm' or gender = 'f'),
	dob date not null,
	address text not null,
	salary integer not null check (salary >= 0 and length(salary) < 6)
);

create table Students (
	ssn integer primary key check (ssn >= 0 and length(ssn) = 9),
	firstName text not null,
	lastName text not null,
	gender text not null check (gender = 'm' or gender = 'f'),
	dob date not null,
	address text not null,
	level text not null check (level = 'K' or level = '1' or level = '2' or level = '3' or level = '4' or level = '5'),
	gpa real check (gpa >= 0 and gpa <= 4)
);

create table Courses (
	courseId integer primary key autoincrement check (courseId >= 0),
	name text not null,
	level text not null check (level = 'K' or level = '1' or level = '2' or level = '3' or level = '4' or level = '5'),
	unique (name, level)
);

create table Administrators (
	ssn integer primary key check (ssn >= 0 and length(ssn) = 9),
	firstName text not null,
	lastName text not null,
	phone integer not null check (phone >= 0 and length(phone) = 10),
	gender text not null check (gender = 'm' or gender = 'f'),
	dob date not null,
	address text not null,
	salary integer not null check (salary >= 0 and length(salary) < 6),
	role text
);

create table Staff (
	ssn integer primary key check (ssn >= 0 and length(ssn) = 9),
	firstName text not null,
	lastName text not null,
	phone integer not null check (phone >= 0 and length(phone) = 10),
	gender text not null check (gender = 'm' or gender = 'f'),
	dob date not null,
	address text not null,
	salary integer not null check (salary >= 0 and length(salary) < 6),
	role text
);

create table Teaches (
	teachesId integer primary key autoincrement, -- Added this
	ssn integer not null references Teachers (ssn),
	courseId integer not null references Courses (courseId),
	semester text not null check (semester = "Fall" or semester = "Spring" or semester = "Summer"),
	year integer not null check (length(year) = 4 and year > 2012),
	unique (ssn, courseId, semester, year)
);

create table Enrollments ( -- Changed majorly
	ssn integer not null references Students (ssn),
	teachesId integer not null references Teaches(teachesId),
	grade int check (grade >=0 and grade <=4),
	primary key (ssn, teachesId, grade)
);

create trigger update_grade_update_gpa
after update of grade on Enrollments
begin
	update students
	set gpa = (
	  select avg(grade)
	  from enrollments
	  where students.ssn = enrollments.ssn
	);
end;

create trigger insert_grade_update_gpa
after insert on Enrollments
begin
	update students
	set gpa = (
	  select avg(grade)
	  from enrollments
	  where students.ssn = enrollments.ssn
	);
end;

create trigger delete_grade_update_gpa
after delete on Enrollments
begin
	update students
	set gpa = (
	  select avg(grade)
	  from enrollments
	  where students.ssn = enrollments.ssn
	);
end;

create trigger do_not_change_gpa
before update of gpa on students
begin
	select raise(ignore);
end;