SELECT
	concept_relationship.relationship_id,
	concept_1.vocabulary_id AS from_vocabulary_id,
	concept_1.domain_id AS from_domain_id,
    concept_1.concept_class_id AS from_concept_class_id,
	concept_1.standard_concept AS from_standard_concept,
	concept_2.vocabulary_id AS to_vocabulary_id,
	concept_2.domain_id AS to_domain_id,
    concept_2.concept_class_id AS to_concept_class_id,
	concept_2.standard_concept AS to_standard_concept,
    COUNT(*) AS relationship_count
FROM
    @vocabSchema.concept_relationship
JOIN @vocabSchema.concept AS concept_1
    ON concept_1.concept_id = concept_id_1
JOIN @vocabSchema.concept AS concept_2
    ON concept_2.concept_id = concept_id_2
WHERE concept_relationship.invalid_reason IS NULL AND concept_id_1 != concept_id_2
GROUP BY 
	concept_relationship.relationship_id,
	concept_1.vocabulary_id,
	concept_1.domain_id,
	concept_1.standard_concept,
	concept_2.vocabulary_id,
	concept_2.domain_id,
	concept_2.standard_concept
	
	