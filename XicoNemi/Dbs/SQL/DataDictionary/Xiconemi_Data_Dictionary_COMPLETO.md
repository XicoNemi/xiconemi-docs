## Tabla: `businesses`

**Descripción:**  
La tabla almacena información sobre los negocios locales de Xicotepec, incluyendo datos como nombre, categoría, dirección, contacto y redes sociales, con el fin de promoverlos a través de la plataforma Xiconemi.

| Column name      | DataType                                                        | PK | NN | UQ | RN | UN | ZF | AI | Default | Comment |
|------------------|------------------------------------------------------------------|----|----|----|----|----|----|----|---------|---------|
| `id`             | INT                                                              | ✓  | ✓  |    |    |    |    | ✓  |         | Identificador principal del conjunto de registros. <br> **Naturaleza:** Cualitativo. <br> **Composición:** Caracteres hexadecimales. <br> **Dominio:** 36f8(0-f)8+'-'+4(0-f)4+'-'+4(0-f)4+'-'+4(0-f)4+'-'+12(0-f)12 |
| `ownerId`        | INT                                                              |    | ✓  |    |    |    |    |    |         | Identificador del propietario del negocio. <br> **Naturaleza:** Cualitativo. <br> **Composición:** Caracteres hexadecimales. <br> **Dominio:** 36f8(0-f)8+'-'+4(0-f)4+'-'+4(0-f)4+'-'+4(0-f)4+'-'+12(0-f)12 |
| `name`           | VARCHAR(191)                                                    |    | ✓  |    |    |    |    |    |         | Nombre que sirve para identificar el negocio. <br> **Naturaleza:** Cualitativo. <br> **Composición:** Alfanumérico. <br> **Dominio:** Máximo 191 caracteres. |
| `description`    | VARCHAR(191)                                                    |    | ✓  |    |    |    |    |    |         | Breve descripción del negocio. <br> **Naturaleza:** Cualitativo. <br> **Composición:** Alfanumérico y especiales. <br> **Dominio:** Máximo 191 caracteres. |
| `url_image`      | VARCHAR(191)                                                    |    |    |    |    |    |    |    |         | URL de la imagen del negocio. <br> **Naturaleza:** Cualitativo. <br> **Dominio:** URL válida (http/https) de hasta 191 caracteres. |
| `category`       | ENUM('Hospedaje', 'Gastronomia', 'Eventos', 'Turismo', 'Itinerarios', 'Cine', 'Otro') |    | ✓  |    |    |    |    |    |         | Categoría del negocio. <br> **Naturaleza:** Cualitativo. <br> **Dominio:** Enumeración definida. |
| `address`        | VARCHAR(191)                                                    |    | ✓  |    |    |    |    |    |         | Dirección física del negocio. <br> **Naturaleza:** Cualitativo. <br> **Dominio:** Máximo 191 caracteres. |
| `tel`            | VARCHAR(191)                                                    |    | ✓  |    |    |    |    |    |         | Teléfono de contacto del negocio. <br> **Naturaleza:** Cualitativo. <br> **Dominio:** 10-15 dígitos. |
| `web_site`       | VARCHAR(191)                                                    |    |    |    |    |    |    |    |         | Sitio web del negocio. <br> **Naturaleza:** Cualitativo. <br> **Dominio:** URL válida de hasta 191 caracteres. |
| `social_networks`| JSON                                                             |    |    |    |    |    |    |    |         | Enlaces a redes sociales. <br> **Naturaleza:** Cualitativo. <br> **Dominio:** JSON con estructura URL. |
| `status`         | TINYINT(1)                                                      |    | ✓  |    |    |    |    |    | '0'     | Estado del negocio (activo/inactivo). <br> **Naturaleza:** Cualitativo. <br> **Dominio:** 0 (inactivo), 1 (activo). |



## Tabla: `events`

**Descripción:**  
La tabla `events` almacena información sobre los eventos programados en Xicotepec de Juárez, Puebla, que se promueven a través de la plataforma Xiconemi.

