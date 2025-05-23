DROP VIEW IF EXISTS get_microservice_app_properties CASCADE;
DROP VIEW IF EXISTS get_was_app_properties CASCADE;
DROP VIEW IF EXISTS get_pims_app_properties CASCADE;
DROP VIEW IF EXISTS get_ddbb_app_properties CASCADE;
DROP VIEW IF EXISTS get_datastage_app_properties CASCADE;



-- =============================================================================================

CREATE OR REPLACE FUNCTION get_microservice_app_properties(p_id_app_directory INT)
RETURNS TABLE (
    app_general_id INT,
    app_name TEXT,
    repo_name TEXT,
    repo_url TEXT,
    project_name TEXT,
    project_acronym TEXT,
    person_in_charge TEXT,
    person_email TEXT,
    security_champion TEXT,
    security_email TEXT,
    env TEXT,
    country TEXT,
    app_label TEXT,
    app_type TEXT,
    pipeline_securitygate BOOLEAN,
    pipeline_unittests BOOLEAN,
    pipeline_sonarqube BOOLEAN,
    pipeline_qualitygate BOOLEAN,
    runtime_name TEXT,
    runtime_version TEXT,
    sonarqubepath_exec TEXT,
    usage TEXT,
    cpulimits TEXT,
    cpurequest TEXT,
    memorylimits TEXT,
    memoryrequest TEXT,
    replicas INT,
    token TEXT,
    namespace_name TEXT,
    secrets_enabled BOOLEAN,
    configmap_enabled BOOLEAN,
    volume_enabled BOOLEAN,
    volume_path TEXT,
    image_name TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        agp.id,
        appn.app,
        ad.repo_name,
        ad.repo_url,
        pj.project_name,
        pj.project_acronym,
        pic.nombre,
        pic.email,
        sc.nombre,
        sc.email,
        env.env,
        ct.country,
        lbl.app_label,
        apt.app_type,
        pp.securitygate,
        pp.unittests,
        pp.sonarqube,
        pp.qualitygate,
        rt.runtime_name,
        rt.version_path,
        agp.sonarqubepath_exec,
        u.usage,
        msd.cpulimits,
        msd.cpurequest,
        msd.memorylimits,
        msd.memoryrequest,
        msd.replicas,
        tok.token,
        tok.namespace_name,
        op.secrets_enabled,
        op.configmap_enabled,
        op.volume_enabled,
        pd.volume_path,
        img.image_name
    FROM app_general_properties agp
    JOIN app_directory ad ON agp.id_app_directory = ad.id
    JOIN appname_directory appn ON ad.id_appname = appn.id
    JOIN project_directory pj ON agp.id_project_directory = pj.id
    LEFT JOIN person_in_charge pic ON agp.id_person_in_charge = pic.id
    LEFT JOIN security_champion sc ON agp.id_security_champion = sc.id
    LEFT JOIN env_directory env ON agp.id_env_directory = env.id
    LEFT JOIN country_directory ct ON agp.id_country_directory = ct.id
    LEFT JOIN label_directory lbl ON agp.id_label_directory = lbl.id
    LEFT JOIN app_type_directory apt ON agp.id_app_type_directory = apt.id
    LEFT JOIN pipeline_properties_directory pp ON agp.id_pipeline_properties_directory = pp.id
    LEFT JOIN runtime_directory rt ON agp.id_runtime_directory = rt.id
    JOIN microservice_properties_directory msd ON agp.id_microservice_directory = msd.id
    LEFT JOIN usage_directory u ON msd.id_usage_directory = u.id
    LEFT JOIN token_directory tok ON msd.id_token_directory = tok.id
    LEFT JOIN openshift_properties_directory op ON msd.id_openshift_properties_directory = op.id
    LEFT JOIN path_directory pd ON msd.id_path_directory = pd.id
    LEFT JOIN image_directory img ON msd.id_image_directory = img.id
    WHERE agp.id_app_directory = p_id_app_directory;
END;
$$ LANGUAGE plpgsql;


-- =============================================================================================

CREATE OR REPLACE FUNCTION get_was_app_properties(p_id_app_directory INT)
RETURNS TABLE (
    app_general_id INT,
    app_name TEXT,
    repo_name TEXT,
    repo_url TEXT,
    project_name TEXT,
    project_acronym TEXT,
    person_in_charge TEXT,
    person_email TEXT,
    security_champion TEXT,
    security_email TEXT,
    env TEXT,
    country TEXT,
    app_label TEXT,
    app_type TEXT,
    pipeline_securitygate BOOLEAN,
    pipeline_unittests BOOLEAN,
    pipeline_sonarqube BOOLEAN,
    pipeline_qualitygate BOOLEAN,
    runtime_name TEXT,
    runtime_version TEXT,
    sonarqubepath_exec TEXT,
    host TEXT,
    instance_name TEXT,
    context_root TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        agp.id,
        appn.app,
        ad.repo_name,
        ad.repo_url,
        pj.project_name,
        pj.project_acronym,
        pic.nombre,
        pic.email,
        sc.nombre,
        sc.email,
        env.env,
        ct.country,
        lbl.app_label,
        apt.app_type,
        pp.securitygate,
        pp.unittests,
        pp.sonarqube,
        pp.qualitygate,
        rt.runtime_name,
        rt.version_path,
        agp.sonarqubepath_exec,
        was.host,
        was.instance_name,
        was.context_root
    FROM app_general_properties agp
    JOIN app_directory ad ON agp.id_app_directory = ad.id
    JOIN appname_directory appn ON ad.id_appname = appn.id
    JOIN project_directory pj ON agp.id_project_directory = pj.id
    LEFT JOIN person_in_charge pic ON agp.id_person_in_charge = pic.id
    LEFT JOIN security_champion sc ON agp.id_security_champion = sc.id
    LEFT JOIN env_directory env ON agp.id_env_directory = env.id
    LEFT JOIN country_directory ct ON agp.id_country_directory = ct.id
    LEFT JOIN label_directory lbl ON agp.id_label_directory = lbl.id
    LEFT JOIN app_type_directory apt ON agp.id_app_type_directory = apt.id
    LEFT JOIN pipeline_properties_directory pp ON agp.id_pipeline_properties_directory = pp.id
    LEFT JOIN runtime_directory rt ON agp.id_runtime_directory = rt.id
    JOIN was_properties_directory was ON agp.id_was_properties_directory = was.id
    WHERE agp.id_app_directory = p_id_app_directory;
END;
$$ LANGUAGE plpgsql;



-- =============================================================================================

CREATE OR REPLACE FUNCTION get_pims_app_properties(p_id_app_directory INT)
RETURNS TABLE (
    app_general_id INT,
    app_name TEXT,
    repo_name TEXT,
    repo_url TEXT,
    project_name TEXT,
    project_acronym TEXT,
    person_in_charge TEXT,
    person_email TEXT,
    security_champion TEXT,
    security_email TEXT,
    env TEXT,
    country TEXT,
    app_label TEXT,
    app_type TEXT,
    pipeline_securitygate BOOLEAN,
    pipeline_unittests BOOLEAN,
    pipeline_sonarqube BOOLEAN,
    pipeline_qualitygate BOOLEAN,
    runtime_name TEXT,
    runtime_version TEXT,
    sonarqubepath_exec TEXT,
    nexus_url TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        agp.id,
        appn.app,
        ad.repo_name,
        ad.repo_url,
        pj.project_name,
        pj.project_acronym,
        pic.nombre,
        pic.email,
        sc.nombre,
        sc.email,
        env.env,
        ct.country,
        lbl.app_label,
        apt.app_type,
        pp.securitygate,
        pp.unittests,
        pp.sonarqube,
        pp.qualitygate,
        rt.runtime_name,
        rt.version_path,
        agp.sonarqubepath_exec,
        pims.nexus_url
    FROM app_general_properties agp
    JOIN app_directory ad ON agp.id_app_directory = ad.id
    JOIN appname_directory appn ON ad.id_appname = appn.id
    JOIN project_directory pj ON agp.id_project_directory = pj.id
    LEFT JOIN person_in_charge pic ON agp.id_person_in_charge = pic.id
    LEFT JOIN security_champion sc ON agp.id_security_champion = sc.id
    LEFT JOIN env_directory env ON agp.id_env_directory = env.id
    LEFT JOIN country_directory ct ON agp.id_country_directory = ct.id
    LEFT JOIN label_directory lbl ON agp.id_label_directory = lbl.id
    LEFT JOIN app_type_directory apt ON agp.id_app_type_directory = apt.id
    LEFT JOIN pipeline_properties_directory pp ON agp.id_pipeline_properties_directory = pp.id
    LEFT JOIN runtime_directory rt ON agp.id_runtime_directory = rt.id
    JOIN pims_properties_directory pims ON agp.id_pims_properties_directory = pims.id
    WHERE agp.id_app_directory = p_id_app_directory;
END;
$$ LANGUAGE plpgsql;


-- =============================================================================================

CREATE OR REPLACE FUNCTION get_database_app_properties(p_id_app_directory INT)
RETURNS TABLE (
    app_general_id INT,
    app_name TEXT,
    repo_name TEXT,
    repo_url TEXT,
    project_name TEXT,
    project_acronym TEXT,
    person_in_charge TEXT,
    person_email TEXT,
    security_champion TEXT,
    security_email TEXT,
    env TEXT,
    country TEXT,
    app_label TEXT,
    app_type TEXT,
    pipeline_securitygate BOOLEAN,
    pipeline_unittests BOOLEAN,
    pipeline_sonarqube BOOLEAN,
    pipeline_qualitygate BOOLEAN,
    runtime_name TEXT,
    runtime_version TEXT,
    sonarqubepath_exec TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        agp.id,
        appn.app,
        ad.repo_name,
        ad.repo_url,
        pj.project_name,
        pj.project_acronym,
        pic.nombre,
        pic.email,
        sc.nombre,
        sc.email,
        env.env,
        ct.country,
        lbl.app_label,
        apt.app_type,
        pp.securitygate,
        pp.unittests,
        pp.sonarqube,
        pp.qualitygate,
        rt.runtime_name,
        rt.version_path,
        agp.sonarqubepath_exec
    FROM app_general_properties agp
    JOIN app_directory ad ON agp.id_app_directory = ad.id
    JOIN appname_directory appn ON ad.id_appname = appn.id
    JOIN project_directory pj ON agp.id_project_directory = pj.id
    LEFT JOIN person_in_charge pic ON agp.id_person_in_charge = pic.id
    LEFT JOIN security_champion sc ON agp.id_security_champion = sc.id
    LEFT JOIN env_directory env ON agp.id_env_directory = env.id
    LEFT JOIN country_directory ct ON agp.id_country_directory = ct.id
    LEFT JOIN label_directory lbl ON agp.id_label_directory = lbl.id
    LEFT JOIN app_type_directory apt ON agp.id_app_type_directory = apt.id
    LEFT JOIN pipeline_properties_directory pp ON agp.id_pipeline_properties_directory = pp.id
    LEFT JOIN runtime_directory rt ON agp.id_runtime_directory = rt.id
    JOIN database_properties_directory db ON agp.id_database_properties_directory = db.id
    WHERE agp.id_app_directory = p_id_app_directory;
END;
$$ LANGUAGE plpgsql;


-- =============================================================================================

CREATE OR REPLACE FUNCTION get_datastage_app_properties(p_id_app_directory INT)
RETURNS TABLE (
    app_general_id INT,
    app_name TEXT,
    repo_name TEXT,
    repo_url TEXT,
    project_name TEXT,
    project_acronym TEXT,
    person_in_charge TEXT,
    person_email TEXT,
    security_champion TEXT,
    security_email TEXT,
    env TEXT,
    country TEXT,
    app_label TEXT,
    app_type TEXT,
    pipeline_securitygate BOOLEAN,
    pipeline_unittests BOOLEAN,
    pipeline_sonarqube BOOLEAN,
    pipeline_qualitygate BOOLEAN,
    runtime_name TEXT,
    runtime_version TEXT,
    sonarqubepath_exec TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        agp.id,
        appn.app,
        ad.repo_name,
        ad.repo_url,
        pj.project_name,
        pj.project_acronym,
        pic.nombre,
        pic.email,
        sc.nombre,
        sc.email,
        env.env,
        ct.country,
        lbl.app_label,
        apt.app_type,
        pp.securitygate,
        pp.unittests,
        pp.sonarqube,
        pp.qualitygate,
        rt.runtime_name,
        rt.version_path,
        agp.sonarqubepath_exec
    FROM app_general_properties agp
    JOIN app_directory ad ON agp.id_app_directory = ad.id
    JOIN appname_directory appn ON ad.id_appname = appn.id
    JOIN project_directory pj ON agp.id_project_directory = pj.id
    LEFT JOIN person_in_charge pic ON agp.id_person_in_charge = pic.id
    LEFT JOIN security_champion sc ON agp.id_security_champion = sc.id
    LEFT JOIN env_directory env ON agp.id_env_directory = env.id
    LEFT JOIN country_directory ct ON agp.id_country_directory = ct.id
    LEFT JOIN label_directory lbl ON agp.id_label_directory = lbl.id
    LEFT JOIN app_type_directory apt ON agp.id_app_type_directory = apt.id
    LEFT JOIN pipeline_properties_directory pp ON agp.id_pipeline_properties_directory = pp.id
    LEFT JOIN runtime_directory rt ON agp.id_runtime_directory = rt.id
    JOIN datastage_properties_directory ds ON agp.id_datastage_properties_directory = ds.id
    WHERE agp.id_app_directory = p_id_app_directory;
END;
$$ LANGUAGE plpgsql;
