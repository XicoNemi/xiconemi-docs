# 📘 Consultas SQL Avanzadas

Este documento contiene consultas SQL avanzadas utilizadas en el proyecto para obtener información clave de la base de datos.

---

## 🔹 Consulta 1: Calificación promedio de negocios

```sql
SELECT
  b.id AS businessId,
  b.name,
  ROUND(AVG(r.rating), 2) AS rating
FROM
  reviews r
JOIN
  businesses b ON r.businessId = b.id
GROUP BY
  b.id, b.name;
```

### Descripción
Esta consulta calcula la calificación promedio de cada negocio basado en las reseñas (`reviews`) asociadas.

- **Campos seleccionados**:
  - `businessId`: Identificador único del negocio.
  - `name`: Nombre del negocio.
  - `rating`: Calificación promedio redondeada a 2 decimales.
- **Joins**:
  - Une la tabla `reviews` con `businesses` utilizando el campo `businessId`.
- **Agrupación**:
  - Agrupa los resultados por `businessId` y `name` para calcular el promedio de las calificaciones.

---

## 🔹 Consulta 2: Total de clientes por plan

```sql
SELECT
  p.id AS planId,
  p.name AS planName,
  COUNT(s.planId) AS totalClients
FROM
  subscriptions s
JOIN
  plans p ON s.planId = p.id
GROUP BY
  p.id, p.name;
```

### Descripción
Esta consulta obtiene el número total de clientes suscritos a cada plan.

- **Campos seleccionados**:
  - `planId`: Identificador único del plan.
  - `planName`: Nombre del plan.
  - `totalClients`: Número total de clientes suscritos al plan.
- **Joins**:
  - Une la tabla `subscriptions` con `plans` utilizando el campo `planId`.
- **Agrupación**:
  - Agrupa los resultados por `planId` y `planName` para contar las suscripciones asociadas.

---

## 🔹 Consulta 3: Distribución de género de los usuarios

```sql
SELECT
  gender,
  COUNT(*) AS count,
  ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM users), 2) AS percentage
FROM
  users
GROUP BY
  gender;
```

### Descripción
Esta consulta calcula la distribución de género de los usuarios en términos de cantidad y porcentaje.

- **Campos seleccionados**:
  - `gender`: Género de los usuarios.
  - `count`: Número total de usuarios por género.
  - `percentage`: Porcentaje de usuarios por género, redondeado a 2 decimales.
- **Subconsulta**:
  - `(SELECT COUNT(*) FROM users)`: Obtiene el total de usuarios para calcular el porcentaje.
- **Agrupación**:
  - Agrupa los resultados por `gender` para contar y calcular el porcentaje.

---

## 🛠️ Notas Adicionales
- Estas consultas están optimizadas para obtener información clave de las tablas `reviews`, `businesses`, `subscriptions`, `plans`, y `users`.
- Asegúrate de que las tablas involucradas contengan los datos necesarios para que las consultas funcionen correctamente.
- Si necesitas modificar o extender estas consultas, asegúrate de probarlas en un entorno seguro antes de implementarlas en producción.
