export type AmplifyDependentResourcesAttributes = {
    "auth": {
        "mystudentapp61fa3dde": {
            "IdentityPoolId": "string",
            "IdentityPoolName": "string",
            "UserPoolId": "string",
            "UserPoolArn": "string",
            "UserPoolName": "string",
            "AppClientIDWeb": "string",
            "AppClientID": "string",
            "CreatedSNSRole": "string"
        },
        "userPoolGroups": {
            "usersGroupRole": "string"
        }
    },
    "api": {
        "mystudentapp": {
            "GraphQLAPIIdOutput": "string",
            "GraphQLAPIEndpointOutput": "string"
        }
    },
    "storage": {
        "s3Avatars": {
            "BucketName": "string",
            "Region": "string"
        }
    }
}