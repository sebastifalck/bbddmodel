-- =============================================
-- CREACIÓN DE TABLAS
-- =============================================

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

CREATE TABLE environment_type (
    id INT IDENTITY(1,1) PRIMARY KEY,
    environment_type VARCHAR(100)
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

CREATE TABLE usage_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    usage VARCHAR(100) NOT NULL
);

CREATE TABLE namespace_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    namespace_name VARCHAR(100),
    token TEXT
);

CREATE TABLE application_directory (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    appname VARCHAR(100) NOT NULL
);

CREATE TABLE runtime_directory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    runtime_name VARCHAR(100)
);


CREATE TABLE microservice_properties (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_appname UNIQUEIDENTIFIER REFERENCES application_directory(id),
    id_environment INT REFERENCES environment_type(id),
    unit_tests BIT DEFAULT 1,
    sonarqube BIT DEFAULT 1,
    security_gate BIT DEFAULT 1,
    id_usage INT REFERENCES usage_directory(id),
    id_namespace INT REFERENCES namespace_directory(id),
    cpu_limits VARCHAR(100),
    cpu_request VARCHAR(100),
    memory_limits VARCHAR(100),
    memory_request VARCHAR(100),
    id_label INT REFERENCES labelocp_directory(id),
    id_image INT REFERENCES image_directory(id),
    id_path INT REFERENCES path_directory(id),
    configmap BIT DEFAULT 0,
    secrets BIT DEFAULT 0,
    volume BIT DEFAULT 0,
    sonar_exclusions VARCHAR(100),
    id_runtimeversion INT REFERENCES runtime_directory(id),
);

CREATE TABLE was_properties (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_appname UNIQUEIDENTIFIER REFERENCES application_directory(id),
    ip_number VARCHAR(100) NOT NULL,
    port_number INT
);

CREATE TABLE app_general_properties (
    id UNIQUEIDENTIFIER PRIMARY KEY,
    id_personincharge INT REFERENCES person_in_charge(id),
    id_project_type INT REFERENCES project_type(id),
    id_project INT REFERENCES project_directory(id),
    id_country INT REFERENCES country_directory(id),
    repositorio VARCHAR(100) NOT NULL,
    url_repositorio VARCHAR(255) NOT NULL,
    id_microservice_properties INT REFERENCES microservice_properties(id),
    id_was_properties INT REFERENCES was_properties(id),
    FOREIGN KEY (id) REFERENCES application_directory(id)
);

-- =============================================
-- INSERCIÓN DE DATOS
-- =============================================

-- Catálogos básicos
INSERT INTO person_in_charge (nombre, email) VALUES
('Carlos Mendoza', 'carlos.mendoza@example.com'),
('Laura Ruiz', 'laura.ruiz@example.com'),
('Ana Torres', 'ana.torres@example.com');

INSERT INTO project_type (project_type) VALUES
('Microservice'),
('WAS');

INSERT INTO project_directory (project_name) VALUES
('E-CommercePlatform'),
('HRManagementSystem');

INSERT INTO country_directory (country) VALUES
('Colombia'),
('Chile');

INSERT INTO environment_type (environment_type) VALUES
('Dev'),
('QA'),
('Production');

INSERT INTO labelocp_directory (ocplabel) VALUES
('app=frontend'),
('app=backend');

INSERT INTO image_directory (image_name) VALUES
('nginx:1.23'),
('java-app:17');

INSERT INTO path_directory (path_name) VALUES
('/usr/src/app'),
('/opt/web');

INSERT INTO usage_directory (usage) VALUES
('internal'),
('external');

INSERT INTO namespace_directory (namespace_name, token) VALUES
('ecommerce-dev', 'token123ecom'),
('hr-qa', 'token456hr');

-- =============================================
-- Aplicaciones automáticas
-- =============================================

DECLARE @ShopEase UNIQUEIDENTIFIER = NEWID();
DECLARE @HRPortal UNIQUEIDENTIFIER = NEWID();
DECLARE @FinanceApp UNIQUEIDENTIFIER = NEWID();
DECLARE @CRMPortal UNIQUEIDENTIFIER = NEWID();

INSERT INTO application_directory (id, appname) VALUES
(@ShopEase, 'ShopEase'),
(@HRPortal, 'HRPortal'),
(@FinanceApp, 'FinanceApp'),
(@CRMPortal, 'CRMPortal');

-- =============================================
-- Propiedades técnicas
-- =============================================

-- Microservice Properties
INSERT INTO microservice_properties (
    id_appname, id_environment, unit_tests, sonarqube, security_gate,
    id_usage, id_namespace, cpu_limits, cpu_request, memory_limits, memory_request,
    id_label, id_image, id_path, configmap, secrets, volume, sonar_exclusions, runtimeversion, nodeversion
) VALUES
(@ShopEase, 1, 1, 1, 1, 1, 1, '500m', '300m', '512Mi', '256Mi', 1, 1, 1, 1, 1, 0, 'src/**/test/**', '18', '16'),
(@FinanceApp, 2, 1, 1, 1, 2, 2, '600m', '400m', '1Gi', '512Mi', 2, 2, 2, 1, 1, 0, 'finance/**', '20', '18');

