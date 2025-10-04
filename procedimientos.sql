
delimiter // 
-- 1. Procedimiento para inscribir un estudiante en un curso
DROP PROCEDURE IF EXISTS InscribirEstudiantesACurso;

CREATE PROCEDURE IncribiriEstudiantesACurso(
    IN estudiante INT,
    IN curso INT,
    IN fecha DATE
)
BEGIN 
    INSERT INTO Incripciones (id_estudiante, id_curso, fecha_inscripcion)
    VALUES (estudiante, curso, fecha);
END 
//

-- 2. Procedimiento para calcular el promedio de notas de un estudiante
//
DROP PROCEDURE IF EXISTS AVGNotasEstudiante;

CREATE PROCEDURE AVGNotasEstudiante (
    IN estudiante INT,
    OUT promedio DECIMAL(5,2)
)
BEGIN 
    SELECT
        AVG(c.nota) as promedio
    FROM 
        Calificaciones c
    JOIN 
        Inscripciones i ON c.id_inscripcion = i.id_inscripcion
    WHERE 
        i.id_estudiante = estudiante;
END

//

-- 3. Procedimiento para obtener la lista de cursos en los que está inscrito un estudiante
//
DROP PROCEDURE IF EXISTS MateriasPorEstudinte;

CREATE PROCEDURE MateriasPorEstudinte(
    IN estudiante INT
)
BEGIN
    SELECT 
        c.nombre
    FROM 
        Inscripciones i
    JOIN 
        Cursos c 
    ON 
        i.id_curso = c.id_curso 
    WHERE 
        i.id_estudiante = estudiante;
END
//

-- 4. Procedimiento para actualizar la calificación de un estudiante en un curso
//
DROP PROCEDURE IF EXISTS actualizarCalificacionEstudiante;


CREATE PROCEDURE actualizarCalificacionEstudiante(
    IN estudiante INT,
    IN curso INT,
    IN nuevaNota DECIMAL(5,2)
)
BEGIN
    UPDATE Calificaciones c
    JOIN Inscripciones i ON c.id_inscripcion = i.id_inscripcion
    SET c.nota = nuevaNota,
        c.fecha_evaluacion = fecha
    WHERE i.id_estudiante = estudiante;
END 
//

-- 5. Procedimiento para eliminar la inscripción de un estudiante en un curso
//
DROP PROCEDURE IF EXISTS BorrarInscripcionPorEstudianteYCurso;

CREATE PROCEDURE BorrarInscripcionPorEstudianteYCurso(
    IN estudiante INT,
    IN materia INT
)
BEGIN
    DELETE 
    FROM Inscripciones 
    WHERE 
        id_estudiante = estudiante 
        AND id_curso = materia;
END
//



delimiter ;

-- CALL IncribiriEstudiantesACurso(1, 2, '2025-01-10');
CALL AVGNotasEstudiante(1, @avgNota);
CALL MateriasPorEstudinte(1); 
CALL actualizarCalificacionEstudiante(1, 1, 95.0);
CALL BorrarInscripcionPorEstudianteYCurso(1, 2);
