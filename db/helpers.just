image := "mishpocha-db"
config := "edgedb-config"
edgedb_instance := replace(image, "-", "_")
edgedb_command := "edgedb --instance " + edgedb_instance
connect_to_edgedb := just + " _create;" + edgedb_command
