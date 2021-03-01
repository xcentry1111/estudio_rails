# Procedimiento cargue de publicaciones

### Creacion de procedimiento
```sh

CREATE FUNCTION prc_mg_publicaciones(idMigracion integer, ruta char) RETURNS integer
    LANGUAGE plpgsql
    AS $$DECLARE status INTEGER;
DECLARE
    l1 migraciones_publicaciones%rowtype;
BEGIN
  if ruta = 'A' then
		update migraciones_publicaciones 
		set article_types = 0,
			visits_quantity = 0,
			publication_type = 0,
			rating = 0,
			available_days = 0,
			status = 0,
			company_id = user_id,
			city_id = 80,
			portafolio_id = (select distinct portafolio_id from users where id = migraciones_publicaciones.user_id),
			indicador_cargue = replace(indicador_cargue,'.0','')
		where migracion_id = idMigracion and aplicado is null;

		update migraciones_publicaciones set finish_date = now()::date+'3 month'::interval
		where finish_date is null and migracion_id = idMigracion and aplicado is null;

		for l1 IN select * from migraciones_publicaciones where migracion_id = idMigracion and aplicado is null
		loop
			if l1.discount_percentage > 0 and l1.price_type = 2 then
				update migraciones_publicaciones set error = concat(error,' - ','* El tipo de precio no es correcto porque el porcentaje es mayor a 0')
				where  price_type = 2
				and    discount_percentage > 0
				and    migracion_id = idMigracion
				and    aplicado is null;
			end if;
			if l1.discount_percentage = 0 and l1.price_type = 3 then
				update migraciones_publicaciones set error = concat(error,' - ','* El tipo de precio no es correcto porque el porcentaje , debe ser mayor a 0')
				where  price_type = 3
				and    discount_percentage = 0
				and    migracion_id = idMigracion
				and    aplicado is null;
			end if;
		end loop;

		-- Calcula los valores cuando un producto es con precio fijo
		update migraciones_publicaciones set total = valor_original,
				iva = CAST(valor_original * 0.19 as int),
				subtotal = valor_original - CAST(valor_original * 0.19 as int)
		where price_type = 2
		and discount_percentage = 0
		and migracion_id = idMigracion
		and aplicado is null;

		-- Calcula los valores cuando un producto es de tipo 3 (descuento)
		-- Calcula primero el total
		update migraciones_publicaciones
			set total = valor_original - cast((valor_original * discount_percentage) / 100 as int)
		where price_type = 3
		and discount_percentage > 0
		and migracion_id = idMigracion
		and aplicado is null;

		-- Calcula el subtotal y el iva
		update migraciones_publicaciones
			set iva = CAST(total * 0.19 as int),
				subtotal = total - CAST(total * 0.19 as int)
		where price_type = 3
		and discount_percentage > 0
		and migracion_id = idMigracion
		and aplicado is null;

	elsif ruta = 'B' then

		update migraciones_publicaciones set publication_id = nextval('publications_id_seq') where migracion_id = idMigracion and aplicado is null;

    end if;
  return 0;
  exception when others then
    return 1;
END;

$$;
```

