# Sprint 11 – Salesforce Integration

## Overview

This project is part of my Salesforce Sprint 11 training. The main focus of this sprint is learning how Salesforce communicates with external systems using APIs and REST integrations.

In this project, I implemented an external recruitment integration where selected candidates from Salesforce are sent to an external recruitment system using Queueable Apex, HTTP Callouts, and Named Credentials.

---

## Business Problem

When a student is selected for a job, the candidate information needs to be shared with an external recruitment system.

Instead of manually sending the candidate details, Salesforce can automatically send the information when the Application status changes to **Selected**.

The candidate information includes:

- Student Id
- Name
- Email
- Branch
- CGPA
- Job Id
- Company
- Role
- Selection Date

---

## Integration Flow

The overall integration flow is:

```text
Application Status = Selected
          ↓
Application Trigger
          ↓
CandidateSyncQueueable
          ↓
Named Credential
          ↓
HTTP POST Request
          ↓
External Recruitment API
          ↓
Process Response
          ↓
Update Integration Status
