library(dplyr)

# 1 - Parte 1 -------------------------------------------------------------

# 1. Importar datasets
ventas <- readr::read_csv("../Desktop/NEOLAND2/5. R/3. Dplyr/Automotriz/ventas.csv")
clientes <- readr::read_csv("../Desktop/NEOLAND2/5. R/3. Dplyr/Automotriz/clientes.csv")
modelos <- readr::read_csv("../Desktop/NEOLAND2/5. R/3. Dplyr/Automotriz/modelos.csv")

# 2. Generar un dataframe con las columnas Fecha, Estado y Precio de las ventas ordenadas de mayor a menor en función del precio
df_ordenado_precio <- ventas %>%
  select(Fecha, Estado, Precio) %>%
  arrange(desc(Precio))

df_ordenado_precio

# 3. Ordenar el dataframe anterior por Fecha de más antiguo a mas reciente, y en caso de que dos registros tengan la misma fecha, ordenarlos por Precio de mayor a menor.
df_ordenado_fecha_precio <- df_ordenado_precio %>%
  arrange(Fecha, desc(Precio))

df_ordenado_fecha_precio

# 4. Mostrar una tabla con todos los Estados y IdModelos diferentes
tabla_estados_modelos <- ventas %>%
  distinct(Estado, IdModelo)

tabla_estados_modelos

# 5. Mostrar todos los registros de ventas de coches nuevos
ventas_nuevos <- ventas %>%
  filter(Estado == "Nuevo")

ventas_nuevos

# 6. Mostrar la cantidad de coches vendidos por estado
cantidad_ventas_por_estado <- ventas %>%
  group_by(Estado) %>%
  summarise(Cantidad = n())

cantidad_ventas_por_estado

# 7. Mostrar la cantidad de coches vendidos y facturación por año de fabricación de coche y por estado.
ventas_por_anio_estado <- ventas %>%
  group_by(Year, Estado) %>%
  summarise(Cantidad = n(), Facturacion = sum(Precio))

ventas_por_anio_estado

# 8. Mostrar todas las ventas de coches de segunda mano que sean modelo 2020, o coches Nuevos que hayan sido comprados antes del "2019-12-31" y que se hayan vendido por un precio mayor a 40000 euros
ventas_filtradas <- ventas %>%
  filter(
    (Estado == "Segunda Mano" & Year == 2020) | 
    (Estado == "Nuevo" & Fecha < as.Date("2019-12-31") & Precio > 40000)
  )

ventas_filtradas

# 9. Agregar una columna que se llame “Gama” que compare el precio de venta del auto frente al promedio general
# a. “Gama baja” si el precio de venta es inferior al 75% del precio promedio.
# b. “Gama alta” si el precio de venta es superior al 125% del precio promedio.
# c. “Gama media” en caso contrario


ventas_con_gama_general <- ventas %>%
  mutate(
    Gama = case_when(
      Precio < 0.75 * mean(Precio) ~ "Gama baja",
      Precio > 1.25 * mean(Precio) ~ "Gama alta",
      TRUE ~ "Gama media"
    )
  )

ventas_con_gama_general

# 10. Agregar una columna que se llame “Gama” que compare el precio de venta del auto frente al promedio de los autos fabricados en su mismo año
# a. “Gama baja” si el precio de venta es inferior al 75% del precio promedio.
# b. “Gama alta” si el precio de venta es superior al 125% del precio promedio.
# c. “Gama media” en caso contrario

ventas_con_gama_por_anio <- ventas %>%
  group_by(Year) %>%
  mutate(PromedioPorAnio = mean(Precio)) %>%
  ungroup() %>%
  mutate(Gama = case_when(
    Precio < 0.75 * PromedioPorAnio ~ "Gama baja",
    Precio > 1.25 * PromedioPorAnio ~ "Gama alta",
    TRUE ~ "Gama media"
  )) %>%
  select(-PromedioPorAnio)

# 11. Crear un dataframe que sea igual a la tabla ventas, pero que todas las columnas que empiecen con “Id” sean del tipo de dato integer

ventas_con_id_enteros <- ventas %>%
  mutate(across(starts_with("Id"), as.integer))


# 2 - Parte 2 -------------------------------------------------------------

# 1. Mostrar la cantidad de ventas realizadas por cada marca
ventas_por_marca <- ventas %>%
  left_join(modelos %>% select(IdModelo, Marca), by = "IdModelo") %>%
  group_by(Marca) %>%
  summarise(CantidadVentas = n())

# 2. Mostrar el precio promedio de venta y la cantidad de autos vendidos para cada modelo
precio_promedio_por_modelo <- ventas %>%
  left_join(modelos %>% select(IdModelo, Modelo), by = "IdModelo") %>%
  group_by(Modelo) %>%
  summarise(
    PrecioPromedio = mean(Precio), 
    CantidadVentas = n()
  )

