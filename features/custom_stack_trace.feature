Feature: Custom stack trace

  Scenario: Error.prepareStackTrace override
    Given a file named "features/a.feature" with:
      """
      Feature: Some feature
        Scenario: Some scenario
          Given Error.prepareStackTrace has been overriden
      """
    Given a file named "features/step_definitions/cucumber_steps.js" with:
      """
      import {defineSupportCode} from 'cucumber'

      defineSupportCode(({When}) => {
        const _prepareStackTrace = Error.prepareStackTrace;
        Error.prepareStackTrace = () => { return 'Custom message' }

        When(/^Error.prepareStackTrace has been overriden$/, function() {})

        Error.prepareStackTrace = _prepareStackTrace
      })
      """
    When I run cucumber.js
    Then it outputs this text:
      """
      Feature: Some feature

        Scenario: Some scenario
        ✔ Given Error.prepareStackTrace has been overriden

      1 scenario (1 passed)
      1 step (1 passed)
      <duration-stat>
      """
    And the exit status should be 0
