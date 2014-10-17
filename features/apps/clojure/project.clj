(defproject buildstep-clojure "0.0.1"
  :description "Buildstep validation Clojure web app"
  :url "http://clojure.dokku.me"
  :license {:name "Eclipse Public License v1.0"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.6.0"]
                 [compojure "1.1.8"]
                 [ring/ring-jetty-adapter "1.2.2"]
                 [environ "0.5.0"]]
  :min-lein-version "2.0.0"
  :plugins [[environ/environ.lein "0.2.1"]]
  :hooks [environ.leiningen.hooks]
  :uberjar-name "buildstep-clojure-standalone.jar"
  :profiles {:production {:env {:production true}}})
