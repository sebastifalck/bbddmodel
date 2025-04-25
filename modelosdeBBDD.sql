-- Paso 1: Borrar datos desde tablas más dependientes
DELETE FROM microservice_environment_properties;
DELETE FROM microservice_properties;
DELETE FROM app_directory;

DELETE FROM namespace_directory;
DELETE FROM environment_type;
DELETE FROM usage_directory;
DELETE FROM path_directory;
DELETE FROM image_directory;
DELETE FROM labelocp_directory;
DELETE FROM environment_directory;

DELETE FROM country_directory;
DELETE FROM project_directory;
DELETE FROM project_type;
DELETE FROM person_in_charge;

-- Paso 2: Reiniciar IDs (IDENTITY)
DBCC CHECKIDENT ('microservice_environment_properties', RESEED, 0);
DBCC CHECKIDENT ('microservice_properties', RESEED, 0);
DBCC CHECKIDENT ('app_directory', RESEED, 0);
DBCC CHECKIDENT ('namespace_directory', RESEED, 0);
DBCC CHECKIDENT ('environment_type', RESEED, 0);
DBCC CHECKIDENT ('usage_directory', RESEED, 0);
DBCC CHECKIDENT ('path_directory', RESEED, 0);
DBCC CHECKIDENT ('image_directory', RESEED, 0);
DBCC CHECKIDENT ('labelocp_directory', RESEED, 0);
DBCC CHECKIDENT ('environment_directory', RESEED, 0);
DBCC CHECKIDENT ('country_directory', RESEED, 0);
DBCC CHECKIDENT ('project_directory', RESEED, 0);
DBCC CHECKIDENT ('project_type', RESEED, 0);
DBCC CHECKIDENT ('person_in_charge', RESEED, 0);




CREATE TABLE person_in_charge (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE project_type (
    id INT IDENTITY(1,1) PRIMARY KEY,
    project_type VARCHAR(100)
);

CREATE TABLE project_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL
);

CREATE TABLE country_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    country VARCHAR(100)
);


CREATE TABLE app_directory (
	id INT IDENTITY(1,1) PRIMARY KEY,
	id_personincharge INT REFERENCES person_in_charge(id),
	appname VARCHAR(100) NOT NULL,
	id_project_type INT REFERENCES project_type(id),
	id_project INT REFERENCES project_directory(id),
	id_country INT REFERENCES country_directory(id),
	repositorio VARCHAR(100) NOT NULL,
	url_repositorio VARCHAR(255) NOT NULL
);

CREATE TABLE environment_directory (
	id INT IDENTITY(1,1) PRIMARY KEY,
	environment VARCHAR(100) NOT NULL
);

CREATE TABLE labelocp_directory (
	id INT IDENTITY(1,1) PRIMARY KEY,
	ocplabel VARCHAR(100) NOT NULL
);

CREATE TABLE image_directory (
	id INT IDENTITY(1,1) PRIMARY KEY,
	image_name VARCHAR(100) NOT NULL
);

CREATE TABLE path_directory (
	id INT IDENTITY(1,1) PRIMARY KEY,
	path_name VARCHAR(100) NOT NULL
);

CREATE TABLE microservice_properties (
	id INT IDENTITY(1,1) PRIMARY KEY,
	id_label INT REFERENCES labelocp_directory(id),
	id_image INT REFERENCES image_directory(id),
	id_path INT REFERENCES path_directory(id),
	configmap BIT DEFAULT 0, -- por defecto será false
	secrets BIT DEFAULT 0,
	volume BIT DEFAULT 0,
	sonar_exclusions VARCHAR(100),
	runtimeversion VARCHAR(100),
	nodeversion VARCHAR(100),
);

CREATE TABLE usage_directory (
	id INT IDENTITY(1,1) PRIMARY KEY,
	usage VARCHAR(100) NOT NULL
);

CREATE TABLE environment_type (
	id INT IDENTITY(1,1) PRIMARY KEY,
	environment_type VARCHAR(100)
);

CREATE TABLE namespace_directory (
	id INT IDENTITY(1,1) PRIMARY KEY,
	namespace_name VARCHAR(100),
	token TEXT
);


CREATE TABLE microservice_environment_properties (
	id INT IDENTITY(1,1) PRIMARY KEY,
	id_properties INT REFERENCES microservice_properties(id),
	id_environment INT REFERENCES environment_type(id),
	unit_tests BIT DEFAULT 1, -- por defecto será false
	sonarqube BIT DEFAULT 1,
	security_gate BIT DEFAULT 1,
	id_usage INT REFERENCES environment_type(id),
	id_namespace INT REFERENCES namespace_directory,
	cpu_limits VARCHAR(100),
	cpu_request VARCHAR(100),
	memory_limits VARCHAR(100),
	memory_request VARCHAR(100)
);


-- Insertar personas a cargo
INSERT INTO person_in_charge (nombre, email) VALUES
('Carlos Mendoza', 'carlos.mendoza@example.com'),
('Laura Ruiz', 'laura.ruiz@example.com'),
('Ana Torres', 'ana.torres@example.com');

SELECT * FROM person_in_charge;

-- Insertar tipos de proyecto
INSERT INTO project_type (project_type) VALUES
('Microservice'),
('WAS');

SELECT * FROM project_type;

-- Insertar nombres de proyecto
INSERT INTO project_directory (project_name) VALUES
('CHLWEBBENEFICIARIOS'),
('CHLPEP'),
('CHLONEINSURANCEINTERNOBACKEND');

SELECT * FROM project_directory;