| Column name | DataType                                                                                   | PK | NN | UQ | RN | UN | ZF | AI | Default | Comment |
|-------------|---------------------------------------------------------------------------------------------|----|----|----|----|----|----|----|---------|---------|
| `id`        | INT                                                                                        | ✓  | ✓  |    |    |    |    | ✓  |         | Identificador único del evento. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Entero positivo autoincrementable. |
| `userId`    | INT                                                                                        |    | ✓  |    |    |    |    |    |         | ID del usuario que creó el evento. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Referencia a `users.id`. |
| `name`      | VARCHAR(191)                                                                               |    | ✓  |    |    |    |    |    |         | Nombre del evento. <br> **Naturaleza:** Cualitativo. <br> **Dominio:** Hasta 191 caracteres. |
| `startDate` | INT                                                                                        |    | ✓  |    |    |    |    |    |         | Fecha de inicio del evento. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Timestamp (YYYY-MM-DD HH:MM:SS). |
| `endDate`   | INT                                                                                        |    | ✓  |    |    |    |    |    |         | Fecha de fin del evento. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Timestamp (YYYY-MM-DD HH:MM:SS). |
| `status`    | TINYINT(1)                                                                                 |    | ✓  |    |    |    |    |    | '0'     | Estado del evento. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** 0 (inactivo), 1 (activo). |
| `type`      | ENUM('General', 'Cultural', 'Gastronomico', 'Aventura', 'Relax', 'Familiar', 'Otro')      |    | ✓  |    |    |    |    |    |         | Tipo del evento. <br> **Naturaleza:** Cualitativo. <br> **Dominio:** Enumeración predefinida. |



## Tabla: `itineraries`

**Descripción:**  
La tabla almacena los itinerarios creados por los usuarios en la plataforma Xiconemi, incluyendo nombre, fechas y estado.

| Column name | DataType     | PK | NN | UQ | RN | UN | ZF | AI | Default | Comment |
|-------------|--------------|----|----|----|----|----|----|----|---------|---------|
| `id`        | INT          | ✓  | ✓  |    |    |    |    | ✓  |         | Identificador único del itinerario. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Entero autoincrementable. |
| `userId`    | INT          |    | ✓  |    |    |    |    |    |         | Usuario que creó el itinerario. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Referencia a `users.id`. |
| `name`      | VARCHAR(191) |    | ✓  |    |    |    |    |    |         | Nombre del itinerario. <br> **Naturaleza:** Cualitativo. <br> **Dominio:** Hasta 191 caracteres. |
| `startDate` | INT          |    | ✓  |    |    |    |    |    |         | Fecha de inicio. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Timestamp. |
| `endDate`   | INT          |    | ✓  |    |    |    |    |    |         | Fecha de finalización. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Timestamp. |
| `status`    | TINYINT(1)   |    | ✓  |    |    |    |    |    | '0'     | Estado del itinerario. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** 0 (inactivo), 1 (activo). |



## Tabla: `locations`

**Descripción:**  
La tabla almacena las ubicaciones de negocios, eventos u otros puntos de interés en la plataforma Xiconemi.

| Column name | DataType       | PK | NN | UQ | RN | UN | ZF | AI | Default | Comment |
|-------------|----------------|----|----|----|----|----|----|----|---------|---------|
| `id`        | INT            | ✓  | ✓  |    |    |    |    | ✓  |         | Identificador único de la ubicación. <br> **Naturaleza:** Cuantitativo. |
| `street`    | VARCHAR(191)   |    | ✓  |    |    |    |    |    |         | Calle o referencia. <br> **Naturaleza:** Cualitativo. |
| `lat`       | DECIMAL(65,30) |    | ✓  |    |    |    |    |    |         | Coordenada de latitud. <br> **Naturaleza:** Cuantitativo. |
| `lng`       | DECIMAL(65,30) |    | ✓  |    |    |    |    |    |         | Coordenada de longitud. <br> **Naturaleza:** Cuantitativo. |



## Tabla: `plans`

**Descripción:**  
Almacena los diferentes planes disponibles en la plataforma Xiconemi.

