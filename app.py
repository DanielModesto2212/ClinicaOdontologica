from flask import Flask, render_template, request, redirect, url_for, session
import mysql.connector
from datetime import datetime

app = Flask(__name__)
app.secret_key = 'clave_secreta'

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="bd_odontologia"
)
cursor = db.cursor(dictionary=True)

#----------RUTAS-----------
@app.route('/')
def home():
    return render_template('login.html')

@app.route('/login', methods=['POST'])
def login():
    username = request.form['username']
    password = request.form['password']

    cursor.execute("SELECT * FROM usuario WHERE username = %s", (username,))
    usuario = cursor.fetchone()
    
    # VALIDACION DE CREDENCIALES
    if usuario and usuario['password_hash'] == password:
        session['username'] = usuario['username']
        session['role'] = usuario['role_id']
        return redirect(url_for('dashboard'))
    else:
        # Si la contrase;a es incorrecta saca un alert y devuelve al login
        return '''<script>alert("Credenciales incorrectas"); window.location.href = "/";</script>''' 
    
    
@app.route('/dashboard', methods=['GET', 'POST'])
def dashboard():
    if 'role' not in session:
        return redirect(url_for('home'))

    role = session['role']
    username = session.get('username')

    if role == 1:
        # Obtener user_id desde Usuario
        cursor.execute("SELECT user_id FROM usuario WHERE username = %s", (username,))
        usuario = cursor.fetchone()
        if not usuario:
            return "Usuario no encontrado", 404

        user_id = usuario['user_id']

        # Si es un POST, actualizamos los datos
        if request.method == 'POST':
            telefono = request.form['telefono']
            direccion = request.form['direccion']
            correo = request.form['correo']

            cursor.execute("""
                UPDATE paciente
                SET telefono_paciente = %s, correo_paciente = %s, direccion_paciente = %s
                WHERE user_id = %s
            """, (telefono, correo, direccion, user_id))
            db.commit()  # Confirmamos los cambios

            # Redirigir al perfil actualizado y lanzar alerta
            return '''<script>alert("Datos actualizados"); window.location.href = "{}";</script>'''.format(url_for('dashboard'))

        # Si es un GET, obtenemos los datos del paciente
        cursor.execute("""
            SELECT nombre_paciente, edad_paciente, tipo_sangre, 
                   telefono_paciente, correo_paciente, direccion_paciente
            FROM paciente
            WHERE user_id = %s
        """, (user_id,))
        paciente = cursor.fetchone()

        # Pasamos el objeto paciente a la plantilla
        return render_template('user-dashboard.html', paciente=paciente)
    
    elif role == 2:
        # Obtener user_id desde Usuario
        cursor.execute("SELECT user_id FROM usuario WHERE username = %s", (username,))
        usuario = cursor.fetchone()
        if not usuario:
            return "Usuario no encontrado", 404

        user_id = usuario['user_id']

        # Si es un POST, actualizamos los datos
        if request.method == 'POST':
            telefono_medico = request.form['telefono']
            direccion_medico = request.form['direccion']
            correo_medico = request.form['correo']

            cursor.execute("""
                UPDATE medico
                SET telefono_medico = %s, correo_medico = %s, direccion_medico = %s
                WHERE user_id = %s
            """, (telefono_medico, correo_medico, direccion_medico, user_id))
            db.commit()  # Confirmamos los cambios

            # Redirigir al perfil actualizado y lanzar alerta
            return '''<script>alert("Datos actualizados"); window.location.href = "{}";</script>'''.format(url_for('dashboard'))

        # Si es un GET, obtenemos los datos del paciente
        cursor.execute("""
            SELECT nombre_medico, edad_medico, tipo_sangre_medico, 
                   telefono_medico, correo_medico, direccion_medico
            FROM medico
            WHERE user_id = %s
        """, (user_id,))
        medico = cursor.fetchone()

        # Pasamos el objeto paciente a la plantilla
        return render_template('medico-dashboard.html', medico=medico)

    else:
        return "Rol no identificado"
    

