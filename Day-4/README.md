# Sprint 7 – Building Software That Survives Scale

## Bulk Processing and Governor Limits

## Introduction

Sprint 7 introduced one of the most important concepts in Salesforce development—writing Apex code that can handle large volumes of data efficiently. Until the previous sprint, the main focus was on making the code work correctly. In this sprint, the focus shifted towards writing scalable, optimized, and bulk-safe code that follows Salesforce best practices.

The sprint was divided into two parts. The first part explained the concepts behind Governor Limits and Bulkification, while the second part demonstrated how to apply those concepts in Apex Triggers using collections, Trigger context variables, and proper Trigger architecture.

---

# Part I – Understanding Bulk Processing and Governor Limits

## Why Bulk Processing Matters

Salesforce processes records in batches rather than one record at a time. A Trigger may receive one record during manual testing, but it can also receive up to 200 records in a single transaction during imports, data loads, or integrations.

If Apex code is written only for a single record, it may work during testing but fail in real-world scenarios. This sprint explained why developers should always design their code assuming that multiple records will be processed together.

---

## Governor Limits

Salesforce is a multi-tenant platform where many organizations share the same resources. To ensure fair resource usage, Salesforce enforces Governor Limits.

Some important limits discussed during this sprint include:

* Maximum SOQL queries per transaction
* Maximum DML statements
* CPU execution time
* Heap size
* Number of records processed

Instead of memorizing every limit, the sprint emphasized understanding how inefficient code reaches these limits and how proper design helps avoid them.

---

## Understanding Bulkification

Bulkification is the process of designing Apex code that can efficiently process multiple records within a single transaction.

Instead of writing logic that works only for one record, developers should build solutions that perform equally well for:

* 1 record
* 10 records
* 50 records
* 200 records

Bulkification improves application performance and prevents Governor Limit exceptions.

---

## SOQL Inside Loops

One of the biggest mistakes highlighted during this sprint is writing SOQL queries inside loops.

### Incorrect Approach

* Process one record
* Execute one SOQL query
* Repeat for every record

This increases the number of database queries and may exceed Salesforce Governor Limits.

### Correct Approach

* Collect all required record IDs first
* Execute a single SOQL query
* Store the results in a Map
* Process all records using the retrieved data

This approach significantly reduces database operations and improves performance.

---

## DML Inside Loops

Another common mistake is performing DML operations inside loops.

### Incorrect Approach

Updating each record individually results in multiple database operations.

### Correct Approach

* Store all modified records in a List.
* Perform one bulk update after processing all records.

This reduces resource consumption and follows Salesforce best practices.

---

## Thinking in Collections

One of the biggest mindset changes introduced in this sprint is moving from record-based thinking to collection-based thinking.

Instead of asking:

> Which record am I processing?

Developers should ask:

> Which collection of records am I processing?

This change is the foundation of bulk-safe Apex development.

---

## Using Apex Collections

The sprint explained how different collection types solve different problems.

### List

Used to store multiple records that need to be processed or updated together.

Example use:

* Store applications that require validation.
* Store records for bulk update.

---

### Set

Stores only unique values.

Example use:

* Collect unique Student IDs.
* Remove duplicate IDs before querying Salesforce.

---

### Map

Stores data in key-value format.

Example use:

* Retrieve Student records using Student ID.
* Avoid repeated database queries.
* Improve lookup performance during processing.

---

## Seven-Step Bulk Processing Pattern

The sprint introduced a standard design pattern followed by Salesforce developers.

1. Receive all records.
2. Collect required IDs.
3. Execute SOQL queries outside loops.
4. Store retrieved records in Maps.
5. Process records in memory.
6. Collect records for update.
7. Perform one bulk DML operation.

Following this pattern helps build scalable and efficient applications.

---

# Part II – Designing Bulk-Safe Apex and Triggers

The second part focused on implementing the concepts learned in Part I through Apex Triggers and Trigger architecture.

