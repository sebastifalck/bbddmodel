
-- ========================================
-- ELIMINACIÓN DE TABLAS (ORDEN CORRECTO)
-- ========================================

-- ========================================
-- ELIMINAR CONSTRAINTS MANUALMENTE
-- ========================================


-- ========================================
-- ELIMINACIÓN DE TABLAS (ORDEN CORRECTO)
-- ========================================
DROP TABLE IF EXISTS app_general_properties;
DROP TABLE IF EXISTS microservice_directory;
DROP TABLE IF EXISTS app_directory;
DROP TABLE IF EXISTS appname_directory;
DROP TABLE IF EXISTS project_directory;
DROP TABLE IF EXISTS env_directory;
DROP TABLE IF EXISTS country_directory;
DROP TABLE IF EXISTS label_directory;
DROP TABLE IF EXISTS app_type_directory;
DROP TABLE IF EXISTS pipeline_properties_directory;
DROP TABLE IF EXISTS runtime_directory;
DROP TABLE IF EXISTS person_in_charge;
DROP TABLE IF EXISTS security_champion;
DROP TABLE IF EXISTS token_directory;
DROP TABLE IF EXISTS openshift_properties_directory;
DROP TABLE IF EXISTS usage_directory;
DROP TABLE IF EXISTS image_directory;
DROP TABLE IF EXISTS path_directory;
DROP TABLE IF EXISTS ddbb_directory;
DROP TABLE IF EXISTS was_directory;
DROP TABLE IF EXISTS pims_directory;


-- =============================
-- CREACIÓN Y LLENADO DE TODAS LAS TABLAS
-- =============================

-- =============================
-- CREACIÓN DE TABLAS AUXILIARES
-- =============================

CREATE TABLE project_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    project_acronym VARCHAR(100) NOT NULL
);

CREATE TABLE appname_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    app VARCHAR(100) NOT NULL
);

CREATE TABLE app_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_appname INT REFERENCES appname_directory(id),
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
    sonarqube BIT DEFAULT 1
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
    secrets BIT DEFAULT 1,
    configmap BIT DEFAULT 1,
    volume BIT DEFAULT 1
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

CREATE TABLE microservice_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_usage_directory INT REFERENCES usage_directory(id),
    cpulimits VARCHAR(100),
    cpurequest VARCHAR(100),
    memorylimits VARCHAR(100),
    memoryrequest VARCHAR(100),
    replicas INT,
    id_token INT REFERENCES token_directory(id),
    id_openshift_properties_directory INT REFERENCES openshift_properties_directory(id),
    id_path_directory INT REFERENCES path_directory(id),
	drs_enabled BIT DEFAULT 0,
    id_image_directory INT REFERENCES image_directory(id)
);

CREATE TABLE ddbb_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    type_bbdd VARCHAR(100)
);

CREATE TABLE was_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    type_was VARCHAR(100)
);

CREATE TABLE pims_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    branch VARCHAR(100)
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
    id_microservice_directory INT REFERENCES microservice_directory(id),
    id_ddbb_directory INT REFERENCES ddbb_directory(id),
    id_was_directory INT REFERENCES was_directory(id),
    id_pims_directory INT REFERENCES pims_directory(id)
);



-- Tipos de Proyecto
INSERT INTO project_directory (project_name, project_acronym) VALUES 
('Customer Portal', 'CP'),
('Billing System', 'BS');

-- Nombres de Aplicaciones
INSERT INTO appname_directory (app) VALUES 
('app-customer'),
('app-billing'),
('db-customer'),
('was-billing'),
('pims-reports');

-- Tipos de Aplicación
INSERT INTO app_type_directory (app_type) VALUES 
('microservice'), ('ddbb'), ('was'), ('pims');

-- Repositorios
INSERT INTO app_directory (id_appname, repo_name, repo_url) VALUES 
(1, 'customer-service', 'http://git.local/repo/customer'),
(2, 'billing-service', 'http://git.local/repo/billing'),
(3, 'customer-db', 'http://git.local/repo/db-customer'),
(4, 'billing-was', 'http://git.local/repo/was-billing'),
(5, 'reports-pims', 'http://git.local/repo/pims-reports');

-- Ambientes
INSERT INTO env_directory (env) VALUES 
('dev'), ('qa'), ('prod');

-- Países
INSERT INTO country_directory (country) VALUES 
('Colombia'), ('México');

-- Etiquetas
INSERT INTO label_directory (app_label) VALUES 
('APP=backend'), ('APP=database'), ('APP=was'), ('APP=pims');

-- Pipeline properties
INSERT INTO pipeline_properties_directory DEFAULT VALUES;
INSERT INTO pipeline_properties_directory (securitygate, unittests, sonarqube) VALUES (0, 1, 1);

-- Runtime
INSERT INTO runtime_directory (runtime_name, version_path) VALUES 
('OpenJDK', '/jdk-17'), 
('NodeJS', '/node-18');

-- Responsables
INSERT INTO person_in_charge (nombre, email) VALUES 
('Carlos Dev', 'carlos@corp.com'),
('Ana QA', 'ana@corp.com');

-- Security Champion
INSERT INTO security_champion (nombre, email) VALUES 
('Laura Sec', 'laura@corp.com');

