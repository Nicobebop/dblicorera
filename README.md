# README
# 🏪 dbLicorera – Diseño de base de datos

## 📌 Descripción

**dbLicorera** es un proyecto académico enfocado en el diseño y desarrollo de una base de datos para la gestión de información de una licorera.

El proyecto busca organizar la información relacionada con productos, marcas, sucursales, ciudades, tipos de sucursal e inventarios, aplicando conceptos de bases de datos relacionales, modelado de datos y normalización.

Actualmente, el proyecto parte de un modelo relacional desarrollado en SQL y contempla su adaptación a MongoDB como parte del proceso de aprendizaje de diferentes tecnologías de bases de datos.

## 🎯 Objetivos

- Diseñar una estructura de base de datos organizada y consistente.
- Establecer relaciones entre las diferentes entidades del sistema.
- Implementar claves primarias (PK) y claves foráneas (FK).
- Aplicar principios de normalización hasta la tercera forma normal (3FN).
- Explorar la adaptación de un modelo relacional a una base de datos NoSQL.

## 🗄️ Estructura de la base de datos

El modelo relacional está compuesto por las siguientes tablas:

| Tabla | Descripción |
|---|---|
| `Ciudad` | Almacena información de las ciudades. |
| `TipoSucursal` | Clasifica los tipos de sucursales. |
| `Marca` | Contiene las marcas de los productos. |
| `Producto` | Almacena la información de los productos. |
| `Sucursal` | Registra las sucursales de la licorera. |
| `Inventario` | Relaciona los productos con las sucursales y permite organizar su inventario. |

La tabla `Inventario` funciona como entidad intermedia entre `Producto` y `Sucursal`, permitiendo establecer la relación entre los productos disponibles y las diferentes sucursales.

## 🛠️ Tecnologías y herramientas

- **SQL:** diseño y estructuración de la base de datos relacional.
- **MongoDB Compass:** herramienta utilizada para explorar la adaptación del proyecto a MongoDB.
- **GitHub:** almacenamiento y control del proyecto.

## 📚 Conceptos aplicados

- Modelado de bases de datos relacionales.
- Relaciones entre tablas.
- Claves primarias y foráneas.
- Integridad referencial.
- Normalización de datos hasta 3FN.
- Exploración de bases de datos NoSQL.

## 🚧 Estado del proyecto

**En desarrollo.**

El modelo relacional en SQL constituye la base del proyecto. Actualmente se está trabajando en su adaptación a MongoDB, con el propósito de comprender las diferencias entre el almacenamiento relacional y el orientado a documentos.

## 👨‍💻 Autor

**Nicolás Quinchia Echeverri**

Estudiante de Tecnología en Desarrollo de Software  
Institución Universitaria Pascual Bravo

Proyecto desarrollado con fines académicos y de aprendizaje.
