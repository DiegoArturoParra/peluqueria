PGDMP         $                x            DesignStyle    12.2    12.2 Z   ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    17880    DesignStyle    DATABASE     ?   CREATE DATABASE "DesignStyle" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Spain.1252' LC_CTYPE = 'Spanish_Spain.1252';
    DROP DATABASE "DesignStyle";
                postgres    false                        2615    18331    reserva    SCHEMA        CREATE SCHEMA reserva;
    DROP SCHEMA reserva;
                postgres    false                        2615    18332    security    SCHEMA        CREATE SCHEMA security;
    DROP SCHEMA security;
                postgres    false            ?           0    0    SCHEMA security    COMMENT     8   COMMENT ON SCHEMA security IS 'Esquema para auditoria';
                   postgres    false    8            	            2615    18333    usuario    SCHEMA        CREATE SCHEMA usuario;
    DROP SCHEMA usuario;
                postgres    false                       1255    18334 )   f_actualizar_alerta_confirmacion(integer)    FUNCTION     e  CREATE FUNCTION reserva.f_actualizar_alerta_confirmacion(_id integer) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

		begin

		    UPDATE 
			 reserva.reserva
	            SET 
			  confirmacion=TRUE
	            WHERE 
			 reserva.reserva.id=_id ;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
        end 

$$;
 E   DROP FUNCTION reserva.f_actualizar_alerta_confirmacion(_id integer);
       reserva          postgres    false    3                       1255    18335 (   f_actualizar_inacistencia(integer, date)    FUNCTION       CREATE FUNCTION reserva.f_actualizar_inacistencia(_id_estilista integer, _dia_inacistencia date) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

		begin

		    UPDATE 
			 reserva.reservas
	            SET 
			  disponible=FALSE
	            WHERE 
			 reserva.reservas.id_estilista=_id_estilista AND reserva.reservas.hora_inicio::date=_dia_inacistencia;  

		    UPDATE 
	                  reserva.reserva
	            SET 
			  id_alerta=1
	            WHERE 
			 reserva.reserva.id_estilista=_id_estilista AND reserva.reserva.dia_hora_inicio::date=_dia_inacistencia AND reserva.reserva.id_alerta=0
			 AND reserva.reserva.dia_hora_inicio::date > current_timestamp;	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
        end 

$$;
 `   DROP FUNCTION reserva.f_actualizar_inacistencia(_id_estilista integer, _dia_inacistencia date);
       reserva          postgres    false    3                       1255    18336 )   f_actualizar_inacistencia2(integer, date)    FUNCTION       CREATE FUNCTION reserva.f_actualizar_inacistencia2(_id_estilista integer, _dia_inacistencia date) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

		begin

		    UPDATE 
			 reserva.reservas
	            SET 
			  disponible=TRUE
	            WHERE 
			 reserva.reservas.id_estilista=_id_estilista AND reserva.reservas.hora_inicio::date=_dia_inacistencia;  

		    UPDATE 
	                  reserva.reserva
	            SET 
			  id_alerta=0
	            WHERE 
			 reserva.reserva.id_estilista=_id_estilista AND reserva.reserva.dia_hora_inicio::date=_dia_inacistencia AND reserva.reserva.id_alerta=1
			 AND reserva.reserva.dia_hora_inicio::date > current_timestamp;	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
        end 

$$;
 a   DROP FUNCTION reserva.f_actualizar_inacistencia2(_id_estilista integer, _dia_inacistencia date);
       reserva          postgres    false    3                        1255    18337 8   f_actualizar_reserva(integer, integer, integer, boolean)    FUNCTION     h  CREATE FUNCTION reserva.f_actualizar_reserva(_id integer, _id_servicio integer, _id_cliente integer, _disponible boolean) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

		begin
     UPDATE 
     reserva.reservas
	SET 
	   id_servicio =_id_servicio,
	   id_cliente =_id_cliente,
	   disponible =_disponible
	WHERE
	 id = _id;
        end 

$$;
 y   DROP FUNCTION reserva.f_actualizar_reserva(_id integer, _id_servicio integer, _id_cliente integer, _disponible boolean);
       reserva          postgres    false    3            !           1255    18338 '   f_actualizar_reserva2(integer, boolean)    FUNCTION        CREATE FUNCTION reserva.f_actualizar_reserva2(_id integer, _disponible boolean) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

		begin
     UPDATE 
     reserva.reservas
	SET 
	   disponible =_disponible
	WHERE
	 id = _id;
        end 

$$;
 O   DROP FUNCTION reserva.f_actualizar_reserva2(_id integer, _disponible boolean);
       reserva          postgres    false    3            "           1255    18339 B   f_actualizar_servicioeliminado(integer, integer, integer, integer)    FUNCTION       CREATE FUNCTION reserva.f_actualizar_servicioeliminado(_id integer, _servicio integer, _estilista integer, _alerta integer) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

		begin

                    UPDATE 
			 reserva.reserva
	            SET 
			  id_alerta=_alerta
	            WHERE 
			 reserva.reserva.id_estilista=_estilista AND reserva.reserva.id_servicio=_servicio AND reserva.reserva.id_alerta=0;


			 DELETE FROM
		           usuario.usuario_servicio
		         WHERE 
			    id= _id;
	
        end 

$$;
 {   DROP FUNCTION reserva.f_actualizar_servicioeliminado(_id integer, _servicio integer, _estilista integer, _alerta integer);
       reserva          postgres    false    3            #           1255    18340 "   f_eliminar_alerta_reserva(integer)    FUNCTION     ?   CREATE FUNCTION reserva.f_eliminar_alerta_reserva(_id integer) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

begin
	
	DELETE FROM
	reserva.reserva
	WHERE 
	id= _id;
	end

$$;
 >   DROP FUNCTION reserva.f_eliminar_alerta_reserva(_id integer);
       reserva          postgres    false    3            $           1255    18341     f_eliminar_inasistencia(integer)    FUNCTION     ?   CREATE FUNCTION reserva.f_eliminar_inasistencia(id_ integer) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

begin
		
		DELETE FROM
			reserva.alerta_usuario
		WHERE 
			id= id_;
	end

$$;
 <   DROP FUNCTION reserva.f_eliminar_inasistencia(id_ integer);
       reserva          postgres    false    3            %           1255    18342    f_eliminar_reserva(integer)    FUNCTION     ?   CREATE FUNCTION reserva.f_eliminar_reserva(_id integer) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

begin
	
	DELETE FROM
	reserva.reserva
	WHERE 
	id= _id;
	end

$$;
 7   DROP FUNCTION reserva.f_eliminar_reserva(_id integer);
       reserva          postgres    false    3            &           1255    18343    f_guardar_agenda()    FUNCTION     ?  CREATE FUNCTION reserva.f_guardar_agenda() RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	DECLARE
		_cursor refcursor;
		_cursor2 refcursor;
		_row1 reserva.serie%ROWTYPE;
		_row2 reserva.json%ROWTYPE;
		_control int;

	BEGIN

		OPEN _cursor FOR 
			SELECT
			id,
			generate_series AS fecha_inicio,
			generate_series + '15 minute'  AS fecha_fin,
			case extract(dow from generate_series)
				when 1 then 'Lunes'
				when 2 then 'Martes'
				when 3 then 'Miercoles'
				when 4 then 'Jueves'
				when 5 then 'Viernes'
				when 6 then 'Sabado'
				else 'Domingo'
			end as dia
			
		FROM
			generate_series('2019-05-06 00:00'::timestamp, '2019-05-11 00:00'::timestamp, '15 minute')NATURAL JOIN usuario.usuario 
		where
		generate_series::time between '08:00' and '17:00'
		and	(generate_series + interval '15 minute')::time between '08:00' and '18:00'
		and	generate_series::time not between '12:00' and '12:59'
		and id = 39763673;

		LOOP
			FETCH _cursor INTO _row1;
			EXIT WHEN NOT FOUND;
			/*RAISE NOTICE 'Primer cursor Voy en el registro %', _row1.fecha_inicio;
			RAISE NOTICE 'Primer cursor Voy en el registro %', _row1.dia;*/
				OPEN _cursor2 FOR 
					select
					*
					from json_populate_recordset
					(null::reserva.horario_view1,((
					SELECT
						rangos
					FROM
						reserva.horario_estilista
					WHERE
						estilista_id = 1 and dia ilike _row1.dia)));

					LOOP
						FETCH _cursor2 INTO _row2;
						EXIT WHEN NOT FOUND;
						RAISE NOTICE 'id%', _row2.id;
						RAISE NOTICE 'fecha serie%', _row1.fecha_inicio;
						/*RAISE NOTICE 'Hora ininico %', _row2.horainicio;
						RAISE NOTICE 'hora Fin %', _row2.horafin;
						RAISE NOTICE 'extract %', EXTRACT(HOUR FROM _row1.fecha_inicio);*/
						IF ((EXTRACT(HOUR FROM _row1.fecha_inicio) >= _row2.id ) AND (EXTRACT(HOUR FROM _row1.fecha_inicio) < _row2.horainicio))
							THEN
							RAISE NOTICE 'Entre al if id json%', _row2.id;
							RETURN query select _row1.dia, _row1.fecha_inicio,_row1.fecha_fin;
							
						ELSE
							/*RAISE NOTICE 'Estoy en el else %', _row2.horainicio;*/
						END IF;

					END LOOP;

				CLOSE _cursor2;

		END LOOP;

		CLOSE _cursor;
		end

		
$$;
 *   DROP FUNCTION reserva.f_guardar_agenda();
       reserva          postgres    false    3            ?            1259    18344    horario_view3    VIEW     ?   CREATE VIEW reserva.horario_view3 AS
 SELECT ''::text AS dia,
    NULL::timestamp without time zone AS hora_inico,
    NULL::timestamp without time zone AS hora_fin;
 !   DROP VIEW reserva.horario_view3;
       reserva          postgres    false    3            (           1255    18348    f_guardar_agenda2()    FUNCTION     ?  CREATE FUNCTION reserva.f_guardar_agenda2() RETURNS SETOF reserva.horario_view3
    LANGUAGE plpgsql
    AS $$
	DECLARE
		_cursor refcursor;
		_cursor2 refcursor;
		_row1 reserva.serie%ROWTYPE;
		_row2 reserva.json%ROWTYPE;
		_control int;

	BEGIN

		OPEN _cursor FOR 
			SELECT
			id,
			generate_series AS fecha_inicio,
			generate_series + '15 minute'  AS fecha_fin,
			case extract(dow from generate_series)
				when 1 then 'Lunes'
				when 2 then 'Martes'
				when 3 then 'Miercoles'
				when 4 then 'Jueves'
				when 5 then 'Viernes'
				when 6 then 'Sabado'
				else 'Domingo'
			end as dia
			
		FROM
			generate_series('2019-05-06 00:00'::timestamp, '2019-05-11 00:00'::timestamp, '15 minute')NATURAL JOIN usuario.usuario 
		where
		generate_series::time between '08:00' and '17:00'
		and	(generate_series + interval '15 minute')::time between '08:00' and '18:00'
		and	generate_series::time not between '12:00' and '12:59'
		and id = 39763673;

		LOOP
			FETCH _cursor INTO _row1;
			EXIT WHEN NOT FOUND;
			RAISE NOTICE 'Primer cursor Voy en el registro %', _row1.fecha_inicio;
			RAISE NOTICE 'Primer cursor Voy en el registro %', _row1.dia;
				OPEN _cursor2 FOR 
					select
					*
					from json_populate_recordset
					(null::reserva.horario_view1,((
					SELECT
						rangos
					FROM
						reserva.horario_estilista
					WHERE
						estilista_id = 39763673 and dia ilike _row1.dia)));

					LOOP
						FETCH _cursor2 INTO _row2;
						EXIT WHEN NOT FOUND;
						RAISE NOTICE 'id%', _row2.id;
						RAISE NOTICE 'fecha serie%', _row1.fecha_inicio;
						/*RAISE NOTICE 'Hora ininico %', _row2.horainicio;
						RAISE NOTICE 'hora Fin %', _row2.horafin;
						RAISE NOTICE 'extract %', EXTRACT(HOUR FROM _row1.fecha_inicio);*/
						IF ((EXTRACT(HOUR FROM _row1.fecha_inicio) >= _row2.id ) AND (EXTRACT(HOUR FROM _row1.fecha_inicio) < _row2.horainicio))
							THEN
							RAISE NOTICE 'Entre al if id json%', _row2.id;
							RETURN query select _row1.dia, _row1.fecha_inicio,_row1.fecha_fin;
							
						ELSE
							/*RAISE NOTICE 'Estoy en el else %', _row2.horainicio;*/
						END IF;

					END LOOP;

				CLOSE _cursor2;

		END LOOP;

		CLOSE _cursor;
		end

		
$$;
 +   DROP FUNCTION reserva.f_guardar_agenda2();
       reserva          postgres    false    205    3            )           1255    18349 T   f_guardar_agenda3(integer, timestamp without time zone, timestamp without time zone)    FUNCTION     8
  CREATE FUNCTION reserva.f_guardar_agenda3(_id_estilista integer, _inicio_serie timestamp without time zone, _final_serie timestamp without time zone) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	DECLARE
		_cursor refcursor;
		_cursor2 refcursor;
		_row1 reserva.serie%ROWTYPE;
		_row2 reserva.json%ROWTYPE;
		_control int;

	BEGIN

		OPEN _cursor FOR 
			SELECT
			id,
			generate_series AS fecha_inicio,
			generate_series + '15 minute'  AS fecha_fin,
			case extract(dow from generate_series)
				when 1 then 'Lunes'
				when 2 then 'Martes'
				when 3 then 'Miercoles'
				when 4 then 'Jueves'
				when 5 then 'Viernes'
				when 6 then 'Sabado'
				else 'Domingo'
			end as dia
			
		FROM
			generate_series(_inicio_serie, _final_serie, '15 minute')NATURAL JOIN usuario.usuario 
		where
		generate_series::time between '08:00' and '17:00'
		and	(generate_series + interval '15 minute')::time between '08:00' and '18:00'
		/*and	generate_series::time not between '12:00' and '12:59'*/
		and id = _id_estilista;

		LOOP
			FETCH _cursor INTO _row1;
			EXIT WHEN NOT FOUND;
			/*RAISE NOTICE 'Primer cursor Voy en el registro %', _row1.fecha_inicio;
			RAISE NOTICE 'Primer cursor Voy en el registro %', _row1.dia;*/
				OPEN _cursor2 FOR 
					select
					*
					from json_populate_recordset
					(null::reserva.horario_view1,((
					SELECT
						rangos
					FROM
						reserva.horario_estilista
					WHERE
						estilista_id = _id_estilista and dia ilike _row1.dia)));

					LOOP
						FETCH _cursor2 INTO _row2;
						EXIT WHEN NOT FOUND;
						/*RAISE NOTICE 'id%', _row2.id;
						RAISE NOTICE 'fecha serie%', _row1.fecha_inicio;
						RAISE NOTICE 'Hora ininico %', _row2.horainicio;
						RAISE NOTICE 'hora Fin %', _row2.horafin;
						RAISE NOTICE 'extract %', EXTRACT(HOUR FROM _row1.fecha_inicio);*/
						IF ((EXTRACT(HOUR FROM _row1.fecha_inicio) >= _row2.id ) AND (EXTRACT(HOUR FROM _row1.fecha_inicio) < _row2.horainicio))
							THEN
							RAISE NOTICE 'Entre al if id json%', _row2.id;
							/*RETURN query select _row1.dia, _row1.fecha_inicio,_row1.fecha_fin;*/
							INSERT INTO reserva.reservas
							(
								hora_inicio,
								disponible,
								id_estilista,
								hora_final
							)
							VALUES
							(
								_row1.fecha_inicio,
								true,
								_id_estilista,
								_row1.fecha_fin
							);
							
						ELSE
							/*RAISE NOTICE 'Estoy en el else %', _row2.horainicio;*/
						END IF;

					END LOOP;

				CLOSE _cursor2;

		END LOOP;

		CLOSE _cursor;
		end

		
$$;
 ?   DROP FUNCTION reserva.f_guardar_agenda3(_id_estilista integer, _inicio_serie timestamp without time zone, _final_serie timestamp without time zone);
       reserva          postgres    false    3            ?            1259    18350    reservas    TABLE     ?   CREATE TABLE reserva.reservas (
    hora_inicio timestamp without time zone,
    disponible boolean,
    id_estilista integer,
    hora_final timestamp without time zone,
    id integer NOT NULL
);
    DROP TABLE reserva.reservas;
       reserva         heap    postgres    false    3            *           1255    18353 .   f_insert_horario(integer, date, date, boolean)    FUNCTION     ?  CREATE FUNCTION reserva.f_insert_horario(_id_estilista integer, _hora_inicio date, _hora_final date, _estado boolean) RETURNS SETOF reserva.reservas
    LANGUAGE plpgsql
    AS $$
Begin
INSERT INTO reserva.reservas
		(
			
			hora_inicio,
			hora_final,
			disponible,
			id_estilista,
			id_cliente,
			id_servicio,
			id_alerta
		)
		VALUES
		(
			
			_hora_inicio,
			_hora_final,
			_estado,
			_id_estilista,
			0,
			0,
			0
			);
end
$$;
 u   DROP FUNCTION reserva.f_insert_horario(_id_estilista integer, _hora_inicio date, _hora_final date, _estado boolean);
       reserva          postgres    false    206    3            +           1255    18354 \   f_insert_horario(integer, timestamp without time zone, timestamp without time zone, boolean)    FUNCTION       CREATE FUNCTION reserva.f_insert_horario(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone, _estado boolean) RETURNS SETOF reserva.reservas
    LANGUAGE plpgsql
    AS $$
Begin
INSERT INTO reserva.reservas
		(
			
			hora_inicio,
			hora_final,
			disponible,
			id_estilista,
			id_cliente,
			id_servicio,
			id_alerta
		)
		VALUES
		(
			
			_hora_inicio,
			_hora_final,
			_estado,
			_id_estilista,
			0,
			0,
			0
			);
end
$$;
 ?   DROP FUNCTION reserva.f_insert_horario(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone, _estado boolean);
       reserva          postgres    false    206    3            ,           1255    18355    f_insert_horarioprueba(integer)    FUNCTION     ?  CREATE FUNCTION reserva.f_insert_horarioprueba(_id_estilista integer) RETURNS SETOF reserva.reservas
    LANGUAGE plpgsql
    AS $$
Begin
INSERT INTO reserva.reservas
		(
			
			hora_inicio,
			hora_final
		)SELECT 
			generate_series AS hora_inicio, 
			generate_series + interval '15 minute' as hora_final
			FROM 
			generate_series('2019-05-01 00:00'::timestamp, '2019-05-02 00:00'::timestamp, '15 minute')
			where 
			generate_series::time between '08:00' and '17:00'
			and	(generate_series + interval '15 minute')::time between '08:00' and '18:00'
			and	generate_series::time not between '12:00' and '12:59';
end
$$;
 E   DROP FUNCTION reserva.f_insert_horarioprueba(_id_estilista integer);
       reserva          postgres    false    206    3            -           1255    18356 Z   f_insert_horarioprueba2(integer, timestamp without time zone, timestamp without time zone)    FUNCTION     ?  CREATE FUNCTION reserva.f_insert_horarioprueba2(_id_estilista integer, _inicio_serie timestamp without time zone, _final_serie timestamp without time zone) RETURNS SETOF reserva.reservas
    LANGUAGE plpgsql
    AS $$
Begin
INSERT INTO reserva.reservas
		(
			hora_inicio,
			hora_final
		)SELECT 
			generate_series AS hora_inicio, 
			generate_series + interval '15 minute' as hora_final
			FROM 
			generate_series(_inicio_serie, _final_serie, '15 minute')
			where 
			generate_series::time between '08:00' and '17:00'
			and	(generate_series + interval '15 minute')::time between '08:00' and '18:00'
			and	generate_series::time not between '12:00' and '12:59';
end
$$;
 ?   DROP FUNCTION reserva.f_insert_horarioprueba2(_id_estilista integer, _inicio_serie timestamp without time zone, _final_serie timestamp without time zone);
       reserva          postgres    false    206    3            .           1255    18357 Z   f_insert_horarioprueba3(integer, timestamp without time zone, timestamp without time zone)    FUNCTION       CREATE FUNCTION reserva.f_insert_horarioprueba3(_id_estilista integer, _inicio_serie timestamp without time zone, _final_serie timestamp without time zone) RETURNS SETOF reserva.reservas
    LANGUAGE plpgsql
    AS $$
Begin
INSERT INTO reserva.reservas
		(
			hora_inicio,
			hora_final, 
			id_estilista,
			disponible
		)SELECT 
			generate_series AS hora_inicio, 
			generate_series + interval '15 minute' as hora_final,
			_id_estilista AS id_estilista,
			disponible = true
			FROM 
			generate_series(_inicio_serie, _final_serie, '15 minute')
			where 
			generate_series::time between '08:00' and '17:00'
			and	(generate_series + interval '15 minute')::time between '08:00' and '18:00'
			and	generate_series::time not between '12:00' and '12:59';
end
$$;
 ?   DROP FUNCTION reserva.f_insert_horarioprueba3(_id_estilista integer, _inicio_serie timestamp without time zone, _final_serie timestamp without time zone);
       reserva          postgres    false    206    3            /           1255    18358 c   f_insert_horarioprueba3(integer, timestamp without time zone, timestamp without time zone, boolean)    FUNCTION     -  CREATE FUNCTION reserva.f_insert_horarioprueba3(_id_estilista integer, _inicio_serie timestamp without time zone, _final_serie timestamp without time zone, _disponible boolean) RETURNS SETOF reserva.reservas
    LANGUAGE plpgsql
    AS $$
Begin
INSERT INTO reserva.reservas
		(
			hora_inicio,
			hora_final, 
			id_estilista,
			disponible
		)SELECT 
			generate_series AS hora_inicio, 
			generate_series + interval '15 minute' as hora_final,
			_id_estilista AS id_estilista,
			_disponible AS disponible
			FROM 
			generate_series(_inicio_serie, _final_serie, '15 minute')
			where 
			generate_series::time between '08:00' and '17:00'
			and	(generate_series + interval '15 minute')::time between '08:00' and '18:00'
			and	generate_series::time not between '12:00' and '12:59';
end
$$;
 ?   DROP FUNCTION reserva.f_insert_horarioprueba3(_id_estilista integer, _inicio_serie timestamp without time zone, _final_serie timestamp without time zone, _disponible boolean);
       reserva          postgres    false    206    3            ?            1259    18359    alerta_usuario    TABLE     ?   CREATE TABLE reserva.alerta_usuario (
    id integer NOT NULL,
    id_alerta integer NOT NULL,
    id_estilista integer NOT NULL,
    session text,
    last_modified time with time zone,
    dia_inacistencia date NOT NULL
);
 #   DROP TABLE reserva.alerta_usuario;
       reserva         heap    postgres    false    3            ?           0    0    COLUMN alerta_usuario.id    COMMENT     H   COMMENT ON COLUMN reserva.alerta_usuario.id IS 'id de la inacistencia';
          reserva          postgres    false    207            ?           0    0    COLUMN alerta_usuario.id_alerta    COMMENT     l   COMMENT ON COLUMN reserva.alerta_usuario.id_alerta IS 'id de la alerta que le peternece a la inacistencia';
          reserva          postgres    false    207            ?           0    0 "   COLUMN alerta_usuario.id_estilista    COMMENT     `   COMMENT ON COLUMN reserva.alerta_usuario.id_estilista IS 'id del estilista que no va asistir ';
          reserva          postgres    false    207            ?           0    0 &   COLUMN alerta_usuario.dia_inacistencia    COMMENT     q   COMMENT ON COLUMN reserva.alerta_usuario.dia_inacistencia IS 'dia en  que el estilista no va asistir al salon ';
          reserva          postgres    false    207            0           1255    18365 3   f_insert_inacistencia(integer, integer, date, text)    FUNCTION     ?  CREATE FUNCTION reserva.f_insert_inacistencia(_id_alerta integer, _id_estilista integer, _dia_inacistencia date, _session text) RETURNS SETOF reserva.alerta_usuario
    LANGUAGE plpgsql
    AS $$
	BEGIN
		INSERT INTO
			reserva.alerta_usuario
			(id_alerta,
			id_estilista,
			dia_inacistencia,
			session,
			last_modified)
		VALUES
			(
			_id_alerta,
			_id_estilista,
			_dia_inacistencia,
			_session,
			current_timestamp);

				             

			
		end
$$;
    DROP FUNCTION reserva.f_insert_inacistencia(_id_alerta integer, _id_estilista integer, _dia_inacistencia date, _session text);
       reserva          postgres    false    207    3            ?            1259    18366    reserva    TABLE     ?  CREATE TABLE reserva.reserva (
    id integer NOT NULL,
    id_servicio integer,
    id_estilista integer,
    id_alerta integer,
    id_usuario integer,
    session text,
    last_modified timestamp without time zone,
    dia_hora_inicio timestamp without time zone,
    dia_hora_final timestamp without time zone,
    precio integer,
    registro boolean,
    confirmacion boolean
);
    DROP TABLE reserva.reserva;
       reserva         heap    postgres    false    3            ?           0    0    TABLE reserva    COMMENT     J   COMMENT ON TABLE reserva.reserva IS 'Reservas que harán los clientes. ';
          reserva          postgres    false    208            ?           0    0    COLUMN reserva.id    COMMENT     N   COMMENT ON COLUMN reserva.reserva.id IS 'Identificador de la tabla reserva
';
          reserva          postgres    false    208            ?           0    0    COLUMN reserva.id_servicio    COMMENT     a   COMMENT ON COLUMN reserva.reserva.id_servicio IS 'Servicio que fue asignado para esa reserva 
';
          reserva          postgres    false    208            ?           0    0    COLUMN reserva.id_estilista    COMMENT     d   COMMENT ON COLUMN reserva.reserva.id_estilista IS 'Estilista el cual va a realizar ese servicio 
';
          reserva          postgres    false    208            ?           0    0    COLUMN reserva.id_alerta    COMMENT     ?   COMMENT ON COLUMN reserva.reserva.id_alerta IS 'Indica si una reserva fue: 
-cancelada
-no asistió el cliente
-asistió y se realizó el servicio
';
          reserva          postgres    false    208            ?           0    0    COLUMN reserva.id_usuario    COMMENT     ]   COMMENT ON COLUMN reserva.reserva.id_usuario IS 'Identifica cual cliente reservo esa cita.';
          reserva          postgres    false    208            ?           0    0    COLUMN reserva.registro    COMMENT     ?   COMMENT ON COLUMN reserva.reserva.registro IS 'Columna que se usara para verificar si un usurio ya se econtraba registrado en la plataforma a la hora de hacer una reserva. 

