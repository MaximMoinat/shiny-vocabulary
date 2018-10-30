SELECT
    concept.vocabulary_id,
    concept.domain_id,
    concept.concept_class_id,
    concept.standard_concept,
    concept.invalid_reason,
    COUNT(*) AS concept_count
FROM
    @cdmSchema.concept
GROUP BY
    concept.vocabulary_id,
    concept.domain_id,
    concept.concept_class_id,
    concept.standard_concept,
    concept.invalid_reason
;