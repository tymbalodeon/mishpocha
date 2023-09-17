image := "mishpocha-db"
config := "edgedb-config"
edgedb_instance := replace(image, "-db", "")
edgedb_command := "edgedb --instance " + edgedb_instance
edgedb_cloud_command := "edgedb --instance " + "${EDGEDB_CLOUD_INSTANCE}"
connect_to_edgedb := just + " _create;" + edgedb_command
connect_to_edgedb_cloud := just + " _create;" + edgedb_cloud_command
