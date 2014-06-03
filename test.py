import sqlite3

from flask import Flask, g, render_template, request, redirect, url_for


app = Flask(__name__)


def connect_db():
    conn = sqlite3.connect("database.db")
    conn.execute("PRAGMA foreign_keys = ON;")
    conn.row_factory = sqlite3.Row
    return conn


def load_schema():
    with app.open_resource("schema.sql") as schema:
        with connect_db() as db:
            db.executescript(schema.read())
            db.commit()


def load_sample():
    with app.open_resource("sample_data.sql") as data:
        with connect_db() as db:
            db.executescript(data.read())
            db.commit()


def query_db(query, args=(), one=False):
    cur = g.db.execute(query, args)
    rv = cur.fetchall()
    cur.close()
    return (rv[0] if rv else None) if one else rv


@app.before_first_request
def before_first_request():
    try:
        with app.open_resource("database.db"):
            pass
    except IOError:
        load_schema()
        load_sample()


@app.before_request
def before_request():
    g.db = connect_db()


@app.teardown_request
def teardown_request(e):
    g.db.close()


@app.route("/qdb", methods=['POST'])
def qdb():
    g.db.execute(request.form['sql'])
    g.db.commit()
    return redirect(url_for(request.form['redirect']))


@app.route("/")
def home():
    return render_template("home.html")


@app.route("/teachers")
def teachers():
    result = query_db("select * from Teachers")
    return render_template(
        "entries.html",
        entries=result,
        active_page="teachers"
    )


@app.route('/teachers', methods=['POST'])
def add_teachers():
    try:
        g.db.execute('insert into Teachers values (?, ?, ?, ?, ?, ?, ?, ?)', [
            request.form['ssn'],
            request.form['firstName'],
            request.form['lastName'],
            request.form['phone'],
            request.form['gender'],
            request.form['dob'],
            request.form['address'],
            request.form['salary']
        ])
        g.db.commit()
    except sqlite3.IntegrityError as e:
        print e
    return redirect(url_for('teachers'))


@app.route("/students")
def students():
    result = query_db("select * from Students")
    return render_template(
        "entries.html",
        entries=result,
        active_page="students"
    )


@app.route('/students', methods=['POST'])
def add_students():
    try:
        g.db.execute('insert into Students values (?, ?, ?, ?, ?, ?, ?, ?)', [
            request.form['ssn'],
            request.form['firstName'],
            request.form['lastName'],
            request.form['gender'],
            request.form['dob'],
            request.form['address'],
            request.form['level'],
            request.form['gpa']
        ])
        g.db.commit()
    except sqlite3.IntegrityError as e:
        print e
    return redirect(url_for('students'))


@app.route("/administrators")
def administrators():
    result = query_db("select * from Administrators")
    return render_template(
        "entries.html",
        entries=result,
        active_page="administrators"
    )


@app.route('/administrators', methods=['POST'])
def add_administrators():
    try:
        g.db.execute(
            'insert into Administrators values (?, ?, ?, ?, ?, ?, ?, ?, ?)',
            [
                request.form['ssn'],
                request.form['firstName'],
                request.form['lastName'],
                request.form['phone'],
                request.form['gender'],
                request.form['dob'],
                request.form['address'],
                request.form['salary'],
                request.form['role']
            ]
        )
        g.db.commit()
    except sqlite3.IntegrityError as e:
        print e
    return redirect(url_for('administrators'))


@app.route("/staff")
def staff():
    result = query_db("select * from Staff")
    return render_template("entries.html", entries=result, active_page="staff")


@app.route('/staff', methods=['POST'])
def add_staff():
    try:
        g.db.execute('insert into Staff values (?, ?, ?, ?, ?, ?, ?, ?, ?)', [
            request.form['ssn'],
            request.form['firstName'],
            request.form['lastName'],
            request.form['phone'],
            request.form['gender'],
            request.form['dob'],
            request.form['address'],
            request.form['salary'],
            request.form['role']
        ])
        g.db.commit()
    except sqlite3.IntegrityError as e:
        print e
    return redirect(url_for('staff'))


@app.route("/courses")
def courses():
    result = query_db("select * from Courses")
    return render_template(
        "entries.html",
        entries=result,
        active_page="courses"
    )


@app.route('/courses', methods=['POST'])
def add_courses():
    try:
        g.db.execute('insert into Courses values (?, ?, ?)', [
            request.form['courseId'],
            request.form['name'],
            request.form['level']
        ])
        g.db.commit()
    except sqlite3.IntegrityError as e:
        print e
    return redirect(url_for('courses'))


@app.route("/teaches")
def teaches():
    result = query_db("select * from Teaches")
    return render_template(
        "entries.html",
        entries=result,
        active_page="teaches"
    )


@app.route('/teaches', methods=['POST'])
def add_teaches():
    try:
        g.db.execute('insert into Teaches values (?, ?, ?, ?, ?)', [
            request.form['teachesId'],
            request.form['ssn'],
            request.form['courseId'],
            request.form['semester'],
            request.form['year']
        ])
        g.db.commit()
    except sqlite3.IntegrityError as e:
        print e
    return redirect(url_for('teaches'))


@app.route("/enrollments")
def enrollments():
    result = query_db("select * from Enrollments")
    return render_template(
        "entries.html",
        entries=result,
        active_page="enrollments"
    )


@app.route('/enrollments', methods=['POST'])
def add_enrollments():
    try:
        g.db.execute('insert into Enrollments values (?, ?, ?)', [
            request.form['ssn'],
            request.form['teachesId'],
            request.form['grade']
        ])
        g.db.commit()
    except sqlite3.IntegrityError as e:
        print e
    return redirect(url_for('enrollments'))


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True)
