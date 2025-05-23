CREATE OR REPLACE FUNCTION get_microservice_app_properties(p_id_app_directory INT)
RETURNS TABLE (
    app_general_id INT,
    app_name TEXT,
    repo_name TEXT,
    repo_url TEXT,
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
    image_name TEXT,
    sonarqubepath_exec TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        agp.id,
        appn.app,
        ad.repo_name,
        ad.repo_url,
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
        img.image_name,
        agp.sonarqubepath_exec
    FROM app_general_properties agp
    JOIN app_directory ad ON agp.id_app_directory = ad.id
    JOIN appname_directory appn ON ad.id_appname = appn.id
    JOIN microservice_properties_directory msd ON agp.id_microservice_directory = msd.id
    LEFT JOIN token_directory tok ON msd.id_token_directory = tok.id
    LEFT JOIN openshift_properties_directory op ON msd.id_openshift_properties_directory = op.id
    LEFT JOIN path_directory pd ON msd.id_path_directory = pd.id
    LEFT JOIN image_directory img ON msd.id_image_directory = img.id
    WHERE agp.id_app_directory = p_id_app_directory;
END;
$$ LANGUAGE plpgsql;
