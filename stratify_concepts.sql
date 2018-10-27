-- some concepts are counted twice. TODO: remove the join on relationship, OR ensure every concept counted once and only once.
SELECT
    concept.vocabulary_id,
    concept.domain_id,
    concept.concept_class_id,
    concept.standard_concept,
    concept.invalid_reason,
    concept_relationship.relationship_id,
    COUNT( DISTINCT concept_id ) AS concept_count,
    COUNT(*) AS total_count
FROM
    @cdmSchema.concept
LEFT JOIN @cdmSchema.concept_relationship 
    ON concept_id = concept_id_1
    AND concept_id_1 != concept_id_2
    AND relationship_id IN ('Mapped from','Maps to')
    AND concept_relationship.invalid_reason IS NULL
GROUP BY
    concept.vocabulary_id,
    concept.domain_id,
    concept.concept_class_id,
    concept.standard_concept,
    concept.invalid_reason,
    concept_relationship.relationship_id
;