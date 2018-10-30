SELECT
	concept_relationship.relationship_id,
	concept_1.vocabulary_id AS from_vocabulary_id,
	concept_1.domain_id AS from_domain_id,
	concept_1.standard_concept AS from_standard_concept,
	concept_2.vocabulary_id AS to_vocabulary_id,
	concept_2.domain_id AS to_domain_id,
	concept_2.standard_concept TO to_standard_concept,
    COUNT(*) AS relationship_count
FROM
    @cdmSchema.concept_relationship
RIGHT JOIN @cdmSchema.concept AS concept_1
    ON concept_1.concept_id = concept_id_1
JOIN @cdmSchema.concept AS concept_2
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
	
	