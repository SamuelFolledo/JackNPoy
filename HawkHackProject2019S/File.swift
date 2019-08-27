////
////  File.swift
////  HawkHackProject2019S
////
////  Created by Samuel Folledo on 4/30/19.
////  Copyright © 2019 Samuel Folledo. All rights reserved.
////
//
//import Foundation
//
//What is AWS Amplify?
//The amplify framework provides a set of libraries and UI components and a CLI to build mobile backends and integrate with your iOS, Android, web, and react natives apps
//
//What does CLI do?
//CLI =  creates and configures AWS services based on categories, allowing you to configure the services needed to power your backend through a simple command line
//
//Great platforms needs to be secured and scalability
//
//In cognito, there are 2 roles (Auth, and unAuth), unAuth will get a defaut access to certain things like analytics. if they log in, they can then get access to more
//
//Codegen = automatically generate code for GraphQL quereies, mutations, subscriptions, and typed schemas
//
//Amazon Cognito
// - Craete & configure new Amazon Cognito resources for user signup and signin
// - interact with amazon Cognito using Auth class from client Library
// - Pre-configured components available for React, Reach Native, Angular, and Ionic
//
//Amazon Pinpoint
// - Create and configure new amazon pinpoint resoirces
// - record events from the client application
// - automatically records session data
// - automatically records auth data (sign ups, sign ins, and auth failures)
//
//REST API
//AWS Lambda + Amazon API Gateway
//
//GraphQL API
//AWS AppSync
//
//Database API
//Amazon DynamoDB + AWS Lamba + Amazon API Gateway
// - create and configure table
// - create Lambda function
// - Configure API Gateway
// - scaffolds lambda code to act as REST API
// - interact with Lambda Function using client library
//
//AWS Lambda
// - Create and configure Lambda functions
// - push changes
// - invoke functions locally
// - interact with lambda function from using client library
// = this basically store data or update data etc. when needed. Running a function base on the request
//
//Amazon S3
// - Create and configure S3 bucket for hosting
// - configure amazon Cloudfront
// - pubslishes assets to SIMD3
// - push updates when necessary directly from CLI
// = great simple solution for websites on GoDaddy, or github repo
//
//To install CLI
// - npm install -g @aws-amplify/cli
// - unified toolchain to create, integrate, and manage AWS cloud services for your app
//
//
//


//It has been a long time, but I got stuck at "correct" way of persistent storing my game's dictionary values with key: game.gameId using UserDefaults
//- Now all I have to do is update wherever I have the UserDefaults to a much "better" way of coding (either through CoreData or Firebase Persistent Storage). Leaning towards Firebase just to "master" Firebase in iOS

//Upcoming features:
//- if a user wants to fight the other user, will work on the ability to send notifications from one user's device to another device after persistent storage using Firebase
