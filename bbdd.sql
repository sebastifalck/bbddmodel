-- Tabla de aplicaciones centrada en appName
CREATE TABLE aplicaciones (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE,
    proyecto VARCHAR(100),
    pais VARCHAR(100),
    repositorio VARCHAR(100),
    url_repositorio VARCHAR(255),
    etiqueta_ocp VARCHAR(50),
    version_base_image VARCHAR(50),
    secreto BOOLEAN,
    configmap BOOLEAN,
    volume BOOLEAN
);

-- Configuración por entorno con uso trasladado
CREATE TABLE configuraciones_entorno (
    id SERIAL PRIMARY KEY,
    app_id INT REFERENCES aplicaciones(id),
    entorno VARCHAR(10) CHECK (entorno IN ('dev', 'uat', 'prd')),
    uso VARCHAR(50),
    namespace VARCHAR(100),
    token VARCHAR(100),
    replicas INT,
    cpu_limits VARCHAR(20),
    cpu_requests VARCHAR(20),
    memory_limits VARCHAR(20),
    memory_requests VARCHAR(20)
);


INSERT INTO aplicaciones (
            id, nombre, proyecto, pais, repositorio, url_repositorio,
            etiqueta_ocp, version_base_image, secreto, configmap, volume
        ) VALUES (
            1, 'app1', 'proyecto1', 'Colombia',
            'Repo1', 'Urlrepo1', 'frontend',
            'jdk', TRUE,
            FALSE, FALSE
        );
INSERT INTO configuraciones_entorno (
            app_id, entorno, uso, namespace, token, replicas, cpu_limits, cpu_requests, memory_limits, memory_requests
        ) VALUES (
            1, 'dev', 'Internal', 'NameSpaceDev1', 'TokenDev1',
            1, '100m', '20m',
            '200Mi', '100Mi'
        );
INSERT INTO configuraciones_entorno (
            app_id, entorno, uso, namespace, token, replicas, cpu_limits, cpu_requests, memory_limits, memory_requests
        ) VALUES (
            1, 'uat', 'Internal', 'NameSpaceUat1', 'TokenUat1',
            1, '100m', '20m',
            '200Mi', '100Mi'
        );
INSERT INTO configuraciones_entorno (
            app_id, entorno, uso, namespace, token, replicas, cpu_limits, cpu_requests, memory_limits, memory_requests
        ) VALUES (
            1, 'prd', 'Internal', 'NameSpacePrd1', 'TokenPrd1',
            1, '100m', '20m',
            '200Mi', '100Mi'
        );
INSERT INTO aplicaciones (
            id, nombre, proyecto, pais, repositorio, url_repositorio,
            etiqueta_ocp, version_base_image, secreto, configmap, volume
        ) VALUES (
            2, 'app2', 'proyecto1', 'Colombia',
            'Repo2', 'Urlrepo2', 'backend',
            'nginx', FALSE,
            FALSE, TRUE
        );
INSERT INTO configuraciones_entorno (
            app_id, entorno, uso, namespace, token, replicas, cpu_limits, cpu_requests, memory_limits, memory_requests
        ) VALUES (
            2, 'dev', 'External', 'NameSpaceDev1', 'TokenDev1',
            5, '200m', '50m',
            '100Mi', '40Mi'
        );
INSERT INTO configuraciones_entorno (
            app_id, entorno, uso, namespace, token, replicas, cpu_limits, cpu_requests, memory_limits, memory_requests
        ) VALUES (
            2, 'uat', 'External', 'NameSpaceUat1', 'TokenUat1',
            5, '200m', '50m',
            '100Mi', '40Mi'
        );
INSERT INTO configuraciones_entorno (
            app_id, entorno, uso, namespace, token, replicas, cpu_limits, cpu_requests, memory_limits, memory_requests
        ) VALUES (
            2, 'prd', 'External', 'NameSpacePrd1', 'TokenPrd1',
            5, '200m', '50m',
            '100Mi', '40Mi'
        );
