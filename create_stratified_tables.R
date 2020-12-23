library(DatabaseConnector)
library(SqlRender)

connectionDetails <- createConnectionDetails(dbms = "postgresql",
                                             user = "postgres",
                                             password = "postgres",
                                             server = "localhost/ohdsi",
                                             port = 5432)
vocabSchema <- 'vocab2'

connection <- connect(connectionDetails)

# Concepts
# sql <- SqlRender::loadRenderTranslateSql('stratify_concepts.sql', dbms = connectionDetails$dbms, vocabSchema = vocabSchema)
rawSql <- readSql('stratify_concepts.sql')
renderedSql <- renderSql(rawSql, vocabSchema = vocabSchema)$sql
df <- querySql(connection, renderedSql)
write.csv(df, file = 'stratified_concepts.csv', row.names = FALSE)

# Relationships
rawSql <- readSql('stratify_relationships.sql')
renderedSql <- renderSql(rawSql, vocabSchema = vocabSchema)$sql
df <- querySql(connection, renderedSql)
write.csv(df, file = 'stratified_relationships.csv', row.names = FALSE)

#versions
versionSql <- renderSql("SELECT vocabulary_version FROM @vocabSchema.vocabulary WHERE vocabulary_id = 'None'", 
                      vocabSchema = vocabSchema)$sql
vocabVersion <- querySql(connection, versionSql)

DatabaseConnector::disconnect(connection)