-- Token Directory
INSERT INTO token_directory (token, namespace_name) VALUES 
('token123', 'dev-ns'),
('token456', 'qa-ns');

-- OpenShift
INSERT INTO openshift_properties_directory DEFAULT VALUES;

-- Usage
INSERT INTO usage_directory (usage) VALUES 
('API'), ('Backend');

-- Image Directory
INSERT INTO image_directory (image_name) VALUES 
('openjdk:17'), ('node:18');

-- Path Directory
INSERT INTO path_directory (volume_path) VALUES 
('/deployments/certs');

-- Microservices
INSERT INTO microservice_directory (id_usage_directory, cpulimits, cpurequest, memorylimits, memoryrequest, replicas, id_token, id_openshift_properties_directory, id_path_directory, id_image_directory)
VALUES 
(1, '500m', '250m', '512Mi', '256Mi', 2, 1, 1, 1, 1), -- id = 1
(2, '300m', '100m', '256Mi', '128Mi', 1, 2, 1, 1, 2); -- id = 2

-- Bases de Datos
INSERT INTO ddbb_directory (type_bbdd) VALUES 
('PostgreSQL'), -- id = 1
('SQLServer');  -- id = 2

-- WAS
INSERT INTO was_directory (type_was) VALUES 
('Liberty'), -- id = 1
('Tomcat');  -- id = 2

-- PIMS
INSERT INTO pims_directory (branch) VALUES 
('main'), -- id = 1
('dev');  -- id = 2



-- MICROSERVICES
INSERT INTO app_general_properties (
    id_project_directory, id_app_directory, id_person_in_charge, id_security_champion,
    id_env_directory, id_country_directory, id_label_directory, id_app_type_directory,
    id_pipeline_properties_directory, id_runtime_directory, sonarqubepath_exec,
    id_microservice_directory, id_ddbb_directory, id_was_directory, id_pims_directory)
VALUES 
(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '/sonar/customer/dev', 1, NULL, NULL, NULL),
(1, 1, 1, 1, 2, 2, 1, 1, 1, 1, '/sonar/customer/qa', 1, NULL, NULL, NULL),
(1, 1, 1, 1, 3, 1, 1, 1, 1, 1, '/sonar/customer/prod', 1, NULL, NULL, NULL),

(1, 2, 1, 1, 1, 1, 1, 1, 1, 1, '/sonar/billing/dev', 2, NULL, NULL, NULL),
(1, 2, 1, 1, 2, 2, 1, 1, 1, 1, '/sonar/billing/qa', 2, NULL, NULL, NULL),
(1, 2, 1, 1, 3, 1, 1, 1, 1, 1, '/sonar/billing/prod', 2, NULL, NULL, NULL);

-- DDBB
INSERT INTO app_general_properties (
    id_project_directory, id_app_directory, id_person_in_charge, id_security_champion,
    id_env_directory, id_country_directory, id_label_directory, id_app_type_directory,
    id_pipeline_properties_directory, id_runtime_directory, sonarqubepath_exec,
    id_microservice_directory, id_ddbb_directory, id_was_directory, id_pims_directory)
VALUES 
(1, 3, 1, 1, 1, 1, 2, 2, 1, 1, '/sonar/db-customer/dev', NULL, 1, NULL, NULL),
(1, 3, 1, 1, 2, 2, 2, 2, 1, 1, '/sonar/db-customer/qa', NULL, 1, NULL, NULL),
(1, 3, 1, 1, 3, 1, 2, 2, 1, 1, '/sonar/db-customer/prod', NULL, 1, NULL, NULL);

-- WAS
INSERT INTO app_general_properties (
    id_project_directory, id_app_directory, id_person_in_charge, id_security_champion,
    id_env_directory, id_country_directory, id_label_directory, id_app_type_directory,
    id_pipeline_properties_directory, id_runtime_directory, sonarqubepath_exec,
    id_microservice_directory, id_ddbb_directory, id_was_directory, id_pims_directory)
VALUES 
(2, 4, 2, 1, 1, 1, 3, 3, 1, 1, '/sonar/was-billing/dev', NULL, NULL, 1, NULL),
(2, 4, 2, 1, 2, 2, 3, 3, 1, 1, '/sonar/was-billing/qa', NULL, NULL, 1, NULL),
(2, 4, 2, 1, 3, 1, 3, 3, 1, 1, '/sonar/was-billing/prod', NULL, NULL, 1, NULL);

-- PIMS
INSERT INTO app_general_properties (
    id_project_directory, id_app_directory, id_person_in_charge, id_security_champion,
    id_env_directory, id_country_directory, id_label_directory, id_app_type_directory,
    id_pipeline_properties_directory, id_runtime_directory, sonarqubepath_exec,
    id_microservice_directory, id_ddbb_directory, id_was_directory, id_pims_directory)
VALUES 
(2, 5, 2, 1, 1, 1, 4, 4, 1, 1, '/sonar/pims/dev', NULL, NULL, NULL, 1),
(2, 5, 2, 1, 2, 2, 4, 4, 1, 1, '/sonar/pims/qa', NULL, NULL, NULL, 1),
(2, 5, 2, 1, 3, 1, 4, 4, 1, 1, '/sonar/pims/prod', NULL, NULL, NULL, 1);
