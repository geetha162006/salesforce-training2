# Sprint 8 – Asynchronous Apex: Future, Queueable, Batch & Scheduled Apex

## Objective

The objective of this sprint was to understand how Salesforce performs background processing using Asynchronous Apex. I learned the difference between synchronous and asynchronous processing and explored different asynchronous mechanisms such as Future Methods, Queueable Apex, Batch Apex, and Scheduled Apex. I also implemented Queueable, Batch, and Scheduled Apex classes to understand how background processing works in Salesforce.

---

# Part I – Theory

## Topics Covered

### Synchronous Processing
Synchronous processing executes all operations in a single transaction. The user waits until every operation is completed before receiving a response. This approach is suitable for tasks like validation, record creation, and immediate business logic.

### Asynchronous Processing
Asynchronous processing allows Salesforce to perform only the essential work immediately while moving secondary tasks to the background. This improves system performance and provides a better user experience.

### Future Methods
Future Methods execute code asynchronously and are mainly used for simple background operations. They are commonly found in legacy Salesforce applications and are useful for basic asynchronous processing.

### Queueable Apex
Queueable Apex provides a structured approach for background processing. It supports job chaining, allows passing data through constructors, and is easier to maintain compared to Future Methods.

### Batch Apex
Batch Apex is designed for processing large numbers of records. Salesforce divides the records into smaller batches, and each batch executes as a separate transaction.

A Batch Apex class contains three important methods:

- start()
- execute()
- finish()

### Scheduled Apex
Scheduled Apex allows Apex classes to execute automatically at a specified date and time using a CRON expression. It is commonly used for recurring business operations.

### Additional Concepts Learned

- Transaction Boundary
- Queueable Chaining
- Legacy Future Methods
- Idempotency
- Batch Size Selection
- Scheduled Apex with Batch Apex
- Monitoring Apex Jobs
- Governor Limits in Asynchronous Apex

---

# Part II – Practical Implementation

## Task 1 – Queueable Apex

Created a Queueable Apex class named **OfferPostProcessingJob**.

Executed the Queueable job using:

```apex
System.enqueueJob(new OfferPostProcessingJob());
```

Verified successful execution using **Setup → Apex Jobs**.

---

## Task 2 – Queueable Chaining

Created two Queueable classes:

- ExternalPlacementSyncJob
- PlacementNotificationJob

Configured the first Queueable job to enqueue the second Queueable job after successful completion, demonstrating Queueable Chaining.

---

## Task 3 – Batch Apex

Created a Batch Apex class named **PlacementCategoryBatch**.

Implemented the following methods:

- start()
- execute()
- finish()

Executed the batch using:

```apex
Database.executeBatch(new PlacementCategoryBatch(), 200);
```

Verified the batch execution using **Setup → Apex Jobs**.

---

## Task 4 – Scheduled Apex

Created a Scheduled Apex class named **ExpiredJobScheduler**.

Scheduled the job using:

```apex
System.schedule('Morning Batch Job', cronExpression, new ExpiredJobScheduler());
```

Verified the scheduled job using **Setup → Scheduled Jobs**.

---

## Task 5 – Scheduled + Batch

Updated the Scheduled Apex class to automatically execute the Batch Apex class.

```apex
Database.executeBatch(new PlacementCategoryBatch(), 200);
```

This demonstrated how Scheduled Apex and Batch Apex work together for automated large-scale processing.

---

# Screenshots Included

- Queueable Apex Class
- Queueable Apex Execution
- Queueable Apex Jobs
- Queueable Chaining Classes
- Queueable Chaining Apex Jobs
- Batch Apex Class
- Batch Apex Execution
- Batch Apex Jobs
- Scheduled Apex Class
- Schedule Execution
- Scheduled Jobs
- Scheduled + Batch Implementation

---

# What I Learned

Through this sprint, I gained a practical understanding of asynchronous processing in Salesforce.

I learned:

- The difference between synchronous and asynchronous processing.
- When to use Future Methods, Queueable Apex, Batch Apex, and Scheduled Apex.
- Why Queueable Apex is preferred for new asynchronous development.
- How Queueable Chaining improves application design.
- How Batch Apex processes large datasets efficiently.
- How Scheduled Apex automates recurring business operations.
- How Scheduled Apex and Batch Apex work together.
- The importance of Governor Limits in asynchronous processing.
- How to monitor background jobs using Apex Jobs and Scheduled Jobs.

---

# Conclusion

Sprint 8 provided hands-on experience with Salesforce Asynchronous Apex. I implemented Queueable Apex, Queueable Chaining, Batch Apex, Scheduled Apex, and Scheduled + Batch processing while understanding when and why each asynchronous mechanism should be used. This sprint improved my understanding of designing scalable and efficient Salesforce applications using background processing.
