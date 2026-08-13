@IsTest
static void testCandidateSyncFailure() {

    Student__c student = new Student__c(
        Name = 'Failure Student',
        Email__c = 'failure@example.com',
        Branch__c = 'CSE',
        CGPA__c = 7
    );

    insert student;

    Job__c job = new Job__c(
        Name = 'Developer',
        Company__c = 'Test Company',
        Role__c = 'Salesforce Developer'
    );

    insert job;

    Application__c application = new Application__c(
        Student__c = student.Id,
        Job__c = job.Id,
        Status__c = 'Selected',
        Integration_Status__c = 'Pending'
    );

    insert application;

    Test.setMock(
        HttpCalloutMock.class,
        new CandidateSyncFailureMock()
    );

    Test.startTest();

    System.enqueueJob(
        new CandidateSyncQueueable(application.Id)
    );

    Test.stopTest();

    Application__c result = [
        SELECT Integration_Status__c,
               Integration_Error__c
        FROM Application__c
        WHERE Id = :application.Id
    ];

    System.assertEquals(
        'Retry Required',
        result.Integration_Status__c
    );

    System.assert(
        result.Integration_Error__c.contains(
            'External Server Error'
        )
    );
}
