CREATE OR REPLACE VIEW view_app_type_env_project AS
SELECT
    agp.id AS app_general_id,
    adn.id AS appname_id,
    adn.app AS app_name,
    atd.app_type AS app_type,
    env.env AS environment,
    pj.project_name
FROM app_general_properties agp
JOIN app_directory ad ON agp.id_app_directory = ad.id
JOIN appname_directory adn ON ad.id_appname = adn.id
JOIN app_type_directory atd ON agp.id_app_type_directory = atd.id
JOIN env_directory env ON agp.id_env_directory = env.id
JOIN project_directory pj ON agp.id_project_directory = pj.id;



CREATE OR REPLACE VIEW view_app_env_versus AS
SELECT
    adn.id AS appname_id,
    adn.app AS app_name,
    pj.id AS id_project_directory,
    pj.project_name,
    
    MAX(CASE WHEN env.env = 'dev' THEN agp.id END) AS dev_app_general_id,
    MAX(CASE WHEN env.env = 'qa' THEN agp.id END) AS qa_app_general_id,
    MAX(CASE WHEN env.env = 'prod' THEN agp.id END) AS prod_app_general_id

FROM app_general_properties agp
JOIN app_directory ad ON agp.id_app_directory = ad.id
JOIN appname_directory adn ON ad.id_appname = adn.id
JOIN project_directory pj ON agp.id_project_directory = pj.id
JOIN env_directory env ON agp.id_env_directory = env.id

GROUP BY adn.id, adn.app, pj.id, pj.project_name;

