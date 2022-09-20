Feature: EPUB 3 — Vocabularies — Meta properties vocabulary


  Checks conformance to the "Meta properties vocabulary" section of the EPUB 3.3 specification:
    https://www.w3.org/TR/epub-33/#app-meta-property-vocab


  Background: 
    Given EPUB test files located at '/epub3/D-vocabularies/files/'
    And EPUBCheck with default settings

  # D.3 Meta properties vocabulary

  Scenario: 'authority' metadata can refine a subject expression
  	When checking file 'metadata-meta-authority-valid.opf'
  	Then no errors or warnings are reported

  Scenario: 'authority' metadata can only refine a subject expression
  	When checking file 'metadata-meta-authority-refines-disallowed-error.opf'
  	Then error RSC-005 is reported
    And the message contains 'Property "authority" must refine a "subject" property'
  	Then no errors or warnings are reported

  Scenario: 'authority' metadata must be associated to a term
  	When checking file 'metadata-meta-authority-no-term-error.opf'
  	Then error RSC-005 is reported
  	And the message contains "A term property must be associated"
  	And no other errors or warnings are reported

  Scenario: 'authority' metadata must not be defined more than once
  	When checking file 'metadata-meta-authority-cardinality-error.opf'
  	Then error RSC-005 is reported
  	And the message contains "Only one pair of authority and term properties"
  	And no other errors or warnings are reported

  Scenario: 'belongs-to-collection' metadata can identify the publicationâ€™s collection
    When checking file 'metadata-meta-collection-valid.opf'
    Then no errors or warnings are reported

  Scenario: 'belongs-to-collection' metadata can only refine other 'belongs-to-collection' metadata
    When checking file 'metadata-meta-collection-refines-non-collection-error.opf'
    Then error RSC-005 is reported
    And the message contains 'Property "belongs-to-collection" can only refine other "belongs-to-collection" properties'
    And no other errors or warnings are reported

  Scenario: 'collection-type' cannot be used as a primary metadata
    When checking file 'metadata-meta-collection-type-refines-missing-error.opf'
    Then error RSC-005 is reported
    And the message contains 'Property "collection-type" must refine a "belongs-to-collection" property'
    And no other errors or warnings are reported

  Scenario: 'collection-type' metadata can only refine a 'belongs-to-collection' property
    When checking file 'metadata-meta-collection-type-refines-non-collection-error.opf'
    Then error RSC-005 is reported
    And the message contains 'Property "collection-type" must refine a "belongs-to-collection" property'
    And no other errors or warnings are reported

  Scenario: 'collection-type' metadata cannot be defined more than once to refine the same expression 
    When checking file 'metadata-meta-collection-type-cardinality-error.opf'
    Then error RSC-005 is reported
    And the message contains '"collection-type" cannot be declared more than once'
    And no other errors or warnings are reported
  
  Scenario: 'display-seq' metadata is allowed 
    When checking file 'metadata-meta-display-seq-valid.opf'
    Then no errors or warnings are reported

  Scenario: 'display-seq' metadata cannot be defined more than once to refine the same expression 
    When checking file 'metadata-meta-display-seq-cardinality-error.opf'
    Then error RSC-005 is reported
    And the message contains '"display-seq" cannot be declared more than once'
    And no other errors or warnings are reported
  
  Scenario: 'file-as' metadata is allowed 
    When checking file 'metadata-meta-file-as-valid.opf'
    Then no errors or warnings are reported

  Scenario: 'file-as' metadata cannot be defined more than once to refine the same expression 
    When checking file 'metadata-meta-file-as-cardinality-error.opf'
    Then error RSC-005 is reported
    And the message contains '"file-as" cannot be declared more than once'
    And no other errors or warnings are reported

  Scenario: 'group-position' metadata is allowed 
    When checking file 'metadata-meta-group-position-valid.opf'
    Then no errors or warnings are reported

  Scenario: 'group-position' metadata cannot be defined more than once to refine the same expression 
    When checking file 'metadata-meta-group-position-cardinality-error.opf'
    Then error RSC-005 is reported
    And the message contains '"group-position" cannot be declared more than once'
    And no other errors or warnings are reported

	Scenario: 'identifier-type' metadata can only refine a 'source' or 'identifier' property
    When checking file 'metadata-meta-identifier-type-refines-disallowed-error.opf'
    Then error RSC-005 is reported
    And the message contains 'Property "identifier-type" must refine an "identifier" or "source" property'
    And no other errors or warnings are reported
    
  Scenario: 'identifier-type' metadata cannot be defined more than once to refine the same expression 
    When checking file 'metadata-meta-identifier-type-cardinality-error.opf'
    Then error RSC-005 is reported
    And the message contains '"identifier-type" cannot be declared more than once'
    And no other errors or warnings are reported
    
  Scenario: 'meta-auth' metadata is deprecated 
    When checking file 'metadata-meta-meta-auth-deprecated-warning.opf'
    Then warning RSC-017 is reported
    And the message contains "the meta-auth property is deprecated"
    And no other errors or warnings are reported

  Scenario: 'role' metadata can be used once or more to refine a creator, contributor, or publisher 
    When checking file 'metadata-meta-role-valid.opf'
    Then no errors or warnings are reported

  Scenario: 'role' metadata cannot be used to refine properties other than creator, contributor, or publisher  
    When checking file 'metadata-meta-role-refines-disallowed-error.opf'
    Then error RSC-005 is reported
    And the message contains '"role" must refine a "creator", "contributor", or "publisher" property'
    And no other errors or warnings are reported
  
  Scenario: 'source-of' metadata can be used to refine the pagination source 
    When checking file 'metadata-meta-source-of-valid.opf'
    Then no errors or warnings are reported
    
  Scenario: 'source-of' metadata value must be "pagination" 
    When checking file 'metadata-meta-source-of-value-unknown-error.opf'
    Then error RSC-005 is reported
    And the message contains 'The "source-of" property must have the value "pagination"'
    And no other errors or warnings are reported
  
  Scenario: 'source-of' metadata cannot be used as a primary metadata 
    When checking file 'metadata-meta-source-of-refines-missing-error.opf'
    Then error RSC-005 is reported
    And the message contains 'The "source-of" property must refine a "source" property'
    And no other errors or warnings are reported
  
  Scenario: 'source-of' metadata must refine a 'dc:source' metadata entry
    When checking file 'metadata-meta-source-of-refines-not-dcsource-error.opf'
    Then error RSC-005 is reported
    And the message contains 'The "source-of" property must refine a "source" property'
    And no other errors or warnings are reported

  Scenario: 'source-of' metadata cannot be defined more than once to refine the same expression 
    When checking file 'metadata-meta-source-of-cardinality-error.opf'
    Then error RSC-005 is reported
    And the message contains '"source-of" cannot be declared more than once'
    And no other errors or warnings are reported

  Scenario: 'term' metadata can refine a subject expression
  	When checking file 'metadata-meta-term-valid.opf'
  	Then no errors or warnings are reported

  Scenario: 'term' metadata can only refine a subject expression
  	When checking file 'metadata-meta-term-refines-disallowed-error.opf'
  	Then error RSC-005 is reported
    And the message contains 'Property "term" must refine a "subject" property'
  	Then no errors or warnings are reported

  Scenario: 'term' metadata must be associated to an authority
  	When checking file 'metadata-meta-term-no-authority-error.opf'
  	Then error RSC-005 is reported
  	And the message contains "An authority property must be associated"
  	And no other errors or warnings are reported

  Scenario: 'term' metadata must not be defined more than once
  	When checking file 'metadata-meta-term-cardinality-error.opf'
  	Then error RSC-005 is reported
  	And the message contains "Only one pair of authority and term properties"
  	And no other errors or warnings are reported

  Scenario: 'title-type' metadata can be used to refine a title expression 
    When checking file 'metadata-meta-title-type-valid.opf'
    Then no errors or warnings are reported

	Scenario: 'title-type' metadata can only refine a 'title' expression
    When checking file 'metadata-meta-title-type-refines-disallowed-error.opf'
    Then error RSC-005 is reported
    And the message contains 'Property "title-type" must refine a "title" property'
    And no other errors or warnings are reported

  Scenario: 'title-type' metadata cannot be defined more than once to refine the same expression 
    When checking file 'metadata-meta-title-type-cardinality-error.opf'
    Then error RSC-005 is reported
    And the message contains '"title-type" cannot be declared more than once'
    And no other errors or warnings are reported
