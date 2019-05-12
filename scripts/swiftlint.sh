#!/bin/sh

swiftlint lint --strict --quiet --path Banking --config ../swiftlint.yml
swiftlint lint --strict --quiet --path MBKModel/Models --config ../../swiftlint.yml
swiftlint lint --strict --quiet --path MBKModelTests --config ../swiftlint.yml
swiftlint lint --strict --quiet --path MBK_Siri_Intent --config ../swiftlint.yml
swiftlint lint --strict --quiet --path MBK_Siri_IntentUI --config ../swiftlint.yml
swiftlint lint --strict --quiet --path MBKSiriTests --config ../swiftlint.yml
swiftlint lint --strict --quiet --path MBK\ Integration\ Tests --config ../swiftlint.yml
swiftlint lint --strict --quiet --path MBK\ Unit\ Tests --config ../swiftlint.yml
swiftlint lint --strict --quiet --path MBKService --config ../swiftlint.yml
swiftlint lint --strict --quiet --path MBKServiceTests --config ../swiftlint.yml
swiftlint lint --strict --quiet --path MBKAppKit --config ../swiftlint.yml
swiftlint lint --strict --quiet --path MBKAppKitTests --config ../swiftlint.yml