-- Insertar países
INSERT INTO country_directory (country) VALUES
('Chile'),
('Colombia'),
('Latam'),
('Peru'),
('Brasil'),
('Mexico');

SELECT * FROM country_directory;

-- Insertar aplicaciones
INSERT INTO app_directory (id_personincharge, appname, id_project_type, id_project, id_country, repositorio, url_repositorio) VALUES
(1, 'ShopEase', 1, 1, 1, 'gitlab', 'https://gitlab.com/company/shopease'),
(2, 'TalentManager', 2, 2, 2, 'github', 'https://github.com/company/talentmanager'),
(3, 'DataVision', 2, 3, 3, 'bitbucket', 'https://bitbucket.org/company/datavision');

SELECT * FROM app_directory;

-- Insertar entornos
INSERT INTO environment_type (environment_type) VALUES
('Dev'),
('Uat'),
('Prd');

SELECT * FROM environment_type;

-- Insertar etiquetas OCP
INSERT INTO labelocp_directory (ocplabel) VALUES
('APP=frontend'),
('APP=backend'); -- corregido 'backtend' a 'backend'

SELECT * FROM labelocp_directory;

-- Insertar imágenes
INSERT INTO image_directory (image_name) VALUES
('nginx-122-regional'),
('nginx-124-regional'),
('nodejs-20-regional'),
('openjdk-17-runtime-regional'),
('openjdk-17-runtime-regional-fonts'),
('openjdk-8-runtime-regional');

SELECT * FROM image_directory;

-- Insertar paths
INSERT INTO path_directory (path_name) VALUES
('/deployment/cert'),
('/deployments/cert'),
('/opt/app-root/certs/');

SELECT * FROM path_directory;

-- Insertar propiedades de microservicios
INSERT INTO microservice_properties (id_label, id_image, id_path, configmap, secrets, volume, sonar_exclusions, runtimeversion, nodeversion) VALUES
(1, 1, 1, 1, 1, 0, 'node_modules,test/', 'Java 11', '14.17.0'),
(2, 2, 2, 0, 1, 1, 'coverage,logs', 'Node.js 16', '16.13.0'),
(1, 3, 3, 1, 0, 1, 'test,docs', 'Python 3.9', NULL); -- corregido id_label a uno válido

SELECT * FROM microservice_properties;

-- Insertar tipos de uso
INSERT INTO usage_directory (usage) VALUES
('Internal'),
('External');

SELECT * FROM usage_directory;

-- Insertar namespaces
INSERT INTO namespace_directory (namespace_name, token) VALUES
('namespace-dev', 'token_dev_abc123'),
('namespace-qa', 'token_qa_def456'),
('namespace-prod', 'token_prod_ghi789');

SELECT * FROM namespace_directory;

-- Insertar propiedades de microservicio por entorno
INSERT INTO microservice_environment_properties (id_properties, id_environment, unit_tests, sonarqube, security_gate, id_usage, id_namespace, cpu_limits, cpu_request, memory_limits, memory_request) VALUES
(1, 1, 1, 1, 0, 1, 1, '500m', '250m', '512Mi', '256Mi'),
(2, 2, 1, 1, 1, 2, 2, '1', '500m', '1Gi', '512Mi'),
(3, 2, 1, 0, 1, 2, 3, '2', '1', '2Gi', '1Gi'); -- corregido id_usage a valor existente

SELECT * FROM microservice_environment_properties;



DECLARE @appname VARCHAR(100) = 'ShopEase';
DECLARE @ambiente VARCHAR(100) = 'Dev';

SELECT
    ad.appname,
    ed.environment,
    pic.nombre AS responsable,
    pic.email AS email_responsable,
    pt.project_type,
    pd.project_name,
    cd.country,
    ad.repositorio,
    ad.url_repositorio,
    mp.configmap,
    mp.secrets,
    mp.volume,
    mp.sonar_exclusions,
    mp.runtimeversion,
    mp.nodeversion,
    ld.ocplabel,
    id.image_name,
    pad.path_name,
    mep.unit_tests,
    mep.sonarqube,
    mep.security_gate,
    ud.usage,
    ns.namespace_name,
    ns.token,
    mep.cpu_limits,
    mep.cpu_request,
    mep.memory_limits,
    mep.memory_request
FROM app_directory ad
INNER JOIN person_in_charge pic ON ad.id_personincharge = pic.id
INNER JOIN project_type pt ON ad.id_project_type = pt.id
INNER JOIN project_directory pd ON ad.id_project = pd.id
INNER JOIN country_directory cd ON ad.id_country = cd.id
INNER JOIN microservice_properties mp ON mp.id = (
    SELECT TOP 1 mep.id_properties
    FROM microservice_environment_properties mep
    INNER JOIN environment_type et ON mep.id_environment = et.id
    WHERE et.environment_type = @ambiente
)
INNER JOIN microservice_environment_properties mep ON mep.id_properties = mp.id
INNER JOIN environment_type et ON mep.id_environment = et.id
INNER JOIN labelocp_directory ld ON mp.id_label = ld.id
INNER JOIN image_directory id ON mp.id_image = id.id
INNER JOIN path_directory pad ON mp.id_path = pad.id
INNER JOIN usage_directory ud ON mep.id_usage = ud.id
INNER JOIN namespace_directory ns ON mep.id_namespace = ns.id
INNER JOIN environment_directory ed ON ed.environment = et.environment_type
WHERE ad.appname = @appname
AND et.environment_type = @ambiente;



-- Luego ejecuta la consulta anterior.