---

## Trigger.new

One important lesson from this sprint is understanding that `Trigger.new` is always a collection of records.

Even if only one record is inserted, Salesforce still provides a List.

Developers should always assume that multiple records can be received and write code accordingly.

---

## Trigger.old

`Trigger.old` contains the previous version of records before an update.

It is mainly used to compare old and new values and determine whether an important business event has actually occurred.

Example:

* Previous Status → Interview Scheduled
* Current Status → Selected

By comparing these values, automation runs only when the status changes instead of every time the record is edited.

---

## Trigger.newMap and Trigger.oldMap

The sprint also introduced Trigger Maps.

These Maps store records using their IDs as keys.

Benefits include:

* Fast record lookup
* Easy comparison between old and new records
* Better performance than repeatedly searching through Lists

---

## Building a Bulk-Safe Trigger

The sprint demonstrated how to design a Trigger using the following approach:

* Receive all application records.
* Collect Student IDs using a Set.
* Execute one SOQL query.
* Store Student records in a Map.
* Process all applications using the Map.
* Avoid SOQL inside loops.

This architecture ensures that the Trigger performs efficiently even when hundreds of records are processed.

---

## Querying Multiple Related Objects

The eligibility validation example required information from both Student and Job objects.

Instead of executing separate queries for every Application record, the solution followed these steps:

* Collect Student IDs.
* Collect Job IDs.
* Query Students once.
* Query Jobs once.
* Store both results in Maps.
* Perform validation using the Maps.

This approach minimizes database operations and improves scalability.

---

## Bulk-Safe DML Operations

After processing records, updates should not be performed immediately.

Instead:

* Collect modified records into a List.
* Execute a single update statement.

This reduces DML usage and keeps the application within Governor Limits.

---

## Before Trigger Best Practice

The sprint explained an important concept about Before Triggers.

Since Salesforce automatically saves changes made to records inside a Before Trigger, developers should modify `Trigger.new` records directly instead of calling an additional update statement.

Avoiding unnecessary DML improves performance and prevents resource wastage.

---

## Trigger Handler Architecture

As business requirements grow, placing all logic inside the Trigger makes the code difficult to understand and maintain.

The recommended architecture is:

Trigger

↓

Trigger Handler

↓

Service Class

↓

Business Logic

This separation improves readability, maintainability, testing, and code reuse.

---

## Detecting Business Events

Instead of checking only the current field value, developers should compare previous and current values.

For example:

Pending → Selected

Only when this transition occurs should the application:

* Update Student status.
* Save selected company information.
* Trigger notifications.

This prevents duplicate processing and unnecessary automation.

---

## Professional Code Review

The sprint also explained how experienced Salesforce developers review code.

During code review, developers should check for:

* SOQL inside loops
* DML inside loops
* Repeated database queries
* Poor Trigger architecture
* Scalability issues
* Maintainability
* Efficient use of Lists, Sets, and Maps

Rather than simply fixing errors, the goal is to redesign the solution using Salesforce best practices.

---

# Key Learning Outcomes

After completing Sprint 7, I gained a better understanding of:

* Salesforce Governor Limits and why they exist.
* Bulkification and scalable Apex development.
* Efficient use of Lists, Sets, and Maps.
* Trigger context variables (`Trigger.new`, `Trigger.old`, `Trigger.newMap`, and `Trigger.oldMap`).
* Writing bulk-safe SOQL and DML operations.
* Designing clean Trigger architecture using Handler classes.
* Reviewing and improving Apex code from both performance and maintainability perspectives.

---

# Conclusion

Sprint 7 completely changed my approach to writing Apex code. Instead of focusing only on making the code work, I learned how to design applications that continue to perform efficiently when processing large numbers of records. Understanding Bulkification, Governor Limits, Trigger context variables, and proper Trigger architecture has given me a strong foundation for building scalable Salesforce applications and preparing for real-world development projects.