-- WAS Properties
INSERT INTO was_properties (id_appname, ip_number, port_number) VALUES
(@HRPortal, '192.168.10.1', 9080),
(@CRMPortal, '192.168.10.2', 9081);

-- =============================================
-- app_directory (relación)
-- =============================================

-- ShopEase -> Microservice
INSERT INTO app_directory (
    id, id_personincharge, id_project_type, id_project, id_country,
    repositorio, url_repositorio, id_microservice_properties, id_was_properties
) VALUES (
    @ShopEase, 1, 1, 1, 1, 'gitlab', 'https://gitlab.com/company/shopease', 1, NULL
);

-- HRPortal -> WAS
INSERT INTO app_directory (
    id, id_personincharge, id_project_type, id_project, id_country,
    repositorio, url_repositorio, id_microservice_properties, id_was_properties
) VALUES (
    @HRPortal, 2, 2, 2, 2, 'github', 'https://github.com/company/hrportal', NULL, 1
);

-- FinanceApp -> Microservice
INSERT INTO app_directory (
    id, id_personincharge, id_project_type, id_project, id_country,
    repositorio, url_repositorio, id_microservice_properties, id_was_properties
) VALUES (
    @FinanceApp, 3, 1, 1, 1, 'bitbucket', 'https://bitbucket.org/company/financeapp', 2, NULL
);

-- CRMPortal -> WAS
INSERT INTO app_directory (
    id, id_personincharge, id_project_type, id_project, id_country,
    repositorio, url_repositorio, id_microservice_properties, id_was_properties
) VALUES (
    @CRMPortal, 3, 2, 2, 2, 'gitlab', 'https://gitlab.com/company/crmportal', NULL, 2
);


-------------------------------------------------------------------------

DECLARE @appname VARCHAR(100) = 'FinanceApp'; -- cambia el nombre de la aplicación aquí
DECLARE @environment VARCHAR(100) = 'Dev'; -- solo para microservicios

-- Consulta para MICRO Y WAS
SELECT 
    appd.appname,
    
    CASE 
        WHEN ad.id_microservice_properties IS NOT NULL THEN 'Microservice'
        WHEN ad.id_was_properties IS NOT NULL THEN 'WAS'
        ELSE 'Sin Clasificación'
    END AS tipo_aplicacion,
    
    ad.id AS id_app,
    ad.repositorio,
    ad.url_repositorio,
    pc.nombre AS responsable,
    pc.email AS email_responsable,
    pt.project_type,
    pd.project_name,
    cd.country,
    
    -- Propiedades específicas
    mp.cpu_limits,
    mp.cpu_request,
    mp.memory_limits,
    mp.memory_request,
    mp.unit_tests,
    mp.sonarqube,
    mp.security_gate,
    mp.configmap,
    mp.secrets,
    mp.volume,
    mp.sonar_exclusions,
    mp.runtimeversion,
    mp.nodeversion,
    et.environment_type,
    ud.usage,
    nd.namespace_name,
    nd.token,
    idc.image_name,
    ld.ocplabel,
    pdp.path_name,
    
    wp.ip_number,
    wp.port_number

FROM app_directory ad

INNER JOIN application_directory appd ON ad.id = appd.id
INNER JOIN person_in_charge pc ON ad.id_personincharge = pc.id
INNER JOIN project_type pt ON ad.id_project_type = pt.id
INNER JOIN project_directory pd ON ad.id_project = pd.id
INNER JOIN country_directory cd ON ad.id_country = cd.id

-- LEFT JOIN a microservice_properties (si aplica)
LEFT JOIN microservice_properties mp ON ad.id_microservice_properties = mp.id
LEFT JOIN environment_type et ON mp.id_environment = et.id
LEFT JOIN usage_directory ud ON mp.id_usage = ud.id
LEFT JOIN namespace_directory nd ON mp.id_namespace = nd.id
LEFT JOIN image_directory idc ON mp.id_image = idc.id
LEFT JOIN labelocp_directory ld ON mp.id_label = ld.id
LEFT JOIN path_directory pdp ON mp.id_path = pdp.id

-- LEFT JOIN a was_properties (si aplica)
LEFT JOIN was_properties wp ON ad.id_was_properties = wp.id

-- FILTROS
WHERE appd.appname = @appname
  AND (
    -- Si es microservicio, validar ambiente
    (ad.id_microservice_properties IS NULL) -- si no tiene microservice (es WAS)
    OR
    (ad.id_microservice_properties IS NOT NULL AND et.environment_type = @environment) -- si tiene microservice y coincide ambiente
  );