| Column name | DataType     | PK | NN | UQ | RN | UN | ZF | AI | Default | Comment |
|-------------|--------------|----|----|----|----|----|----|----|---------|---------|
| `id`        | INT          | ✓  | ✓  |    |    |    |    | ✓  |         | ID del plan. <br> **Naturaleza:** Cuantitativo. |
| `name`      | VARCHAR(191) |    | ✓  |    |    |    |    |    |         | Nombre del plan. <br> **Naturaleza:** Cualitativo. |
| `price`     | DOUBLE       |    | ✓  |    |    |    |    |    |         | Precio del plan. <br> **Naturaleza:** Cuantitativo. |
| `features`  | VARCHAR(191) |    | ✓  |    |    |    |    |    |         | Características del plan. <br> **Naturaleza:** Cualitativo. |
| `status`    | TINYINT(1)   |    | ✓  |    |    |    |    |    | '0'     | Estado del plan. <br> **Naturaleza:** Cuantitativo. |



## Tabla: `promotions`

**Descripción:**  
La tabla almacena las promociones que ofrecen los negocios locales dentro de la plataforma Xiconemi.

| Column name | DataType     | PK | NN | UQ | RN | UN | ZF | AI | Default | Comment |
|-------------|--------------|----|----|----|----|----|----|----|---------|---------|
| `id`        | INT          | ✓  | ✓  |    |    |    |    | ✓  |         | Identificador único de la promoción. <br> **Naturaleza:** Cuantitativo. |
| `businessId`| INT          |    | ✓  |    |    |    |    |    |         | ID del negocio asociado. <br> **Naturaleza:** Cuantitativo. |
| `title`     | VARCHAR(191) |    | ✓  |    |    |    |    |    |         | Título de la promoción. <br> **Naturaleza:** Cualitativo. |
| `description`| TEXT        |    |    |    |    |    |    |    |         | Detalles de la promoción. <br> **Naturaleza:** Cualitativo. |
| `discount`  | DOUBLE       |    | ✓  |    |    |    |    |    |         | Porcentaje de descuento. <br> **Naturaleza:** Cuantitativo. |
| `startDate` | INT          |    | ✓  |    |    |    |    |    |         | Inicio de la promoción. <br> **Naturaleza:** Cuantitativo. |
| `endDate`   | INT          |    | ✓  |    |    |    |    |    |         | Fin de la promoción. <br> **Naturaleza:** Cuantitativo. |



## Tabla: `reviews`

**Descripción:**  
La tabla `reviews` contiene las reseñas y calificaciones que los usuarios dejan sobre los negocios listados en la plataforma Xiconemi, permitiendo retroalimentación y mejora continua.

| Column name | DataType     | PK | NN | UQ | RN | UN | ZF | AI | Default | Comment |
|-------------|--------------|----|----|----|----|----|----|----|---------|---------|
| `id`        | INT          | ✓  | ✓  |    |    |    |    | ✓  |         | Identificador único de la reseña. <br> **Naturaleza:** Cuantitativo. |
| `userId`    | INT          |    | ✓  |    |    |    |    |    |         | ID del usuario que escribió la reseña. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Relación con `users.id`. |
| `businessId`| INT          |    | ✓  |    |    |    |    |    |         | ID del negocio reseñado. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Relación con `businesses.id`. |
| `rating`    | INT          |    | ✓  |    |    |    |    |    |         | Puntuación dada al negocio (1 a 5). <br> **Naturaleza:** Cuantitativo. |
| `comment`   | TEXT         |    |    |    |    |    |    |    |         | Comentario escrito por el usuario. <br> **Naturaleza:** Cualitativo. |
| `createdAt` | INT          |    | ✓  |    |    |    |    |    |         | Fecha en que se hizo la reseña. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Timestamp. |




## Tabla: `routes`

**Descripción:**  
La tabla `routes` almacena las rutas turísticas diseñadas para recorrerse en senderismo o ciclismo dentro del municipio, permitiendo a los usuarios planear recorridos en la plataforma Xiconemi.

