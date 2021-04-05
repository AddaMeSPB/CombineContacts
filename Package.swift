// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CombineContacts",
  platforms: [
    .iOS(.v14),
    .macOS(.v10_15)
  ],
  products: [
    .library(
      name: "CombineContacts",
      targets: ["CombineContacts"]),
  ],
  dependencies: [
    .package(url: "https://github.com/CombineCommunity/CombineExt.git", from: "1.0.0")
  ],
  targets: [
    .target(
      name: "CombineContacts",
      dependencies: ["CombineExt"]),
    .testTarget(
      name: "CombineContactsTests",
      dependencies: ["CombineContacts"]),
  ]
)
