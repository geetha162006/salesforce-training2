# Day 9 – Lightning Web Components and Application Workflow

## Overview

This task focuses on building a Lightning Web Component that displays eligible job opportunities for students and allows them to apply for a selected job.

The implementation uses Lightning Web Components for the user interface and Apex for server-side processing. It also demonstrates communication between parent and child components using custom events and the use of imperative Apex for application submission.

## Objectives

- Build a parent Lightning Web Component to display eligible jobs.
- Create a reusable child component for displaying individual job details.
- Implement communication between child and parent components using custom events.
- Use Apex to retrieve eligible jobs.
- Use imperative Apex to submit a job application.
- Apply CGPA-based eligibility rules.
- Validate the application deadline.
- Prevent duplicate applications.
- Display success and error messages to the user.

## Salesforce Objects

### Student

The Student object contains:

- Student Name
- CGPA
- User

The student's CGPA is used to determine whether the student is eligible for a particular job.

### Job

The Job object contains:

- Job Name
- Minimum CGPA
- Deadline

A student's CGPA is compared with the minimum CGPA required for the job.

### Application

The Application object is used to store the student's job application.

It maintains the relationship between the student and the selected job along with the application status.

## Apex Classes

### ApplicationController

`ApplicationController.cls` acts as the controller layer between the Lightning Web Component and the service layer.

It provides methods for:

- Retrieving eligible jobs.
- Submitting an application.

### ApplicationService

`ApplicationService.cls` contains the main business logic.

It is responsible for:

- Finding the student associated with the current Salesforce user.
- Retrieving available jobs.
- Checking the student's CGPA.
- Checking the job deadline.
- Checking for duplicate applications.
- Creating a new Application record.

Separating the business logic into a service class makes the code easier to maintain.

## Lightning Web Components

### eligibleJobs

`eligibleJobs` is the parent component.

It is responsible for:

- Loading eligible jobs from Apex.
- Displaying the jobs.
- Handling the Apply event from the child component.
- Calling Apex imperatively when the user applies.
- Displaying loading, success, and error messages.

### jobCard

`jobCard` is the child component.

It is responsible for displaying information about an individual job and providing the Apply button.

When the user clicks Apply, the component sends a custom event to the parent `eligibleJobs` component.

## Application Flow

```text
Student
   ↓
Eligible Jobs
   ↓
Job Card
   ↓
Apply Button
   ↓
Custom Event
   ↓
eligibleJobs
   ↓
Imperative Apex
   ↓
ApplicationController
   ↓
ApplicationService
   ↓
Eligibility and Deadline Validation
   ↓
Create Application Record
   ↓
Success / Error Message
