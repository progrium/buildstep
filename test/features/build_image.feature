Feature: build docker application containers

  In order to build application containers
  As a developer using Dokku
  I want to use the buildstep image

  Background:
    Given the default aruba timeout is 600 seconds

  Scenario: build a Ruby app
    When I deploy a "ruby" application
    Then a "ruby" application image should exist

  Scenario: build a Node.js app
    When I deploy a "nodejs" application
    Then a "nodejs" application image should exist

  Scenario: build a Clojure app
    When I deploy a "clojure" application
    Then a "clojure" application image should exist

  Scenario: build a Python app
    When I deploy a "python" application
    Then a "python" application image should exist

  Scenario: build a Java app
    When I deploy a "java" application
    Then a "java" application image should exist

  Scenario: build a Gradle app
    When I deploy a "gradle" application
    Then a "gradle" application image should exist

  Scenario: build a Grails app
    When I deploy a "grails" application
    Then a "grails" application image should exist

  Scenario: build a Scala app
    When I deploy a "scala" application
    Then a "scala" application image should exist

  Scenario: build a Play app
    When I deploy a "play" application
    Then a "play" application image should exist

  Scenario: build a PHP app
    When I deploy a "php" application
    Then a "php" application image should exist

  Scenario: build a Go app
    When I deploy a "go" application
    Then a "go" application image should exist
