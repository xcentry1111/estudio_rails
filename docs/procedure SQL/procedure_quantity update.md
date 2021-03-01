# Procedimiento de actualizacion de cantidades

### Creacion de procedimiento
```sh
CREATE FUNCTION prc_mg_cantidades(idMigracion integer, ruta char) RETURNS integer
    LANGUAGE plpgsql
    AS $$DECLARE status INTEGER;
DECLARE
    l1 migraciones_cantidades%rowtype;
BEGIN
  if ruta = 'A' then
		update migraciones_cantidades set error = '*El id de la publicacion no existe'
		where  publicacion_id not in (select id from publications where id = migraciones_cantidades.publicacion_id)
		and    migracion_id = idMigracion
		and    aplicado is null;

	elsif ruta = 'B' then
		for l1 IN select * from migraciones_cantidades where migracion_id = idMigracion and aplicado is null
		loop
			update publications set cantidad_disponible = l1.cantidad_disponible
			where id = l1.publication_id;
			update migraciones_cantidades set aplicado = 'SI' where id = l1.id;
		end loop;
    end if;
  return 0;
  exception when others then
    return 1;
END;

$$;
```