@app.route('/historias_clinicas')
def historias_clinicas():
    if 'role' not in session:
        return redirect(url_for('home'))

    # Obtener el username del usuario logueado
    username = session.get('username')

    # Obtener el user_id del usuario basado en su username
    cursor.execute("SELECT user_id FROM usuario WHERE username = %s", (username,))
    usuario = cursor.fetchone()

    if not usuario:
        return "Usuario no encontrado", 404

    user_id = usuario['user_id']

    # Obtener el id_paciente del usuario
    cursor.execute("SELECT id_paciente FROM paciente WHERE user_id = %s", (user_id,))
    paciente = cursor.fetchone()

    if not paciente:
        return "Paciente no encontrado", 404

    id_paciente = paciente['id_paciente']

    # Obtener las historias clínicas solo para este paciente
    cursor.execute("""
        SELECT h.id_historia,
                   h.analisis,
                   d.id_diagnostico,
                   d.nombre_diagnostico,
                   h.id_procedimiento,
                   p.nombre_procedimiento,
                   h.id_medicamento,
                   m.nombre_medicamento,
                   DATE_FORMAT(h.fecha_historia, '%d/%m/%Y - %H:%i') AS fecha_formateada
        FROM historias_clinicas AS h
        LEFT JOIN diagnosticos AS d ON h.id_diagnostico = d.id_diagnostico
        LEFT JOIN procedimientos AS p ON h.id_procedimiento = p.id_procedimiento
        LEFT JOIN medicamentos AS m ON h.id_medicamento = m.id_medicamento
        WHERE h.id_paciente = %s
        ORDER BY h.fecha_historia DESC;
    """, (id_paciente,))
    historias = cursor.fetchall()

    return render_template('historias_clinicas.html', historias=historias, id_paciente=id_paciente)


@app.route('/forgotPassword')
def forgotPassword():
    return "Menu para recuperar contrase;a"

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('home'))


# ------------------------VISTAS USUARIO-------------------
@app.route('/agendarCita', methods=['GET', 'POST'])
def agendarCita():
    if 'role' not in session or session['role'] != 1:
        return redirect(url_for('home'))

    username = session.get('username')

    # Obtener el user_id
    cursor.execute("SELECT user_id FROM usuario WHERE username = %s", (username,))
    usuario = cursor.fetchone()
    if not usuario:
        return "Usuario no encontrado", 404

    user_id = usuario['user_id']

    # Obtener id_paciente
    cursor.execute("SELECT id_paciente FROM paciente WHERE user_id = %s", (user_id,))
    paciente = cursor.fetchone()
    if not paciente:
        return "Paciente no encontrado", 404

    id_paciente = paciente['id_paciente']

    if request.method == 'POST':
        fecha_cita = request.form['fecha_cita']
        hora_cita = request.form['hora_cita']
        tipo_cita = request.form['tipo_cita']

        try:
            # Insertar cita en la BD
            cursor.execute("""
                INSERT INTO cita (id_paciente, fecha_cita, hora_cita, id_tipo_cita)
                VALUES (%s, %s, %s, %s)
            """, (id_paciente, fecha_cita, f'{fecha_cita} {hora_cita}', tipo_cita))

            db.commit()

            return '''<script>alert("Cita agendada exitosamente"); window.location.href = "/agendarCita";</script>'''
        except Exception as e:
            return f"Error al agendar la cita: {e}"

    # Obtener citas activas
    cursor.execute("""
        SELECT C.id_cita, C.fecha_cita, C.hora_cita, TC.nombre_tipo_cita
        FROM Cita AS C
        JOIN Tipo_Cita AS TC ON C.id_tipo_cita = TC.id_tipo_cita
        WHERE C.id_paciente = %s
    """, (id_paciente,))
    citas = cursor.fetchall()

    return render_template('agendar-cita.html', citas=citas)


@app.route('/cancelarCita', methods=['POST'])
def cancelarCita():
    if 'role' not in session or session['role'] != 1:
        return redirect(url_for('home'))

    id_cita = request.form.get('id_cita')

    try:
        cursor.execute("DELETE FROM cita WHERE id_cita = %s", (id_cita,))
        db.commit()
        return '''<script>alert("Cita cancelada exitosamente"); window.location.href = "/agendarCita";</script>'''
    except:
        return '''<script>alert("Error al cancelar la cita"); window.location.href = "/agendarCita";</script>'''


# ------------------------VISTAS MEDICO-------------------
@app.route('/verAgenda')
def verAgenda():
    if 'role' not in session:
        return redirect(url_for('home'))

    role = session['role']
    # USER
    if role == 1:
        return "Acceso denegado", 403
    # MEDICO
    elif role == 2:
        return render_template('agenda-medico.html')
    else:
        return "Rol no identificado"
    


if __name__ == '__main__':
    app.run(debug=True)