| Column name | DataType     | PK | NN | UQ | RN | UN | ZF | AI | Default | Comment |
|-------------|--------------|----|----|----|----|----|----|----|---------|---------|
| `id`        | INT          | ✓  | ✓  |    |    |    |    | ✓  |         | Identificador único de la ruta. <br> **Naturaleza:** Cuantitativo. |
| `userId`    | INT          |    | ✓  |    |    |    |    |    |         | ID del usuario que registró la ruta. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Relación con `users.id`. |
| `name`      | VARCHAR(191) |    | ✓  |    |    |    |    |    |         | Nombre de la ruta. <br> **Naturaleza:** Cualitativo. |
| `type`      | ENUM('Senderismo', 'Ciclismo') | | ✓ |  |  |  |  |  |     | Tipo de actividad para la ruta. <br> **Naturaleza:** Cualitativo. |
| `difficulty`| ENUM('Baja', 'Media', 'Alta') |    | ✓  |    |    |    |    |    | Nivel de dificultad de la ruta. <br> **Naturaleza:** Cualitativo. |
| `distance`  | DOUBLE       |    | ✓  |    |    |    |    |    |         | Distancia aproximada en kilómetros. <br> **Naturaleza:** Cuantitativo. |



## Tabla: `subscriptions`

**Descripción:**  
La tabla `subscriptions` gestiona las suscripciones de los usuarios a los planes premium dentro de la plataforma Xiconemi, incluyendo los períodos de validez, plan asociado y estado de la suscripción.

| Column name | DataType | PK | NN | UQ | RN | UN | ZF | AI | Default | Comment |
|-------------|----------|----|----|----|----|----|----|----|---------|---------|
| `id`        | INT      | ✓  | ✓  |    |    |    |    | ✓  |         | Identificador único de la suscripción. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Entero autoincrementable. |
| `userId`    | INT      |    | ✓  |    |    |    |    |    |         | ID del usuario suscrito. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Relación con `users.id`. |
| `planId`    | INT      |    | ✓  |    |    |    |    |    |         | ID del plan adquirido. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Relación con `plans.id`. |
| `startDate` | INT      |    | ✓  |    |    |    |    |    |         | Fecha de inicio de la suscripción. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Timestamp. |
| `endDate`   | INT      |    | ✓  |    |    |    |    |    |         | Fecha de finalización de la suscripción. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Timestamp. |
| `status`    | TINYINT(1)|    | ✓  |    |    |    |    |    | '1'     | Estado de la suscripción.



## Tabla: `users`

**Descripción:**  
La tabla `users` contiene la información de los usuarios registrados en la plataforma Xiconemi, ya sea que tengan el rol de turista o administrador.

| Column name | DataType     | PK | NN | UQ | RN | UN | ZF | AI | Default | Comment |
|-------------|--------------|----|----|----|----|----|----|----|---------|---------|
| `id`        | INT          | ✓  | ✓  |    |    |    |    | ✓  |         | Identificador único del usuario. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** Entero autoincrementable. |
| `name`      | VARCHAR(191) |    | ✓  |    |    |    |    |    |         | Nombre completo del usuario. <br> **Naturaleza:** Cualitativo. |
| `email`     | VARCHAR(191) |    | ✓  | ✓  |    |    |    |    |         | Correo electrónico del usuario. <br> **Naturaleza:** Cualitativo. <br> **Dominio:** Único. |
| `password`  | VARCHAR(191) |    | ✓  |    |    |    |    |    |         | Contraseña cifrada. <br> **Naturaleza:** Cualitativo. |
| `role`      | ENUM('turista', 'admin') |    | ✓  |    |    |    |    |    |         | Rol del usuario. <br> **Naturaleza:** Cualitativo. <br> **Dominio:** Rol específico dentro de la plataforma. |
| `status`    | TINYINT(1)   |    | ✓  |    |    |    |    |    | '1'     | Estado del usuario. <br> **Naturaleza:** Cuantitativo. <br> **Dominio:** 1 (activo), 0 (inactivo). |



