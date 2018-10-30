library(DatabaseConnector)
library(SqlRender)

connectionDetails <- createConnectionDetails(dbms = "postgresql",
                                             user = "postgres",
                                             password = "postgres",
                                             server = "localhost/abucasis_dev",
                                             port = 6000,
                                             schema = "cdm5")

connection <- connect(connectionDetails)

# Concepts
rawSql <- readSql('stratify_concepts.sql')
renderedSql <- renderSql(rawSql, cdmSchema = connectionDetails$schema)$sql
df <- querySql(connection, renderedSql)
write.csv(df, file = 'stratified_concepts.csv', row.names = FALSE)

# Relationships
rawSql <- readSql('stratify_relationships.sql')
renderedSql <- renderSql(rawSql, cdmSchema = connectionDetails$schema)$sql
df <- querySql(connection, renderedSql)
write.csv(df, file = 'stratified_relationships.csv', row.names = FALSE)

versionSql <- renderSql("SELECT vocabulary_version FROM @cdmSchema.vocabulary WHERE vocabulary_id = 'None'", 
                      cdmSchema = connectionDetails$schema)$sql
vocabVersion <- querySql(connection, versionSql)