Si  = true 
No = false';
          reserva          postgres    false    208            ?           0    0    COLUMN reserva.confirmacion    COMMENT     o   COMMENT ON COLUMN reserva.reserva.confirmacion IS 'se indicara si la alerta ya fue confirmada por el cliente';
          reserva          postgres    false    208            '           1255    18372 l   f_insert_reserva2(integer, timestamp without time zone, timestamp without time zone, integer, integer, text)    FUNCTION     w  CREATE FUNCTION reserva.f_insert_reserva2(_id_estilista integer, _dia_hora_inicio timestamp without time zone, _dia_hora_final timestamp without time zone, _id_servicio integer, _id_usuario integer, _session text) RETURNS SETOF reserva.reserva
    LANGUAGE plpgsql
    AS $$
Begin
INSERT INTO reserva.reserva
		(
			id_servicio,
			id_estilista,
			id_alerta,
			id_usuario,
			session,
			last_modified,
			dia_hora_inicio,
			dia_hora_final
		)
		VALUES
		(
			_id_servicio,
			_id_estilista,
			0,
			_id_usuario,
			_session,
			current_timestamp,
			_dia_hora_inicio,
			_dia_hora_final
			);
end
$$;
 ?   DROP FUNCTION reserva.f_insert_reserva2(_id_estilista integer, _dia_hora_inicio timestamp without time zone, _dia_hora_final timestamp without time zone, _id_servicio integer, _id_usuario integer, _session text);
       reserva          postgres    false    208    3            2           1255    18373 u   f_insert_reserva3(integer, timestamp without time zone, timestamp without time zone, integer, integer, integer, text)    FUNCTION     ?  CREATE FUNCTION reserva.f_insert_reserva3(_id_estilista integer, _dia_hora_inicio timestamp without time zone, _dia_hora_final timestamp without time zone, _id_servicio integer, _id_usuario integer, _precio integer, _session text) RETURNS SETOF reserva.reserva
    LANGUAGE plpgsql
    AS $$
Begin
INSERT INTO reserva.reserva
		(
			id_servicio,
			id_estilista,
			id_alerta,
			id_usuario,
			session,
			last_modified,
			dia_hora_inicio,
			dia_hora_final,
			precio
		)
		VALUES
		(
			_id_servicio,
			_id_estilista,
			0,
			_id_usuario,
			_session,
			current_timestamp,
			_dia_hora_inicio,
			_dia_hora_final,
			_precio
			);
end
$$;
 ?   DROP FUNCTION reserva.f_insert_reserva3(_id_estilista integer, _dia_hora_inicio timestamp without time zone, _dia_hora_final timestamp without time zone, _id_servicio integer, _id_usuario integer, _precio integer, _session text);
       reserva          postgres    false    3    208            3           1255    18374 ~   f_insert_reserva4(integer, timestamp without time zone, timestamp without time zone, integer, integer, integer, boolean, text)    FUNCTION     ?  CREATE FUNCTION reserva.f_insert_reserva4(_id_estilista integer, _dia_hora_inicio timestamp without time zone, _dia_hora_final timestamp without time zone, _id_servicio integer, _id_usuario integer, _precio integer, _registro boolean, _session text) RETURNS SETOF reserva.reserva
    LANGUAGE plpgsql
    AS $$
Begin
INSERT INTO reserva.reserva
		(
			id_servicio,
			id_estilista,
			id_alerta,
			id_usuario,
			session,
			last_modified,
			dia_hora_inicio,
			dia_hora_final,
			precio,
			registro
		)
		VALUES
		(
			_id_servicio,
			_id_estilista,
			0,
			_id_usuario,
			_session,
			current_timestamp,
			_dia_hora_inicio,
			_dia_hora_final,
			_precio,
			_registro
			);
end
$$;
 ?   DROP FUNCTION reserva.f_insert_reserva4(_id_estilista integer, _dia_hora_inicio timestamp without time zone, _dia_hora_final timestamp without time zone, _id_servicio integer, _id_usuario integer, _precio integer, _registro boolean, _session text);
       reserva          postgres    false    3    208            4           1255    18375 ~   f_insert_reserva5(integer, timestamp without time zone, timestamp without time zone, integer, integer, integer, boolean, text)    FUNCTION     ?  CREATE FUNCTION reserva.f_insert_reserva5(_id_estilista integer, _dia_hora_inicio timestamp without time zone, _dia_hora_final timestamp without time zone, _id_servicio integer, _id_usuario integer, _precio integer, _registro boolean, _session text) RETURNS SETOF reserva.reserva
    LANGUAGE plpgsql
    AS $$
Begin
INSERT INTO reserva.reserva
		(
			id_servicio,
			id_estilista,
			id_alerta,
			id_usuario,
			session,
			last_modified,
			dia_hora_inicio,
			dia_hora_final,
			precio,
			registro,
			confirmacion
		)
		VALUES
		(
			_id_servicio,
			_id_estilista,
			0,
			_id_usuario,
			_session,
			current_timestamp,
			_dia_hora_inicio,
			_dia_hora_final,
			_precio,
			_registro,
			false
			);
end
$$;
 ?   DROP FUNCTION reserva.f_insert_reserva5(_id_estilista integer, _dia_hora_inicio timestamp without time zone, _dia_hora_final timestamp without time zone, _id_servicio integer, _id_usuario integer, _precio integer, _registro boolean, _session text);
       reserva          postgres    false    3    208            5           1255    18376 %   f_insertar_rango(text, json, integer)    FUNCTION     6  CREATE FUNCTION reserva.f_insertar_rango(_dia text, _rango json, _estilista_id integer) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		INSERT INTO reserva.horario_estilista
		(
			dia,
			rangos,
			estilista_id
		)
		VALUES 
		(
			_dia,
			_rango,
			_estilista_id
		);

	END
$$;
 W   DROP FUNCTION reserva.f_insertar_rango(_dia text, _rango json, _estilista_id integer);
       reserva          postgres    false    3            ?            1259    18377    reserva_view    VIEW     ?   CREATE VIEW reserva.reserva_view AS
 SELECT 0 AS id,
    ''::text AS servicio,
    ''::text AS nombre_estilista,
    ''::text AS apellido_estilista,
    ''::text AS descripcion,
    '2001-01-01'::date AS fecha;
     DROP VIEW reserva.reserva_view;
       reserva          postgres    false    3            6           1255    18381    f_mostar_alerta(integer)    FUNCTION     ?  CREATE FUNCTION reserva.f_mostar_alerta(_id_usuario integer) RETURNS SETOF reserva.reserva_view
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			reserva.reserva.id,usuario.servicio.nombre,usuario.usuario.nombre,usuario.usuario.apellido,reserva.alerta.descripcion
                        from usuario.servicio,usuario.usuario,reserva.reserva,reserva.alerta
                        where 

                        reserva.alerta.id=reserva.reserva.id_alerta AND usuario.servicio.id=reserva.reserva.id_servicio AND 
                        reserva.reserva.id_usuario=_id_usuario AND usuario.servicio.estado='No disponible' AND usuario.usuario.id=reserva.reserva.id_estilista;
		end
$$;
 <   DROP FUNCTION reserva.f_mostar_alerta(_id_usuario integer);
       reserva          postgres    false    3    209            7           1255    18382    f_mostar_alerta2(integer)    FUNCTION     ?  CREATE FUNCTION reserva.f_mostar_alerta2(_id_usuario integer) RETURNS SETOF reserva.reserva_view
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			reserva.reserva.id,usuario.servicio.nombre,usuario.usuario.nombre,usuario.usuario.apellido,reserva.alerta.descripcion,
			reserva.reserva.dia_hora_inicio::date
                        from usuario.servicio,usuario.usuario,reserva.reserva,reserva.alerta
                        where 
                        reserva.reserva.id=(
			SELECT MAX(reserva.reserva.id)FROM reserva.reserva WHERE reserva.reserva.confirmacion=FALSE ) AND
                        reserva.alerta.id=reserva.reserva.id_alerta AND usuario.servicio.id=reserva.reserva.id_servicio AND 
                        reserva.reserva.id_usuario=_id_usuario AND reserva.reserva.id_alerta IN(1,2,3,6)  AND usuario.usuario.id=reserva.reserva.id_estilista
                        AND reserva.reserva.dia_hora_inicio::date=current_timestamp::date; 
		end
$$;
 =   DROP FUNCTION reserva.f_mostar_alerta2(_id_usuario integer);
       reserva          postgres    false    209    3            ?            1259    18383 #   reserva_inasistencia_estilista_view    VIEW     ?   CREATE VIEW reserva.reserva_inasistencia_estilista_view AS
 SELECT 0 AS id,
    '2001-01-01'::date AS fecha,
    ''::text AS nombre_estilista,
    ''::text AS apellido_estilista;
 7   DROP VIEW reserva.reserva_inasistencia_estilista_view;
       reserva          postgres    false    3            8           1255    18387 )   f_mostar_estilistas_inasistencia(integer)    FUNCTION     q  CREATE FUNCTION reserva.f_mostar_estilistas_inasistencia(_id integer) RETURNS SETOF reserva.reserva_inasistencia_estilista_view
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		 SELECT
			reserva.alerta_usuario.id,reserva.alerta_usuario.dia_inacistencia::date,usuario.usuario.nombre,usuario.usuario.apellido
                         FROM
                        reserva.alerta_usuario,usuario.usuario
                        WHERE 
                        reserva.alerta_usuario.id_estilista=usuario.usuario.id AND reserva.alerta_usuario.id_alerta=1 AND reserva.alerta_usuario.id_estilista=_id ;
	
		end
$$;
 E   DROP FUNCTION reserva.f_mostar_estilistas_inasistencia(_id integer);
       reserva          postgres    false    210    3            ?            1259    18388 $   reserva_inasistencia_estilista_view2    VIEW     ?   CREATE VIEW reserva.reserva_inasistencia_estilista_view2 AS
 SELECT 0 AS id,
    '2001-01-01'::date AS fecha,
    ''::text AS nombre_estilista,
    ''::text AS apellido_estilista,
    ''::text AS servicio;
 8   DROP VIEW reserva.reserva_inasistencia_estilista_view2;
       reserva          postgres    false    3            9           1255    18392 #   f_mostar_estilistas_inasistencia2()    FUNCTION     c  CREATE FUNCTION reserva.f_mostar_estilistas_inasistencia2() RETURNS SETOF reserva.reserva_inasistencia_estilista_view2
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
		
	
		
			reserva.reserva.id,reserva.reserva.dia_hora_inicio::date,usuario.usuario.nombre,usuario.usuario.apellido,usuario.servicio.nombre
                        FROM usuario.usuario,reserva.reserva,usuario.servicio
                        WHERE 

                        reserva.reserva.id_estilista=usuario.usuario.id AND reserva.reserva.id_servicio=usuario.servicio.id AND reserva.reserva.id_alerta=1;
		end
$$;
 ;   DROP FUNCTION reserva.f_mostar_estilistas_inasistencia2();
       reserva          postgres    false    211    3            ?            1259    18393    horario3    VIEW     ?   CREATE VIEW reserva.horario3 AS
 SELECT NULL::timestamp without time zone AS hora_inicio,
    NULL::timestamp without time zone AS hora_fin;
    DROP VIEW reserva.horario3;
       reserva          postgres    false    3            :           1255    18397    f_mostar_horario4()    FUNCTION       CREATE FUNCTION reserva.f_mostar_horario4() RETURNS SETOF reserva.horario3
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT 
	generate_series AS hora_inicio, 
	generate_series + interval '15 minute' as hora_final
FROM 
generate_series('2019-01-01 00:00'::timestamp, '2020-12-31 00:00'::timestamp, '15 minute')
where 
	generate_series::time between '08:00' and '17:00'
and	(generate_series + interval '15 minute')::time between '08:00' and '17:00'
and	generate_series::time not between '12:00' and '12:59';
		end
$$;
 +   DROP FUNCTION reserva.f_mostar_horario4();
       reserva          postgres    false    3    212            ;           1255    18398    f_mostar_horarioprueba()    FUNCTION     #  CREATE FUNCTION reserva.f_mostar_horarioprueba() RETURNS SETOF reserva.horario3
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT 
	generate_series AS hora_inicio, 
	generate_series + interval '15 minute' as hora_final
FROM 
generate_series('2019-04-01 00:00'::timestamp, '2019-05-01 00:00'::timestamp, '15 minute')
where 
	generate_series::time between '08:00' and '17:00'
and	(generate_series + interval '15 minute')::time between '08:00' and '18:00'
and	generate_series::time not between '12:00' and '12:59';
		end
$$;
 0   DROP FUNCTION reserva.f_mostar_horarioprueba();
       reserva          postgres    false    212    3            <           1255    18399 T   f_mostar_horarios(integer, timestamp without time zone, timestamp without time zone)    FUNCTION     ?  CREATE FUNCTION reserva.f_mostar_horarios(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone) RETURNS SETOF reserva.reservas
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query

		SELECT
			*
		FROM
			reserva.reservas
		WHERE 
			id_estilista = _id_estilista 
			AND hora_inicio BETWEEN _hora_inicio AND _hora_final
			AND disponible = true;
		end
$$;
 ?   DROP FUNCTION reserva.f_mostar_horarios(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone);
       reserva          postgres    false    206    3            ?            1259    18400    estilista_horario    VIEW     v   CREATE VIEW reserva.estilista_horario AS
 SELECT 0 AS id,
    NULL::timestamp without time zone AS horario_estilista;
 %   DROP VIEW reserva.estilista_horario;
       reserva          postgres    false    3            =           1255    18404 U   f_mostar_horarios2(integer, timestamp without time zone, timestamp without time zone)    FUNCTION     ?  CREATE FUNCTION reserva.f_mostar_horarios2(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone) RETURNS SETOF reserva.estilista_horario
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query

		SELECT
			id,
			hora_inicio
		FROM
			reserva.reservas
		WHERE 
			id_estilista = _id_estilista 
			AND hora_inicio BETWEEN _hora_inicio AND _hora_final
			AND disponible = true;
		end
$$;
 ?   DROP FUNCTION reserva.f_mostar_horarios2(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone);
       reserva          postgres    false    3    213            ?            1259    18405    estilista_horario2    VIEW     x   CREATE VIEW reserva.estilista_horario2 AS
 SELECT 0 AS id,
    '00:00:00'::time without time zone AS horario_estilista;
 &   DROP VIEW reserva.estilista_horario2;
       reserva          postgres    false    3            1           1255    18409 U   f_mostar_horarios3(integer, timestamp without time zone, timestamp without time zone)    FUNCTION     ?  CREATE FUNCTION reserva.f_mostar_horarios3(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone) RETURNS SETOF reserva.estilista_horario2
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query

		SELECT
			id,
			hora_inicio
		FROM
			reserva.reservas
		WHERE 
			id_estilista = _id_estilista 
			AND hora_inicio BETWEEN _hora_inicio AND _hora_final
			AND disponible = true;
		end
$$;
 ?   DROP FUNCTION reserva.f_mostar_horarios3(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone);
       reserva          postgres    false    3    214            >           1255    18410 U   f_mostar_horarios4(integer, timestamp without time zone, timestamp without time zone)    FUNCTION     ?  CREATE FUNCTION reserva.f_mostar_horarios4(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone) RETURNS SETOF reserva.estilista_horario2
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query

		SELECT
			id,
			hora_inicio::time
		FROM
			reserva.reservas
		WHERE 
			id_estilista = _id_estilista 
			AND hora_inicio BETWEEN _hora_inicio AND _hora_final
			AND disponible = true;
		end
$$;
 ?   DROP FUNCTION reserva.f_mostar_horarios4(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone);
       reserva          postgres    false    214    3            ?           1255    18411 U   f_mostar_horarios5(integer, timestamp without time zone, timestamp without time zone)    FUNCTION     ?  CREATE FUNCTION reserva.f_mostar_horarios5(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone) RETURNS SETOF reserva.estilista_horario2
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query

		SELECT
			id,
			hora_inicio::time
		FROM
			reserva.reservas
		WHERE 
			id_estilista = _id_estilista 
			AND hora_inicio BETWEEN _hora_inicio AND _hora_final
			AND disponible = true
		ORDER BY
			hora_inicio;
		end
$$;
 ?   DROP FUNCTION reserva.f_mostar_horarios5(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone);
       reserva          postgres    false    214    3            @           1255    18412 ^   f_mostar_horarios5(integer, timestamp without time zone, timestamp without time zone, integer)    FUNCTION     V  CREATE FUNCTION reserva.f_mostar_horarios5(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone, _servicio integer) RETURNS SETOF reserva.estilista_horario2
    LANGUAGE plpgsql
    AS $$
	DECLARE
		_cursor refcursor;
		_cursor2 refcursor;
		_row1 reserva.reservas%ROWTYPE;
		_row2 reserva.reservas%ROWTYPE;
		_duracion time;
		_tiempo time;
		_control int;
	BEGIN
		_duracion := (SELECT duracion FROM usuario.servicio WHERE id = _servicio);

		OPEN _cursor FOR 
			SELECT
				*
			FROM
				reserva.reservas
			WHERE 
				id_estilista = _id_estilista 
				AND hora_inicio BETWEEN _hora_inicio AND _hora_final
				AND disponible = true
			ORDER BY
				hora_inicio;

		LOOP
			FETCH _cursor INTO _row1;
			EXIT WHEN NOT FOUND;
			RAISE NOTICE 'Voy en el registro %', _row1.id;
			IF ((_row1.hora_final - _row1.hora_inicio) >= _duracion)
				THEN
					RAISE NOTICE 'Sali por paso 1 %', _row1.id;
					RETURN query select _row1.id, _row1.hora_inicio::time;
			ELSE
				_control = _row1.id;
				OPEN _cursor2 FOR 
					SELECT
						*
					FROM
						reserva.reservas
					WHERE 
						id_estilista = _id_estilista 
						AND hora_inicio BETWEEN _hora_inicio AND _hora_final
						AND disponible = true
						and id > _row1.id
					ORDER BY
						hora_inicio;

					LOOP
						FETCH _cursor2 INTO _row2;
						EXIT WHEN NOT FOUND;
						RAISE NOTICE 'Voy CONTRA %', _row2.id;

						IF (_row2.id - _control = 1)
							THEN
								IF ((_row2.hora_final - _row1.hora_inicio) >= _duracion)
									THEN
										RAISE NOTICE 'Sali por paso 2 %', _row1.id;
										RETURN query select _row1.id, _row1.hora_inicio::time;
										exit;
								ELSE
									_control = _row2.id;
								END IF;
						ELSE
							exit;
						END IF;

					END LOOP;

				CLOSE _cursor2;




/*
				IF(_row2.id -_row1.id = 1)
					THEN
						RAISE NOTICE 'Son continuos %', _row1.id;
						IF ((_row2.hora_final - _row1.hora_inicio) >= _duracion)
							THEN
								RAISE NOTICE 'Sali por paso 2 %', _row1.id;
								RETURN query select _row1.id, _row1.hora_inicio::time;
						ELSE
							_control = _row1.id;
							MOVE PRIOR FROM _cursor;
							LOOP
								RAISE NOTICE 'Entre al loop siendo %', _control;
								FETCH _cursor INTO _row2;
								EXIT WHEN NOT FOUND;

								RAISE NOTICE 'Voy contra %', _row2.id;
								
								IF(_row2.id -_control != 1)
									THEN
										RAISE NOTICE 'No son continuos %', _row2.id;
										EXIT;
								END IF;

								IF ((_row2.hora_final - _row1.hora_inicio) >= _duracion)
									THEN
									RAISE NOTICE 'Sali por paso 3 %', _row1.id;
									RETURN query select _row1.id, _row1.hora_inicio::time;
									EXIT;
								END IF;
								RAISE NOTICE 'No entre con ninguno %', _row2.id;
								_control = _row2.id;
							END LOOP;

							MOVE PRIOR FROM _cursor;
						END IF;
				ELSE
					RAISE NOTICE 'No son continuos%', _row1.id;
					MOVE PRIOR FROM _cursor;
				END IF;
*/
			END IF;
		END LOOP;

		CLOSE _cursor;
		end

		
$$;
 ?   DROP FUNCTION reserva.f_mostar_horarios5(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone, _servicio integer);
       reserva          postgres    false    214    3            A           1255    18413 ^   f_mostar_horarios6(integer, timestamp without time zone, timestamp without time zone, integer)    FUNCTION     ?  CREATE FUNCTION reserva.f_mostar_horarios6(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone, _servicio integer) RETURNS SETOF reserva.estilista_horario2
    LANGUAGE plpgsql
    AS $$
	DECLARE
		_cursor refcursor;
		_cursor2 refcursor;
		_row1 reserva.reservas%ROWTYPE;
		_row2 reserva.reservas%ROWTYPE;
		_duracion time;
		_tiempo time;
		_control int;
	BEGIN
		_duracion := (SELECT duracion FROM usuario.servicio WHERE id = _servicio);

		OPEN _cursor FOR 
			SELECT
				*
			FROM
				reserva.reservas
			WHERE 
				id_estilista = _id_estilista 
				AND hora_inicio BETWEEN _hora_inicio AND _hora_final
				AND disponible = true
			ORDER BY
				hora_inicio;

		LOOP
			FETCH _cursor INTO _row1;
			EXIT WHEN NOT FOUND;
			RAISE NOTICE 'Voy en el registro %', _row1.id;
			/*RAISE NOTICE 'hora inicio %', _row1.hora_inicio;
			RAISE NOTICE 'hora final %', _row1.hora_final;*/
			IF ((_row1.hora_final - _row1.hora_inicio) >= _duracion )
				THEN
					RAISE NOTICE 'Sali por paso 1 %', _row1.id;
					RETURN query select _row1.id, _row1.hora_inicio::time;
			ELSE
				RAISE NOTICE 'entre al else 1 %', _row1.id;
				_control = _row1.id;
				RAISE NOTICE 'primer control %', _control;
				OPEN _cursor2 FOR 
					SELECT
						*
					FROM
						reserva.reservas
					WHERE 
						id_estilista = _id_estilista 
						AND hora_inicio BETWEEN _hora_inicio AND _hora_final
						AND disponible = true
						and id > _row1.id
						and hora_inicio::time != '13:00:00'
					ORDER BY
						hora_inicio;

					LOOP
						FETCH _cursor2 INTO _row2;
						EXIT WHEN NOT FOUND;
						RAISE NOTICE 'Voy CONTRA %', _row2.id;

						IF (_row2.id - _control = 1)
							THEN
							RAISE NOTICE 'entre a con %', _row2.id;
							RAISE NOTICE 'Voy en el registro %', _row1.id;
							/*RAISE NOTICE 'hora inicio row1 %', _row1.hora_inicio;
							RAISE NOTICE 'hora final  row1%', _row1.hora_final;
							RAISE NOTICE 'hora inicio row2 %', _row2.hora_inicio;
							RAISE NOTICE 'hora final  row2%', _row2.hora_final;*/
							RAISE NOTICE 'resta igual antes IF %',(_row2.hora_final - _row1.hora_inicio);
								IF ((_row2.hora_inicio - _row1.hora_inicio) >= _duracion )
									THEN
									RAISE NOTICE 'resta dentro IF igual %',(_row2.hora_final - _row1.hora_inicio);
										RAISE NOTICE 'Sali por paso 2 %', _row1.id;
										RETURN query select _row1.id, _row1.hora_inicio::time;
										exit;
								ELSE
								RAISE NOTICE 'entre al else 3 %', _row1.id;
									_control = _row2.id;
								RAISE NOTICE 'nuevo control %', _control;
								END IF;
						ELSE
						RAISE NOTICE 'entre al else 2 %', _row1.id;
							exit;
						END IF;

					END LOOP;

				CLOSE _cursor2;




/*
				IF(_row2.id -_row1.id = 1)
					THEN
						RAISE NOTICE 'Son continuos %', _row1.id;
						IF ((_row2.hora_final - _row1.hora_inicio) >= _duracion)
							THEN
								RAISE NOTICE 'Sali por paso 2 %', _row1.id;
								RETURN query select _row1.id, _row1.hora_inicio::time;
						ELSE
							_control = _row1.id;
							MOVE PRIOR FROM _cursor;
							LOOP
								RAISE NOTICE 'Entre al loop siendo %', _control;
								FETCH _cursor INTO _row2;
								EXIT WHEN NOT FOUND;

								RAISE NOTICE 'Voy contra %', _row2.id;
								
								IF(_row2.id -_control != 1)
									THEN
										RAISE NOTICE 'No son continuos %', _row2.id;
										EXIT;
								END IF;

								IF ((_row2.hora_final - _row1.hora_inicio) >= _duracion)
									THEN
									RAISE NOTICE 'Sali por paso 3 %', _row1.id;
									RETURN query select _row1.id, _row1.hora_inicio::time;
									EXIT;
								END IF;
								RAISE NOTICE 'No entre con ninguno %', _row2.id;
								_control = _row2.id;
							END LOOP;

							MOVE PRIOR FROM _cursor;
						END IF;
				ELSE
					RAISE NOTICE 'No son continuos%', _row1.id;
					MOVE PRIOR FROM _cursor;
				END IF;
*/
			END IF;
		END LOOP;

		CLOSE _cursor;
		end

		
$$;
 ?   DROP FUNCTION reserva.f_mostar_horarios6(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone, _servicio integer);
       reserva          postgres    false    3    214            ?            1259    18414    horario_estilista    TABLE     ?   CREATE TABLE reserva.horario_estilista (
    id integer NOT NULL,
    dia text NOT NULL,
    rangos json NOT NULL,
    estilista_id integer
);
 &   DROP TABLE reserva.horario_estilista;
       reserva         heap    postgres    false    3            B           1255    18420    f_mostar_rangohorario(integer)    FUNCTION       CREATE FUNCTION reserva.f_mostar_rangohorario(estilista_id integer) RETURNS SETOF reserva.horario_estilista
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query

		SELECT
			dia
		FROM
			reserva.horario_estilista
		WHERE
		estilista_id = estilista_id;
		end
$$;
 C   DROP FUNCTION reserva.f_mostar_rangohorario(estilista_id integer);
       reserva          postgres    false    215    3            C           1255    18421    f_mostar_rangohorario2(integer)    FUNCTION       CREATE FUNCTION reserva.f_mostar_rangohorario2(_estilista_id integer) RETURNS SETOF reserva.horario_estilista
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query

		SELECT
			dia
		FROM
			reserva.horario_estilista
		WHERE
		estilista_id = _estilista_id;
		end
