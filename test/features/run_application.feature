Feature: run docker application containers

  Background:
    Given the default aruba timeout is 300 seconds

  Scenario: run a Ruby app
    Given a "ruby" application image exists
    When I start the "ruby" application
    Then it should successfully respond to web requests
    And shutdown cleanly

  Scenario: run a Node.js app
    Given a "nodejs" application image exists
    When I start the "nodejs" application
    Then it should successfully respond to web requests
    And shutdown cleanly

  Scenario: run a Clojure app
    Given a "clojure" application image exists
    When I start the "clojure" application
    Then it should successfully respond to web requests
    And shutdown cleanly

  Scenario: run a Python app
    Given a "python" application image exists
    When I start the "python" application
    Then it should successfully respond to web requests
    And shutdown cleanly

  Scenario: run a Java app
    Given a "java" application image exists
    When I start the "java" application
    Then it should successfully respond to web requests
    And shutdown cleanly

  Scenario: run a Gradle app
    Given a "gradle" application image exists
    When I start the "gradle" application
    Then it should successfully respond to web requests
    And shutdown cleanly

  Scenario: run a Grails app
    Given a "grails" application image exists
    When I start the "grails" application
    Then it should successfully respond to web requests
    And shutdown cleanly

  Scenario: run a Scala app
    Given a "scala" application image exists
    When I start the "scala" application
    Then it should successfully respond to web requests
    And shutdown cleanly

  Scenario: run a Play app
    Given a "play" application image exists
    When I start the "play" application
    Then it should successfully respond to web requests
    And shutdown cleanly

  Scenario: run a PHP app
    Given a "php" application image exists
    When I start the "php" application
    Then it should successfully respond to web requests
    And shutdown cleanly

  Scenario: run a Go app
    Given a "go" application image exists
    When I start the "go" application
    Then it should successfully respond to web requests
    And shutdown cleanly
