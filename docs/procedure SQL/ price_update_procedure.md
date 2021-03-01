# Procedimiento de actualización de precios

### Creacion de procedimiento
```sh
CREATE FUNCTION prc_mg_precios(idMigracion integer, ruta char) RETURNS integer
    LANGUAGE plpgsql
    AS $$DECLARE status INTEGER;
DECLARE
    l1 migraciones_precios%rowtype;
BEGIN
  if ruta = 'A' then
		update migraciones_precios set error = concat(error,' ','* El tipo de precio no es correcto')
		where  price_type not in (2,3) 
		and    migracion_id = idMigracion 
		and    aplicado is null;
		
		update migraciones_precios set error = concat(error,' - ','* El valor total no puede estar en 0')
		where  total = 0
		and    migracion_id = idMigracion 
		and    aplicado is null;
		
		update migraciones_precios set error = concat(error,' - ','* El valor subtotal no puede estar en 0')
		where  subtotal = 0
		and    migracion_id = idMigracion 
		and    aplicado is null;
		
		update migraciones_precios set error = concat(error,' - ','* El valor iva no puede estar en 0')
		where  iva = 0
		and    migracion_id = idMigracion 
		and    aplicado is null;
		
		update migraciones_precios set error = concat(error,' - ','* El valor original no puede estar en 0')
		where  valor_original = 0
		and    migracion_id = idMigracion 
		and    aplicado is null;
		
		update migraciones_precios set error = concat(error,' - ','* El el tipo de precio no coincide con los valores establecidos')
		where  price_type = 3
		and    discount_percentage = 0
		and    migracion_id = idMigracion 
		and    aplicado is null;
		
	elsif ruta = 'B' then	
		for l1 IN select * from migraciones_precios where migracion_id = idMigracion and aplicado is null
		loop
			update publications set price_type = l1.price_type, 
									 discount_percentage = l1.discount_percentage, 
									 total = l1.total, 
									 subtotal = l1.subtotal, 
									 iva = l1.iva, 
									 valor_original = l1.valor_original
			where id = l1.publication_id;
			update migraciones_precios set aplicado = 'SI' where id = l1.id;
		end loop;
    end if;
  return 0;
  exception when others then
    return 1;
END;

$$;
```