$$;
 E   DROP FUNCTION reserva.f_mostar_rangohorario2(_estilista_id integer);
       reserva          postgres    false    3    215            ?            1259    18422 
   rango_dias    VIEW     ;   CREATE VIEW reserva.rango_dias AS
 SELECT ''::text AS dia;
    DROP VIEW reserva.rango_dias;
       reserva          postgres    false    3            D           1255    18426    f_mostar_rangohorario3(integer)    FUNCTION       CREATE FUNCTION reserva.f_mostar_rangohorario3(_estilista_id integer) RETURNS SETOF reserva.rango_dias
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query

		SELECT
			dia
		FROM
			reserva.horario_estilista
		WHERE
		estilista_id = _estilista_id;
		end
$$;
 E   DROP FUNCTION reserva.f_mostar_rangohorario3(_estilista_id integer);
       reserva          postgres    false    216    3            E           1255    18427    f_mostar_reserva(integer)    FUNCTION     ?   CREATE FUNCTION reserva.f_mostar_reserva(_id integer) RETURNS SETOF reserva.reserva
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query

		SELECT
			*
		FROM
			reserva.reserva
		WHERE 
			id = _id;
		end
$$;
 5   DROP FUNCTION reserva.f_mostar_reserva(_id integer);
       reserva          postgres    false    208    3            ?            1259    18428 "   reserva_estilistas_historial_view2    VIEW       CREATE VIEW reserva.reserva_estilistas_historial_view2 AS
 SELECT 0 AS id,
    ''::text AS nombre_servicio,
    ''::text AS nombre_cliente,
    ''::text AS apellido_cliente,
    '00:00:00'::time without time zone AS hora,
    '2001-01-01'::date AS fecha,
    0 AS alerta;
 6   DROP VIEW reserva.reserva_estilistas_historial_view2;
       reserva          postgres    false    3            F           1255    18432 #   f_mostar_reserva_estilista(integer)    FUNCTION     ?  CREATE FUNCTION reserva.f_mostar_reserva_estilista(_id_usuario integer) RETURNS SETOF reserva.reserva_estilistas_historial_view2
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
		        reserva.reserva.id,usuario.servicio.nombre,usuario.usuario.nombre,usuario.usuario.apellido,reserva.reserva.dia_hora_inicio::time,
		        reserva.reserva.dia_hora_inicio::date,reserva.reserva.id_alerta
                        from usuario.servicio,usuario.usuario ,reserva.reserva
                        where
                        reserva.reserva.id_estilista=_id_usuario AND usuario.servicio.id=reserva.reserva.id_servicio 
                         AND reserva.reserva.id_usuario=usuario.usuario.id  AND reserva.reserva.id_alerta IN(4,5) 
                       
                        
                        ORDER BY
			reserva.reserva.dia_hora_inicio::time;
		end
$$;
 G   DROP FUNCTION reserva.f_mostar_reserva_estilista(_id_usuario integer);
       reserva          postgres    false    3    217            ?            1259    18433 !   reserva_estilistas_historial_view    VIEW     ?   CREATE VIEW reserva.reserva_estilistas_historial_view AS
 SELECT 0 AS id,
    ''::text AS nombre_servicio,
    ''::text AS nombre_cliente,
    ''::text AS apellido_cliente,
    '00:00:00'::time without time zone AS fecha,
    0 AS alerta;
 5   DROP VIEW reserva.reserva_estilistas_historial_view;
       reserva          postgres    false    3            G           1255    18437 )   f_mostar_reserva_estilista(integer, date)    FUNCTION     ?  CREATE FUNCTION reserva.f_mostar_reserva_estilista(_id_usuario integer, _fecha date) RETURNS SETOF reserva.reserva_estilistas_historial_view
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT

			
			reserva.reserva.id,usuario.servicio.nombre,usuario.usuario.nombre,usuario.usuario.apellido,reserva.reserva.dia_hora_inicio::time,reserva.reserva.id_alerta
                        from usuario.servicio,usuario.usuario ,reserva.reserva
                        where
                        reserva.reserva.id_estilista=_id_usuario AND usuario.servicio.id=reserva.reserva.id_servicio AND 
                        reserva.reserva.dia_hora_inicio::date=_fecha AND reserva.reserva.id_usuario=usuario.usuario.id  AND reserva.reserva.id_alerta IN(4,5) 
                       
                        
                        ORDER BY
                        
			reserva.reserva.dia_hora_inicio::time;
		end
$$;
 T   DROP FUNCTION reserva.f_mostar_reserva_estilista(_id_usuario integer, _fecha date);
       reserva          postgres    false    218    3            H           1255    18438 *   f_mostar_reserva_estilista2(integer, date)    FUNCTION     ?  CREATE FUNCTION reserva.f_mostar_reserva_estilista2(_id_usuario integer, _fecha date) RETURNS SETOF reserva.reserva_estilistas_historial_view
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		
		SELECT

			
			reserva.reserva.id,usuario.servicio.nombre,usuario.usuario.nombre,usuario.usuario.apellido,reserva.reserva.dia_hora_inicio::time,reserva.reserva.id_alerta
                        from usuario.servicio,usuario.usuario ,reserva.reserva
                        where
                        reserva.reserva.id_estilista=_id_usuario AND usuario.servicio.id=reserva.reserva.id_servicio AND 
                        reserva.reserva.dia_hora_inicio::date=_fecha AND reserva.reserva.id_usuario=usuario.usuario.id  AND reserva.reserva.id_alerta IN(4,0,5) 
                       
                        
                        ORDER BY
                        
			reserva.reserva.dia_hora_inicio::time;
		end
$$;
 U   DROP FUNCTION reserva.f_mostar_reserva_estilista2(_id_usuario integer, _fecha date);
       reserva          postgres    false    218    3                       1255    18439    f_mostar_reservast()    FUNCTION     ?   CREATE FUNCTION reserva.f_mostar_reservast() RETURNS SETOF reserva.reserva
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query

		SELECT
			*
		FROM
			reserva.reserva;
		end
$$;
 ,   DROP FUNCTION reserva.f_mostar_reservast();
       reserva          postgres    false    3    208            ?            1259    18440    mostrar_reservas1    VIEW     X  CREATE VIEW reserva.mostrar_reservas1 AS
 SELECT ''::text AS nombre_estilista,
    0 AS id_estilista,
    ''::text AS nombre_cliente,
    0 AS id_cliente,
    ''::text AS nombre_servicio,
    0 AS precio,
    NULL::time without time zone AS _hora_inicio,
    NULL::time without time zone AS __hora_final,
    NULL::date AS _fecha,
    0 AS id;
 %   DROP VIEW reserva.mostrar_reservas1;
       reserva          postgres    false    3            I           1255    18444    f_mostar_reservast2()    FUNCTION     ?  CREATE FUNCTION reserva.f_mostar_reservast2() RETURNS SETOF reserva.mostrar_reservas1
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			us.nombre || ' ' || us.apellido,
			rs.id_estilista,
			cl.nombre || ' ' || cl.apellido,
			rs.id_usuario,
			sr.nombre,
			rs.precio,
			rs.dia_hora_inicio::time,
			rs.dia_hora_final::time,
			rs.dia_hora_inicio::date
		FROM
			usuario.usuario us join reserva.reserva rs on rs.id_estilista=us.id and us.id=rs.id_estilista  join usuario.servicio sr on sr.id = rs.id_servicio  join usuario.usuario cl on cl.id = rs.id_usuario 
		ORDER BY
			rs.dia_hora_inicio asc;
			end
$$;
 -   DROP FUNCTION reserva.f_mostar_reservast2();
       reserva          postgres    false    219    3            ?            1259    18445    mostrar_reservas2    VIEW     K  CREATE VIEW reserva.mostrar_reservas2 AS
 SELECT ''::text AS nombre_estilista,
    0 AS id_estilista,
    ''::text AS nombre_cliente,
    0 AS id_cliente,
    ''::text AS nombre_servicio,
    0 AS precio,
    NULL::time without time zone AS _hora_inicio,
    NULL::time without time zone AS __hora_final,
    NULL::date AS _fecha;
 %   DROP VIEW reserva.mostrar_reservas2;
       reserva          postgres    false    3            J           1255    18449    f_mostar_reservast3()    FUNCTION     ?  CREATE FUNCTION reserva.f_mostar_reservast3() RETURNS SETOF reserva.mostrar_reservas2
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			us.nombre || ' ' || us.apellido,
			rs.id_estilista,
			cl.nombre || ' ' || cl.apellido,
			rs.id_usuario,
			sr.nombre,
			rs.precio,
			rs.dia_hora_inicio::time,
			rs.dia_hora_final::time,
			rs.dia_hora_inicio::date
		FROM
			usuario.usuario us join reserva.reserva rs on rs.id_estilista=us.id and us.id=rs.id_estilista  join usuario.servicio sr on sr.id = rs.id_servicio  join usuario.usuario cl on cl.id = rs.id_usuario 
		ORDER BY
			rs.dia_hora_inicio asc;
			end
$$;
 -   DROP FUNCTION reserva.f_mostar_reservast3();
       reserva          postgres    false    3    220            K           1255    18450    f_mostrar_asistencia2(integer)    FUNCTION     w  CREATE FUNCTION reserva.f_mostrar_asistencia2(id_ integer) RETURNS SETOF reserva.reserva
    LANGUAGE plpgsql
    AS $$

begin
		RETURN QUERY
	        SELECT
			*
		FROM
			reserva.reserva
		WHERE 
			reserva.reserva.id=(
			SELECT MAX(reserva.reserva.id)FROM reserva.reserva WHERE reserva.reserva.id_usuario=id_)  AND reserva.reserva.id_usuario=id_ ;
	end

$$;
 :   DROP FUNCTION reserva.f_mostrar_asistencia2(id_ integer);
       reserva          postgres    false    208    3            ?            1259    18451    mostrar_historial    VIEW       CREATE VIEW reserva.mostrar_historial AS
 SELECT ''::text AS nombre_estilista,
    ''::text AS nombre_servicio,
    0 AS precio,
    NULL::time without time zone AS _hora_inicio,
    NULL::time without time zone AS __hora_final,
    NULL::date AS _fecha,
    0 AS id;
 %   DROP VIEW reserva.mostrar_historial;
       reserva          postgres    false    3            L           1255    18455 9   f_mostrar_historial(integer, timestamp without time zone)    FUNCTION     ?  CREATE FUNCTION reserva.f_mostrar_historial(_id_cliente integer, _hora_actual timestamp without time zone) RETURNS SETOF reserva.mostrar_historial
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			us.nombre || ' ' || us.apellido,
			sr.nombre,
			rs.precio,
			rs.dia_hora_inicio::time,
			rs.dia_hora_final::time,
			rs.dia_hora_inicio::date,
			rs.id
		FROM
			usuario.usuario us join reserva.reserva rs  on rs.id_estilista=us.id and us.id=rs.id_estilista join usuario.servicio sr on sr.id = rs.id_servicio
		WHERE 
			rs.id_usuario = _id_cliente and rs.dia_hora_inicio < _hora_actual
		ORDER BY
			rs.dia_hora_inicio DESC;
			end
$$;
 j   DROP FUNCTION reserva.f_mostrar_historial(_id_cliente integer, _hora_actual timestamp without time zone);
       reserva          postgres    false    3    221            M           1255    18456 &   f_mostrar_inacistencia4(integer, date)    FUNCTION     ?  CREATE FUNCTION reserva.f_mostrar_inacistencia4(_id_estilista integer, _dia_inacistencia date) RETURNS SETOF reserva.alerta_usuario
    LANGUAGE plpgsql
    AS $$

begin
		RETURN QUERY

	        SELECT
			*
		FROM
			reserva.alerta_usuario
		WHERE 
			reserva.alerta_usuario.id_estilista=_id_estilista   AND  reserva.alerta_usuario.dia_inacistencia=_dia_inacistencia::date;
	end

$$;
 ^   DROP FUNCTION reserva.f_mostrar_inacistencia4(_id_estilista integer, _dia_inacistencia date);
       reserva          postgres    false    207    3            ?            1259    18457    mostrar_reserva7    VIEW       CREATE VIEW reserva.mostrar_reserva7 AS
 SELECT ''::text AS nombre_estilista,
    ''::text AS nombre_servicio,
    0 AS precio,
    NULL::time without time zone AS _hora_inicio,
    NULL::time without time zone AS __hora_final,
    NULL::date AS _fecha,
    0 AS id;
 $   DROP VIEW reserva.mostrar_reserva7;
       reserva          postgres    false    3            N           1255    18461 :   f_mostrar_reservas10(integer, timestamp without time zone)    FUNCTION     ?  CREATE FUNCTION reserva.f_mostrar_reservas10(_id_cliente integer, _hora_actual timestamp without time zone) RETURNS SETOF reserva.mostrar_reserva7
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			us.nombre || ' ' || us.apellido,
			sr.nombre,
			rs.precio,
			rs.dia_hora_inicio::time,
			rs.dia_hora_final::time,
			rs.dia_hora_inicio::date,
			rs.id
		FROM
			usuario.usuario us join reserva.reserva rs  on rs.id_estilista=us.id and us.id=rs.id_estilista join usuario.servicio sr on sr.id = rs.id_servicio
		WHERE 
			rs.id_usuario = _id_cliente and rs.dia_hora_inicio >= _hora_actual and rs.id_alerta = 0
		ORDER BY
			rs.dia_hora_inicio ASC;
			end
$$;
 k   DROP FUNCTION reserva.f_mostrar_reservas10(_id_cliente integer, _hora_actual timestamp without time zone);
       reserva          postgres    false    222    3            ?            1259    18462    mostrar_reserva6    VIEW       CREATE VIEW reserva.mostrar_reserva6 AS
 SELECT ''::text AS nombre_estilista,
    ''::text AS nombre_servicio,
    0 AS precio,
    NULL::timestamp without time zone AS _dia_hora_inicio,
    NULL::timestamp without time zone AS _dia_hora_final,
    0 AS id;
 $   DROP VIEW reserva.mostrar_reserva6;
       reserva          postgres    false    3            O           1255    18466    f_mostrar_reservas6(integer)    FUNCTION     ?  CREATE FUNCTION reserva.f_mostrar_reservas6(_id_cliente integer) RETURNS SETOF reserva.mostrar_reserva6
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			us.nombre,
			sr.nombre,
			sr.precio,
			rs.dia_hora_inicio,
			rs.dia_hora_final,
			rs.id
		FROM
			usuario.usuario us join reserva.reserva rs  on rs.id_estilista=us.id and us.id=rs.id_estilista join usuario.servicio sr on sr.id = rs.id_servicio
		WHERE 
			rs.id_usuario = _id_cliente;
			end
$$;
 @   DROP FUNCTION reserva.f_mostrar_reservas6(_id_cliente integer);
       reserva          postgres    false    223    3            P           1255    18467    f_mostrar_reservas7(integer)    FUNCTION     ?  CREATE FUNCTION reserva.f_mostrar_reservas7(_id_cliente integer) RETURNS SETOF reserva.mostrar_reserva6
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			us.nombre,
			sr.nombre,
			rs.precio,
			rs.dia_hora_inicio,
			rs.dia_hora_final,
			rs.id
		FROM
			usuario.usuario us join reserva.reserva rs  on rs.id_estilista=us.id and us.id=rs.id_estilista join usuario.servicio sr on sr.id = rs.id_servicio
		WHERE 
			rs.id_usuario = _id_cliente;
			end
$$;
 @   DROP FUNCTION reserva.f_mostrar_reservas7(_id_cliente integer);
       reserva          postgres    false    223    3            Q           1255    18468    f_mostrar_reservas8(integer)    FUNCTION     %  CREATE FUNCTION reserva.f_mostrar_reservas8(_id_cliente integer) RETURNS SETOF reserva.mostrar_reserva7
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			us.nombre || ' ' || us.apellido,
			sr.nombre,
			rs.precio,
			rs.dia_hora_inicio::time,
			rs.dia_hora_final::time,
			rs.dia_hora_inicio::date,
			rs.id
		FROM
			usuario.usuario us join reserva.reserva rs  on rs.id_estilista=us.id and us.id=rs.id_estilista join usuario.servicio sr on sr.id = rs.id_servicio
		WHERE 
			rs.id_usuario = _id_cliente;
			end
$$;
 @   DROP FUNCTION reserva.f_mostrar_reservas8(_id_cliente integer);
       reserva          postgres    false    3    222            R           1255    18469 9   f_mostrar_reservas9(integer, timestamp without time zone)    FUNCTION     ?  CREATE FUNCTION reserva.f_mostrar_reservas9(_id_cliente integer, _hora_actual timestamp without time zone) RETURNS SETOF reserva.mostrar_reserva7
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			us.nombre || ' ' || us.apellido,
			sr.nombre,
			rs.precio,
			rs.dia_hora_inicio::time,
			rs.dia_hora_final::time,
			rs.dia_hora_inicio::date,
			rs.id
		FROM
			usuario.usuario us join reserva.reserva rs  on rs.id_estilista=us.id and us.id=rs.id_estilista join usuario.servicio sr on sr.id = rs.id_servicio
		WHERE 
			rs.id_usuario = _id_cliente and rs.dia_hora_inicio >= _hora_actual
		ORDER BY
			rs.dia_hora_inicio ASC;
			end
$$;
 j   DROP FUNCTION reserva.f_mostrar_reservas9(_id_cliente integer, _hora_actual timestamp without time zone);
       reserva          postgres    false    3    222            S           1255    18470 2   f_mostrar_reservassin(timestamp without time zone)    FUNCTION     x  CREATE FUNCTION reserva.f_mostrar_reservassin(_hora_actual timestamp without time zone) RETURNS SETOF reserva.mostrar_reserva7
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			us.nombre || ' ' || us.apellido,
			sr.nombre,
			rs.precio,
			rs.dia_hora_inicio::time,
			rs.dia_hora_final::time,
			rs.dia_hora_inicio::date,
			rs.id
		FROM
			usuario.usuario us join reserva.reserva rs on rs.id_usuario=us.id and us.id=rs.id_usuario join usuario.servicio sr on sr.id = rs.id_servicio
		WHERE 
			us.id_rol = 4 and rs.dia_hora_inicio >= _hora_actual 
		ORDER BY
			rs.dia_hora_inicio ASC;
			end
$$;
 W   DROP FUNCTION reserva.f_mostrar_reservassin(_hora_actual timestamp without time zone);
       reserva          postgres    false    222    3            T           1255    18471 U   f_read_reservasest(integer, timestamp without time zone, timestamp without time zone)    FUNCTION     ?  CREATE FUNCTION reserva.f_read_reservasest(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone) RETURNS SETOF reserva.mostrar_reserva7
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			us.nombre || ' ' || us.apellido,
			sr.nombre,
			rs.precio,
			rs.dia_hora_inicio::time,
			rs.dia_hora_final::time,
			rs.dia_hora_inicio::date,
			rs.id
		FROM
			usuario.usuario us join reserva.reserva rs  on rs.id_usuario=us.id and us.id=rs.id_usuario join usuario.servicio sr on sr.id = rs.id_servicio
		WHERE 
			rs.dia_hora_inicio BETWEEN _hora_inicio AND _hora_final 
			AND rs.id_estilista = _id_estilista
		ORDER BY
			rs.dia_hora_inicio ASC;
			end
$$;
 ?   DROP FUNCTION reserva.f_read_reservasest(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone);
       reserva          postgres    false    222    3            ?            1259    18472    mostrar_reservaest    VIEW     ?   CREATE VIEW reserva.mostrar_reservaest AS
 SELECT ''::text AS nombre_cliente,
    ''::text AS nombre_servicio,
    NULL::time without time zone AS _hora_inicio,
    NULL::time without time zone AS __hora_final,
    NULL::date AS _fecha,
    0 AS id;
 &   DROP VIEW reserva.mostrar_reservaest;
       reserva          postgres    false    3            U           1255    18476 V   f_read_reservasest2(integer, timestamp without time zone, timestamp without time zone)    FUNCTION     ?  CREATE FUNCTION reserva.f_read_reservasest2(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone) RETURNS SETOF reserva.mostrar_reservaest
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			us.nombre || ' ' || us.apellido,
			sr.nombre,
			rs.dia_hora_inicio::time,
			rs.dia_hora_final::time,
			rs.dia_hora_inicio::date,
			rs.id
		FROM
			usuario.usuario us join reserva.reserva rs  on rs.id_usuario=us.id and us.id=rs.id_usuario join usuario.servicio sr on sr.id = rs.id_servicio
		WHERE 
			rs.dia_hora_inicio BETWEEN _hora_inicio AND _hora_final 
			AND rs.id_estilista = _id_estilista
		ORDER BY
			rs.dia_hora_inicio ASC;
			end
$$;
 ?   DROP FUNCTION reserva.f_read_reservasest2(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone);
       reserva          postgres    false    224    3            ?            1259    18477    servicios_mas    VIEW     b   CREATE VIEW reserva.servicios_mas AS
 SELECT 0 AS id,
    NULL::text AS _nombre,
    0 AS _total;
 !   DROP VIEW reserva.servicios_mas;
       reserva          postgres    false    3            V           1255    18481    f_reporte_servicio()    FUNCTION     ?  CREATE FUNCTION reserva.f_reporte_servicio() RETURNS SETOF reserva.servicios_mas
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT p2.id , p2.nombre , p1.total FROM 
		(SELECT servicio.id, servicio.nombre FROM usuario.servicio)p2
		LEFT JOIN 
		(SELECT reserva.id_servicio AS id, COUNT(reserva.id_servicio) AS total FROM reserva.reserva GROUP BY reserva.id_servicio)p1
		ON (p2.id = p1.id)
		ORDER BY
		p2.id desc;
		end
$$;
 ,   DROP FUNCTION reserva.f_reporte_servicio();
       reserva          postgres    false    225    3            ?            1259    18482    servicios_mas1    VIEW     m   CREATE VIEW reserva.servicios_mas1 AS
 SELECT 0 AS id,
    NULL::text AS _nombre,
    (0)::bigint AS _total;
 "   DROP VIEW reserva.servicios_mas1;
       reserva          postgres    false    3            W           1255    18486    f_reporte_servicio2()    FUNCTION     ?  CREATE FUNCTION reserva.f_reporte_servicio2() RETURNS SETOF reserva.servicios_mas1
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT p2.id , p2.nombre , p1.total FROM 
		(SELECT servicio.id, servicio.nombre FROM usuario.servicio)p2
		LEFT JOIN 
		(SELECT reserva.id_servicio AS id, COUNT(reserva.id_servicio) AS total FROM reserva.reserva GROUP BY reserva.id_servicio)p1
		ON (p2.id = p1.id)
		ORDER BY
		p2.id desc;
		end
