Feature: EPUB 3 — Layout Rendering Control


  Checks conformance to the "Layout rendering control" section of the EPUB 3.3 specification:
    https://www.w3.org/TR/epub-33/#sec-rendering-control


  Background: 
    Given EPUB test files located at '/epub3/08-layout/files/'
    And EPUBCheck with default settings

  ##  8.2 Fixed layouts

  Scenario: Verify a fixed-layout SVG
    When checking EPUB 'content-fxl-svg-valid'
    Then no errors or warnings are reported

  ###  8.2.2 Fixed-layout package settings

  ### 4.3.4 Fixed-Layout Properties

  Scenario: the 'rendition:layout' property can be used to define the global layout preference
    When checking file 'rendition-layout-global-valid.opf'
    Then no errors or warnings are reported

  Scenario: a 'rendition:layout' property with no value is reported
    See also issue #727
    When checking file 'rendition-layout-global-empty-error.opf'
    Then the following errors are reported (one for the empty element, one for the consequently unexpected value)
      | RSC-005 | character content of element "meta" invalid          |
      | RSC-005 | The value of the "rendition:layout" property must be |
    And no other errors or warnings are reported

  Scenario: a 'rendition:layout' property with an unknown value is reported
    When checking file 'rendition-layout-global-unknown-value-error.opf'
    Then error RSC-005 is reported
    And the message contains 'The value of the "rendition:layout" property must be'
    And no other errors or warnings are reported

  Scenario: the 'rendition:layout' property cannot be declared more than once
    When checking file 'rendition-layout-global-duplicate-error.opf'
    Then error RSC-005 is reported
    And the message contains 'The "rendition:layout" property must not occur more than one time'
    And no other errors or warnings are reported

  Scenario: the 'rendition:layout' property cannot be used in a 'meta' element to refine a publication resource
    When checking file 'rendition-layout-global-refines-error.opf'
    Then error RSC-005 is reported
    And the message contains "refines"
    And no other errors or warnings are reported

  Scenario: the 'rendition:layout' property can be used as a spine override
    When checking file 'rendition-layout-itemref-valid.opf'
    Then no errors or warnings are reported

  Scenario: the 'rendition:layout' spine overrides values are mutually exclusive
    When checking file 'rendition-layout-itemref-conflict-error.opf'
    Then error RSC-005 is reported
    And the message contains "are mutually exclusive"
    And no other errors or warnings are reported

  Scenario: the 'rendition:page-spread-*' properties can be used without the prefix
    When checking file 'rendition-page-spread-itemref-unprefixed-valid.opf'
    Then no errors or warnings are reported

  Scenario: the 'rendition:page-spread-*' properties values are mutually exclusive
    When checking file 'rendition-page-spread-itemref-conflict-error.opf'
    Then error RSC-005 is reported
    And the message contains "are mutually exclusive"
    And no other errors or warnings are reported

  Scenario: the 'rendition:orientation' property can be used to define the global orientation preference
    When checking file 'rendition-orientation-global-valid.opf'
    Then no errors or warnings are reported

  Scenario: a 'rendition:orientation' property with an unknown value is reported
    When checking file 'rendition-orientation-global-unknown-value-error.opf'
    Then error RSC-005 is reported
    And the message contains 'The value of the "rendition:orientation" property must be'
    And no other errors or warnings are reported

  Scenario: the 'rendition:orientation' property cannot be declared more than once
    When checking file 'rendition-orientation-global-duplicate-error.opf'
    Then error RSC-005 is reported
    And the message contains 'The "rendition:orientation" property must not occur more than one time'
    And no other errors or warnings are reported

  Scenario: the 'rendition:orientation' property cannot be used in a 'meta' element to refine a publication resource
    When checking file 'rendition-orientation-global-refines-error.opf'
    Then error RSC-005 is reported
    And the message contains "refines"
    And no other errors or warnings are reported

  Scenario: the 'rendition:orientation' property can be used as a spine override
    When checking file 'rendition-orientation-itemref-valid.opf'
    Then no errors or warnings are reported

  Scenario: the 'rendition:orientation' spine overrides values are mutually exclusive
    When checking file 'rendition-orientation-itemref-conflict-error.opf'
    Then error RSC-005 is reported
    And the message contains "are mutually exclusive"
    And no other errors or warnings are reported

  Scenario: the 'rendition:spread' property can be used to define the global spread preference
    When checking file 'rendition-spread-global-valid.opf'
    Then no errors or warnings are reported

  Scenario: a 'rendition:spread' property with an unknown value is reported
    When checking file 'rendition-spread-global-unknown-value-error.opf'
    Then error RSC-005 is reported
    And the message contains 'The value of the "rendition:spread" property must be'
    And no other errors or warnings are reported

  Scenario: the 'rendition:spread' property cannot be declared more than once
    When checking file 'rendition-spread-global-duplicate-error.opf'
    Then error RSC-005 is reported
    And the message contains 'The "rendition:spread" property must not occur more than one time'
    And no other errors or warnings are reported

  Scenario: the 'rendition:spread' property cannot be used in a 'meta' element to refine a publication resource
    When checking file 'rendition-spread-global-refines-error.opf'
    Then error RSC-005 is reported
    And the message contains "refines"
    And no other errors or warnings are reported

  Scenario: the 'rendition:spread' property can be used as a spine override
    When checking file 'rendition-spread-itemref-valid.opf'
    Then no errors or warnings are reported

  Scenario: the 'rendition:spread' spine overrides values are mutually exclusive
    When checking file 'rendition-spread-itemref-conflict-error.opf'
    Then error RSC-005 is reported
    And the message contains "are mutually exclusive"
    And no other errors or warnings are reported

  Scenario: the 'rendition:spread' 'portrait' value is deprecated as a global value
    When checking file 'rendition-spread-portrait-global-deprecated-warning.opf'
    Then warning RSC-017 is reported
    And the message contains "is deprecated"
    And no other errors or warnings are reported

  Scenario: the 'rendition:spread' 'spread-portrait' value is deprecated as a spine override
    When checking file 'rendition-spread-portrait-itemref-deprecated-warning.opf'
    Then warning RSC-017 is reported
    And the message contains "is deprecated"
    And no other errors or warnings are reported

  Scenario: the 'rendition:viewport' property is deprecated
    When checking file 'rendition-viewport-deprecated-warning.opf'
    Then warning RSC-017 is reported
    And the message contains "is deprecated"
    And no other errors or warnings are reported

  Scenario: the 'rendition:viewport' property syntax errors are reported
    When checking file 'rendition-viewport-syntax-error.opf'
    Then warning RSC-017 is reported (since 'viewport' is deprecated)
    And error RSC-005 is reported
    And the message contains 'The value of the "rendition:viewport" property must be of the form'
    And no other errors or warnings are reported

  Scenario: the 'rendition:viewport' property cannot be declared more than once
    When checking file 'rendition-viewport-duplicate-error.opf'
    Then warning RSC-017 is reported 2 times (since 'viewport' is deprecated)
    And error RSC-005 is reported
    And the message contains 'The "rendition:viewport" property must not occur more than one time as a global value'
    And no other errors or warnings are reported
  
  ####  8.2.2.6 Content document dimensions

  Scenario: Report a fixed-layout XHTML document with no viewport
    When checking EPUB 'content-fxl-xhtml-viewport-missing-error'
    Then error HTM-046 is reported
    And no other errors or warnings are reported

  Scenario: Report a fixed-layout XHTML document with an invalid viewport
    When checking EPUB 'content-fxl-xhtml-viewport-invalid-error'
    Then error HTM-047 is reported
    And no other errors or warnings are reported
    
  Scenario: Verify that the initial containing block rules are not checked on embedded svg elements
    When checking EPUB 'content-fxl-svg-no-viewbox-on-inner-svg-valid'
    Then no errors or warnings are reported

  Scenario: Report a fixed-layout SVG without a `viewbox` declaration
    When checking EPUB 'content-fxl-svg-no-viewbox-error'
    Then error HTM-048 is reported
    And no other errors or warnings are reported

  Scenario: Report a fixed-layout SVG without a `viewbox` declaration (only `width`/`height` in units)
    When checking EPUB 'content-fxl-svg-no-viewbox-width-height-units-error'
    Then error HTM-048 is reported
    And no other errors or warnings are reported

  Scenario: Report a fixed-layout SVG without a `viewbox` declaration (only `width`/`height` in percent)
    When checking EPUB 'content-fxl-svg-no-viewbox-width-height-percent-error'
    Then error HTM-048 is reported
    And no other errors or warnings are reported


  ## 8.3 Reflowable layouts
  
  Scenario: the 'rendition:flow' property can be used to define the global flow preference
    When checking file 'rendition-flow-global-valid.opf'
    Then no errors or warnings are reported

  Scenario: a 'rendition:flow' property with an unknown value is reported
    When checking file 'rendition-flow-global-unknown-value-error.opf'
    Then error RSC-005 is reported
    And the message contains 'The value of the "rendition:flow" property must be'
    And no other errors or warnings are reported

  Scenario: the 'rendition:flow' property cannot be declared more than once
    When checking file 'rendition-flow-global-duplicate-error.opf'
    Then error RSC-005 is reported
    And the message contains 'The "rendition:flow" property must not occur more than one time'
    And no other errors or warnings are reported

  Scenario: the 'rendition:flow' property cannot be used in a 'meta' element to refine a publication resource
    When checking file 'rendition-flow-global-refines-error.opf'
    Then error RSC-005 is reported
    And the message contains "refines"
    And no other errors or warnings are reported

  Scenario: the 'rendition:flow' property can be used as a spine override
    When checking file 'rendition-flow-itemref-valid.opf'
    Then no errors or warnings are reported

  Scenario: the 'rendition:flow' spine overrides values are mutually exclusive
    When checking file 'rendition-flow-itemref-conflict-error.opf'
    Then error RSC-005 is reported
    And the message contains "are mutually exclusive"
    And no other errors or warnings are reported
