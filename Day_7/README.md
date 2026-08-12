# Part 10 – LWC Component Communication, Forms and Reusable Architecture

## Overview

Part 10 focuses on building the Student Placement Portal using multiple Lightning Web Components that work together as one application.

The main concepts covered in this part are parent-child communication, Custom Events, `@api` properties, form handling, validation, reactive data, reusable components, loading and error states, and connecting LWC components with Apex.

---

## Objectives

The main objectives of this part are:

- Understand parent-to-child communication in LWC.
- Understand child-to-parent communication using Custom Events.
- Use `@api` properties to pass data between components.
- Build a Student Profile form.
- Validate Student information.
- Retrieve and update Student information using Apex.
- Display eligible jobs based on Student CGPA.
- Create reusable Job Card components.
- Handle loading, success, error and empty states.
- Refresh dependent information when Student data changes.
- Design components with clear responsibilities.

---

## Component Architecture

The Student Placement Portal is divided into focused components.

```text
StudentPortal
│
├── StudentProfile
│
└── EligibleJobs
    │
    └── JobCard
