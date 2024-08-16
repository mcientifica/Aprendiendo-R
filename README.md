# Aprendiendo-R
Empresa Automotriz
La empresa NeoCar se dedica a la venta de autos nuevos y de segunda mano. Cuenta con la información de la base 
de clientes, ventas y modelos para responder las siguientes preguntas. Solo se podrán utilizar funciones de dplyr para 
responder:
Parte 1
1. Importar datasets ventas.csv, clientes.csv y modelos.csv
2. Generar un dataframe con las columnas Fecha, Estado y Precio de las ventas ordenadas de mayor a menor en 
función del precio.
3. Ordenar el dataframe anterior por Fecha de más antiguo a mas reciente, y en caso de que dos registros 
tengan la misma fecha, ordenarlos por Precio de mayor a menor.
4. Mostrar una tabla con todos los Estados e IdModelos diferentes.
5. Mostrar todos los registros de ventas de coches nuevos.
6. Mostrar la cantidad de coches vendidos por estado.
7. Mostrar la cantidad de coches vendidos y facturación por año de fabricación de coche y por estado.
8. Mostrar todas las ventas de coches de segunda mano que sean modelo 2020, o coches Nuevos que hayan 
sido comprados antes del “2019-12-31” y que se hayan vendido por un precio mayor a 40000 euros.
9. Agregar una columna que se llame “Gama” que compare el precio de venta del auto frente al promedio 
general que sea:
a. “Gama baja” si el precio de venta es inferior al 75% del precio promedio.
b. “Gama alta” si el precio de venta es superior al 125% del precio promedio.
c. “Gama media” en caso contrario.
10. Agregar una columna que se llame “Gama” que compare el precio de venta del auto frente al promedio de 
los autos fabricados en su mismo año que sea:
a. “Gama baja” si el precio de venta es inferior al 75% del precio promedio.
b. “Gama alta” si el precio de venta es superior al 125% del precio promedio.
c. “Gama media” en caso contrario.
11. Crear un dataframe que sea igual a la tabla ventas, pero que todas las columnas que empiecen con “Id” sean 
del tipo de dato integer.
Parte 2
1. Mostrar la cantidad de ventas realizadas por cada marca.
2. Mostrar el precio promedio de venta y la cantidad de autos vendidos para cada modelo.
3. Identificar el cliente que ha realizado la compra más cara y mostrar sus detalles (IdCliente, Nombre, Precio).
4. Mostrar el precio promedio de venta para autos nuevos y usados por cada marca.
5. Contar cuantos coches modelo Corolla fueron vendidos.
6. Mostrar en una tabla cual fue el fue el coche vendido más caro por cada marca y a quien fue vendido.
7. Mostrar el top 5 de las provincias con más facturado en la historia.
8. Mostrar el top 5 de las provincias con más facturado en la historia de clientes que no sean españoles y que 
no hayan comprado coches de la marca Chevrolet.
9. Mostrar la cantidad de clientes diferentes que compraron coches Toyota en Zaragoza, desglosado por 
modelo, y la diferencia entre el precio promedio de venta vs el precio de lista promedio de los coches.
10. Mostrar la cantidad de clientes por provincia que nunca compraron un coche.
11. Cual fue la venta con menor margen (Precio / PrecioLista - 1) y que modelo de coche y cliente fue.
12. Mostrar los clientes que hayan comprado la mayor cantidad de coches.
13. Para cada cliente que haya realizado más de una compra, mostrar cuantos coches compró de cada modelo
