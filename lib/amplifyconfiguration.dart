const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "mystudentapp": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://vx5sok32afhafbmf2lhsk576de.appsync-api.eu-central-1.amazonaws.com/graphql",
                    "region": "eu-central-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-t4skk35kqraxzfykxal4lhxdge"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "eu-central-1:97c844a3-a1b3-4907-81f2-092b4ba13bee",
                            "Region": "eu-central-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "eu-central-1_q7MgHB7o3",
                        "AppClientId": "slgi6a9btvhqoc38h9ea0o03p",
                        "Region": "eu-central-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "socialProviders": [],
                        "usernameAttributes": [],
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://vx5sok32afhafbmf2lhsk576de.appsync-api.eu-central-1.amazonaws.com/graphql",
                        "Region": "eu-central-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-t4skk35kqraxzfykxal4lhxdge",
                        "ClientDatabasePrefix": "mystudentapp_API_KEY"
                    },
                    "mystudentapp_AWS_IAM": {
                        "ApiUrl": "https://vx5sok32afhafbmf2lhsk576de.appsync-api.eu-central-1.amazonaws.com/graphql",
                        "Region": "eu-central-1",
                        "AuthMode": "AWS_IAM",
                        "ClientDatabasePrefix": "mystudentapp_AWS_IAM"
                    },
                    "mystudentapp_AMAZON_COGNITO_USER_POOLS": {
                        "ApiUrl": "https://vx5sok32afhafbmf2lhsk576de.appsync-api.eu-central-1.amazonaws.com/graphql",
                        "Region": "eu-central-1",
                        "AuthMode": "AMAZON_COGNITO_USER_POOLS",
                        "ClientDatabasePrefix": "mystudentapp_AMAZON_COGNITO_USER_POOLS"
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "mystudentapp-storage-d6g3v57wcp7av204127-dev",
                        "Region": "eu-central-1"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "mystudentapp-storage-d6g3v57wcp7av204127-dev",
                "region": "eu-central-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';