$$;
 -   DROP FUNCTION reserva.f_reporte_servicio2();
       reserva          postgres    false    3    226            ?            1259    18487 !   reserva_usuario_sinregistro_view2    VIEW     ?   CREATE VIEW reserva.reserva_usuario_sinregistro_view2 AS
 SELECT 0 AS id,
    ''::text AS nombre,
    ''::text AS apellido,
    ''::text AS servicio,
    '2001-01-01'::date AS fecha,
    '00:00:00'::time without time zone AS hora;
 5   DROP VIEW reserva.reserva_usuario_sinregistro_view2;
       reserva          postgres    false    3            X           1255    18491     f_reporte_usuario_sin_registro()    FUNCTION     [  CREATE FUNCTION reserva.f_reporte_usuario_sin_registro() RETURNS SETOF reserva.reserva_usuario_sinregistro_view2
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query

		SELECT
			reserva.reserva.id_usuario,usuario.usuario.nombre,usuario.usuario.apellido,usuario.servicio.nombre,reserva.reserva.dia_hora_inicio::date,reserva.reserva.dia_hora_inicio::time
		FROM
			reserva.reserva,usuario.usuario,usuario.servicio
		WHERE 			

		        reserva.reserva.registro=false AND usuario.usuario.id=reserva.reserva.id_usuario
		        AND usuario.servicio.id=reserva.reserva.id_servicio;
		end
$$;
 8   DROP FUNCTION reserva.f_reporte_usuario_sin_registro();
       reserva          postgres    false    3    227            Y           1255    18492 8   f_traer_rescliente(integer, timestamp without time zone)    FUNCTION     x  CREATE FUNCTION reserva.f_traer_rescliente(_id_cliente integer, _fechaactual timestamp without time zone) RETURNS SETOF reserva.reserva
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query

		SELECT
			*
		FROM
			reserva.reserva
		WHERE 
			id_usuario = _id_cliente
		AND
			dia_hora_inicio >= _fechaActual 
		AND 
		dia_hora_inicio <= _fechaActual;
		end
$$;
 i   DROP FUNCTION reserva.f_traer_rescliente(_id_cliente integer, _fechaactual timestamp without time zone);
       reserva          postgres    false    3    208            Z           1255    18493 U   f_traer_rescliente(integer, timestamp without time zone, timestamp without time zone)    FUNCTION     ?  CREATE FUNCTION reserva.f_traer_rescliente(_id_cliente integer, _fechaactual timestamp without time zone, _hora_final timestamp without time zone) RETURNS SETOF reserva.reserva
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query

		SELECT
			*
		FROM
			reserva.reserva
		WHERE 
			id_usuario = _id_cliente
		AND dia_hora_inicio BETWEEN _fechaactual AND _hora_final;
		end
$$;
 ?   DROP FUNCTION reserva.f_traer_rescliente(_id_cliente integer, _fechaactual timestamp without time zone, _hora_final timestamp without time zone);
       reserva          postgres    false    3    208            [           1255    18494 \   f_traer_reservas(integer, integer, timestamp without time zone, timestamp without time zone)    FUNCTION     ?  CREATE FUNCTION reserva.f_traer_reservas(_id_estilista integer, _id_cliente integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone) RETURNS SETOF reserva.reservas
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query

		SELECT
			*
		FROM
			reserva.reservas
		WHERE 
			id_estilista = _id_estilista 
			AND 
			id_cliente = _id_cliente
			AND hora_inicio BETWEEN _hora_inicio AND _hora_final
			AND disponible = false;
		end
$$;
 ?   DROP FUNCTION reserva.f_traer_reservas(_id_estilista integer, _id_cliente integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone);
       reserva          postgres    false    206    3            \           1255    18495 T   f_traer_reservas2(integer, timestamp without time zone, timestamp without time zone)    FUNCTION     ?  CREATE FUNCTION reserva.f_traer_reservas2(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone) RETURNS SETOF reserva.reservas
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query

		SELECT
			*
		FROM
			reserva.reservas
		WHERE 
			id_estilista = _id_estilista 
			AND hora_inicio BETWEEN _hora_inicio AND _hora_final
			AND disponible = false;
		end
$$;
 ?   DROP FUNCTION reserva.f_traer_reservas2(_id_estilista integer, _hora_inicio timestamp without time zone, _hora_final timestamp without time zone);
       reserva          postgres    false    206    3            ]           1255    18496    insert_horario(integer)    FUNCTION     t  CREATE FUNCTION reserva.insert_horario(_id_estilista integer) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

	BEGIN
	SELECT 
	ROW_NUMBER() OVER () as _id, 
	generate_series AS _hora_inicio, 
	generate_series + interval '15 minute' as _hora_final, 
	true::boolean AS _disponible
FROM 
generate_series('2019-01-01 00:00'::timestamp, '2020-12-31 00:00'::timestamp, '15 minute')
where 
	generate_series::time between '08:00' and '17:00'
and	(generate_series + interval '15 minute')::time between '08:00' and '17:00'
and	generate_series::time not between '12:00' and '12:59';

INSERT INTO reserva.reservas
		(
			id,
			hora_inicio,
			hora_final,
			disponible,
			id_estilista,
			id_cliente,
			id_servicio,
			id_alerta
		)
		VALUES
		(
			_id,
			_hora_inicio,
			_hora_final,
			_disponible,
			_id_estilista,
			0,
			0,
			0
			);
end
$$;
 =   DROP FUNCTION reserva.insert_horario(_id_estilista integer);
       reserva          postgres    false    3            ^           1255    18497    f_cerrar_session(text)    FUNCTION     ?   CREATE FUNCTION security.f_cerrar_session(_session text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	
	
		
	BEGIN
		UPDATE
			security.autenication
		SET
			fecha_fin = current_timestamp
		WHERE
			session = _session;
			
	END

$$;
 8   DROP FUNCTION security.f_cerrar_session(_session text);
       security          postgres    false    8            _           1255    18498 G   f_guardado_session(integer, character varying, character varying, text)    FUNCTION     ?  CREATE FUNCTION security.f_guardado_session(_user_id integer, _ip character varying, _mac character varying, _session text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		INSERT INTO security.autenication
		(
			user_id,
			ip,
			mac,
			fecha_inicio,
			session
		)
	VALUES 
		(
			_user_id,
			_ip,
			_mac,
			current_timestamp,
			_session
		);


		
		
	END

$$;
 {   DROP FUNCTION security.f_guardado_session(_user_id integer, _ip character varying, _mac character varying, _session text);
       security          postgres    false    8            `           1255    18499    f_log_auditoria()    FUNCTION     ?  CREATE FUNCTION security.f_log_auditoria() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	 DECLARE
		_pk TEXT :='';		-- Representa la llave primaria de la tabla que esta siedno modificada.
		_sql TEXT;		-- Variable para la creacion del procedured.
		_column_guia RECORD; 	-- Variable para el FOR guarda los nombre de las columnas.
		_column_key RECORD; 	-- Variable para el FOR guarda los PK de las columnas.
		_session TEXT;	-- Almacena el usuario que genera el cambio.
		_user_db TEXT;		-- Almacena el usuario de bd que genera la transaccion.
		_control INT;		-- Variabel de control par alas llaves primarias.
		_count_key INT = 0;	-- Cantidad de columnas pertenecientes al PK.
		_sql_insert TEXT;	-- Variable para la construcción del insert del json de forma dinamica.
		_sql_delete TEXT;	-- Variable para la construcción del delete del json de forma dinamica.
		_sql_update TEXT;	-- Variable para la construcción del update del json de forma dinamica.
		_new_data RECORD; 	-- Fila que representa los campos nuevos del registro.
		_old_data RECORD;	-- Fila que representa los campos viejos del registro.

	BEGIN

			-- Se genera la evaluacion para determianr el tipo de accion sobre la tabla
		 IF (TG_OP = 'INSERT') THEN
			_new_data := NEW;
			_old_data := NEW;
		ELSEIF (TG_OP = 'UPDATE') THEN
			_new_data := NEW;
			_old_data := OLD;
		ELSE
			_new_data := OLD;
			_old_data := OLD;
		END IF;

		-- Se genera la evaluacion para determianr el tipo de accion sobre la tabla
		IF ((SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = TG_TABLE_SCHEMA AND table_name = TG_TABLE_NAME AND column_name = 'id' ) > 0) THEN
			_pk := _new_data.id;
		ELSE
			_pk := '-1';
		END IF;

		-- Se valida que exista el campo modified_by
		IF ((SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = TG_TABLE_SCHEMA AND table_name = TG_TABLE_NAME AND column_name = 'session') > 0) THEN
			_session := _new_data.session;
		ELSE
			_session := '';
		END IF;

		-- Se guarda el susuario de bd que genera la transaccion
		_user_db := (SELECT CURRENT_USER);

		-- Se evalua que exista el procedimeinto adecuado
		IF (SELECT COUNT(*) FROM security.function_db_view acfdv WHERE acfdv.b_function = 'field_audit' AND acfdv.b_type_parameters = TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME || ', '|| TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME || ', character varying, character varying, character varying, text, character varying, text, text') > 0
			THEN
				-- Se realiza la invocación del procedured generado dinamivamente
				PERFORM security.field_audit(_new_data, _old_data, TG_OP, _session, _user_db , _pk, ''::text);
		ELSE
			-- Se empieza la construcción del Procedured generico
			_sql := 'CREATE OR REPLACE FUNCTION security.field_audit( _data_new '|| TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME || ', _data_old '|| TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME || ', _accion character varying, _session text, _user_db character varying, _table_pk text, _init text)'
			|| ' RETURNS TEXT AS ''
'
			|| '
'
	|| '	DECLARE
'
	|| '		_column_data TEXT;
	 	_datos jsonb;
	 	
'
	|| '	BEGIN
			_datos = ''''{}'''';
';
			-- Se evalua si hay que actualizar la pk del registro de auditoria.
			IF _pk = '-1'
				THEN
					_sql := _sql
					|| '
		_column_data := ';

					-- Se genera el update con la clave pk de la tabla
					SELECT
						COUNT(isk.column_name)
					INTO
						_control
					FROM
						information_schema.table_constraints istc JOIN information_schema.key_column_usage isk ON isk.constraint_name = istc.constraint_name
					WHERE
						istc.table_schema = TG_TABLE_SCHEMA
					 AND	istc.table_name = TG_TABLE_NAME
					 AND	istc.constraint_type ilike '%primary%';

					-- Se agregan las columnas que componen la pk de la tabla.
					FOR _column_key IN SELECT
							isk.column_name
						FROM
							information_schema.table_constraints istc JOIN information_schema.key_column_usage isk ON isk.constraint_name = istc.constraint_name
						WHERE
							istc.table_schema = TG_TABLE_SCHEMA
						 AND	istc.table_name = TG_TABLE_NAME
						 AND	istc.constraint_type ilike '%primary%'
						ORDER BY 
							isk.ordinal_position  LOOP

						_sql := _sql || ' _data_new.' || _column_key.column_name;
						
						_count_key := _count_key + 1 ;
						
						IF _count_key < _control THEN
							_sql :=	_sql || ' || ' || ''''',''''' || ' ||';
						END IF;
					END LOOP;
				_sql := _sql || ';';
			END IF;

			_sql_insert:='
		IF _accion = ''''INSERT''''
			THEN
				';
			_sql_delete:='
		ELSEIF _accion = ''''DELETE''''
			THEN
				';
			_sql_update:='
		ELSE
			';

			-- Se genera el ciclo de agregado de columnas para el nuevo procedured
			FOR _column_guia IN SELECT column_name, data_type FROM information_schema.columns WHERE table_schema = TG_TABLE_SCHEMA AND table_name = TG_TABLE_NAME
				LOOP
						
					_sql_insert:= _sql_insert || '_datos := _datos || json_build_object('''''
					|| _column_guia.column_name
					|| '_nuevo'
					|| ''''', '
					|| '_data_new.'
					|| _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea', 'USER-DEFINED') THEN 
						_sql_insert:= _sql_insert
						||'::text';
					END IF;

					_sql_insert:= _sql_insert || ')::jsonb;
				';

					_sql_delete := _sql_delete || '_datos := _datos || json_build_object('''''
					|| _column_guia.column_name
					|| '_anterior'
					|| ''''', '
					|| '_data_old.'
					|| _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea', 'USER-DEFINED') THEN 
						_sql_delete:= _sql_delete
						||'::text';
					END IF;

					_sql_delete:= _sql_delete || ')::jsonb;
				';

					_sql_update := _sql_update || 'IF _data_old.' || _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea','USER-DEFINED') THEN 
						_sql_update:= _sql_update
						||'::text';
					END IF;

					_sql_update:= _sql_update || ' <> _data_new.' || _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea','USER-DEFINED') THEN 
						_sql_update:= _sql_update
						||'::text';
					END IF;

					_sql_update:= _sql_update || '
				THEN _datos := _datos || json_build_object('''''
					|| _column_guia.column_name
					|| '_anterior'
					|| ''''', '
					|| '_data_old.'
					|| _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea','USER-DEFINED') THEN 
						_sql_update:= _sql_update
						||'::text';
					END IF;

					_sql_update:= _sql_update
					|| ', '''''
					|| _column_guia.column_name
					|| '_nuevo'
					|| ''''', _data_new.'
					|| _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea', 'USER-DEFINED') THEN 
						_sql_update:= _sql_update
						||'::text';
					END IF;

					_sql_update:= _sql_update
					|| ')::jsonb;
			END IF;
			';
			END LOOP;

			-- Se le agrega la parte final del procedured generico
			
			_sql:= _sql || _sql_insert || _sql_delete || _sql_update
			|| ' 
		END IF;

		INSERT INTO security.auditoria
		(
			fecha,
			accion,
			schema,
			tabla,
			pk,
			session,
			user_bd,
			data
		)
		VALUES
		(
			CURRENT_TIMESTAMP,
			_accion,
			''''' || TG_TABLE_SCHEMA || ''''',
			''''' || TG_TABLE_NAME || ''''',
			_table_pk,
			_session,
			_user_db,
			_datos::jsonb
			);

		RETURN NULL; 
	END;'''
|| '
LANGUAGE plpgsql;';

			-- Se genera la ejecución de _sql, es decir se crea el nuevo procedured de forma generica.
			EXECUTE _sql;

		-- Se realiza la invocación del procedured generado dinamivamente
			PERFORM security.field_audit(_new_data, _old_data, TG_OP::character varying, _session, _user_db, _pk, ''::text);

		END IF;

		RETURN NULL;

END;
$$;
 *   DROP FUNCTION security.f_log_auditoria();
       security          postgres    false    8            ?            1259    18501    autenticate_view    VIEW     e   CREATE VIEW security.autenticate_view AS
 SELECT 0 AS user_id,
    ''::text AS nombre,
    0 AS rol;
 %   DROP VIEW security.autenticate_view;
       security          postgres    false    8            a           1255    18505    f_loggin(text, text)    FUNCTION       CREATE FUNCTION security.f_loggin(_correo text, _contrasena text) RETURNS SETOF security.autenticate_view
    LANGUAGE plpgsql
    AS $$

		DECLARE
		_user_id INTEGER;
		_nombre text;
        _rol INTEGER;

	BEGIN

		IF (SELECT COUNT(*) FROM usuario.usuario WHERE correo = _correo AND contrasena = _contrasena AND estado = 1) > 0
			THEN
				SELECT
					id,
					nombre,
					id_rol
				INTO
					_user_id,
					_nombre,
					_rol
				FROM
					usuario.usuario 
				WHERE
					correo = _correo AND contrasena = contrasena
				 AND	estado = 1;
					
				RETURN QUERY 
					SELECT
						_user_id,
						_nombre,
						_rol;
		ELSE
			RETURN QUERY
				SELECT
					-1::INTEGER,
					''::TEXT,
				-1::INTEGER;
		END IF;
		
	END

$$;
 A   DROP FUNCTION security.f_loggin(_correo text, _contrasena text);
       security          postgres    false    228    8            ?            1259    18506    alerta    TABLE     ?   CREATE TABLE reserva.alerta (
    descripcion text,
    session text,
    last_modified timestamp without time zone,
    id integer NOT NULL
);
    DROP TABLE reserva.alerta;
       reserva         heap    postgres    false    3            ?           0    0    TABLE alerta    COMMENT     ?   COMMENT ON TABLE reserva.alerta IS 'Describe la alerta que una reserva puede llegar a tener como, cancelacion de un servicio, inasistencia del estilista o asistencia del cliente
';
          reserva          postgres    false    229            ?           0    0    COLUMN alerta.descripcion    COMMENT     ?   COMMENT ON COLUMN reserva.alerta.descripcion IS 'Describe si una reserva tiene alertas como: 
-no asistió el cliente
-cancelacion de un servicio
-inasistencia del estilista
';
          reserva          postgres    false    229            ?           0    0    COLUMN alerta.id    COMMENT     @   COMMENT ON COLUMN reserva.alerta.id IS 'pk de la tabla alerta';
          reserva          postgres    false    229            b           1255    18512 c   field_audit(reserva.alerta, reserva.alerta, character varying, text, character varying, text, text)    FUNCTION     ?  CREATE FUNCTION security.field_audit(_data_new reserva.alerta, _data_old reserva.alerta, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text) RETURNS text
    LANGUAGE plpgsql
    AS $$

	DECLARE
		_column_data TEXT;
	 	_datos jsonb;
	 	
	BEGIN
			_datos = '{}';

		IF _accion = 'INSERT'
			THEN
				_datos := _datos || json_build_object('descripcion_nuevo', _data_new.descripcion)::jsonb;
				_datos := _datos || json_build_object('session_nuevo', _data_new.session)::jsonb;
				_datos := _datos || json_build_object('last_modified_nuevo', _data_new.last_modified)::jsonb;
				_datos := _datos || json_build_object('id_nuevo', _data_new.id)::jsonb;
				
		ELSEIF _accion = 'DELETE'
			THEN
				_datos := _datos || json_build_object('descripcion_anterior', _data_old.descripcion)::jsonb;
				_datos := _datos || json_build_object('session_anterior', _data_old.session)::jsonb;
				_datos := _datos || json_build_object('last_modified_anterior', _data_old.last_modified)::jsonb;
				_datos := _datos || json_build_object('id_anterior', _data_old.id)::jsonb;
				
		ELSE
			IF _data_old.descripcion <> _data_new.descripcion
				THEN _datos := _datos || json_build_object('descripcion_anterior', _data_old.descripcion, 'descripcion_nuevo', _data_new.descripcion)::jsonb;
			END IF;
			IF _data_old.session <> _data_new.session
				THEN _datos := _datos || json_build_object('session_anterior', _data_old.session, 'session_nuevo', _data_new.session)::jsonb;
			END IF;
			IF _data_old.last_modified <> _data_new.last_modified
				THEN _datos := _datos || json_build_object('last_modified_anterior', _data_old.last_modified, 'last_modified_nuevo', _data_new.last_modified)::jsonb;
			END IF;
			IF _data_old.id <> _data_new.id
				THEN _datos := _datos || json_build_object('id_anterior', _data_old.id, 'id_nuevo', _data_new.id)::jsonb;
			END IF;
			 
		END IF;

		INSERT INTO security.auditoria
		(
			fecha,
			accion,
			schema,
			tabla,
			pk,
			session,
			user_bd,
			data
		)
		VALUES
		(
			CURRENT_TIMESTAMP,
			_accion,
			'reserva',
			'alerta',
			_table_pk,
			_session,
			_user_db,
			_datos::jsonb
			);

		RETURN NULL; 
	END;$$;
 ?   DROP FUNCTION security.field_audit(_data_new reserva.alerta, _data_old reserva.alerta, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text);
       security          postgres    false    8    229    229            c           1255    18513 e   field_audit(reserva.reserva, reserva.reserva, character varying, text, character varying, text, text)    FUNCTION     k  CREATE FUNCTION security.field_audit(_data_new reserva.reserva, _data_old reserva.reserva, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text) RETURNS text
    LANGUAGE plpgsql
    AS $$

	DECLARE
		_column_data TEXT;
	 	_datos jsonb;
	 	
	BEGIN
			_datos = '{}';

		IF _accion = 'INSERT'
			THEN
				_datos := _datos || json_build_object('id_nuevo', _data_new.id)::jsonb;
				_datos := _datos || json_build_object('id_servicio_nuevo', _data_new.id_servicio)::jsonb;
				_datos := _datos || json_build_object('id_estilista_nuevo', _data_new.id_estilista)::jsonb;
				_datos := _datos || json_build_object('id_alerta_nuevo', _data_new.id_alerta)::jsonb;
				_datos := _datos || json_build_object('id_usuario_nuevo', _data_new.id_usuario)::jsonb;
				_datos := _datos || json_build_object('session_nuevo', _data_new.session)::jsonb;
				_datos := _datos || json_build_object('last_modified_nuevo', _data_new.last_modified)::jsonb;
				_datos := _datos || json_build_object('dia_hora_inicio_nuevo', _data_new.dia_hora_inicio)::jsonb;
				_datos := _datos || json_build_object('dia_hora_final_nuevo', _data_new.dia_hora_final)::jsonb;
				_datos := _datos || json_build_object('precio_nuevo', _data_new.precio)::jsonb;
				_datos := _datos || json_build_object('registro_nuevo', _data_new.registro)::jsonb;
				_datos := _datos || json_build_object('confirmacion_nuevo', _data_new.confirmacion)::jsonb;
				
		ELSEIF _accion = 'DELETE'
			THEN
				_datos := _datos || json_build_object('id_anterior', _data_old.id)::jsonb;
				_datos := _datos || json_build_object('id_servicio_anterior', _data_old.id_servicio)::jsonb;
				_datos := _datos || json_build_object('id_estilista_anterior', _data_old.id_estilista)::jsonb;
				_datos := _datos || json_build_object('id_alerta_anterior', _data_old.id_alerta)::jsonb;
				_datos := _datos || json_build_object('id_usuario_anterior', _data_old.id_usuario)::jsonb;
				_datos := _datos || json_build_object('session_anterior', _data_old.session)::jsonb;
				_datos := _datos || json_build_object('last_modified_anterior', _data_old.last_modified)::jsonb;
				_datos := _datos || json_build_object('dia_hora_inicio_anterior', _data_old.dia_hora_inicio)::jsonb;
				_datos := _datos || json_build_object('dia_hora_final_anterior', _data_old.dia_hora_final)::jsonb;
				_datos := _datos || json_build_object('precio_anterior', _data_old.precio)::jsonb;
				_datos := _datos || json_build_object('registro_anterior', _data_old.registro)::jsonb;
				_datos := _datos || json_build_object('confirmacion_anterior', _data_old.confirmacion)::jsonb;
				
		ELSE
			IF _data_old.id <> _data_new.id
				THEN _datos := _datos || json_build_object('id_anterior', _data_old.id, 'id_nuevo', _data_new.id)::jsonb;
			END IF;
			IF _data_old.id_servicio <> _data_new.id_servicio
				THEN _datos := _datos || json_build_object('id_servicio_anterior', _data_old.id_servicio, 'id_servicio_nuevo', _data_new.id_servicio)::jsonb;
			END IF;
			IF _data_old.id_estilista <> _data_new.id_estilista
				THEN _datos := _datos || json_build_object('id_estilista_anterior', _data_old.id_estilista, 'id_estilista_nuevo', _data_new.id_estilista)::jsonb;
			END IF;
			IF _data_old.id_alerta <> _data_new.id_alerta
				THEN _datos := _datos || json_build_object('id_alerta_anterior', _data_old.id_alerta, 'id_alerta_nuevo', _data_new.id_alerta)::jsonb;
			END IF;
			IF _data_old.id_usuario <> _data_new.id_usuario
				THEN _datos := _datos || json_build_object('id_usuario_anterior', _data_old.id_usuario, 'id_usuario_nuevo', _data_new.id_usuario)::jsonb;
			END IF;
			IF _data_old.session <> _data_new.session
				THEN _datos := _datos || json_build_object('session_anterior', _data_old.session, 'session_nuevo', _data_new.session)::jsonb;
			END IF;
			IF _data_old.last_modified <> _data_new.last_modified
				THEN _datos := _datos || json_build_object('last_modified_anterior', _data_old.last_modified, 'last_modified_nuevo', _data_new.last_modified)::jsonb;
			END IF;
			IF _data_old.dia_hora_inicio <> _data_new.dia_hora_inicio
				THEN _datos := _datos || json_build_object('dia_hora_inicio_anterior', _data_old.dia_hora_inicio, 'dia_hora_inicio_nuevo', _data_new.dia_hora_inicio)::jsonb;
			END IF;
			IF _data_old.dia_hora_final <> _data_new.dia_hora_final
				THEN _datos := _datos || json_build_object('dia_hora_final_anterior', _data_old.dia_hora_final, 'dia_hora_final_nuevo', _data_new.dia_hora_final)::jsonb;
			END IF;
			IF _data_old.precio <> _data_new.precio
				THEN _datos := _datos || json_build_object('precio_anterior', _data_old.precio, 'precio_nuevo', _data_new.precio)::jsonb;
			END IF;
			IF _data_old.registro <> _data_new.registro
				THEN _datos := _datos || json_build_object('registro_anterior', _data_old.registro, 'registro_nuevo', _data_new.registro)::jsonb;
			END IF;
			IF _data_old.confirmacion <> _data_new.confirmacion
				THEN _datos := _datos || json_build_object('confirmacion_anterior', _data_old.confirmacion, 'confirmacion_nuevo', _data_new.confirmacion)::jsonb;
			END IF;
			 
		END IF;

		INSERT INTO security.auditoria
		(
			fecha,
			accion,
			schema,
			tabla,
			pk,
			session,
			user_bd,
			data
		)
		VALUES
		(
			CURRENT_TIMESTAMP,
			_accion,
			'reserva',
			'reserva',
			_table_pk,
			_session,
			_user_db,
			_datos::jsonb
			);

		RETURN NULL; 
	END;$$;
 ?   DROP FUNCTION security.field_audit(_data_new reserva.reserva, _data_old reserva.reserva, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text);
       security          postgres    false    8    208    208            ?            1259    18514    catalogo    TABLE     ?   CREATE TABLE usuario.catalogo (
    id integer NOT NULL,
    imagen text,
    id_usuario integer,
    session text,
    last_modified timestamp without time zone
);
    DROP TABLE usuario.catalogo;
       usuario         heap    postgres    false    9            ?           0    0    TABLE catalogo    COMMENT     h   COMMENT ON TABLE usuario.catalogo IS 'Se almacenaran las imagenes de los catalogos de los estilistas.';
          usuario          postgres    false    230            ?           0    0    COLUMN catalogo.id    COMMENT     I   COMMENT ON COLUMN usuario.catalogo.id IS 'identificador de la imagen 
';
          usuario          postgres    false    230            ?           0    0    COLUMN catalogo.imagen    COMMENT     C   COMMENT ON COLUMN usuario.catalogo.imagen IS 'url de la imagen 
';
          usuario          postgres    false    230            ?           0    0    COLUMN catalogo.id_usuario    COMMENT     r   COMMENT ON COLUMN usuario.catalogo.id_usuario IS 'Identificador del estilista, al cual le pertenece la imagen 
';
          usuario          postgres    false    230            d           1255    18520 g   field_audit(usuario.catalogo, usuario.catalogo, character varying, text, character varying, text, text)    FUNCTION     ,
  CREATE FUNCTION security.field_audit(_data_new usuario.catalogo, _data_old usuario.catalogo, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text) RETURNS text
    LANGUAGE plpgsql
    AS $$

	DECLARE
		_column_data TEXT;
	 	_datos jsonb;
	 	
	BEGIN
			_datos = '{}';

		IF _accion = 'INSERT'
			THEN
				_datos := _datos || json_build_object('id_nuevo', _data_new.id)::jsonb;
				_datos := _datos || json_build_object('imagen_nuevo', _data_new.imagen)::jsonb;
				_datos := _datos || json_build_object('id_usuario_nuevo', _data_new.id_usuario)::jsonb;
				_datos := _datos || json_build_object('session_nuevo', _data_new.session)::jsonb;
				_datos := _datos || json_build_object('last_modified_nuevo', _data_new.last_modified)::jsonb;
				
		ELSEIF _accion = 'DELETE'
			THEN
				_datos := _datos || json_build_object('id_anterior', _data_old.id)::jsonb;
				_datos := _datos || json_build_object('imagen_anterior', _data_old.imagen)::jsonb;
				_datos := _datos || json_build_object('id_usuario_anterior', _data_old.id_usuario)::jsonb;
				_datos := _datos || json_build_object('session_anterior', _data_old.session)::jsonb;
				_datos := _datos || json_build_object('last_modified_anterior', _data_old.last_modified)::jsonb;
				
		ELSE
			IF _data_old.id <> _data_new.id
				THEN _datos := _datos || json_build_object('id_anterior', _data_old.id, 'id_nuevo', _data_new.id)::jsonb;
			END IF;
			IF _data_old.imagen <> _data_new.imagen
				THEN _datos := _datos || json_build_object('imagen_anterior', _data_old.imagen, 'imagen_nuevo', _data_new.imagen)::jsonb;
			END IF;
			IF _data_old.id_usuario <> _data_new.id_usuario
				THEN _datos := _datos || json_build_object('id_usuario_anterior', _data_old.id_usuario, 'id_usuario_nuevo', _data_new.id_usuario)::jsonb;
			END IF;
			IF _data_old.session <> _data_new.session
				THEN _datos := _datos || json_build_object('session_anterior', _data_old.session, 'session_nuevo', _data_new.session)::jsonb;
			END IF;
			IF _data_old.last_modified <> _data_new.last_modified
				THEN _datos := _datos || json_build_object('last_modified_anterior', _data_old.last_modified, 'last_modified_nuevo', _data_new.last_modified)::jsonb;
			END IF;
			 
		END IF;

		INSERT INTO security.auditoria
		(
			fecha,
			accion,
			schema,
			tabla,
			pk,
			session,
			user_bd,
			data
		)
		VALUES
		(
			CURRENT_TIMESTAMP,
			_accion,
			'usuario',
			'catalogo',
			_table_pk,
			_session,
			_user_db,
			_datos::jsonb
			);

		RETURN NULL; 
	END;$$;
 ?   DROP FUNCTION security.field_audit(_data_new usuario.catalogo, _data_old usuario.catalogo, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text);
       security          postgres    false    230    8    230            ?            1259    18521    rol    TABLE     ?   CREATE TABLE usuario.rol (
    id integer NOT NULL,
    descripcion text,
    session text,
    last_modified timestamp without time zone
);
    DROP TABLE usuario.rol;
       usuario         heap    postgres    false    9            ?           0    0 	   TABLE rol    COMMENT     z   COMMENT ON TABLE usuario.rol IS 'Tabla donde se va a almacenar, la identificación de rol y cual nombre tiene ese rol.
';
          usuario          postgres    false    231            ?           0    0    COLUMN rol.id    COMMENT     G   COMMENT ON COLUMN usuario.rol.id IS 'Identificacion de la tabla rol ';
          usuario          postgres    false    231            ?           0    0    COLUMN rol.descripcion    COMMENT     ?   COMMENT ON COLUMN usuario.rol.descripcion IS 'Almacena el nombre del rol :

-administrador(1)
-estilista (2)
-cliente (3)
-cliente sin registro (4)
';
          usuario          postgres    false    231            e           1255    18527 ]   field_audit(usuario.rol, usuario.rol, character varying, text, character varying, text, text)    FUNCTION     ?  CREATE FUNCTION security.field_audit(_data_new usuario.rol, _data_old usuario.rol, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text) RETURNS text
    LANGUAGE plpgsql
    AS $$

	DECLARE
		_column_data TEXT;
	 	_datos jsonb;
	 	
	BEGIN
			_datos = '{}';

		IF _accion = 'INSERT'
			THEN
				_datos := _datos || json_build_object('id_nuevo', _data_new.id)::jsonb;
				_datos := _datos || json_build_object('descripcion_nuevo', _data_new.descripcion)::jsonb;
				_datos := _datos || json_build_object('session_nuevo', _data_new.session)::jsonb;
				_datos := _datos || json_build_object('last_modified_nuevo', _data_new.last_modified)::jsonb;
				
		ELSEIF _accion = 'DELETE'
			THEN
				_datos := _datos || json_build_object('id_anterior', _data_old.id)::jsonb;
				_datos := _datos || json_build_object('descripcion_anterior', _data_old.descripcion)::jsonb;
				_datos := _datos || json_build_object('session_anterior', _data_old.session)::jsonb;
				_datos := _datos || json_build_object('last_modified_anterior', _data_old.last_modified)::jsonb;
				
		ELSE
			IF _data_old.id <> _data_new.id
				THEN _datos := _datos || json_build_object('id_anterior', _data_old.id, 'id_nuevo', _data_new.id)::jsonb;
			END IF;
			IF _data_old.descripcion <> _data_new.descripcion
				THEN _datos := _datos || json_build_object('descripcion_anterior', _data_old.descripcion, 'descripcion_nuevo', _data_new.descripcion)::jsonb;
			END IF;
			IF _data_old.session <> _data_new.session
				THEN _datos := _datos || json_build_object('session_anterior', _data_old.session, 'session_nuevo', _data_new.session)::jsonb;
			END IF;
			IF _data_old.last_modified <> _data_new.last_modified
				THEN _datos := _datos || json_build_object('last_modified_anterior', _data_old.last_modified, 'last_modified_nuevo', _data_new.last_modified)::jsonb;
			END IF;
			 
		END IF;

		INSERT INTO security.auditoria
		(
			fecha,
			accion,
			schema,
			tabla,
			pk,
			session,
			user_bd,
			data
		)
		VALUES
		(
			CURRENT_TIMESTAMP,
			_accion,
			'usuario',
			'rol',
			_table_pk,
			_session,
			_user_db,
			_datos::jsonb
			);

		RETURN NULL; 
	END;$$;
 ?   DROP FUNCTION security.field_audit(_data_new usuario.rol, _data_old usuario.rol, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text);
       security          postgres    false    231    231    8            ?            1259    18528    servicio    TABLE     ?   CREATE TABLE usuario.servicio (
    nombre text,
    descripcion text,
    precio integer,
    session text,
    last_modified timestamp without time zone,
    id integer NOT NULL,
    duracion time without time zone,
    estado text
);
    DROP TABLE usuario.servicio;
       usuario         heap    postgres    false    9            ?           0    0    TABLE servicio    COMMENT     q   COMMENT ON TABLE usuario.servicio IS 'Servicios que ofrece el salon de belleza (uñas, tientes , cortes , etc)';
          usuario          postgres    false    232            ?           0    0    COLUMN servicio.nombre    COMMENT     D   COMMENT ON COLUMN usuario.servicio.nombre IS 'Nombre del servicio';
          usuario          postgres    false    232            ?           0    0    COLUMN servicio.descripcion    COMMENT     ^   COMMENT ON COLUMN usuario.servicio.descripcion IS ' Describe que es lo que hace el servicio';
          usuario          postgres    false    232            ?           0    0    COLUMN servicio.precio    COMMENT     D   COMMENT ON COLUMN usuario.servicio.precio IS 'Precio del servicio';
          usuario          postgres    false    232            ?           0    0    COLUMN servicio.id    COMMENT     C   COMMENT ON COLUMN usuario.servicio.id IS 'Identifica al servicio';
          usuario          postgres    false    232            ?           0    0    COLUMN servicio.duracion    COMMENT     f   COMMENT ON COLUMN usuario.servicio.duracion IS 'Tiempo en el que dura la realizacion de un servicio';
          usuario          postgres    false    232            ?           0    0    COLUMN servicio.estado    COMMENT     j   COMMENT ON COLUMN usuario.servicio.estado IS 'Identifica si un servicio estaDisponible o No disponible.';
          usuario          postgres    false    232            i           1255    18534 g   field_audit(usuario.servicio, usuario.servicio, character varying, text, character varying, text, text)    FUNCTION     v  CREATE FUNCTION security.field_audit(_data_new usuario.servicio, _data_old usuario.servicio, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text) RETURNS text
    LANGUAGE plpgsql
    AS $$

	DECLARE
		_column_data TEXT;
	 	_datos jsonb;
	 	
	BEGIN
			_datos = '{}';

		IF _accion = 'INSERT'
			THEN
				_datos := _datos || json_build_object('nombre_nuevo', _data_new.nombre)::jsonb;
				_datos := _datos || json_build_object('descripcion_nuevo', _data_new.descripcion)::jsonb;
				_datos := _datos || json_build_object('precio_nuevo', _data_new.precio)::jsonb;
				_datos := _datos || json_build_object('session_nuevo', _data_new.session)::jsonb;
				_datos := _datos || json_build_object('last_modified_nuevo', _data_new.last_modified)::jsonb;
				_datos := _datos || json_build_object('id_nuevo', _data_new.id)::jsonb;
				_datos := _datos || json_build_object('duracion_nuevo', _data_new.duracion)::jsonb;
				_datos := _datos || json_build_object('estado_nuevo', _data_new.estado)::jsonb;
				
		ELSEIF _accion = 'DELETE'
			THEN
				_datos := _datos || json_build_object('nombre_anterior', _data_old.nombre)::jsonb;
				_datos := _datos || json_build_object('descripcion_anterior', _data_old.descripcion)::jsonb;
				_datos := _datos || json_build_object('precio_anterior', _data_old.precio)::jsonb;
				_datos := _datos || json_build_object('session_anterior', _data_old.session)::jsonb;
				_datos := _datos || json_build_object('last_modified_anterior', _data_old.last_modified)::jsonb;
				_datos := _datos || json_build_object('id_anterior', _data_old.id)::jsonb;
				_datos := _datos || json_build_object('duracion_anterior', _data_old.duracion)::jsonb;
				_datos := _datos || json_build_object('estado_anterior', _data_old.estado)::jsonb;
				
		ELSE
			IF _data_old.nombre <> _data_new.nombre
				THEN _datos := _datos || json_build_object('nombre_anterior', _data_old.nombre, 'nombre_nuevo', _data_new.nombre)::jsonb;
			END IF;
			IF _data_old.descripcion <> _data_new.descripcion
				THEN _datos := _datos || json_build_object('descripcion_anterior', _data_old.descripcion, 'descripcion_nuevo', _data_new.descripcion)::jsonb;
			END IF;
			IF _data_old.precio <> _data_new.precio
				THEN _datos := _datos || json_build_object('precio_anterior', _data_old.precio, 'precio_nuevo', _data_new.precio)::jsonb;
			END IF;
			IF _data_old.session <> _data_new.session
				THEN _datos := _datos || json_build_object('session_anterior', _data_old.session, 'session_nuevo', _data_new.session)::jsonb;
			END IF;
			IF _data_old.last_modified <> _data_new.last_modified
				THEN _datos := _datos || json_build_object('last_modified_anterior', _data_old.last_modified, 'last_modified_nuevo', _data_new.last_modified)::jsonb;
			END IF;
			IF _data_old.id <> _data_new.id
				THEN _datos := _datos || json_build_object('id_anterior', _data_old.id, 'id_nuevo', _data_new.id)::jsonb;
			END IF;
			IF _data_old.duracion <> _data_new.duracion
				THEN _datos := _datos || json_build_object('duracion_anterior', _data_old.duracion, 'duracion_nuevo', _data_new.duracion)::jsonb;
			END IF;
			IF _data_old.estado <> _data_new.estado
				THEN _datos := _datos || json_build_object('estado_anterior', _data_old.estado, 'estado_nuevo', _data_new.estado)::jsonb;
			END IF;
			 
		END IF;

		INSERT INTO security.auditoria
		(
			fecha,
			accion,
			schema,
			tabla,
			pk,
			session,
			user_bd,
			data
		)
		VALUES
		(
			CURRENT_TIMESTAMP,
			_accion,
			'usuario',
			'servicio',
			_table_pk,
			_session,
			_user_db,
			_datos::jsonb
			);

		RETURN NULL; 
	END;$$;
 ?   DROP FUNCTION security.field_audit(_data_new usuario.servicio, _data_old usuario.servicio, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text);
       security          postgres    false    232    8    232            ?            1259    18535    token_repureacion_usuario    TABLE     ?   CREATE TABLE usuario.token_repureacion_usuario (
    id integer NOT NULL,
    user_id integer NOT NULL,
    token text,
    fecha_creado timestamp without time zone,
    fecha_vigencia timestamp without time zone
);
 .   DROP TABLE usuario.token_repureacion_usuario;
       usuario         heap    postgres    false    9            ?           0    0    TABLE token_repureacion_usuario    COMMENT     r   COMMENT ON TABLE usuario.token_repureacion_usuario IS 'Tabla que almacena los token de recuperación de usuario';
          usuario          postgres    false    233            ?           0    0 #   COLUMN token_repureacion_usuario.id    COMMENT     L   COMMENT ON COLUMN usuario.token_repureacion_usuario.id IS 'Id de la tabla';
          usuario          postgres    false    233            ?           0    0 -   COLUMN token_repureacion_usuario.fecha_creado    COMMENT     e   COMMENT ON COLUMN usuario.token_repureacion_usuario.fecha_creado IS 'Fecha de creación del tokecn';
          usuario          postgres    false    233            f           1255    18541 ?   field_audit(usuario.token_repureacion_usuario, usuario.token_repureacion_usuario, character varying, text, character varying, text, text)    FUNCTION     s
  CREATE FUNCTION security.field_audit(_data_new usuario.token_repureacion_usuario, _data_old usuario.token_repureacion_usuario, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text) RETURNS text
    LANGUAGE plpgsql
    AS $$

	DECLARE
		_column_data TEXT;
	 	_datos jsonb;
	 	
	BEGIN
			_datos = '{}';

		IF _accion = 'INSERT'
			THEN
				_datos := _datos || json_build_object('id_nuevo', _data_new.id)::jsonb;
				_datos := _datos || json_build_object('user_id_nuevo', _data_new.user_id)::jsonb;
				_datos := _datos || json_build_object('token_nuevo', _data_new.token)::jsonb;
				_datos := _datos || json_build_object('fecha_creado_nuevo', _data_new.fecha_creado)::jsonb;
				_datos := _datos || json_build_object('fecha_vigencia_nuevo', _data_new.fecha_vigencia)::jsonb;
				
		ELSEIF _accion = 'DELETE'
			THEN
				_datos := _datos || json_build_object('id_anterior', _data_old.id)::jsonb;
				_datos := _datos || json_build_object('user_id_anterior', _data_old.user_id)::jsonb;
				_datos := _datos || json_build_object('token_anterior', _data_old.token)::jsonb;
				_datos := _datos || json_build_object('fecha_creado_anterior', _data_old.fecha_creado)::jsonb;
				_datos := _datos || json_build_object('fecha_vigencia_anterior', _data_old.fecha_vigencia)::jsonb;
				
		ELSE
			IF _data_old.id <> _data_new.id
				THEN _datos := _datos || json_build_object('id_anterior', _data_old.id, 'id_nuevo', _data_new.id)::jsonb;
			END IF;
			IF _data_old.user_id <> _data_new.user_id
				THEN _datos := _datos || json_build_object('user_id_anterior', _data_old.user_id, 'user_id_nuevo', _data_new.user_id)::jsonb;
			END IF;
			IF _data_old.token <> _data_new.token
				THEN _datos := _datos || json_build_object('token_anterior', _data_old.token, 'token_nuevo', _data_new.token)::jsonb;
			END IF;
			IF _data_old.fecha_creado <> _data_new.fecha_creado
				THEN _datos := _datos || json_build_object('fecha_creado_anterior', _data_old.fecha_creado, 'fecha_creado_nuevo', _data_new.fecha_creado)::jsonb;
			END IF;
			IF _data_old.fecha_vigencia <> _data_new.fecha_vigencia
				THEN _datos := _datos || json_build_object('fecha_vigencia_anterior', _data_old.fecha_vigencia, 'fecha_vigencia_nuevo', _data_new.fecha_vigencia)::jsonb;
			END IF;
			 
		END IF;

		INSERT INTO security.auditoria
		(
			fecha,
			accion,
			schema,
			tabla,
			pk,
			session,
			user_bd,
			data
		)
		VALUES
		(
			CURRENT_TIMESTAMP,
			_accion,
			'usuario',
			'token_repureacion_usuario',
			_table_pk,
			_session,
			_user_db,
			_datos::jsonb
			);

		RETURN NULL; 
	END;$$;
 ?   DROP FUNCTION security.field_audit(_data_new usuario.token_repureacion_usuario, _data_old usuario.token_repureacion_usuario, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text);
       security          postgres    false    8    233    233            ?            1259    18542    usuario    TABLE     I  CREATE TABLE usuario.usuario (
    id integer NOT NULL,
    nombre text,
    apellido text,
    telefono bigint,
    correo text,
    contrasena text,
    fecha_nacimiento date,
    estado integer,
    biografia text,
    imagen_perfil text,
    id_rol integer,
    session text,
    last_modified timestamp without time zone
);
    DROP TABLE usuario.usuario;
       usuario         heap    postgres    false    9            ?           0    0    COLUMN usuario.id    COMMENT     i   COMMENT ON COLUMN usuario.usuario.id IS 'Identificador del usuario el cual será la cedula de ciudania';
          usuario          postgres    false    234            ?           0    0    COLUMN usuario.nombre    COMMENT     B   COMMENT ON COLUMN usuario.usuario.nombre IS 'Nombre del usuario';
          usuario          postgres    false    234            ?           0    0    COLUMN usuario.apellido    COMMENT     G   COMMENT ON COLUMN usuario.usuario.apellido IS 'Apellido del usuario
';
          usuario          postgres    false    234            ?           0    0    COLUMN usuario.telefono    COMMENT     Q   COMMENT ON COLUMN usuario.usuario.telefono IS 'Telefono o celular del usuario
';
          usuario          postgres    false    234                        0    0    COLUMN usuario.correo    COMMENT     t   COMMENT ON COLUMN usuario.usuario.correo IS 'correo el cual sera el nickname para iniciar sesion en la plataforma';
          usuario          postgres    false    234                       0    0    COLUMN usuario.contrasena    COMMENT     b   COMMENT ON COLUMN usuario.usuario.contrasena IS 'Contraseña con la cual podra iniciar sesion. ';
          usuario          postgres    false    234                       0    0    COLUMN usuario.fecha_nacimiento    COMMENT     }   COMMENT ON COLUMN usuario.usuario.fecha_nacimiento IS 'fecha de nacimiento del cliente para confirmar si es mayor de edad ';
          usuario          postgres    false    234                       0    0    COLUMN usuario.estado    COMMENT     ?   COMMENT ON COLUMN usuario.usuario.estado IS 'Estado en el cual se encuentra la cuenta del usuario
-activa (1)
-inactiva (2) para estilistas , o si se encuentra en un token
-inactiva (3) para usuarios

';
          usuario          postgres    false    234                       0    0    COLUMN usuario.biografia    COMMENT     U   COMMENT ON COLUMN usuario.usuario.biografia IS 'Biografia para el perfil estilista';
          usuario          postgres    false    234                       0    0    COLUMN usuario.imagen_perfil    COMMENT     W   COMMENT ON COLUMN usuario.usuario.imagen_perfil IS 'Imagen del perfil del estilista
';
          usuario          postgres    false    234                       0    0    COLUMN usuario.id_rol    COMMENT     p   COMMENT ON COLUMN usuario.usuario.id_rol IS 'Identifica si un usuario es administrador, estilista o cliente

';
          usuario          postgres    false    234            ?           1255    18548 e   field_audit(usuario.usuario, usuario.usuario, character varying, text, character varying, text, text)    FUNCTION     9  CREATE FUNCTION security.field_audit(_data_new usuario.usuario, _data_old usuario.usuario, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text) RETURNS text
    LANGUAGE plpgsql
    AS $$

	DECLARE
		_column_data TEXT;
	 	_datos jsonb;
	 	
	BEGIN
			_datos = '{}';

		IF _accion = 'INSERT'
			THEN
				_datos := _datos || json_build_object('id_nuevo', _data_new.id)::jsonb;
				_datos := _datos || json_build_object('nombre_nuevo', _data_new.nombre)::jsonb;
				_datos := _datos || json_build_object('apellido_nuevo', _data_new.apellido)::jsonb;
				_datos := _datos || json_build_object('telefono_nuevo', _data_new.telefono)::jsonb;
				_datos := _datos || json_build_object('correo_nuevo', _data_new.correo)::jsonb;
				_datos := _datos || json_build_object('contrasena_nuevo', _data_new.contrasena)::jsonb;
				_datos := _datos || json_build_object('fecha_nacimiento_nuevo', _data_new.fecha_nacimiento)::jsonb;
				_datos := _datos || json_build_object('estado_nuevo', _data_new.estado)::jsonb;
				_datos := _datos || json_build_object('biografia_nuevo', _data_new.biografia)::jsonb;
				_datos := _datos || json_build_object('imagen_perfil_nuevo', _data_new.imagen_perfil)::jsonb;
				_datos := _datos || json_build_object('id_rol_nuevo', _data_new.id_rol)::jsonb;
				_datos := _datos || json_build_object('session_nuevo', _data_new.session)::jsonb;
				_datos := _datos || json_build_object('last_modified_nuevo', _data_new.last_modified)::jsonb;
				
		ELSEIF _accion = 'DELETE'
			THEN
				_datos := _datos || json_build_object('id_anterior', _data_old.id)::jsonb;
				_datos := _datos || json_build_object('nombre_anterior', _data_old.nombre)::jsonb;
				_datos := _datos || json_build_object('apellido_anterior', _data_old.apellido)::jsonb;
				_datos := _datos || json_build_object('telefono_anterior', _data_old.telefono)::jsonb;
				_datos := _datos || json_build_object('correo_anterior', _data_old.correo)::jsonb;
				_datos := _datos || json_build_object('contrasena_anterior', _data_old.contrasena)::jsonb;
				_datos := _datos || json_build_object('fecha_nacimiento_anterior', _data_old.fecha_nacimiento)::jsonb;
				_datos := _datos || json_build_object('estado_anterior', _data_old.estado)::jsonb;
				_datos := _datos || json_build_object('biografia_anterior', _data_old.biografia)::jsonb;
				_datos := _datos || json_build_object('imagen_perfil_anterior', _data_old.imagen_perfil)::jsonb;
				_datos := _datos || json_build_object('id_rol_anterior', _data_old.id_rol)::jsonb;
				_datos := _datos || json_build_object('session_anterior', _data_old.session)::jsonb;
				_datos := _datos || json_build_object('last_modified_anterior', _data_old.last_modified)::jsonb;
				
		ELSE
			IF _data_old.id <> _data_new.id
				THEN _datos := _datos || json_build_object('id_anterior', _data_old.id, 'id_nuevo', _data_new.id)::jsonb;
			END IF;
			IF _data_old.nombre <> _data_new.nombre
				THEN _datos := _datos || json_build_object('nombre_anterior', _data_old.nombre, 'nombre_nuevo', _data_new.nombre)::jsonb;
			END IF;
			IF _data_old.apellido <> _data_new.apellido
				THEN _datos := _datos || json_build_object('apellido_anterior', _data_old.apellido, 'apellido_nuevo', _data_new.apellido)::jsonb;
			END IF;
			IF _data_old.telefono <> _data_new.telefono
				THEN _datos := _datos || json_build_object('telefono_anterior', _data_old.telefono, 'telefono_nuevo', _data_new.telefono)::jsonb;
			END IF;
			IF _data_old.correo <> _data_new.correo
				THEN _datos := _datos || json_build_object('correo_anterior', _data_old.correo, 'correo_nuevo', _data_new.correo)::jsonb;
			END IF;
			IF _data_old.contrasena <> _data_new.contrasena
				THEN _datos := _datos || json_build_object('contrasena_anterior', _data_old.contrasena, 'contrasena_nuevo', _data_new.contrasena)::jsonb;
			END IF;
			IF _data_old.fecha_nacimiento <> _data_new.fecha_nacimiento
				THEN _datos := _datos || json_build_object('fecha_nacimiento_anterior', _data_old.fecha_nacimiento, 'fecha_nacimiento_nuevo', _data_new.fecha_nacimiento)::jsonb;
			END IF;
			IF _data_old.estado <> _data_new.estado
				THEN _datos := _datos || json_build_object('estado_anterior', _data_old.estado, 'estado_nuevo', _data_new.estado)::jsonb;
			END IF;
			IF _data_old.biografia <> _data_new.biografia
				THEN _datos := _datos || json_build_object('biografia_anterior', _data_old.biografia, 'biografia_nuevo', _data_new.biografia)::jsonb;
			END IF;
			IF _data_old.imagen_perfil <> _data_new.imagen_perfil
				THEN _datos := _datos || json_build_object('imagen_perfil_anterior', _data_old.imagen_perfil, 'imagen_perfil_nuevo', _data_new.imagen_perfil)::jsonb;
			END IF;
			IF _data_old.id_rol <> _data_new.id_rol
				THEN _datos := _datos || json_build_object('id_rol_anterior', _data_old.id_rol, 'id_rol_nuevo', _data_new.id_rol)::jsonb;
			END IF;
			IF _data_old.session <> _data_new.session
				THEN _datos := _datos || json_build_object('session_anterior', _data_old.session, 'session_nuevo', _data_new.session)::jsonb;
			END IF;
			IF _data_old.last_modified <> _data_new.last_modified
				THEN _datos := _datos || json_build_object('last_modified_anterior', _data_old.last_modified, 'last_modified_nuevo', _data_new.last_modified)::jsonb;
			END IF;
			 
		END IF;

		INSERT INTO security.auditoria
		(
			fecha,
			accion,
			schema,
			tabla,
			pk,
			session,
			user_bd,
			data
		)
		VALUES
		(
			CURRENT_TIMESTAMP,
			_accion,
			'usuario',
			'usuario',
			_table_pk,
			_session,
			_user_db,
			_datos::jsonb
			);

		RETURN NULL; 
	END;$$;
 ?   DROP FUNCTION security.field_audit(_data_new usuario.usuario, _data_old usuario.usuario, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text);
       security          postgres    false    8    234    234            ?            1259    18549    usuario_servicio    TABLE     ?   CREATE TABLE usuario.usuario_servicio (
    id_usuario integer NOT NULL,
    id_servicio integer NOT NULL,
    session text,
    last_modified timestamp with time zone,
    id integer NOT NULL
);
 %   DROP TABLE usuario.usuario_servicio;
       usuario         heap    postgres    false    9                       0    0    TABLE usuario_servicio    COMMENT     ?   COMMENT ON TABLE usuario.usuario_servicio IS 'Tabla para la creacion de la relacion muchos a muchos de entre estilista y servicios

';
          usuario          postgres    false    235                       0    0 "   COLUMN usuario_servicio.id_usuario    COMMENT     Y   COMMENT ON COLUMN usuario.usuario_servicio.id_usuario IS 'identificador del estilista ';
          usuario          postgres    false    235            	           0    0 #   COLUMN usuario_servicio.id_servicio    COMMENT     [   COMMENT ON COLUMN usuario.usuario_servicio.id_servicio IS 'identificador del servicio 
';
          usuario          postgres    false    235            g           1255    18555 w   field_audit(usuario.usuario_servicio, usuario.usuario_servicio, character varying, text, character varying, text, text)    FUNCTION     v
  CREATE FUNCTION security.field_audit(_data_new usuario.usuario_servicio, _data_old usuario.usuario_servicio, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text) RETURNS text
    LANGUAGE plpgsql
    AS $$

	DECLARE
		_column_data TEXT;
	 	_datos jsonb;
	 	
	BEGIN
			_datos = '{}';

		IF _accion = 'INSERT'
			THEN
				_datos := _datos || json_build_object('id_usuario_nuevo', _data_new.id_usuario)::jsonb;
				_datos := _datos || json_build_object('id_servicio_nuevo', _data_new.id_servicio)::jsonb;
				_datos := _datos || json_build_object('session_nuevo', _data_new.session)::jsonb;
				_datos := _datos || json_build_object('last_modified_nuevo', _data_new.last_modified)::jsonb;
				_datos := _datos || json_build_object('id_nuevo', _data_new.id)::jsonb;
				
		ELSEIF _accion = 'DELETE'
			THEN
				_datos := _datos || json_build_object('id_usuario_anterior', _data_old.id_usuario)::jsonb;
				_datos := _datos || json_build_object('id_servicio_anterior', _data_old.id_servicio)::jsonb;
				_datos := _datos || json_build_object('session_anterior', _data_old.session)::jsonb;
				_datos := _datos || json_build_object('last_modified_anterior', _data_old.last_modified)::jsonb;
				_datos := _datos || json_build_object('id_anterior', _data_old.id)::jsonb;
				
		ELSE
			IF _data_old.id_usuario <> _data_new.id_usuario
				THEN _datos := _datos || json_build_object('id_usuario_anterior', _data_old.id_usuario, 'id_usuario_nuevo', _data_new.id_usuario)::jsonb;
			END IF;
			IF _data_old.id_servicio <> _data_new.id_servicio
				THEN _datos := _datos || json_build_object('id_servicio_anterior', _data_old.id_servicio, 'id_servicio_nuevo', _data_new.id_servicio)::jsonb;
			END IF;
			IF _data_old.session <> _data_new.session
				THEN _datos := _datos || json_build_object('session_anterior', _data_old.session, 'session_nuevo', _data_new.session)::jsonb;
			END IF;
			IF _data_old.last_modified <> _data_new.last_modified
				THEN _datos := _datos || json_build_object('last_modified_anterior', _data_old.last_modified, 'last_modified_nuevo', _data_new.last_modified)::jsonb;
			END IF;
			IF _data_old.id <> _data_new.id
				THEN _datos := _datos || json_build_object('id_anterior', _data_old.id, 'id_nuevo', _data_new.id)::jsonb;
			END IF;
			 
		END IF;

		INSERT INTO security.auditoria
		(
			fecha,
			accion,
			schema,
			tabla,
			pk,
			session,
			user_bd,
			data
		)
		VALUES
		(
			CURRENT_TIMESTAMP,
			_accion,
			'usuario',
			'usuario_servicio',
			_table_pk,
			_session,
			_user_db,
			_datos::jsonb
			);

		RETURN NULL; 
	END;$$;
 ?   DROP FUNCTION security.field_audit(_data_new usuario.usuario_servicio, _data_old usuario.usuario_servicio, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text);
       security          postgres    false    235    235    8            j           1255    18556 0   actualizar_asistencia(integer, integer, integer)    FUNCTION     ?  CREATE FUNCTION usuario.actualizar_asistencia(_id_estilista integer, _id integer, _alerta integer) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	BEGIN

	      IF (_alerta= 4)   
	             THEN  
		    UPDATE 
			 reserva.reserva
	            SET 
			  id_alerta=4
	            WHERE 
			 reserva.reserva.id_estilista=_id_estilista AND reserva.reserva.id=_id AND reserva.reserva.id_alerta=0;
			 
	       ELSE 
                   UPDATE 
			 reserva.reserva
	            SET 
			  id_alerta=5
	            WHERE 
			 reserva.reserva.id_estilista=_id_estilista AND reserva.reserva.id=_id AND reserva.reserva.id_alerta=0;
			 
	       END IF;
		   

		end
$$;
 b   DROP FUNCTION usuario.actualizar_asistencia(_id_estilista integer, _id integer, _alerta integer);
       usuario          postgres    false    9            k           1255    18557 '   actualizar_inasistencia2(integer, date)    FUNCTION     ?  CREATE FUNCTION usuario.actualizar_inasistencia2(_id_estilista integer, _fecha date) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	BEGIN
			             
		    UPDATE 
			 reserva.reserva
	            SET 
			  id_alerta=1
	            WHERE 
			 reserva.reserva.id_estilista=_id_estilista AND reserva.reserva.dia_hora_inicio::date=_fecha::date AND reserva.reserva.id_alerta=0;
			 	

		end
$$;
 T   DROP FUNCTION usuario.actualizar_inasistencia2(_id_estilista integer, _fecha date);
       usuario          postgres    false    9            l           1255    18558 %   f_actualizar_biografia(integer, text)    FUNCTION     ?   CREATE FUNCTION usuario.f_actualizar_biografia(_user_id integer, _biografia text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		UPDATE
			usuario.usuario
		SET
			biografia = _biografia
		WHERE
			id = _user_id;
	END

$$;
 Q   DROP FUNCTION usuario.f_actualizar_biografia(_user_id integer, _biografia text);
       usuario          postgres    false    9            m           1255    18559 D   f_actualizar_cliente(integer, text, text, integer, text, date, text)    FUNCTION     ?  CREATE FUNCTION usuario.f_actualizar_cliente(_id integer, _nombre text, _apellido text, _telefono integer, _correo text, _fecha_nacimiento date, _session text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

		begin
     UPDATE 
     usuario.usuario
	SET 
	   nombre =_nombre,
	   apellido =_apellido,
	   telefono =_telefono,
	   correo = _correo,
	   fecha_nacimiento = _fecha_nacimiento,
	   session = _session,
	   last_modified = current_timestamp
	WHERE
	 id = _id;
        end 

$$;
 ?   DROP FUNCTION usuario.f_actualizar_cliente(_id integer, _nombre text, _apellido text, _telefono integer, _correo text, _fecha_nacimiento date, _session text);
       usuario          postgres    false    9            n           1255    18560 ?   f_actualizar_cliente2(integer, text, text, integer, text, text)    FUNCTION     ?  CREATE FUNCTION usuario.f_actualizar_cliente2(_id integer, _nombre text, _apellido text, _telefono integer, _correo text, _session text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

		begin
     UPDATE 
     usuario.usuario
	SET 
	   nombre =_nombre,
	   apellido =_apellido,
	   telefono =_telefono,
	   correo = _correo,
	   session = _session,
	   last_modified = current_timestamp
	WHERE
	 id = _id;
        end 

$$;
 ?   DROP FUNCTION usuario.f_actualizar_cliente2(_id integer, _nombre text, _apellido text, _telefono integer, _correo text, _session text);
       usuario          postgres    false    9            o           1255    18561 >   f_actualizar_cliente2(integer, text, text, bigint, text, text)    FUNCTION     ?  CREATE FUNCTION usuario.f_actualizar_cliente2(_id integer, _nombre text, _apellido text, _telefono bigint, _correo text, _session text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

		begin
     UPDATE 
     usuario.usuario
	SET 
	   nombre =_nombre,
	   apellido =_apellido,
	   telefono =_telefono,
	   correo = _correo,
	   session = _session,
	   last_modified = current_timestamp
	WHERE
	 id = _id;
        end 

$$;
 ?   DROP FUNCTION usuario.f_actualizar_cliente2(_id integer, _nombre text, _apellido text, _telefono bigint, _correo text, _session text);
       usuario          postgres    false    9            p           1255    18562 3   f_actualizar_contrasena(integer, character varying)    FUNCTION     w  CREATE FUNCTION usuario.f_actualizar_contrasena(_user_id integer, _contrasena character varying) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		DELETE FROM
			usuario.token_repureacion_usuario
		WHERE
			user_id = _user_id;
	
		UPDATE
			usuario.usuario
		SET
			estado = 1,
			contrasena = _contrasena
			
		WHERE
			id = _user_id;
	END

$$;
 `   DROP FUNCTION usuario.f_actualizar_contrasena(_user_id integer, _contrasena character varying);
       usuario          postgres    false    9            q           1255    18563 4   f_actualizar_contrasena2(integer, character varying)    FUNCTION     
  CREATE FUNCTION usuario.f_actualizar_contrasena2(_user_id integer, _contrasena character varying) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		UPDATE
			usuario.usuario
		SET
			contrasena = _contrasena
		WHERE
			id = _user_id;
	END

$$;
 a   DROP FUNCTION usuario.f_actualizar_contrasena2(_user_id integer, _contrasena character varying);
       usuario          postgres    false    9            r           1255    18564    f_actualizar_estado(integer)    FUNCTION     ?   CREATE FUNCTION usuario.f_actualizar_estado(_id integer) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

begin
		UPDATE usuario.servicio
		
		SET 
			estado=2

		 WHERE id =_id;
        end 

$$;
 8   DROP FUNCTION usuario.f_actualizar_estado(_id integer);
       usuario          postgres    false    9            s           1255    18565 I   f_actualizar_estilista(integer, text, text, integer, text, text, integer)    FUNCTION     ?  CREATE FUNCTION usuario.f_actualizar_estilista(_id integer, _nombre text, _apellido text, _telefono integer, _correo text, _contrasena text, _estado integer) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

		begin
     UPDATE 
     usuario.usuario
	SET 
	   nombre =_nombre,
	   apellido =_apellido,
	   telefono =_telefono,
	   correo = _correo,
	   contrasena=_contrasena,
	   estado=_estado
	WHERE
	 id = _id;

		   UPDATE 
			reserva.reserva
	            SET 
			id_alerta=3
	            FROM 
			 usuario.servicio,usuario.usuario
	            WHERE 
			 reserva.reserva.id_estilista=usuario.usuario.id AND reserva.reserva.id_servicio=usuario.servicio.id 
			 AND usuario.usuario.estado=2 AND reserva.reserva.dia_hora_inicio::date >current_timestamp AND reserva.reserva.id_alerta=0;

		   UPDATE 
			 reserva.reserva
	            SET 
			id_alerta=0
	            FROM 
			 usuario.servicio,usuario.usuario
	            WHERE 
			 reserva.reserva.id_estilista=usuario.usuario.id AND reserva.reserva.id_servicio=usuario.servicio.id
			 AND usuario.usuario.estado=1 AND reserva.reserva.id_alerta=3
			 AND reserva.reserva.dia_hora_inicio::date > current_timestamp;

			
        end 

$$;
 ?   DROP FUNCTION usuario.f_actualizar_estilista(_id integer, _nombre text, _apellido text, _telefono integer, _correo text, _contrasena text, _estado integer);
       usuario          postgres    false    9            t           1255    18566 &   f_actualizar_imagperfil(integer, text)    FUNCTION       CREATE FUNCTION usuario.f_actualizar_imagperfil(_user_id integer, _imagen_perfil text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		UPDATE
			usuario.usuario
		SET
			imagen_perfil = _imagen_perfil
		WHERE
			id = _user_id;
	END

$$;
 V   DROP FUNCTION usuario.f_actualizar_imagperfil(_user_id integer, _imagen_perfil text);
       usuario          postgres    false    9            u           1255    18567 9   f_actualizar_servicio(integer, text, text, integer, text)    FUNCTION     s  CREATE FUNCTION usuario.f_actualizar_servicio(_id integer, _nombre text, _descripcion text, _precio integer, _duracion text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

		begin
     UPDATE 
     usuario.servicio
	SET 
	  nombre=_nombre,
	  descripcion=_descripcion,
	  precio=_precio,
	  duracion=_duracion::time
	WHERE
	 id = _id;
        end 

$$;
 |   DROP FUNCTION usuario.f_actualizar_servicio(_id integer, _nombre text, _descripcion text, _precio integer, _duracion text);
       usuario          postgres    false    9            v           1255    18568 C   f_actualizar_servicio2(integer, text, text, integer, integer, text)    FUNCTION     ?  CREATE FUNCTION usuario.f_actualizar_servicio2(_id integer, _nombre text, _descripcion text, _precio integer, _estado integer, _duracion text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

		begin
     UPDATE 
     usuario.servicio
	SET 
	  nombre=_nombre,
	  descripcion=_descripcion,
	  precio=_precio,
	  estado = _estado,
	  duracion=_duracion::time
	WHERE
	 id = _id;
        end 

$$;
 ?   DROP FUNCTION usuario.f_actualizar_servicio2(_id integer, _nombre text, _descripcion text, _precio integer, _estado integer, _duracion text);
       usuario          postgres    false    9            w           1255    18569 @   f_actualizar_servicio2(integer, text, text, integer, text, text)    FUNCTION     ?  CREATE FUNCTION usuario.f_actualizar_servicio2(_id integer, _nombre text, _descripcion text, _precio integer, _estado text, _duracion text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

		begin
     UPDATE 
     usuario.servicio
	SET 
	  nombre=_nombre,
	  descripcion=_descripcion,
	  precio=_precio,
	  estado = _estado,
	  duracion=_duracion::time
	WHERE
	 id = _id;
        end 

$$;
 ?   DROP FUNCTION usuario.f_actualizar_servicio2(_id integer, _nombre text, _descripcion text, _precio integer, _estado text, _duracion text);
       usuario          postgres    false    9            h           1255    18570 F   f_actualizar_servicio_alerta(integer, text, text, integer, text, text)    FUNCTION     ?  CREATE FUNCTION usuario.f_actualizar_servicio_alerta(_id integer, _nombre text, _descripcion text, _precio integer, _estado text, _duracion text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

		begin
     UPDATE 
     usuario.servicio
	SET 
	  nombre=_nombre,
	  descripcion=_descripcion,
	  precio=_precio,
	  estado = _estado,
	  duracion=_duracion::time
	WHERE
	 id = _id;

	           UPDATE 
			 reserva.reserva
	            SET 
			       id_alerta=2 
	            FROM 
			 usuario.servicio
	            WHERE 
			 reserva.reserva.id_servicio=usuario.servicio.id AND usuario.servicio.estado='No disponible';
   
        end 

$$;
 ?   DROP FUNCTION usuario.f_actualizar_servicio_alerta(_id integer, _nombre text, _descripcion text, _precio integer, _estado text, _duracion text);
       usuario          postgres    false    9            y           1255    18571 M   f_actualizar_sinregistro(integer, text, text, bigint, text, text, date, text)    FUNCTION     C  CREATE FUNCTION usuario.f_actualizar_sinregistro(_id integer, _nombre text, _apellido text, _telefono bigint, _correo text, _contrasena text, _fecha_nacimiento date, _session text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

		begin
     UPDATE 
     usuario.usuario
	SET 
	   nombre =_nombre,
	   apellido =_apellido,
	   telefono =_telefono,
	   correo = _correo,
	   contrasena = _contrasena,
	   fecha_nacimiento = _fecha_nacimiento,
	   id_rol = 3,
	   session = _session,
	   last_modified = current_timestamp
	WHERE
	 id = _id;
        end 

$$;
 ?   DROP FUNCTION usuario.f_actualizar_sinregistro(_id integer, _nombre text, _apellido text, _telefono bigint, _correo text, _contrasena text, _fecha_nacimiento date, _session text);
       usuario          postgres    false    9            z           1255    18572     f_almacenar_token(text, integer)    FUNCTION     ?  CREATE FUNCTION usuario.f_almacenar_token(_token text, _user_id integer) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		INSERT INTO usuario.token_repureacion_usuario
		(
			user_id,
			token, 
			fecha_creado,
			fecha_vigencia
			
		)
		VALUES 
		(
			_user_id,
			_token,
			current_timestamp,
			current_timestamp + interval '2 hours'
		);

			
	END

$$;
 H   DROP FUNCTION usuario.f_almacenar_token(_token text, _user_id integer);
       usuario          postgres    false    9            {           1255    18573 M   f_cargar_clientesin(timestamp without time zone, timestamp without time zone)    FUNCTION     f  CREATE FUNCTION usuario.f_cargar_clientesin(_rango_inicio timestamp without time zone, _rango_final timestamp without time zone) RETURNS SETOF usuario.usuario
    LANGUAGE plpgsql
    AS $$
	begin
		return query
		
		SELECT
			*
		FROM
			usuario.usuario
		WHERE
			id_rol=4
		AND last_modified BETWEEN _rango_inicio AND _rango_final;
	end

$$;
 ?   DROP FUNCTION usuario.f_cargar_clientesin(_rango_inicio timestamp without time zone, _rango_final timestamp without time zone);
       usuario          postgres    false    234    9            ?            1259    18574 
   clientesin    VIEW     S   CREATE VIEW usuario.clientesin AS
 SELECT 0 AS id,
    ''::text AS nombre_cliente;
    DROP VIEW usuario.clientesin;
       usuario          postgres    false    9            |           1255    18578 N   f_cargar_clientesin2(timestamp without time zone, timestamp without time zone)    FUNCTION     w  CREATE FUNCTION usuario.f_cargar_clientesin2(_rango_inicio timestamp without time zone, _rango_final timestamp without time zone) RETURNS SETOF usuario.clientesin
    LANGUAGE plpgsql
    AS $$
	begin
		return query
		
		SELECT
			id,
			nombre
		FROM
			usuario.usuario
		WHERE
			id_rol=4
		AND last_modified BETWEEN _rango_inicio AND _rango_final;
	end

$$;
 ?   DROP FUNCTION usuario.f_cargar_clientesin2(_rango_inicio timestamp without time zone, _rango_final timestamp without time zone);
       usuario          postgres    false    9    236            ?            1259    18579    estilista_reserva    VIEW     \   CREATE VIEW usuario.estilista_reserva AS
 SELECT 0 AS id,
    ''::text AS nombre_estilista;
 %   DROP VIEW usuario.estilista_reserva;
       usuario          postgres    false    9            }           1255    18583    f_cargar_estilista(integer)    FUNCTION     z  CREATE FUNCTION usuario.f_cargar_estilista(_id_servicio integer) RETURNS SETOF usuario.estilista_reserva
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			us.id_usuario,
			use.nombre
		FROM
			usuario.usuario_servicio us join usuario.usuario use  on use.id =us.id_usuario and us.id_usuario=use.id 
			where
			us.id_servicio = _id_servicio;
		end
$$;
 @   DROP FUNCTION usuario.f_cargar_estilista(_id_servicio integer);
       usuario          postgres    false    237    9            ~           1255    18584    f_cargar_estilista2(integer)    FUNCTION     ?  CREATE FUNCTION usuario.f_cargar_estilista2(_id_servicio integer) RETURNS SETOF usuario.estilista_reserva
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			us.id_usuario,
			use.nombre
		FROM
			usuario.usuario_servicio us join usuario.usuario use  on use.id =us.id_usuario and us.id_usuario=use.id 
			where
			us.id_servicio = _id_servicio AND use.estado = 1;
		end
$$;
 A   DROP FUNCTION usuario.f_cargar_estilista2(_id_servicio integer);
       usuario          postgres    false    9    237                       1255    18585    f_cargar_estilista3(integer)    FUNCTION     ?  CREATE FUNCTION usuario.f_cargar_estilista3(_id_servicio integer) RETURNS SETOF usuario.estilista_reserva
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			us.id_usuario,
			use.nombre || ' ' || use.apellido
		FROM
			usuario.usuario_servicio us join usuario.usuario use  on use.id =us.id_usuario and us.id_usuario=use.id 
			where
			us.id_servicio = _id_servicio AND use.estado = 1;
		end
$$;
 A   DROP FUNCTION usuario.f_cargar_estilista3(_id_servicio integer);
       usuario          postgres    false    9    237            ?           1255    18586    f_cargar_estilistas()    FUNCTION     ?  CREATE FUNCTION usuario.f_cargar_estilistas() RETURNS SETOF usuario.estilista_reserva
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		((SELECT
			usuario.id,
			usuario.nombre || ' ' || usuario.apellido
		FROM
			usuario.usuario
			where
			usuario.estado = 1
			AND
			usuario.id_rol = 2)
		UNION ALL
		(SELECT
			0,
			'Seleccione un estilista')
		ORDER BY 
		id);
		end
$$;
 -   DROP FUNCTION usuario.f_cargar_estilistas();
       usuario          postgres    false    9    237            ?            1259    18587    precio_servicio    VIEW     E   CREATE VIEW usuario.precio_servicio AS
 SELECT 0 AS precio_servicio;
 #   DROP VIEW usuario.precio_servicio;
       usuario          postgres    false    9            ?           1255    18591    f_cargar_precio(integer)    FUNCTION     ?   CREATE FUNCTION usuario.f_cargar_precio(_id_servicio integer) RETURNS SETOF usuario.precio_servicio
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
		precio
		FROM
			usuario.servicio
			where
			id  = _id_servicio;
		end
$$;
 =   DROP FUNCTION usuario.f_cargar_precio(_id_servicio integer);
       usuario          postgres    false    9    238            ?            1259    18592    servicio_reserva    VIEW     Z   CREATE VIEW usuario.servicio_reserva AS
 SELECT 0 AS id,
    ''::text AS nombre_servicio;
 $   DROP VIEW usuario.servicio_reserva;
       usuario          postgres    false    9            ?           1255    18596    f_cargar_servicio()    FUNCTION     ?   CREATE FUNCTION usuario.f_cargar_servicio() RETURNS SETOF usuario.servicio_reserva
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			id,
			nombre
		FROM
			usuario.servicio;
		end
$$;
 +   DROP FUNCTION usuario.f_cargar_servicio();
       usuario          postgres    false    9    239            ?           1255    18597    f_cargar_servicio2()    FUNCTION     ?   CREATE FUNCTION usuario.f_cargar_servicio2() RETURNS SETOF usuario.servicio_reserva
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			id,
			nombre
		FROM
			usuario.servicio
		WHERE
		estado = 'Disponible';
		end
$$;
 ,   DROP FUNCTION usuario.f_cargar_servicio2();
       usuario          postgres    false    9    239            ?            1259    18598    contarcorreo_view    VIEW     J   CREATE VIEW usuario.contarcorreo_view AS
 SELECT ''::text AS user_correo;
 %   DROP VIEW usuario.contarcorreo_view;
       usuario          postgres    false    9            ?           1255    18602    f_contarcorreo(text)    FUNCTION       CREATE FUNCTION usuario.f_contarcorreo(_correo text) RETURNS SETOF usuario.contarcorreo_view
    LANGUAGE plpgsql
    AS $$

		DECLARE
		_user_correo TEXT;

	BEGIN

		IF (SELECT COUNT(*) FROM usuario.usuario WHERE correo = _correo ) > 0
			THEN
				SELECT
					correo
				INTO
					_user_correo
				FROM
					usuario.usuario 
				WHERE
					correo = _correo;
					
				RETURN QUERY 
					SELECT
						_user_correo;
		ELSE
			RETURN QUERY
				SELECT
					'1'::text;
		END IF;
		
	END

$$;
 4   DROP FUNCTION usuario.f_contarcorreo(_correo text);
       usuario          postgres    false    9    240            ?            1259    18603    contarid_view    VIEW     ;   CREATE VIEW usuario.contarid_view AS
 SELECT 0 AS user_id;
 !   DROP VIEW usuario.contarid_view;
       usuario          postgres    false    9            ?           1255    18607    f_contarid(integer)    FUNCTION     ?  CREATE FUNCTION usuario.f_contarid(_id integer) RETURNS SETOF usuario.contarid_view
    LANGUAGE plpgsql
    AS $$

		DECLARE
		_user_id INTEGER;

	BEGIN

		IF (SELECT COUNT(*) FROM usuario.usuario WHERE id = _id ) > 0
			THEN
				SELECT
					id
				INTO
					_user_id
				FROM
					usuario.usuario 
				WHERE
					id = _id;
					
				RETURN QUERY 
					SELECT
						_user_id;
		ELSE
			RETURN QUERY
				SELECT
					-1::INTEGER;
		END IF;
		
	END

$$;
 /   DROP FUNCTION usuario.f_contarid(_id integer);
       usuario          postgres    false    9    241            ?           1255    18608    f_contarid2(integer)    FUNCTION     ?  CREATE FUNCTION usuario.f_contarid2(_id integer) RETURNS SETOF usuario.contarid_view
    LANGUAGE plpgsql
    AS $$

		DECLARE
		_user_id INTEGER;

	BEGIN

		IF (SELECT COUNT(*) FROM usuario.usuario WHERE id = _id AND id_rol != 4) > 0
			THEN
				SELECT
					id
				INTO
					_user_id
				FROM
					usuario.usuario 
				WHERE
					id = _id;
					
				RETURN QUERY 
					SELECT
						_user_id;
		ELSE
			RETURN QUERY
				SELECT
					-1::INTEGER;
		END IF;
		
	END

$$;
 0   DROP FUNCTION usuario.f_contarid2(_id integer);
       usuario          postgres    false    9    241            ?           1255    18609    f_contarid3(integer)    FUNCTION     ?  CREATE FUNCTION usuario.f_contarid3(_id integer) RETURNS SETOF usuario.contarid_view
    LANGUAGE plpgsql
    AS $$

		DECLARE
		_user_id INTEGER;

	BEGIN

		IF (SELECT COUNT(*) FROM usuario.usuario WHERE id = _id AND id_rol = 4) > 0
			THEN
				SELECT
					id
				INTO
					_user_id
				FROM
					usuario.usuario 
				WHERE
					id = _id;
					
				RETURN QUERY 
					SELECT
						_user_id;
		ELSE
			RETURN QUERY
				SELECT
					-1::INTEGER;
		END IF;
		
	END

$$;
 0   DROP FUNCTION usuario.f_contarid3(_id integer);
       usuario          postgres    false    9    241            ?            1259    18610    duracionservicio_view    VIEW     h   CREATE VIEW usuario.duracionservicio_view AS
 SELECT NULL::time without time zone AS duracion_servicio;
 )   DROP VIEW usuario.duracionservicio_view;
       usuario          postgres    false    9            ?           1255    18614    f_duracion_servicio(integer)    FUNCTION     ?   CREATE FUNCTION usuario.f_duracion_servicio(_id integer) RETURNS SETOF usuario.duracionservicio_view
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			duracion
		FROM
			usuario.servicio
		WHERE 
			id = _id;
		end
$$;
 8   DROP FUNCTION usuario.f_duracion_servicio(_id integer);
       usuario          postgres    false    9    242            ?           1255    18615    f_eliminar_cliente(integer)    FUNCTION     ?   CREATE FUNCTION usuario.f_eliminar_cliente(_user_id integer) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		UPDATE
			usuario.usuario
		SET
			estado = 3
		WHERE
			id = _user_id;
	END

$$;
 <   DROP FUNCTION usuario.f_eliminar_cliente(_user_id integer);
       usuario          postgres    false    9            ?           1255    18616 #   f_eliminar_imagen_catalogo(integer)    FUNCTION     ?   CREATE FUNCTION usuario.f_eliminar_imagen_catalogo(_id integer) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

begin
	
	DELETE FROM
	usuario.catalogo
	WHERE 
	id= _id;
	end

$$;
 ?   DROP FUNCTION usuario.f_eliminar_imagen_catalogo(_id integer);
       usuario          postgres    false    9            x           1255    18617 $   f_eliminar_usuario_servicio(integer)    FUNCTION     ?   CREATE FUNCTION usuario.f_eliminar_usuario_servicio(_id integer) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$

begin
	
	DELETE FROM
	usuario.usuario_servicio
	WHERE 
	id= _id;
	end

$$;
 @   DROP FUNCTION usuario.f_eliminar_usuario_servicio(_id integer);
       usuario          postgres    false    9            ?           1255    18618 &   f_insert_catalogo(text, integer, text)    FUNCTION     h  CREATE FUNCTION usuario.f_insert_catalogo(_imagen text, _id_usuario integer, _session text) RETURNS SETOF usuario.catalogo
    LANGUAGE plpgsql
    AS $$
	BEGIN
		INSERT INTO
			usuario.catalogo
			(
			imagen,
			id_usuario,
			session,
			last_modified)
		VALUES
			(
			_imagen,
			_id_usuario,
			_session,
			current_timestamp);
		end
$$;
 [   DROP FUNCTION usuario.f_insert_catalogo(_imagen text, _id_usuario integer, _session text);
       usuario          postgres    false    9    230            ?           1255    18619 X   f_insert_cliente(integer, text, text, text, text, date, integer, integer, integer, text)    FUNCTION     ?  CREATE FUNCTION usuario.f_insert_cliente(_id integer, _nombre text, _apellido text, _correo text, _contrasena text, _fecha_nacimiento date, _telefono integer, _estado integer, _id_rol integer, _session text) RETURNS SETOF usuario.usuario
    LANGUAGE plpgsql
    AS $$
	BEGIN
		INSERT INTO
			usuario.usuario
			(id,
			nombre,
			apellido,
			correo,
			contrasena,
			fecha_nacimiento,
			telefono,
			estado,
			id_rol,
			session,
			last_modified)
		VALUES
			(_id,
			_nombre,
			_apellido,
			_correo,
			_contrasena,
			_fecha_nacimiento,
			_telefono,
			_estado,
			_id_rol,
			_session,
			current_timestamp);
		end
$$;
 ?   DROP FUNCTION usuario.f_insert_cliente(_id integer, _nombre text, _apellido text, _correo text, _contrasena text, _fecha_nacimiento date, _telefono integer, _estado integer, _id_rol integer, _session text);
       usuario          postgres    false    9    234            ?           1255    18620 W   f_insert_cliente(integer, text, text, text, text, date, bigint, integer, integer, text)    FUNCTION     ?  CREATE FUNCTION usuario.f_insert_cliente(_id integer, _nombre text, _apellido text, _correo text, _contrasena text, _fecha_nacimiento date, _telefono bigint, _estado integer, _id_rol integer, _session text) RETURNS SETOF usuario.usuario
    LANGUAGE plpgsql
    AS $$
	BEGIN
		INSERT INTO
			usuario.usuario
			(id,
			nombre,
			apellido,
			correo,
			contrasena,
			fecha_nacimiento,
			telefono,
			estado,
			id_rol,
			session,
			last_modified)
		VALUES
			(_id,
			_nombre,
			_apellido,
			_correo,
			_contrasena,
			_fecha_nacimiento,
			_telefono,
			_estado,
			_id_rol,
			_session,
			current_timestamp);
		end
$$;
 ?   DROP FUNCTION usuario.f_insert_cliente(_id integer, _nombre text, _apellido text, _correo text, _contrasena text, _fecha_nacimiento date, _telefono bigint, _estado integer, _id_rol integer, _session text);
       usuario          postgres    false    9    234            ?           1255    18621 3   f_insert_estilista_servicio(integer, integer, text)    FUNCTION     ?  CREATE FUNCTION usuario.f_insert_estilista_servicio(_id_usuario integer, _id_servicio integer, _session text) RETURNS SETOF usuario.usuario_servicio
    LANGUAGE plpgsql
    AS $$
	BEGIN
		INSERT INTO
			usuario.usuario_servicio
			(id_usuario,
			id_servicio,
			session,
			last_modified)
		VALUES
			(_id_usuario,
			_id_servicio,
			_session,
			current_timestamp);
		end
$$;
 m   DROP FUNCTION usuario.f_insert_estilista_servicio(_id_usuario integer, _id_servicio integer, _session text);
       usuario          postgres    false    9    235            ?           1255    18622 ;   f_insert_servicio(text, text, integer, text, integer, text)    FUNCTION     +  CREATE FUNCTION usuario.f_insert_servicio(_nombre text, _descripcion text, _precio integer, _duracion text, _estado integer, _session text) RETURNS SETOF usuario.servicio
    LANGUAGE plpgsql
    AS $$
	BEGIN
		INSERT INTO
			usuario.servicio
			(
			id,
			nombre,
			descripcion,
			precio,
			duracion,
			estado,
			session,
			last_modified)
		VALUES
			(
			(SELECT MAX(id)+1 as id FROM usuario.servicio),
			_nombre,
			_descripcion,
			_precio,
			_duracion::time,
			_estado,
			_session,
			current_timestamp);
		end
$$;
 ?   DROP FUNCTION usuario.f_insert_servicio(_nombre text, _descripcion text, _precio integer, _duracion text, _estado integer, _session text);
       usuario          postgres    false    9    232            ?           1255    18623 8   f_insert_servicio(text, text, integer, text, text, text)    FUNCTION     ?  CREATE FUNCTION usuario.f_insert_servicio(_nombre text, _descripcion text, _precio integer, _duracion text, _estado text, _session text) RETURNS SETOF usuario.servicio
    LANGUAGE plpgsql
    AS $$
	BEGIN
		INSERT INTO
			usuario.servicio
			(
			nombre,
			descripcion,
			precio,
			duracion,
			estado,
			session,
			last_modified)
		VALUES
			(
			_nombre,
			_descripcion,
			_precio,
			_duracion::time,
			_estado,
			_session,
			current_timestamp);
		end
$$;
 ?   DROP FUNCTION usuario.f_insert_servicio(_nombre text, _descripcion text, _precio integer, _duracion text, _estado text, _session text);
       usuario          postgres    false    9    232            ?           1255    18624 3   f_insert_servicio_adicional(integer, integer, text)    FUNCTION     ?  CREATE FUNCTION usuario.f_insert_servicio_adicional(_id_usuario integer, _id_servicio integer, _session text) RETURNS SETOF usuario.usuario_servicio
    LANGUAGE plpgsql
    AS $$
	BEGIN
		INSERT INTO
			usuario.usuario_servicio
			(id_usuario,
			id_servicio,
			session,
			last_modified)
		VALUES
			(_id_usuario,
			_id_servicio,
			_session,
			current_timestamp);


                    UPDATE 
			 reserva.reserva
	            SET 
			  id_alerta=0
	            WHERE 
			 reserva.reserva.id_estilista=_id_usuario AND reserva.reserva.id_servicio=_id_servicio AND reserva.reserva.id_alerta=6 
			 AND reserva.reserva.dia_hora_inicio::date > current_timestamp;


			
		end
$$;
 m   DROP FUNCTION usuario.f_insert_servicio_adicional(_id_usuario integer, _id_servicio integer, _session text);
       usuario          postgres    false    9    235            ?           1255    18625    f_mostar_catalogo()    FUNCTION     ?   CREATE FUNCTION usuario.f_mostar_catalogo() RETURNS SETOF usuario.catalogo
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			*
		FROM
			usuario.catalogo;
		end
$$;
 +   DROP FUNCTION usuario.f_mostar_catalogo();
       usuario          postgres    false    9    230            ?           1255    18626    f_mostar_catalogo2(integer)    FUNCTION     ?   CREATE FUNCTION usuario.f_mostar_catalogo2(_id_usuario integer) RETURNS SETOF usuario.catalogo
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			*
		FROM
			usuario.catalogo
		WHERE 
		       id_usuario=_id_usuario;
		end
$$;
 ?   DROP FUNCTION usuario.f_mostar_catalogo2(_id_usuario integer);
       usuario          postgres    false    9    230            ?           1255    18627    f_mostar_estilista()    FUNCTION     ?   CREATE FUNCTION usuario.f_mostar_estilista() RETURNS SETOF usuario.usuario
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query

		SELECT
			*
		FROM
			usuario.usuario
		WHERE 
			id_rol =2;
		end
$$;
 ,   DROP FUNCTION usuario.f_mostar_estilista();
       usuario          postgres    false    9    234            ?           1255    18628    f_mostar_estilista2(integer)    FUNCTION     ?   CREATE FUNCTION usuario.f_mostar_estilista2(_id integer) RETURNS SETOF usuario.usuario
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			*
		FROM
			usuario.usuario
		WHERE 
			usuario.usuario.id=_id;
		end
$$;
 8   DROP FUNCTION usuario.f_mostar_estilista2(_id integer);
       usuario          postgres    false    9    234            ?           1255    18629    f_mostar_inacistencia(integer)    FUNCTION     ?   CREATE FUNCTION usuario.f_mostar_inacistencia(_id integer) RETURNS SETOF reserva.alerta_usuario
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			*
		FROM
			reserva.alerta_usuario

		WHERE 
			id =_id;
		end
$$;
 :   DROP FUNCTION usuario.f_mostar_inacistencia(_id integer);
       usuario          postgres    false    9    207            ?           1255    18630    f_mostar_perfil_estilista()    FUNCTION     ?   CREATE FUNCTION usuario.f_mostar_perfil_estilista() RETURNS SETOF usuario.usuario
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query

		SELECT
			*
		FROM
			usuario.usuario
		WHERE 
			id_rol =2;
		end
$$;
 3   DROP FUNCTION usuario.f_mostar_perfil_estilista();
       usuario          postgres    false    9    234            ?           1255    18631    f_mostar_servicio()    FUNCTION     ?   CREATE FUNCTION usuario.f_mostar_servicio() RETURNS SETOF usuario.servicio
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			*
		FROM
			usuario.servicio;
		end
$$;
 +   DROP FUNCTION usuario.f_mostar_servicio();
       usuario          postgres    false    9    232            ?           1255    18632    f_mostar_servicio2()    FUNCTION     ?   CREATE FUNCTION usuario.f_mostar_servicio2() RETURNS SETOF usuario.servicio
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			*
		FROM
			usuario.servicio
		WHERE
		estado = 'Disponible';
		end
$$;
 ,   DROP FUNCTION usuario.f_mostar_servicio2();
       usuario          postgres    false    232    9            ?            1259    18633    usuario_servicio_view2    VIEW     ?   CREATE VIEW usuario.usuario_servicio_view2 AS
 SELECT 0 AS id,
    ''::text AS servicio,
    ''::text AS nombre_usuario,
    ''::text AS apellido_usuario;
 *   DROP VIEW usuario.usuario_servicio_view2;
       usuario          postgres    false    9            ?           1255    18637    f_mostar_servicio_usuario()    FUNCTION     ?  CREATE FUNCTION usuario.f_mostar_servicio_usuario() RETURNS SETOF usuario.usuario_servicio_view2
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			usuario.usuario_servicio.id,usuario.servicio.nombre,usuario.usuario.nombre,usuario.usuario.apellido
                        from usuario.servicio,usuario.usuario ,usuario.usuario_servicio
                        where usuario.id=usuario_servicio.id_usuario AND servicio.id=usuario_servicio.id_servicio;
		end
$$;
 3   DROP FUNCTION usuario.f_mostar_servicio_usuario();
       usuario          postgres    false    243    9            ?           1255    18638    f_mostar_servicio_usuario2()    FUNCTION       CREATE FUNCTION usuario.f_mostar_servicio_usuario2() RETURNS SETOF usuario.usuario_servicio_view2
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
	           SELECT
			usuario.usuario_servicio.id,usuario.servicio.nombre,usuario.usuario.nombre,usuario.usuario.apellido
                        from usuario.servicio,usuario.usuario ,usuario.usuario_servicio
                        where usuario.id=usuario_servicio.id_usuario AND servicio.id=usuario_servicio.id_servicio AND usuario.usuario.estado=1;
		end
$$;
 4   DROP FUNCTION usuario.f_mostar_servicio_usuario2();
       usuario          postgres    false    9    243                       1255    18639    f_mostar_usuario(integer)    FUNCTION     ?   CREATE FUNCTION usuario.f_mostar_usuario(_id integer) RETURNS SETOF usuario.usuario
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			*
		FROM
			usuario.usuario
		WHERE 
			id = _id;
		end
$$;
 5   DROP FUNCTION usuario.f_mostar_usuario(_id integer);
       usuario          postgres    false    9    234            ?            1259    18640    usuario_servicio_alerta    VIEW     Z   CREATE VIEW usuario.usuario_servicio_alerta AS
 SELECT 0 AS servicio,
    0 AS estilista;
 +   DROP VIEW usuario.usuario_servicio_alerta;
       usuario          postgres    false    9                       1255    18644 "   f_mostar_usuario_servicio(integer)    FUNCTION     E  CREATE FUNCTION usuario.f_mostar_usuario_servicio(_id integer) RETURNS SETOF usuario.usuario_servicio_alerta
    LANGUAGE plpgsql
    AS $$
	BEGIN
		return query
		SELECT
			usuario.usuario_servicio.id_servicio,usuario.usuario_servicio.id_usuario
		FROM
			usuario.usuario_servicio

		WHERE 
			id =_id;
		end
$$;
 >   DROP FUNCTION usuario.f_mostar_usuario_servicio(_id integer);
       usuario          postgres    false    9    244                       1255    18645    f_obtener_estilista()    FUNCTION       CREATE FUNCTION usuario.f_obtener_estilista() RETURNS SETOF usuario.usuario
    LANGUAGE plpgsql
    AS $$
	begin
		return query
		
                SELECT
			*
		FROM
			usuario.usuario
		WHERE   
		        id_rol=2
		AND 
			estado ='1';		

	end

$$;
 -   DROP FUNCTION usuario.f_obtener_estilista();
       usuario          postgres    false    234    9                       1255    18646    f_obtener_estilista2()    FUNCTION     c  CREATE FUNCTION usuario.f_obtener_estilista2() RETURNS SETOF usuario.estilista_reserva
    LANGUAGE plpgsql
    AS $$
	begin
		return query
		
               SELECT
			usuario.usuario.id,
			usuario.usuario.nombre || ' ' || usuario.usuario.apellido
		FROM
			usuario.usuario
		WHERE   
		        id_rol=2
		AND 
			estado ='1';

	end

$$;
 .   DROP FUNCTION usuario.f_obtener_estilista2();
       usuario          postgres    false    9    237                       1255    18647    f_obtener_servicio()    FUNCTION     ?   CREATE FUNCTION usuario.f_obtener_servicio() RETURNS SETOF usuario.servicio
    LANGUAGE plpgsql
    AS $$
	begin
		return query
		
		SELECT
			*
		FROM
			usuario.servicio
		WHERE 
			estado ='Disponible';
		

	end

$$;
 ,   DROP FUNCTION usuario.f_obtener_servicio();
       usuario          postgres    false    232    9                       1255    18648    f_obtener_usuario_token(text)    FUNCTION     ?  CREATE FUNCTION usuario.f_obtener_usuario_token(_token text) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		IF (SELECT COUNT(*) FROM usuario.token_repureacion_usuario WHERE token = _token) = 0
			THEN RETURN QUERY
				SELECT
					-1::INTEGER;
		elseIF (SELECT COUNT(*)FROM usuario.token_repureacion_usuario WHERE token = _token AND current_timestamp between fecha_creado AND fecha_vigencia) = 0
			THEN
				DELETE FROM usuario.token_repureacion_usuario WHERE token = _token;
			
				RETURN QUERY
				SELECT
					-2::INTEGER;
		ELSE	
			RETURN QUERY 
				SELECT
					user_id
				FROM
					usuario.token_repureacion_usuario
				WHERE
					token = _token;
		
		END IF;

			
	END

$$;
 <   DROP FUNCTION usuario.f_obtener_usuario_token(_token text);
       usuario          postgres    false    9                       1255    18649    f_validar_usuario(text)    FUNCTION     B  CREATE FUNCTION usuario.f_validar_usuario(_correo text) RETURNS SETOF usuario.usuario
    LANGUAGE plpgsql
    AS $$

	
			
	BEGIN
		IF (SELECT COUNT(*) FROM usuario.usuario WHERE correo = _correo AND estado != 3) = 0
			then RETURN QUERY
				SELECT
					-1::INTEGER,
					''::TEXT,
					''::TEXT,
					1::BIGINT,
					''::TEXT,
					''::TEXT,
                    NULL::DATE,
                    1::INTEGER,
                    ''::TEXT,
                    ''::TEXT,
                    1::INTEGER,
                    ''::TEXT,
                    NULL::TIMESTAMP;
		elseIF (SELECT COUNT(*) FROM usuario.usuario uu join usuario.token_repureacion_usuario ut on ut.user_id = uu.id WHERE uu.correo = _correo and current_timestamp between ut.fecha_creado AND ut.fecha_vigencia) > 0

			then RETURN QUERY
				SELECT
					-2::INTEGER,
					''::TEXT,
					''::TEXT,
					1::BIGINT,
					''::TEXT,
					''::TEXT,
                    NULL::DATE,
                    1::INTEGER,
                    ''::TEXT,
                    ''::TEXT,
                    1::INTEGER,
                    ''::TEXT,
                    NULL::TIMESTAMP;
		ELSEIF (SELECT COUNT(*) FROM usuario.usuario WHERE correo = _correo) > 0
			THEN
				update 
					usuario.usuario
				set
					estado = 2
				where
					correo = _correo;
				
				RETURN QUERY 
				SELECT
					*
				FROM
					usuario.usuario 
				WHERE
					correo = _correo;
		ELSE
			RETURN QUERY
				SELECT
					-1::INTEGER, 
					''::TEXT,
					''::TEXT,
					1::BIGINT,
					''::TEXT,
					''::TEXT,
                    NULL::DATE,
                    1::INTEGER,
                    ''::TEXT,
                    ''::TEXT,
                    1::INTEGER,
                    ''::TEXT,
                    NULL::TIMESTAMP;
		END IF;
			
	END

$$;
 7   DROP FUNCTION usuario.f_validar_usuario(_correo text);
       usuario          postgres    false    234    9                       1255    18650    f_validar_usuariocuenta(text)    FUNCTION     G  CREATE FUNCTION usuario.f_validar_usuariocuenta(_correo text) RETURNS SETOF usuario.usuario
    LANGUAGE plpgsql
    AS $$

	
			
	BEGIN
		IF (SELECT COUNT(*) FROM usuario.usuario WHERE correo = _correo AND estado = 3) = 0
			then RETURN QUERY
				SELECT
					-1::INTEGER,
					''::TEXT,
					''::TEXT,
					1::BIGINT,
					''::TEXT,
					''::TEXT,
                    NULL::DATE,
                    1::INTEGER,
                    ''::TEXT,
                    ''::TEXT,
                    1::INTEGER,
                    ''::TEXT,
                    NULL::TIMESTAMP;
		elseIF (SELECT COUNT(*) FROM usuario.usuario uu join usuario.token_repureacion_usuario ut on ut.user_id = uu.id WHERE uu.correo = _correo and current_timestamp between ut.fecha_creado AND ut.fecha_vigencia) > 0

			then RETURN QUERY
				SELECT
					-2::INTEGER,
					''::TEXT,
					''::TEXT,
					1::BIGINT,
					''::TEXT,
					''::TEXT,
                    NULL::DATE,
                    1::INTEGER,
                    ''::TEXT,
                    ''::TEXT,
                    1::INTEGER,
                    ''::TEXT,
                    NULL::TIMESTAMP;
		ELSEIF (SELECT COUNT(*) FROM usuario.usuario WHERE correo = _correo) > 0
			THEN
				update 
					usuario.usuario
				set
					estado = 2
				where
					correo = _correo;
				
				RETURN QUERY 
				SELECT
					*
				FROM
					usuario.usuario 
				WHERE
					correo = _correo;
		ELSE
			RETURN QUERY
				SELECT
					-1::INTEGER, 
					''::TEXT,
					''::TEXT,
					1::BIGINT,
					''::TEXT,
					''::TEXT,
                    NULL::DATE,
                    1::INTEGER,
                    ''::TEXT,
                    ''::TEXT,
                    1::INTEGER,
                    ''::TEXT,
                    NULL::TIMESTAMP;
		END IF;
			
	END

$$;
 =   DROP FUNCTION usuario.f_validar_usuariocuenta(_correo text);
       usuario          postgres    false    9    234            ?            1259    18651    alerta_usuario_id_seq    SEQUENCE        CREATE SEQUENCE reserva.alerta_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE reserva.alerta_usuario_id_seq;
       reserva          postgres    false    3    207            
           0    0    alerta_usuario_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE reserva.alerta_usuario_id_seq OWNED BY reserva.alerta_usuario.id;
          reserva          postgres    false    245            ?            1259    18653    horario_estilista_id_seq    SEQUENCE     ?   CREATE SEQUENCE reserva.horario_estilista_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE reserva.horario_estilista_id_seq;
       reserva          postgres    false    3    215                       0    0    horario_estilista_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE reserva.horario_estilista_id_seq OWNED BY reserva.horario_estilista.id;
          reserva          postgres    false    246            ?            1259    18655    horario_view1    VIEW     T   CREATE VIEW reserva.horario_view1 AS
 SELECT 0 AS "HoraInicio",
    0 AS "HoraFin";
 !   DROP VIEW reserva.horario_view1;
       reserva          postgres    false    3            ?            1259    18659    json    TABLE     d   CREATE TABLE reserva.json (
    id integer NOT NULL,
    horainicio integer,
    horafin integer
);
    DROP TABLE reserva.json;
       reserva         heap    postgres    false    3            ?            1259    18662    json_id_seq    SEQUENCE     u   CREATE SEQUENCE reserva.json_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE reserva.json_id_seq;
       reserva          postgres    false    3    248                       0    0    json_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE reserva.json_id_seq OWNED BY reserva.json.id;
          reserva          postgres    false    249            ?            1259    18664    reserva_estilistas_view    VIEW     ?   CREATE VIEW reserva.reserva_estilistas_view AS
 SELECT 0 AS id,
    ''::text AS nombre_servicio,
    '00:00:00'::time without time zone AS fecha;
 +   DROP VIEW reserva.reserva_estilistas_view;
       reserva          postgres    false    3            ?            1259    18668    reserva_id_seq    SEQUENCE     x   CREATE SEQUENCE reserva.reserva_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE reserva.reserva_id_seq;
       reserva          postgres    false    3    208                       0    0    reserva_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE reserva.reserva_id_seq OWNED BY reserva.reserva.id;
          reserva          postgres    false    251            ?            1259    18670    reservas_id_seq    SEQUENCE     y   CREATE SEQUENCE reserva.reservas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE reserva.reservas_id_seq;
       reserva          postgres    false    3    206                       0    0    reservas_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE reserva.reservas_id_seq OWNED BY reserva.reservas.id;
          reserva          postgres    false    252            ?            1259    18672    serie    TABLE     ?   CREATE TABLE reserva.serie (
    id integer NOT NULL,
    fecha_inicio timestamp without time zone,
    fecha_fin timestamp without time zone,
    dia text
);
    DROP TABLE reserva.serie;
       reserva         heap    postgres    false    3            ?            1259    18678    serie_id_seq    SEQUENCE     v   CREATE SEQUENCE reserva.serie_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE reserva.serie_id_seq;
       reserva          postgres    false    253    3                       0    0    serie_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE reserva.serie_id_seq OWNED BY reserva.serie.id;
          reserva          postgres    false    254            ?            1259    18680 	   auditoria    TABLE     T  CREATE TABLE security.auditoria (
    id bigint NOT NULL,
    fecha timestamp without time zone NOT NULL,
    accion character varying(100),
    schema character varying(200) NOT NULL,
    tabla character varying(200),
    session text NOT NULL,
    user_bd character varying(100) NOT NULL,
    data jsonb NOT NULL,
    pk text NOT NULL
);
    DROP TABLE security.auditoria;
       security         heap    postgres    false    8                       0    0    TABLE auditoria    COMMENT     a   COMMENT ON TABLE security.auditoria IS 'Tabla que almacena la trazabilidad de la informaicón.';
          security          postgres    false    255                       0    0    COLUMN auditoria.id    COMMENT     D   COMMENT ON COLUMN security.auditoria.id IS 'campo pk de la tabla ';
          security          postgres    false    255                       0    0    COLUMN auditoria.fecha    COMMENT     Z   COMMENT ON COLUMN security.auditoria.fecha IS 'ALmacen ala la fecha de la modificación';
          security          postgres    false    255                       0    0    COLUMN auditoria.accion    COMMENT     f   COMMENT ON COLUMN security.auditoria.accion IS 'Almacena la accion que se ejecuto sobre el registro';
          security          postgres    false    255                       0    0    COLUMN auditoria.schema    COMMENT     m   COMMENT ON COLUMN security.auditoria.schema IS 'Almanena el nomnbre del schema de la tabla que se modifico';
          security          postgres    false    255                       0    0    COLUMN auditoria.tabla    COMMENT     `   COMMENT ON COLUMN security.auditoria.tabla IS 'Almacena el nombre de la tabla que se modifico';
          security          postgres    false    255                       0    0    COLUMN auditoria.session    COMMENT     p   COMMENT ON COLUMN security.auditoria.session IS 'Campo que almacena el id de la session que generó el cambio';
          security          postgres    false    255                       0    0    COLUMN auditoria.user_bd    COMMENT     ?   COMMENT ON COLUMN security.auditoria.user_bd IS 'Campo que almacena el user que se autentico en el motor para generar el cmabio';
          security          postgres    false    255                       0    0    COLUMN auditoria.data    COMMENT     d   COMMENT ON COLUMN security.auditoria.data IS 'campo que almacena la modificaicón que se realizó';
          security          postgres    false    255                       0    0    COLUMN auditoria.pk    COMMENT     W   COMMENT ON COLUMN security.auditoria.pk IS 'Campo que identifica el id del registro.';
          security          postgres    false    255                        1259    18686    auditoria_id_seq    SEQUENCE     {   CREATE SEQUENCE security.auditoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE security.auditoria_id_seq;
       security          postgres    false    8    255                       0    0    auditoria_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE security.auditoria_id_seq OWNED BY security.auditoria.id;
          security          postgres    false    256                       1259    18688    autenication    TABLE     ?   CREATE TABLE security.autenication (
    id bigint NOT NULL,
    user_id integer,
    ip character varying(100),
    mac character varying(100),
    fecha_inicio timestamp without time zone,
    session text,
    fecha_fin timestamp without time zone
);
 "   DROP TABLE security.autenication;
       security         heap    postgres    false    8                       0    0    TABLE autenication    COMMENT     o   COMMENT ON TABLE security.autenication IS 'Tabla que almacena las autenticaciones por parte de los usuarios.';
          security          postgres    false    257                       0    0    COLUMN autenication.id    COMMENT     F   COMMENT ON COLUMN security.autenication.id IS 'campo pk de la tabla';
          security          postgres    false    257                       0    0    COLUMN autenication.user_id    COMMENT     V   COMMENT ON COLUMN security.autenication.user_id IS 'Campo que identifica el usuario';
          security          postgres    false    257                       0    0    COLUMN autenication.ip    COMMENT     Y   COMMENT ON COLUMN security.autenication.ip IS 'Cmapo que almacena la ip de la maquina.';
          security          postgres    false    257                       0    0    COLUMN autenication.mac    COMMENT     X   COMMENT ON COLUMN security.autenication.mac IS 'Campo que almacena la MAC del equipo.';
          security          postgres    false    257                        0    0     COLUMN autenication.fecha_inicio    COMMENT     a   COMMENT ON COLUMN security.autenication.fecha_inicio IS 'Captura la fecha de inicio de session';
          security          postgres    false    257            !           0    0    COLUMN autenication.session    COMMENT     `   COMMENT ON COLUMN security.autenication.session IS 'Campo que almacena la session del usuario';
          security          postgres    false    257            "           0    0    COLUMN autenication.fecha_fin    COMMENT     j   COMMENT ON COLUMN security.autenication.fecha_fin IS 'Cmapo que lamacena la feccha de cierre de session';
          security          postgres    false    257                       1259    18694    autenication_id_seq    SEQUENCE     ~   CREATE SEQUENCE security.autenication_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE security.autenication_id_seq;
       security          postgres    false    8    257            #           0    0    autenication_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE security.autenication_id_seq OWNED BY security.autenication.id;
          security          postgres    false    258                       1259    18696    function_db_view    VIEW     ?  CREATE VIEW security.function_db_view AS
 SELECT pp.proname AS b_function,
    oidvectortypes(pp.proargtypes) AS b_type_parameters
   FROM (pg_proc pp
     JOIN pg_namespace pn ON ((pn.oid = pp.pronamespace)))
  WHERE ((pn.nspname)::text <> ALL (ARRAY[('pg_catalog'::character varying)::text, ('information_schema'::character varying)::text, ('admin_control'::character varying)::text, ('vial'::character varying)::text]));
 %   DROP VIEW security.function_db_view;
       security          postgres    false    8                       1259    18701    catalogo_id_seq    SEQUENCE     y   CREATE SEQUENCE usuario.catalogo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE usuario.catalogo_id_seq;
       usuario          postgres    false    230    9            $           0    0    catalogo_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE usuario.catalogo_id_seq OWNED BY usuario.catalogo.id;
          usuario          postgres    false    260                       1259    18703    servicio_id_seq    SEQUENCE     y   CREATE SEQUENCE usuario.servicio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE usuario.servicio_id_seq;
       usuario          postgres    false    232    9            %           0    0    servicio_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE usuario.servicio_id_seq OWNED BY usuario.servicio.id;
          usuario          postgres    false    261                       1259    18705     token_repureacion_usuario_id_seq    SEQUENCE     ?   CREATE SEQUENCE usuario.token_repureacion_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE usuario.token_repureacion_usuario_id_seq;
       usuario          postgres    false    9    233            &           0    0     token_repureacion_usuario_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE usuario.token_repureacion_usuario_id_seq OWNED BY usuario.token_repureacion_usuario.id;
          usuario          postgres    false    262                       1259    18707    usuario_servicio_id_seq    SEQUENCE     ?   CREATE SEQUENCE usuario.usuario_servicio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE usuario.usuario_servicio_id_seq;
       usuario          postgres    false    235    9            '           0    0    usuario_servicio_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE usuario.usuario_servicio_id_seq OWNED BY usuario.usuario_servicio.id;
          usuario          postgres    false    263            ?           2604    18709    alerta_usuario id    DEFAULT     x   ALTER TABLE ONLY reserva.alerta_usuario ALTER COLUMN id SET DEFAULT nextval('reserva.alerta_usuario_id_seq'::regclass);
 A   ALTER TABLE reserva.alerta_usuario ALTER COLUMN id DROP DEFAULT;
       reserva          postgres    false    245    207            ?           2604    18710    horario_estilista id    DEFAULT     ~   ALTER TABLE ONLY reserva.horario_estilista ALTER COLUMN id SET DEFAULT nextval('reserva.horario_estilista_id_seq'::regclass);
 D   ALTER TABLE reserva.horario_estilista ALTER COLUMN id DROP DEFAULT;
       reserva          postgres    false    246    215            ?           2604    18711    json id    DEFAULT     d   ALTER TABLE ONLY reserva.json ALTER COLUMN id SET DEFAULT nextval('reserva.json_id_seq'::regclass);
 7   ALTER TABLE reserva.json ALTER COLUMN id DROP DEFAULT;
       reserva          postgres    false    249    248            ?           2604    18712 
   reserva id    DEFAULT     j   ALTER TABLE ONLY reserva.reserva ALTER COLUMN id SET DEFAULT nextval('reserva.reserva_id_seq'::regclass);
 :   ALTER TABLE reserva.reserva ALTER COLUMN id DROP DEFAULT;
       reserva          postgres    false    251    208            ?           2604    18713    reservas id    DEFAULT     l   ALTER TABLE ONLY reserva.reservas ALTER COLUMN id SET DEFAULT nextval('reserva.reservas_id_seq'::regclass);
 ;   ALTER TABLE reserva.reservas ALTER COLUMN id DROP DEFAULT;
       reserva          postgres    false    252    206            ?           2604    18714    serie id    DEFAULT     f   ALTER TABLE ONLY reserva.serie ALTER COLUMN id SET DEFAULT nextval('reserva.serie_id_seq'::regclass);
 8   ALTER TABLE reserva.serie ALTER COLUMN id DROP DEFAULT;
       reserva          postgres    false    254    253            ?           2604    18715    auditoria id    DEFAULT     p   ALTER TABLE ONLY security.auditoria ALTER COLUMN id SET DEFAULT nextval('security.auditoria_id_seq'::regclass);
 =   ALTER TABLE security.auditoria ALTER COLUMN id DROP DEFAULT;
       security          postgres    false    256    255            ?           2604    18716    autenication id    DEFAULT     v   ALTER TABLE ONLY security.autenication ALTER COLUMN id SET DEFAULT nextval('security.autenication_id_seq'::regclass);
 @   ALTER TABLE security.autenication ALTER COLUMN id DROP DEFAULT;
       security          postgres    false    258    257            ?           2604    18717    catalogo id    DEFAULT     l   ALTER TABLE ONLY usuario.catalogo ALTER COLUMN id SET DEFAULT nextval('usuario.catalogo_id_seq'::regclass);
 ;   ALTER TABLE usuario.catalogo ALTER COLUMN id DROP DEFAULT;
       usuario          postgres    false    260    230            ?           2604    18718    servicio id    DEFAULT     l   ALTER TABLE ONLY usuario.servicio ALTER COLUMN id SET DEFAULT nextval('usuario.servicio_id_seq'::regclass);
 ;   ALTER TABLE usuario.servicio ALTER COLUMN id DROP DEFAULT;
       usuario          postgres    false    261    232            ?           2604    18719    token_repureacion_usuario id    DEFAULT     ?   ALTER TABLE ONLY usuario.token_repureacion_usuario ALTER COLUMN id SET DEFAULT nextval('usuario.token_repureacion_usuario_id_seq'::regclass);
 L   ALTER TABLE usuario.token_repureacion_usuario ALTER COLUMN id DROP DEFAULT;
       usuario          postgres    false    262    233            ?           2604    18720    usuario_servicio id    DEFAULT     |   ALTER TABLE ONLY usuario.usuario_servicio ALTER COLUMN id SET DEFAULT nextval('usuario.usuario_servicio_id_seq'::regclass);
 C   ALTER TABLE usuario.usuario_servicio ALTER COLUMN id DROP DEFAULT;
       usuario          postgres    false    263    235            ?          0    18506    alerta 
   TABLE DATA           J   COPY reserva.alerta (descripcion, session, last_modified, id) FROM stdin;
    reserva          postgres    false    229   ?>      ?          0    18359    alerta_usuario 
   TABLE DATA           p   COPY reserva.alerta_usuario (id, id_alerta, id_estilista, session, last_modified, dia_inacistencia) FROM stdin;
    reserva          postgres    false    207   ??      ?          0    18414    horario_estilista 
   TABLE DATA           K   COPY reserva.horario_estilista (id, dia, rangos, estilista_id) FROM stdin;
    reserva          postgres    false    215   ??      ?          0    18659    json 
   TABLE DATA           8   COPY reserva.json (id, horainicio, horafin) FROM stdin;
    reserva          postgres    false    248   ??      ?          0    18366    reserva 
   TABLE DATA           ?   COPY reserva.reserva (id, id_servicio, id_estilista, id_alerta, id_usuario, session, last_modified, dia_hora_inicio, dia_hora_final, precio, registro, confirmacion) FROM stdin;
    reserva          postgres    false    208   ??      ?          0    18350    reservas 
   TABLE DATA           Z   COPY reserva.reservas (hora_inicio, disponible, id_estilista, hora_final, id) FROM stdin;
    reserva          postgres    false    206   ??      ?          0    18672    serie 
   TABLE DATA           B   COPY reserva.serie (id, fecha_inicio, fecha_fin, dia) FROM stdin;
    reserva          postgres    false    253   @      ?          0    18680 	   auditoria 
   TABLE DATA           c   COPY security.auditoria (id, fecha, accion, schema, tabla, session, user_bd, data, pk) FROM stdin;
    security          postgres    false    255   4@      ?          0    18688    autenication 
   TABLE DATA           `   COPY security.autenication (id, user_id, ip, mac, fecha_inicio, session, fecha_fin) FROM stdin;
    security          postgres    false    257   ?E      ?          0    18514    catalogo 
   TABLE DATA           S   COPY usuario.catalogo (id, imagen, id_usuario, session, last_modified) FROM stdin;
    usuario          postgres    false    230   vF      ?          0    18521    rol 
   TABLE DATA           G   COPY usuario.rol (id, descripcion, session, last_modified) FROM stdin;
    usuario          postgres    false    231   ?F      ?          0    18528    servicio 
   TABLE DATA           n   COPY usuario.servicio (nombre, descripcion, precio, session, last_modified, id, duracion, estado) FROM stdin;
    usuario          postgres    false    232   G      ?          0    18535    token_repureacion_usuario 
   TABLE DATA           f   COPY usuario.token_repureacion_usuario (id, user_id, token, fecha_creado, fecha_vigencia) FROM stdin;
    usuario          postgres    false    233   ?G      ?          0    18542    usuario 
   TABLE DATA           ?   COPY usuario.usuario (id, nombre, apellido, telefono, correo, contrasena, fecha_nacimiento, estado, biografia, imagen_perfil, id_rol, session, last_modified) FROM stdin;
    usuario          postgres    false    234   ?G      ?          0    18549    usuario_servicio 
   TABLE DATA           `   COPY usuario.usuario_servicio (id_usuario, id_servicio, session, last_modified, id) FROM stdin;
    usuario          postgres    false    235   iH      (           0    0    alerta_usuario_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('reserva.alerta_usuario_id_seq', 1, false);
          reserva          postgres    false    245            )           0    0    horario_estilista_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('reserva.horario_estilista_id_seq', 1, false);
          reserva          postgres    false    246            *           0    0    json_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('reserva.json_id_seq', 1, false);
          reserva          postgres    false    249            +           0    0    reserva_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('reserva.reserva_id_seq', 1, false);
          reserva          postgres    false    251            ,           0    0    reservas_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('reserva.reservas_id_seq', 1, false);
          reserva          postgres    false    252            -           0    0    serie_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('reserva.serie_id_seq', 1, false);
          reserva          postgres    false    254            .           0    0    auditoria_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('security.auditoria_id_seq', 15, true);
          security          postgres    false    256            /           0    0    autenication_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('security.autenication_id_seq', 2, true);
          security          postgres    false    258            0           0    0    catalogo_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('usuario.catalogo_id_seq', 1, false);
          usuario          postgres    false    260            1           0    0    servicio_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('usuario.servicio_id_seq', 1, true);
          usuario          postgres    false    261            2           0    0     token_repureacion_usuario_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('usuario.token_repureacion_usuario_id_seq', 1, false);
          usuario          postgres    false    262            3           0    0    usuario_servicio_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('usuario.usuario_servicio_id_seq', 1, false);
          usuario          postgres    false    263            ?           2606    18722     alerta_usuario pk_alerta_usuario 
   CONSTRAINT     _   ALTER TABLE ONLY reserva.alerta_usuario
    ADD CONSTRAINT pk_alerta_usuario PRIMARY KEY (id);
 K   ALTER TABLE ONLY reserva.alerta_usuario DROP CONSTRAINT pk_alerta_usuario;
       reserva            postgres    false    207            ?           2606    18724    horario_estilista pk_horario 
   CONSTRAINT     [   ALTER TABLE ONLY reserva.horario_estilista
    ADD CONSTRAINT pk_horario PRIMARY KEY (id);
 G   ALTER TABLE ONLY reserva.horario_estilista DROP CONSTRAINT pk_horario;
       reserva            postgres    false    215            ?           2606    18726    alerta pk_reserva_alerta 
   CONSTRAINT     W   ALTER TABLE ONLY reserva.alerta
    ADD CONSTRAINT pk_reserva_alerta PRIMARY KEY (id);
 C   ALTER TABLE ONLY reserva.alerta DROP CONSTRAINT pk_reserva_alerta;
       reserva            postgres    false    229            	           2606    18728    json pk_reserva_json 
   CONSTRAINT     S   ALTER TABLE ONLY reserva.json
    ADD CONSTRAINT pk_reserva_json PRIMARY KEY (id);
 ?   ALTER TABLE ONLY reserva.json DROP CONSTRAINT pk_reserva_json;
       reserva            postgres    false    248            ?           2606    18730    reserva pk_reserva_reserva 
   CONSTRAINT     Y   ALTER TABLE ONLY reserva.reserva
    ADD CONSTRAINT pk_reserva_reserva PRIMARY KEY (id);
 E   ALTER TABLE ONLY reserva.reserva DROP CONSTRAINT pk_reserva_reserva;
       reserva            postgres    false    208            ?           2606    18732    reservas pk_reserva_reservas 
   CONSTRAINT     [   ALTER TABLE ONLY reserva.reservas
    ADD CONSTRAINT pk_reserva_reservas PRIMARY KEY (id);
 G   ALTER TABLE ONLY reserva.reservas DROP CONSTRAINT pk_reserva_reservas;
       reserva            postgres    false    206                       2606    18734    serie pk_reserva_series 
   CONSTRAINT     V   ALTER TABLE ONLY reserva.serie
    ADD CONSTRAINT pk_reserva_series PRIMARY KEY (id);
 B   ALTER TABLE ONLY reserva.serie DROP CONSTRAINT pk_reserva_series;
       reserva            postgres    false    253                       2606    18736    auditoria pk_security_auditoria 
   CONSTRAINT     _   ALTER TABLE ONLY security.auditoria
    ADD CONSTRAINT pk_security_auditoria PRIMARY KEY (id);
 K   ALTER TABLE ONLY security.auditoria DROP CONSTRAINT pk_security_auditoria;
       security            postgres    false    255                       2606    18738 %   autenication pk_security_autenication 
   CONSTRAINT     e   ALTER TABLE ONLY security.autenication
    ADD CONSTRAINT pk_security_autenication PRIMARY KEY (id);
 Q   ALTER TABLE ONLY security.autenication DROP CONSTRAINT pk_security_autenication;
       security            postgres    false    257                       2606    18740 "   token_repureacion_usuario pk_token 
   CONSTRAINT     a   ALTER TABLE ONLY usuario.token_repureacion_usuario
    ADD CONSTRAINT pk_token PRIMARY KEY (id);
 M   ALTER TABLE ONLY usuario.token_repureacion_usuario DROP CONSTRAINT pk_token;
       usuario            postgres    false    233            ?           2606    18742    catalogo pk_usuario_catalogo 
   CONSTRAINT     [   ALTER TABLE ONLY usuario.catalogo
    ADD CONSTRAINT pk_usuario_catalogo PRIMARY KEY (id);
 G   ALTER TABLE ONLY usuario.catalogo DROP CONSTRAINT pk_usuario_catalogo;
       usuario            postgres    false    230            ?           2606    18744    rol pk_usuario_rol 
   CONSTRAINT     Q   ALTER TABLE ONLY usuario.rol
    ADD CONSTRAINT pk_usuario_rol PRIMARY KEY (id);
 =   ALTER TABLE ONLY usuario.rol DROP CONSTRAINT pk_usuario_rol;
       usuario            postgres    false    231                       2606    18746    servicio pk_usuario_servicio 
   CONSTRAINT     [   ALTER TABLE ONLY usuario.servicio
    ADD CONSTRAINT pk_usuario_servicio PRIMARY KEY (id);
 G   ALTER TABLE ONLY usuario.servicio DROP CONSTRAINT pk_usuario_servicio;
       usuario            postgres    false    232                       2606    18748    usuario pk_usuario_usuario 
   CONSTRAINT     Y   ALTER TABLE ONLY usuario.usuario
    ADD CONSTRAINT pk_usuario_usuario PRIMARY KEY (id);
 E   ALTER TABLE ONLY usuario.usuario DROP CONSTRAINT pk_usuario_usuario;
       usuario            postgres    false    234                       2606    18750 ,   usuario_servicio pk_usuario_usuario_servicio 
   CONSTRAINT     ?   ALTER TABLE ONLY usuario.usuario_servicio
    ADD CONSTRAINT pk_usuario_usuario_servicio PRIMARY KEY (id_usuario, id_servicio);
 W   ALTER TABLE ONLY usuario.usuario_servicio DROP CONSTRAINT pk_usuario_usuario_servicio;
       usuario            postgres    false    235    235                       2620    18751    alerta tg_reserva_alerta    TRIGGER     ?   CREATE TRIGGER tg_reserva_alerta AFTER INSERT OR DELETE OR UPDATE ON reserva.alerta FOR EACH ROW EXECUTE FUNCTION security.f_log_auditoria();
 2   DROP TRIGGER tg_reserva_alerta ON reserva.alerta;
       reserva          postgres    false    229    352                       2620    18752    reserva tg_reserva_reserva    TRIGGER     ?   CREATE TRIGGER tg_reserva_reserva AFTER INSERT OR DELETE OR UPDATE ON reserva.reserva FOR EACH ROW EXECUTE FUNCTION security.f_log_auditoria();
 4   DROP TRIGGER tg_reserva_reserva ON reserva.reserva;
       reserva          postgres    false    352    208                       2620    18753    catalogo tg_usuario_catalogo    TRIGGER     ?   CREATE TRIGGER tg_usuario_catalogo AFTER INSERT OR DELETE OR UPDATE ON usuario.catalogo FOR EACH ROW EXECUTE FUNCTION security.f_log_auditoria();
 6   DROP TRIGGER tg_usuario_catalogo ON usuario.catalogo;
       usuario          postgres    false    352    230                       2620    18754    rol tg_usuario_rol    TRIGGER     ?   CREATE TRIGGER tg_usuario_rol AFTER INSERT OR DELETE OR UPDATE ON usuario.rol FOR EACH ROW EXECUTE FUNCTION security.f_log_auditoria();
 ,   DROP TRIGGER tg_usuario_rol ON usuario.rol;
       usuario          postgres    false    231    352                       2620    18755    servicio tg_usuario_servicio    TRIGGER     ?   CREATE TRIGGER tg_usuario_servicio AFTER INSERT OR DELETE OR UPDATE ON usuario.servicio FOR EACH ROW EXECUTE FUNCTION security.f_log_auditoria();
 6   DROP TRIGGER tg_usuario_servicio ON usuario.servicio;
       usuario          postgres    false    352    232                       2620    18756 >   token_repureacion_usuario tg_usuario_token_repureacion_usuario    TRIGGER     ?   CREATE TRIGGER tg_usuario_token_repureacion_usuario AFTER INSERT OR DELETE OR UPDATE ON usuario.token_repureacion_usuario FOR EACH ROW EXECUTE FUNCTION security.f_log_auditoria();
 X   DROP TRIGGER tg_usuario_token_repureacion_usuario ON usuario.token_repureacion_usuario;
       usuario          postgres    false    352    233                       2620    18757    usuario tg_usuario_usuario    TRIGGER     ?   CREATE TRIGGER tg_usuario_usuario AFTER INSERT OR DELETE OR UPDATE ON usuario.usuario FOR EACH ROW EXECUTE FUNCTION security.f_log_auditoria();
 4   DROP TRIGGER tg_usuario_usuario ON usuario.usuario;
       usuario          postgres    false    234    352                       2620    18758 ,   usuario_servicio tg_usuario_usuario_servicio    TRIGGER     ?   CREATE TRIGGER tg_usuario_usuario_servicio AFTER INSERT OR DELETE OR UPDATE ON usuario.usuario_servicio FOR EACH ROW EXECUTE FUNCTION security.f_log_auditoria();
 F   DROP TRIGGER tg_usuario_usuario_servicio ON usuario.usuario_servicio;
       usuario          postgres    false    235    352                       2606    18759    reserva fk_reserva_usuario    FK CONSTRAINT     ?   ALTER TABLE ONLY reserva.reserva
    ADD CONSTRAINT fk_reserva_usuario FOREIGN KEY (id_usuario) REFERENCES usuario.usuario(id);
 E   ALTER TABLE ONLY reserva.reserva DROP CONSTRAINT fk_reserva_usuario;
       reserva          postgres    false    208    234    3077                       2606    18764 2   horario_estilista fk_reservas_usuario_estilista_id    FK CONSTRAINT     ?   ALTER TABLE ONLY reserva.horario_estilista
    ADD CONSTRAINT fk_reservas_usuario_estilista_id FOREIGN KEY (estilista_id) REFERENCES usuario.usuario(id);
 ]   ALTER TABLE ONLY reserva.horario_estilista DROP CONSTRAINT fk_reservas_usuario_estilista_id;
       reserva          postgres    false    215    234    3077                       2606    18769    catalogo fk_catalogo_usuario    FK CONSTRAINT     ?   ALTER TABLE ONLY usuario.catalogo
    ADD CONSTRAINT fk_catalogo_usuario FOREIGN KEY (id_usuario) REFERENCES usuario.usuario(id);
 G   ALTER TABLE ONLY usuario.catalogo DROP CONSTRAINT fk_catalogo_usuario;
       usuario          postgres    false    230    234    3077                       2606    18774    usuario fk_usuario_rol    FK CONSTRAINT     t   ALTER TABLE ONLY usuario.usuario
    ADD CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol) REFERENCES usuario.rol(id);
 A   ALTER TABLE ONLY usuario.usuario DROP CONSTRAINT fk_usuario_rol;
       usuario          postgres    false    234    231    3071            ?   ?   x????1co? ?o?Tp?ڻ??ݚk?h?#8 1"?y?'?h????R$SpH?983????I?Tnl?}?	?v??em??u\?+?????:???[????>?R?"w?=p??|Ϳ/?_?+ xk?m?      ?      x?????? ? ?      ?      x?????? ? ?      ?      x?????? ? ?      ?      x?????? ? ?      ?      x?????? ? ?      ?      x?????? ? ?      ?   ?  x?͘Kr?6???)?c?|?&??bRSSɌ???\ 	ɰI?D?R*?K?K$K??dQ"4[?p!??bw??A8?@?? ??F	?~?8't??????娱?0Jo?q?K?WՃy ?qf??*?y\?jm3#?????oD??0?L??((?ޛd??w?'KY?L	L(???Y)T?g???hi"????
?]??h?t?9?r????*]??]???E-?B??=??B??w!9?U߲??8
H??1U?7?l???dY?\?o?E?Zae%??Q???ꦖf?z~O????C?-m??iL??y?????]=k?)?]ܔ:WS%{M^8?BaBQ?b?f<"??7?٭??D?J%?E?(8?ajpC??h=&?p?ALy???~?%???([?9?2g?[q?6???p?L?B۳R???*?N? ???\\?;??TY????+T?k?,uu?'??Q???(N??W?$?&4?CJ??$Z?D.p?ѲoL?i?iȝ?H?ޅN??W?6?2??Q??Z6q?"x?4=oj-.?????LA???`y???Vt> ?? ?<?؏1A???k?@[??l???G?5??Gzo??ߧs?RLLN3̭IO??Q4??2˲??I,D?>?\^8?M?2?F??*'??	M??G>??rB?.'ẋ9!,?B'su_#??\?f??mpz?.m]?A??:7'??0??????˅?C?b$"q???r>>h?pB??P??????g>?r??a>??A??	?^䴙??̲&o2?
l?G?@1`?a>?Q?????.???傓#Je?tP?Y ?=s????????R????ۢW{???K#Ϳnr%?????
?Y{???:n;)?w?*????	}JO?K@?=???8?1???jm?(d?r+̓?ﬀk?Bj_???-??a?~Ҽ?b?????ec???8y#P???u??i???????~.?<?'4
P?U?B?o9??:??9?EN???~?f?"ˇ?I?=???rs)5?$?9???O1<??.l\?o??mr^?x{Ť+?_AK??9?0?m?p??Id?v*
???P?x?8Aԏ?B>???????^??1:\c??n?ֵ1?Mp~??? aB???Ed??ӗ??W???=?ժ?????Gk??<??j?RwY?? &??^p??Mv?ݎ?v??^???̕?i??7F?wY٣?g??M+??i=???J?ʽI}$??^4???`?ǁy]???y?ɞ?4h??<@$ڗ?J?T?+t=?n?^?ZW*-??%?W?:?ݵ???m7????Uɼ1???'?'??A??U???Nsk????9??ޤ?5t??q??????????????^H??n?;?؞qP???%? ?ɸ?b??RYc??Ҙ?)=?́?g?0F;#6$ʿ?˃?ڃ??g??ǥ?_ކ?.??0?<???yS|X???g?7???mao-?????1y?      ?   n   x?????0г3`?;	?"z???JT? :=T???@?3c?,s?	i?-??J/??:??V,????um~?ۺ??WC=jm???i????X?-??t????*?      ?      x?????? ? ?      ?   q   x?}?=?0@??9'??)??,	v?H?U??]ٿ?ׁŝ3k?E@<b?B?΢????y2=?V?~΂?O???*gK??Ȕ?!?n?ecʕ????????<&??s3l<I      ?   r   x?-?1?0 ??y????qUe?,m?JP?@M??a`??֩??o??0Ԃ??s??q"?Y?&Ǒ???]?[???????\?y???3?"?????礏ZҜ???Ƙ/??"b      ?      x?????? ? ?      ?   ?   x?M?K?@?u?)? ?+O?	،@$0>???&??ū?/?????w'V??S?|?ʢ?~?>??6????q?b7U:??%hr?]??DJI)A??:&D(?*?~???@???1A????h?İ?mkC;??Bq?q?????J3>fl?"?S?B< 	?7      ?      x?????? ? ?     