# 3. Identificar el cliente que ha realizado la compra más cara y mostrar sus detalles (IdCliente, Nombre, Precio)
cliente_compra_mas_cara <- ventas %>%
  filter(Precio == max(Precio)) %>%
  left_join(clientes %>% select(IdCliente, Nombre), by = "IdCliente") %>%
  select(IdCliente, Nombre, Precio)

# 4. Mostrar el precio promedio de venta para autos nuevos y usados por cada marca
precio_promedio_por_estado_y_marca <- ventas %>%
  left_join(modelos %>% select(IdModelo, Marca), by = "IdModelo") %>%
  group_by(Marca, Estado) %>%
  summarise(PrecioPromedio = mean(Precio))

# 5.	Contar cuantos coches modelo Corola fueron vendidos

modelos_corola <- ventas %>% 
  left_join(modelos %>% select(IdModelo, Modelo), by = "IdModelo") %>% 
  filter(Modelo == "Corolla") %>% 
  count()

# 6.	Mostrar en una tabla cual fue el fue el coche vendido más caro por cada marca y a quien fue vendido

ventas %>%
  left_join(modelos %>% select(IdModelo, Marca, Modelo), by = "IdModelo") %>%
  group_by(Marca) %>% 
  filter(Precio == max(Precio)) %>%
  left_join(clientes %>% select(IdCliente, Nombre), by = "IdCliente") %>% 
  select(Marca, Modelo, Precio, Nombre)

# 7.	Mostrar el top 5 de las provincias con más facturado en la historia

ventas %>% 
  left_join(clientes %>% select(IdCliente, ProvinciaResidencia), by = "IdCliente") %>% 
  group_by(ProvinciaResidencia) %>%  
  summarise(Facturacion = sum(Precio)) %>% 
  arrange(desc(Facturacion)) %>% 
  head(5)

# 8.	Mostrar el top 5 de las provincias con más facturado en la historia de clientes que no sean españoles y que no hayan comprado choches de la marca Chevrolet.

ventas %>% 
  left_join(modelos %>% select(IdModelo, Modelo), by = "IdModelo") %>% 
  left_join(clientes %>% select(IdCliente, Nacionalidad, ProvinciaResidencia), by = "IdCliente") %>% 
  filter(Modelo != "Chevrolet" & Nacionalidad != "ES") %>% 
  group_by(ProvinciaResidencia) %>%  
  summarise(Facturacion = sum(Precio)) %>% 
  arrange(desc(Facturacion)) %>% 
  head(5)

# 9.	Mostrar la cantidad de clientes diferentes que compraron coches Toyota en Zaragoza, desglosado por modelo, y la diferencia entre el precio promedio de venta vs el precio de lista promedio de los coches

ventas %>% 
  left_join(modelos %>% select(IdModelo, Marca, Modelo, PrecioLista), by = "IdModelo") %>% 
  left_join(clientes %>% select(IdCliente, Nacionalidad, ProvinciaResidencia), by = "IdCliente") %>% 
  filter(ProvinciaResidencia == "Zaragoza", Marca == "Toyota") %>% 
  group_by(Modelo) %>% 
  summarise(
    TotalVentas = n(),
    VentasClientesDiferentes = n_distinct(IdCliente),
    AvgPrecioLista = mean(PrecioLista),
    AvgPrecio = mean(Precio)
  ) %>% 
  mutate(
    DifPrecio = AvgPrecio - AvgPrecioLista
  )

# 10.	Mostrar la cantidad de clientes por provincia que nunca compraron un auto

clientes %>% 
  anti_join(ventas, by = "IdCliente") %>% 
  group_by(ProvinciaResidencia) %>%  
  summarise(Cantidad = n()) %>% 
  arrange(desc(Cantidad))

# 11.	Cual fue la venta con menor margen (Precio / PrecioLista) y 

ventas %>% 
  left_join(modelos %>% select(IdModelo, Marca, Modelo, PrecioLista), by = "IdModelo") %>% 
  left_join(clientes %>% select(IdCliente, Nombre), by = "IdCliente") %>% 
  mutate(Margen = Precio/PrecioLista - 1) %>% 
  filter(Margen == max(Margen)) %>% 
  select(Modelo, Nombre, Margen)
  
# 12. Mostrar el cliente que ha comprado la mayor cantidad de autos
cliente_con_mas_compras <- ventas %>%
  group_by(IdCliente) %>%
  summarise(CantidadCompras = n()) %>%
  ungroup() %>% 
  filter(CantidadCompras == max(CantidadCompras)) %>% 
  left_join(clientes %>% select(IdCliente, Nombre), by = "IdCliente") %>%
  select(IdCliente, Nombre, CantidadCompras)


# 13. Para cada cliente, mostrar el modelo de auto que ha comprado más veces
modelo_mas_comprado_por_cliente <- ventas %>%
  group_by(IdCliente) %>% 
  mutate(TotalComprado = n()) %>% 
  filter(TotalComprado > 1) %>% 
  ungroup() %>% 
  left_join(modelos %>% select(IdModelo, Modelo)) %>% 
  group_by(IdCliente, Modelo) %>%
  summarise(CantidadCompras = n()) 

