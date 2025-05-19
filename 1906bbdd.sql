-- ===============================
-- ELIMINAR CONSTRAINTS Y TABLAS
-- ===============================

-- Primero eliminar la tabla más dependiente (tiene muchas FK)
DROP TABLE IF EXISTS app_general_properties;

-- Luego eliminar las tablas que tienen FK referenciadas por app_general_properties
DROP TABLE IF EXISTS microservice_properties_directory;
DROP TABLE IF EXISTS datastage_properties_directory;
DROP TABLE IF EXISTS database_properties_directory;
DROP TABLE IF EXISTS was_properties_directory;
DROP TABLE IF EXISTS pims_properties_directory;

-- Tablas de directorios referenciadas directamente
DROP TABLE IF EXISTS project_directory;
DROP TABLE IF EXISTS app_directory;
DROP TABLE IF EXISTS appname_directory;
DROP TABLE IF EXISTS env_directory;
DROP TABLE IF EXISTS country_directory;
DROP TABLE IF EXISTS label_directory;
DROP TABLE IF EXISTS app_type_directory;
DROP TABLE IF EXISTS pipeline_properties_directory;
DROP TABLE IF EXISTS runtime_directory;
DROP TABLE IF EXISTS person_in_charge;
DROP TABLE IF EXISTS security_champion;

-- Tablas secundarias usadas en microservice_properties_directory
DROP TABLE IF EXISTS usage_directory;
DROP TABLE IF EXISTS token_directory;
DROP TABLE IF EXISTS openshift_properties_directory;
DROP TABLE IF EXISTS path_directory;
DROP TABLE IF EXISTS image_directory;

-- Confirmación
PRINT 'Todas las tablas han sido eliminadas correctamente.';


-- ========================================
-- ELIMINACIÓN DE TABLAS (ORDEN CORRECTO)
-- ========================================

-- ========================================
-- ELIMINAR CONSTRAINTS MANUALMENTE
-- ========================================

CREATE TABLE project_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    project_acronym VARCHAR(100) NOT NULL
);

CREATE TABLE appname_directory (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    app VARCHAR(100) NOT NULL
);

CREATE TABLE app_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_appname UNIQUEIDENTIFIER REFERENCES appname_directory(id),
    repo_name VARCHAR(100) NOT NULL,
    repo_url VARCHAR(100) NOT NULL
);

CREATE TABLE env_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    env VARCHAR(100) NOT NULL
);

CREATE TABLE country_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    country VARCHAR(100)
);

CREATE TABLE label_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    app_label VARCHAR(100) NOT NULL
);

CREATE TABLE app_type_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    app_type VARCHAR(100) NOT NULL
);

CREATE TABLE pipeline_properties_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    securitygate BIT DEFAULT 1,
    unittests BIT DEFAULT 1,
    sonarqube BIT DEFAULT 1,
    qualitygate BIT DEFAULT 1
);

CREATE TABLE runtime_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    runtime_name VARCHAR(100) NOT NULL,
    version_path VARCHAR(100) NOT NULL
);

CREATE TABLE person_in_charge (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE security_champion (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE token_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    token TEXT,
    namespace_name VARCHAR(100)
);

CREATE TABLE openshift_properties_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    secrets_enabled BIT DEFAULT 1,
    configmap_enabled BIT DEFAULT 1,
    volume_enabled BIT DEFAULT 1
);

CREATE TABLE usage_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    usage VARCHAR(100)
);

CREATE TABLE image_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    image_name VARCHAR(100)
);

CREATE TABLE path_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    volume_path VARCHAR(100)
);

CREATE TABLE microservice_properties_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_usage INT,
    cpulimits VARCHAR(100),
    cpurequest VARCHAR(100),
    memorylimits VARCHAR(100),
    memoryrequest VARCHAR(100),
    replicas INT,
    id_token INT,
    id_openshift_properties_directory INT,
    id_path_directory INT,
    drs_enabled BIT DEFAULT 0,
    id_image_directory INT
);

CREATE TABLE datastage_properties_directory (
    id INT IDENTITY(1,1) PRIMARY KEY
);

CREATE TABLE database_properties_directory (
    id INT IDENTITY(1,1) PRIMARY KEY
);

CREATE TABLE was_properties_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    host VARCHAR(100),
    instance_name VARCHAR(100),
    context_root VARCHAR(100)
);

CREATE TABLE pims_properties_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nexus_url VARCHAR(100)
);

CREATE TABLE app_general_properties (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_project_directory INT REFERENCES project_directory(id),
    id_app_directory INT REFERENCES app_directory(id),
    id_person_in_charge INT REFERENCES person_in_charge(id),
    id_security_champion INT REFERENCES security_champion(id),
    id_env_directory INT REFERENCES env_directory(id),
    id_country_directory INT REFERENCES country_directory(id),
    id_label_directory INT REFERENCES label_directory(id),
    id_app_type_directory INT REFERENCES app_type_directory(id),
    id_pipeline_properties_directory INT REFERENCES pipeline_properties_directory(id),
    id_runtime_directory INT REFERENCES runtime_directory(id),
    sonarqubepath_exec VARCHAR(100),
    id_microservice_directory INT REFERENCES microservice_properties_directory(id),
    id_datastage_properties_directory INT REFERENCES datastage_properties_directory(id),
    id_database_properties_directory INT REFERENCES database_properties_directory(id),
    id_was_properties_directory INT REFERENCES was_properties_directory(id),
    id_pims_properties_directory INT REFERENCES pims_properties_directory(id)
);