INSERT INTO aplicaciones (
            id, nombre, proyecto, pais, repositorio, url_repositorio,
            etiqueta_ocp, version_base_image, secreto, configmap, volume
        ) VALUES (
            3, 'app3', 'proyecto2', 'Chile',
            'Repo3', 'Urlrepo3', 'frontend',
            'nginx', TRUE,
            TRUE, FALSE
        );
INSERT INTO configuraciones_entorno (
            app_id, entorno, uso, namespace, token, replicas, cpu_limits, cpu_requests, memory_limits, memory_requests
        ) VALUES (
            3, 'dev', 'Internal', 'NameSpaceDev2', 'TokenDev2',
            3, '400m', '200m',
            '20Mi', '10Mi'
        );
INSERT INTO configuraciones_entorno (
            app_id, entorno, uso, namespace, token, replicas, cpu_limits, cpu_requests, memory_limits, memory_requests
        ) VALUES (
            3, 'uat', 'Internal', 'NameSpaceUat2', 'TokenUat2',
            3, '400m', '200m',
            '20Mi', '10Mi'
        );
INSERT INTO configuraciones_entorno (
            app_id, entorno, uso, namespace, token, replicas, cpu_limits, cpu_requests, memory_limits, memory_requests
        ) VALUES (
            3, 'prd', 'Internal', 'NameSpacePrd2', 'TokenPrd2',
            3, '400m', '200m',
            '20Mi', '10Mi'
        );
INSERT INTO aplicaciones (
            id, nombre, proyecto, pais, repositorio, url_repositorio,
            etiqueta_ocp, version_base_image, secreto, configmap, volume
        ) VALUES (
            4, 'app4', 'proyecto2', 'Chile',
            'Repo4', 'Urlrepo4', 'backend',
            'jdk', FALSE,
            FALSE, TRUE
        );
INSERT INTO configuraciones_entorno (
            app_id, entorno, uso, namespace, token, replicas, cpu_limits, cpu_requests, memory_limits, memory_requests
        ) VALUES (
            4, 'dev', 'Internal', 'NameSpaceDev2', 'TokenDev2',
            2, '50m', '20m',
            '40Mi', '20Mi'
        );
INSERT INTO configuraciones_entorno (
            app_id, entorno, uso, namespace, token, replicas, cpu_limits, cpu_requests, memory_limits, memory_requests
        ) VALUES (
            4, 'uat', 'Internal', 'NameSpaceUat2', 'TokenUat2',
            2, '50m', '20m',
            '40Mi', '20Mi'
        );
INSERT INTO configuraciones_entorno (
            app_id, entorno, uso, namespace, token, replicas, cpu_limits, cpu_requests, memory_limits, memory_requests
        ) VALUES (
            4, 'prd', 'Internal', 'NameSpacePrd2', 'TokenPrd2',
            2, '50m', '20m',
            '40Mi', '20Mi'
        );
INSERT INTO aplicaciones (
            id, nombre, proyecto, pais, repositorio, url_repositorio,
            etiqueta_ocp, version_base_image, secreto, configmap, volume
        ) VALUES (
            5, 'app5', 'proyecto3', 'Brasil',
            'Repo5', 'Urlrepo5', 'frontend',
            'nginx', TRUE,
            FALSE, FALSE
        );
INSERT INTO configuraciones_entorno (
            app_id, entorno, uso, namespace, token, replicas, cpu_limits, cpu_requests, memory_limits, memory_requests
        ) VALUES (
            5, 'dev', 'External', 'NameSpaceDev3', 'TokenDev3',
            1, '150m', '100m',
            '100Mi', '40Mi'
        );
INSERT INTO configuraciones_entorno (
            app_id, entorno, uso, namespace, token, replicas, cpu_limits, cpu_requests, memory_limits, memory_requests
        ) VALUES (
            5, 'uat', 'External', 'NameSpaceUat3', 'TokenUat3',
            1, '150m', '100m',
            '100Mi', '40Mi'
        );
INSERT INTO configuraciones_entorno (
            app_id, entorno, uso, namespace, token, replicas, cpu_limits, cpu_requests, memory_limits, memory_requests
        ) VALUES (
            5, 'prd', 'External', 'NameSpacePrd3', 'TokenPrd3',
            1, '150m', '100m',
            '100Mi', '40Mi'
        );
