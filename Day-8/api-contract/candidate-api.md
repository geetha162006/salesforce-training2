# Candidate API Contract

## Endpoint

POST /candidates

## Purpose

Send selected student candidate information
from Salesforce to the external recruitment system.

## Request Method

POST

## Content Type

application/json

## Request JSON

{
    "applicationId": "a01ABC123",
    "studentId": "STU1001",
    "name": "Rahul",
    "email": "rahul@gmail.com",
    "branch": "CSE",
    "cgpa": 8.5,
    "jobId": "JOB1001",
    "company": "ABC Technologies",
    "role": "Salesforce Developer",
    "selectionDate": "2026-08-13"
}

## Success Response

{
    "success": true,
    "externalCandidateId": "EXT10001"
}

## Error Responses

400 - Bad Request
401 - Authentication Failure
403 - Forbidden
500 - Server Error

## Authentication

The Salesforce integration uses a Named Credential.
Credentials and authentication details are not hard-coded
inside Apex.

## Retry Strategy

If the external system temporarily fails, the Application
can be marked as Retry Required.

## Idempotency Strategy

The Salesforce Application Id is used as the unique
reference for a candidate submission.

If the same Application is retried, the same Application Id
is sent again. The external system can use this identifier
to prevent duplicate candidate creation.
